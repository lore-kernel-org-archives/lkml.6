Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226+jbW58I/uy3qJGl/w08TQqX62EO5hOyiBNvBztu3QCIiDyDvzZ/XqzSGgcNz9dlbfCa1J
ARC-Seal: i=1; a=rsa-sha256; t=1519217867; cv=none;
        d=google.com; s=arc-20160816;
        b=Bh9Y/muFoWVuwKt39Jnqu2nsgis52DjETYmQPA7yU/xJS3a+INcb8KEAHrjiWiKsT1
         vBztxwzWuVRHOnnUB9G0PShlPT8PzMtJTs05f+yr7fZ27CleMnZmQ20JNLX97PIz/8nC
         Ww0J8QHsCbLxZZh3Waam/x/rejCly1e6o//ON6PRVH0xm8TeKsa9DHj3UUh6Jr2+DHh5
         5Xuvyw3Laaa4EN/qf8nVPXfE5MQqJXMPurSK7dh3PHjWWpKQbdpfBCy2NXFXKHKyp41D
         yZsYfTurl5fszFiEgKNssgK2ibK6Lb2FXOsCNCcVPweN/Ce8yVPHsMdwcgraLGNiun19
         cFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Irj6y3wSMtrIE0P3XCKtVI0HLeQpNa2Pj45sv1TmTOs=;
        b=Nc+JnHF5pbAaYKoF4CRlrGWW8YAL5SNUX+rEDa2OGDXKr9DDhAzMEGRDiX+SZKK/jo
         3uaGNPzpIV5uFrb1vuawMIzlTe926alHtKkjj21NPablj4TqwElEiLbOaFdLLRJqBFUY
         PRGWLLeQwu7rhp4x7JDv6E0WdrvYDkI0T04rf6K7hxqMW6axOnTyFdIMv5oRW5BXlgbZ
         i5cQhF0oVV0+v+92nXqCeHgxrZa55n7wOPuFCBqYM5R3K9X1dgDdJkO+RvC75lMAsjCK
         ZaelNKZLcwVa6kPLrch/1xM9OpsyZ1En1CWvyg52cteyfjEkTdDv/uS7U/Dto3KA3gFK
         VZ3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	arjan.van.de.ven@intel.com,
	jmattson@google.com,
	karahmed@amazon.de,
	kvm@vger.kernel.org,
	pbonzini@redhat.com,
	rkrcmar@redhat.com,
	sironi@amazon.de,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 52/77] x86/speculation: Update Speculation Control microcode blacklist
Date: Wed, 21 Feb 2018 13:49:01 +0100
Message-Id: <20180221124434.411479585@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015394020607855?=
X-GMAIL-MSGID: =?utf-8?q?1593015394020607855?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit 1751342095f0d2b36fa8114d8e12c5688c455ac4 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/intel.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -82,8 +82,6 @@ static const struct sku_microcode spectr
 	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x84 },
 	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
-	{ INTEL_FAM6_SKYLAKE_MOBILE,	0x03,	0xc2 },
-	{ INTEL_FAM6_SKYLAKE_DESKTOP,	0x03,	0xc2 },
 	{ INTEL_FAM6_BROADWELL_CORE,	0x04,	0x28 },
 	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
@@ -95,8 +93,6 @@ static const struct sku_microcode spectr
 	{ INTEL_FAM6_HASWELL_X,		0x02,	0x3b },
 	{ INTEL_FAM6_HASWELL_X,		0x04,	0x10 },
 	{ INTEL_FAM6_IVYBRIDGE_X,	0x04,	0x42a },
-	/* Updated in the 20180108 release; blacklist until we know otherwise */
-	{ INTEL_FAM6_ATOM_GEMINI_LAKE,	0x01,	0x22 },
 	/* Observed in the wild */
 	{ INTEL_FAM6_SANDYBRIDGE_X,	0x06,	0x61b },
 	{ INTEL_FAM6_SANDYBRIDGE_X,	0x07,	0x712 },
