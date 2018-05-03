Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbeECHwT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 03:52:19 -0400
Received: from mout.perfora.net ([74.208.4.196]:42459 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750773AbeECHwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 03:52:17 -0400
From: Marcel Ziswiler <marcel@ziswiler.com>
To: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] ARM: tegra: apalis-tk1: fix high speed uart compatible
Date: Thu,  3 May 2018 09:46:46 +0200
Message-Id: <20180503074646.24300-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lOcbZM6Ls3TrjMJpCDmInKXBJIFzqhZgeY3gTXYStDJqpe1zR/Q
 00C9FMSXJTi+09xFPALeb89yqB/iCdkpWZS0acy3J9Ku7bDe9TzccB5cOy7G14hdUfJR2nb
 tCV7ew/aSVK2/vZ3P/Cib1OA/3Ead2Me6aW+EzQ/bgu1GoR4Hx2YV1ztOr+hVZ6UmCL0/hA
 +tgh9xKoAhJGpqZQg7spQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+htwVRzJVJ4=:OcfDAlBEdcVfxRHt0g1cJV
 QL2x1xTkagGPHnnS7Y/I8cDxj5ICcoE1ngjo9U2aRhF3ufnX3SeWGlrLo6gdgh5d00pvLglfq
 k+oOyK270oeezNpC4anKPV/yYWuA/9xLIeoaiTQI1Rp/oFJEwujLTk76OxquMHfEF62MI+mf2
 VmhE1ayF4KtCy4pvnZRSjzIUF1zfXRoXe3KeYXPJ19SGSe4p9rqfHLSCB7iWdETpmDu/znRbn
 T0v+hIEzgS4HnqcjYVZD9GWjJJGCTy+EzlDiXrrK7F5abRyK4KAmGJEuD1e49T9anluz51fBX
 VxNwJQahCWe1K9gic71MjgTx6lmi//RGapJFLdT89zzYs1xy6xIC4MnueRoiLb6Z4TXxkAVni
 hMNm8Vrh/UW5K5EUYMi8wxSPXFi36QAVy1AgS6c5sf9fnlaFM3xw5GCTII918dDGO8FFxtxDM
 Ca2O9CO2IJARb3sk94OwVjQD4qN/WAB8UAANEUtMHDyyDFePc2acegDRIcoVOWPlgD4RflMGN
 OtzatLT9bAa1XGuYpK6Fg6qUqbQ8lfVZo8QnmRE8IzB/Uv0JxQYdCBz2m+K75WrFbno48mo7a
 PY09xWE3sAiHtftoGDOpUVd4BkPhU3n0RtMBotfDrlzDEMS7zdScfAtSw33ZmrnOforTL/acg
 ZL7CPhH/mTP5C7OKifH1dWtzhnHEFIktxy+KtT4BjnfxjjcNpNxA1ft4V0Rw/2Q2XyN81NXn4
 QxwFGVykMGN+v8Zj
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Turns out the compatible "nvidia,tegra124-hsuart" does not (yet) exit
and everybody else also uses it only in conjunction with
"nvidia,tegra30-hsuart".

Reported-by: Martin Šafařík <msafarik@retia.cz>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 6 +++---
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index bb67edb016c5..3455822350c5 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -1536,15 +1536,15 @@
 	};
 
 	serial@70006040 {
-		compatible = "nvidia,tegra124-hsuart";
+		compatible = "nvidia,tegra124-hsuart", "nvidia,tegra30-hsuart";
 	};
 
 	serial@70006200 {
-		compatible = "nvidia,tegra124-hsuart";
+		compatible = "nvidia,tegra124-hsuart", "nvidia,tegra30-hsuart";
 	};
 
 	serial@70006300 {
-		compatible = "nvidia,tegra124-hsuart";
+		compatible = "nvidia,tegra124-hsuart", "nvidia,tegra30-hsuart";
 	};
 
 	hdmi_ddc: i2c@7000c700 {
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 65a2161b9b8e..9f960c84ba10 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -1565,15 +1565,15 @@
 	};
 
 	serial@70006040 {
-		compatible = "nvidia,tegra124-hsuart";
+		compatible = "nvidia,tegra124-hsuart", "nvidia,tegra30-hsuart";
 	};
 
 	serial@70006200 {
-		compatible = "nvidia,tegra124-hsuart";
+		compatible = "nvidia,tegra124-hsuart", "nvidia,tegra30-hsuart";
 	};
 
 	serial@70006300 {
-		compatible = "nvidia,tegra124-hsuart";
+		compatible = "nvidia,tegra124-hsuart", "nvidia,tegra30-hsuart";
 	};
 
 	hdmi_ddc: i2c@7000c400 {
-- 
2.14.3
