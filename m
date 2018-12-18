Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796E4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481902133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WPg+M1fH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeLRIGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:06:08 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41176 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeLRIGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:06:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so7451596plm.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UfYvMyUASU0SktOneqY893l+ivwuHLJC4IjYGuuzrdU=;
        b=WPg+M1fHlkW3flIMrdiDhlhfZpjvGLb7X/Ub63au01MaDQdufdVMWB9oZvSdP9+hML
         3OL2FzqCGJQq4KTMOiS/hGusBjqVxBDfuaTdJ0pX6VyrD8jdFd3VNiCk/VMjcUqUv9F8
         EZXRcoNkFCF9QUysdAcDh6AHXV4pvod/3JqpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UfYvMyUASU0SktOneqY893l+ivwuHLJC4IjYGuuzrdU=;
        b=dHTrafueGeNLhqSisu7loFsSx/7vOgzJCaJl32DMbMkbiIlhPmKPS6wo30q+0oXgOC
         8t0vqE14b/t5i5qsHyuHidCsfO6J7jgs32lJfcaCjEtxLKdwGaQIaSPj6HD0yfy3Wf0g
         rkEIMqCmAHHbJBMRxL05Y2RXpDZGSsY22DphFm45coEX5/T7veuhyCNB9BfGwzM5cVY9
         jhfC9b8FWUwo6N1co/87hTEnxJQfQG9edrH4lhhBmcJu+TcNRaHoKtG27R0qyQPjOrJN
         sv6vXfTWuZopRP5hJ+wb8uLU9dRQ8VDcJCc679CCRremljgH5N1hbt0PQXv45yCbWFUJ
         kgHg==
X-Gm-Message-State: AA+aEWa6zrBRpXa+iR+h1CrWcDL+6MJTxT+eY6T2Le6+jjwt3fmoT4yr
        y9hNOnFj7njV/moGf62H2ZFV
X-Google-Smtp-Source: AFSGD/XvlZH7KkcB0shb83eb7e9NODL+0bPIiJR+Z9m8+H5jy/5wLXaQNzpZkAbLuLWEl7VpbYj1LQ==
X-Received: by 2002:a17:902:bd0a:: with SMTP id p10mr15074983pls.322.1545120366410;
        Tue, 18 Dec 2018 00:06:06 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id 7sm45596888pfm.8.2018.12.18.00.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 00:06:05 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 03/11] ARM: Prepare RDA8810PL SoC
Date:   Tue, 18 Dec 2018 13:35:19 +0530
Message-Id: <20181218080527.10801-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
References: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
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

