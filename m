Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsgP5KUOxhgbzaRpRMylk9lSkTYWajTrokSyXLtnDGXU/Rg185wGbKsc4jDRu8GjjibPg1D
ARC-Seal: i=1; a=rsa-sha256; t=1520452107; cv=none;
        d=google.com; s=arc-20160816;
        b=IL8PgecCmz0Pi6y1tJhhYjLorL3h/bxqQRXtFQrG9of5CMw/8Yqb1+/8D0eNpxfQ9n
         7ARjBceThUQ000yTQgxiCcNJXCX9qRaAo5dXUizNk/NOq6NvAh9XA/IKO2L4s/Z1/AyZ
         JWbkHzin9f6KkA0L3TMO+7luZHZ/TPq86Rd1XlREaLfCaMV1qwx8komit/Dnp3j+0Dt1
         PskxmrThEmB24CF3dno+WhTEYIxEd6XdJtq0rT4jbwSNEeG+IArCr16Dye6ltDterDM0
         CV1qIlG4vjep04u9D7UDZ8U0/0S+Q82VV++4vv1qS20oWqy9slsVKh26xvDWSf6LiHSH
         cqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ux05kFeKJl2LY6uSu+kCi/tiyMWggeRXiyp4Rfk6Vho=;
        b=wOP2My2aU9d4X6WzS8MAIHNcsTlX5PD83K9B/OWSjjDF5ykC2vvaxffHODg7VrePxE
         N4ZaCSrVTuMCBz/7w85EQtAd3q0/x+BLhEo1M/9gnHl67OH6GpctoQgOAw3kfcL/VfU4
         LBU1EPNYSZXgOxsTnYNiv/v/hS78yujelxG9N1P+JghHtxXbQ0OFVDDolf9tX6aoyqYo
         qYeHPjXxyg5N44A1t50eLhWtYW579k7Yw7e2In9Hxhtib1xaPPod7VJTeBGUCf+p6yvz
         Hooc+30yOTN9/Aoth8gkaH+z+v6zTWEw9ZzGGox6qVYz4kzpZSW0UM0iXUl2TxkWcaWB
         WhKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ulf Magnusson <ulfalizer@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 4.14 094/110] ARM: mvebu: Fix broken PL310_ERRATA_753970 selects
Date: Wed,  7 Mar 2018 11:39:17 -0800
Message-Id: <20180307191051.881924486@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309306231843406?=
X-GMAIL-MSGID: =?utf-8?q?1594309588793633164?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ulf Magnusson <ulfalizer@gmail.com>

commit 8aa36a8dcde3183d84db7b0d622ffddcebb61077 upstream.

The MACH_ARMADA_375 and MACH_ARMADA_38X boards select ARM_ERRATA_753970,
but it was renamed to PL310_ERRATA_753970 by commit fa0ce4035d48 ("ARM:
7162/1: errata: tidy up Kconfig options for PL310 errata workarounds").

Fix the selects to use the new name.

Discovered with the
https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
script.
Fixes: fa0ce4035d48 ("ARM: 7162/1: errata: tidy up Kconfig options for
PL310 errata workarounds"
cc: stable@vger.kernel.org
Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-mvebu/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -42,7 +42,7 @@ config MACH_ARMADA_375
 	depends on ARCH_MULTI_V7
 	select ARMADA_370_XP_IRQ
 	select ARM_ERRATA_720789
-	select ARM_ERRATA_753970
+	select PL310_ERRATA_753970
 	select ARM_GIC
 	select ARMADA_375_CLK
 	select HAVE_ARM_SCU
@@ -58,7 +58,7 @@ config MACH_ARMADA_38X
 	bool "Marvell Armada 380/385 boards"
 	depends on ARCH_MULTI_V7
 	select ARM_ERRATA_720789
-	select ARM_ERRATA_753970
+	select PL310_ERRATA_753970
 	select ARM_GIC
 	select ARM_GLOBAL_TIMER
 	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
