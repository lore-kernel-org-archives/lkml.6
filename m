Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu/Wo1KQywU1KRFQ6cJNX4h5Ra1uJrReRZZ2+5mXELLfYuVhEF8s+6JBErK+K/akD7hHX2U
ARC-Seal: i=1; a=rsa-sha256; t=1520955229; cv=none;
        d=google.com; s=arc-20160816;
        b=O6ywyO8e+IJMLYKHam6BDGOQsx0/OHmTC55m7FX0HFyeTe22hDAb7j1DHjlDV0pVhO
         65CLbyKbEpHHXK/CaqcRj9TUDO2rzcf9ojTuupJx0mkF7VtJQzcR4zrTSzn4WOudvTip
         AdIP7WNZpurovPa/7D40esD9iKoI5B4bCnGGNrKIGzubw0ffGkA56dFBMV6gejg9Dro5
         MHNNeP2KGE8gMuLU6yzyD+ZcDcHMydRS2QKJraiMi3sySny2fsLbL8VHtyuY3np56ehd
         Y+dH5BaulmUxwXQY7XUazsjxl3WYItz6+ZqphbdPcAMqcBCGkQxtIO0yVzSoX//u4YVT
         rYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7jjI1BQJYiaWvX73Hm+KV+XWvqi0zOueWSban2UrhRU=;
        b=HH2yyFC+t/aYgchIPgb8LjJwQ6QsPjpH5NERIYKCW2gFJG54XfrNLOHopfqxR5C1KF
         gaDjXmpxmjMMbrQvtXiWrjYVFwW8ZZLTaDt8U9MH/cBy5A+r58BFTqecx1Z/Sjn4NTl4
         656/k0hMiKHWzWBthrfBgPNtN1BhFwR96PJFnFpJLbNgYkm+IwxUXYqGBlI/jNpnswj1
         skoNC4TLuTZ+984o26CHfJyCtGxFcAk3MyWFQWbJnPANk8fc8ox/y+mnzOdUdE67Wh31
         9umm7DBkRQD06qsBtzx81xCOIc27MzJEz+/30OzRdumgd6ODN036MFXTr7OfUE0E4guk
         DU5A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 097/146] objtool: Use existing global variables for options
Date: Tue, 13 Mar 2018 16:24:24 +0100
Message-Id: <20180313152328.077420804@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837149906583259?=
X-GMAIL-MSGID: =?utf-8?q?1594837149906583259?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 43a4525f80534530077683f6472d8971646b0ace upstream.

Use the existing global variables instead of passing them around and
creating duplicate global variables.

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
 tools/objtool/builtin-check.c |    2 +-
 tools/objtool/builtin-orc.c   |    6 +-----
 tools/objtool/builtin.h       |    5 +++++
 tools/objtool/check.c         |    5 ++---
 tools/objtool/check.h         |    2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -53,5 +53,5 @@ int cmd_check(int argc, const char **arg
 
 	objname = argv[0];
 
-	return check(objname, no_fp, no_unreachable, false);
+	return check(objname, false);
 }
--- a/tools/objtool/builtin-orc.c
+++ b/tools/objtool/builtin-orc.c
@@ -25,7 +25,6 @@
  */
 
 #include <string.h>
-#include <subcmd/parse-options.h>
 #include "builtin.h"
 #include "check.h"
 
@@ -36,9 +35,6 @@ static const char *orc_usage[] = {
 	NULL,
 };
 
-extern const struct option check_options[];
-extern bool no_fp, no_unreachable;
-
 int cmd_orc(int argc, const char **argv)
 {
 	const char *objname;
@@ -54,7 +50,7 @@ int cmd_orc(int argc, const char **argv)
 
 		objname = argv[0];
 
-		return check(objname, no_fp, no_unreachable, true);
+		return check(objname, true);
 	}
 
 	if (!strcmp(argv[0], "dump")) {
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -17,6 +17,11 @@
 #ifndef _BUILTIN_H
 #define _BUILTIN_H
 
+#include <subcmd/parse-options.h>
+
+extern const struct option check_options[];
+extern bool no_fp, no_unreachable;
+
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
 
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -18,6 +18,7 @@
 #include <string.h>
 #include <stdlib.h>
 
+#include "builtin.h"
 #include "check.h"
 #include "elf.h"
 #include "special.h"
@@ -33,7 +34,6 @@ struct alternative {
 };
 
 const char *objname;
-static bool no_fp;
 struct cfi_state initial_func_cfi;
 
 struct instruction *find_insn(struct objtool_file *file,
@@ -2021,13 +2021,12 @@ static void cleanup(struct objtool_file
 	elf_close(file->elf);
 }
 
-int check(const char *_objname, bool _no_fp, bool no_unreachable, bool orc)
+int check(const char *_objname, bool orc)
 {
 	struct objtool_file file;
 	int ret, warnings = 0;
 
 	objname = _objname;
-	no_fp = _no_fp;
 
 	file.elf = elf_open(objname, orc ? O_RDWR : O_RDONLY);
 	if (!file.elf)
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -63,7 +63,7 @@ struct objtool_file {
 	bool ignore_unreachables, c_file, hints;
 };
 
-int check(const char *objname, bool no_fp, bool no_unreachable, bool orc);
+int check(const char *objname, bool orc);
 
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset);
