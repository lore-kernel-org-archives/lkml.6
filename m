Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt8kmVii+0o4P7ElcMuN95Nss4Rr3xvYetE3Js7tT1zgpEic3q99xw2rjSl7lUTs4hzlzLj
ARC-Seal: i=1; a=rsa-sha256; t=1521483341; cv=none;
        d=google.com; s=arc-20160816;
        b=O0ILoZq61jVOT54sFc33Vv04lje0Q+b2XjOghm+AkWGypsVab4+SrAQnHtT144q993
         XA6RIfuo45cPnd0WL5B73aR3BAEG+bn4ht3f4atbBP7Pajs387/DLb5h1VxvcVcezBX3
         gbbjzqVt2jLFS8/m6AC7u9Oz1XZJFxRztVbJML36hTYZRF55qF9ZFpmpMW30IUPf+jqW
         sAu1blOtZZKqoZBYuyJbExjEOLNLwbwWbRgB84JOWC22jBxz2qCfGdbWvrd6YNZ+1z2J
         tXGXQ3wsAO+7FXSXrLqJ76PWSe6S98BQLZpq9voaaA9IQwbeJEpc7UdsZq9kW1ubhGAh
         ZBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lfIQrh+xNyRqOYaSREt9MgyX9bPp9vv4rfVbDryVglc=;
        b=FFo07RIUiqGZJLEiNkcVzSgQuSmrVyzZsi7/Zz607I1ExXxli6POFhlhm+axaAzHv6
         5yCZtQZrPiJf+8rdu9LfoGJb4D3ZIX9tqOyUROcA2PWBfnWs7JCHWH0iHHrXGmmzVisy
         eYu/l8jJT0gvY9tefXxa3PNHcCEE/co3XTd2U9jVuH8zPcaVnZHJuBxTmHTF4nkEVJes
         ntRENGVilqT7wMchl0tiQeMEHj/Ns8zMTogvsFJ4WNWnc6zIxSskwspUwSQdg4pjEOuu
         7oY2jlVzT+HvOB+xQf9iRorhp+b4Xx+XtuEVwcSk5DucavXzGfcYBAdQBUtl/k9icZ2m
         fN+w==
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
Subject: [PATCH 4.4 089/134] ARM: dts: omap3-n900: Fix the audio CODECs reset pin
Date: Mon, 19 Mar 2018 19:06:12 +0100
Message-Id: <20180319171902.160796295@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390608912985115?=
X-GMAIL-MSGID: =?utf-8?q?1595390916180442021?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -488,7 +488,7 @@
 	tlv320aic3x: tlv320aic3x@18 {
 		compatible = "ti,tlv320aic3x";
 		reg = <0x18>;
-		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
+		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
 		ai3x-gpio-func = <
 			0 /* AIC3X_GPIO1_FUNC_DISABLED */
 			5 /* AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT */
@@ -505,7 +505,7 @@
 	tlv320aic3x_aux: tlv320aic3x@19 {
 		compatible = "ti,tlv320aic3x";
 		reg = <0x19>;
-		gpio-reset = <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
+		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
 
 		AVDD-supply = <&vmmc2>;
 		DRVDD-supply = <&vmmc2>;
