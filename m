Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x225WI7Bnuu5cpXxV00ez6YEoj4g6JutrrpQClU1VdsUoLY2Zt+KPvusv4GvJt5l/14Ih3o6T
ARC-Seal: i=1; a=rsa-sha256; t=1518401216; cv=none;
        d=google.com; s=arc-20160816;
        b=wANCO2zOIfwmXzXFGdPv6BK6XTqfOlwQbtdc5/xTVZ2lVvyd7RrbFOHDPX2b0D+pQ6
         eOyloqwq5+XtdlpoTR9hggCj3d7MyKxb5Z8UyQyYBIogU5cPgdQzTktrJnguzm+G4saU
         XnMEUTsO8i2H9SUijSmK+jfYFMJUJoX0O5J/AVqILNTQ+1ksbMIqswFCV2bn86J13dGy
         b1HIu0YrasnVL77f0I2aUCfp75ka75dBmKnpnioi8pfC2dNqPvmj8mZXi18yhZ0KxuUg
         hapoGixGPEX+oJ6iJJ0S1Js8XX+1ELRH+4KTzGvrTXRJWTEKnfsPoopYeon+PLbP5NpV
         N2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=UtgFQr7rXxTZv+M6e6M66Pgsq58qLUiPi5yGqXWyulg=;
        b=SFHqUk2LgnvYSHDf7D9vKsDG6ySBXgaopYHnGLeOt+hN0osGhfumKF6LP5O3Sugt0/
         mTEbBqCeoTLJmiIa5mnzU4GBXpivj0KFD+gXKsm5gXN+sKAetuYIh7ltO89wmX0uzIG6
         BDBfcgt6cxCeLez6XcYqLBq73pTm4PYzcDGpkFVj+fxGzlSPKRBidoAt3vhJnE95Unx2
         lBG7NVPYSPAz5PdKkmUcemnZ8mn9P8xf4NPI9DNFqyhyKK06FBPp+y13FWMK4mP56qOG
         NE0nZwXgFMYerTzb8zsTjNjA9HECEbwerb1ZVK9LxRJPHdopeYo6S1khT4vS/KwfHviK
         5nrA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Sun, 11 Feb 2018 04:08:57 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for David Woodhouse <tipbot@zytor.com>
Message-ID: <tip-1751342095f0d2b36fa8114d8e12c5688c455ac4@git.kernel.org>
Cc: peterz@infradead.org, jpoimboe@redhat.com, gregkh@linuxfoundation.org,
        bp@alien8.de, dan.j.williams@intel.com, hpa@zytor.com,
        dave.hansen@linux.intel.com, dwmw2@infradead.org,
        arjan@linux.intel.com, mingo@kernel.org, torvalds@linux-foundation.org,
        dwmw@amazon.co.uk, luto@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, torvalds@linux-foundation.org, dwmw@amazon.co.uk,
        tglx@linutronix.de, luto@kernel.org, linux-kernel@vger.kernel.org,
        bp@alien8.de, gregkh@linuxfoundation.org, jpoimboe@redhat.com,
        peterz@infradead.org, dan.j.williams@intel.com, hpa@zytor.com,
        dave.hansen@linux.intel.com, dwmw2@infradead.org,
        arjan@linux.intel.com
In-Reply-To: <1518305967-31356-2-git-send-email-dwmw@amazon.co.uk>
References: <1518305967-31356-2-git-send-email-dwmw@amazon.co.uk>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Update Speculation Control microcode
 blacklist
Git-Commit-ID: 1751342095f0d2b36fa8114d8e12c5688c455ac4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592159073916026557?=
X-GMAIL-MSGID: =?utf-8?q?1592159073916026557?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  1751342095f0d2b36fa8114d8e12c5688c455ac4
Gitweb:     https://git.kernel.org/tip/1751342095f0d2b36fa8114d8e12c5688c455ac4
Author:     David Woodhouse <dwmw@amazon.co.uk>
AuthorDate: Sat, 10 Feb 2018 23:39:22 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 11 Feb 2018 11:24:15 +0100

x86/speculation: Update Speculation Control microcode blacklist

Intel have retroactively blessed the 0xc2 microcode on Skylake mobile
and desktop parts, and the Gemini Lake 0x22 microcode is apparently fine
too. We blacklisted the latter purely because it was present with all
the other problematic ones in the 2018-01-08 release, but now it's
explicitly listed as OK.

We still list 0x84 for the various Kaby Lake / Coffee Lake parts, as
that appeared in one version of the blacklist and then reverted to
0x80 again. We can change it if 0x84 is actually announced to be safe.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: arjan.van.de.ven@intel.com
Cc: jmattson@google.com
Cc: karahmed@amazon.de
Cc: kvm@vger.kernel.org
Cc: pbonzini@redhat.com
Cc: rkrcmar@redhat.com
Cc: sironi@amazon.de
Link: http://lkml.kernel.org/r/1518305967-31356-2-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/intel.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 319bf98..f73b814 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -123,8 +123,6 @@ static const struct sku_microcode spectre_bad_microcodes[] = {
 	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x84 },
 	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
-	{ INTEL_FAM6_SKYLAKE_MOBILE,	0x03,	0xc2 },
-	{ INTEL_FAM6_SKYLAKE_DESKTOP,	0x03,	0xc2 },
 	{ INTEL_FAM6_BROADWELL_CORE,	0x04,	0x28 },
 	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
@@ -136,8 +134,6 @@ static const struct sku_microcode spectre_bad_microcodes[] = {
 	{ INTEL_FAM6_HASWELL_X,		0x02,	0x3b },
 	{ INTEL_FAM6_HASWELL_X,		0x04,	0x10 },
 	{ INTEL_FAM6_IVYBRIDGE_X,	0x04,	0x42a },
-	/* Updated in the 20180108 release; blacklist until we know otherwise */
-	{ INTEL_FAM6_ATOM_GEMINI_LAKE,	0x01,	0x22 },
 	/* Observed in the wild */
 	{ INTEL_FAM6_SANDYBRIDGE_X,	0x06,	0x61b },
 	{ INTEL_FAM6_SANDYBRIDGE_X,	0x07,	0x712 },
