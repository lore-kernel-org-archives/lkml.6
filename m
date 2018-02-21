Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x226FZRXh/y+G40rcCk5wAjj0c7AQQe++1NNKi93g+EfJih2/wMPBFQLovO1lOnVM6bp9+MV3
ARC-Seal: i=1; a=rsa-sha256; t=1519230580; cv=none;
        d=google.com; s=arc-20160816;
        b=BMALfRFWHTDQtLYGTs9+Dyb3kx00ggSrommScLZHyQiHgaO4fpeLEyUvm+pgVcOyrZ
         tCQJTYOz2xLawi2vzNG48VBO8mkihsUWwh6LIyFQ89ymtccHGreYnEUi902YYVnXq6Jw
         Wm5wtj581NkCEBCzgG8lhJ6F+pj7dIRTueVAcVLXoBBLiPLo9mLERRq8C5aqZ74ouRD7
         BmRbAwZhE61Liyy+iVJW6eKz6cneKGNbJ+Na71JdssuTozFCDAguRABI/pgcPwCL4JGi
         TF/Plkp97P+p3Ba8dTmgTMkmJywKHIT27tjnsF/46jdmNVWLyaqsBl7F5zhYMqZQFJEh
         jlog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=974TurxzdMZA3QNPEYbi7aZ/24izTI8Eo/cbfktWrzc=;
        b=hxCl5+hgydyZnkmhaSOLi5+/dO/m9Nzd89hEqVjwWjMTb4nSzj8UKIRS+GZhwTtHf8
         pCg41PGMt+B9eV2nT+f4LD4GpCfU9hvJnmGdHiULei5wCqFbLausz+gAA26NYtZmZvgk
         ARZRx3rbespMY9u+t+UCtgp34YdV9G/U/kyATrfOdlcQJmRvmktJsOym2Bh5wNeZFD1H
         rSjmszjNSa+2mB0t61mtn4e2n+JNfo/80o2XLkbxOCuzDnevHfS1SpWzT5psdJQIprPf
         fxACysMDswvUFnlOcmvRpLV8VQaKyH/xwKKG/Et3uX58Xc/uzRc5J0NV0ffYhChbEeiv
         l2fg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.17.13 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.17.13 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	"chunfeng.yun@mediatek.com" <chunfeng.yun@mediatek.com>,
	Chaotian Jing <chaotian.jing@mediatek.com>,
	Daniel Kurtz <djkurtz@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v4.15-stable] arm64: dts: add #cooling-cells to CPU nodes
Date: Wed, 21 Feb 2018 17:29:19 +0100
Message-Id: <20180221162934.2728048-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:uNkGNBlvrEa55WbfB0nHtYFneKFfOvoB9YRgz03CE7u7kjrPWot
 KjpNI2VMT9cWd/fRgMG5uRybow1uOo/h9C/K1hM/rK4GontSZxjFLSGFwo4p/k0EynA61Yw
 BUL88Fjd7k46wYYNt7A0z5RgKz0ObCiDtPxlv1Z5Hezplk2iCKa0M/Z/SaZahc7jTszn5id
 CTfZbBL7F/4peXlsNaDLQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q14ngxBjUtU=:+Hhxn74rXINi6o9bAJxw/3
 xfZ+DiNAbNAMsWrOKwQAwwP6UgzsUnnozIsBIHNhd+UQubgiIL3QN9pywntkn97B+xE7TkoV2
 BLnOp/7GM0isxu2MHW2Q2+XE3ofO4JkD+ErqB9Dhqji8KPHPLBb3Gea/48UyLQ/dEiIitVjly
 fSYj0KYprPCreQjj4OehaeYq54Ce7Y0+Vs1NhsFP6FIm3OxGl1earjU8/gvq7ipVEsiSmZbHD
 oclMOaBL3fhO1+HlTkwR3RZUT31TZp9XTcR3MhkbnMevQMdVY9+tds91OFcTFyeUxzJyKnfiE
 /KVuZGk+pPOjfYhzkMrDzPQrqgPlFeEdFxWcDzQ/64ZCyE3FnsOhGbmQdCRt6cKepclffz4ce
 3QjShKWdlx9WFdzkGOFukJ371qTI6w0iAewTblLsBeG0+QPCXJIZLSLo2QFczrbxPxrgOnw9t
 ItUQVCH5g+qIK9VY9aQXc2dv8F70aYaMt4GRnmO0urKT8s7gT4EHJvQ1zdovfbyue2BJbvx7Q
 YLLq/wvKD78pADLRXOV6WcN/7F95CuTc5gjGp8PGeQJ3Yi/QP0EiJG+7K3ULU8DzHu6zkFf2h
 ss99LTtwiJBjBEipOR9K/gEroYHqOe65geh3Syk8nka2M4uq+FA3t9VyynCt/Vz9FgG2ykDE1
 UkhEUvHR1skj5U3liBzZuLpk8V3f7nRaHf0cJ+E+MtpdD1wDxSYbs88xDL5IR2ma00XWc+GxH
 YESJslxEHSKN5mUXnlyVT7Ts1iTU+X4ynkMGdw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593028724477169828?=
X-GMAIL-MSGID: =?utf-8?q?1593028724477169828?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit acbf76ee05067c3942852019993f7beb69a0f45f upstream.

dtc complains about the lack of #coolin-cells properties for the
CPU nodes that are referred to as "cooling-device":

arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (cooling_device_property): Missing property '#cooling-cells' in node /cpus/cpu@0 or bad phandle (referred from /thermal-zones/cpu_thermal/cooling-maps/map@0:cooling-device[0])
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (cooling_device_property): Missing property '#cooling-cells' in node /cpus/cpu@100 or bad phandle (referred from /thermal-zones/cpu_thermal/cooling-maps/map@1:cooling-device[0])

Apparently this property must be '<2>' to match the binding.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
[arnd: backported to 4.15]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 26396ef53bde..ea407aff1251 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -81,6 +81,7 @@
 			reg = <0x000>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -97,6 +98,7 @@
 			reg = <0x100>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@101 {
-- 
2.9.0
