Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AC4C4151A
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BE2218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="kR8b33Dw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387598AbfAaNjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:39:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34979 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfAaNjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:39:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so3370109wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gYOoz7sLfOmvnQTTTNScB4YjgZPjHnNJytRdhrJ93Tc=;
        b=kR8b33DwbGVi80dq56qDYiOVzCpjcWmz+Oo4usclGpeR/XtgWNj2/0oG/J37mMKBc8
         vibG6NIVXChxP94HL9cW+fVmTjJy+kwW/Pibxf17VuoG8gW0nKfgi0y2Io+ff6UWQQSM
         sHv/8aKiT4J5c8qdUMgxnaG/vV9bFlhBMoANb3WtZ3gxXemgDIaRBFLdGhf93wEtyWCr
         7zOHgGcwx/9eVh5X7G8tOx4dPbEU1iWdLDmY5IckhEUUTqsfMk8g0KMxzm9rlFPhgYCL
         YdZ4VkSdWKJ9Frs6stYe1OuZL6ju9IOGDsW0TUpIErQrygTXCh+BHUC2mVJQ1tnti4Je
         yv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gYOoz7sLfOmvnQTTTNScB4YjgZPjHnNJytRdhrJ93Tc=;
        b=fLV7b9zhyT+Huz8gkPLos8ob2XgImru6KCT/acCsyGNSwE78PIeqUfYlgSxBiiCtKo
         jyQ/GO3pxerJHoB/Yc6m6wAEntRBXBZ3Qd9rvVlSNn7zNrWamvgxHxg2BJBlrPC6/Y7W
         LNd8zDgvWcUIX8ZXwaaaVh6cmQp80dbUxoXCMKOnZzCwq8l81eR7Oqkf5/LV98M+f/Xn
         /hdyfdA0j+nCu7YhZMoW+Sisjkp/YJ1zpAUNeRQLynasf0xzOQyzG47VH/ryc8INRZaw
         ewVD/H7DUy+7XxvoXtkyBXBpihD2/tL+WIOsaLA/+F7dtBvFhqACwUVt7ogNoIcXjduL
         /znA==
X-Gm-Message-State: AJcUukczi6PQxEpKLe6dC3rFwFZVauUazKB/6Ps3MhnqLRoNU+G4JQp/
        PXy3xl39RmbrLt4DY5gpA89+Ng==
X-Google-Smtp-Source: ALg8bN4elrVkZx/+xtRZqyIM8PbE8pDnzz5A63wKiI9Vhou1RSuYQCaDYuX2DdSfLagFB8lDga9RyA==
X-Received: by 2002:a05:6000:8a:: with SMTP id m10mr33726539wrx.79.1548941981798;
        Thu, 31 Jan 2019 05:39:41 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:39:41 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 01/35] ARM: davinci: remove intc_host_map from davinci_soc_info struct
Date:   Thu, 31 Jan 2019 14:38:54 +0100
Message-Id: <20190131133928.17985-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This field is not used by any board. Remove it as part of the interrupt
support cleanup.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
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

