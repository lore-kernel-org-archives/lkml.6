Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34DDC04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC50E2147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="eYD7Q2I1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC50E2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbeKUUJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:09:59 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44618 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbeKUUJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:09:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so598390wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bz/FeTPmQV60t2Dbi9dat5wUPtQ0d67O7QRzMp0NMt0=;
        b=eYD7Q2I1kuJJgucwbNJH9n2HljmGXNXPpf9GvhEaN8gx7DKtmB73S0vZtsLaD9ednp
         O2UphumfTGyyyRRNY4pW3zF9pps4KbLt6BzMXPVygsi6fCqNYCGbi7K0MqGhFcAQMSJu
         VQdzKrswl/p2FiDkqELqeMe+xQqNoFDj0dLXEgg9GpnfkL7BEnqmX260bEPvpJ+wty36
         hXdT7NeFh1sRkjnHkQDSH9Eqo7eRZmTTc1DkDC6uvrKzBV8G60bE7JJPJFgrj/uOMvnu
         kCRCl0OUfUOZTRAT4rXR8vNZhT+d28bxWh192vbcW0JjBk9oZwGYFpNWJmw3e015HjG6
         4ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bz/FeTPmQV60t2Dbi9dat5wUPtQ0d67O7QRzMp0NMt0=;
        b=FKMfY6FDOsIYlR0aKVgwR38viVOulgH2fIzgNfSkFnyT2PQJyrEMLZNnJJnLmZKqAJ
         xk+LjfAsLFs0oIoPIoHU11ZlmTMLkLqr7W2iF5L+IAuRruU2YGvSJe8i5pfbP8blfVYL
         TGS12dVf7tY94EqB1iTSbsQP4P8oP6AazsHgwVurDSxskRSt+LJYaODsPlshT7/JLQf4
         tUzhs3yjdC4Rc9/cv0Y+vESBp3Cws7WggavZu2W17dzLGrV4DcUrakeLLV3HBS8NLG/v
         lqJmGQJAnfUhmKQo9KPTrwAT5vw32t8e1iO78WPAnczg6CDTVtFJu4z4WRLfMNiDBtSL
         JADA==
X-Gm-Message-State: AA+aEWYR7O+COhyeStANp/80zvnYLtg5krTsBdsOdnDvOdTJC5iQPjTK
        kjCIwiVE2+E4Xw60tV87KvTuiQ==
X-Google-Smtp-Source: AFSGD/WPbxs52+gX0yrYUVdmkqjLz4zaGQbVAc8r5h6ZiksjWJRDUhGEfE02ehFozU6DFdL9UcHedA==
X-Received: by 2002:adf:ed46:: with SMTP id u6mr5238317wro.262.1542792936080;
        Wed, 21 Nov 2018 01:35:36 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o8sm10443785wrx.15.2018.11.21.01.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 01:35:35 -0800 (PST)
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
Subject: [PATCH 05/12] ARM: davinci: dm644x: define gpio interrupts as separate resources
Date:   Wed, 21 Nov 2018 10:35:16 +0100
Message-Id: <20181121093523.12503-6-brgl@bgdev.pl>
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

Since commit eb3744a2dd01 ("gpio: davinci: Do not assume continuous
IRQ numbering") the davinci GPIO driver fails to probe if we boot
in legacy mode from any of the board files. Since the driver now
expects every interrupt to be defined as a separate resource, split
the definition of IRQ resources instead of having a single continuous
interrupt range.

Fixes: eb3744a2dd01 ("gpio: davinci: Do not assume continuous IRQ numbering")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm644x.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 0720da7809a6..de1ec6dc01e9 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -492,6 +492,26 @@ static struct resource dm644_gpio_resources[] = {
 	},
 	{	/* interrupt */
 		.start	= IRQ_GPIOBNK0,
+		.end	= IRQ_GPIOBNK0,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_GPIOBNK1,
+		.end	= IRQ_GPIOBNK1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_GPIOBNK2,
+		.end	= IRQ_GPIOBNK2,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_GPIOBNK3,
+		.end	= IRQ_GPIOBNK3,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_GPIOBNK4,
 		.end	= IRQ_GPIOBNK4,
 		.flags	= IORESOURCE_IRQ,
 	},
-- 
2.19.1

