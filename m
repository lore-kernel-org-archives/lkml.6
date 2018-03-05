Return-Path: <anholt@anholt.net>
X-Google-Smtp-Source: AG47ELuN+otfy6HTZ4RgoVEIxWnzRyx0w4Di/8XPTiw+bZ9dDDm27/vzJmGlut7eI0+XHraApbYd
ARC-Seal: i=1; a=rsa-sha256; t=1520281691; cv=none;
        d=google.com; s=arc-20160816;
        b=Kif17ImILcyZZoWGHjEJQquQevRUJlCH3fvqMb5LIT1ud8iRSZlgofoGdwA02ax8J6
         KYecUr0Ep6pub5TyNo61Hz/2w6647NLcOcukT8g66ycVLDHHKQzo1/2LuI8NX+CEjLdq
         HkrOOXPxpjsBCvLidenmHatqh+7lW9zcNHBA5Qeh8xp7eI16hDqgLatD6APVBqJv8Ukx
         Pw5daH3lAL6DmJJC2zxRJbBVWkpJZTJeT7VgyXXRyPdL4VVdrTTPxTZUTp9ViPXpv0KB
         2I6S3eD2INM+rAYb1yjXIVFBpERDuCEz39rE6xPyMgAWNvYIvIJQ6HcvcS57yhoxWRDO
         FCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=vyNNJhZRjullx5ep4cF9f5D6/F5kGWtLh7YimvOTeFc=;
        b=LOjQrbEA+4nwPTDRiYDnOiY6OTm3GH0B8e3TvwK0se/Lvogyg3vwHdJXpXHHdg6fwP
         jiVST91FLM5UjUi9LjwuOxCx9e5U0LbrfHv6CLTdd8516iM6lm+MU2Jw7FQskALQ2P1B
         1I8suLBTJ8SSg0ZsSDftVVtzg75oR+T1aOGKnEYAkr3Kmdl9UGp6EKIp0vEWyXrbWjnu
         mIWrV30Gbs25wFajbHnF9oNJsnZsa36vh06ilr3vpVeP5B40QwoMvEasVsTnZpQrxGqz
         k6wRpgokewgl3dokONspS9lEmex3USkYOOfNnP5NyLYtGyu7OzTLrRqHdEr5h3UZ8zDQ
         OX/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of anholt@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=anholt@anholt.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of anholt@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=anholt@anholt.net
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Phil Elwell <phil@raspberrypi.org>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Eric Anholt <eric@anholt.net>
Subject: [PATCH 4/5] ARM: dts: bcm2835: Add VCHI node to the Raspberry Pi boards.
Date: Mon,  5 Mar 2018 12:28:05 -0800
Message-Id: <20180305202806.21219-5-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180305202806.21219-1-eric@anholt.net>
References: <20180305202806.21219-1-eric@anholt.net>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594130894529119956?=
X-GMAIL-MSGID: =?utf-8?q?1594130894529119956?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The VCHI firmware communication channel operates in parallel with our
other mailbox-based channel.  This is the communication channel that
exposes the firmware's media decode/encode and ISP interfaces.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index e36c392a2b8f..c128bc6a1435 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -27,6 +27,13 @@
 			firmware = <&firmware>;
 			#power-domain-cells = <1>;
 		};
+
+		vchi@7e00b840 {
+			compatible = "brcm,bcm2835-vchiq";
+			reg = <0x7e00b840 0xf>;
+			interrupts = <0 2>;
+			firmware = <&firmware>;
+		};
 	};
 };
 
-- 
2.16.2
