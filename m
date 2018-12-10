Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFB7C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802802086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802802086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbeLJUsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:48:40 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:59451 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJUsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:48:40 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MNtGq-1gqBDO1Ho0-00OELJ; Mon, 10 Dec 2018 21:48:18 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     arm@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx: fix dependencies on imx7ulp
Date:   Mon, 10 Dec 2018 21:47:59 +0100
Message-Id: <20181210204816.2516007-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/5qOA8hnrs1Q/kzShLRmAfQuhrtQHTybSSKRZpUWS1xzy0VKbI3
 OsS/f+NxMT+PpMq7KI/+w551uRUVFfvbEwGK5fH2DrATqHnapVHNAXGlbsDXkn8Qj0Pyija
 UpcXDb2eyR5jbdOKas1rA6BMyD+ux6Yhk3uPlTE9hCBkewQ0FiuxbZfEM/9fVO24YXYwzYm
 SWudopuCt0jlBNt5OOBMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VAJt8o1f5b8=:L/NgnzfoM/vNh5darJ+Ke5
 YlZgQz/NZsyQxK4lNkvCE/krOQPRimxZ4I19YeyPR5T4JlFt7R60MKPgiHZFNH5DW95iAA9oG
 q+IGc48qWCKwK8K/1+GRtbYPxa+WGW2R8QP0vYFfM1ehh3Ki/u94NLCJxqxF3jwylKdRhI8FS
 A/HFvcD05h9xgyhunLNeznkC5HJUA5asVu8LKpiuGm5HHMFrOFL1nTNcZS0y8MMjnebaiYnfp
 Neji3aTmpIY0cPAeYpnKWJVNYH0zMv++cbUoGZEgexJ4Ol2wn8uUX83caG4xebor/7q3VhmkE
 GcTepV+PqXFiR0GHmFuXkgDKJVv0i2+rP849XI3WzGOf57GOkwOP2LH3MOLFAYU3fyx2hmUtX
 GinhVS7CDU51aLkZIqXTUJ3Z5ghUiVI93vwT1dm2is61bYLPQRrWB77pH/HIsRcSz/ddOEVAb
 f2/4ZKp3uZJv9CNbRoR2JSgp5TzKio4CllGMg0+dH7+8xBJ9Z9c4GbOMgWGFmgVD4spYELySR
 QoxjXdDXrfdqvsFo5EZ864hcS/lBpuzg9xF0PeOQ91JKWp8FrH7pUA8em56gkpyr2mWEBxBet
 GudzzUHAQafP4GOdttCCISR4bdcSFMq1h0WknJ1MIxq+BwxY+c18Pr2MgaMQXEkpm0Tt0y7lY
 L0aTFIuH9hi4V2ddKcw4O9vzNyfLPy+zGMWu9+Is1ACKfzVY/aw0auJIa4bf/6O8J1H2ooNZ0
 oblev9ajQbyiaX31xAgrIgTily7maLiXvS8Kng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX7D configuration was reworked, but that change did
not get propagated into the newly added i.MX7ULP, which now
produces a Kconfig warning:

WARNING: unmet direct dependencies detected for HAVE_ARM_ARCH_TIMER
  Depends on [n]: CPU_V7 [=n]
  Selected by [y]:
  - SOC_IMX7ULP [=y] && ARCH_MXC [=y] && (ARCH_MULTI_V7 [=n] || ARM_SINGLE_ARMV7M [=y])

Change it to work the same way as i.MX7D.

Fixes: 1a1f919eb52e ("ARM: imx: Provide support for NXP i.MX7D Cortex-M4")
Fixes: acb83c0eb036 ("ARM: imx: add initial support for imx7ulp")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index c12a05cbf268..9b8d4d6aa763 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -560,10 +560,10 @@ config SOC_IMX7D
 
 config SOC_IMX7ULP
 	bool "i.MX7ULP support"
-	select ARM_GIC
 	select CLKSRC_IMX_TPM
-	select HAVE_ARM_ARCH_TIMER
 	select PINCTRL_IMX7ULP
+	select SOC_IMX7D_CA7 if ARCH_MULTI_V7
+	select SOC_IMX7D_CM4 if ARM_SINGLE_ARMV7M
 	help
 	  This enables support for Freescale i.MX7 Ultra Low Power processor.
 
-- 
2.20.0

