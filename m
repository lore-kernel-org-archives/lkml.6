Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtp3viXRyzctaLIKfKKeEnJO4ErmB8UajeKvpsMI8H9xsJe79pboSqUgKdDOU2KAbQXZJE0
ARC-Seal: i=1; a=rsa-sha256; t=1520451837; cv=none;
        d=google.com; s=arc-20160816;
        b=s7WdSPwggCEB/HBzeVwaR44X8vbHB52Vy9H/9v2+HyBfWk9qTX4XvTrcb7f3TrBKCF
         Nld7qZ2Vq9sMkB8doQMfxd4Uwa8MgZQmGNXQpFRfX/Sgj9hhq2l4OkUz/UYQZgxrSa2J
         n5OYqAxhHUpCJ5Q1BSCUQCZOu3ahjAXebYYW3P+rKDZ650m6qYBUaBmVjy1M9RTLwGhv
         9tf1g4XfohzqS3TtfZkheSAjJXMRwr+bGBzFOAHPYx7agNyiYzkAXC0gqNQ2admrGTDC
         PCtOexquEHTSlkv+sJeqj/ZkNoo+yuVXVRPHmmsoLFpvnzwvA5YQv+tiSM41KOXOs3Au
         CB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=U5d6lEHUB+vPMUr4bYXAobCRnstI6goSLsS4Rv01xUg=;
        b=maaL8W0i2JII8+ZIH2CBddTTQt54Mgij2FlP6fiUEJ5zqCnHNpMVzqdbjCVR4mFkPU
         VKLOY1LryM8mPedCLdDUuMi2tnb7pefc0epZA7BOjbDgHFSsxIBuI6GfuUgmZBMWBnsP
         m6Y+zPWJZLGFsTCVo+0VabGc2cortN/ERdQhUiORPdNCp61ZhQU27sfnGRXPVOJMezL9
         elVmmhUn4+oYuyZffo6jfafwPKPRksNwdqFSAl6BOAfBoaxbYr3WEcOTsSEPAthVXjrM
         YgVTZz+RyKltQgczpNy8QpTuqLoeNuXDWkwTl08yivDdFtFXKQQ4NpUo/fMPIlce+gV9
         ERfw==
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
Subject: [PATCH 4.15 109/122] ARM: mvebu: Fix broken PL310_ERRATA_753970 selects
Date: Wed,  7 Mar 2018 11:38:41 -0800
Message-Id: <20180307191745.395018374@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309306231843406?=
X-GMAIL-MSGID: =?utf-8?q?1594309306231843406?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
