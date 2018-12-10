Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E99C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1A620855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1A620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbeLJV7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:59:33 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:50299 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeLJV7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:59:32 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MhlbM-1h9x8Q27to-00dpPE; Mon, 10 Dec 2018 22:59:10 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     arm@kernel.org, Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ARM: tegra: avoid section mismatch warning
Date:   Mon, 10 Dec 2018 22:58:37 +0100
Message-Id: <20181210215856.2238253-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181210215856.2238253-1-arnd@arndb.de>
References: <20181210215856.2238253-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pVzuuYiqZoGnxIy+9O0ggSKEMABUdN1/PH8ap7LXzx57zWT85/C
 H5i38KO1MYUDuBDwzj2oZtGDnf2B0nJUcYb6tDuCQ5PclG6juq9E30nyxT3bzPFhjyA8HS+
 qgT9XnOgvQQHZWq5vq2ZGNabnTPvLHqVfDIC/jAH9RhP2GnZaC+FQO5d4dSNTbf4kCULpXY
 htRBQ9zpnaH2qPSt+eXAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NR/oVWTKn40=:f2ARBWMyYmyXlnsazBYwCc
 JUmDGB+JHoTUwWfa0w94mZTeMvA66IoDU6pZ66NV5wAQhZ2a2gXQVkKuUCM7RqMqKnNFqRj2J
 On+rlH3gQrAFA3QNeRQMzbY7NEfI767ywEdIRVue8qKJL+Z4mh2k0CTxU+06OZ0rbD52mzyKb
 Pq6ci9ScKBzqI7poSrCB9tI6zNq03gi3RmjtqEF12e3u+0GfWkPMiHkNxBF1UI69iBlFMYwUO
 Nvmaue+liI5jAYucUnSObCDX8AJpo6KnRXMZNyrgA7QNou2MWaxNaSHLvVbEuTycI5kL8Czfl
 VDqabZ6LO9NEXiTj0Sicyc4vvNCFWsaAbeH/6dZdJPKOycq5vJNJ7pyBygQXAlOko12s3v8cA
 bcCJcEhX+H1VViF8NurwSDHN7Ni5crfziC6menWuhsSyp/QO4oibyho2LcAFtqgYJDFGWJVDl
 M7dUbF5uYvhXBTmmqbAgK0ZnUNzIBSREbtUgXeTn5FB/YMpgt7wXaGQ2eWTlhrppyd/EnCId7
 vcJEs87ZW3L2/mfUeEAGXf3RsxtYrA+s3Bji3nBuJDrj2Q2UJwUWrglZcmR6rNzq9LzLoESs6
 m2cWp/koI3RM0De3NnX/4QRJelKgBxRa5Z88Yi193iulnrsLh1r2ZFMP2KwWh8/UIpTyzRJ8Y
 odst20GVd//mMgTESu2yoZm9rf6UNc4rd4dO+PvHiuXbo4r1s0HwItd+6hd/RISt/leZgvLIQ
 S3c2p7M/xIO2GMopTdRRJg5IcIUcBW3as5ruOA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: vmlinux.o(.text+0x39ecc): Section mismatch in reference from the function tegra114_gic_cpu_pm_registration() to the (unknown reference) .init.rodata:(unknown)
The function tegra114_gic_cpu_pm_registration() references
the (unknown reference) __initconst (unknown).
This is often because tegra114_gic_cpu_pm_registration lacks a __initconst
annotation or the annotation of (unknown) is wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-tegra/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index a69b22d37eed..a186ab663b0b 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -72,7 +72,7 @@ static const struct of_device_id tegra114_dt_gic_match[] __initconst = {
 	{ }
 };
 
-static void tegra114_gic_cpu_pm_registration(void)
+static void __init tegra114_gic_cpu_pm_registration(void)
 {
 	struct device_node *dn;
 
@@ -85,7 +85,7 @@ static void tegra114_gic_cpu_pm_registration(void)
 	cpu_pm_register_notifier(&tegra_gic_notifier_block);
 }
 #else
-static void tegra114_gic_cpu_pm_registration(void) { }
+static void __init tegra114_gic_cpu_pm_registration(void) { }
 #endif
 
 static const struct of_device_id tegra_ictlr_match[] __initconst = {
-- 
2.20.0

