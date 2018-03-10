Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvohDLcLzffq16AZoitAExX8/BCxDgFwy7pdMHic+0WBu00kYeAWsmij0QE7Wb96Ppl2VDH
ARC-Seal: i=1; a=rsa-sha256; t=1520641280; cv=none;
        d=google.com; s=arc-20160816;
        b=gl05H+UFIiWZBzu3/J0hyJfOhqzANuhruoJrajZt6sBaRJFQ+c2xoMBaBqNQP4n0dD
         llnADKvAA+uvDUiWqJuGvfQMV4clbc1ZEY9Inon6PlYMZuIIUBqxn6qQqRol7FOXiNZ0
         o6mAkKarjMUk5xmj64PDYmu3HBoqX+c6USJFytSuFh878DN0s6Nf2NvLTplkBaiu0yc/
         CTdQQlA03BME2dQ+5OgnXjVTeqm2/8WIwi0e31dhnrFoQ9WwXrlRnYMR86w5MsjPrV+W
         +uCAR59dRqCey0/KXJ7GMjEceAOUecRDEi5ZGqsTWGXRhYKCUAnrZZMh6g8gZdzE1e8u
         ne5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=elGn7FiP2R+0+E5dfCM7welKy8gxZFtM/Y625z532wA=;
        b=OxXz7HVxRbrqiLYab2h8wgrb+RUXvPoPqSlegzpZ5BTfiTz+wvsfjjZ4aCdEfOEphB
         6m8UM1duK2wTt6HgZvMm6lpgOsFJT9AaVMLiY19YLtlCKX6VHZ/LuJeexogM6mQZ2YUh
         B8M+8/YMsihxWfkskCNcEgPMkeTjhOuIDPB2TNeLpMyEMcm6bx2qBBYa/3XLAax2gpof
         1g2XP+E9kfRra6ahMEPQQ4p1c+spyDbTan+Yvc0FQPm6vpt8tHKROlsQ+xlyS3oUnwbN
         MMb/5QUL43bntaVML78bevcYPAKh56X9eyriIBlQYhVfJxta8PpzAZ3LHjYE+IGeeuls
         ZAYA==
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
Subject: [PATCH 4.9 19/65] ARM: mvebu: Fix broken PL310_ERRATA_753970 selects
Date: Fri,  9 Mar 2018 16:18:19 -0800
Message-Id: <20180310001826.491019325@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507808977901535?=
X-GMAIL-MSGID: =?utf-8?q?1594507951181930339?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 	select ARMADA_370_XP_IRQ
 	select ARMADA_38X_CLK
