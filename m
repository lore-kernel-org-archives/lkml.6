Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEC5C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C467214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U76fk2SY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C467214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbeHVOVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:21:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36205 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbeHVOVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:21:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id u7-v6so1107932lji.3;
        Wed, 22 Aug 2018 03:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/L25b047FiRn0Jxuo20wJHHkY4rJl7eQk/zssltT4t0=;
        b=U76fk2SYOZMsUNIov+erEOVciVodAhRjn0MI8GLPO8vGxkp3hI2Gw1d8kGOUmrXCm+
         ZqqtITboPWKyU9Ze4MRIHDNrZl9MiprGhAxcyHLtOOZcnoDkc26l4AIzEp/6d5gi//xA
         /mWXvVVe7XOry/b3SXILIfyz5DK0nx0rE2YMccZUEjhGFODDF/qn2uGZuhtomD6u7ZEq
         TDIhuw5NZqh2G8Txw+H41XScOn7yNnFc+fsS9F+j2URlnUlIIioN9IyftrKRcFHJhC89
         2OLkvDgF0VPHPJdbs6hHDtLZT/KvZ37p56exnVc3m0BDzv8F3JDNvAkBLoeu1nMsX1o/
         B9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=/L25b047FiRn0Jxuo20wJHHkY4rJl7eQk/zssltT4t0=;
        b=PaSbUZv73fCSd2d5RW4cQ09m6vfGGISv9vgzB1Xv8OFUl2MQYKrwcyweqKC2v0cKMH
         JdZsB27KAoXSy7yR5tIrlEN0l5QsYFkJGrzqlIozk2u5cXMJTJkKM//PPK7iK1DZv3tc
         mL2AjYnmoOUFYiIrO11alNu6dQGTKUmw0fygAUtFNjrSWG2aty42DROL7rJ73xsAXU9n
         +DJjoCSBsIvEp7oZ987Dc8jRXD9vfGgL1ua9L9RZdRKWO8+7p1b6LMKiU3R4OmcrpxTj
         3PSesYafuzGCFM79TBaLIFPY0Wt2YwpKLaizpyeHKVECsbWFyS2cDqJk4/ojDKlj/43Y
         XwJA==
X-Gm-Message-State: AOUpUlEPK9q6GaiDC0P7tl9CcT0eKlpyMl7LF6pcOIxNR5+XgtZM80kq
        zLKNv8ALkZ1zp64ptx9fThQ=
X-Google-Smtp-Source: ANB0VdasfGFc5GdL3CaRHD/Xenw1gD2JlBviM9JAIMVbAC/DHxVDVykmbyOaTNMb5fIe/vgP/4Ax9A==
X-Received: by 2002:a2e:4089:: with SMTP id r9-v6mr5541524lje.2.1534935443273;
        Wed, 22 Aug 2018 03:57:23 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id h90-v6sm237973lji.66.2018.08.22.03.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 03:57:18 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fsQpD-0002Xo-8Z; Wed, 22 Aug 2018 12:57:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Vincent Cuissard <cuissard@marvell.com>,
        Samuel Ortiz <sameo@linux.intel.com>
Subject: [PATCH 8/9] NFC: nfcmrvl_uart: fix OF child-node lookup
Date:   Wed, 22 Aug 2018 12:55:46 +0200
Message-Id: <20180822105547.9634-9-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180822105547.9634-1-johan@kernel.org>
References: <20180822105547.9634-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new of_get_compatible_child() helper to lookup the nfc child
node instead of using of_find_compatible_node(), which searches the
entire tree and thus can return an unrelated (i.e. non-child) node.

This also addresses a potential use-after-free (e.g. after probe
deferral) as the tree-wide helper drops a reference to its first
argument (i.e. the parent node).

Fixes: e097dc624f78 ("NFC: nfcmrvl: add UART driver")
Fixes: d8e018c0b321 ("NFC: nfcmrvl: update device tree bindings for Marvell NFC")
Cc: stable <stable@vger.kernel.org>     # 4.2
Cc: Vincent Cuissard <cuissard@marvell.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/nfc/nfcmrvl/uart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
index 91162f8e0366..9a22056e8d9e 100644
--- a/drivers/nfc/nfcmrvl/uart.c
+++ b/drivers/nfc/nfcmrvl/uart.c
@@ -73,10 +73,9 @@ static int nfcmrvl_uart_parse_dt(struct device_node *node,
 	struct device_node *matched_node;
 	int ret;
 
-	matched_node = of_find_compatible_node(node, NULL, "marvell,nfc-uart");
+	matched_node = of_get_compatible_child(node, "marvell,nfc-uart");
 	if (!matched_node) {
-		matched_node = of_find_compatible_node(node, NULL,
-						       "mrvl,nfc-uart");
+		matched_node = of_get_compatible_child(node, "mrvl,nfc-uart");
 		if (!matched_node)
 			return -ENODEV;
 	}
-- 
2.18.0

