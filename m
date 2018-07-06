Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEF2C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B104223EA9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B104223EA9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932688AbeGFPQ1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:16:27 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:40967 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932575AbeGFPQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:16:25 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue007 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MXjQA-1feK1D1F14-00WXEH; Fri, 06 Jul 2018 17:16:13 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: r9a06g032: don't build SMP fiiles for non-SMP config
Date:   Fri,  6 Jul 2018 17:16:01 +0200
Message-Id: <20180706151610.3783638-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:CI7i2e8lNXGLM7p1DsPHd0BdP++ExKXzdKdgr/Kz3WEGNh25XKN
 9Wcz8KEwhKJOk0KuPDYUDVX7nV+UeHQ8xvJUIjOEsmO4KHMGS1B/tPBceIXZ3ZgnfTs9UC1
 +3zgJt0KHBIn+ltW3AgLSNNJB3yO73jqLSKK/xsOloO4/qg8g2VrLaao0SO41aA+dH0Toqn
 5D+Zw/qH2BKiy/1tbybFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KzDBpnXBjUc=:64X8I65GhWtGxfZ2xpYWjc
 FHLYfbltcD1Ytm/HKr1pSDhaps9iZJGNV+WOa8muSRj5HgxNBSp8Av7kdwcjIyJTUUppghFQy
 yA+t6/1v+hhBvaCoXRqOQ4y4bqBgG7smhb9C8EGrX4eBFxPyhZTSVOuIANe/fmH0/3XBgINkv
 lU3cHpBdZKzpFhxFdLa9eDbk35jX30AmDGBpBTk/QGuiy8tposnN2jflgrZyvQX4zaUAcI983
 UtIZgh5F7EcgxifKfgj9KS2cn/+PHxGp1l/Dxiklg0LvJj2+2O9AbGxO5cFYAPfr/LG01nt0H
 nmw013WaP5RvIF8/5NUTA1LgK3J4N2ngk4EW/4jfxeqntJ414KCPGbzaoPw1S/RpCh7PbW7gf
 fTEpyd8I4cOyN9XiD4Q/O0tyOmrU/dMYr8dOetjLceSCrB5A68DsNbygOF0P8kZfaK12GWzoF
 9NbK3HN+bR4AeIqmMajKDPaKrUENvKosAjpdGGLMu1mZ+0hPjED9b/2qC65oqd1YZgN014ZWw
 o6GJrIWeoFjypIrONI6CaSZWcOwSJYS0j+jnqbZ6TRJPTPzKt5p+aqMbrG6bVcVTBxDyrdSEA
 jf6pPNlB2rVIZk1v9S8mZ16msAtWNH1J4KrHb1bDYbDg6wDtLQwGwbdQEzmxKnhKteA3uZxe6
 15jwocJCko7Ua9zW69yDdsKhzy81PNcSaVYs8Yn3LsJuXfW56oiMktFsX5oon7/7qmfk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_SMP, we get a build failure:

In file included from include/linux/byteorder/little_endian.h:5,
                 from arch/arm/include/uapi/asm/byteorder.h:22,
                 from include/asm-generic/bitops/le.h:6,
                 from arch/arm/include/asm/bitops.h:342,
                 from include/linux/bitops.h:18,
                 from include/linux/kernel.h:11,
                 from include/asm-generic/bug.h:18,
                 from arch/arm/include/asm/bug.h:60,
                 from include/linux/bug.h:5,
                 from include/linux/io.h:23,
                 from drivers/soc/renesas/r9a06g032-smp.c:11:
drivers/soc/renesas/r9a06g032-smp.c: In function 'r9a06g032_smp_boot_secondary':
drivers/soc/renesas/r9a06g032-smp.c:43:21: error: 'secondary_startup' undeclared (first use in this function)
  writel(__pa_symbol(secondary_startup), cpu_bootaddr);
                     ^~~~~~~~~~~~~~~~~

This makes the compilation of that file conditional on SMP support.
It would probably be better for consistency to leave that file
in arch/arm/mach-shmobile/, matching what we do for all other smp
operations.

Fixes: cde4f86f9249 ("arm: shmobile: Add the R9A06G032 SMP enabler driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/renesas/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 44a0d6b10192..c37b0803c1b6 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -18,7 +18,9 @@ obj-$(CONFIG_SYSC_R8A77970)	+= r8a77970-sysc.o
 obj-$(CONFIG_SYSC_R8A77980)	+= r8a77980-sysc.o
 obj-$(CONFIG_SYSC_R8A77990)	+= r8a77990-sysc.o
 obj-$(CONFIG_SYSC_R8A77995)	+= r8a77995-sysc.o
+ifdef CONFIG_SMP
 obj-$(CONFIG_ARCH_R9A06G032)	+= r9a06g032-smp.o
+endif
 
 # Family
 obj-$(CONFIG_RST_RCAR)		+= rcar-rst.o
-- 
2.9.0

