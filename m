Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBA3C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FC7222D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IS05PJ+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391444AbfBMJ4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:56:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34679 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388982AbfBMJ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:56:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id f14so1765441wrg.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 01:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fM3DtWzdm7lzNMZ5rtfBSNROL8nNsUNCCP9M4XkP7Cs=;
        b=IS05PJ+AujhhHNnbN/gJsZA9ubDgDZV+VgnzCvaP8/104J+n/9CKqBbRAO4lQVKcD/
         aA9o+KITB2HYtwyAlhLrVwa4dGDCziuw/XmE9Ofkbn668lrGbMHQnB8aWRlEkuRDJ9pP
         p0SPNqcrS84DSGImVJnFSd2ERHyK+jV9nBAW8Et4eMxOXlTGSfuKNoX8kmXlXDUbTcF8
         4NEEbl2oywDAaIADntO73bbsQCs5DtsXRsqHQ9PI1PzHqfdPlXXS45FIMFlcjkGIXgZd
         7/AEL3HKvDB22qaxFuJZrmXjJnTV/EeY6i7G2MMSp2IS1kQUpYCIox87Mawy/RKkJrKS
         o1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fM3DtWzdm7lzNMZ5rtfBSNROL8nNsUNCCP9M4XkP7Cs=;
        b=LQCXxLTM13U5Cw9UURY6HyfO2YQFNxJIj1Gp/GrhU4GidC+aDFQmXHaNmIeYgeqGT6
         ACDP+BlaMe1uw5yvXYLmOtJ1+GCEuTmX/jgKwukkP40FG4NWeNnjFN32lTqEGR05sz2U
         W4NfrOj0UinflTwD9fn6xR1QhaA8H6xEDhdpP72D22FFMi0jvszrJMe798MSRlqoC2Sy
         A+/yN7TIKuCPlWriSIJTAYyZphbazEzD24PKnz3hGfIGn9rlN3eYM70VrJeQCzndutgl
         tt1eC1duXjGlovSMIBMnC0Nx7pVqmPwKKt9a9ked2RpwnJxR+WDkc30Pw41sXqY5auLi
         tdKw==
X-Gm-Message-State: AHQUAuZ9xIWU9w2CHRkgfhnQV1ft/BP5BgjJuqKn4Rt0jIVSaFFrmLY5
        XLgDnaCxzREctP2dsF/PjjaLKw==
X-Google-Smtp-Source: AHgI3IZu/qqrCsaG42W6vlIrjCqFfYCA5BLN654/s5Br5us1Fb8R+aYAv9rRekALAyFFqmx5KI5Atg==
X-Received: by 2002:adf:8919:: with SMTP id s25mr6317360wrs.38.1550051778345;
        Wed, 13 Feb 2019 01:56:18 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1008:7bdd:48fa:e18e:8893:ae85])
        by smtp.gmail.com with ESMTPSA id 2sm41244909wrj.27.2019.02.13.01.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 01:56:17 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
To:     linux@armlinux.org.uk, arnd@arndb.de, alexandre.torgue@st.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Jason Liu <r64343@freescale.com>
Subject: [PATCH 1/2] ARM: errata 814220-B-Cache maintenance by set/way operations can execute out of order.
Date:   Wed, 13 Feb 2019 10:56:12 +0100
Message-Id: <20190213095613.31045-2-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190213095613.31045-1-benjamin.gaignard@linaro.org>
References: <20190213095613.31045-1-benjamin.gaignard@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
The v7 ARM states that all cache and branch predictor maintenance operations
that do not specify an address execute, relative to each other, in program
order. However, because of this erratum, an L2 set/way cache maintenance
operation can overtake an L1 set/way cache maintenance operation, this would
cause the data corruption.

This ERRATA affected the Cortex-A7 and present in r0p2, r0p3, r0p4, r0p5.

This patch is the SW workaround by adding a DSB before changing cache levels as
the ARM ERRATA: ARM/MP: 814220 told in the ARM ERRATA documentation.

Signed-off-by: Jason Liu <r64343@freescale.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 arch/arm/Kconfig       | 10 ++++++++++
 arch/arm/mm/cache-v7.S |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e918e2624..6f608558e22a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1227,6 +1227,16 @@ config PCI_HOST_ITE8152
 	default y
 	select DMABOUNCE
 
+config ARM_ERRATA_814220
+	bool "ARM errata: Cache maintenance by set/way operations can execute out of order"
+	depends on CPU_V7
+	help
+	  The v7 ARM states that all cache and branch predictor maintenance operations
+	  that do not specify an address execute, relative to each other, in program order.
+	  However, because of this erratum, an L2 set/way cache maintenance operation can
+	  overtake an L1 set/way cache maintenance operation. This ERRATA only affected the
+	  Cortex-A7 and present in r0p2, r0p3, r0p4, r0p5.
+
 endmenu
 
 menu "Kernel Features"
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 2149b47a0c5a..7ff7b4c197cc 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -163,6 +163,9 @@ loop2:
 skip:
 	add	r10, r10, #2			@ increment cache number
 	cmp	r3, r10
+#ifdef CONFIG_ARM_ERRATA_814220
+	dsb
+#endif
 	bgt	flush_levels
 finished:
 	mov	r10, #0				@ switch back to cache level 0
-- 
2.15.0

