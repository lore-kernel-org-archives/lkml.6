Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuVfOOlPla2Dm4NEJy2znI34qzo8dfL3cex3jzCLOyPNci2Sj73fx7Bk31CmnCaaY2/z303
ARC-Seal: i=1; a=rsa-sha256; t=1520955181; cv=none;
        d=google.com; s=arc-20160816;
        b=nxFDL5XUDUph20Udmg/8enXfGlIuM3rZUNOEMBNYn+9xg3nOP8OhnOTrau0QC19eeR
         iNRja9QsnEXk8Wqo4Gx2OBg0xF26JIguSP+PSOT0CLAUogTJhytueK/kFb0jeXGqtb3N
         ovV5KT19r/a8dhBEBnYruQMfksPYDAaM5JaENdQFcmId/eJ9FHp8Ap5ZbszTElR61oxF
         PBR71kUGcjsKKG5Hcdx+EHqCFpUn4gWAcCX3je2dQNPohrwYFQVZzHGkVvj+aTz1JBoH
         NN2DCn3hwQRk/bsKoEL7HZr5Z+RMegNtBvPAy9f3wXSTrlAbOX5xS7dmXMIr5q22FU7x
         Sizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0Zuln8lux42M1TFUCPUul6c/P0aEIcrx6GHxTnBm+cc=;
        b=sVvdKu1T733KIZgJWbNKQaoG1Ru1yXYBDCfnFkA+5tt1k6QDTD4goIMeBG6e5h2xJT
         cxpzgo5M6fDiit64MwQcxBn+dw/msK3NFZ5gViqqWWOcF2Ju+01j5S5s6QAHSSTq1KS2
         tZ+KS2PW11FFjfOyvvzd3K3OO0M6+wSGzjGQdqO3LdlZ3TJmQDHhEOD4E29CbSt8/kE6
         LYyvZurfQ19UrNVm1gDI/bSAC/C4lOH+zVCy14PW3czTHFZuDPdngKqH6+lZmvsQn8jO
         MgbiScvQccZpbn+fAui0XTSExFZ34Ev2SRiXqY8x2KcW8wcWYkmWk+hZ3zMKwWVdaOmD
         xmPA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 099/146] objtool: Add module specific retpoline rules
Date: Tue, 13 Mar 2018 16:24:26 +0100
Message-Id: <20180313152328.204751220@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837100802362123?=
X-GMAIL-MSGID: =?utf-8?q?1594837100802362123?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit ca41b97ed9124fd62323a162de5852f6e28f94b8 upstream.

David allowed retpolines in .init.text, except for modules, which will
trip up objtool retpoline validation, fix that.

Requested-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/Makefile.build        |    2 ++
 tools/objtool/builtin-check.c |    3 ++-
 tools/objtool/builtin.h       |    2 +-
 tools/objtool/check.c         |    9 +++++++++
 4 files changed, 14 insertions(+), 2 deletions(-)

--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -256,6 +256,8 @@ __objtool_obj := $(objtree)/tools/objtoo
 
 objtool_args = $(if $(CONFIG_UNWINDER_ORC),orc generate,check)
 
+objtool_args += $(if $(part-of-module), --module,)
+
 ifndef CONFIG_FRAME_POINTER
 objtool_args += --no-fp
 endif
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -29,7 +29,7 @@
 #include "builtin.h"
 #include "check.h"
 
-bool no_fp, no_unreachable, retpoline;
+bool no_fp, no_unreachable, retpoline, module;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -40,6 +40,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('f', "no-fp", &no_fp, "Skip frame pointer validation"),
 	OPT_BOOLEAN('u', "no-unreachable", &no_unreachable, "Skip 'unreachable instruction' warnings"),
 	OPT_BOOLEAN('r', "retpoline", &retpoline, "Validate retpoline assumptions"),
+	OPT_BOOLEAN('m', "module", &module, "Indicates the object will be part of a kernel module"),
 	OPT_END(),
 };
 
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -20,7 +20,7 @@
 #include <subcmd/parse-options.h>
 
 extern const struct option check_options[];
-extern bool no_fp, no_unreachable, retpoline;
+extern bool no_fp, no_unreachable, retpoline, module;
 
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1957,6 +1957,15 @@ static int validate_retpoline(struct obj
 		if (insn->retpoline_safe)
 			continue;
 
+		/*
+		 * .init.text code is ran before userspace and thus doesn't
+		 * strictly need retpolines, except for modules which are
+		 * loaded late, they very much do need retpoline in their
+		 * .init.text
+		 */
+		if (!strcmp(insn->sec->name, ".init.text") && !module)
+			continue;
+
 		WARN_FUNC("indirect %s found in RETPOLINE build",
 			  insn->sec, insn->offset,
 			  insn->type == INSN_JUMP_DYNAMIC ? "jump" : "call");
