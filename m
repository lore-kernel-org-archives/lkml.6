Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10263C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01F12081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01F12081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbeLJV7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:59:20 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:56379 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeLJV7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:59:20 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mdva2-1h3tO0002A-00b3Ru; Mon, 10 Dec 2018 22:58:58 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     arm@kernel.org, Kevin Hilman <khilman@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>,
        Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ARM: omap2: avoid section mismatch warning
Date:   Mon, 10 Dec 2018 22:58:36 +0100
Message-Id: <20181210215856.2238253-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4xNfypOG1G7KemGovL5smhPkT+WbudPJ33gdVGCu1Tj3Ec3qUoR
 TyQd9o3k0gnDQFOYHSD7mHWcwPAOkRBgMP7TxDQmDugBgrz7MHvL3ci1Q3nM78uYiiKGF1R
 f2pr8Ww/RxhXapwoSSyiND40NRjiabbovRuJL56i5dryP2/yFvpECuJRBjM1J2V0g20OE+B
 Zocqs3t7mmd6DrTvrmZpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G9nIODCCXis=:LWXXm/mQS1ubBy6fNESCXR
 wJrjp1mn7qniFZ/88nnZauB3WtjCJyeagvPjpJTqMjAexA46Vg5ZP25Higgjka655BkKE9xZV
 WZAdO82shBPideu5BcgKX3Po9DttgoWFU+2lUfFRZtDR4cp7TyFFnpBaVt+VIKwR5EZ+pCEqh
 Vot3l2LIjE86VFA7w15iH+nnRlqMVS+q1sHWzBEll2RVJFi4ErI7kRQ889sSVAtIuRGfZnRv+
 l52AvS+kBqNhguZiVQojz0Y1LVfOvWOpGX+8Ht3KwERI3mq1/jWIMvmHojzGLhY3F+hn2EjSs
 GYVbJZ10XZeF4taln988IJggn25tkB8yMD+t34/yZ/ecOGMWUnyBqXQOCrYgbR3Q/QB7RzIL0
 erjY4T+0XBycItoqTIagX/NQ7l5Ue42SMsVDj442zlVRwEcYsXIxczsyaUULpdQwDS1URUkod
 Et3f4zHXmFeDQBd76G2jKI5Hp5GqgEoZzm0HxmZE+a6GYtriK2vn3cePNF6yLd2vkeTU6F0qw
 SKaXPZvPnC4+XeHpD2a1F0P73m29PtNOZX+ySY3e5IUC7ra85YCQHdpROguKSuGkY7iPy8qzu
 4igcXGn2XTPFGtOuqTS5eKyg3I8Fyt8vDao3trj5QbKC6B0sVWXfZmqDjmmQpZwLYnbPm581k
 UzFqa5CVPNBzXM1Ux+D2smByYQPFlL3MaAmKKyOMLu/loMRwQm97A3u9JzvNcVZOhHh5reu1O
 vyyLNobE3Va70dL12INHEock/hn0jwQr9tNuYA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: vmlinux.o(.text+0x27530): Section mismatch in reference from the function am43xx_suspend_init() to the function .init.text:am43xx_map_scu()
The function am43xx_suspend_init() references
the function __init am43xx_map_scu().
This is often because am43xx_suspend_init lacks a __init
annotation or the annotation of am43xx_map_scu is wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/pm33xx-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
index f4971e4a86b2..724cf5774a6c 100644
--- a/arch/arm/mach-omap2/pm33xx-core.c
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -28,7 +28,7 @@ static struct clockdomain *gfx_l4ls_clkdm;
 static void __iomem *scu_base;
 static struct omap_hwmod *rtc_oh;
 
-static int __init am43xx_map_scu(void)
+static int am43xx_map_scu(void)
 {
 	scu_base = ioremap(scu_a9_get_base(), SZ_256);
 
-- 
2.20.0

