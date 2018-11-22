Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F364C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D863420684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSVCsPt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D863420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437138AbeKWAc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:32:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56253 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437075AbeKWAcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:32:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so8988023wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 05:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MdZkXSLR8ObfNFtvurg2p+jPHB2wbvp6R/xvSpDRpSQ=;
        b=TSVCsPt6IMNTDb2AtyTl1/gxeMn7WJwYnZdQB4sTrtQrm4Y+YnZ2Ifrkj1RCCYFR+i
         xlr3yVkm9/t2Ch7yOKGN+eL+soADMZ76GFWasSsG5ZSGrYVMm+dgIMM5tFhoPV4phyDx
         Tycc3tpi211qFEGScZawq2ZKTn48wl6LHmZkNFEaVMCUt2TZQOSbcKlmIMLlM7SUrTiD
         p9IXn9ZVSuNYBYKVM5xKWlFpgOuMqTkqhHgELWhaI6c+W6i02MrmwEi6emFzQpDmqUMZ
         5tOchZegpmXaZQXD2VseOW4cYy63H+XK/xj+acIA4wMrp+QcZGKtHd6gpN9SFPtJuj7x
         Oqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MdZkXSLR8ObfNFtvurg2p+jPHB2wbvp6R/xvSpDRpSQ=;
        b=NK6RCKeENIsuu7K2pp3EbDtloYK+7xiQbGAsTNxeMLbstl01Ic9PsScUaHzPmKSYja
         IlgmIlrkvhYftf24PiCU9dr+1k32B56NgNSNk3bqmBX6USOB1rUJNkfUMumCNMGO7qaW
         z20TsBgesW/lzavNUsT6jk6TaUangjGbCkA9s54zB8aMX1T+A4S5kstZN0y0n35bkdXX
         AzXCkVjWrI1dnZq8lDbevE6nSyNl6rYvkPwSL2wAWjWzDqanDTQyJRQOj0i6o5IiBPAO
         UqfqpsOUp8JyY/sdbBwuGYv55dkddZIDgz/Iqq+xMtyggmdNumcm6mpVhKyvVok8kSAV
         GNEw==
X-Gm-Message-State: AGRZ1gIQiwva0GlksGt66Nhog/P2jAd9eO8gp41euS+VSqzqKHsnTj2D
        ER9Y+8ZiI2wgPF6qOCG0EnE=
X-Google-Smtp-Source: AJdET5dd/zfBUPNs4bbiNVda6KFK+yROef3bcKKdpaYpHLsCALqDTltO+VIWNSJ+GDII7NpZS8t7Fw==
X-Received: by 2002:a7b:c110:: with SMTP id w16mr9704100wmi.71.1542894756454;
        Thu, 22 Nov 2018 05:52:36 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id c188-v6sm2393285wma.39.2018.11.22.05.52.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:52:35 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/8] staging: rtl8188eu: remove unnecessary parentheses
Date:   Thu, 22 Nov 2018 14:52:15 +0100
Message-Id: <20181122135218.1703-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122135218.1703-1-straube.linux@gmail.com>
References: <20181122135218.1703-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses in usb_ops_linux.c.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
index 75b7d8c2cc50..73d2d312e8ab 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
@@ -25,7 +25,8 @@ static void interrupt_handler_8188eu(struct adapter *adapt, u16 pkt_len, u8 *pbu
 
 	/*  C2H Event */
 	if (pbuf[0] != 0)
-		memcpy(&(haldata->C2hArray[0]), &(pbuf[USB_INTR_CONTENT_C2H_OFFSET]), 16);
+		memcpy(&haldata->C2hArray[0],
+		       &pbuf[USB_INTR_CONTENT_C2H_OFFSET], 16);
 }
 
 static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
-- 
2.19.1

