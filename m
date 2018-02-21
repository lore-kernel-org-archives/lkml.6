Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227IATPQ5LOr68Fzv6PtWNwSyAiwFQXa04NSsJI7QcQkq/icDmsjcmnbLCZDy68ACy0OqMne
ARC-Seal: i=1; a=rsa-sha256; t=1519218467; cv=none;
        d=google.com; s=arc-20160816;
        b=ABgeoNgnqkGeYm734SARynhOqghHbt36OmGzRxCzEg+SZmFjOc/dN/d6ka3QIIzAKI
         IXot71/oFfaRxKSUbz9b2Sr3LJW/3CPN+9VxVXbT4IuiEOeWszoadRdXQlY1ikQPEg5I
         vjH7P3Q6DsyNzRj4Uf/hU1fFP9A8RZOvHH151n965k6srl/gUouRthagLGDsBckp2vFz
         GAD5M3qa1qmFP4FHKUUT4+Cw6++XedzyBmaAmVbSltaSbIJxUPY+OXfHeJ6zXNiNU3gY
         KoI/ul/vah+5UzX1r+sg6oqe8sh2S2xYX1SwIV90PAsw1Sp8fXzDLWI09kjeWVg6UFVT
         0SRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=828aESnEcU9d9YxSt0HKeFYwtu84eUG3qALX5Bnjhlw=;
        b=eHkR14hmkDUhUUgmp1wW5a+MurAeMeBUZNJATS2k02GfYAHJY43Xaugn5ip75gHrZJ
         jJSjzzcjFVJkjUeBGoGSH3OJjvmqmMYFHMrJYBLGUmdDiT/XFBbv+nDzrLk3VfIv4iqb
         e0wEzDf6aReb5AJVuFyY/3GSv9gAqimTlEyUIZe3tdE921ThTIVF00VvkpEm4Lj0Xwkw
         RfA503q4VwAj9iCXiBcomJpk+b6mSj6N/kg9slc7/AyQKhdsvgnzVyea7OdbLEc+OqBS
         vRvil/g76t3+B6NFtQ5tYhf0SUaGc0wj+OMedA8FUcwUhN88u4otz8DXt4aRQY0MqT2G
         cInA==
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
Subject: [PATCH 4.15 048/163] x86/speculation: Update Speculation Control microcode blacklist
Date: Wed, 21 Feb 2018 13:47:57 +0100
Message-Id: <20180221124533.076476577@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015394020607855?=
X-GMAIL-MSGID: =?utf-8?q?1593016023330059856?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -123,8 +123,6 @@ static const struct sku_microcode spectr
 	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x84 },
 	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
-	{ INTEL_FAM6_SKYLAKE_MOBILE,	0x03,	0xc2 },
-	{ INTEL_FAM6_SKYLAKE_DESKTOP,	0x03,	0xc2 },
 	{ INTEL_FAM6_BROADWELL_CORE,	0x04,	0x28 },
 	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
@@ -136,8 +134,6 @@ static const struct sku_microcode spectr
 	{ INTEL_FAM6_HASWELL_X,		0x02,	0x3b },
 	{ INTEL_FAM6_HASWELL_X,		0x04,	0x10 },
 	{ INTEL_FAM6_IVYBRIDGE_X,	0x04,	0x42a },
-	/* Updated in the 20180108 release; blacklist until we know otherwise */
-	{ INTEL_FAM6_ATOM_GEMINI_LAKE,	0x01,	0x22 },
 	/* Observed in the wild */
 	{ INTEL_FAM6_SANDYBRIDGE_X,	0x06,	0x61b },
 	{ INTEL_FAM6_SANDYBRIDGE_X,	0x07,	0x712 },
