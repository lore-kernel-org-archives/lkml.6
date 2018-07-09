Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792B7C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C97B20835
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C97B20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933914AbeGIPvy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:51:54 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:40041 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932940AbeGIPvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:51:52 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Mep7w-1fReNH0beK-00ODqQ; Mon, 09 Jul 2018 17:51:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Bai Ping <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx: call imx6sx_cpuidle_init() conditionally for 6sll
Date:   Mon,  9 Jul 2018 17:51:17 +0200
Message-Id: <20180709155130.2126597-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:VCzWh3uXnKYDxq2EQyeRZu902WGUzMfMyXzx9SsTkwhZY+g8e/m
 OOiVoI+YOOtsPsMtn7+5ke9QngRhS7JiAehx/vQ3Gg8maTNDHOZgjvPrZpXDtNDar2naVTK
 Sr3NmDLZ7GKfpvna6NDKP2Bd79sAYxkj7tzi2nvNS/oGbTVbR5hXbN/a9rekPuXbKX7jQRJ
 GtG2WgYDHsErFiBKB1gcA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:je8t16iOs4A=:MkjVNVslkzESQf4+pgDZw7
 Q3cx2VZxLz1IPQAsO7NImUc9qDAJfBTldwNEILvF6C6aOJWt4YtEtEGBMD9a8+Ya6jeB5BuTB
 K29ZeTWyeHAtPT4fJS8KxSc6SDuaIbIGTLiByAiO9Xss+6oxKem6U8uEtaoHoZDBCGVxWlF4d
 +c103k+4yzWgcLpROYyiy9In739vUMY7Bkob458Dy2e8nc0R4G+FVBm22f7CtyXygmDE0VQ2o
 jb2OsK+x7W5ycSWp1f7BGwUZurJaHNHs82UK1B3eLmGjwwJLDESBx8qOwoynl6uG06/od+rDW
 f8yZND6qbfKNIYUW749xCxL54GA7ulOOFB5i+CVe1t0dlNnVZun5Wh71SPn/lTzxwuVKNcRDG
 xGxdsF1ZT6+7Xp8npZiZm82Dmd8tPB7e1kpaQDTeH7Jq0D5Q/iapZAWQg44OXqXPjYkAioD7v
 +bNgpcKaGaO2B8c2G6DR6Tk6oA3IJcRAFHSYIzWLsdqbuSuANFkNdoWzGCH+gzkMU4uK2foBc
 9Cihdl+WQCn1V+jX2gnMzD4YtDESFDzz/trDrj0GhKu+9IegY6f0KJAXU0dIe10g2LT/2Y3Ut
 nNQ1amSKHlUroFpKzGEygBxwrEMSO48NEu2YumBkc8786oNdhpyFU5k5Ggf2plW5sEmjOlDzr
 1BonGAOknHOt+xlE6RTU5D0pgtvR+gc10V3a8ilJ3d/wRcmt7VsSS3kc/Kz/Q6o8QmGk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx6sl platform has two different cpuidle implementations,
and fails to link if we only want one of the two:

arch/arm/mach-imx/mach-imx6sl.o: In function `imx6sl_init_late':
mach-imx6sl.c:(.init.text+0x12): undefined reference to `imx6sx_cpuidle_init'

This makes the call into reference conditional on the configuration.

Fixes: e7fa1fb39b11 ("ARM: imx: add cpu idle support for i.MX6SLL")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I had already sent a related patch earlier, but missed this second
problem then.
---
 arch/arm/mach-imx/mach-imx6sl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index 183540e0838b..99be4225297a 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -42,9 +42,9 @@ static void __init imx6sl_init_late(void)
 	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ))
 		platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
 
-	if (cpu_is_imx6sl())
+	if (IS_ENABLED(CONFIG_SOC_IMX6SL) && cpu_is_imx6sl())
 		imx6sl_cpuidle_init();
-	else
+	else if (IS_ENABLED(CONFIG_SOC_IMX6SLL))
 		imx6sx_cpuidle_init();
 }
 
-- 
2.9.0

