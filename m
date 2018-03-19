Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtM6pnagt8e1n835+Bx9astg26oC4XMWIzFoWrSiynfFH6VsnEa1UqgmoUcCAzYBGzvqwbk
ARC-Seal: i=1; a=rsa-sha256; t=1521484323; cv=none;
        d=google.com; s=arc-20160816;
        b=bw/TDJcLjHCvFXBFzYNZ9Bq1zZrqs+41Ovsn9i/bqhc1rwHHv3B41kCQEr4J5sljpf
         8R7gahF2b9NM2AMli4REZUgMoQIFyBYhO0Fd13iuz3Eigqb09Td8KlWlPyQvJSpazyqr
         9bhKlNRepL+D0kVMVeNwTXQM6ZQOfnIA6EA7BK6N5ZpkXYAg796WYzN+z8PB6swbAJV9
         V8bYKt/tbogtRnxOfxPB1g48Fwwjhfs18bmYareNI4WZHxTY1FH72fNt2SfIB/Allh84
         A9+bQSq4wG25bRyUqA48VlCzRmuNVPzRNLpPhFf0YNi/fOJzcEL44Zlie8wQs/kR3rp3
         ow1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7CqXmprZ6k2c+XXWbrB8tOTpVJ6YFo1UH5INVR1Id/M=;
        b=BQa6A2FYOh4jl5yBsYeA4airM0i4TzyKGensFLK7uw7V/tN56BmKgCFSLsW6ajG69w
         e90SDIKwafqTomTKzFHbRlW3l6crBFx9LreLSkZ6i1AbAkf/uTBQKovJCeyh6Zo6H/xB
         1vpwPgkCGqpTRD48qnGtvXLPyBx6K5R8v+81vufZ/WAtWvrzpeEAzI22faCkYOslgYL1
         EAZXz6ty2+oALCb/F/7/fmjqkLDutM+yqJspjjVi0PJej9cHpiS/aNe4DNMDVCncf/My
         ke0TEWT/L4KA44VlGM5+40436dP9XHJv0Zg0znEw1HSbbMpJMqTJ2ATEqDroc2bmd0fI
         sJIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Whitcroft <apw@canonical.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 06/52] x86/speculation, objtool: Annotate indirect calls/jumps for objtool on 32-bit kernels
Date: Mon, 19 Mar 2018 19:08:04 +0100
Message-Id: <20180319180735.398008576@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391744762419603?=
X-GMAIL-MSGID: =?utf-8?q?1595391945904846228?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Whitcroft <apw@canonical.com>

commit a14bff131108faf50cc0cf864589fd71ee216c96 upstream.

In the following commit:

  9e0e3c5130e9 ("x86/speculation, objtool: Annotate indirect calls/jumps for objtool")

... we added annotations for CALL_NOSPEC/JMP_NOSPEC on 64-bit x86 kernels,
but we did not annotate the 32-bit path.

Annotate it similarly.

Signed-off-by: Andy Whitcroft <apw@canonical.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180314112427.22351-1-apw@canonical.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/nospec-branch.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -183,7 +183,10 @@
  * otherwise we'll run out of registers. We don't care about CET
  * here, anyway.
  */
-# define CALL_NOSPEC ALTERNATIVE("call *%[thunk_target]\n",	\
+# define CALL_NOSPEC						\
+	ALTERNATIVE(						\
+	ANNOTATE_RETPOLINE_SAFE					\
+	"call *%[thunk_target]\n",				\
 	"       jmp    904f;\n"					\
 	"       .align 16\n"					\
 	"901:	call   903f;\n"					\
