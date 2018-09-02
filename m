Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C751C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3245820841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3245820841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbeIBOYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:24:47 -0400
Received: from mout.perfora.net ([74.208.4.194]:49981 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbeIBOYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:24:47 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MWyu2-1gSJmO48EG-00W9uB; Sun, 02 Sep 2018 12:09:21 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 02/37] ARM: tegra: colibri_t20: iris: integrate i2c real time clock support
Date:   Sun,  2 Sep 2018 12:08:31 +0200
Message-Id: <20180902100906.25792-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:2CrJPLq4YGQShkgZOhukgdIfBxmHPK8RaxfyV9mjceh4w3kJRB/
 y0Qg/2f6b/5K7fx4l6tF7kdy7X1jkJMITtnnXyXxM3boM7ecJ80+tkdcNr2n8QS/W+Vepla
 YNs5r4I8ErPLQUBg3f4cbcqxYejdgvjaTHHd0JzB08LCJXe5/5qkTYHEdoAgZsVnP6mZTKs
 JAoNZCJTp3BSy2DcXd+Aw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F8tsQhmAkUs=:/mPuNKoeaJGqNIznNgEjnZ
 a2cpXalr/c6vwN5xOBtAsMaFT+euDe5hpw4Ht7PFQuUSC2wn5Ko6WWYnDjnngHOKmrK2r34Me
 yx9Y2+u5392lXUIycvz4BQDpK2ZiXPz6HH7H/Nszbiir1N9kDmbHUz9AJNyiQGpnLBqO+hdIs
 PWX3AbE/WHN6LGIFtYjqe+kfgCz+smJGBedXqY66O8yN4d9F85BQPxg5BBjHB2AiPeCvexny0
 +XihEJuu7BFT71Zp/4mAIXvzYdosU8mtZNef4L9b9z2m52d/6jE8MTAk0lCwYMRk7CQ4l0n3X
 2UMejmt0Al7L8lUQiio+c2YhwS6r+aFSpw8XVRg86o1TkYWNRavoocTeJENiPtialV+7j5Uij
 CmuLhMeAUiUZTgei14iJBGwEVBZljyZIQ8kOStjkw/RV+TchpUr20IZV12nPl5UfraSHDgHF0
 ZpkJ40HTeLsSCpnTjU9GKOa1HpzOK2/jUIaePD/HV5wTdKcnnbSuv31z7AfDEQ7Tn8UMBi15Z
 KMIzqxO8lP7/cWCkQHq83qPL45rhKtedUZnsXZyIzy2PZDJTzv14NDFGLCIG97h7kwm0/cEiF
 jO4fRYK3I5j2OiWbJGFwtg8XZz7FPlPB22WLxHv/+n7g6UrDkCEwjOTMcBDdaG2u6kSUEw0h3
 orxJx35K9j5lfNo62R465lQ/gt12fFY8SVdcjLyRwQHRuwXWu/MuL1UKOgkOeXfWyyWU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Integrate support for GEN1_I2C aka I2C_SDA/SCL on SODIMM pin 194/196 and
the M41T0M6 real time clock on the carrier board.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index 496b96e229d2..b6d05da8c93c 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -56,6 +56,21 @@
 		status = "okay";
 	};
 
+	/*
+	 * GEN1_I2C: I2C_SDA/SCL on SODIMM pin 194/196 (e.g. RTC on carrier
+	 * board)
+	 */
+	i2c@7000c000 {
+		status = "okay";
+		clock-frequency = <400000>;
+
+		/* M41T0M6 real time clock on carrier board */
+		rtc@68 {
+			compatible = "st,m41t0";
+			reg = <0x68>;
+		};
+	};
+
 	i2c_ddc: i2c@7000c400 {
 		status = "okay";
 	};
-- 
2.14.4

