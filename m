Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuaFtxDNLNPgV+cDylqNVUHZdi+Pzj4kKPptIflfR4DCQ0P/CFYnA5U3fgzCUjVC4l2bimx
ARC-Seal: i=1; a=rsa-sha256; t=1521483048; cv=none;
        d=google.com; s=arc-20160816;
        b=bxxuRjORr3vJ4/sC593NUFyz1NzEHxCMjaVPylSW6hxVfXXfReCEgZrJz7h66P3Z/d
         w1eLXUEKK12Rt2Y89EOE43XAgM2oBPHMmSd+YpYuaSyUvolTRsBIEht/7jjMGnALSgNu
         M/do/quY6k9htmLwhYbncbIYnOaT8kJp22VEqI6AyPrXvA1Ow7Go0xuou0IbbfsYLSYH
         nd0+6naQLUPWFKeHGbNnb6ng+jhCUlqqpDdUVeK3J3kIF4Nc1FhStd7czpa06l4j8MUD
         2FrqWI3wzbAj523RgH3BfifV9QsNLLkJD/lCLWDtRJKNKyXHwqCymUlNddt4IDqBXdVw
         7jOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RjypeOF8IIRMxGSHPpJGokmMOyXG5SFQ5cn55A3WvLo=;
        b=g7reX62s0SQActsN5i7D5U7YKY6CdUYCZ6fCE+xWhC54n1pzrWLE8qddaVMRtejr92
         xUr/fVpfc8qII/5MU1w2dZXPiW+mMXSZaDKCSRgKmwPUuf/AkMGSEZ20cBl+B6KJT911
         ATsVJU/srr8U5gx5EIBFVoy6dOkO/4sbqgiKjYV7olXqfBr+MNnJnTWWRMkRuOKGGgor
         AgOQP8fTEaXBTi6K2cTt14u6hFhDXq4+N/tcxXUAv/8VBzyx4r+BoT/8NCkkyhMPQgc6
         HGZs2R/vvg49C8aZoFsaH+IPu3tgU3km/LG6ifgvoSYbOvCFP46thlmykT3Id3Lfv1Mj
         Tp7w==
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
Subject: [PATCH 3.18 49/68] ARM: dts: omap3-n900: Fix the audio CODECs reset pin
Date: Mon, 19 Mar 2018 19:06:27 +0100
Message-Id: <20180319171834.760288496@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390608912985115?=
X-GMAIL-MSGID: =?utf-8?q?1595390608912985115?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -435,7 +435,7 @@
 	tlv320aic3x: tlv320aic3x@18 {
 		compatible = "ti,tlv320aic3x";
 		reg = <0x18>;
-		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
+		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
 		ai3x-gpio-func = <
 			0 /* AIC3X_GPIO1_FUNC_DISABLED */
 			5 /* AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT */
@@ -452,7 +452,7 @@
 	tlv320aic3x_aux: tlv320aic3x@19 {
 		compatible = "ti,tlv320aic3x";
 		reg = <0x19>;
-		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
+		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
 
 		AVDD-supply = <&vmmc2>;
 		DRVDD-supply = <&vmmc2>;
