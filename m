Return-Path: <a13xp0p0v88@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520107250; cv=none;
        d=google.com; s=arc-20160816;
        b=zW95p4Ff5g4hxwvS5aGVG/vpLXbiVx2lKS7ZnsEe2agDvP0nkaziOGVuMavDl+HjZC
         onlfIxUdS4rHnThTm2Y3ZSrPlH86cgvxF8ukXtGxsYCK7rQF82mMi7slaLA7e44SOphE
         8Qpho2Ward3ltZyD+P7CkPyt3OxJA7ekIgWEFoRMLlOO96nZoL4o/dJVKzP8F7tdr5DO
         TquTmMOwOboU4oIevOesUVmS8D5WxTyuNLZtjnZT3Q4IyhzS2csv1XADEmNLjQQ1XiRF
         lTWLZ3SwM/uNDvwNh/wX4LeRA84SAqJCR3ErUWmRffWMU1ycIuQmCT9tsZmi61dghPYv
         fAdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :arc-authentication-results;
        bh=EDnRyEkUWY+17yuV5p5k1NrPfVvSW7u12r4hjFpZ8tM=;
        b=k8x4qDYIu4cRDWHnSZas+34MqZ4WQK/OI4WOFFhKF++sC77Jym0Q2AJVqNCxE1Hq5w
         Lj2XEUzmL4FrLEprKiiXdpyUF2ETqdN2QKcuU4EAFDa6qBlzg9Uuak4cJATuJdgsdgtK
         LA7SaaqEAigpYp698GFwEP9Vs1NDOPctaRyyuGOhg8kchX2DvFw12UCZbIZIFunWB23v
         nEWOKjmPqWaRAn6TtwUyQmoIgf/dDfS/pgd2DeEVO7IkOVpED9WON+CvE9VjecoYN+nF
         TOUjBSi4XUMu5pSnA8RkFO1+4XPNHonhjcODRSYmV2yRj5gjxJC3gh0mAtlKGvaNXoTw
         muSg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
X-Google-Smtp-Source: AG47ELuJnS0rVehGyv4xuLyEHt+3uhr/JKr1sh1r7uKJyFEd7lyTtFHyRSN+QpAa5z0vmw0/yL9U8g==
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mathias Krause <minipli@googlemail.com>,
	Vikas Shivappa <vikas.shivappa@linux.intel.com>,
	Kyle Huey <me@kylehuey.com>,
	Dmitry Safonov <dsafonov@virtuozzo.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	alex.popov@linux.com
Subject: [PATCH RFC v9 1/7] gcc-plugins: Clean up the cgraph_create_edge* macros
Date: Sat,  3 Mar 2018 23:00:26 +0300
Message-Id: <1520107232-14111-2-git-send-email-alex.popov@linux.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947980930866304?=
X-GMAIL-MSGID: =?utf-8?q?1593947980930866304?=
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
