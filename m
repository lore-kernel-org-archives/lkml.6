Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE29CC28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CD920831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXJzw3xL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CD920831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeKUCBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:01:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33013 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeKUCBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:01:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id u9-v6so2450764wrr.0;
        Tue, 20 Nov 2018 07:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8fmPV76fUFYlvWzkSd9ouZCSa7SztME68FYrhU194LE=;
        b=IXJzw3xLLWyVnUtDavYmq4ueWIIDNwpQVqDVQRHWJDX8krueN5967CsQNU6wwhl1Gf
         REr57XEQft75kULzObQaIe/IP0n8FG8Yrx5STN8PaEEf4JslVOv3horc74oGBMnjQoVO
         oXU9sk+4XbOWmymGojymE2Fykw/DWUfR0x4XxXSAH90/wpnTgn5lqn7hJ9XryhIQvvyo
         p1zFTq4fgqHneQE8beZsHu84JNI7ZvrYkDDXpJnjWwPM1jFtXmTxnsOGFbaUoMDfdg/2
         arP5ksDOHh5/QfmV0TMeX3/sRxW1YvdlDLTRjfvIUnjHGtKnXRPwCAkB+FWSQAEHPM4u
         AZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8fmPV76fUFYlvWzkSd9ouZCSa7SztME68FYrhU194LE=;
        b=ueBK8tyqhwyefj1JjhF2WBz7S01IadXbWFFp6YKem9WxpkSPs5g4do0v7jqbN+Zu7x
         O7eBB8ZH+/7+Rx6WLBfC+VMN4L9zPrA8LqdeqofhnUoO5iDWxC5jqw81ez7Pojy3uaBj
         Jd5pemrwzxg0zcmZh33syZfjFGaZP2ph525bw/bKefWXlvKAeNU4JBkWeW/lNwlxz+0j
         LtoAes5nKcqYkWssE6jdizgAQxRUYaoOTGUxyCwwsOig6t1ywTZI838bBBfDlXxPZ8fM
         UHJ4+4Hd1Kl+sgN/z+N2ctYGvhPQPzzXCkPEx7GG/3+Kmhrac9WkzWU6Yqarfzq5Ty8S
         BBww==
X-Gm-Message-State: AA+aEWYv9wKS3H46yIUMIGHFxWdR0/MTWnHSCq+l6HeLVjlBndU1wJh5
        ZnjChmx2QtNUdww0xnOJoHE=
X-Google-Smtp-Source: AFSGD/WMLG6KAHHgL1FysKho90BOk4HLXjvq2F+HQTOlX01e9cTW3rx8GhZQAVYCo7pekKzdROGkJw==
X-Received: by 2002:adf:c5c2:: with SMTP id v2-v6mr2381171wrg.30.1542727920127;
        Tue, 20 Nov 2018 07:32:00 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id k73sm14677464wmd.36.2018.11.20.07.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 07:31:59 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, radhey.shyam.pandey@xilinx.com,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v6 2/7] dmaengine: xilinx_dma: in axidma slave_sg and dma_cyclic mode align split descriptors
Date:   Tue, 20 Nov 2018 16:31:46 +0100
Message-Id: <20181120153151.18024-2-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120153151.18024-1-andrea.merello@gmail.com>
References: <20181120153151.18024-1-andrea.merello@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever a single or cyclic transaction is prepared, the driver
could eventually split it over several SG descriptors in order
to deal with the HW maximum transfer length.

This could end up in DMA operations starting from a misaligned
address. This seems fatal for the HW if DRE (Data Realignment Engine)
is not enabled.

This patch eventually adjusts the transfer size in order to make sure
all operations start from an aligned address.

Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes in v2:
        - don't introduce copy_mask field, rather rely on already-esistent
          copy_align field. Suggested by Radhey Shyam Pandey
        - reword title
Changes in v3:
	- fix bug introduced in v2: wrong copy size when DRE is enabled
	- use implementation suggested by Radhey Shyam Pandey
Changes in v4:
	- rework on the top of 1/6
Changes in v5:
	- fix typo in commit title
	- add hint about "DRE" meaning in commit message
Changes in v6:
	None
---
 drivers/dma/xilinx/xilinx_dma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 2c1db500284f..cbf34dd5e966 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -975,6 +975,15 @@ static int xilinx_dma_calc_copysize(struct xilinx_dma_chan *chan,
 	copy = min_t(size_t, size - done,
 		     chan->xdev->max_buffer_len);
 
+	if ((copy + done < size) &&
+	    chan->xdev->common.copy_align) {
+		/*
+		 * If this is not the last descriptor, make sure
+		 * the next one will be properly aligned
+		 */
+		copy = rounddown(copy,
+				 (1 << chan->xdev->common.copy_align));
+	}
 	return copy;
 }
 
-- 
2.17.1

