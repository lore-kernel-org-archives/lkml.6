Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B16C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A89205C9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="v/Ii9SJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfBHRiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:38:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51843 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbfBHRfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so4375885wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FQpTYNOFF/xBKJ0FliQbJ6ZdH9bqB2OMp9FtFZp2/A0=;
        b=v/Ii9SJyJuAmwSaaqOktm0NSIXF7mrcHTm6MfReo5x63shtm7vxeM0EbQQUiZyYrEu
         b4ZD3b4VIYr2ZFP2zRltnQxHhxzVRgElJ/V6JFyzXdEK6Syw9Cyw7ikzmGezfqFw/GXf
         0nAv7M2e1/D3LfiRevQdLaOUeK2wLH+GnJc0TkbdjPOqHMe6rKFLpiw/mFzibjxroA+s
         s418e5OZXSF9Gg9uio7wBFHZZyjMEKHfSbFdfvLULFuFLvM+/DXytAvCg9x+fQkPTkzl
         ma70ao9bHEMBpNJZg24+Zp9h9JS5mksplC9ucN9Ru0qXV1Rx91uhp9pdd543eVzCQdvO
         SiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FQpTYNOFF/xBKJ0FliQbJ6ZdH9bqB2OMp9FtFZp2/A0=;
        b=WxS/TWTE46pG1VEq1BdeX8uYjUgt3HxJ9HxoE5u7Q/2gH2njd2j2kgq8psQCJVSdgx
         Prbr52BkXpwkmMucqUtRslGGiZbiOiG5n87sxDadV8mdfBI/IG96vJZsKv1IC/Mf6Gni
         v0cpGyUXgU+bOWfqJRwuY4NjjEqhMQwuHLrhFXKJg+aiKd11CyrVMkpOYRczWuCSaSd6
         Tuo0WZPsbVjwWwmayo40IgfjwrZdMSEWnjp2VPttCyUH3ps6pkGXma+RlbhBIB6kmtGZ
         hIhGUVPilEzXdJH5qVRsX9/5HJ0GfXPDYBCe4X61gcbSOTXqsgQZfqQBCCXD6MrdCQtL
         z5bA==
X-Gm-Message-State: AHQUAubV3NJAhS9mBLjUKVpiaBbATlF4wkbDGk5GVebF9T4sWttWV+I2
        8OQuUM1gC+os2h11emV0bcMTOw==
X-Google-Smtp-Source: AHgI3IYPdAX3n34cLN9DfUSchpmdQB8sOgNgW67edjr9V44w3BsiNIGAj7fQS7jLmx7pjiKAGGk/yw==
X-Received: by 2002:a5d:6808:: with SMTP id w8mr16815425wru.270.1549647306207;
        Fri, 08 Feb 2019 09:35:06 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:05 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 01/33] ARM: davinci: remove intc_host_map from davinci_soc_info struct
Date:   Fri,  8 Feb 2019 18:34:26 +0100
Message-Id: <20190208173458.4801-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The intc_host_map field in struct davinci_soc_info is not used by any
board. Remove it as part of the interrupt support cleanup.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/cp_intc.c             | 5 -----
 arch/arm/mach-davinci/include/mach/common.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 94085d21018e..67805ca74ff8 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -117,7 +117,6 @@ int __init cp_intc_of_init(struct device_node *node, struct device_node *parent)
 {
 	u32 num_irq		= davinci_soc_info.intc_irq_num;
 	u8 *irq_prio		= davinci_soc_info.intc_irq_prios;
-	u32 *host_map		= davinci_soc_info.intc_host_map;
 	unsigned num_reg	= BITS_TO_LONGS(num_irq);
 	int i, irq_base;
 
@@ -182,10 +181,6 @@ int __init cp_intc_of_init(struct device_node *node, struct device_node *parent)
 			cp_intc_write(0x0f0f0f0f, CP_INTC_CHAN_MAP(i));
 	}
 
-	if (host_map)
-		for (i = 0; host_map[i] != -1; i++)
-			cp_intc_write(host_map[i], CP_INTC_HOST_MAP(i));
-
 	irq_base = irq_alloc_descs(-1, 0, num_irq, 0);
 	if (irq_base < 0) {
 		pr_warn("Couldn't allocate IRQ numbers\n");
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index b577e13a9c23..944afd57ee38 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -61,7 +61,6 @@ struct davinci_soc_info {
 	int				intc_type;
 	u8				*intc_irq_prios;
 	unsigned long			intc_irq_num;
-	u32				*intc_host_map;
 	struct davinci_timer_info	*timer_info;
 	int				gpio_type;
 	u32				gpio_base;
-- 
2.20.1

