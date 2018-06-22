Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96D0C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8815A23F88
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAgKLwL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8815A23F88
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754190AbeFVJoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:44:06 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36177 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbeFVJoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:44:04 -0400
Received: by mail-wr0-f193.google.com with SMTP id f16-v6so6059727wrm.3;
        Fri, 22 Jun 2018 02:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rRZYKkBnukFeUbvmXo6GNjDeV1VIxGMvd61S1K1RgFA=;
        b=IAgKLwL6tzVd6jkBe/sCxdNDdhpfvWsGR+YHaEbz4ku1JeoiciZLZxNnRmfsITdoLu
         9WLNPYp+6MZ1FdtZoAmHuqJhRIUmKseMzptWuMcIcNciEPUXYJ5OxDtf60wiGRzuEcjL
         t1Kf0MWZrFtTO7CXdO9lffEphlHcZBgyzlwjDJgQz6h68oYloTFX/FFlv7pe1h3MPwT4
         e3NXIB+nIq1qpapxb8Cnky5w2XYMw0PsXlVehGE4izvbWLfuGi6PPMkR1YpocEhike+r
         7AcRyRDc4Azmxx/Y5FXu2Z8v5Zn+tPN4VrK+QURCz70mAPXydURREPtC9ENk5l4ZMsYk
         T2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rRZYKkBnukFeUbvmXo6GNjDeV1VIxGMvd61S1K1RgFA=;
        b=OrGxtdvkbrzhd8eWbJ5Tddi6eCZQFauakLDtZFI3vhHG2viSiSMBPg/QejRsWM/aae
         ef0BNjzhX0K7YY6/pypzc8VGN5Yt3PAIorHZJn4qvL0/RsRvVRZTXSo0O9SXztuAyy2R
         BYFVvUDZxFNLH0HPkhDFzfnIp7O6nB2GHn4p1iYKoJiH47Q4Tw5/Lp1+gS8BfcMGKfHG
         bgY+4HteLr8iP8Y/ywS54i8Gjclgmg8K54+U202mzVlGax0lUdyiP2WHZ9y/3BoyPq3G
         fld1o/fyLQ1CxlCmP/azm7w5SizOrrzy4pRN/9RBD6ZhNtvNLGkz/oH/s9jMKjmtR6vs
         nnUQ==
X-Gm-Message-State: APt69E11AJWRTVAiY+BPi8vATOAwgwNaDwoyf9JncKpGUYaseOMjZNMD
        6J1BqGcHWlJXEpDrXlVUw1I=
X-Google-Smtp-Source: AAOMgpe8njMnO5oKoXiAdAbIBG6KFPjAuuAfcdsZu24KRkpE6g2h+D5ASRIvHTaOfIFNEDvXUOCiMw==
X-Received: by 2002:adf:a285:: with SMTP id s5-v6mr925474wra.114.1529660643238;
        Fri, 22 Jun 2018 02:44:03 -0700 (PDT)
Received: from kitone-HP-ProBook-4530s ([196.43.135.103])
        by smtp.gmail.com with ESMTPSA id v68-v6sm1375591wmd.12.2018.06.22.02.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 02:44:02 -0700 (PDT)
Date:   Fri, 22 Jun 2018 14:39:19 +0300
From:   Kitone Elvis Peter <elviskitone@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] block: Change simple_strtol() to kstrtol()
Message-ID: <20180622113918.GA6633@kitone-HP-ProBook-4530s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage of simple_strtol is discouraged, because
strtol() is obsolete. Instead kstrtol() should be 
used to convert a string into a long integer.  

Signed-off-by: Kitone Elvis Peter <elviskitone@gmail.com>
---
 drivers/block/brd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index e2a1278..4b7a28e 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -351,7 +351,7 @@ MODULE_ALIAS("rd");
 /* Legacy boot options - nonmodular */
 static int __init ramdisk_size(char *str)
 {
-	rd_size = simple_strtol(str, NULL, 0);
+	rd_size = kstrtol(str, NULL, 0);
 	return 1;
 }
 __setup("ramdisk_size=", ramdisk_size);
-- 
2.7.4

