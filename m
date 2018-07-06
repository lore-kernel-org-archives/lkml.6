Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82545C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3880723EA9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3880723EA9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932995AbeGFPQH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:16:07 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:46595 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932542AbeGFPQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:16:05 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Lx70L-1gCZRt2tg1-016eQb; Fri, 06 Jul 2018 17:15:32 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: shmobile: r8a7779: hide unused r8a7779_platform_cpu_kill
Date:   Fri,  6 Jul 2018 17:15:19 +0200
Message-Id: <20180706151528.3759312-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:H0IJLaOwxpSI1u+aeBkfsD1IXKxfuBvey2775URZ7tvMdSq3R+u
 4zk4I4FtmoZePIlCO7iTwcNVG+p6mlT9V3kk4mN46ysuDvwab/JpRVfhHNQNPBtkvdqiIOt
 f+Ih4lpKl5xZtUwAn9cpE/gSxsi/Mc8us9izmVtXcEWWbFr6tprG9uMyPp6JkUFpyoS8raX
 sKu2N1Wm/3b+HCNTv1qnQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2oBWXK5I0bc=:zO2GLzxp1vY/sfKs+i10X2
 s69S1rw0tgWXZVArct66OUJqGL5+33h9o2FY+Rk5eq1I+T5WBJdphd3NighY/HTn3mkIo25z8
 U80JYR2tdpIy4Vkq5Xxn22F1i2FhZgE4GauLubmQNhFxrkgI1rv+15RlKN669U2LOepSCrZYF
 LBFeyh3h22QxVBTjThV9V8BcLarN2lHGiJxYGWD4BXnaVIEGnfyQwh29Uin7LN3/Hmf93evlY
 4sC5wGRy516OmEoNxNpK1E46EfWoCubcXo2fHkT5UCpgNpAxb8/y5W3bJ4PnE58CRBCBI8E3X
 +1ET8Eh4XHTK2p7kHQ5By9dzKImUVIAi0pz/1HwBmDdcDz2sxKTDz1gJYsEbzlKHiz3cVAC91
 2J/9EYcz5O/gzRU8llmmaU7X9tZXC6ag/VXmB4dFYtJoGLCLKld1lYcbL4VNkJHO8AxDhmDBA
 azEnwiajV1vOh1QXzJhBeKTkc9Wdg5KZ0E4clU4SXqBAvKq1fHitbRoZk1qKPWBFy4MnLVIhb
 XPFd/gOaIJuhVZBNohMeQ58X8B/dG2+bQfYm3SabAzefnHx+MofF+jdhCBvGTK48zVdNWgmIv
 8T3TcpJol2gia7NBTn+aVI6URPDJ2uuoAFjlI6ukhLume3b4PK/2T7q9BEjX3KY7ZcQoxEpPl
 TMnL4Zwjb3XUn8+jfAn2XBm5/i4iBchdBuNIvHJimUrs7u1I3ok0BHBSAzHP3BlENdfg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the cleanup in r8a7779_smp_prepare_cpus(), the only remaining caller of
r8a7779_platform_cpu_kill() is in an ifdef, which leads to a build warning
without CONFIG_HOTPLUG_CPU:

arch/arm/mach-shmobile/smp-r8a7779.c:26:12: error: 'r8a7779_platform_cpu_kill' defined but not used [-Werror=unused-function]

This moves the function inside of that #ifdef to avoid the warning.

Fixes: 62f55ce683e3 ("ARM: shmobile: r8a7779: Stop powering down secondary CPUs during early boot")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-shmobile/smp-r8a7779.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index b7fe1f489b08..0ed73b650c14 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -23,17 +23,6 @@
 #define AVECR IOMEM(0xfe700040)
 #define R8A7779_SCU_BASE 0xf0000000
 
-static int r8a7779_platform_cpu_kill(unsigned int cpu)
-{
-	int ret = -EIO;
-
-	cpu = cpu_logical_map(cpu);
-	if (cpu)
-		ret = rcar_sysc_power_down_cpu(cpu);
-
-	return ret ? ret : 1;
-}
-
 static int r8a7779_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	int ret = -EIO;
@@ -55,6 +44,17 @@ static void __init r8a7779_smp_prepare_cpus(unsigned int max_cpus)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
+static int r8a7779_platform_cpu_kill(unsigned int cpu)
+{
+	int ret = -EIO;
+
+	cpu = cpu_logical_map(cpu);
+	if (cpu)
+		ret = rcar_sysc_power_down_cpu(cpu);
+
+	return ret ? ret : 1;
+}
+
 static int r8a7779_cpu_kill(unsigned int cpu)
 {
 	if (shmobile_smp_scu_cpu_kill(cpu))
-- 
2.9.0

