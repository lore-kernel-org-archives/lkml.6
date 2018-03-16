Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt2LBhRDEd4pdetEU1as1hk7I0OXmKKO6JTj5+ievtroX+S7ctSADQIknh4HWRgeN9zqvQU
ARC-Seal: i=1; a=rsa-sha256; t=1521214565; cv=none;
        d=google.com; s=arc-20160816;
        b=O0LvYbF8DzfPA1jG2xUdzaX2cn4SA1+7M5fRJ9trvaOveQFYN+aEAGzFPIIp/bV2kc
         kSubv+GTpt1h6j4ISPb/f1DCL6bbPkRy82b+1BAs2nFc4J9PdkvD2U3lf1Hv4lZ+Wn3U
         BxCF70JihxFaRLIlxW9NYzBV4XVI/58dsbEovP5SpoMl0urKFI2fXE7QT9g6fQJdihvs
         /fg6SOm3GYQFEsDjR3ulhmKZ9/67/Ng71hQw7xp+f6f8sBp1UBL9axlvdM5G5hQNVEIk
         8ZDBFVhC+7l3nXwZQ6VGORpLrQiipkVDC+12DzAZnQ6OirGl8LXmPdauSUQS6UQTV4jj
         40Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sreTa28qHamrgtPYA3B8t8Rw0JhGsnRON6YeDbX3qZQ=;
        b=Q15fwu6ldeAIfyLMo2laZ3CdS9VVzIluYs/52k3pJhw3Etnus+Nq4aGVmb8l5c51UX
         1a0/MLF2tyHr1VfAUFnF8jvTEsVEyq/7HACvXbnOCagSYBjPHvSsVEpi94bFYtdS4gbV
         yNat1S7XzJ/ur6esFCe2fNJgwUiEd+4LF/TMxEDc5lE8zcam/wktyOFlp12HJsTtucYb
         1544AomlXl+5txiVnX/8kbLPg4qLUjnP/dJAq5mc7Zz6QsOUL++SHoHOJXtsdteCIhRi
         jFpXlv/ieJI8NQKxq6hKUzcSDkglt6iSG6JGS9qVBfiRM93Mbhb946Lezh+dAzZzN6T6
         rn3g==
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
Subject: [PATCH 4.14 051/109] ARM: dts: omap3-n900: Fix the audio CODECs reset pin
Date: Fri, 16 Mar 2018 16:23:20 +0100
Message-Id: <20180316152332.749403985@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109083759069731?=
X-GMAIL-MSGID: =?utf-8?q?1595109083759069731?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -558,7 +558,7 @@
 	tlv320aic3x: tlv320aic3x@18 {
 		compatible = "ti,tlv320aic3x";
 		reg = <0x18>;
-		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
+		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
 		ai3x-gpio-func = <
 			0 /* AIC3X_GPIO1_FUNC_DISABLED */
 			5 /* AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT */
@@ -575,7 +575,7 @@
 	tlv320aic3x_aux: tlv320aic3x@19 {
 		compatible = "ti,tlv320aic3x";
 		reg = <0x19>;
-		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
+		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
 
 		AVDD-supply = <&vmmc2>;
 		DRVDD-supply = <&vmmc2>;
