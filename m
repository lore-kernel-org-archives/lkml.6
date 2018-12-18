Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EF5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281E920874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gVAh7JL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeLRDmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:42:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37344 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeLRDmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 22:42:23 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so7432948pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 19:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UfYvMyUASU0SktOneqY893l+ivwuHLJC4IjYGuuzrdU=;
        b=gVAh7JL4w5/QOJxDUswDGvBXkidVWZzZDpWSujaKogLRWBLhKOHr8Lb+sx/BjM+wzf
         PCkSrYZP98FcGGRJJKGhhfTKY8mnFnfrhnPRz4Vx+aVobXcxNfgyFqZETAqAGdo92CV6
         ozFApD5vTfn8XnfI06VJ1WxGr3tdPoQ24e7Ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UfYvMyUASU0SktOneqY893l+ivwuHLJC4IjYGuuzrdU=;
        b=AnNEl2ZGVhdiAIxnvLB6E89ZmzBQf8EoyqNtilviWhKNOw2FuzrLS7HO+BSN3cqqrn
         D364tCkumgBwEUnTCRymqRLQBcvFpQ2XMc6lj8NAOBTq+wox82XcnQHp0ZO7UFMJJsqn
         XgHl+Tivuh+hcpR61pihaKEsPvSTbbPpE85pJQdbq4AD1xSbZJPB0Tm0Dxx6cqAZdM7I
         +1Vpwwpsn21y6CLqUs7GgfdJ/jre2b40k4Xbz8iU2enF2wcXa3q74WvsL42i7SZhwmKr
         guWzdf0KSdqLJjureXzn/4U8ZELFgyHsKSdPsz3NrZnb1m+fCZfwItMFCveRlN1G5mVo
         xItA==
X-Gm-Message-State: AA+aEWbTNVibyTCHPtXKZvGQN7eeHxulepYuRfRWFp4Ry8IHbov2P8Ru
        A0E/9AqSNnV0U24ArP/9zFcD
X-Google-Smtp-Source: AFSGD/X8y4EN7pjdYPLHwzHhbJRvH6d30hXBqOEQ8Twoaag5VlT0ecI+DIH084YQ0TqA+XdqevRxOA==
X-Received: by 2002:a63:5d55:: with SMTP id o21mr14119004pgm.92.1545104542854;
        Mon, 17 Dec 2018 19:42:22 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id b202sm25255422pfb.88.2018.12.17.19.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 19:42:22 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 03/11] ARM: Prepare RDA8810PL SoC
Date:   Tue, 18 Dec 2018 09:11:24 +0530
Message-Id: <20181218034132.5070-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
References: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Färber <afaerber@suse.de>

Introduce ARCH_RDA and mach-rda for RDA Micro SoCs.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/Kconfig           | 2 ++
 arch/arm/Makefile          | 1 +
 arch/arm/mach-rda/Kconfig  | 9 +++++++++
 arch/arm/mach-rda/Makefile | 1 +
 4 files changed, 13 insertions(+)
 create mode 100644 arch/arm/mach-rda/Kconfig
 create mode 100644 arch/arm/mach-rda/Makefile

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 91be74d8df65..084f0983e6b2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -804,6 +804,8 @@ source "arch/arm/plat-pxa/Kconfig"
 
 source "arch/arm/mach-qcom/Kconfig"
 
+source "arch/arm/mach-rda/Kconfig"
+
 source "arch/arm/mach-realview/Kconfig"
 
 source "arch/arm/mach-rockchip/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 05a91d8b89f3..10056ccdb8be 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -202,6 +202,7 @@ machine-$(CONFIG_ARCH_ORION5X)		+= orion5x
 machine-$(CONFIG_ARCH_PICOXCELL)	+= picoxcell
 machine-$(CONFIG_ARCH_PXA)		+= pxa
 machine-$(CONFIG_ARCH_QCOM)		+= qcom
+machine-$(CONFIG_ARCH_RDA)		+= rda
 machine-$(CONFIG_ARCH_REALVIEW)		+= realview
 machine-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip
 machine-$(CONFIG_ARCH_RPC)		+= rpc
diff --git a/arch/arm/mach-rda/Kconfig b/arch/arm/mach-rda/Kconfig
new file mode 100644
index 000000000000..1ea753f57b2d
--- /dev/null
+++ b/arch/arm/mach-rda/Kconfig
@@ -0,0 +1,9 @@
+menuconfig ARCH_RDA
+	bool "RDA Micro SoCs"
+	depends on ARCH_MULTI_V7
+	select COMMON_CLK
+	select GENERIC_IRQ_CHIP
+	select RDA_INTC
+	select RDA_TIMER
+	help
+	  This enables support for the RDA Micro 8810PL SoC family.
diff --git a/arch/arm/mach-rda/Makefile b/arch/arm/mach-rda/Makefile
new file mode 100644
index 000000000000..6bea3d3a2dd7
--- /dev/null
+++ b/arch/arm/mach-rda/Makefile
@@ -0,0 +1 @@
+obj- += dummy.o
-- 
2.17.1

