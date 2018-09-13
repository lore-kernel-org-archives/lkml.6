Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2DCC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C285E20881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HceUwuL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C285E20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeIMMVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 08:21:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36715 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbeIMMVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 08:21:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1-v6so2318242pgo.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 00:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PfXTmkGM3sXrJxh+Ebp+8XSYuv8pPyoLy56nh36gvPA=;
        b=HceUwuL6fqfhdDzt/V6osXFCiuRMuNae5seQ5kTVv64M90f/DyCjgEjy8lMK2UvOZE
         qhowfrnroKeb8v7FHdVVvXIbHbOPVpdj/d+vhyBoCzq25JV51EUl/2yNWdikgIJBqc15
         iIaBq3RBpvF70bQvxGh7EgU2JzFWbLqX4DRlHuvHsSvhiyVxUljbAvQ2ym3VE8OolM0I
         mmr4HZCpnUI6d8KNXW/ozH1PP3mM/hj1DBmFJg4WeZxC9pP7S8JhZDL4ZPF96FCkAElI
         tsSHaUD4UQjFlq9197pTblf0CbkgQekXg37ArlzkfZtt/D7NJwsnL41/NjL3dgonfYhk
         Kovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PfXTmkGM3sXrJxh+Ebp+8XSYuv8pPyoLy56nh36gvPA=;
        b=thvB4MwmKQ9zNA10k7LGQegYTX5cF0bCoI6M2xnp0KQ2sqZLoYBwJjAFmNzuviLFAk
         XOk3PEo14HUT1KFd1xwSQWCCRBSBzstUEuPcZS2xfYOmIXRN2o5QDDls7Nsi+vWzi8Xd
         Xbzt11HUkRd/GNiJKCiD9mk86eQ7r+FBOlNCLH/8lvdcAdrONCH9bveTI275+QEpizR0
         c7d00ofiBIwQqwL64qTcGAlHEM89RldeoskVWl7k5MGC9DgNPjvtYkw3HPU+Zx3f+G5P
         m1VBb+RWNO02rq1QgJkiN8H83M9m7yqkZOj6qt6nyfl9P865TfIn8Y5bs95WFPCxHZ+h
         16Yw==
X-Gm-Message-State: APzg51D9LFSxLrkg6Dnz8ztx6SlN7Xxy6bjrxxYIZYMa2Dj4BbH1c44P
        XX66UdwCYHEj9ogrI8Y5zAY=
X-Google-Smtp-Source: ANB0VdZWx1XvSfhtu3H2jX4o/o0DeHuEPnPzX0qCMaE05FU7QzP26tkTCsiqnHl3dBeMxLaAxFpuqw==
X-Received: by 2002:a63:cf52:: with SMTP id b18-v6mr5652359pgj.194.1536822779612;
        Thu, 13 Sep 2018 00:12:59 -0700 (PDT)
Received: from localhost ([175.223.16.57])
        by smtp.gmail.com with ESMTPSA id x24-v6sm4246841pfh.67.2018.09.13.00.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 00:12:57 -0700 (PDT)
Date:   Thu, 13 Sep 2018 16:12:54 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        kbuild test robot <fengguang.wu@intel.com>, pmladek@suse.com,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180913071204.GA604@jagdpanzerIV>
References: <CACT4Y+YMubTm1xduj+XCbQnNwQxYFLjBT33cFKisN1HyeaBpZw@mail.gmail.com>
 <20180620090413.GA444@jagdpanzerIV>
 <20180620091541.GB444@jagdpanzerIV>
 <CACT4Y+bcp4fSBBq3F86T-C4+n-YkeXUGMqpvkJ6vj6mK-TU2EA@mail.gmail.com>
 <20180620110759.GD444@jagdpanzerIV>
 <CACT4Y+aER3O2x2ApM=MVFoFXhp_T_rUeyG9CBx031qyH0voSRg@mail.gmail.com>
 <20180620130628.GA1000@tigerII.localdomain>
 <CAG_fn=XuZo5yrZzVizP26iV6eFfJtAHUs4NsDFXFyvnaJkdSQw@mail.gmail.com>
 <20180912065307.GA606@jagdpanzerIV>
 <20180912120548.4280f04a@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912120548.4280f04a@vmware.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Steven

On (09/12/18 12:05), Steven Rostedt wrote:
> > : Introduce a few helper functions for it:
> > : 
> > :  init_line_buffer(&buf);
> > :  print_line(&buf, fmt, args);
> > :  vprint_line(&buf, fmt, vararg);
> > :  finish_line(&buf);
> > : 
> 
> This sounds like seq_buf to me.

Correct.

> > +struct pr_line {
> > +	char			*buffer;
> > +	int			size;
> > +	int			len;
> > +	char			*level;
> > +};
> 
> Can you look at implementing this with using a seq_buf?

Certainly, attached.

It doesn't seem to save us that much code, tho. It looks smaller just
because I dropped "truncated" print out and didn't include !CONFIG_PRINTK
noise this time around. And the OK thing about previous version was that
it didn't introduce any new dependencies to printk.

Making pr_line available via printk.h -- #include seq_buf.h in printk.h - at
glance looks like some fun. printk.h is getting included very early, before
we have all the stuff that seq_buf.h wants - we can remove fs.h from
seq_buf.h and add a bunch of forward declarations for path and seq_file;
but all those BUG_ON/WARN_ON/etc is another story (unless we want every
pr_line user to include seq_buf.h).

... maybe I can change API. But I sort of like that implicit buffer case:

	DEFINE_PR_LINE(KERN_ERR, pl);

	pr_line(&pl, "Hello, ");
	pr_line(&pl, "%s.\n", "Steven");

And, looking at potential users of pr_line, I'd say that we better
have DEFINE_PR_LINE_BUF, because some of them do print messages longer
than 80 chars.

===

From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] lib/seq_buf: add pr_line buffering API

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 include/linux/seq_buf.h | 35 +++++++++++++++++++++++++++++++
 lib/seq_buf.c           | 46 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index aa5deb041c25..5e9a5ff9a440 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -23,6 +23,36 @@ struct seq_buf {
 	loff_t			readpos;
 };
 
+#define __SEQ_BUF_INITIALIZER(buf, length) {				\
+	.buffer			= (buf),				\
+	.size			= (length),				\
+	.len			= 0,					\
+	.readpos		= 0, }
+
+#ifdef CONFIG_PRINTK
+#define __PR_LINE_BUF_SZ	80
+#else
+#define __PR_LINE_BUF_SZ	0
+#endif
+
+struct pr_line {
+	struct seq_buf		sb;
+	char			*level;
+};
+
+#define DEFINE_PR_LINE(lev, name)					\
+	char		__line[__PR_LINE_BUF_SZ];			\
+	struct pr_line	name = {					\
+		.sb = __SEQ_BUF_INITIALIZER(__line, __PR_LINE_BUF_SZ),	\
+		.level	= lev,						\
+	}
+
+#define DEFINE_PR_LINE_BUF(lev, name, buf, sz)				\
+	struct pr_line	name = {					\
+		.sb = __SEQ_BUF_INITIALIZER(buf, (sz)),		\
+		.level	= lev,						\
+	}
+
 static inline void seq_buf_clear(struct seq_buf *s)
 {
 	s->len = 0;
@@ -131,4 +161,9 @@ extern int
 seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary);
 #endif
 
+extern __printf(2, 0)
+int vpr_line(struct pr_line *pl, const char *fmt, va_list args);
+extern __printf(2, 3)
+int pr_line(struct pr_line *pl, const char *fmt, ...);
+extern void pr_line_flush(struct pr_line *pl);
 #endif /* _LINUX_SEQ_BUF_H */
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 11f2ae0f9099..29bc4f24b83e 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -324,3 +324,49 @@ int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, int cnt)
 	s->readpos += cnt;
 	return cnt;
 }
+
+int vpr_line(struct pr_line *pl, const char *fmt, va_list args)
+{
+	struct seq_buf *s = &pl->sb;
+	int ret, len;
+
+	if (fmt[0] == '\n') {
+		pr_line_flush(pl);
+		return 0;
+	}
+
+	ret = seq_buf_vprintf(s, fmt, args);
+
+	len = seq_buf_used(s);
+	if (len && s->buffer[len - 1] == '\n')
+		pr_line_flush(pl);
+
+	return ret;
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
+
+	return ret;
+}
+EXPORT_SYMBOL(pr_line);
+
+void pr_line_flush(struct pr_line *pl)
+{
+	struct seq_buf *s = &pl->sb;
+	int len = seq_buf_used(s);
+
+	if (!len)
+		return;
+
+	printk("%s%.*s", pl->level, len, s->buffer);
+	seq_buf_clear(s);
+}
+EXPORT_SYMBOL(pr_line_flush);
-- 
2.19.0

