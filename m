Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ACDC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7391217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugNh42NH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfAWAd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:33:59 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35098 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbfAWAdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 19:33:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so219958plo.2;
        Tue, 22 Jan 2019 16:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tfGTIJO5m8NWQURx9g+bU65yV8N/3DpbsVgcNTCxXUQ=;
        b=ugNh42NHKJ4iuhT/CHr1m6eYLE8RjkCAjsWmnDTdjvh8eUgjuTa1ZYXyFKt7MpkPRp
         98VcQyMqN1iyydW+quiBl80XY6bUaTkgkdpA2+yb7QKFUAQAqXQch9loQVX/y60x5+ur
         6JFblbgbhFucwXuaypL2eY2hA5a7FH4Q10U0mTtH30m2ANuM1JlkB1hj6UdmBwbG3dRI
         aPvVvvwD93bw/zruuyZTsAzm5DS1SuDo9eeBuD9ZSqi0Ie2XHceGd5ecCiV176ixAOw5
         94LqTvnTDS0QTgxVfHnU81JJabz87rceMbJ+1cMxmHKUjVVcCGj9s1o1vNBtJlEWyXVa
         6wBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tfGTIJO5m8NWQURx9g+bU65yV8N/3DpbsVgcNTCxXUQ=;
        b=VvK5JiaRjTRLRWE2rebJNZX9TFKwl1uRiFWMRF2VrcV6gQQxbs+3U29vFuNZec366G
         y0mz7nrgT6E8kZIvl9Jfp4RBwwJKGLGA0TTCyQtbCrrBEVT4A0JBtdnzI0Lxqrc0uwt3
         BvIvSFupsIxvXQeJHlyJgKizD49aChGJjrd+eXbqvNJglvRd2T3d7sleOniKzJcEJtbP
         Dma2P6adk0QSEXXLpzokTsR0Mv4sL8b3xeNV8jKUWgPedB/N0rZW+Pzz5R1H697kPaMe
         +fXyX8zvVgv6iUHfBGuUdF75ECsQnTJUy+Z8o5Kp/xnrcQgGuGLKZ7XZiHZgPp2QeN+D
         NU1w==
X-Gm-Message-State: AJcUukeuQlatJHmb5tzApCgnnXHxUd1FLELZJkc68GkiCtaKhxPss6IE
        bkEm05c7CPnd/irK1lQw66+44vhC
X-Google-Smtp-Source: ALg8bN6D3u/lHxf23Y6GYqAbjBgb885VrYySsIy73j6QMoNSyHSAZ6EuoFY+qDgkn+v7+nleb7gYVw==
X-Received: by 2002:a17:902:32c3:: with SMTP id z61mr113791plb.114.1548203632158;
        Tue, 22 Jan 2019 16:33:52 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id e86sm25465257pfb.6.2019.01.22.16.33.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 16:33:51 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE), rdunlap@infradead.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        paul.gortmaker@windriver.com
Subject: [PATCH reset-next 2/2] reset: brcmstb: Fix 32-bit build with 64-bit resource_size_t
Date:   Tue, 22 Jan 2019 16:33:45 -0800
Message-Id: <20190123003345.13750-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190123003345.13750-1-f.fainelli@gmail.com>
References: <20190123003345.13750-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit architectures defining resource_size_t as 64-bit (because of
PAE), we can run into a linker failure because of the modulo and the
division against resource_size(), replace the two problematic operations
with an alignment check on the register resource (instead of modulo),
and the division with DIV_ROUND_CLOSEST_ULL().

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: c196cdc7659d ("reset: Add Broadcom STB SW_INIT reset controller driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/reset/reset-brcmstb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-brcmstb.c b/drivers/reset/reset-brcmstb.c
index 01ab1f71518b..c4cab8b5052d 100644
--- a/drivers/reset/reset-brcmstb.c
+++ b/drivers/reset/reset-brcmstb.c
@@ -91,7 +91,8 @@ static int brcmstb_reset_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (resource_size(res) % SW_INIT_BANK_SIZE) {
+	if (!IS_ALIGNED(res->start, SW_INIT_BANK_SIZE) ||
+	    !IS_AGLINED(resource_size(res), SW_INIT_BANK_SIZE)) {
 		dev_err(kdev, "incorrect register range\n");
 		return -EINVAL;
 	}
@@ -103,7 +104,8 @@ static int brcmstb_reset_probe(struct platform_device *pdev)
 	dev_set_drvdata(kdev, priv);
 
 	priv->rcdev.owner = THIS_MODULE;
-	priv->rcdev.nr_resets = (resource_size(res) / SW_INIT_BANK_SIZE) * 32;
+	priv->rcdev.nr_resets = DIV_ROUND_CLOSEST_ULL(resource_size(res),
+						      SW_INIT_BANK_SIZE) * 32;
 	priv->rcdev.ops = &brcmstb_reset_ops;
 	priv->rcdev.of_node = kdev->of_node;
 	/* Use defaults: 1 cell and simple xlate function */
-- 
2.17.1

