Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F8AC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC9620841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC9620841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeIAMY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:24:58 -0400
Received: from mout.perfora.net ([74.208.4.196]:55879 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeIAMY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:24:57 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LgGag-1fbJKL2dXg-00neMu; Sat, 01 Sep 2018 10:13:42 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 21/34] ARM: tegra: colibri_t30: add gpio hog to unreset usb ethernet chip
Date:   Sat,  1 Sep 2018 10:12:35 +0200
Message-Id: <20180901081248.22639-22-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:wU1lmJ3TpyEtuc16ixnc0Dkn/oVQuzEFm4tame6hD1r7sLtM2Ed
 S1HyQUpdm2aS7jgniTD9OOUGcXCTgqseIhf71ZAOXIudYQ5VKcqZTnvymTbNx7hD/Z2XkR3
 ZvNOK3QzRaQr1REiLYdcHora1L32BSPhzbYwbAkf8Z9ji2ecSVeSQs+QPahuSVG/icIVZGR
 bBulrnvf+5T9QNS/KsZBw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zZaobZqm4j8=:DDMyPnZd5e81l2yUnUkXss
 PiW8XwTSyRCgnfNiGC9kkSEtDY0+N7DM+oiNLxfYPCd+OMZu4AgdDOvPO0eaJ8+Xe+JTW18iV
 LNBwBKHlg8QFBGbzBGyVgxL4Xi6JbI8olJD4Zatf8D6Vc8zYv5oSxRXGsP0ezvKOeb0c7JgbC
 LE6qL9CMFS/Y7YLdVenmiD37z68gzhQj9rybkHSCV2OlkP+USTvUb7JMDGTPff8R0sZ4KXrRa
 0QA+pZMFLKo0Gf3aEoy3eLJk6TcsGVN00T8i7S+gq/AmHXuK/QRaby9sJ2YS0zztTeWOKYfzx
 sOTRfJnZptT11eYYPboSFLmPlw8x2s4zPLtsjPdGuj+9rm6ll28p4AmR11RRsZGSuEL2sOUzl
 aVVMFd7EDcC2RS2N9OANh9rR7Jp0aztYxzKfdmGtNBojHGQsnhGAM9DKKLIxrSlIMbHLdJk48
 oM1LhLvuXQkcD5/TRI941WI6b2hpHjLFh7qnXPkn8jeIPKZldUlCPvZLy4HhEvYG3XpEc1h9d
 kG2O1eTXisNif7Y7nU3ARhQ93kl2q2hNASuturZmtI7rimVB2k8wITG/F4lcG96k6XtovJnuI
 g+tyXU+spnqo4Zm56Ob1FESwMYLklvVEesswx+8JQRG9qHkzRbTfYw3FNAOsLSOvpv7RLy72C
 n9pcjnnXz3jYiiXV12Fe2aQh+pTNK4cDI7q5g92gL9PKIGx/3vrYksm7zAR0vvc9PaVk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add GPIO hog to unreset ASIX AX88772B USB Ethernet chip.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Replace underscores in node names with dashes.

 arch/arm/boot/dts/tegra30-colibri.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index eb36ae3038a7..aff94707b3fa 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -1027,3 +1027,12 @@
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
+
+&gpio {
+	lan-reset-n {
+		gpio-hog;
+		gpios = <TEGRA_GPIO(DD, 0) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "LAN_RESET#";
+	};
+};
-- 
2.14.4

