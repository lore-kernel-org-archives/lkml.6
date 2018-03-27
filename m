Return-Path: <sebastian.reichel@collabora.co.uk>
X-Google-Smtp-Source: AIpwx49v8kNLTJ9akN5PZzVf7SZlKMUYA/GzkkGYT1XnaSbztc9YNRmDOq3LP7PhpL8FY6u5noe4
ARC-Seal: i=1; a=rsa-sha256; t=1522158792; cv=none;
        d=google.com; s=arc-20160816;
        b=k79oviyRp4LH0XId2oE8ecwBGMl5BKto9cCHxhoAvjsDV1Ff8JzvVWQqzOUH3rVaWD
         R7ubSARBUGIBQhJQzFIovi9Ywzs5G6F3VCfI91cR8tuqbKirRFJ838nnhqZmyqCLhi+l
         yfW1lU7abyERhni2o37oOfz/goLmbJCjfHNAVsotjL6XgP/68Z6GuGPD3C3yodn8BVKJ
         2tYa7hgIETSMsTa7bEjjHwt4rxfNKGwlj+vqGT63fJ0B+Tm/e2GEnZdQ/Z9TqgSfIX+B
         E4Aul48MK8A5YXGU/OxNITcG+Nt3f24WwYMSfrQPFlByiDIBuiacdg6mc2wnujnbTPhn
         yOjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=CSzF0KGJSePexebGXaiq3SJMyPT5cchmK34KFn5cioY=;
        b=qQdPPV0+XIjTi5GxbN+eEtyPAEvVEWd2gFruNvuKrvFrpzzdDsfPvR6WEdwjgpdI7j
         udStJ1ocrK4fdbrPjedF82YlGH0uvmQ5O+LcO+F4thMy2Qus1Khq/Nfas5EZwnDA4W7b
         725DiBoRcfpV89swI/EisuQfO8Z4uyvj/X/H1nfXnjptymWe7h9hoBY5r6eSB0FQ8ccA
         Hx0TT64Zdp1b9Pj95NK7D4RpMUXK15q//LF3MUE06J4d8vNvrIfBu8MdKJZf+r2Qm0EN
         l+lQfrHaHYrBTvkey7POnaC+nHZqZSEO2KrkA/qWIlhz2+ISqcso0r6Vr/Hlik+8pvNk
         A4GA==
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
Subject: [PATCHv2 3/3] ARM: dts: imx53: PPD: Update ACHC programming interface
Date: Tue, 27 Mar 2018 15:52:59 +0200
Message-Id: <20180327135259.30890-4-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180327135259.30890-1-sebastian.reichel@collabora.co.uk>
References: <20180327135259.30890-1-sebastian.reichel@collabora.co.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596099177298546157?=
X-GMAIL-MSGID: =?utf-8?q?1596099177298546157?=
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
