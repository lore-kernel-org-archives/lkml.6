Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A8BECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2738E214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uEeIJQBR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2738E214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbeIRAEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 20:04:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35697 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIRAEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 20:04:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id x20-v6so861333lfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 11:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cAyH04cOm+pKbv2NZgH5xq64BqFREsSsIBvZUgrVdx0=;
        b=uEeIJQBRyRMS2UV5dvwzPXDlyMTHEfBfH4uS/myBQz/9zF/3nyUdyDeN+/OyjgOC0v
         tLcBbsJK1C//u1ceXp6m8e3xAzlv11TSUpokIIVW6u+VI9XKKTZGGQZwSVatChUt7Nd1
         i4wyKxXzAu6iKPIhUpruaIDZO5hpZGhd9Ry8iUWgMtVELFxK9eLwf2Qtp6dZzD2v0rO8
         po8geoPF5RMY6Bjk0QfKstpph5XKud+SpYHEFE+SlbUhlbdxoPVhqKLrtrJHg0SNE9Nv
         oGCcaCuTynxlQS87oaKaKPSN1H59CNMOlptf1BcTfH4VVe7255hx4lHZN9JLGfAg3OPj
         iiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cAyH04cOm+pKbv2NZgH5xq64BqFREsSsIBvZUgrVdx0=;
        b=XOk0M+SbdCgMbI/ahqkP3jpmsaa8vNvwC28BdYWBVJAvIMqxhCgScVtbTaItSFD0Rm
         hUQgudIkVXjSni8+jolTx1V0SVKPaQTxMcaJhZ81NNUhFvvSgjXk2KWSvegu/1t50c9Q
         wuvLgEj7mOIQSM1lPxd4L9NAXdwuIGFypboBKHum0qiIZ/gatvg0mI8v4fY6DHLFDPUg
         invuyXtXXOQ0C9FgBI9sCtjnS/8fuIELHvtVuzZ+Ta7DUgKcmMbCmMD8mDbM1neUDn9c
         2UlbHpujdptisqI7/j8/SvV/bjNISDGRjJLnighfi5Nqf9xSbLjtlc9EIJAUhenAxAOu
         UH6g==
X-Gm-Message-State: APzg51A/iFTxsiSO1hJpcz6fwIFH6Psn2AmSjBdo9/d9gaMmVuvvlj9i
        30yKmE2ERIkfWO2G/WttpW12O3gdtIY=
X-Google-Smtp-Source: ANB0VdYybK0duyv3Kki6jF9+AB6xnoygM3jDZpklaciqWpAWFo4fn0jDHs+v3HQxDX+uVPL2PgrDDQ==
X-Received: by 2002:a19:9601:: with SMTP id y1-v6mr17250334lfd.91.1537209361718;
        Mon, 17 Sep 2018 11:36:01 -0700 (PDT)
Received: from localhost.localdomain ([85.232.252.14])
        by smtp.gmail.com with ESMTPSA id h9-v6sm3006334lfc.47.2018.09.17.11.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 11:36:01 -0700 (PDT)
From:   Jakub Lewalski <jakub.lewalski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org, Jakub Lewalski <jakub.lewalski@gmail.com>
Subject: [PATCH] spi/pl022.h fix name of struct in documentation
Date:   Mon, 17 Sep 2018 20:35:43 +0200
Message-Id: <20180917183543.27848-1-jakub.lewalski@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix name of struct in documentation. Previous one was incorrect.

Signed-off-by: Jakub Lewalski <jakub.lewalski@gmail.com>
---
 include/linux/amba/pl022.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/amba/pl022.h b/include/linux/amba/pl022.h
index 854b7294f6c6..28be2db03550 100644
--- a/include/linux/amba/pl022.h
+++ b/include/linux/amba/pl022.h
@@ -230,7 +230,9 @@ enum ssp_chip_select {
 
 struct dma_chan;
 /**
- * struct pl022_ssp_master - device.platform_data for SPI controller devices.
+ * struct pl022_ssp_controller - device.platform_data for SPI
+ * controller devices.
+ *
  * @bus_id: identifier for this bus
  * @num_chipselect: chipselects are used to distinguish individual
  *     SPI slaves, and are numbered from zero to num_chipselects - 1.
-- 
2.19.0

