Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtXQ6B2p8fECkj9ouq0rDHAT2nwX7+6p8oVxQQExml/cg8HLFMB9bKf8wCsWta/07SdpVDq
ARC-Seal: i=1; a=rsa-sha256; t=1521483971; cv=none;
        d=google.com; s=arc-20160816;
        b=jW4ZSSdNNKVL+fsu+fYj+CNhaMyJ+1sTwnK125bU1+w6nJBowjH4JLZ1/6BM+veuL+
         VvjKagdUaqrg9R3mOOGNkj1yvm0tgaGFNdtnlHQMgxOhmCIY7YNewTLyNYxrhz+4UUeY
         qsY3vp11N20YYwYn0LeV/+Q23a+J/d/m0gpf472st7/RpSI1m5m/VZdqoLN8nlPHHnli
         91UTWLx07NEJdxGA1vbjpcmj4FmrQR0RqdMqMafL7OVny5flFDucNOSV1zZrg+hTvMK9
         WOZP5J6OmvP1w2e9Quhy6ORuyoEYQDN2KnMca+6jDMAJ2R4HutPH+nwEFyO4wogSfp0b
         LPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=f5Iv/aGYr374dkvjniZMBbfHWMSGOyjBB1Qi2usa8so=;
        b=VGyfD7nFCQnaEeZfJXfrYhN0IpbSj9hxSG7Znpg28ollRnYgIcAoCrONtvBozgTppN
         VzyAMKgHnGRrYxOQKpU8I5xy8kRPNmWUQ5l9pv6xp4Shu/A3dNcuKB/jEdo8aSba9/bt
         zdPusxJwWcqotXYkGrZMVGp7StkWoyG2MjnR56Pm+w6CI47lTRW3iUUeqj8g5Gd+7Zub
         iwu8tYcW9RJ/T2Rwa0/9GJ7MyGrx0425YSTEm7WPrPtnBpgNkYNli9Ql1PoYZucTHRBs
         QKTubCdvD43q2hw/23fOv5TEdzIl5gfy6PCIvVf+qB6XcLOMN78qBWgw6k0/0yI6kyQT
         oR4Q==
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
Subject: [PATCH 4.9 177/241] ARM: dts: am335x-pepper: Fix the audio CODECs reset pin
Date: Mon, 19 Mar 2018 19:07:22 +0100
Message-Id: <20180319180758.487831876@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390605554403205?=
X-GMAIL-MSGID: =?utf-8?q?1595391576909583392?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Andrew F. Davis" <afd@ti.com>


[ Upstream commit e153db03c6b7a035c797bcdf35262586f003ee93 ]

The correct DT property for specifying a GPIO used for reset
is "reset-gpios", fix this here.

Fixes: 4341881d0562 ("ARM: dts: Add devicetree for Gumstix Pepper board")

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/am335x-pepper.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -139,7 +139,7 @@
 &audio_codec {
 	status = "okay";
 
-	gpio-reset = <&gpio1 16 GPIO_ACTIVE_LOW>;
+	reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
 	AVDD-supply = <&ldo3_reg>;
 	IOVDD-supply = <&ldo3_reg>;
 	DRVDD-supply = <&ldo3_reg>;
