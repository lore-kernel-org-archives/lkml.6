Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48qvQ2YBPfD/GJCpOsSqEGgUldFa9DHi6CUnMUf6qK/e45U+tPWhGsQZMFVY01l2HEIT+mi
ARC-Seal: i=1; a=rsa-sha256; t=1524406716; cv=none;
        d=google.com; s=arc-20160816;
        b=X/fmZBNiPFxtzlPN3qRyNRISIZv51GTyxcqGnXzRAf/bzMxFR2NUMnUo01dXlax3/7
         Aq9wTfV9enGa181cR5dS8P36Ia1AugPCgbYEUOZFKvlXA6AoPQzJ/QEeqlQ7l7yOzum0
         kj/JdODMgCWk/D+RbF5WdUjfRIsXRhotnTz7sfYhWS5XFDqQhzLbQhoFtf6S2ljjxHgn
         eEmIIRTvP2VWYxppR0ivJo5LBDIOH5WlzccIrMuaVXzK3APr1L0g4EkAjvU+TV+xU6lb
         86uPlgFlcfL2QtiPVLWs83pjnMy1YHTVlLP6aOK4d2UNAbN89YQEV8ItXX7eHql7m9ht
         Ek2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=onFDc88X60ur1MgkP+D4j4/dmuKMdj5ldxLLltylqbY=;
        b=YWWsoI6x27pWzl3Sj3AeBxTJ8P/9JEojDQbgXTGGaWTHTlHn5UpwX/eipFo9qLMHeD
         uv6HQr/fS1fSRpapOWgTmh6WTo9+v+4Dw5+6RcNosXQKSJ3/p0l/nyjiCQr5+cK5t1cr
         dWz730RFgfiFM+GfecapUt96J9RPtpbdp7wqTki9KwnNKd2gk+eUzCTEar/8ZHnZ9WcI
         rG/ZRikm0vswdW7Q/Kft2X2LMD1leb1dEM4Je1HWVg1DU5SfjXq3QyjwREdxAX1S9UqF
         xFIaVM6M0GrudpqLGXCij3LPCXlRAMmy9GOi042guAd+uMizwQcwe0jyx+F60JymVPku
         g1ag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Santiago Esteban <Santiago.Esteban@microchip.com>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4.4 32/97] ARM: dts: at91: sama5d4: fix pinctrl compatible string
Date: Sun, 22 Apr 2018 15:53:10 +0200
Message-Id: <20180422135307.140538907@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454842841403828?=
X-GMAIL-MSGID: =?utf-8?q?1598456296912579719?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Santiago Esteban <Santiago.Esteban@microchip.com>

commit 9a06757dcc8509c162ac00488c8c82fc98e04227 upstream.

The compatible string is incorrect. Add atmel,sama5d3-pinctrl since
it's the appropriate compatible string. Remove the
atmel,at91rm9200-pinctrl compatible string, this fallback is
useless, there are too many changes.

Signed-off-by: Santiago Esteban <Santiago.Esteban@microchip.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: stable@vger.kernel.org #v3.18
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/sama5d4.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1354,7 +1354,7 @@
 			pinctrl@fc06a000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "atmel,at91sam9x5-pinctrl", "atmel,at91rm9200-pinctrl", "simple-bus";
+				compatible = "atmel,sama5d3-pinctrl", "atmel,at91sam9x5-pinctrl", "simple-bus";
 				ranges = <0xfc068000 0xfc068000 0x100
 					  0xfc06a000 0xfc06a000 0x4000>;
 				/* WARNING: revisit as pin spec has changed */
