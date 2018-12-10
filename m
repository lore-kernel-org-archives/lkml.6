Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97069C67839
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFFE20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFFE20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbeLJUoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:44:22 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:59387 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbeLJUoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:44:20 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mz9EL-1hR9vT0bkR-00wE1f; Mon, 10 Dec 2018 21:44:04 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     arm@kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: mmp: fix pxa168_device_usb_phy use on aspenite
Date:   Mon, 10 Dec 2018 21:43:02 +0100
Message-Id: <20181210204340.2269622-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181210204340.2269622-1-arnd@arndb.de>
References: <20181210204340.2269622-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:066X8609S8rRazQMCxM0FQnLP8YBYE3tBO/JFQU/o9qGK62sZEZ
 qnkHhV6WydiLmZjK6EPxbr7ntdTB1Hjf2f+DRGjcZ29jjc4BbT2kLtOiYiOKR1WEdO53qVD
 BD5c+EyteTSOTmrfUA1RcosJq+JwInpv7Nxp9SlKAIjQ8cgUjIauG7s8oDiuyx2ArM5OKmD
 /3SwebMridHGZxB4OmrwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Al2IwXHE/Ao=:OWxv5MAfZta7Ray7LT/eCZ
 DWOeYtzaektrlbfMIsguch7FKeGQeBBSrQQg+GUmYuGmoy85WzZKmsdR2RSYiZ0orgV1YynkS
 kFMXBH0OcI0mlexGgcHWsArbQuubbvwtTuZMxgk0A6yF9aY5kAS7fcbrHcQRhBhbH6SQd6xSg
 I4GWBul94I5vhz4zFIUHyQHBhAMg7xQ/MBSnbRN3r44x6W8rv5+C0ziUPcp/UaOFrH8suJ7AQ
 OmTFFZXiqy7fTvMYEmOP9qcHrOkRRrUy1jPfgxyPH4+6jg9aLP4Y2Pb8e8tnbZUGe6+C6fk2H
 vGK4dxbff4AgLesJgLnEQEg8dClRQXmeYENMisCiYVPOkrXP7AS3GWiFnl9WAi27AJ7XiHSJ1
 XWDOqBnfX69fNKPtYedDnwOHCgXYUm9bt4QeuNKELBaRZfWM1pwoJEmwKt/e3TCxksvUYrT+Y
 BNAJJb6SEvy2767vciVaLaUrd/AeNngECLzFRMdqh2cbg8WRStpKWBtU6m8Q1RKCmJzULSU8H
 X0emm/aZQfmgt1dbtuNA9dB3m5BWLqtFquEms6iIQs8yBp8Cw98lLFci/DNb5tP0i/9n2s/ju
 W2i1c4TkjI2E02eKaMj1MUfmkvGBRw/6K2YAUyAiy8wLoko7dgD5THSCIQzYbkrQzAsTS/iL/
 TXUHTcnT46CvemYhMdVv0A0RCMHKiA2iTxbJ86B0KrZM3Gnyi1SMvKWwq3+FDQ+6cevGsDli8
 CAsolcFHCXWDjb781orIRecfTpbbtY9FJ+SrTQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one ended up in the wrong header file, causing a build failure
on at least one platform:

arch/arm/mach-mmp/aspenite.c: In function 'common_init':
arch/arm/mach-mmp/aspenite.c:260:28: error: 'pxa168_device_usb_phy' undeclared (first use in this function); did you mean 'pxa168_device_ssp5'?

We can just include both the pxa168.h and pxa910.h headers to make
that work, which gets us to the next failure:

arch/arm/mach-mmp/aspenite.o: In function `common_init':
aspenite.c:(.init.text+0x1c0): undefined reference to `pxa168_device_usb_phy'

This is solved by using the matching ifdef check around the
USB device registration, enabling them only when either USB
host or gadget mode are enabled.

Fixes: a225daf72ee7 ("ARM: mmp: add a pxa-usb-phy device")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-mmp/aspenite.c | 3 +++
 arch/arm/mach-mmp/ttc_dkb.c  | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 23f99976b5f5..75b2d7db643e 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -29,6 +29,7 @@
 #include "addr-map.h"
 #include "mfp-pxa168.h"
 #include "pxa168.h"
+#include "pxa910.h"
 #include "irqs.h"
 #include "common.h"
 
@@ -256,6 +257,7 @@ static void __init common_init(void)
 	/* off-chip devices */
 	platform_device_register(&smc91x_device);
 
+#if IS_ENABLED(CONFIG_USB_SUPPORT)
 #if IS_ENABLED(CONFIG_PHY_PXA_USB)
 	platform_device_register(&pxa168_device_usb_phy);
 #endif
@@ -263,6 +265,7 @@ static void __init common_init(void)
 #if IS_ENABLED(CONFIG_USB_EHCI_MV)
 	pxa168_add_usb_host(&pxa168_sph_pdata);
 #endif
+#endif
 }
 
 MACHINE_START(ASPENITE, "PXA168-based Aspenite Development Platform")
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 767dcb23ee1c..09b53ace08ac 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -282,6 +282,7 @@ static void __init ttc_dkb_init(void)
 				 sizeof(struct pxa_gpio_platform_data));
 	platform_add_devices(ARRAY_AND_SIZE(ttc_dkb_devices));
 
+#if IS_ENABLED(CONFIG_USB_SUPPORT)
 #if IS_ENABLED(CONFIG_PHY_PXA_USB)
 	platform_device_register(&pxa168_device_usb_phy);
 #endif
@@ -300,6 +301,7 @@ static void __init ttc_dkb_init(void)
 	pxa168_device_u2ootg.dev.platform_data = &ttc_usb_pdata;
 	platform_device_register(&pxa168_device_u2ootg);
 #endif
+#endif
 
 #if IS_ENABLED(CONFIG_MMP_DISP)
 	add_disp();
-- 
2.20.0

