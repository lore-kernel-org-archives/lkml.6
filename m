Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD67C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35155205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhH0SIgk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35155205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503069AbeKWUlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:41:35 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:47091 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387962AbeKWUlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:41:35 -0500
Received: by mail-io1-f67.google.com with SMTP id v10so2751041ios.13;
        Fri, 23 Nov 2018 01:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JrC00WIYhhedll7l9dt/xU+eCXaR7xec2dE4AO2mhsA=;
        b=MhH0SIgk0M+7kXQtBFMgX5x3EOYR/PLv6jM5iZiDwwlgAiePO1gbq4IobZdtwkkhG2
         EswwQP4vlNCi99fg3hXQdxYVeOzW+6UuQqzF2Kl/rf9ExHTXdWqV4bCFTi2LLk7YuMav
         HeCsm95BZ9XfqkUO6beGP5iIpcMynCDQuhWnG9ewJPGEzyVZzaqNa2kt2L7A4Inc383Y
         jQUwl3mCs4mBxfJWQjv2heboQHKDjhNp9jLeFX2zowMro5Cckc5D2xP1+kxTT6egLtpB
         V1rnWi8XV6CYaOKyotR1YfB7Zb9FtnpYI1DfCGCKLjae1ZzZ8T/om32HRpORiQtI/jyn
         Lizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JrC00WIYhhedll7l9dt/xU+eCXaR7xec2dE4AO2mhsA=;
        b=kARX2qp/EvHCz/zES8f+KBOcIuY6dM8mI/HbiKsvOv62+ysu1lZD1qg17kQR3uvXYa
         j2Nmfc72CyI0Z6BHJKQtozEBlpiRE9VuoXiE0SvrwRVJbkOzEmg8QwurUhMQovoreAII
         0QBjzh6f7kS6+VZ5DwxucckXJW7qmDn6BBSLRR3M+SkszyMAloO2Bi1LefTV/lVpojta
         MVskXaPD9xAB9R8TU1OD1fQxu/gdeNUU4FGoiPO2SD0gy64CDfetgPpdsfKd+lBXc3NM
         JkQKLlQOUMnKpZnRdY+diWA15bv8gOMViZsRk6863xgqUqAAmkY8yeDpYOkULSAbBhyY
         nsAg==
X-Gm-Message-State: AA+aEWZh2Mopnvm4z9IUn5WRGh98v7SFJPh0M+YJmOBI8BQIpSjSmQD7
        DUrAXmt2ihEWa3ABlLlmqFlLIHl0sLtJL3ocf2o=
X-Google-Smtp-Source: AFSGD/Vcogajjv9ejXtGpFKf9bODSpxoVxyI+seTwYgnKmj6LM/pRzMY7+6eSIyXu9WTlT/R7pdsYDsElLNsjLqe+dw=
X-Received: by 2002:a6b:b706:: with SMTP id h6mr10383958iof.295.1542967080108;
 Fri, 23 Nov 2018 01:58:00 -0800 (PST)
MIME-Version: 1.0
References: <1542626272-29129-1-git-send-email-laoar.shao@gmail.com>
 <20181121192844.1cd1c2fa4801a324d059176c@linux-foundation.org>
 <CACVxJT9ns2XGeE3FUwNT2J2Fn2s0YuHPQT-z6yg2RE8qzK-ssQ@mail.gmail.com>
 <CALOAHbBaR2GB1Xtzzi9bNprfCWSP_PV5FCfAG_xK=jqg8uuong@mail.gmail.com> <20181122133826.GA14139@avx2>
In-Reply-To: <20181122133826.GA14139@avx2>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 23 Nov 2018 17:57:23 +0800
Message-ID: <CALOAHbBucSqCynLP5C3wJK+zMUGp+LLzp3-+p0k0Hq+SH6Jb1g@mail.gmail.com>
Subject: Re: [PATCH] procfs: fix the output format in /proc/PID/wchan
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     viro@zeniv.linux.org.uk, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 9:38 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> On Thu, Nov 22, 2018 at 09:29:52PM +0800, Yafang Shao wrote:
> > On Thu, Nov 22, 2018 at 7:40 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > >
> > > On Wed, Nov 21, 2018 at 07:28:44PM -0800, Andrew Morton wrote:
> > > > On Mon, 19 Nov 2018 19:17:52 +0800 Yafang Shao <laoar.shao@gmail.com> wrote:
> > > >
> > > > > Just add the missing newline.
> > > > >
> > > > > ...
> > > > >
> > > > > --- a/fs/proc/base.c
> > > > > +++ b/fs/proc/base.c
> > > > > @@ -370,11 +370,12 @@ static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
> > > > >     wchan = get_wchan(task);
> > > > >     if (wchan && !lookup_symbol_name(wchan, symname)) {
> > > > >             seq_puts(m, symname);
> > > > > +           seq_putc(m, '\n');
> > > > >             return 0;
> > > > >     }
> > > > >
> > > > >  print0:
> > > > > -   seq_putc(m, '0');
> > > > > +   seq_puts(m, "0\n");
> > > > >     return 0;
> > > > >  }
> > > > >  #endif /* CONFIG_KALLSYMS */
> > > >
> > > > What is presently wrong with the wchan output?  The changelog
> > > > should explain such things, please.
> > >
> > > It is just newline to make "cat /proc/*/wchan" output look cool.
> > > But newline can break something.
> >
> > Could you pls. show some examples for what the newline may break ?
>
>         char buf[16];
>         rv = read(fd, buf, sizeof(buf));
>         assert(rv == 1);

That's really a break, so we can't apply this patch.

Hi Andrew,
I found that you have applied this patch to -mm tree, could you pls.
help revert it as it may break something ?

Thanks
Yafang
