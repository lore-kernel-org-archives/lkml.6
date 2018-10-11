Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721E3C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C284520835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C284520835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbeJKRr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:47:28 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:36569 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeJKRr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:47:28 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9BAKkFi008523;
        Thu, 11 Oct 2018 19:20:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Thu, 11 Oct 2018 19:20:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9BAKerL008351
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 11 Oct 2018 19:20:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Dmitriy Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180928090939.GE1160@jagdpanzerIV>
 <3b378c7d-c613-4a8d-67f8-946fac8ad0b0@i-love.sakura.ne.jp>
 <20180929105151.GA1392@tigerII.localdomain>
 <91efcff8-dc6d-b7b4-9ac8-2f3882289f95@i-love.sakura.ne.jp>
 <20181001023721.GA6409@jagdpanzerIV>
 <880ef52f-dff7-af91-5353-f63513265ffe@i-love.sakura.ne.jp>
 <20181002063851.GF598@jagdpanzerIV>
 <5a958a1b-a986-014a-5908-816e0a3ef4ff@i-love.sakura.ne.jp>
 <20181008160310.ldwryudzkvp5de3b@pathway.suse.cz>
 <3ce1695b-9c47-40cc-602b-7c5ffb593024@i-love.sakura.ne.jp>
 <20181009145229.3lv5vl2ypz5i45cq@pathway.suse.cz>
 <a4a2ecae-3c47-db1f-8124-4d2d0ab8b91c@i-love.sakura.ne.jp>
 <d3e76073-c896-5807-1a2d-fe320643617d@i-love.sakura.ne.jp>
Message-ID: <3a7a180a-b644-bb0c-54e0-21dc3eb1d83b@i-love.sakura.ne.jp>
Date:   Thu, 11 Oct 2018 19:20:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d3e76073-c896-5807-1a2d-fe320643617d@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/10 19:14, Tetsuo Handa wrote:
> On 2018/10/10 6:19, Tetsuo Handa wrote:
>> Do you think that adding cmpxchg() & retry logic to this API generates better
>> result than simple fallback? buffered_printk() does not add a new locking dependency
>> is a good point of this API. Showing the backtrace (by enabling a debug kernel config
>> option for this API) will be sufficient.
>>
> 
> This is an idea for reporting out of buffers event. I would add a kernel config
> option for whether to report that event. Maybe I should offload the reporting
> to a workqueue context, for reporting from get_printk_context() requires that
> get_printk_context() callers have to be printk()-safe, and
> get_printk_context() callers might be already in vprintk_safe()/vprintk_nmi()
> context even if it is possible to call printk().
> 

I dropped DEFINE_PRINTK_BUFFER() in order to hide "struct printk_buffer" because
I added reporting functionality for out of static "struct printk_buffer" and
made that number configurable at kernel compile option. I think we can start
evaluating with only static buffers. Then, we will consider whether we need to
expose "struct printk_buffer" in order to allow allocating from kernel stack
memory. Maybe allocating from slab memory is sufficient if someone happened to
want to reserve several "struct printk_buffer" buffers for its lifetime.

Thus, here is v4.

From a65f018d563928c7b7e4a9bec1d1a564dd8b4635 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Thu, 11 Oct 2018 14:21:22 +0900
Subject: [PATCH v4] printk: Add line-buffered printk() API.

Sometimes we want to print a whole line without being disturbed by
concurrent printk() from interrupts and/or other threads, for printk()
which does not end with '\n' can be disturbed.

Mixed printk() output makes it hard to interpret. Assuming that we will go
to a direction that we allow prefixing context identifier to each line of
printk() output (so that we can group multiple lines into one block when
parsing), this patch introduces API for line-buffered printk() output
(so that we can make sure that printk() ends with '\n').

Since functions introduced by this patch are merely wrapping
printk()/vprintk() calls in order to minimize possibility of using
"struct cont", it is safe to replace printk()/vprintk() with this API.

Details:

  A structure named "struct printk_buffer" is introduced for buffering
  up to LOG_LINE_MAX bytes of printk() output which did not end with '\n'.

  get_printk_buffer() tries to assign a "struct printk_buffer" from
  statically preallocated array. get_printk_buffer() returns NULL if
  all "struct printk_buffer" are in use, but the caller does not need to
  check for NULL.

  put_printk_buffer() flushes and releases the "struct printk_buffer".
  put_printk_buffer() must match corresponding get_printk_buffer() as with
  rcu_read_unlock() must match corresponding rcu_read_lock().

  Three functions buffered_vprintk(), buffered_printk() and
  flush_printk_buffer() are provided for using "struct printk_buffer".
  These are like vfprintf(), fprintf(), fflush() except that these receive
  "struct printk_buffer *" for the first argument.

  buffered_vprintk() and buffered_printk() behave like vprintk() and
  printk() respectively if "struct printk_buffer *" argument is NULL.
  flush_printk_buffer() and put_printk_buffer() become no-op if
  "struct printk_buffer *" argument is NULL. Therefore, the caller of
  get_printk_buffer() does not need to check for NULL.

How to configure this API:

  For those who want to save memory footprint, this API is enabled only
  if CONFIG_PRINTK_LINE_BUFFERED option is selected.

  For those who want to tune the number of statically preallocated
  buffers, CONFIG_PRINTK_NUM_LINE_BUFFERS option is available. The default
  value is 16. Since "struct printk_buffer" makes difference only when
  there are multiple threads concurrently calling printk() which does not
  end with '\n', and this API will fallback to normal printk() when all
  CONFIG_PRINTK_NUM_LINE_BUFFERS buffers are in use, you won't need to
  specify a large number.

  But somebody might forget to call put_printk_buffer(). For those who
  want to know why all CONFIG_PRINTK_NUM_LINE_BUFFERS buffers are in use,
  CONFIG_PRINTK_REPORT_OUT_OF_LINE_BUFFERS option is available.
  This option reports when/where get_printk_buffer() was called and
  put_printk_buffer() is not yet called, up to once per a minute.

How to use this API:

  (1) Call get_printk_buffer() and acquire "struct printk_buffer *".

  (2) Rewrite printk() calls in the following way. The "ptr" is
      "struct printk_buffer *" obtained in step (1).

      printk(fmt, ...)     => buffered_printk(ptr, fmt, ...)
      vprintk(fmt, args)   => buffered_vprintk(ptr, fmt, args)
      pr_emerg(fmt, ...)   => bpr_emerg(ptr, fmt, ...)
      pr_alert(fmt, ...)   => bpr_alert(ptr, fmt, ...)
      pr_crit(fmt, ...)    => bpr_crit(ptr, fmt, ...)
      pr_err(fmt, ...)     => bpr_err(ptr, fmt, ...)
      pr_warning(fmt, ...) => bpr_warning(ptr, fmt, ...)
      pr_warn(fmt, ...)    => bpr_warn(ptr, fmt, ...)
      pr_notice(fmt, ...)  => bpr_notice(ptr, fmt, ...)
      pr_info(fmt, ...)    => bpr_info(ptr, fmt, ...)
      pr_cont(fmt, ...)    => bpr_cont(ptr, fmt, ...)

  (3) Release "struct printk_buffer" by calling put_printk_buffer().

Note that since "struct printk_buffer" buffers only up to one line, there
is no need to rewrite if it is known that the "struct printk_buffer" is
empty and printk() ends with '\n'.

  Good example:

    printk("Hello ");    =>  buf = get_printk_buffer();
    pr_cont("world.\n");     buffered_printk(buf, "Hello ");
                             buffered_printk(buf, "world.\n");
                             put_printk_buffer(buf);

  Pointless example:

    printk("Hello\n");   =>  buf = get_printk_buffer();
    printk("World.\n");      buffered_printk(buf, "Hello\n");
                             buffered_printk(buf, "World.\n");
                             put_printk_buffer(buf);

Note that bpr_devel() and bpr_debug() are not defined. This is
because pr_devel()/pr_debug() should not be followed by pr_cont()
because pr_devel()/pr_debug() are conditionally enabled; output from
pr_devel()/pr_debug() should always end with '\n'.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/printk.h |  41 +++++++++
 init/Kconfig           |  31 +++++++
 kernel/printk/printk.c | 239 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 311 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index cf3eccf..f93d9c8 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -286,6 +286,30 @@ static inline void printk_safe_flush_on_panic(void)
 }
 #endif
 
+struct printk_buffer;
+#if defined(CONFIG_PRINTK_LINE_BUFFERED)
+struct printk_buffer *get_printk_buffer(void);
+void flush_printk_buffer(struct printk_buffer *ptr);
+__printf(2, 3)
+int buffered_printk(struct printk_buffer *ptr, const char *fmt, ...);
+__printf(2, 0)
+int buffered_vprintk(struct printk_buffer *ptr, const char *fmt, va_list args);
+void put_printk_buffer(struct printk_buffer *ptr);
+#else
+static inline struct printk_buffer *get_printk_buffer(void)
+{
+	return NULL;
+}
+static inline void flush_printk_buffer(struct printk_buffer *ptr)
+{
+}
+#define buffered_printk(ptr, fmt, ...) printk(fmt, ##__VA_ARGS__)
+#define buffered_vprintk(ptr, fmt, args) vprintk(fmt, args)
+static inline void put_printk_buffer(struct printk_buffer *ptr)
+{
+}
+#endif
+
 extern int kptr_restrict;
 
 #ifndef pr_fmt
@@ -300,19 +324,34 @@ static inline void printk_safe_flush_on_panic(void)
  */
 #define pr_emerg(fmt, ...) \
 	printk(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
+#define bpr_emerg(ptr, fmt, ...) \
+	buffered_printk(ptr, KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_alert(fmt, ...) \
 	printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
+#define bpr_alert(ptr, fmt, ...) \
+	buffered_printk(ptr, KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_crit(fmt, ...) \
 	printk(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
+#define bpr_crit(ptr, fmt, ...) \
+	buffered_printk(ptr, KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_err(fmt, ...) \
 	printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
+#define bpr_err(ptr, fmt, ...) \
+	buffered_printk(ptr, KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_warning(fmt, ...) \
 	printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
+#define bpr_warning(ptr, fmt, ...) \
+	buffered_printk(ptr, KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_warn pr_warning
+#define bpr_warn bpr_warning
 #define pr_notice(fmt, ...) \
 	printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
+#define bpr_notice(ptr, fmt, ...) \
+	buffered_printk(ptr, KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_info(fmt, ...) \
 	printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
+#define bpr_info(ptr, fmt, ...) \
+	buffered_printk(ptr, KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
 /*
  * Like KERN_CONT, pr_cont() should only be used when continuing
  * a line with no newline ('\n') enclosed. Otherwise it defaults
@@ -320,6 +359,8 @@ static inline void printk_safe_flush_on_panic(void)
  */
 #define pr_cont(fmt, ...) \
 	printk(KERN_CONT fmt, ##__VA_ARGS__)
+#define bpr_cont(ptr, fmt, ...) \
+	buffered_printk(ptr, KERN_CONT fmt, ##__VA_ARGS__)
 
 /* pr_devel() should produce zero code unless DEBUG is defined */
 #ifdef DEBUG
diff --git a/init/Kconfig b/init/Kconfig
index 1e234e2..1fb01de 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -604,6 +604,37 @@ config PRINTK_SAFE_LOG_BUF_SHIFT
 		     13 =>   8 KB for each CPU
 		     12 =>   4 KB for each CPU
 
+config PRINTK_LINE_BUFFERED
+	bool "Allow line buffered printk()"
+	default y
+	depends on PRINTK
+	help
+	  The line buffered printk() tries to buffer printk() output up to '\n'
+	  so that incomplete lines won't be mixed when there are multiple
+	  threads concurrently calling printk() which does not end with '\n'.
+
+config PRINTK_NUM_LINE_BUFFERS
+	int "Number of buffers for line buffered printk()"
+	range 1 4096
+	default 16
+	depends on PRINTK_LINE_BUFFERED
+	help
+	  Specify the number of statically preallocated "struct printk_buffer"
+	  for line buffered printk(). You don't need to specify a large number
+	  here because "struct printk_buffer" makes difference only when there
+	  are multiple threads concurrently calling printk() which does not end
+	  with '\n', and line buffered printk() will fallback to normal
+	  printk() when out of statically preallocated "struct printk_buffer"
+	  happened.
+
+config PRINTK_REPORT_OUT_OF_LINE_BUFFERS
+	bool "Report out of buffers for line buffered printk()"
+	default n
+	depends on PRINTK_LINE_BUFFERED && STACKTRACE
+	help
+	  Select this if you want to know who is using statically preallocated
+	  "struct printk_buffer" when out of "struct printk_buffer" happened.
+
 #
 # Architectures with an unreliable sched_clock() should select this:
 #
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9bf5404..afc8bed 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1949,6 +1949,245 @@ asmlinkage int printk_emit(int facility, int level,
 }
 EXPORT_SYMBOL(printk_emit);
 
+#ifdef CONFIG_PRINTK_LINE_BUFFERED
+/*
+ * A structure for line-buffered printk() output.
+ */
+static struct printk_buffer {
+	unsigned short int used; /* Valid bytes in buf[]. */
+	char buf[LOG_LINE_MAX];
+} printk_buffers[CONFIG_PRINTK_NUM_LINE_BUFFERS] __aligned(1024);
+static DECLARE_BITMAP(printk_buffers_in_use, CONFIG_PRINTK_NUM_LINE_BUFFERS);
+
+
+#ifdef CONFIG_PRINTK_REPORT_OUT_OF_LINE_BUFFERS
+static struct {
+	unsigned long stamp;
+	struct stack_trace trace;
+	unsigned long entries[20];
+} printk_buffers_dump[CONFIG_PRINTK_NUM_LINE_BUFFERS];
+static int buffer_users_report_scheduled;
+
+static void reset_holdoff_flag(struct timer_list *timer)
+{
+	buffer_users_report_scheduled = 0;
+}
+static DEFINE_TIMER(buffer_users_holdoff_timer, reset_holdoff_flag);
+
+static void report_buffer_users(struct work_struct *work)
+{
+	long i;
+	unsigned int j;
+
+	/*
+	 * This report is racy. But it does not worth introducing a lock
+	 * dependency.
+	 */
+	pr_info("printk: All line buffers are in use.\n");
+	for (i = 0; i < CONFIG_PRINTK_NUM_LINE_BUFFERS; i++) {
+		if (!test_bit(i, printk_buffers_in_use))
+			continue;
+		pr_info("buffer[%lu] was reserved %lu jiffies ago by\n",
+			i, jiffies - printk_buffers_dump[i].stamp);
+		for (j = 0; j < printk_buffers_dump[i].trace.nr_entries; j++)
+			pr_info("  %pS\n", (void *)
+				printk_buffers_dump[i].entries[j]);
+		cond_resched();
+	}
+	/* Wait for at least 60 seconds before reporting again. */
+	mod_timer(&buffer_users_holdoff_timer, jiffies + 60 * HZ);
+}
+#endif
+
+/**
+ * get_printk_buffer - Try to get printk_buffer.
+ *
+ * Returns pointer to "struct printk_buffer" on success, NULL otherwise.
+ *
+ * If this function returned "struct printk_buffer", the caller is responsible
+ * for passing it to put_printk_buffer() so that "struct printk_buffer" can be
+ * reused in the future.
+ *
+ * Even if this function returned NULL, the caller does not need to check for
+ * NULL, for passing NULL to buffered_printk() simply acts like normal printk()
+ * and passing NULL to flush_printk_buffer()/put_printk_buffer() is a no-op.
+ */
+struct printk_buffer *get_printk_buffer(void)
+{
+#ifdef CONFIG_PRINTK_REPORT_OUT_OF_LINE_BUFFERS
+	static DECLARE_WORK(work, report_buffer_users);
+#endif
+	long i;
+
+	for (i = 0; i < CONFIG_PRINTK_NUM_LINE_BUFFERS; i++) {
+		if (test_bit(i, printk_buffers_in_use) ||
+		    test_and_set_bit(i, printk_buffers_in_use))
+			continue;
+		printk_buffers[i].used = 0;
+#ifdef CONFIG_PRINTK_REPORT_OUT_OF_LINE_BUFFERS
+		printk_buffers_dump[i].stamp = jiffies;
+		printk_buffers_dump[i].trace.nr_entries = 0;
+		printk_buffers_dump[i].trace.entries =
+			printk_buffers_dump[i].entries;
+		printk_buffers_dump[i].trace.max_entries = 20;
+		printk_buffers_dump[i].trace.skip = 0;
+		save_stack_trace(&printk_buffers_dump[i].trace);
+#endif
+		return &printk_buffers[i];
+	}
+#ifdef CONFIG_PRINTK_REPORT_OUT_OF_LINE_BUFFERS
+	/*
+	 * Oops, out of "struct printk_buffer" happened. Fallback to normal
+	 * printk(). You might notice it by partial lines being printed.
+	 *
+	 * If you think that it might be due to missing put_printk_buffer()
+	 * calls, you can enable CONFIG_PRINTK_REPORT_OUT_OF_LINE_BUFFERS.
+	 * Then, who is using the buffers will be reported (from workqueue
+	 * context because reporting CONFIG_PRINTK_NUM_LINE_BUFFERS entries
+	 * from atomic context might be too slow). If it does not look like
+	 * missing put_printk_buffer() calls, you might want to increase
+	 * CONFIG_PRINTK_NUM_LINE_BUFFERS.
+	 *
+	 * But if it turns out that allocating "struct printk_buffer" on stack
+	 * or in .bss section or from kzalloc() is more suitable than tuning
+	 * CONFIG_PRINTK_NUM_LINE_BUFFERS, we can update to do so.
+	 */
+	if (!in_nmi() && !cmpxchg(&buffer_users_report_scheduled, 0, 1))
+		queue_work(system_unbound_wq, &work);
+#endif
+	return NULL;
+}
+EXPORT_SYMBOL(get_printk_buffer);
+
+/**
+ * buffered_vprintk - Try to vprintk() in line buffered mode.
+ *
+ * @ptr:  Pointer to "struct printk_buffer". It can be NULL.
+ * @fmt:  printk() format string.
+ * @args: va_list structure.
+ *
+ * Returns the return value of vprintk().
+ *
+ * Try to store to @ptr first. If it fails, flush @ptr and then try to store to
+ * @ptr again. If it still fails, use unbuffered printing.
+ */
+int buffered_vprintk(struct printk_buffer *ptr, const char *fmt, va_list args)
+{
+	va_list tmp_args;
+	unsigned short int i;
+	int r;
+
+	if (!ptr)
+		goto unbuffered;
+	for (i = 0; i < 2; i++) {
+		unsigned int pos = ptr->used;
+		char *text = ptr->buf + pos;
+
+		va_copy(tmp_args, args);
+		r = vsnprintf(text, sizeof(ptr->buf) - pos, fmt, tmp_args);
+		va_end(tmp_args);
+		if (r + pos < sizeof(ptr->buf)) {
+			/*
+			 * Eliminate KERN_CONT at this point because we can
+			 * concatenate incomplete lines inside printk_buffer.
+			 */
+			if (r >= 2 && printk_get_level(text) == 'c') {
+				memmove(text, text + 2, r - 2);
+				ptr->used += r - 2;
+			} else {
+				ptr->used += r;
+			}
+			/* Flush already completed lines if any. */
+			while (1) {
+				char *cp = memchr(ptr->buf, '\n', ptr->used);
+
+				if (!cp)
+					break;
+				*cp = '\0';
+				printk("%s\n", ptr->buf);
+				i = cp - ptr->buf + 1;
+				ptr->used -= i;
+				memmove(ptr->buf, ptr->buf + i, ptr->used);
+			}
+			return r;
+		}
+		if (i)
+			break;
+		flush_printk_buffer(ptr);
+	}
+ unbuffered:
+	return vprintk(fmt, args);
+}
+
+/**
+ * buffered_printk - Try to printk() in line buffered mode.
+ *
+ * @ptr:  Pointer to "struct printk_buffer". It can be NULL.
+ * @fmt:  printk() format string, followed by arguments.
+ *
+ * Returns the return value of printk().
+ *
+ * Try to store to @ptr first. If it fails, flush @ptr and then try to store to
+ * @ptr again. If it still fails, use unbuffered printing.
+ */
+int buffered_printk(struct printk_buffer *ptr, const char *fmt, ...)
+{
+	va_list args;
+	int r;
+
+	va_start(args, fmt);
+	r = buffered_vprintk(ptr, fmt, args);
+	va_end(args);
+	return r;
+}
+EXPORT_SYMBOL(buffered_printk);
+
+/**
+ * flush_printk_buffer - Flush incomplete line in printk_buffer.
+ *
+ * @ptr: Pointer to "struct printk_buffer". It can be NULL.
+ *
+ * Returns nothing.
+ *
+ * Flush if @ptr contains partial data. But usually there is no need to call
+ * this function because @ptr is flushed by put_printk_buffer().
+ */
+void flush_printk_buffer(struct printk_buffer *ptr)
+{
+	if (!ptr || !ptr->used)
+		return;
+	/* buffered_vprintk() keeps 0 <= ptr->used < sizeof(ptr->buf) true. */
+	ptr->buf[ptr->used] = '\0';
+	printk("%s", ptr->buf);
+	ptr->used = 0;
+}
+EXPORT_SYMBOL(flush_printk_buffer);
+
+/**
+ * put_printk_buffer - Release printk_buffer.
+ *
+ * @ptr: Pointer to "struct printk_buffer". It can be NULL.
+ *
+ * Returns nothing.
+ *
+ * Flush and release @ptr.
+ */
+void put_printk_buffer(struct printk_buffer *ptr)
+{
+	long i = ptr - printk_buffers;
+
+	if (!ptr || i < 0 || i >= CONFIG_PRINTK_NUM_LINE_BUFFERS)
+		return;
+	if (ptr->used)
+		flush_printk_buffer(ptr);
+	/* Make sure in_use flag is cleared after setting ptr->used = 0. */
+	wmb();
+	clear_bit(i, printk_buffers_in_use);
+}
+EXPORT_SYMBOL(put_printk_buffer);
+
+#endif
+
 int vprintk_default(const char *fmt, va_list args)
 {
 	int r;
-- 
1.8.3.1

