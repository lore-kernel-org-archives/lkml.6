Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx492NU8Mw1hmzhxC9PxyVMzoheu1RVIMYpLjPZar/e0rCSW7itMIF4VQNX6+JThZ7g69aC7o
ARC-Seal: i=1; a=rsa-sha256; t=1523022219; cv=none;
        d=google.com; s=arc-20160816;
        b=kAfOmUOByXcR87Sw3AiPCWfbxPXx1e1cw9qDZY6lCPA3+JKXRxNb7Jk4wWhM91uOsW
         XXMyfuuiAF3l9DVWE5qoxxIMtrWUdYcm2fiF4ubQjMzgSc5FAAeUmT3buTjBCNziKCf4
         PNUlhYkKnbA2KR3sKkqsprp8fQXCumpCSQTQer0G9kTLrI8O+YmkiLyoesem6WrnPFlV
         4nSFMnOm0DrDPAVR/AoEOLx29vubsOsoh5bkriqOaZRCnQdCIQYRp0QrE35T9vp3WBil
         s524lr2DK4mMVCzYhJ1hZqFkiA7jGo8Gdd2Yuof5oouFeOiAbN893heUJ83jEamIbVGC
         w0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xjqPx+2WwZnB+T9YdZBO+pacd6iBcMN3hBmQ6FUAURQ=;
        b=0lP87zZgac+pIS3WgC2hVf7LKExw/QSjQod34HnnldHWe2Vhq4R6tB/vOlPfhKd+P4
         Cc/9FLMPp42IA0MAFh2QJ/2iWUkkI32+xK3qZOnAhEg0a4a216A3JBIKM6hrFVGesB8z
         AjFJVjFp8lNcnDnAZOOy2t0nH7+kXMiVUeKLpuT/J7P5BuGnIC2objxnbJ/sTdd5vjEa
         mEf9Q3h/rx3Xwr0aC+sFRpiptbD9EBnOrC+BWnuye6zxAgQpJP0r4J40bA3iefqdJ7Q7
         NYKA2EFwQZhFZYiwRVg6edNa/hM92R9fB4q4jHs9+60GT3K8uAOrF8OtfLDNl12Nmd/Q
         7H9w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	"Andrew F. Davis" <afd@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 69/72] Revert "ARM: dts: am335x-pepper: Fix the audio CODECs reset pin"
Date: Fri,  6 Apr 2018 15:24:44 +0200
Message-Id: <20180406084353.980933260@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003618153570477?=
X-GMAIL-MSGID: =?utf-8?q?1597004547609465529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit cc578825b46e984c19b4a4630d3191d60ff83642 which was
comit e153db03c6b7a035c797bcdf35262586f003ee93 upstream.

It requires a driver that was not merged until 4.16, so remove it from
this stable tree as it is pointless.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/am335x-pepper.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -139,7 +139,7 @@
 &audio_codec {
 	status = "okay";
 
-	reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
+	gpio-reset = <&gpio1 16 GPIO_ACTIVE_LOW>;
 	AVDD-supply = <&ldo3_reg>;
 	IOVDD-supply = <&ldo3_reg>;
 	DRVDD-supply = <&ldo3_reg>;
