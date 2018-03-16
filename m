Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtSmuLpXhzD6Avbeeebru3w4eWtaJncgbjK5bRm52PNzJKNpOadr1zb714a2o2twvKiZCIG
ARC-Seal: i=1; a=rsa-sha256; t=1521214914; cv=none;
        d=google.com; s=arc-20160816;
        b=NahniqeA8Mq4Jc3ftc6s8c0g0/26BdJx6j8Z70eu5JAl3SpUTYJnCpoX1Z6yA/0spV
         GIKtGr/6Sc5DjkpTM1rgs6hzKY2ZvDwma1Z6CeDXN+XZSZITe0r8klfHv8/qvNr72qyY
         GFU353CvrF57S4QN+UQSSvPDbUQYoOnCLOcNwtwZptfEv6Re12BjvdkIwLPaYNQ4i2IL
         XW8JuT+C5iMNTNkFEMjPgpGy+3VDyW/QMGDKHy0HM/lCmRI+5ori6tE3x7K+SZSHmJSF
         HGUaypTDH2V/YMAM4ao112sB3a/BDhRFGuLZDqRyg5qIJ0lRrRNfUROLQedbkRnNfpK3
         Zw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pGu6MNZF1tNvp1V4ewFZuuFoUb28hHF0vatu+CSwd1c=;
        b=u1pJaRs/PKYaN3bAL4M/i5EfkC90qGsSqJfsV9BzaRdVUsQDnrLs+OEbqceTQsH+em
         /gg/02MNYqfv357yWKrN9NrgZo6jxpg1C9LAmXDSKkoda7fs9LLX6jBbtnGJbbKnGwJ9
         jzVs5DevpB3JSxKHupevsDbQpqrVKgT9xRY8VrWnZp1x13gu+S7s4NeFX/8K59ozcJwU
         P23MP3AXxHjcef/zw6f98Jh14BE8AfL6CDPi7QBZChkQxOcqeEU8EEcTmes7vmY9uNBg
         +KW0PZFWM7cOSkBjQ5Nkdh2GL2F/RZWbUmDUCKgLW0+41/1eQkiSrDeH55wL4cyfI1Tu
         jDww==
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
Subject: [PATCH 4.15 062/128] ARM: dts: omap3-n900: Fix the audio CODECs reset pin
Date: Fri, 16 Mar 2018 16:23:23 +0100
Message-Id: <20180316152339.880368668@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109083759069731?=
X-GMAIL-MSGID: =?utf-8?q?1595109450704451043?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
