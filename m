Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELshrx/+a8pW09MRFwM4q9J+qGxSiIOLep6fWKlrUYRgSNJUPOJy0+v23PkyVJtSaA5JcUEl
ARC-Seal: i=1; a=rsa-sha256; t=1521484001; cv=none;
        d=google.com; s=arc-20160816;
        b=SQj93UhNAbwx4NIyjjWMrvaa+XSo2vN1R4BKSp7PSkpc/vD2clcFutM1Syfcu9JKCY
         ToPcFA1RgwDhrzzShKgDOU7z1oU1Tpv6+5psn9hwgHOt1prr76Pdp6LpRHMHVtKRUs0V
         wDnYHkMAevqGXj1xu6jqh5aJZhyAJ1BzYRTKHDVvEh7ULFzmuBcy8KR80OFgwZoGB1wi
         08qIDVtowOd5kAIUihsN+pHKO8BbjLboQx9mEsgFxe4eiOh9FmCropJDxq0e/+Zaok0k
         L853UI/ATRVuJpauWUk/kvMgVLGIyCxNKYTxjNeHFgrOwV2rxUp6azoeFZkmRrkI20an
         iG2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uPGGhzm7F98b1nvXjWwA/5vyO4vGvB29N5l0EpvSaZY=;
        b=RYf+fDWw9LgxEpYAZhG/J92jehHbCGp9phmpffrcrcfblLNqFdyfPJ4ZU2Kpf5yraK
         F+VX3i6zaGHmuQ+vN9UoCCQntlRqI1TDzDk4fJgRajE/jOlEOpZwUy4Be35SfeYNS/kc
         TVopH8hInh2I8zfz/GVQYGFtAjLKT/aYnXE8w1zKtb7Rk1rJHHs8FFaYnsJxjMDCwl1d
         GbX10qoqkVAUr0qNW+ajcKeUDWZe378YEWpwu/H0X5+fmZTNu157/WNarNdC84ZKJplx
         aCfquQo8bJJ6LXEWOOLjkENzmvMofTvBg6TQaUhLnakY0BSpmIUNuJkTg1Vd3LsPczlQ
         qesQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Andrew F. Davis" <afd@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 178/241] ARM: dts: omap3-n900: Fix the audio CODECs reset pin
Date: Mon, 19 Mar 2018 19:07:23 +0100
Message-Id: <20180319180758.523777268@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390608912985115?=
X-GMAIL-MSGID: =?utf-8?q?1595391608319878663?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Andrew F. Davis" <afd@ti.com>


[ Upstream commit 7be4b5dc7ffa9499ac6ef33a5ffa9ff43f9b7057 ]

The correct DT property for specifying a GPIO used for reset
is "reset-gpios", fix this here.

Fixes: 14e3e295b2b9 ("ARM: dts: omap3-n900: Add TLV320AIC3X support")

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/omap3-n900.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -510,7 +510,7 @@
 	tlv320aic3x: tlv320aic3x@18 {
 		compatible = "ti,tlv320aic3x";
 		reg = <0x18>;
-		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
+		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
 		ai3x-gpio-func = <
 			0 /* AIC3X_GPIO1_FUNC_DISABLED */
 			5 /* AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT */
@@ -527,7 +527,7 @@
 	tlv320aic3x_aux: tlv320aic3x@19 {
 		compatible = "ti,tlv320aic3x";
 		reg = <0x19>;
-		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
+		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
 
 		AVDD-supply = <&vmmc2>;
 		DRVDD-supply = <&vmmc2>;
