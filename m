Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5BEC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EEB2173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EEB2173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732665AbeHCMRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:17:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38793 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeHCMRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:17:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w73ALJfK3848978
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 3 Aug 2018 03:21:19 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w73ALJ1R3848975;
        Fri, 3 Aug 2018 03:21:19 -0700
Date:   Fri, 3 Aug 2018 03:21:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Palmer Dabbelt <tipbot@zytor.com>
Message-ID: <tip-4f7799d96e6621ce584df60739e1480a6fd89f0a@git.kernel.org>
Cc:     will.deacon@arm.com, hpa@zytor.com, gregkh@linuxfoundation.org,
        palmer@sifive.com, tglx@linutronix.de, arnd@arndb.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, arnd@arndb.de, hpa@zytor.com,
          will.deacon@arm.com, gregkh@linuxfoundation.org,
          palmer@sifive.com
In-Reply-To: <20180622170126.6308-6-palmer@sifive.com>
References: <20180622170126.6308-6-palmer@sifive.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/irqchip: Remove MULTI_IRQ_HANDLER as it's now
 obselete
Git-Commit-ID: 4f7799d96e6621ce584df60739e1480a6fd89f0a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4f7799d96e6621ce584df60739e1480a6fd89f0a
Gitweb:     https://git.kernel.org/tip/4f7799d96e6621ce584df60739e1480a6fd89f0a
Author:     Palmer Dabbelt <palmer@sifive.com>
AuthorDate: Fri, 22 Jun 2018 10:01:26 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 3 Aug 2018 12:14:10 +0200

genirq/irqchip: Remove MULTI_IRQ_HANDLER as it's now obselete

Now that every user of MULTI_IRQ_HANDLER has been convereted over to use
GENERIC_IRQ_MULTI_HANDLER remove the references to MULTI_IRQ_HANDLER.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux@armlinux.org.uk
Cc: catalin.marinas@arm.com
Cc: Will Deacon <will.deacon@arm.com>
Cc: jonas@southpole.se
Cc: stefan.kristiansson@saunalahti.fi
Cc: shorne@gmail.com
Cc: jason@lakedaemon.net
Cc: marc.zyngier@arm.com
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: nicolas.pitre@linaro.org
Cc: vladimir.murzin@arm.com
Cc: keescook@chromium.org
Cc: jinb.park7@gmail.com
Cc: yamada.masahiro@socionext.com
Cc: alexandre.belloni@bootlin.com
Cc: pombredanne@nexb.com
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: kstewart@linuxfoundation.org
Cc: jhogan@kernel.org
Cc: mark.rutland@arm.com
Cc: ard.biesheuvel@linaro.org
Cc: james.morse@arm.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: openrisc@lists.librecores.org
Link: https://lkml.kernel.org/r/20180622170126.6308-6-palmer@sifive.com

---
 drivers/irqchip/Kconfig | 24 ++++++++----------------
 kernel/irq/Kconfig      |  1 -
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7527f6a9adae..d564d21245c5 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -8,8 +8,7 @@ config ARM_GIC
 	bool
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 
 config ARM_GIC_PM
@@ -35,8 +34,7 @@ config GIC_NON_BANKED
 config ARM_GIC_V3
 	bool
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select IRQ_DOMAIN_HIERARCHY
 	select PARTITION_PERCPU
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
@@ -68,8 +66,7 @@ config ARM_NVIC
 config ARM_VIC
 	bool
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 
 config ARM_VIC_NR
 	int
@@ -96,16 +93,14 @@ config ATMEL_AIC_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 
 config ATMEL_AIC5_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 
 config I8259
@@ -142,8 +137,7 @@ config DW_APB_ICTL
 config FARADAY_FTINTC010
 	bool
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 
 config HISILICON_IRQ_MBIGEN
@@ -168,8 +162,7 @@ config CLPS711X_IRQCHIP
 	bool
 	depends on ARCH_CLPS711X
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 	default y
 
@@ -188,8 +181,7 @@ config OMAP_IRQCHIP
 config ORION_IRQCHIP
 	bool
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER
 
 config PIC32_EVIC
 	bool
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index c6766f326072..5f3e2baefca9 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -134,7 +134,6 @@ config GENERIC_IRQ_DEBUGFS
 endmenu
 
 config GENERIC_IRQ_MULTI_HANDLER
-	depends on !MULTI_IRQ_HANDLER
 	bool
 	help
 	  Allow to specify the low level IRQ handler at run time.
