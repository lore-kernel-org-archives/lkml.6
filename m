Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsLBcjNoehQwy1w09bg6BfeZQko5xudzca2CjkfaUHP27yXtEtLbX2+ALUSHAhD0FeQZAT8
ARC-Seal: i=1; a=rsa-sha256; t=1520641144; cv=none;
        d=google.com; s=arc-20160816;
        b=IX1jpPio4eBIkY/aQnmSCFba1lY8WWPnzffsTcaggSp5YhTz8SNlUJyeYkIoaWab4S
         yfYBufW2Eq+nQECovsmd7Js41O32FdSvNoWrL59EHg9jS3dbWFXCznzp9OdXi9k6oiTz
         W99g4yxVYchrfdHR9tkC0qhLSQylj0v5/IxI1ZlF8S8c13d2fu8Kk8MmDhZrrSGvSbcI
         rkDFHOcI1YughklkCOa4XsUNGuZIkW6fTI7DxkDIPxK+UjPEcodRpvOPwqovOmPu+TwX
         2D/K/tGHBclaXABQpu2+pZD2ku1tw8NhGnAdElTF4PRVho6iPBpkrTi+/7cPUQR33hOB
         HPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=24LJ6GZeRb3Qc1aj3ss7AzvP4yb0t35p5uk7iTHNYGU=;
        b=QkEZVP8mJrnReQcNZ1QlHFzUpBGRZ+6INw0dRl06Jzf2Z4Ye3THofsOtqd07RJghUj
         NpUJMND/mjk9P4S/tWyADaf/50v+iELfiy1gzRstty79Yn/0Lpoc/REy0mE1e6ey9ard
         8XgPVL67bqptUFmS7jmNS3bQWWz4Ak+VgRU9r41s+OyCvhdKpWq83OOp2OrHjq5xAmCI
         iF95jUpkiG1Kuhyq5mdC2w2lJ25Ol316Tw6bbdoXZXCikwxH2apDnYihlcYbmhyGdmpK
         Wujq/6m5zl9DQX+QC+cSRkEpGOka6kdFqGhLeNccKuCoGs80J6EKQcNqW5lSrX3r2rdT
         kXZg==
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
Subject: [PATCH 3.18 05/21] ARM: mvebu: Fix broken PL310_ERRATA_753970 selects
Date: Fri,  9 Mar 2018 16:18:27 -0800
Message-Id: <20180310001801.364995678@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001801.045114869@linuxfoundation.org>
References: <20180310001801.045114869@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507808977901535?=
X-GMAIL-MSGID: =?utf-8?q?1594507808977901535?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -37,7 +37,7 @@ config MACH_ARMADA_370
 config MACH_ARMADA_375
 	bool "Marvell Armada 375 boards" if ARCH_MULTI_V7
 	select ARM_ERRATA_720789
-	select ARM_ERRATA_753970
+	select PL310_ERRATA_753970
 	select ARM_GIC
 	select ARMADA_375_CLK
 	select HAVE_ARM_SCU
@@ -52,7 +52,7 @@ config MACH_ARMADA_375
 config MACH_ARMADA_38X
 	bool "Marvell Armada 380/385 boards" if ARCH_MULTI_V7
 	select ARM_ERRATA_720789
-	select ARM_ERRATA_753970
+	select PL310_ERRATA_753970
 	select ARM_GIC
 	select ARMADA_38X_CLK
 	select HAVE_ARM_SCU
