Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F665FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FCF20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeemvLnl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FCF20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbeINREn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:04:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45805 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbeINREm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:04:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so4187451pfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 04:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YX7M9aZwwQ6E+PPdOahhghzgBDIXWcgo41Uo9vAPZjg=;
        b=CeemvLnlnUeqEBec28xQHF/1J7GyYN4gVRa5y+lmVaM/pdC3PKz62l6huq4bjh6dS2
         jGlEemQLn7HE9tk7hJVq1hLXx1KjoP0L4htcsPRR4uSrok9OjWiEK6bjeVdS3NlseYgn
         PrGrTp0FN5k3BAYmvEiHlE60UcB5JvlZ3MPIFt2dp2aOgLsQXsCcDRB0aaBnxxxbxHL9
         NZXWVpOHbg7SFaKF2Er9zIrk8YL9mGuU2EHMO2JQYzRBLVcEEuzI0EqbhAFmEguQhx5k
         dKQ4IKpSyj77bXBNLQ4VXG+xa667B6yrTcO5RU0WzI8LePUHkKc/A5jUs5T3W8A4PD7G
         +ACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YX7M9aZwwQ6E+PPdOahhghzgBDIXWcgo41Uo9vAPZjg=;
        b=PfOQR89ejuzmCozDgZ5XX4S6+7gqMi9sP1QgvsQOLjLhaGE/BTHogl1ZkMKwdTvr7g
         Y9edVTCaVadM65iXn5ltSsrRWruAjgKojV+HusYSRVpJsWs609BoaIhusH/UpClivQZa
         RRRUAMVhpgpaCj/ui6Vw7o09OR4qwfsUVUqRFmDTbgttdRYuORvcsLRmmI02v+S2nN96
         kg9L+3Wk6g7ZmOAIMNfZV8KVkjAq8DCbWmqYcPDeR422aaaslELsN7HqYiSu5k3y4lU6
         K3ff1Mo2s+8PB6e4THqCGI45ZlxwgpkPNnwmGRXeB+MgBFEm2HUW5tDX7DblWycm5crz
         YL3g==
X-Gm-Message-State: APzg51Czvs/7rWe97kb1CQhHXp9q9rLAZatrj1E1GbUJ02xFk7wBeHNL
        Y2mUCyMEjG/8UH7e0HgVKVA=
X-Google-Smtp-Source: ANB0VdYD+dlxHhvsQ/QXsX4HMOgcTQQtGxMZyQeGag8IZ+qyazS2lSRlDjCkdjlyY8eEDr/a1lr0Gw==
X-Received: by 2002:a62:2e02:: with SMTP id u2-v6mr12316333pfu.134.1536925833734;
        Fri, 14 Sep 2018 04:50:33 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id c8-v6sm8379447pfb.147.2018.09.14.04.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 04:50:32 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 14 Sep 2018 20:50:28 +0900
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180914115028.GB20572@tigerII.localdomain>
References: <CACT4Y+aER3O2x2ApM=MVFoFXhp_T_rUeyG9CBx031qyH0voSRg@mail.gmail.com>
 <20180620130628.GA1000@tigerII.localdomain>
 <CAG_fn=XuZo5yrZzVizP26iV6eFfJtAHUs4NsDFXFyvnaJkdSQw@mail.gmail.com>
 <20180912065307.GA606@jagdpanzerIV>
 <20180912120548.4280f04a@vmware.local.home>
 <20180913071204.GA604@jagdpanzerIV>
 <20180913122625.6ieyexpcmlc5z2it@pathway.suse.cz>
 <20180913142802.GB517@tigerII.localdomain>
 <20180914065728.GA515@jagdpanzerIV>
 <49d22738-17ad-410a-be0a-d27d76ba9f37@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49d22738-17ad-410a-be0a-d27d76ba9f37@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/14/18 19:37), Tetsuo Handa wrote:
> > @@ -20,6 +20,9 @@
> >   * Annotation for a "continued" line of log printout (only done after a
> >   * line that had no enclosing \n). Only to be used by core/arch code
> >   * during early bootup (a continued line is not SMP-safe otherwise).
> > + *
> > + * Please consider pr_line()/vpr_line() functions for SMP-safe continued
> > + * line printing.
> 
> I think the advantage is not limited to SMP-safeness. Reducing the frequency of
> calling printk() will reduce overhead. Also, latency for netconsole will be
> reduced by sending a whole line in one printk().

Hmm. These are very good points, indeed. But do we want to list all
advantages here? I just wanted to mention SMP-unsafe pr_cont/printk(KERN_CONT),
because I also mention pr_line in kern_levels.h.

> > + * Defines a new pr_line varialbe, which would use an implicit
> 
> s/varialbe/variable/ .

Thanks.

> > +#define DEFINE_PR_LINE(lev, name)				\
> > +	char		__line_##name[__PR_LINE_BUF_SZ];	\
> > +	struct pr_line	name = {				\
> > +		.sb	= __SEQ_BUF_INITIALIZER(__line_##name,	\
> > +					__PR_LINE_BUF_SZ),	\
> > +		.level	= lev,					\
> > +	}
> 
> Want a note that
> 
>   static DEFINE_PR_LINE(lev, name);
> 
> won't make "name" variable "static" ?

Interesting point. Any hint what the comment should look like?
Do we want to have static pr_line buffers?

> > +#define DEFINE_PR_LINE_BUF(lev, name, buf, sz)			\
> > +	struct pr_line	name = {				\
> > +		.sb	= __SEQ_BUF_INITIALIZER(buf, (sz)),	\
> > +		.level	= lev,					\
> > +	}
> > +
> 
> I would use this one for the OOM killer. 80 bytes is too short.

80 bytes is quite short for OOM, agreed.

>   static char oom_print_buf[1024];
>   DEFINE_PR_LINE_BUF(level, oom_print_buf);

Do I get it right that you suggest to drop the "size" param?
Do OOM people agree on 1024 bytes stack usage?


> > @@ -131,4 +187,8 @@ extern int
> >  seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary);
> >  #endif
> >  
> > +extern __printf(2, 0)
> > +int vpr_line(struct pr_line *pl, const char *fmt, va_list args);
> > +extern __printf(2, 3)
> > +int pr_line(struct pr_line *pl, const char *fmt, ...);
> 
> Do we want to mark "asmlinkage" like printk() ?

Dunno, do we? Does code written in assembly call pr_cont that often?
We are not turning pr_line() into syscall anyway.

> > @@ -324,3 +324,60 @@ int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, int cnt)
> >  	s->readpos += cnt;
> >  	return cnt;
> >  }
> > +
> > +/**
> > + * vpr_line - Append data to the printk() line buffer
> > + * @pl: the pr_line descriptor
> 
> s/descriptor/structure/ ?

Yeah, I used the term "descriptor", just because it's used in seq_buf.c.
So, it's sort of common in seq_buf.
E.g.
   seq_buf_vprintf(), seq_buf_print_seq(), seq_buf_can_fit() and so on.

> > + * @fmt: printf format string
> > + * @args: va_list of arguments from a printf() type function
> > + *
> > + * Writes a vnprintf() format into the printk() pr_line buffer.
> 
> s/vnprintf/vprintf/ ?

Indeed.
We also need to fix a typo in seq_buf_vprintf() comment then.

	-ss
