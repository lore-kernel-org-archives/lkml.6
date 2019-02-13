Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F8AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FCE222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WN/ROOmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbfBMGTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 01:19:22 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42596 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfBMGTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 01:19:22 -0500
Received: by mail-qk1-f194.google.com with SMTP id y140so699941qkb.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 22:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ro2jC56O54+ic/AwGOG3252SMG5Rzo6rjWDESRSYSI=;
        b=WN/ROOmUgTQrWMVyajb5VQ3pJ9Hvqo5r/tLhmm5YbdLtUuQTqSAjJSYwc1osYZlunt
         JO81HC8i3YSFLuaTY7XEbBHUt5UPrvmWhH6ISwlWdfSUYsXIHYODaOEkMa1iFlpY1NK8
         Yv27LbrZjQ3mXnAko5Tht54GhwJCq6c4ctJFSBt5XlTHE7xe5tAfxO23UJpuAOrgQywr
         z48iowljPOfQ1DlvrhgPGKNtLkZdQWvQh+6o28Nw6+qr3vyiQHT4jObr1RCiNkkU+wDe
         DdwdL4/CnLJJL5pnG9zWILoIOWpZku0QixGqkqP4UdSS3He+ba6FnKAUQSt7QVa89sQh
         0HRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ro2jC56O54+ic/AwGOG3252SMG5Rzo6rjWDESRSYSI=;
        b=Nh1sqCn9bIaJq0e/LtGHHGHyZMTXbOegkCW6oWq4OW4CMUgYaH7VuQpkQb4050iVuT
         omwkeZpRI41Uwdoj+/mn3oQKecS9n/dTtixQZrjkEmShJX+FP8f31yqv+Id3BcyaWDh9
         xMw43tQHEmAIKNhgNXFmNBEswGy7ewAXH62tVaphJDSkOGbbsHWMv0XrMOeSBn5otyOL
         Yf5VRUNGPh+iHsMgfdHl0Mk/1S9en+MsfA5BmtIU/NQsSBke3A3vOms+KAi3zUMOIa2w
         62laoBtTrvuUDAsYzE2fvh0/ZTRrgSpVBmFPLmCR2DebqVRItyyJqSVj5QBLj8D29XYe
         sugw==
X-Gm-Message-State: AHQUAuZbL9iQ2OetqDqoth2Ny3sh/MXjCxKd+9yTRgnsZiR08r49J17R
        B4ETMYoZqRQ0ix1vWvZfR4Jsaw/WdJD/E8QEkBc=
X-Google-Smtp-Source: AHgI3IZ7DN6qMW2JUOQdKh5siEjbze2UlxH65ziLGwXiSZZqJqAUYuC+5f6mZOnJfLOD1M6GD/6DjEnvxKz11V8K/E4=
X-Received: by 2002:ae9:ed12:: with SMTP id c18mr67773qkg.39.1550038761265;
 Tue, 12 Feb 2019 22:19:21 -0800 (PST)
MIME-Version: 1.0
References: <1549995065-27597-1-git-send-email-xiaoxiang@xiaomi.com> <20190212144606.4b7cf0f8@gandalf.local.home>
In-Reply-To: <20190212144606.4b7cf0f8@gandalf.local.home>
From:   xiang xiao <xiaoxiang781216@gmail.com>
Date:   Wed, 13 Feb 2019 14:19:01 +0800
Message-ID: <CAH2Cfb-Zd9TKgs52ROVGYg6F_hiN2ieWKwYPkxpVV8St+zwa2A@mail.gmail.com>
Subject: Re: [PATCH] printk: add KERN_NOTIME to skip the timestamp
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Xiang Xiao <xiaoxiang@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 3:46 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 13 Feb 2019 02:11:05 +0800
> Xiang Xiao <xiaoxiang781216@gmail.com> wrote:
>
> > Because log may already add the timestamp sometime
>
> Can you be a bit more detailed on this. When and where does this
> happen?

Here is my case:
1.A small MCU(Cortex M4) in SoC run RTOS
2.RTOS append timestamp to log for the accurate timing
3.RTOS send log to Linux kernel when buffer exceed the threshold
4.Kernel call printk to dump the received buffer
So I want that printk skip the timestamp here.

> If anything, I would probably prefer that we export whether
> time is being printed, and have the caller not print time if printk is
> doing it already, than to add the complexity into printk itself.

Actually, the timestamp of our initial implementation like your
suggestion come from printk,
but we found that timestamp from kernel isn't accurate as from RTOS
due the buffer and IPC.

>
> -- Steve
>
> >
> > Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
> > ---
> >  include/linux/kern_levels.h | 2 ++
> >  include/linux/printk.h      | 1 +
> >  kernel/printk/printk.c      | 7 ++++++-
> >  3 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/kern_levels.h b/include/linux/kern_levels.h
> > index d237fe8..ed2aec6 100644
> > --- a/include/linux/kern_levels.h
> > +++ b/include/linux/kern_levels.h
> > @@ -23,6 +23,8 @@
> >   */
> >  #define KERN_CONT    KERN_SOH "c"
> >
> > +#define KERN_NOTIME  KERN_SOH "t"    /* don't print the timestamp */
> > +
> >  /* integer equivalents of KERN_<LEVEL> */
> >  #define LOGLEVEL_SCHED               -2      /* Deferred messages from sched code
> >                                        * are set to this special level */
> > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > index 77740a5..be12ac4 100644
> > --- a/include/linux/printk.h
> > +++ b/include/linux/printk.h
> > @@ -20,6 +20,7 @@ static inline int printk_get_level(const char *buffer)
> >               case '0' ... '7':
> >               case 'd':       /* KERN_DEFAULT */
> >               case 'c':       /* KERN_CONT */
> > +             case 't':       /* KERN_NOTIME */
> >                       return buffer[1];
> >               }
> >       }
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index d3d1703..0688cf2 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -346,6 +346,7 @@ enum log_flags {
> >       LOG_NEWLINE     = 2,    /* text ended with a newline */
> >       LOG_PREFIX      = 4,    /* text started with a prefix */
> >       LOG_CONT        = 8,    /* text is a fragment of a continuation line */
> > +     LOG_NOTIME      = 16,   /* don't print the timestamp */
> >  };
> >
> >  struct printk_log {
> > @@ -1247,7 +1248,7 @@ static size_t print_prefix(const struct printk_log *msg, bool syslog,
> >
> >       if (syslog)
> >               len = print_syslog((msg->facility << 3) | msg->level, buf);
> > -     if (time)
> > +     if (time && !(msg->flags & LOG_NOTIME))
> >               len += print_time(msg->ts_nsec, buf + len);
> >       return len;
> >  }
> > @@ -1873,6 +1874,10 @@ int vprintk_store(int facility, int level,
> >                               break;
> >                       case 'c':       /* KERN_CONT */
> >                               lflags |= LOG_CONT;
> > +                             break;
> > +                     case 't':       /* KERN_NOTIME */
> > +                             lflags |= LOG_NOTIME;
> > +                             break;
> >                       }
> >
> >                       text_len -= 2;
>
