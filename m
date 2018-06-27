Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF60C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FEE24CEC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30FEE24CEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753473AbeF0KbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 06:31:10 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:23092 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932143AbeF0KbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 06:31:08 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5RAT8Vo000264;
        Wed, 27 Jun 2018 19:29:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp);
 Wed, 27 Jun 2018 19:29:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5RAT2Ad000244
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 27 Jun 2018 19:29:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
To:     Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <CACT4Y+ZGSefrYL9xtQs=yPMRNFsOUumuJXsShJPhCOBSLySxuw@mail.gmail.com>
 <20180620083126.GA477@jagdpanzerIV>
 <CACT4Y+YMubTm1xduj+XCbQnNwQxYFLjBT33cFKisN1HyeaBpZw@mail.gmail.com>
 <20180620090413.GA444@jagdpanzerIV> <20180620091541.GB444@jagdpanzerIV>
 <CACT4Y+bcp4fSBBq3F86T-C4+n-YkeXUGMqpvkJ6vj6mK-TU2EA@mail.gmail.com>
 <20180620110759.GD444@jagdpanzerIV>
 <CACT4Y+aER3O2x2ApM=MVFoFXhp_T_rUeyG9CBx031qyH0voSRg@mail.gmail.com>
 <20180620130628.GA1000@tigerII.localdomain>
 <197be25e-c841-bf3c-7081-61f0a9653c8c@i-love.sakura.ne.jp>
 <20180625014122.GB557@jagdpanzerIV>
 <CACT4Y+YXRD1RCV4jFyEaCOB8D17j3+bXG9qXJ5XrcmsznjidRg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <4d20b713-d36a-7f83-cd6c-7c022e5342b4@i-love.sakura.ne.jp>
Date:   Wed, 27 Jun 2018 19:29:01 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YXRD1RCV4jFyEaCOB8D17j3+bXG9qXJ5XrcmsznjidRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/25 18:36, Dmitry Vyukov wrote:
> On Mon, Jun 25, 2018 at 3:41 AM, Sergey Senozhatsky
> <sergey.senozhatsky.work@gmail.com> wrote:
>> On (06/22/18 22:06), Tetsuo Handa wrote:
>>>>
>>>> Awesome. If you and Fengguang can combine forces and lead the
>>>> whole thing towards "we couldn't care of pr_cont() less", it
>>>> would be really huuuuuge. Go for it!
>>>
>>> Can't we have seq_printf()-like one which flushes automatically upon seeing '\n'
>>> or buffer full? Printing memory information is using a lot of pr_cont(), even in
>>> function names (e.g. http://lkml.kernel.org/r/20180622083949.GR10465@dhcp22.suse.cz ).
>>> Since OOM killer code is serialized by oom_lock, we can use static buffer for
>>> OOM killer messages.
>>
>> I'm not the right guy to answer this question. Sorry. We need to Cc MM
>> people on this.
>>
>> Does OOM's pr_cont() usage cause too much disturbance to syzkaller? I thought
>> that OOM was slightly out of sight.
> 
> Hard to tell. Nothing specific comes to mind.
> We do see lines like these:
> 
> BUG: unable to handle kernel [ 110.NUM] device gre0 entered promiscuous mode
> BUG:--------[ cut here ]------------
> 
> and frequently it's also required to look deep inside of crash message
> to understand what they really mean. Hard to tell how random pr_cont's
> contribute to the problem. We now throw away everything that looks any
> corrupted right away.
> I guess the main requirement is that the crash report itself does not
> use pr_cont and provided we have task/cpu context we can separate the
> crash report lines from everything else (assuming that random
> pr_cont's on other CPUs won't glue to the report lines).
> 

PATCH 1/3 below is a sample implementation of seq_printf()-like one which
flushes automatically upon seeing '\n' or buffer full. PATCH 2/3 is a
straightforward user of such function. (Well, since it is so simple,
we could rewrite it using snprintf() before PATCH 1/3 is accepted.)
PATCH 3/3 is a complicated user of such function. (Well, we could reduce
pr_cont() before PATCH 1/3 is accepted.) Can we agree with PATCH 1/3 ?

From 485406f585e566dccdfb85a1afbae460b8756457 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 27 Jun 2018 16:29:14 +0900
Subject: [PATCH 1/3] printk: Introduce buffered_printk().

Linus suggested in "printk: what is going on with additional newlines?"
thread [1] that

  Making the buffer explicit is (a) cheaper and (b) better. Now you can
  put the buffer on the stack, you never have to worry about where you
  need to track context, and you have no buffering limits (ie you can
  buffer across any event).

  I definitely suspect that "single line" is often sufficient. I
  mean, that's all that KERN_CONT ever gave you anyway (and not reliably).

  And then a 80 character buffer really isn't any different from having
  a structure with a few pointers in it, which we do on the stack all
  the time.

Now, since syzbot is bothered by concurrent printk() messages (e.g.
memory allocation fault injection), we started thinking about adding
prefix to each line of printk() output. This matches the suggestion that
buffering single line will be sufficient if we add caller's context
information for distinguishing concurrent printk() messages.

Thus, this patch introduces buffered_printk() which spools printk() output
and automatically flushes when '\n' was found or buffer became full (and
related structure/macro/functions).

[1] http://lkml.kernel.org/r/CA+55aFx+5R-vFQfr7+Ok9Yrs2adQ2Ma4fz+S6nCyWHY_-2mrmw@mail.gmail.com

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/printk.h | 28 ++++++++++++++++
 kernel/printk/printk.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 6d7e800..81bc12a 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -153,6 +153,23 @@ static inline void printk_nmi_enter(void) { }
 static inline void printk_nmi_exit(void) { }
 #endif /* PRINTK_NMI */
 
+struct printk_buffer {
+	unsigned short int size;
+	unsigned short int used;
+	char *buf;
+};
+
+#define DEFINE_PRINTK_BUFFER(name, size, buf)		\
+	struct printk_buffer name = { size, 0, buf }
+
+static inline void INIT_PRINTK_BUFFER(struct printk_buffer *ptr,
+				      unsigned short int size, char *buf)
+{
+	ptr->size = size;
+	ptr->used = 0;
+	ptr->buf = buf;
+}
+
 #ifdef CONFIG_PRINTK
 asmlinkage __printf(5, 0)
 int vprintk_emit(int facility, int level,
@@ -169,6 +186,9 @@ int printk_emit(int facility, int level,
 
 asmlinkage __printf(1, 2) __cold
 int printk(const char *fmt, ...);
+asmlinkage __printf(2, 3) __cold
+int buffered_printk(struct printk_buffer *ptr, const char *fmt, ...);
+void flush_buffered_printk(struct printk_buffer *ptr);
 
 /*
  * Special printk facility for scheduler/timekeeping use only, _DO_NOT_USE_ !
@@ -216,6 +236,14 @@ int printk(const char *s, ...)
 {
 	return 0;
 }
+static inline __printf(2, 3) __cold
+int buffered_printk(struct printk_buffer *ptr, const char *fmt, ...)
+{
+	return 0;
+}
+static inline void flush_buffered_printk(struct printk_buffer *ptr)
+{
+}
 static inline __printf(1, 2) __cold
 int printk_deferred(const char *s, ...)
 {
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2478083..24566dc 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1985,6 +1985,92 @@ asmlinkage __visible int printk(const char *fmt, ...)
 }
 EXPORT_SYMBOL(printk);
 
+static void __flush_printk_buffer(struct printk_buffer *ptr, bool all)
+{
+	while (1) {
+		char *text = ptr->buf;
+		unsigned int text_len = ptr->used;
+		char *cp = memchr(text, '\n', text_len);
+		char c;
+
+		if (cp++)
+			text_len = cp - text;
+		else if (all)
+			cp = text + text_len;
+		else
+			break;
+		c = *cp;
+		*cp = '\0';
+		printk("%s", text);
+		ptr->used -= text_len;
+		if (!ptr->used)
+			break;
+		*cp = c;
+		memmove(text, text + text_len, ptr->used);
+	}
+}
+
+/*
+ * buffered_printk - Try to print multiple printk() calls as line oriented.
+ *
+ * This is a utility function for avoiding KERN_CONT and pr_cont() usage.
+ *
+ * Before:
+ *
+ *   pr_info("INFO:");
+ *   for (i = 0; i < 5; i++)
+ *     pr_cont(" %s=%s", name[i], value[i]);
+ *   pr_cont("\n");
+ *
+ * After:
+ *
+ *   char buffer[256];
+ *   DEFINE_PRINTK_BUFFER(buf, sizeof(buffer), buffer);
+ *   buffered_printk(&buf, KERN_INFO "INFO:");
+ *   for (i = 0; i < 5; i++)
+ *     buffered_printk(&buf, " %s=%s", name[i], value[i]);
+ *   buffered_printk(&buf, "\n");
+ *
+ * If the caller is not sure that the last buffered_printk() call ends with
+ * "\n", the caller can use flush_buffered_printk() in order to make sure that
+ * all data is passed to printk().
+ *
+ * If the buffer is not large enough to hold one line, buffered_printk() will
+ * fall back to regular printk() instead of truncating the data. But be careful
+ * with LOG_LINE_MAX limit anyway.
+ */
+asmlinkage __visible int buffered_printk(struct printk_buffer *ptr,
+					 const char *fmt, ...)
+{
+	va_list args;
+	int r;
+	const unsigned int pos = ptr->used;
+
+	/* Try to store to printk_buffer first. */
+	va_start(args, fmt);
+	r = vsnprintf(ptr->buf + pos, ptr->size - pos, fmt, args);
+	va_end(args);
+	/* If it succeeds, process printk_buffer up to last '\n' and return. */
+	if (r + pos < ptr->size) {
+		ptr->used += r;
+		__flush_printk_buffer(ptr, false);
+		return r;
+	}
+	/* Otherwise, flush printk_buffer and use unbuffered printk(). */
+	__flush_printk_buffer(ptr, true);
+	va_start(args, fmt);
+	r = vprintk_func(fmt, args);
+	va_end(args);
+	return r;
+}
+EXPORT_SYMBOL(buffered_printk);
+
+void flush_buffered_printk(struct printk_buffer *ptr)
+{
+	__flush_printk_buffer(ptr, true);
+}
+EXPORT_SYMBOL(flush_buffered_printk);
+
 #else /* CONFIG_PRINTK */
 
 #define LOG_LINE_MAX		0
-- 
1.8.3.1

From 8f38ec70c9c444673e6bf2e699781cd143442ac6 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 27 Jun 2018 16:30:18 +0900
Subject: [PATCH 2/3] x86: Use buffered_printk() in show_opcodes()

Since syzbot is confused by concurrent printk() messages,
this patch changes show_opcodes() to use buffered_printk().

When we start adding prefix to each line of printk() output,
syzbot will be able to handle concurrent printk() messages.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 arch/x86/kernel/dumpstack.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 666a284..c284dd0 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -97,22 +97,24 @@ void show_opcodes(u8 *rip, const char *loglvl)
 	u8 opcodes[OPCODE_BUFSIZE];
 	u8 *ip;
 	int i;
+	char tmpbuf[(2 + 6) + (3 * OPCODE_BUFSIZE + 2) + 2];
+	DEFINE_PRINTK_BUFFER(buf, sizeof(tmpbuf), tmpbuf);
 
-	printk("%sCode: ", loglvl);
+	buffered_printk(&buf, "%sCode: ", loglvl);
 
 	ip = (u8 *)rip - code_prologue;
 	if (probe_kernel_read(opcodes, ip, OPCODE_BUFSIZE)) {
-		pr_cont("Bad RIP value.\n");
+		buffered_printk(&buf, "Bad RIP value.\n");
 		return;
 	}
 
 	for (i = 0; i < OPCODE_BUFSIZE; i++, ip++) {
 		if (ip == rip)
-			pr_cont("<%02x> ", opcodes[i]);
+			buffered_printk(&buf, "<%02x> ", opcodes[i]);
 		else
-			pr_cont("%02x ", opcodes[i]);
+			buffered_printk(&buf, "%02x ", opcodes[i]);
 	}
-	pr_cont("\n");
+	buffered_printk(&buf, "\n");
 }
 
 void show_ip(struct pt_regs *regs, const char *loglvl)
-- 
1.8.3.1

From 910520d0f5f366c86f5e4a2d5d344ae16e375604 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 27 Jun 2018 16:31:17 +0900
Subject: [PATCH 3/3] lockdep: Replace KERN_CONT/pr_cont() with
 buffered_printk()

Since syzbot is confused by concurrent printk() messages,
this patch eliminates KERN_CONT/pr_cont() usage from
kernel/locking/lockdep.c functions.

When we start adding prefix to each line of printk() output,
syzbot will be able to handle concurrent printk() messages.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 kernel/locking/lockdep.c | 248 +++++++++++++++++++++++------------------------
 1 file changed, 123 insertions(+), 125 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5fa4d31..b8d9aa6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -499,36 +499,38 @@ void get_usage_chars(struct lock_class *class, char usage[LOCK_USAGE_CHARS])
 	usage[i] = '\0';
 }
 
-static void __print_lock_name(struct lock_class *class)
+static void __print_lock_name(struct printk_buffer *buf, struct lock_class *class,
+			      const char *header, const char *trailer)
 {
 	char str[KSYM_NAME_LEN];
 	const char *name;
 
+	buffered_printk(buf, "%s", header);
 	name = class->name;
 	if (!name) {
 		name = __get_key_name(class->key, str);
-		printk(KERN_CONT "%s", name);
+		buffered_printk(buf, "%s", name);
 	} else {
-		printk(KERN_CONT "%s", name);
+		buffered_printk(buf, "%s", name);
 		if (class->name_version > 1)
-			printk(KERN_CONT "#%d", class->name_version);
+			buffered_printk(buf, "#%d", class->name_version);
 		if (class->subclass)
-			printk(KERN_CONT "/%d", class->subclass);
+			buffered_printk(buf, "/%d", class->subclass);
 	}
+	buffered_printk(buf, "%s", trailer);
 }
 
-static void print_lock_name(struct lock_class *class)
+static void print_lock_name(struct printk_buffer *buf, struct lock_class *class, const char *trailer)
 {
 	char usage[LOCK_USAGE_CHARS];
 
 	get_usage_chars(class, usage);
 
-	printk(KERN_CONT " (");
-	__print_lock_name(class);
-	printk(KERN_CONT "){%s}", usage);
+	__print_lock_name(buf, class, " (", ")");
+	buffered_printk(buf, "{%s}%s", usage, trailer);
 }
 
-static void print_lockdep_cache(struct lockdep_map *lock)
+static void print_lockdep_cache(struct printk_buffer *buf, struct lockdep_map *lock, const char *trailer)
 {
 	const char *name;
 	char str[KSYM_NAME_LEN];
@@ -537,11 +539,13 @@ static void print_lockdep_cache(struct lockdep_map *lock)
 	if (!name)
 		name = __get_key_name(lock->key->subkeys, str);
 
-	printk(KERN_CONT "%s", name);
+	buffered_printk(buf, "%s%s", name, trailer);
 }
 
-static void print_lock(struct held_lock *hlock)
+static void print_lock(struct printk_buffer *buf, struct held_lock *hlock)
 {
+	char tmpbuf[256];
+	DEFINE_PRINTK_BUFFER(buf2, sizeof(tmpbuf), tmpbuf);
 	/*
 	 * We can be called locklessly through debug_show_all_locks() so be
 	 * extra careful, the hlock might have been released and cleared.
@@ -551,19 +555,23 @@ static void print_lock(struct held_lock *hlock)
 	/* Don't re-read hlock->class_idx, can't use READ_ONCE() on bitfields: */
 	barrier();
 
+	if (!buf)
+		buf = &buf2;
 	if (!class_idx || (class_idx - 1) >= MAX_LOCKDEP_KEYS) {
-		printk(KERN_CONT "<RELEASED>\n");
+		buffered_printk(buf, "<RELEASED>\n");
 		return;
 	}
 
-	printk(KERN_CONT "%p", hlock->instance);
-	print_lock_name(lock_classes + class_idx - 1);
-	printk(KERN_CONT ", at: %pS\n", (void *)hlock->acquire_ip);
+	buffered_printk(buf, "%p", hlock->instance);
+	print_lock_name(buf, lock_classes + class_idx - 1, "");
+	buffered_printk(buf, ", at: %pS\n", (void *)hlock->acquire_ip);
 }
 
 static void lockdep_print_held_locks(struct task_struct *p)
 {
 	int i, depth = READ_ONCE(p->lockdep_depth);
+	char tmpbuf[256];
+	DEFINE_PRINTK_BUFFER(buf, sizeof(tmpbuf), tmpbuf);
 
 	if (!depth)
 		printk("no locks held by %s/%d.\n", p->comm, task_pid_nr(p));
@@ -577,8 +585,8 @@ static void lockdep_print_held_locks(struct task_struct *p)
 	if (p->state == TASK_RUNNING && p != current)
 		return;
 	for (i = 0; i < depth; i++) {
-		printk(" #%d: ", i);
-		print_lock(p->held_locks + i);
+		buffered_printk(&buf, " #%d: ", i);
+		print_lock(&buf, p->held_locks + i);
 	}
 }
 
@@ -812,10 +820,10 @@ static bool assign_lock_key(struct lockdep_map *lock)
 	if (verbose(class)) {
 		graph_unlock();
 
-		printk("\nnew class %px: %s", class->key, class->name);
 		if (class->name_version > 1)
-			printk(KERN_CONT "#%d", class->name_version);
-		printk(KERN_CONT "\n");
+			printk("\nnew class %px: %s#%d\n", class->key, class->name, class->name_version);
+		else
+			printk("\nnew class %px: %s\n", class->key, class->name);
 		dump_stack();
 
 		if (!graph_lock()) {
@@ -1089,11 +1097,13 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 static noinline int
 print_circular_bug_entry(struct lock_list *target, int depth)
 {
+	char tmpbuf[256];
+	DEFINE_PRINTK_BUFFER(buf, sizeof(tmpbuf), tmpbuf);
+
 	if (debug_locks_silent)
 		return 0;
-	printk("\n-> #%u", depth);
-	print_lock_name(target->class);
-	printk(KERN_CONT ":\n");
+	buffered_printk(&buf, "\n-> #%u", depth);
+	print_lock_name(&buf, target->class, ":\n");
 	print_stack_trace(&target->trace, 6);
 
 	return 0;
@@ -1107,6 +1117,8 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 	struct lock_class *source = hlock_class(src);
 	struct lock_class *target = hlock_class(tgt);
 	struct lock_class *parent = prt->class;
+	char tmpbuf[256];
+	DEFINE_PRINTK_BUFFER(buf, sizeof(tmpbuf), tmpbuf);
 
 	/*
 	 * A direct locking problem where unsafe_class lock is taken
@@ -1122,30 +1134,19 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 	 * from the safe_class lock to the unsafe_class lock.
 	 */
 	if (parent != source) {
-		printk("Chain exists of:\n  ");
-		__print_lock_name(source);
-		printk(KERN_CONT " --> ");
-		__print_lock_name(parent);
-		printk(KERN_CONT " --> ");
-		__print_lock_name(target);
-		printk(KERN_CONT "\n\n");
+		printk("Chain exists of:\n");
+		__print_lock_name(&buf, source, "  ", " --> ");
+		__print_lock_name(&buf, parent, "", " --> ");
+		__print_lock_name(&buf, target, "", "\n\n");
 	}
 
 	printk(" Possible unsafe locking scenario:\n\n");
 	printk("       CPU0                    CPU1\n");
 	printk("       ----                    ----\n");
-	printk("  lock(");
-	__print_lock_name(target);
-	printk(KERN_CONT ");\n");
-	printk("                               lock(");
-	__print_lock_name(parent);
-	printk(KERN_CONT ");\n");
-	printk("                               lock(");
-	__print_lock_name(target);
-	printk(KERN_CONT ");\n");
-	printk("  lock(");
-	__print_lock_name(source);
-	printk(KERN_CONT ");\n");
+	__print_lock_name(&buf, target, "  lock(", ");\n");
+	__print_lock_name(&buf, parent, "                               lock(", ");\n");
+	__print_lock_name(&buf, target, "                               lock(", ");\n");
+	__print_lock_name(&buf, source, "  lock(", ");\n");
 	printk("\n *** DEADLOCK ***\n\n");
 }
 
@@ -1170,11 +1171,11 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 	pr_warn("------------------------------------------------------\n");
 	pr_warn("%s/%d is trying to acquire lock:\n",
 		curr->comm, task_pid_nr(curr));
-	print_lock(check_src);
+	print_lock(NULL, check_src);
 
 	pr_warn("\nbut task is already holding lock:\n");
 
-	print_lock(check_tgt);
+	print_lock(NULL, check_tgt);
 	pr_warn("\nwhich lock already depends on the new lock.\n\n");
 	pr_warn("\nthe existing dependency chain (in reverse order) is:\n");
 
@@ -1394,18 +1395,19 @@ static inline int usage_match(struct lock_list *entry, void *bit)
 static void print_lock_class_header(struct lock_class *class, int depth)
 {
 	int bit;
+	char tmpbuf[256];
+	DEFINE_PRINTK_BUFFER(buf, sizeof(tmpbuf), tmpbuf);
 
-	printk("%*s->", depth, "");
-	print_lock_name(class);
-	printk(KERN_CONT " ops: %lu", class->ops);
-	printk(KERN_CONT " {\n");
+	buffered_printk(&buf, "%*s->", depth, "");
+	print_lock_name(&buf, class, "");
+	buffered_printk(&buf, " ops: %lu", class->ops);
+	buffered_printk(&buf, " {\n");
 
 	for (bit = 0; bit < LOCK_USAGE_STATES; bit++) {
 		if (class->usage_mask & (1 << bit)) {
 			int len = depth;
 
-			len += printk("%*s   %s", depth, "", usage_str[bit]);
-			len += printk(KERN_CONT " at:\n");
+			len += printk("%*s   %s at:\n", depth, "", usage_str[bit]);
 			print_stack_trace(class->usage_traces + bit, len);
 		}
 	}
@@ -1455,6 +1457,8 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 	struct lock_class *safe_class = safe_entry->class;
 	struct lock_class *unsafe_class = unsafe_entry->class;
 	struct lock_class *middle_class = prev_class;
+	char tmpbuf[256];
+	DEFINE_PRINTK_BUFFER(buf, sizeof(tmpbuf), tmpbuf);
 
 	if (middle_class == safe_class)
 		middle_class = next_class;
@@ -1473,32 +1477,21 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 	 * from the safe_class lock to the unsafe_class lock.
 	 */
 	if (middle_class != unsafe_class) {
-		printk("Chain exists of:\n  ");
-		__print_lock_name(safe_class);
-		printk(KERN_CONT " --> ");
-		__print_lock_name(middle_class);
-		printk(KERN_CONT " --> ");
-		__print_lock_name(unsafe_class);
-		printk(KERN_CONT "\n\n");
+		printk("Chain exists of:\n");
+		__print_lock_name(&buf, safe_class, "  ", " --> ");
+		__print_lock_name(&buf, middle_class, "", " --> ");
+		__print_lock_name(&buf, unsafe_class, "", "\n\n");
 	}
 
 	printk(" Possible interrupt unsafe locking scenario:\n\n");
 	printk("       CPU0                    CPU1\n");
 	printk("       ----                    ----\n");
-	printk("  lock(");
-	__print_lock_name(unsafe_class);
-	printk(KERN_CONT ");\n");
+	__print_lock_name(&buf, unsafe_class, "  lock(", ");\n");
 	printk("                               local_irq_disable();\n");
-	printk("                               lock(");
-	__print_lock_name(safe_class);
-	printk(KERN_CONT ");\n");
-	printk("                               lock(");
-	__print_lock_name(middle_class);
-	printk(KERN_CONT ");\n");
+	__print_lock_name(&buf, safe_class, "                               lock(", ");\n");
+	__print_lock_name(&buf, middle_class, "                               lock(", ");\n");
 	printk("  <Interrupt>\n");
-	printk("    lock(");
-	__print_lock_name(safe_class);
-	printk(KERN_CONT ");\n");
+	__print_lock_name(&buf, safe_class, "    lock(", ");\n");
 	printk("\n *** DEADLOCK ***\n\n");
 }
 
@@ -1514,6 +1507,9 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 			 enum lock_usage_bit bit2,
 			 const char *irqclass)
 {
+	char tmpbuf[256];
+	DEFINE_PRINTK_BUFFER(buf, sizeof(tmpbuf), tmpbuf);
+
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return 0;
 
@@ -1529,26 +1525,24 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 		curr->softirq_context, softirq_count() >> SOFTIRQ_SHIFT,
 		curr->hardirqs_enabled,
 		curr->softirqs_enabled);
-	print_lock(next);
+	print_lock(NULL, next);
 
 	pr_warn("\nand this task is already holding:\n");
-	print_lock(prev);
+	print_lock(NULL, prev);
 	pr_warn("which would create a new lock dependency:\n");
-	print_lock_name(hlock_class(prev));
-	pr_cont(" ->");
-	print_lock_name(hlock_class(next));
-	pr_cont("\n");
+	print_lock_name(&buf, hlock_class(prev), " ->");
+	print_lock_name(&buf, hlock_class(next), "\n");
 
 	pr_warn("\nbut this new dependency connects a %s-irq-safe lock:\n",
 		irqclass);
-	print_lock_name(backwards_entry->class);
-	pr_warn("\n... which became %s-irq-safe at:\n", irqclass);
+	print_lock_name(&buf, backwards_entry->class, "\n");
+	pr_warn("... which became %s-irq-safe at:\n", irqclass);
 
 	print_stack_trace(backwards_entry->class->usage_traces + bit1, 1);
 
 	pr_warn("\nto a %s-irq-unsafe lock:\n", irqclass);
-	print_lock_name(forwards_entry->class);
-	pr_warn("\n... which became %s-irq-unsafe at:\n", irqclass);
+	print_lock_name(&buf, forwards_entry->class, "\n");
+	pr_warn("... which became %s-irq-unsafe at:\n", irqclass);
 	pr_warn("...");
 
 	print_stack_trace(forwards_entry->class->usage_traces + bit2, 1);
@@ -1564,8 +1558,8 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 		return 0;
 	print_shortest_lock_dependencies(backwards_entry, prev_root);
 
-	pr_warn("\nthe dependencies between the lock to be acquired");
-	pr_warn(" and %s-irq-unsafe lock:\n", irqclass);
+	pr_warn("\nthe dependencies between the lock to be acquired and %s-irq-unsafe lock:\n",
+		irqclass);
 	if (!save_trace(&next_root->trace))
 		return 0;
 	print_shortest_lock_dependencies(forwards_entry, next_root);
@@ -1725,16 +1719,14 @@ static inline void inc_chains(void)
 {
 	struct lock_class *next = hlock_class(nxt);
 	struct lock_class *prev = hlock_class(prv);
+	char tmpbuf[256];
+	DEFINE_PRINTK_BUFFER(buf, sizeof(tmpbuf), tmpbuf);
 
 	printk(" Possible unsafe locking scenario:\n\n");
 	printk("       CPU0\n");
 	printk("       ----\n");
-	printk("  lock(");
-	__print_lock_name(prev);
-	printk(KERN_CONT ");\n");
-	printk("  lock(");
-	__print_lock_name(next);
-	printk(KERN_CONT ");\n");
+	__print_lock_name(&buf, prev, "  lock(", ");\n");
+	__print_lock_name(&buf, next, "  lock(", ");\n");
 	printk("\n *** DEADLOCK ***\n\n");
 	printk(" May be due to missing lock nesting notation\n\n");
 }
@@ -1753,9 +1745,9 @@ static inline void inc_chains(void)
 	pr_warn("--------------------------------------------\n");
 	pr_warn("%s/%d is trying to acquire lock:\n",
 		curr->comm, task_pid_nr(curr));
-	print_lock(next);
+	print_lock(NULL, next);
 	pr_warn("\nbut task is already holding lock:\n");
-	print_lock(prev);
+	print_lock(NULL, prev);
 
 	pr_warn("\nother info that might help us debug this:\n");
 	print_deadlock_scenario(next, prev);
@@ -2052,13 +2044,12 @@ static inline int get_first_held_lock(struct task_struct *curr,
 /*
  * Returns the next chain_key iteration
  */
-static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
+static u64 print_chain_key_iteration(struct printk_buffer *buf, int class_idx, u64 chain_key)
 {
 	u64 new_chain_key = iterate_chain_key(chain_key, class_idx);
 
-	printk(" class_idx:%d -> chain_key:%016Lx",
-		class_idx,
-		(unsigned long long)new_chain_key);
+	buffered_printk(buf, " class_idx:%d -> chain_key:%016Lx",
+			class_idx, (unsigned long long)new_chain_key);
 	return new_chain_key;
 }
 
@@ -2069,17 +2060,19 @@ static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
 	u64 chain_key = 0;
 	int depth = curr->lockdep_depth;
 	int i;
+	char tmpbuf[256];
+	DEFINE_PRINTK_BUFFER(buf, sizeof(tmpbuf), tmpbuf);
 
 	printk("depth: %u\n", depth + 1);
 	for (i = get_first_held_lock(curr, hlock_next); i < depth; i++) {
 		hlock = curr->held_locks + i;
-		chain_key = print_chain_key_iteration(hlock->class_idx, chain_key);
+		chain_key = print_chain_key_iteration(&buf, hlock->class_idx, chain_key);
 
-		print_lock(hlock);
+		print_lock(&buf, hlock);
 	}
 
-	print_chain_key_iteration(hlock_next->class_idx, chain_key);
-	print_lock(hlock_next);
+	print_chain_key_iteration(&buf, hlock_next->class_idx, chain_key);
+	print_lock(&buf, hlock_next);
 }
 
 static void print_chain_keys_chain(struct lock_chain *chain)
@@ -2087,14 +2080,15 @@ static void print_chain_keys_chain(struct lock_chain *chain)
 	int i;
 	u64 chain_key = 0;
 	int class_id;
+	char tmpbuf[256];
+	DEFINE_PRINTK_BUFFER(buf, sizeof(tmpbuf), tmpbuf);
 
 	printk("depth: %u\n", chain->depth);
 	for (i = 0; i < chain->depth; i++) {
 		class_id = chain_hlocks[chain->base + i];
-		chain_key = print_chain_key_iteration(class_id + 1, chain_key);
+		chain_key = print_chain_key_iteration(&buf, class_id + 1, chain_key);
 
-		print_lock_name(lock_classes + class_id);
-		printk("\n");
+		print_lock_name(&buf, lock_classes + class_id, "\n");
 	}
 }
 
@@ -2495,17 +2489,15 @@ static void check_chain_key(struct task_struct *curr)
 print_usage_bug_scenario(struct held_lock *lock)
 {
 	struct lock_class *class = hlock_class(lock);
+	char tmpbuf[256];
+	DEFINE_PRINTK_BUFFER(buf, sizeof(tmpbuf), tmpbuf);
 
 	printk(" Possible unsafe locking scenario:\n\n");
 	printk("       CPU0\n");
 	printk("       ----\n");
-	printk("  lock(");
-	__print_lock_name(class);
-	printk(KERN_CONT ");\n");
+	__print_lock_name(&buf, class, "  lock(", ");\n");
 	printk("  <Interrupt>\n");
-	printk("    lock(");
-	__print_lock_name(class);
-	printk(KERN_CONT ");\n");
+	__print_lock_name(&buf, class, "    lock(", ");\n");
 	printk("\n *** DEADLOCK ***\n\n");
 }
 
@@ -2531,7 +2523,7 @@ static void check_chain_key(struct task_struct *curr)
 		trace_softirq_context(curr), softirq_count() >> SOFTIRQ_SHIFT,
 		trace_hardirqs_enabled(curr),
 		trace_softirqs_enabled(curr));
-	print_lock(this);
+	print_lock(NULL, this);
 
 	pr_warn("{%s} state was registered at:\n", usage_str[prev_bit]);
 	print_stack_trace(hlock_class(this)->usage_traces + prev_bit, 1);
@@ -2577,6 +2569,8 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	struct lock_list *entry = other;
 	struct lock_list *middle = NULL;
 	int depth;
+	char tmpbuf[256];
+	DEFINE_PRINTK_BUFFER(buf, sizeof(tmpbuf), tmpbuf);
 
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return 0;
@@ -2588,13 +2582,13 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	pr_warn("--------------------------------------------------------\n");
 	pr_warn("%s/%d just changed the state of lock:\n",
 		curr->comm, task_pid_nr(curr));
-	print_lock(this);
+	print_lock(NULL, this);
 	if (forwards)
 		pr_warn("but this lock took another, %s-unsafe lock in the past:\n", irqclass);
 	else
 		pr_warn("but this lock was taken by another, %s-safe lock in the past:\n", irqclass);
-	print_lock_name(other->class);
-	pr_warn("\n\nand interrupts could create inverse lock ordering between them.\n\n");
+	print_lock_name(&buf, other->class, "\n\n");
+	pr_warn("and interrupts could create inverse lock ordering between them.\n\n");
 
 	pr_warn("\nother info that might help us debug this:\n");
 
@@ -3169,7 +3163,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	 */
 	if (ret == 2) {
 		printk("\nmarked lock as {%s}:\n", usage_str[new_bit]);
-		print_lock(this);
+		print_lock(NULL, this);
 		print_irqtrace_events(curr);
 		dump_stack();
 	}
@@ -3264,7 +3258,7 @@ void lockdep_init_map(struct lockdep_map *lock, const char *name,
 	pr_warn("----------------------------------\n");
 
 	pr_warn("%s/%d is trying to lock:\n", curr->comm, task_pid_nr(curr));
-	print_lock(hlock);
+	print_lock(NULL, hlock);
 
 	pr_warn("\nbut this task is not holding:\n");
 	pr_warn("%s\n", hlock->nest_lock->name);
@@ -3326,10 +3320,10 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	}
 	atomic_inc((atomic_t *)&class->ops);
 	if (very_verbose(class)) {
-		printk("\nacquire class [%px] %s", class->key, class->name);
 		if (class->name_version > 1)
-			printk(KERN_CONT "#%d", class->name_version);
-		printk(KERN_CONT "\n");
+			printk("\nacquire class [%px] %s#%d\n", class->key, class->name, class->name_version);
+		else
+			printk("\nacquire class [%px] %s\n", class->key, class->name);
 		dump_stack();
 	}
 
@@ -3465,6 +3459,9 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 print_unlock_imbalance_bug(struct task_struct *curr, struct lockdep_map *lock,
 			   unsigned long ip)
 {
+	char tmpbuf[256];
+	DEFINE_PRINTK_BUFFER(buf, sizeof(tmpbuf), tmpbuf);
+
 	if (!debug_locks_off())
 		return 0;
 	if (debug_locks_silent)
@@ -3475,10 +3472,9 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	pr_warn("WARNING: bad unlock balance detected!\n");
 	print_kernel_ident();
 	pr_warn("-------------------------------------\n");
-	pr_warn("%s/%d is trying to release lock (",
-		curr->comm, task_pid_nr(curr));
-	print_lockdep_cache(lock);
-	pr_cont(") at:\n");
+	buffered_printk(&buf, KERN_WARNING "%s/%d is trying to release lock (",
+			curr->comm, task_pid_nr(curr));
+	print_lockdep_cache(&buf, lock, ") at:\n");
 	print_ip_sym(ip);
 	pr_warn("but there are no more locks to release!\n");
 	pr_warn("\nother info that might help us debug this:\n");
@@ -4026,6 +4022,9 @@ void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 print_lock_contention_bug(struct task_struct *curr, struct lockdep_map *lock,
 			   unsigned long ip)
 {
+	char tmpbuf[256];
+	DEFINE_PRINTK_BUFFER(buf, sizeof(tmpbuf), tmpbuf);
+
 	if (!debug_locks_off())
 		return 0;
 	if (debug_locks_silent)
@@ -4036,10 +4035,9 @@ void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 	pr_warn("WARNING: bad contention detected!\n");
 	print_kernel_ident();
 	pr_warn("---------------------------------\n");
-	pr_warn("%s/%d is trying to contend lock (",
-		curr->comm, task_pid_nr(curr));
-	print_lockdep_cache(lock);
-	pr_cont(") at:\n");
+	buffered_printk(&buf, KERN_WARNING "%s/%d is trying to contend lock (",
+			curr->comm, task_pid_nr(curr));
+	print_lockdep_cache(&buf, lock, ") at:\n");
 	print_ip_sym(ip);
 	pr_warn("but there are no locks held!\n");
 	pr_warn("\nother info that might help us debug this:\n");
@@ -4382,7 +4380,7 @@ void __init lockdep_info(void)
 	pr_warn("-------------------------\n");
 	pr_warn("%s/%d is freeing memory %px-%px, with a lock still held there!\n",
 		curr->comm, task_pid_nr(curr), mem_from, mem_to-1);
-	print_lock(hlock);
+	print_lock(NULL, hlock);
 	lockdep_print_held_locks(curr);
 
 	pr_warn("\nstack backtrace:\n");
-- 
1.8.3.1
