Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AG47ELtwFfCf8cyy2c2zdluU+fPKT9PtA80NifBfUjIJnvsxnh1y+Jq8Oo7JhfFAWNqD8NBGrqGB
ARC-Seal: i=1; a=rsa-sha256; t=1520379156; cv=none;
        d=google.com; s=arc-20160816;
        b=EkxAYDI94Bznutw36pLLdDy4Et6X1Br1WbPYpvKNKk/Fe+OfwBZctJaxqPcXQtB/04
         lBEYYaVkI3KOoJNRKY3HxdYqiij1uOxhSCTcm3kc/7IQ7w03LvWSrgRdXioNdwGglC8f
         3cYeeE4z4LtVTzEUUDmtuoPm/NiqcxKL8NdH6B1pR0UxnT3zUFHlnWFK4LFrmoacWvHa
         pA3Ate0XVRhfRC+YJfHorLkYh+xlv5UYRuB0fFNAVvJfwF0eH2E6HDo9PqfbqLRUwfwU
         Wo2is25T84JviwbkGa/Vrfg4vEl4RBT1PadMZ/GtQ9gbhFnp/93Nf154sFaoqEgw9wiu
         ImeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:from:cc:to:subject:arc-authentication-results;
        bh=6M8+whjGFCRpwx4myVQk9wu05XcalodGrwNjb+RZ2z8=;
        b=OKVhoUcZQN5iBFTGn3TGWLvsnmlMv5skMxdm+or9iilIGTZqQdHE9xHhV9iUMPpMNm
         oUHI+VUdUthynNtis4EuDprzvm94Hgltr2mMNX/3L95Tx7llvRZC+7IIYEMR3zlegojg
         4muOIRdVgONCnB49hL75iwlyIGDHpDvyUjEEVeNziOnKjiIgxSgLVloRysKln7cPbx0t
         6t1L6XDoz7dmytcM45k5lSt1CskCNlf9MX0ZTI5lpzJPh6zGDUgArtFSdnRJMBWAXXL9
         WEe20p+IEpcx38UT1eVyTz7Z4Jk23KqjJKecseUJT1G3OAlUBZh7mFVcDFADLSrkPWaX
         jmkw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,433,1515484800";
   d="scan'208";a="206044826"
Subject: [PATCH] docs: clarify security-bugs disclosure policy
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,tglx@linutronix.de,gregkh@linuxfoundation.org,torvalds@linux-foundation.org,gnomes@lxorguk.ukuu.org.uk,aarcange@redhat.com,luto@kernel.org,keescook@google.com,tim.c.chen@linux.intel.com,dan.j.williams@intel.com,viro@zeniv.linux.org.uk,akpm@linux-foundation.org,linux-doc@vger.kernel.org,corbet@lwn.net,mark.rutland@arm.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Tue, 06 Mar 2018 15:31:40 -0800
Message-Id: <20180306233140.268BD8E1@viggo.jf.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594233094195809494?=
X-GMAIL-MSGID: =?utf-8?q?1594233094195809494?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

I think we need to soften the language a bit.  It might scare folks
off, especially the:

	 We prefer to fully disclose the bug as soon as possible.

which is not really the case.  As Greg mentioned in private mail, we
really do not prefer to disclose things until *after* a fix.  The
whole "we have the final say" is also a bit harsh.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@google.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <mark.rutland@arm.com>
---

 b/Documentation/admin-guide/security-bugs.rst |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff -puN Documentation/admin-guide/security-bugs.rst~embargo Documentation/admin-guide/security-bugs.rst
--- a/Documentation/admin-guide/security-bugs.rst~embargo	2018-03-06 14:47:04.519431230 -0800
+++ b/Documentation/admin-guide/security-bugs.rst	2018-03-06 14:57:46.410429629 -0800
@@ -29,18 +29,22 @@ made public.
 Disclosure
 ----------
 
-The goal of the Linux kernel security team is to work with the
-bug submitter to bug resolution as well as disclosure.  We prefer
-to fully disclose the bug as soon as possible.  It is reasonable to
-delay disclosure when the bug or the fix is not yet fully understood,
-the solution is not well-tested or for vendor coordination.  However, we
-expect these delays to be short, measurable in days, not weeks or months.
+The goal of the Linux kernel security team is to work with the bug
+submitter to bug resolution as well as disclosure.  We prefer to fully
+disclose the bug as soon as possible after a fix is available.  It is
+customary to delay disclosure when the bug or the fix is not yet fully
+understood, the solution is not well-tested or for vendor coordination.
+However, we expect these delays to typically be short, measurable in
+days, not weeks or months.
+
 A disclosure date is negotiated by the security team working with the
-bug submitter as well as vendors.  However, the kernel security team
-holds the final say when setting a disclosure date.  The timeframe for
-disclosure is from immediate (esp. if it's already publicly known)
-to a few weeks.  As a basic default policy, we expect report date to
-disclosure date to be on the order of 7 days.
+bug submitter as well as affected vendors.  The security team prefers
+coordinated disclosure and will consider pre-existing, reasonable
+disclosure dates.
+
+The timeframe for disclosure ranges from immediate (esp. if it's
+already publicly known) to a few weeks.  As a basic default policy, we
+expect report date to disclosure date to be on the order of 7 days.
 
 Coordination
 ------------
_
