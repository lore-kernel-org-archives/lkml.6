Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtkfv1/Th3EwzpjSl9RAOfdJ33SnzXoiSJsoNbF4jkVaBcS/IJq0+U1dvo6hAC42Ovg/POR
ARC-Seal: i=1; a=rsa-sha256; t=1521214123; cv=none;
        d=google.com; s=arc-20160816;
        b=SIfJYxvQ6HMjIPaSYfZQf1HZDiLNWfz8TU1gYcw+Bs+K7d2DE2T+NfrBV6cAnfBv+d
         ONab8nN5xyoJflCJLCC9uCvl7mXhLi1/EB9Mpj9w0yhREhj74F7vWTXEOBdwhV5yKV69
         PaaR/UBJWahOT8yOdQ//RcmrvKdyOzQC0yD40+lBlLjmU0RjkOFqBEbKVoDE60lVIfY4
         PSq+B4+tzk5uP6L1+sB91qqzaYaXg3o88gnsWjAuan/zH41RmBz+uQG2k2Nh4H7sMoeg
         SLKFz9AQXa8LnmH80I5abwjldae3pXVP5JDALM8nqvNhdZzGmVLZn43niUsyXgo9tx3S
         mG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xZCPuMYxDoo49oVgtVA2Wz/NpLHzaaQ1pynad3fDUXU=;
        b=sJm6L7kgAzSFDBSjqMFd9eZR6qwA/60NHngZTQoWkpeJHRrMrnH+oIWnm3dcgmqJqa
         eONGZ8x9iYCIxM0dTMgSBh8Az2BL+bOhOX2OI4uy67cfUeUOLFPyhs4+HMdTCdeuzJfs
         wHlTPoZaEE4F+1tZidlHAxMsPvE+woeDo1FhXqA6vlMn8yVWM4Sz59USOSj1h6XLn3Jr
         XxHubdDstGDa2pvrppK9uGVKBQAFVxTGeSgaPExoPondQ9A2M4xVJ0A9XPb2iaNhyzz0
         JJAd4mH11Mi9iGKbSpD4OhfkMgkCDZohzkWWVgRWUUdmMpzBBeErP9zGsPlDrqtkjgF5
         lrJA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	Adam Ford <aford173@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4.4 49/63] Revert "ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux"
Date: Fri, 16 Mar 2018 16:23:21 +0100
Message-Id: <20180316152305.089955468@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108621239521366?=
X-GMAIL-MSGID: =?utf-8?q?1595108621239521366?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit c86bfc7b7b01c4b98c29a39bd60e61fa8e337ebf which was
commit 74402055a2d3ec998a1ded599e86185a27d9bbf4 upstream.

The backport merged incorrectly, so I'm dropping it.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Adam Ford <aford173@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi |    8 --------
 1 file changed, 8 deletions(-)

--- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
@@ -90,8 +90,6 @@
 };
 
 &i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
 	clock-frequency = <2600000>;
 
 	twl: twl@48 {
@@ -148,12 +146,6 @@
 			OMAP3630_CORE2_IOPAD(0x25da, PIN_INPUT_PULLUP | MUX_MODE2)   /* etk_ctl.sdmmc3_cmd */
 		>;
 	};
-	i2c1_pins: pinmux_i2c1_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21ba, PIN_INPUT | MUX_MODE0)        /* i2c1_scl.i2c1_scl */
-			OMAP3_CORE1_IOPAD(0x21bc, PIN_INPUT | MUX_MODE0)        /* i2c1_sda.i2c1_sda */
-		>;
-	};
 };
 
 #include "twl4030.dtsi"
