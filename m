Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225gpSL6xMj1Cdfc4MZ6J16tQlEMyQ0xIJ+FufSihBY6u48T83SerYDUjqeK8ZsLHD8Jkkxt
ARC-Seal: i=1; a=rsa-sha256; t=1519218545; cv=none;
        d=google.com; s=arc-20160816;
        b=CCmpgIiu0agOvOUg8AbNduM1iFFL4jbXLztNsBBjfBv1UMNB7Xonv8duZIqdvR0H0t
         Gspif0uI1GMnWBEeJgp7HB9pqrToMyYjDokwXirEUX3nDLSaV5QK1+xIdnQFxI1MAcsy
         p11FBotjvmfrYqZIJbFqcfWob6hHhkKrjvkn14zDS9tdU9aCdePFkzCBdzRA5EMGJGyk
         D5+MoGuzlc8tnBqK0+Z29uQ3imP2ZIxAnSbPuuv4+moAjkSWe5/TkNdIQF0R0wrCL1KC
         Bv+gZgl6rWwnDyx4wmJygCEmnzAbtB29+kyuhAzbmQHmujsGBJFrgqHI6GWo4RDEnSpl
         o7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/IBkwYmJfStbHh8cH0jgZHhJiVYv1CsEojAJesq14Q0=;
        b=glel3j0sGIS6vozXeaZg4MYg+C5Hh645zIH6qgrxPlSOqgpONcA2V8eIXz0uO/8Vq/
         NqqmiT5wiF1GDdwrYbX9rBVx2Q38ZEuEmHNdobdEBUt7a0a6103DRLqpxav9cyL7mKA/
         RRaCPQaM73gYeLgilk+2fem1yFaT8AYYdTiQpkqbaOTjeiJbm7O1NtC9q+cJBA7R4cP1
         SSmmJOoWuHEF0HbEOFD8SEfSHuG3P+P/oHI6OcVzJWfUVHrvg6w0nORHN6q/rtnFSy9s
         vESXAEnIAJAkjrN7siNbZWUEBuV5Trz3x89xPejrtP3NL4MznCICWiua+tPaVa0H0KWp
         0hxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	kbuild test robot <fengguang.wu@intel.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 077/163] x86/debug, objtool: Annotate WARN()-related UD2 as reachable
Date: Wed, 21 Feb 2018 13:48:26 +0100
Message-Id: <20180221124534.710771370@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015701695663855?=
X-GMAIL-MSGID: =?utf-8?q?1593016105294143556?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit 2b5db66862b95532cb6cca8165ae6eb73633cf85 upstream.

By default, objtool assumes that a UD2 is a dead end.  This is mainly
because GCC 7+ sometimes inserts a UD2 when it detects a divide-by-zero
condition.

Now that WARN() is moving back to UD2, annotate the code after it as
reachable so objtool can follow the code flow.

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kbuild test robot <fengguang.wu@intel.com>
Link: http://lkml.kernel.org/r/0e483379275a42626ba8898117f918e1bf661e40.1518130694.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/bug.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -77,7 +77,11 @@ do {								\
 	unreachable();						\
 } while (0)
 
-#define __WARN_FLAGS(flags)	_BUG_FLAGS(ASM_UD0, BUGFLAG_WARNING|(flags))
+#define __WARN_FLAGS(flags)					\
+do {								\
+	_BUG_FLAGS(ASM_UD0, BUGFLAG_WARNING|(flags));		\
+	annotate_reachable();					\
+} while (0)
 
 #include <asm-generic/bug.h>
 
