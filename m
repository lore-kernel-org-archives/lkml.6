Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752413AbeBJBmi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 20:42:38 -0500
Received: from mout.perfora.net ([74.208.4.194]:40103 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752374AbeBJBmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 20:42:36 -0500
From: Marcel Ziswiler <marcel@ziswiler.com>
To: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] ARM: dts: tegra: apalis/colibri: use correct compatible for rtc
Date: Sat, 10 Feb 2018 02:36:37 +0100
Message-Id: <20180210013638.28164-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180210013638.28164-1-marcel@ziswiler.com>
References: <20180210013638.28164-1-marcel@ziswiler.com>
X-Provags-ID: V03:K0:h2++kxmopnOrzGqjyWkZYRLb0SOn3lkIkU5GNhSYHvuGbPxVvHX
 YlYOt5nvnnPvgXmYmtpje3imA7FbZlxLV9LSC5YeBgzjlfvQ4ZYaaOYbruWde2ilOpPehYd
 80Yx5WO4VICpDg/MJTAO6yLZFW39tg9KC/7ejZJPqhx7qXl4ap0Jpyzj1Ic6EZ0z6JZZcql
 LYpyxs88unsmoDTKhPL3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BLPzFrOQtz8=:jVUFsaqOxTNV2V19uEZDGO
 W4tQNRhMqDevvmkV5ru1sXgJvCunkFGFTxnfcH5xixLshIw2ZoT90LAiG3ALftJN4KdbKuPP5
 n3Cj1NZik4Y2UY5kRAMYUc+cFPVdN7pkXzw90Lix5S6/tRHGvxMy6Tv9V/0iouXIUhQrhlNPA
 yKX1stKsQSs3dIx6cryY9Rf5k0/mHmF23J2QXdW/GZ8HsOgNzCBXWqOcII0vVcW4AYWAPin5p
 QHJxpXJwic4r3uhCbu06jCj4SRjQ8bES8AsmfwKweIxf8ui1rUofSMx6b2v3L/+vgRzGVsS51
 fB5e1dSoVy7U/oTtq7iRUmyWYeX5LZ9qJXxoEL/zdhHQI2sM98MrEM7VvW4cKe8kazO3E8iis
 z47zjDFecIPlCZh9G9/dK7s3oI2QWLmAz7O7QChA46YsMxFVgCX361/54QXRIIIhmOZmK50ih
 8LNYBHQZkYnUkeKQAoyRnFHt15jfiYp3ij+vhCADJKbKJ4g29Oa3xXzF0hxioWOlpmnm+rC6+
 xO+5bfNf842o4zGfOV1GC56hCgtUUOTJMRI5IfJi6BbL5vF65DtRv7XA63nUUNEx7IisxyFAe
 LrJIjxdU4ZbZJwvV2QVXAGCC64Ed1S0NNHhHlSBLfBPG9zZtyqBi5woGUO0axzaQEn3n1h6XW
 YSXPC4xA2sAFZFcci4L4/TPp4sIUEfBI7j+1MzUJZmk30aZW9X9Yxto1kVvUX3Hk5sjlCzrI7
 GEvb7cikEdTC5xn0kpukj2a3fsC7dRqLIMul7Q==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

All Toradex Carrier Boards use a st,m41t0 compatible RTC. Compared to a
st,m41t00 this RTC has also an oscillator fail bit which allows to
detect when the RTC lost track of time.

Similar to commit c53bec16b150 ("ARM: dts: colibri/apalis: use correct
compatible for RTC") covering our NXP i.MX and Vybrid based modules.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis-eval.dts    | 2 +-
 arch/arm/boot/dts/tegra30-apalis-eval.dts     | 2 +-
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/tegra124-apalis-eval.dts
index 66b6c45ee865..af6c566e8ac4 100644
--- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
@@ -114,7 +114,7 @@
 
 		/* M41T0M6 real time clock on carrier board */
 		rtc@68 {
-			compatible = "st,m41t00";
+			compatible = "st,m41t0";
 			reg = <0x68>;
 		};
 	};
diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index fdca527a2248..0dc85a20bd45 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -88,7 +88,7 @@
 
 		/* M41T0M6 real time clock on carrier board */
 		rtc@68 {
-			compatible = "st,m41t00";
+			compatible = "st,m41t0";
 			reg = <0x68>;
 		};
 	};
diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 8c62833197e5..16e1f387aa6d 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -60,7 +60,7 @@
 
 		/* M41T0M6 real time clock on carrier board */
 		rtc@68 {
-			compatible = "st,m41t00";
+			compatible = "st,m41t0";
 			reg = <0x68>;
 		};
 	};
-- 
2.14.3
