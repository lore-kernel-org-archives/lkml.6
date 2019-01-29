Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDB3C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D94D214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iky8fOpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfA2PpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:45:21 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46642 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfA2PpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:45:21 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so8881133pgp.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 07:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2hL+n8s3PZPDTVR3C3fsWQ4CUK8XIxnsp6gmvT4RKy4=;
        b=iky8fOpDKopaxVP5oB+m/gza7nNYX98IttZ9Ou3fFLtC0Q2Rqf8LzajWHG+agWM3Sw
         wHo/jk63ro7ORYasiFmXLcCClY7rx3lkYnjRSmbB4p3UcvkoqS/+uHB7Vh9S9c3rNC/k
         ffB5EYudjdgAoZ7O93gXMppWeFky4qU3qs7VxQXFuCug4gQV4C8wagJB2gILgZfSHKiM
         MdQSHljJhpXiH3KrXtrgTO0PSA8s423H9Qd1YwFJWdgbiVCEyBT1Zx9dd6MyIXZ7C3m4
         M9CCOwCfVt4lRLE5jzQVQttbosHGdgb5wZ6VyjWklz0D/LLvBnI8qCO7/YG5lfguLtZ/
         RRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2hL+n8s3PZPDTVR3C3fsWQ4CUK8XIxnsp6gmvT4RKy4=;
        b=dZzFRPWBnIDBxsPm0HahKonOGbWJIvRmNUU/VzZiEbWAXWEBSCk810IHbom5cZFMHb
         J8eQCbTgf+84DkqjD2NMWyA7E6wny+1g/h6KPSAWGQCkUYSBxlr/lj9cWeyImGAryBsv
         sSJMp1FWDcRtkSlCjlfvaOJOQdNM3wg+PEccjnOwLQTrJbwbNduRkyR15eGYOPBx2VaL
         fztVuGosZd9irima1PqcDbyHZ+/S5heUBysPEsx7TXFZNVWgT60URpohexDyyV4ERR3U
         yRLJn9qE143FkhFBp68q1IroPtGvZ6O45ZK00oLu+AA1miKgSLwQsdFEa/Av5T5r7zVM
         2s2A==
X-Gm-Message-State: AJcUukelAOUkpViClsaIkJNQDjkfuRx6FEjnEvaTUbxj6fqSwIQzYceS
        57aEqwAyIHXoQUta1dQVmyF3DW3fOM+JKw==
X-Google-Smtp-Source: ALg8bN5XE/W25hqzW7cVy6uuZTOVgGIDj/6VzVf76Uweg1cDJ9QLj+yuRPdAFWbEgoVP7RrzDWhiCg==
X-Received: by 2002:a63:e247:: with SMTP id y7mr23038857pgj.84.1548776720057;
        Tue, 29 Jan 2019 07:45:20 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id w11sm45165929pgk.16.2019.01.29.07.45.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 07:45:19 -0800 (PST)
Date:   Tue, 29 Jan 2019 21:15:12 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     NeilBrown <neil@brown.name>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Kees Cook <keescook@chromium.org>, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-pinctrl: Test devm_kzalloc for failure while
 improving the code
Message-ID: <20190129154507.GA25365@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tests the return of devm_kzalloc for failure and
improves the code.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
index 3e959fa73703..9b52d44abef1 100644
--- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
+++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
@@ -350,7 +350,6 @@ static int rt2880_pinmux_probe(struct platform_device *pdev)
 	for_each_compatible_node(np, NULL, "ralink,rt2880-gpio") {
 		const __be32 *ngpio, *gpiobase;
 		struct pinctrl_gpio_range *range;
-		char *name;
 
 		if (!of_device_is_available(np))
 			continue;
@@ -362,9 +361,10 @@ static int rt2880_pinmux_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 
-		range = devm_kzalloc(p->dev, sizeof(*range) + 4, GFP_KERNEL);
-		range->name = name = (char *)&range[1];
-		sprintf(name, "pio");
+		range = devm_kzalloc(p->dev, sizeof(*range), GFP_KERNEL);
+		if (!range)
+			return -ENOMEM;
+		range->name = "pio";
 		range->npins = __be32_to_cpu(*ngpio);
 		range->base = __be32_to_cpu(*gpiobase);
 		range->pin_base = range->base;
-- 
2.17.1

