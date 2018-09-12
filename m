Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A873C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54FE20833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFoT27qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54FE20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeILL4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 07:56:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35152 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeILL4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 07:56:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so528839pfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 23:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZarQ2g6giEczKrUxmwPElzSVCv3J2O/TJ9CWdefMAIA=;
        b=KFoT27qy59kLpQe2alY249UVDb9AxQILmRI0NcUfJ4EIp0g/Pd1jNjzFgtwxJ/Xu47
         kEMzfnsY6ZFXJ15Qvn3bVaRiYUMLBBYWf6xCg+o7NQXeVYJbuG6HiyExaBPOoa86x6Yq
         WUY5DGi0k+LyTaeCC9N7WWDF3MYjv8Z4mb6La+KWG3y+sOmmyLP6ypWDBF33TRsczHjm
         PNHjAtp6zp0FvCPvKLRIDUtayvjN2KZEkvDH7flBP+Ss/IOTYaiJ7T6E9wrJO6oUmcmp
         FIbH54RWq+mWtIcPcoUohi7sGpO7yCWlpHQPGrT/wSH38GzvkWVgDRQV+796lAEQnnzI
         8hGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZarQ2g6giEczKrUxmwPElzSVCv3J2O/TJ9CWdefMAIA=;
        b=hR9TGs4EsZ9YketlGclojL7sosoU9fZ3hKNkT2/dGcv2B6o3V1KNJPF5n9XqkWIyKp
         UxUDEs8I2vcvhVAFWteTNkPbzRpKx5rKROqpDu39SangD8EmzksIb63DNTwXZKvmgXWk
         /XHp9KDfw+jzzCdwla347MHzNZtg6o2yDVbXpis03/b2BM8nBw0OL+7+DreX69lAQbfR
         lbDY9ussd2pH8oQCmTr/dzknff+B8aXSfMQ7a435EMFK8/bB8cQjIo9aBoEzsGyZzHwl
         LSJnNj5tqM7agxjNPDywXaN6H2yUxmaRAR93XQRkXLMsDv2RIW4p50C3Re7HDsEeO21x
         wDBQ==
X-Gm-Message-State: APzg51BCAia/H1LQIXTyn8L7pf84WQTCGLPgcXpeSAXoUlRATOZcs8Tr
        +0Z2CQlhUh0TMloR8uPg12M=
X-Google-Smtp-Source: ANB0VdZDM0Xu+IqXTzMoAIyY/R2i7O3W/hT5sbkYuH+PHcvkcyTurT/k20N/uGLW+WZMOdN30swckg==
X-Received: by 2002:a62:4898:: with SMTP id q24-v6mr548973pfi.22.1536735194166;
        Tue, 11 Sep 2018 23:53:14 -0700 (PDT)
Received: from localhost ([175.223.23.50])
        by smtp.gmail.com with ESMTPSA id s14-v6sm438483pfj.105.2018.09.11.23.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 23:53:11 -0700 (PDT)
Date:   Wed, 12 Sep 2018 15:53:07 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        kbuild test robot <fengguang.wu@intel.com>,
        sergey.senozhatsky.work@gmail.com, pmladek@suse.com,
        syzkaller <syzkaller@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180912065307.GA606@jagdpanzerIV>
References: <CACT4Y+ZGSefrYL9xtQs=yPMRNFsOUumuJXsShJPhCOBSLySxuw@mail.gmail.com>
 <20180620083126.GA477@jagdpanzerIV>
 <CACT4Y+YMubTm1xduj+XCbQnNwQxYFLjBT33cFKisN1HyeaBpZw@mail.gmail.com>
 <20180620090413.GA444@jagdpanzerIV>
 <20180620091541.GB444@jagdpanzerIV>
 <CACT4Y+bcp4fSBBq3F86T-C4+n-YkeXUGMqpvkJ6vj6mK-TU2EA@mail.gmail.com>
 <20180620110759.GD444@jagdpanzerIV>
 <CACT4Y+aER3O2x2ApM=MVFoFXhp_T_rUeyG9CBx031qyH0voSRg@mail.gmail.com>
 <20180620130628.GA1000@tigerII.localdomain>
 <CAG_fn=XuZo5yrZzVizP26iV6eFfJtAHUs4NsDFXFyvnaJkdSQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=XuZo5yrZzVizP26iV6eFfJtAHUs4NsDFXFyvnaJkdSQw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/10/18 13:20), Alexander Potapenko wrote:
> > Awesome. If you and Fengguang can combine forces and lead the
> > whole thing towards "we couldn't care of pr_cont() less", it
> > would be really huuuuuge. Go for it!
> 
> Sorry, folks, am I understanding right that pr_cont() and flushing the
> buffer on "\n" are two separate problems that can be handled outside
> Tetsuo's patchset, just assuming pr_cont() is unsupported?
> Or should the pr_cont() cleanup be a prerequisite for that?

Oh... Sorry. I'm quite overloaded at the moment and simply forgot about
this thread.

So what is exactly our problem with pr_cont -- it's not SMP friendly.
And this leads to various things, the most annoying of which is a
preliminary flush.

E.g. let me do a simple thing on my box:

ps aux | grep firefox
kill 2727

dmesg | tail
[  554.098341] Chrome_~dThread[2823]: segfault at 0 ip 00007f5df153a1f3 sp 00007f5ded47ab00 error 6 in libxul.so[7f5df1531000+4b01000]
[  554.098348] Code: e7 04 48 8d 15 a6 94 ae 03 48 89 10 c7 04 25 00 00 00 00 00 00 00 00 0f 0b 48 8b 05 57 d0 e7 04 48 8d 0d b0 94 ae 03 48 89 08 <c7> 04 25 00 00 00 00 00 00 00 00 0f 0b e8 4d f4 ff ff 48 8b 05 34
[  554.109418] Chrome_~dThread[3047]: segfault at 0 ip 00007f3d5bdba1f3 sp 00007f3d57cfab00 error 6
[  554.109421] Chrome_~dThread[3077]: segfault at 0 ip 00007fe773f661f3 sp 00007fe76fea6b00 error 6
[  554.109424]  in libxul.so[7f3d5bdb1000+4b01000]
[  554.109426]  in libxul.so[7fe773f5d000+4b01000]
[  554.109429] Code: e7 04 48 8d 15 a6 94 ae 03 48 89 10 c7 04 25 00 00 00 00 00 00 00 00 0f 0b 48 8b 05 57 d0 e7 04 48 8d 0d b0 94 ae 03 48 89 08 <c7> 04 25 00 00 00 00 00 00 00 00 0f 0b e8 4d f4 ff ff 48 8b 05 34


Even such a simple thing as "printk several lines per-crashed process"
is broken. Look at line #0 and lines #2-#5.

And this is the only problem we probably need to address. Overlapping
printk lines -- when several CPUs printk simultaneously, or same CPUs
printk-s from IRQ, etc -- are here by design and it's not going to be
easy to change that (and maybe we shouldn't try).


Buffering multiple lines in printk buffer does not look so simple and
perhaps we should not try to do this, as well. Why:

- it's hard to decide what to do when buffer overflows

    Switching to "normal printk" defeats the reason we do buffering in the
    first place. Because "normal printk" permits overlapping. So buffering
    makes a little sense if we are OK with switching to a "normal printk".

- the more we buffer the more we can lose in case of panic.

    We can't flush_on_panic() printk buffers which were allocated on stack.

- flushing multiple lines should be more complex than just a simple
  printk loop

  while (1) {
     x = memchr(buf, '\n', sz);
     ...
     print("%s", buf);
     ...
  }

    Because "printk() loop" permits lines overlap. Hence buffering makes
    little sense, once again.



So let's reduce the problem scope to "we want to have a replacement for
pr_cont()". And let's address pr_cont()'s "preliminary flush" issue only.


I scanned some of Linus' emails, and skimmed through previous discussions
on this topic. Let me quote Linus:

: 
: My preference as a user is actually to just have a dynamically
: re-sizable buffer (that's pretty much what I've done in *every* single
: user space project I've had in the last decade), but because some
: users might have atomicity issues I do suspect that we should just use
: a stack buffer.
: 
: And then perhaps say that the buffer size has to be capped at 80 characters.
: 
: Because if you're printing more than 80 characters and expecting it
: all to fit on a line, you're doing something else wrong anyway.
: 
: And hide it not as a explicit "char buffer[80]]" allocation, but as a
: "struct line_buffer" or similar, so that
: 
:  (a) people don't get the line size wrong
: 
:  (b) the buffering code can add a few fields for length etc in there too
: 
: Introduce a few helper functions for it:
: 
:  init_line_buffer(&buf);
:  print_line(&buf, fmt, args);
:  vprint_line(&buf, fmt, vararg);
:  finish_line(&buf);
: 



And this is, basically, what I have attached to this email. It's very
simple and very short. And I think this is what Linus wanted us to do.

- usage example

       DEFINE_PR_LINE(KERN_ERR, pl);

       pr_line(&pl, "Hello, %s!\n", "buffer");
       pr_line(&pl, "%s", "OK.\n");
       pr_line(&pl, "Goodbye, %s", "buffer");
       pr_line(&pl, "\n");

dmesg | tail

[   69.908542] Hello, buffer!
[   69.908544] OK.
[   69.908545] Goodbye, buffer


- pr_cont-like usage

       DEFINE_PR_LINE(KERN_ERR, pl);

       pr_line(&pl,"%d ", 1);
       pr_line(&pl,"%d ", 3);
       pr_line(&pl,"%d ", 5);
       pr_line(&pl,"%d ", 7);
       pr_line(&pl,"%d\n", 9);

dmesg | tail

[   69.908546] 1 3 5 7 9


- An explicit, aux buffer // output should be truncated

       char buf[16];
       DEFINE_PR_LINE_BUF(KERN_ERR, ps, buf, sizeof(buf));

       pr_line(&ps, "Test test test test test test test test test\n");
       pr_line(&ps, "\n");


dmesg | tail

[   69.908547] Test test test ** truncated **


Opinions? Will this work for us?

====

From 7fd8407e0081d8979f08dec48e88364d6210b4ab Mon Sep 17 00:00:00 2001
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] printk: add pr_line buffering API

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 include/linux/printk.h | 63 ++++++++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c | 55 ++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index cf3eccfe1543..fc5f11c7579c 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -157,6 +157,15 @@ static inline void printk_nmi_direct_enter(void) { }
 static inline void printk_nmi_direct_exit(void) { }
 #endif /* PRINTK_NMI */
 
+#define PRINTK_PR_LINE_BUF_SZ	80
+
+struct pr_line {
+	char			*buffer;
+	int			size;
+	int			len;
+	char			*level;
+};
+
 #ifdef CONFIG_PRINTK
 asmlinkage __printf(5, 0)
 int vprintk_emit(int facility, int level,
@@ -209,6 +218,30 @@ extern asmlinkage void dump_stack(void) __cold;
 extern void printk_safe_init(void);
 extern void printk_safe_flush(void);
 extern void printk_safe_flush_on_panic(void);
+
+#define DEFINE_PR_LINE(lev, name)				\
+	char		__pr_line_buf[PRINTK_PR_LINE_BUF_SZ];	\
+	struct pr_line	name = {				\
+		.buffer = __pr_line_buf,			\
+		.size 	= PRINTK_PR_LINE_BUF_SZ,		\
+		.len 	= 0,					\
+		.level	= lev,					\
+	}
+
+#define DEFINE_PR_LINE_BUF(lev, name, buf, sz)			\
+	struct pr_line	name = {				\
+		.buffer = buf,					\
+		.size 	= (sz),					\
+		.len 	= 0,					\
+		.level	= lev,					\
+	}
+
+extern __printf(2, 3)
+int pr_line(struct pr_line *pl, const char *fmt, ...);
+extern __printf(2, 0)
+int vpr_line(struct pr_line *pl, const char *fmt, va_list args);
+extern void pr_line_flush(struct pr_line *pl);
+
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -284,6 +317,36 @@ static inline void printk_safe_flush(void)
 static inline void printk_safe_flush_on_panic(void)
 {
 }
+
+#define DEFINE_PR_LINE(lev, name)				\
+	struct pr_line	name = {				\
+		.buffer = NULL,					\
+		.size 	= 0,					\
+		.len 	= 0,					\
+		.level	= lev,					\
+	}
+
+#define DEFINE_PR_LINE_BUF(lev, name, buf, sz)			\
+	struct pr_line	name = {				\
+		.buffer = buf,					\
+		.size 	= 0,					\
+		.len 	= 0,					\
+		.level	= lev,					\
+	}
+
+static inline __printf(2, 3)
+int pr_line(struct pr_line *pl, const char *fmt, ...)
+{
+	return 0;
+}
+static inline __printf(2, 0)
+int vpr_line(struct pr_line *pl, const char *fmt, va_list args)
+{
+	return 0;
+}
+static inline void pr_line_flush(struct pr_line *pl)
+{
+}
 #endif
 
 extern int kptr_restrict;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fd6f8ed28e01..daeb41a57929 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2004,6 +2004,61 @@ asmlinkage __visible int printk(const char *fmt, ...)
 }
 EXPORT_SYMBOL(printk);
 
+#define PR_LINE_TRUNCATED_MSG "** truncated **\n"
+
+int vpr_line(struct pr_line *pl, const char *fmt, va_list args)
+{
+	int len;
+
+	if (unlikely(pl->size >= LOG_LINE_MAX))
+		pl->size = LOG_LINE_MAX - sizeof(PR_LINE_TRUNCATED_MSG);
+
+	if (fmt[0] == '\n') {
+		pr_line_flush(pl);
+		return 0;
+	}
+
+	if (pl->len >= pl->size)
+		return -1;
+
+	len = vsnprintf(pl->buffer + pl->len, pl->size - pl->len, fmt, args);
+	if (pl->len + len >= pl->size) {
+		pl->len = pl->size + 1;
+		return -1;
+	}
+
+	pl->len += len;
+	if (pl->len && pl->buffer[pl->len - 1] == '\n')
+		pr_line_flush(pl);
+	return 0;
+}
+EXPORT_SYMBOL(vpr_line);
+
+int pr_line(struct pr_line *pl, const char *fmt, ...)
+{
+	va_list ap;
+	int ret;
+
+	va_start(ap, fmt);
+	ret = vpr_line(pl, fmt, ap);
+	va_end(ap);
+	return ret;
+}
+EXPORT_SYMBOL(pr_line);
+
+void pr_line_flush(struct pr_line *pl)
+{
+	if (!pl->len)
+		return;
+
+	if (pl->len < pl->size)
+		printk("%s%.*s", pl->level, pl->len, pl->buffer);
+	else
+		printk("%s%.*s%s", pl->level, pl->len, pl->buffer,
+			PR_LINE_TRUNCATED_MSG);
+	pl->len = 0;
+}
+EXPORT_SYMBOL(pr_line_flush);
 #else /* CONFIG_PRINTK */
 
 #define LOG_LINE_MAX		0
-- 
2.19.0

