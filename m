Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+iT2z2jnIgaN5Qi+jSwMtUJjFIQfZi5W78c7u3n8V5ja4+gMPbMqwOz4b5iHZcGr5aHNQs
ARC-Seal: i=1; a=rsa-sha256; t=1524405849; cv=none;
        d=google.com; s=arc-20160816;
        b=QeYFSY0Tpwm1MJC13SMomVlSpaxRCCB2VkjI4dCy9RCn4IPOSZZ1PSTHRrWOe46Emd
         KebIsEIEH/59x5gMBRna3xmc57KhzuY7cwJDHYGfti1aDUGAACLw9rxljmSMflzDooUT
         i7+7R9ZMbkFmdw0iEIsA+E+WxzZRxxgTHFf1LFGQLYbJYRaRyvLmGBYx/Np1I9YKrKAD
         2o9TgQLST4pDktc2kf2RQ6smdW5xIEa2exTOGMV+2EOvQ5tt/UoTuHgLD28nlWvnaXzl
         eutItk8+p7c0nJxkmgFsRPsK3PA0p9TzDoIAzCVEYFg6bggq/5xF1BD02anJseGGKnXr
         TDtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=d7PKBzPTYwDreiliOcA38ht/lyS5/IAOX+nzHQ+xBnY=;
        b=GVN52xCug44OwGb/lbEe+S8QCq4Bcj6N+2ONz1zBkRWci6B/muxUkPor9224SIuKVT
         6dm/Uhff0z37V+B1tRlM1t8ANHAimuEkXn95DJ/Lw3z8u1gwz+sVRR1L7WvD3+rkeD71
         9BphbxuSAJ/n8fPvV1X0dOBLy6wKTBLVW0SeSX0OeRWIhsm2OkcDsEjCesLe3B/PzlLR
         FQeAxp/dFP4vf1PGuBUU8YZNwbaRQga5mROVYhovjIPaUenaAJb8r89fIXBUUB32AnDF
         MZztLDh9EWxLr97U0G/kV9AKxOtUg+NeBcYgAOwNTWy/oz8H3WdMidyKWXdXyycoBrJR
         aGYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Lechner <david@lechnology.com>,
	Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 4.14 020/164] ARM: dts: da850-lego-ev3: Fix battery voltage gpio
Date: Sun, 22 Apr 2018 15:51:27 +0200
Message-Id: <20180422135136.219605166@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455387797992514?=
X-GMAIL-MSGID: =?utf-8?q?1598455387797992514?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Lechner <david@lechnology.com>

commit c5a88cd2e1c508868922bafa0a5c3365986b98e5 upstream.

This fixes the battery voltage monitoring gpio-hog settings.

When the gpio is low, it turns off the battery voltage to the ADC chip.
However, this needs to be on all of the time so that we can monitor
battery voltage.

Also, there was a typo that prevented pinmuxing from working correctly.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/da850-lego-ev3.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/da850-lego-ev3.dts
+++ b/arch/arm/boot/dts/da850-lego-ev3.dts
@@ -178,7 +178,7 @@
 	 */
 	battery {
 		pinctrl-names = "default";
-		pintctrl-0 = <&battery_pins>;
+		pinctrl-0 = <&battery_pins>;
 		compatible = "lego,ev3-battery";
 		io-channels = <&adc 4>, <&adc 3>;
 		io-channel-names = "voltage", "current";
@@ -392,7 +392,7 @@
 	batt_volt_en {
 		gpio-hog;
 		gpios = <6 GPIO_ACTIVE_HIGH>;
-		output-low;
+		output-high;
 	};
 };
 
