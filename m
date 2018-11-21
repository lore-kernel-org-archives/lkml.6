Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB98C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347FB21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZnrEuMGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347FB21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbeKUUJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:09:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37936 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729664AbeKUUJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:09:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id k198so5031808wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=30GQrjJ4sz6Srjekt5dJ/0kQMETEcA/z8amjFDgKjXw=;
        b=ZnrEuMGasyw+8D6Urh+Bi0FjEO+fKG25kFZAI9fiRKOmh91ZvWcxmHRqb5vfU+rZbU
         unhbkgYtWJ5Q7uk4CQLsWuQJ4SC+W/KjtUHgdyO2mekZCQ7Vdp8nfvvj5aG0LHbJ3qch
         oF3ZySZMCRVxlOsBB5jZSZl1jYXEf+OFco6NQnfkyxLORQppoiAfI0zRsqoJIgBtRdG8
         Z8aeWgGOirt/ME/QDKylB3MjwfbKpo31/SIwCZAv6qxqa0XzKSctGW4bD7vT8oN0SABo
         xom8Rhq+0NZKQvZDtqZBmOfd5qhf8Wz1gXbZlvji9T0UL9gQj8LIyShWFZ8mlU7X8rlB
         9reQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=30GQrjJ4sz6Srjekt5dJ/0kQMETEcA/z8amjFDgKjXw=;
        b=UA5f+QFSYdyeQmPIFruv2bMBZSy+FZ10xezJrLyfCNdWTOEVt6Y14QSC/vowELcrr1
         OrIHL6EGanQoPLzdCcTolO4YPa5UrsvqfGJ+DccurPk5GlyGd2OUwf6brECe4smlVMIS
         Mxmvv//7UMo4GUdT2jWXdbPILdVUK5zAw8E86YYcDCny1yLR6e+POImAubF7B4YnaTbJ
         E8R75haVHX8DfKo3cy1/4bKxNYShi122zG7mYApP6Xtn19IbJ3q7x9v35V1unYvvUoFa
         yCV4eZarhK90koSKDBj5/m0v3//eDkGI/o7Z5WbLTefylBntrmoV6LC4d7G3WGWqdSUP
         OMXg==
X-Gm-Message-State: AGRZ1gIyzam7AcL8Edu1PD1m7ysYqIv9WprejIdT8HomWxc0qiB8ktFn
        PtApmiIVRpg61A17CkWPnFL87g==
X-Google-Smtp-Source: AFSGD/X1j+U5/FzdwwzZgZtjJmF7fLRB64n9WQrBObfmgqOeO2pMJ22bGXjR+6e0gIp9UgKg9nuDXQ==
X-Received: by 2002:a1c:c70f:: with SMTP id x15mr5100035wmf.130.1542792944159;
        Wed, 21 Nov 2018 01:35:44 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o8sm10443785wrx.15.2018.11.21.01.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 01:35:43 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH 12/12] ARM: davinci: dm644x: set the GPIO base to 0
Date:   Wed, 21 Nov 2018 10:35:23 +0100
Message-Id: <20181121093523.12503-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121093523.12503-1-brgl@bgdev.pl>
References: <20181121093523.12503-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
automatic base selection") broke the GPIO support on DaVinci boards
in legacy mode by allowing gpiolib to set the GPIO base automatically.

DaVinci board files use the legacy GPIO API with hard-coded GPIO line
numbers. Use the new fields in struct davinci_gpio_platform_data to
manually set the GPIO base to 0.

Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm644x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index de1ec6dc01e9..38f92b7d413e 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -518,6 +518,8 @@ static struct resource dm644_gpio_resources[] = {
 };
 
 static struct davinci_gpio_platform_data dm644_gpio_platform_data = {
+	.no_auto_base	= true,
+	.base		= 0,
 	.ngpio		= 71,
 };
 
-- 
2.19.1

