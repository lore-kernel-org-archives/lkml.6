Return-Path: <sebastian.reichel@collabora.co.uk>
X-Google-Smtp-Source: AG47ELtWNQA+hF7xqs9ZUtdD6LcKk9JJY1DhxFpCJfCpJGnp47AD1cfk0Dem2R3QYrdP1Bcncjjb
ARC-Seal: i=1; a=rsa-sha256; t=1521566530; cv=none;
        d=google.com; s=arc-20160816;
        b=JcTjNLug94XjSOZX0T/fmSp8VdBvJqnbbHP9sxdq3fJI/iY5deZX7nL55Vaz0f0844
         zu9RdzE3FNfuCc7oIFPUWMstJrfyhWW7WXQOpFOpBgbEdW6ugSuDWwgb0NmuuCaGr1eh
         oPNG3FRb7EYw2+qd6DkN/nW/PCnGEjFfxySTeevlQbPrVTVCVIhKEd272STtkwSFH4vI
         epzyJKWD52rbQq9XS+X1C0Z3liR+Sa0e09TpEeN4yipV32ngBDJybNJT1aU3lWD+3Axh
         u1Ze3xTXz1t7pcHFISBidfkgdTXWRmJb3sXSZ2xvAVUVm5DXo2mD0WLhZroLQGYcEfsd
         FLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=CSzF0KGJSePexebGXaiq3SJMyPT5cchmK34KFn5cioY=;
        b=q6smJIfw3MN95uh9N2ZyPQDVWvQ9rbWABS9FBZB1GE2wjhMrJhjay41mjec9XOe+MU
         nixvz1xwmvZ/ucoO1wiFxfi3PJD9GzyoIsdDLhNV9wWSN9V+vL5GWGOHDJvcwXAW8XHr
         +Lt2fVoOfCux0VrbBblnzLT8vENArpGh/hfxjuKSFx3JyfLSOhoNi/3owgVAvLgnpd6l
         zYC1LEuwS4wv5d3+WRHP6jjczfQvctiGpsKeRTXJkKTAImNqmcRJk/H1I5mfaXtB7fdx
         h0TICRL1YymHsRbM26ir9edVf/klK6C4XCZEyx4VsnD1kKL5kN38vdRZEH0ixtuE1iq/
         GlcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sebastian.reichel@collabora.co.uk designates 2a00:1098:0:82:1000:25:2eeb:e3e3 as permitted sender) smtp.mailfrom=sebastian.reichel@collabora.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=collabora.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sebastian.reichel@collabora.co.uk designates 2a00:1098:0:82:1000:25:2eeb:e3e3 as permitted sender) smtp.mailfrom=sebastian.reichel@collabora.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=collabora.co.uk
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Nandor Han <nandor.han@ge.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kernel@collabora.com,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 2/2] ARM: dts: imx53: PPD: Update ACHC programming interface
Date: Tue, 20 Mar 2018 18:22:01 +0100
Message-Id: <20180320172201.2065-3-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320172201.2065-1-sebastian.reichel@collabora.co.uk>
References: <20180320172201.2065-1-sebastian.reichel@collabora.co.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595478146286261781?=
X-GMAIL-MSGID: =?utf-8?q?1595478146286261781?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Update ACHC programming interface description following the binding
document. This makes it possible to use the new EzPort firmware
update driver.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/imx53-ppd.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
index 3c87e0d73f63..03c353be2fe7 100644
--- a/arch/arm/boot/dts/imx53-ppd.dts
+++ b/arch/arm/boot/dts/imx53-ppd.dts
@@ -253,9 +253,10 @@
 	status = "okay";
 
 	spidev0: spi@0 {
-		compatible = "ge,achc";
+		compatible = "ge,achc-ezport";
 		reg = <0>;
-		spi-max-frequency = <1000000>;
+		spi-max-frequency = <300000>;
+		reset-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
 	};
 
 	spidev1: spi@1 {
-- 
2.16.2
