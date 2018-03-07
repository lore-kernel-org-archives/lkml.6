Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AG47ELtm/LA2Hdz9cH23lGmT6FYbuNBRcOURero3ofOemZYNFc33KvtCiE1qfvDGXuzJEMlp09sr
ARC-Seal: i=1; a=rsa-sha256; t=1520459243; cv=none;
        d=google.com; s=arc-20160816;
        b=liHL+1zdOKTcTZr0Ge1bonVAaYx4CkieNIiTqfX2HZO/hmgUwyQwbgyg2Yas6tz3id
         DKt7icfsxNmI9JZb9iWWMFS0y7EzFHYsNXibSpEHpZ6rW5TTK65R+a3mwNALPH/PvZDU
         IqQafdIITcTU+npipZszDG0/Bd1zoHo5N6DfsQbeTRynx8Hx9gO8ROu4X7CcXWwGhVXG
         VBwg4EWBLRUxRRnI47sxrMWu0dh8rwMkwC6HHmjjeg10ugtUvC5x0PEMwnalePwsTP3n
         rniejPwdZnGRmoqCKyW9aMLtX/3DPDFWa48DD9jbNF7/Gg/Qvj1G+P+5VN9igEwVzGzA
         6lbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:from:cc:to:subject:arc-authentication-results;
        bh=F+s1BygsLe5aB8bE5FQ8Z6NQhwz0df59Qt3L2ixFawg=;
        b=SzagJ23SBGtaFw7DVCxL1Mi0uNMdUCIFDMImwYpjYLdXK0WA65DOB9PnrZlBACR6iP
         sZfxfq5cYSFnMlyTO1TA6QxlPGej7FDGhJv5Ugrtngc1oR0ASNqDTP5TE/cg1WA6i6B6
         cvhmq9QMXfoPRVVu6fDjMMtwdHjsrdcjxZK7gM5qaMHe0WcoygkR+4Kw1GD92nkTxjPX
         8V8LqelBf1HPK1C39v2qGPVb0+2Jua6Af9kln5fwKCOPiH+e+sCnkzFYi5SogwQSL/Gr
         EDR8TcgqEdgnfsJbaDuWtwS6Cp5bOuiIB67o2yc+qXH/ws/3SvmwWUJ0UT+FkudyRB+X
         ldJA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,437,1515484800";
   d="scan'208";a="22841928"
Subject: [PATCH] [v2] docs: clarify security-bugs disclosure policy
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,dan.j.williams@intel.com,tglx@linutronix.de,gregkh@linuxfoundation.org,torvalds@linux-foundation.org,gnomes@lxorguk.ukuu.org.uk,aarcange@redhat.com,luto@kernel.org,keescook@google.com,tim.c.chen@linux.intel.com,viro@zeniv.linux.org.uk,akpm@linux-foundation.org,linux-doc@vger.kernel.org,corbet@lwn.net,mark.rutland@arm.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 07 Mar 2018 13:46:24 -0800
Message-Id: <20180307214624.D4361772@viggo.jf.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594317071955827625?=
X-GMAIL-MSGID: =?utf-8?q?1594317071955827625?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

I think we need to soften the language a bit.  It might scare folks
off, especially the:

	 We prefer to fully disclose the bug as soon as possible.

which is not really the case.  Linus says:

	It's not full disclosure, it's not coordinated disclosure,
	and it's not "no disclosure".  It's more like just "timely
	open fixes".

I changed a bit of the wording in here, but mostly to remove the word
"disclosure" since it seems to mean very specific things to people
that we do not mean here.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@google.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <mark.rutland@arm.com>
---

 b/Documentation/admin-guide/security-bugs.rst |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff -puN Documentation/admin-guide/security-bugs.rst~embargo2 Documentation/admin-guide/security-bugs.rst
--- a/Documentation/admin-guide/security-bugs.rst~embargo2	2018-03-07 13:23:49.390228208 -0800
+++ b/Documentation/admin-guide/security-bugs.rst	2018-03-07 13:42:37.618225395 -0800
@@ -29,18 +29,20 @@ made public.
 Disclosure
 ----------
 
-The goal of the Linux kernel security team is to work with the
-bug submitter to bug resolution as well as disclosure.  We prefer
-to fully disclose the bug as soon as possible.  It is reasonable to
-delay disclosure when the bug or the fix is not yet fully understood,
-the solution is not well-tested or for vendor coordination.  However, we
-expect these delays to be short, measurable in days, not weeks or months.
-A disclosure date is negotiated by the security team working with the
-bug submitter as well as vendors.  However, the kernel security team
-holds the final say when setting a disclosure date.  The timeframe for
-disclosure is from immediate (esp. if it's already publicly known)
+The goal of the Linux kernel security team is to work with the bug
+submitter to understand and fix the bug.  We prefer to publish the fix as
+soon as possible, but try to avoid public discussion of the bug itself
+and leave that to others.
+
+Publishing the fix may be delayed when the bug or the fix is not yet
+fully understood, the solution is not well-tested or for vendor
+coordination.  However, we expect these delays to be short, measurable in
+days, not weeks or months.  A release date is negotiated by the security
+team working with the bug submitter as well as vendors.  However, the
+kernel security team holds the final say when setting a timeframe.  The
+timeframe varies from immediate (esp. if it's already publicly known bug)
 to a few weeks.  As a basic default policy, we expect report date to
-disclosure date to be on the order of 7 days.
+release date to be on the order of 7 days.
 
 Coordination
 ------------
_
