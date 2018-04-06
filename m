Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48tr4Ek0Q9qcRWacUsH98dbgyOThnyyPLmEr4k57ORudzJjaVH42GPcwRpckRbf/6JBR8Jq
ARC-Seal: i=1; a=rsa-sha256; t=1523021791; cv=none;
        d=google.com; s=arc-20160816;
        b=npsMGftm2AB0tk0cvPwFV4lBUqV8IJ9bi5Eo9eTJoKZpTAaJCuDfFVsaMeG1vOUSEu
         BObW21WBmkWU3RAX5+s/2KjU6vvDdNDx6u7fuquto+6FSDumsAYpBCWsdfsoWt7MrlL5
         P/z1oXcF1P1PiUhUmAD3bMPiMHXUiCFTeXtWlS5iHB/Dvtj64gKivZqg0m2thf9663Ur
         LUCkjlERAxptepSvgTPuz/h6ts8DgjQyw0eXIdmODVk76+o5o61cQzbAucoBzQgZ5OwI
         NhVvR3XCcAi7E8b00bTBVGlky+Yrdv9y94c5ZAD7j5ItuszpiizCrd6PfuEwquGYtZlM
         ZD7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SonQedz1RQdFIJYa1QcKngWhobPxmJeK9e/gdDR1wkQ=;
        b=COfIyg6M5FS772BdTEJCqn+rqoPBURdWIRebnR8FCsVL3lXvWOAWKxY8ysXGpn3Ana
         VBTjtlBLK0UVQHb2WDhNynQl+/xy7BVdeXuuWtR1aBBkeHHWKAskA4V6ctrM3Ru5Zo3T
         Iac6jdsMAlfu2uS+zcQvFmsLWxB3C66afVddjmh+JD+ZkyC6ZroAv1iAMAaLm6nSFU1b
         Aoo105mL0lILpjebKrOevOEhWijJ01yKk9dZV9/DRGQ7fl9Xc6tq3xvEQJSsb1ckMDUR
         6Amaj5Zjv2bRF0h1i/eDAfepjFomMGWqcBXRZRIs4V/+xt69CYivT/27PHuUttDC93RC
         Ii4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Keerthy <j-keerthy@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 092/102] ARM: dts: am57xx-beagle-x15-common: Add overide powerhold property
Date: Fri,  6 Apr 2018 15:24:13 +0200
Message-Id: <20180406084344.451562692@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003794128655610?=
X-GMAIL-MSGID: =?utf-8?q?1597004097895678742?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keerthy <j-keerthy@ti.com>

commit 1f166499ce006b3770a3166122eda64e160736ab upstream.

The PMICs have POWERHOLD set by default which prevents PMIC shutdown
even on DEV_CTRL On bit set to 0 as the Powerhold has higher priority.
So to enable pmic power off this property lets one over ride the default
value and enable pmic power off.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -204,6 +204,7 @@
 		interrupt-controller;
 
 		ti,system-power-controller;
+		ti,palmas-override-powerhold;
 
 		tps659038_pmic {
 			compatible = "ti,tps659038-pmic";
