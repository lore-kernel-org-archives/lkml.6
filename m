Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x224Od/j6hUrL6+bBnvOWJTsanqGyCD5aE4qDiOvLXnDlgxBcKpmXCO2y1xEaERhhw607POZj
ARC-Seal: i=1; a=rsa-sha256; t=1518513245; cv=none;
        d=google.com; s=arc-20160816;
        b=emfCkp/gdcjtm17fubBpemhwufajmjVGqcUN6VBQ1hu2T0xDqfV418zrhyQloS4XeD
         tDwVC7rI+7iAaoxtuC8dMFszFGPauET7OTqqiCXhyT+Yd+9WgLUk3Mm+WcLJRICGESHv
         9YccSpYcmIXHdWudJNs0mQnHpz6ilzYwfsF1Wtg4aP4OLY2svbTZzvASLaM0ihMUiVvi
         vwwu/xVQZAVqzBGEHBlfli4NgJvGEdSfb+n0cgReZzDibOi2MzQDYEjLdmH37PioU+6f
         d5NXxGfQ/w+uzhbSBOA4EGnIlRNK6qY2zax4UWbxywD0FqzzTmi4Q9VucyA8lRn/k+pU
         nDfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=y5mbxZOYQQ4AVEZvDUFI0Uga/HGVLkXVYf5c87V96KM=;
        b=kL4hJES7662iZEXkkuXOvE/dLepKW5PiVgQWp8o+eS4ekKYciCGNatRYBOncpi6Xjn
         W3bxQOowI4VXNCvJdpweeVywhVllrcPajsrLtSTVkW0Y0DDBwqbMcbPU/ilBpBh6EgtB
         HBe1/U+3rU4mM78nexEl1CPcExeU2WBMh+7UQsL+YkoClS4IAeb/iyOjq7RBVTFiMrrz
         /897T+ibzi+byLY+CgMDOx90oPq9i98nBUEXo3AeJO2v+5j+xnwIsLEOCwwJalVLpoGM
         xwZGUfhm4C5TPWPZQQmBJz37DUTmkaqt+CKttawzC610upL9yGQwf4hm6C6bVJ6dE8oM
         TBfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Tue, 13 Feb 2018 00:57:55 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for David Woodhouse <tipbot@zytor.com>
Message-ID: <tip-d37fc6d360a404b208547ba112e7dabb6533c7fc@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, dave.hansen@linux.intel.com, dwmw@amazon.co.uk,
        bp@alien8.de, jpoimboe@redhat.com, arjan.van.de.ven@intel.com,
        dan.j.williams@intel.com, mingo@kernel.org,
        torvalds@linux-foundation.org, arjan@linux.intel.com,
        tglx@linutronix.de
Reply-To: hpa@zytor.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org, luto@kernel.org,
        dwmw@amazon.co.uk, bp@alien8.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, arjan@linux.intel.com, arjan.van.de.ven@intel.com,
        dan.j.williams@intel.com, mingo@kernel.org, jpoimboe@redhat.com
In-Reply-To: <1518449255-2182-1-git-send-email-dwmw@amazon.co.uk>
References: <1518449255-2182-1-git-send-email-dwmw@amazon.co.uk>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Correct Speculation Control
 microcode blacklist again
Git-Commit-ID: d37fc6d360a404b208547ba112e7dabb6533c7fc
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592276544846443221?=
X-GMAIL-MSGID: =?utf-8?q?1592276544846443221?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  d37fc6d360a404b208547ba112e7dabb6533c7fc
Gitweb:     https://git.kernel.org/tip/d37fc6d360a404b208547ba112e7dabb6533c7fc
Author:     David Woodhouse <dwmw@amazon.co.uk>
AuthorDate: Mon, 12 Feb 2018 15:27:34 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 08:58:59 +0100

x86/speculation: Correct Speculation Control microcode blacklist again

Arjan points out that the Intel document only clears the 0xc2 microcode
on *some* parts with CPUID 506E3 (INTEL_FAM6_SKYLAKE_DESKTOP stepping 3).
For the Skylake H/S platform it's OK but for Skylake E3 which has the
same CPUID it isn't (yet) cleared.

So removing it from the blacklist was premature. Put it back for now.

Also, Arjan assures me that the 0x84 microcode for Kaby Lake which was
featured in one of the early revisions of the Intel document was never
released to the public, and won't be until/unless it is also validated
as safe. So those can change to 0x80 which is what all *other* versions
of the doc have identified.

Once the retrospective testing of existing public microcodes is done, we
should be back into a mode where new microcodes are only released in
batches and we shouldn't even need to update the blacklist for those
anyway, so this tweaking of the list isn't expected to be a thing which
keeps happening.

Requested-by: Arjan van de Ven <arjan.van.de.ven@intel.com>
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
Cc: dave.hansen@intel.com
Cc: kvm@vger.kernel.org
Cc: pbonzini@redhat.com
Link: http://lkml.kernel.org/r/1518449255-2182-1-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/intel.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index f73b814..ef796f1 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -116,13 +116,14 @@ struct sku_microcode {
 	u32 microcode;
 };
 static const struct sku_microcode spectre_bad_microcodes[] = {
-	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0B,	0x84 },
-	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0A,	0x84 },
-	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x09,	0x84 },
-	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x0A,	0x84 },
-	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x84 },
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0B,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0A,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x09,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x0A,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x80 },
 	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
+	{ INTEL_FAM6_SKYLAKE_DESKTOP,	0x03,	0xc2 },
 	{ INTEL_FAM6_BROADWELL_CORE,	0x04,	0x28 },
 	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
