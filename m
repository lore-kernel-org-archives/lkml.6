Return-Path: <a13xp0p0v88@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526488121; cv=none;
        d=google.com; s=arc-20160816;
        b=luLpH5IyppztUOk12IeGYRNPKJhgwYBXto1knPsfNndG/Vkd91eoC7sGqVYNFHbMd6
         ZT85ACjOURFkmApUEHu0ar2QHU3VJOvEjI7osB7Ul4O7F1eYQHEFlRmKZJjzDxFyMY1C
         A0pPhB5ObmvKFRkt8mPVf9x9EjMy/EPuZ4lQTGwTazIvV+t2+0bWlcr9KSuD10AaQaPq
         YIiw18sSYQOtUX1G62Q8oXgLw/F68o5PIMpTiepHw4h4FmKD8uzbRFRNNqFkNliA6pQb
         AyQ5SnyxmA0V++MWTheJ3WdUsU0jp9QjCwoCYLjPmUdpXOrlKihvod0kWjqzQmygRUEV
         1Vow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :arc-authentication-results;
        bh=EDnRyEkUWY+17yuV5p5k1NrPfVvSW7u12r4hjFpZ8tM=;
        b=G2EQmCo/XHE6BYhUGEG5n1NvH+fUb8jIwPZ0C4MegenYjB8j70ALVd7l/ITfYaSeA0
         LSHSJJ13+FW7+0ZMdP1Ai+CuWgiZSZrXkuU4EXGv5qkzOcY+FKExcJUNbFnT0NE+P90e
         QbrlCva7w2ODSQF2vSnfqlJJC6xttV3QgOZCZc0ou357pEw9i1ANx4l5hYzjrg0wrLsg
         RDwAUjKYBNZTiZ/xqnNUQ/Da+mY7z8ZGhOjbi/XnIqdroARjumG6hUR2qZTy5S0l0xlE
         OKx5rutWeek1AXPoL0OdzoFNGEvU901fdR48fE6kEMMAsHHmhTvAoiVyEctKcF2qvhMh
         NWlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
X-Google-Smtp-Source: AB8JxZqQLXTIYtXYRKgO7oKUE0PiRdTbneZv85+33O3opAeEG+XuyL4XtuGHDQrdnCbHjKp86+zYWA==
From: Alexander Popov <alex.popov@linux.com>
To: kernel-hardening@lists.openwall.com,
	Kees Cook <keescook@chromium.org>,
	PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>,
	Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Tycho Andersen <tycho@tycho.ws>,
	Laura Abbott <labbott@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Borislav Petkov <bp@alien8.de>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"Dmitry V . Levin" <ldv@altlinux.org>,
	Emese Revfy <re.emese@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Garnier <thgarnie@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Josef Bacik <jbacik@fb.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Ding Tianhong <dingtianhong@huawei.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Juergen Gross <jgross@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mathias Krause <minipli@googlemail.com>,
	Vikas Shivappa <vikas.shivappa@linux.intel.com>,
	Kyle Huey <me@kylehuey.com>,
	Dmitry Safonov <dsafonov@virtuozzo.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Florian Weimer <fweimer@redhat.com>,
	Boris Lukashev <blukashev@sempervictus.com>,
	Andrey Konovalov <andreyknvl@google.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	alex.popov@linux.com
Subject: [PATCH v12 1/6] gcc-plugins: Clean up the cgraph_create_edge* macros
Date: Wed, 16 May 2018 19:28:12 +0300
Message-Id: <1526488097-20611-2-git-send-email-alex.popov@linux.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526488097-20611-1-git-send-email-alex.popov@linux.com>
References: <1526488097-20611-1-git-send-email-alex.popov@linux.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600638808528304883?=
X-GMAIL-MSGID: =?utf-8?q?1600638808528304883?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Drop useless redefinitions of cgraph_create_edge* macros. Drop the unused
nest argument. Also support gcc-8, which doesn't have freq argument.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 scripts/gcc-plugins/gcc-common.h | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index f467500..552d5ef 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -392,13 +392,6 @@ static inline struct cgraph_node *cgraph_alias_target(struct cgraph_node *n)
 }
 #endif
 
-#if BUILDING_GCC_VERSION >= 4007 && BUILDING_GCC_VERSION <= 4009
-#define cgraph_create_edge(caller, callee, call_stmt, count, freq, nest) \
-	cgraph_create_edge((caller), (callee), (call_stmt), (count), (freq))
-#define cgraph_create_edge_including_clones(caller, callee, old_call_stmt, call_stmt, count, freq, nest, reason) \
-	cgraph_create_edge_including_clones((caller), (callee), (old_call_stmt), (call_stmt), (count), (freq), (reason))
-#endif
-
 #if BUILDING_GCC_VERSION <= 4008
 #define ENTRY_BLOCK_PTR_FOR_FN(FN)	ENTRY_BLOCK_PTR_FOR_FUNCTION(FN)
 #define EXIT_BLOCK_PTR_FOR_FN(FN)	EXIT_BLOCK_PTR_FOR_FUNCTION(FN)
@@ -723,10 +716,23 @@ static inline const char *get_decl_section_name(const_tree decl)
 #define varpool_get_node(decl) varpool_node::get(decl)
 #define dump_varpool_node(file, node) (node)->dump(file)
 
-#define cgraph_create_edge(caller, callee, call_stmt, count, freq, nest) \
+#if BUILDING_GCC_VERSION >= 8000
+#define cgraph_create_edge(caller, callee, call_stmt, count, freq) \
+	(caller)->create_edge((callee), (call_stmt), (count))
+
+#define cgraph_create_edge_including_clones(caller, callee,	\
+		old_call_stmt, call_stmt, count, freq, reason)	\
+	(caller)->create_edge_including_clones((callee),	\
+		(old_call_stmt), (call_stmt), (count), (reason))
+#else
+#define cgraph_create_edge(caller, callee, call_stmt, count, freq) \
 	(caller)->create_edge((callee), (call_stmt), (count), (freq))
-#define cgraph_create_edge_including_clones(caller, callee, old_call_stmt, call_stmt, count, freq, nest, reason) \
-	(caller)->create_edge_including_clones((callee), (old_call_stmt), (call_stmt), (count), (freq), (reason))
+
+#define cgraph_create_edge_including_clones(caller, callee,	\
+		old_call_stmt, call_stmt, count, freq, reason)	\
+	(caller)->create_edge_including_clones((callee),	\
+		(old_call_stmt), (call_stmt), (count), (freq), (reason))
+#endif
 
 typedef struct cgraph_node *cgraph_node_ptr;
 typedef struct cgraph_edge *cgraph_edge_p;
-- 
2.7.4
