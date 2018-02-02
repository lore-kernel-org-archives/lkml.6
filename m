Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225me5OmcIe76uc24RlX7OdpcB7ryaoSXOSZVTsWYV/X2QFkcX6bcQwMAlWOroyDGIhwcdwX
ARC-Seal: i=1; a=rsa-sha256; t=1517591560; cv=none;
        d=google.com; s=arc-20160816;
        b=N1vtaFrfPxeYtICgyrLRGBAMSIiYHOYWYNGp3C4o+WDtbd+cjp6PiINVyalCQHed+b
         WKLC5wA3KVULFY1Gx/jQx15mYcj6FzzztqNSmje/hIFz3yHBedkSfzK4l/tYo0KPhu6F
         OjO80BBNu/9TftEqD5h4sIRuocDFb8Aczr9k/oUO2ekSUY7zVBpanUfCc62raaPgUkGG
         kDoNWB18CPjcB1UNzWEA+DxphAZMU3ChclpMcC8kHy9dmAJOHcDzVqTQi1dEwi+u3fxR
         elgGCR3I3eknaK5f1Uc/sc/KjUi1fvx/DMX8fhHut6z6pJV/28UzDUs8tik2GVBL34ow
         S4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=m8D67AVjULjanNV+qYLtkjaF8ZVaZDrZBQbaxUJcgAA=;
        b=UydO3BDAnwvCjoUJgWeHNSYjbv0ZtdeXL6LuoKgpmOl1jd848bgSTC1aU1WoFRaVGw
         okOVe/S+lKJUnQiUooTbX2oplH+nbEkLqDk4tFl4ySV6tWRnTzHp18RPTZ+8r15YUhV2
         NQIgLj/wPb3iNhDsSm4jXjz00E/y2CKckGIXudyoi+ViVhfLLTPZefs7HhOtlob04+e9
         Vs/nrhms5K2Es2cWa1aWglpFW9HQWDZ84vwZaprExhnhaii6moCLLG6G9K80+koeG4d5
         hYpxL5yGz9cwlcSePaCM/KF8cusUPd3qv3hN9fl/MrWIJ/XOzoCtoC3/D6YZBOpbYWsO
         EBLw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jon Mason <jon.mason@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 121/156] ARM: dts: NSP: Disable AHCI controller for HR NSP boards
Date: Fri,  2 Feb 2018 17:58:22 +0100
Message-Id: <20180202140845.652050967@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310087606032393?=
X-GMAIL-MSGID: =?utf-8?q?1591310087606032393?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>


[ Upstream commit 77416ab35f5712382e5a792bfa1736ceb70d5bbb ]

The AHCI controller is currently enabled for all of these boards:
bcm958623hr and bcm958625hr would result in a hard hang on boot that we
cannot get rid of. Since this does not appear to have an easy and simple
fix, just disable the AHCI controller for now until this gets resolved.

Fixes: 70725d6e97ac ("ARM: dts: NSP: Enable SATA on bcm958625hr")
Fixes: d454c3762437 ("ARM: dts: NSP: Add new DT file for bcm958623hr")
Acked-by: Jon Mason <jon.mason@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/bcm958623hr.dts |    4 ----
 arch/arm/boot/dts/bcm958625hr.dts |    4 ----
 2 files changed, 8 deletions(-)

--- a/arch/arm/boot/dts/bcm958623hr.dts
+++ b/arch/arm/boot/dts/bcm958623hr.dts
@@ -141,10 +141,6 @@
 	status = "okay";
 };
 
-&sata {
-	status = "okay";
-};
-
 &qspi {
 	bspi-sel = <0>;
 	flash: m25p80@0 {
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -177,10 +177,6 @@
 	status = "okay";
 };
 
-&sata {
-	status = "okay";
-};
-
 &srab {
 	compatible = "brcm,bcm58625-srab", "brcm,nsp-srab";
 	status = "okay";
