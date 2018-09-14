Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB18C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56AE20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWUODz5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56AE20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbeINMKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:10:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42128 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbeINMKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:10:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so3924012pgp.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 23:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1IuaYtbdSkVdT2fkhiUXKkbGR0yd7gehdZjtfOfY+Ts=;
        b=QWUODz5t5eOTwExDTLoSav+1MrLWchzR5X2u5QudcRl21asUG3kxoavzmLrfsQ8nic
         AKZ3h49SftiHu5M7CFhB97xz+0fyA01jtXsR0HkV8Ms0FHMQYRl1P41+wvwGTYsK08GC
         M64GwsMmIGBRDRMJvlNpVhYXXaZ+Na73EqMsIj417hbD3uYP884JWz3FH8zXDYo/D1km
         AHLh4u5rVzsY9QNS31EK+C+xjfh0WhdedsMhT9Y1G6d2u/7LzH0mDD7lkZxv5jl5ddBy
         9P3FYrPXGMbU4Q6dYJ0fSU/UgNJUJaMPTxGw4+xwGr3FLl1friuIsRh1Lwxaq6MkJ8kk
         au5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1IuaYtbdSkVdT2fkhiUXKkbGR0yd7gehdZjtfOfY+Ts=;
        b=r63t+jId8l4EMCMz6eCvBhFiWfNlOjgjN4Un38swgn9/QGMlbbvLFLzzbaRUfHwDHF
         P6ayPei/rgUGR7YXUqXzR/5QwtitsBXkBzP63LR1n9qVOdZQMNzHBbK9EY0nzXzg+RLO
         MrSR+IXI+rX21pwKUQUzwvDCsxScHR9ZPQBptKr9EwbwwohhB3OOQJRPIXqPceSanRyn
         CFJygxjS7OnhnQEIToV234NqlrMkB2kHWuFs6DpgNmdzzWP3604V1YYROUSLoalrz6Bu
         bwwzD9gVt+gHxBrSbRCqxPSMvCYJ/nTc3lkdUnyOCUrt5ICefInUXMVXjucyzUlObKKb
         qTww==
X-Gm-Message-State: APzg51DU76YAHzB1fc3+tEmVqkTpKbMo3f14bXOWcWNYd1gyS193nNgi
        rS16Wgt6mmPx1bqjQAzT4Cs=
X-Google-Smtp-Source: ANB0VdZuQQw0wFgW7kdgMyWPHAf4bPiqRANIsZVEzSqMtlh0gLkcg/QcymOX8w6u2pQiAYwlYRm4lw==
X-Received: by 2002:a63:1316:: with SMTP id i22-v6mr10166212pgl.86.1536908253719;
        Thu, 13 Sep 2018 23:57:33 -0700 (PDT)
Received: from localhost ([39.7.18.191])
        by smtp.gmail.com with ESMTPSA id z11-v6sm8840579pfi.4.2018.09.13.23.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 23:57:32 -0700 (PDT)
Date:   Fri, 14 Sep 2018 15:57:28 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180914065728.GA515@jagdpanzerIV>
References: <CACT4Y+bcp4fSBBq3F86T-C4+n-YkeXUGMqpvkJ6vj6mK-TU2EA@mail.gmail.com>
 <20180620110759.GD444@jagdpanzerIV>
 <CACT4Y+aER3O2x2ApM=MVFoFXhp_T_rUeyG9CBx031qyH0voSRg@mail.gmail.com>
 <20180620130628.GA1000@tigerII.localdomain>
 <CAG_fn=XuZo5yrZzVizP26iV6eFfJtAHUs4NsDFXFyvnaJkdSQw@mail.gmail.com>
 <20180912065307.GA606@jagdpanzerIV>
 <20180912120548.4280f04a@vmware.local.home>
 <20180913071204.GA604@jagdpanzerIV>
 <20180913122625.6ieyexpcmlc5z2it@pathway.suse.cz>
 <20180913142802.GB517@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913142802.GB517@tigerII.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/13/18 23:28), Sergey Senozhatsky wrote:
> Not that I see any problems with pr_line_flush(). But can drop it, sure.
> pr_line() is a replacement for pr_cont() and as such it's not for multi-line
> buffering.

OK, attached.
Let me know if anything needs to improved (including broken English).
Will we keep in the printk tree or shall I send a formal patch to Andrew?

===

From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [PATCH] lib/seq_buf: add pr_line buffering API

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 include/linux/kern_levels.h |  3 ++
 include/linux/seq_buf.h     | 60 +++++++++++++++++++++++++++++++++++++
 lib/seq_buf.c               | 57 +++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+)

diff --git a/include/linux/kern_levels.h b/include/linux/kern_levels.h
index d237fe854ad9..9c281ac745b3 100644
--- a/include/linux/kern_levels.h
+++ b/include/linux/kern_levels.h
@@ -20,6 +20,9 @@
  * Annotation for a "continued" line of log printout (only done after a
  * line that had no enclosing \n). Only to be used by core/arch code
  * during early bootup (a continued line is not SMP-safe otherwise).
+ *
+ * Please consider pr_line()/vpr_line() functions for SMP-safe continued
+ * line printing.
  */
 #define KERN_CONT	KERN_SOH "c"
 
diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index aa5deb041c25..b33aeea14803 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -23,6 +23,62 @@ struct seq_buf {
 	loff_t			readpos;
 };
 
+#define __SEQ_BUF_INITIALIZER(buf, length)			\
+{								\
+	.buffer			= (buf),			\
+	.size			= (length),			\
+	.len			= 0,				\
+	.readpos		= 0,				\
+}
+
+#ifdef CONFIG_PRINTK
+#define __PR_LINE_BUF_SZ	80
+#else
+#define __PR_LINE_BUF_SZ	0
+#endif
+
+/**
+ * pr_line - printk() line buffer structure
+ * @sb:	underlying seq buffer, which holds the data
+ * @level:	printk() log level (KERN_ERR, etc.)
+ */
+struct pr_line {
+	struct seq_buf		sb;
+	char			*level;
+};
+
+/**
+ * DEFINE_PR_LINE - define a new pr_line variable
+ * @lev:	printk() log level
+ * @name:	variable name
+ *
+ * Defines a new pr_line varialbe, which would use an implicit
+ * stack buffer of size __PR_LINE_BUF_SZ.
+ */
+#define DEFINE_PR_LINE(lev, name)				\
+	char		__line_##name[__PR_LINE_BUF_SZ];	\
+	struct pr_line	name = {				\
+		.sb	= __SEQ_BUF_INITIALIZER(__line_##name,	\
+					__PR_LINE_BUF_SZ),	\
+		.level	= lev,					\
+	}
+
+/**
+ * DEFINE_PR_LINE_BUF - define a new pr_line variable
+ * @lev:	printk() log level
+ * @name:	variable name
+ * @buf:	external buffer
+ * @sz:	external buffer size
+ *
+ * Defines a new pr_line variable, which would use an external
+ * buffer for printk line.
+ */
+#define DEFINE_PR_LINE_BUF(lev, name, buf, sz)			\
+	struct pr_line	name = {				\
+		.sb	= __SEQ_BUF_INITIALIZER(buf, (sz)),	\
+		.level	= lev,					\
+	}
+
 static inline void seq_buf_clear(struct seq_buf *s)
 {
 	s->len = 0;
@@ -131,4 +187,8 @@ extern int
 seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary);
 #endif
 
+extern __printf(2, 0)
+int vpr_line(struct pr_line *pl, const char *fmt, va_list args);
+extern __printf(2, 3)
+int pr_line(struct pr_line *pl, const char *fmt, ...);
 #endif /* _LINUX_SEQ_BUF_H */
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 11f2ae0f9099..fada7623f168 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -324,3 +324,60 @@ int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, int cnt)
 	s->readpos += cnt;
 	return cnt;
 }
+
+/**
+ * vpr_line - Append data to the printk() line buffer
+ * @pl: the pr_line descriptor
+ * @fmt: printf format string
+ * @args: va_list of arguments from a printf() type function
+ *
+ * Writes a vnprintf() format into the printk() pr_line buffer.
+ * Terminating new-line symbol flushes (prints) the buffer.
+ *
+ * Unlike pr_cont() and printk(KERN_CONT), this function is SMP-safe
+ * and shall be used for continued line printing.
+ *
+ * Returns zero on success, -1 on overflow.
+ */
+int vpr_line(struct pr_line *pl, const char *fmt, va_list args)
+{
+	struct seq_buf *s = &pl->sb;
+	int ret, len;
+
+	ret = seq_buf_vprintf(s, fmt, args);
+
+	len = seq_buf_used(s);
+	if (len && s->buffer[len - 1] == '\n') {
+		printk("%s%.*s", pl->level ? : KERN_DEFAULT, len, s->buffer);
+		seq_buf_clear(s);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(vpr_line);
+
+/**
+ * pr_line - Append data to the printk() line buffer
+ * @pl: the pr_line descriptor
+ * @fmt: printf format string
+ *
+ * Writes a printf() format into the printk() pr_line buffer.
+ * Terminating new-line symbol flushes (prints) the buffer.
+ *
+ * Unlike pr_cont() and printk(KERN_CONT), this function is SMP-safe
+ * and shall be used for continued line printing.
+ *
+ * Returns zero on success, -1 on overflow.
+ */
+int pr_line(struct pr_line *pl, const char *fmt, ...)
+{
+	va_list ap;
+	int ret;
+
+	va_start(ap, fmt);
+	ret = vpr_line(pl, fmt, ap);
+	va_end(ap);
+
+	return ret;
+}
+EXPORT_SYMBOL(pr_line);
-- 
2.19.0

