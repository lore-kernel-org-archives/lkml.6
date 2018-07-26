Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9333C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7721020857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="slSwmFfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7721020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbeGZXPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 19:15:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44156 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730533AbeGZXPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 19:15:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so1950629pgp.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 14:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k8md6zmM090pLvd8O9V1YcO888OyPmKVBIHUw3FpN4k=;
        b=slSwmFfx6L1ShTgJw9K495hBXIIecPRczAVSmkNml6A0oW7QnVlWIZ9W/JYacvq8ZW
         NbsEZum6x7srBPADuuYEcoFHOkwgYOiSFzAwXDiSU91bHn/m5FOJmDbugVXS5EgP/MRW
         tJuc8IpRqewkC51NAime0lckTV0kHjfNiCCkgdtyliEwvC/We5gX6Asc+KPUT9NbN8CO
         HySNfEMzYyZl5+JPGI8eRPQAsDIcftj6ddyaW3eLouU87Y7Zvn0aS0cd0ZNCYWzfampu
         2rCo1EIZqcHFGc7ONaFuogkW+50Ys+ZU1gQMXnn1+oEQgakDvjhT5qO+jkDbRurVu5hn
         kk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k8md6zmM090pLvd8O9V1YcO888OyPmKVBIHUw3FpN4k=;
        b=ZPE0S8POEdm9lHq/mOuU5ZKfsRsq1qF+6rUUREjvmKddENBXZKMM1wFLcBO1cJox+n
         CVenOfwhebySmlH0Yzm/QgemnWCrhMwuXkPSGvzSP1sVIs0VLI8pT7mlD7mTrVTW7h6l
         8tEOvPBMLIfc78tKJU4DoQtancFzqOnhXhFqgmcWsKM03fnkGQ19w3iXF3IOpHjDt869
         Ucqn7bhg3Qfp8lDJg9wx0oWNhjnkvse++dF/NjgGT5P6+Bs+hcUwgqVEL6/aMPBUrjEt
         /JZaVVwCoqC1ZWO74hZKNfav4KGKOcNjrVvF/n4GEFNsjR9symWUf02j+DBb7tqSNNDp
         UO4w==
X-Gm-Message-State: AOUpUlEmvDdhuV5mYRi+VO96J93cDLBM+WbRw14Afz1X+0jC/b2ucBQg
        94PbPMureob/iXS0eBss3LjM2yYJj5YdwxJ/MdBbQg==
X-Google-Smtp-Source: AAOMgpd/WsxW6hjEQMx110VWuJqJyjUBvmxv7W4D/VQfTDPJvOzEHtvXl5wClHu2LDCklvJIoYcPPKouleHEjfXHsl0=
X-Received: by 2002:a63:a502:: with SMTP id n2-v6mr3531933pgf.263.1532642207482;
 Thu, 26 Jul 2018 14:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180725202238.165314-1-salyzyn@android.com> <20180725210717.3b807191@vmware.local.home>
 <11437c3e-5131-7190-c496-7b51eb7fcc2a@android.com> <20180726112245.3c1bf91d@gandalf.local.home>
 <CAKwvOdknFPpyQx17EbixnydJukuX4kH8=xVTS_9qnsERKCoPkQ@mail.gmail.com>
 <20180726123719.0db9dca0@gandalf.local.home> <CAKwvOdk26WrqF7Ni0DP+KYEp7LCtfhTemG5RBYFwR02_VRc=6Q@mail.gmail.com>
In-Reply-To: <CAKwvOdk26WrqF7Ni0DP+KYEp7LCtfhTemG5RBYFwR02_VRc=6Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 26 Jul 2018 14:56:36 -0700
Message-ID: <CAKwvOdmyEoBJCGEERUB1Vjzgw6bZpmopGzyhTecCJBMjjd_fbg@mail.gmail.com>
Subject: Re: [PATCH] tracing: do not leak kernel addresses
To:     rostedt@goodmis.org
Cc:     salyzyn@android.com, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 9:59 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Jul 26, 2018 at 9:37 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Thu, 26 Jul 2018 09:32:07 -0700
> > Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > > On Thu, Jul 26, 2018 at 8:22 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > >
> > > > On Thu, 26 Jul 2018 08:14:08 -0700
> > > > Mark Salyzyn <salyzyn@android.com> wrote:
> > > >
> > > > > Thank you Steve, much appreciated feedback, I have asked the security
> > > > > developers to keep this in mind and come up with a correct fix.
> > > > >
> > > > > The correct fix that meets your guidelines would _not_ be suitable for
> > > > > stable due to the invasiveness it sounds, only for the latest will such
> > > > > a rework make sense. As such, the fix proposed in this patch is the only
> > > > > one that meets the bar for stable patch simplicity, and merely(!) needs
> > > > > to state that if the fix is taken, perf and trace are broken.
> > > > >
> > > > > Posting this patch publicly on the lists, that may never be applied, may
> > > > > be the limit of our responsibility for a fix to stable kernel releases,
> > > > > to be optionally applied by vendors concerned with this CVE criteria?
> > > > >
> > > >
> > > > The patch breaks the code it touches. It makes it useless.
> > >
> > > Doesn't that depend on kptr_restrict, or would it be broken if
> > > kptr_restrict was set to 0?
> >
> > Is that what governs the output of kallsyms?
>
> From my workstation:
>
> $ cat /proc/kallsyms
>
> prints a bunch of zero'd out addresses, while
>
> $ sudo !!
>
> prints out actual addresses.  Looking at kernel/kallsyms.c, it seems
> that there's no use of %pK, but kallsyms_show_value() switches on
> kptr_restrict (and additional values):
>
> /*
>  * We show kallsyms information even to normal users if we've enabled
>  * kernel profiling and are explicitly not paranoid (so kptr_restrict
>  * is clear, and sysctl_perf_event_paranoid isn't set).
>  *
>  * Otherwise, require CAP_SYSLOG (assuming kptr_restrict isn't set to
>  * block even that).
>  */
> int kallsyms_show_value(void)
> {
>         switch (kptr_restrict) {
>         case 0:
>                 if (kallsyms_for_perf())
>                         return 1;
>         /* fallthrough */
>         case 1:
>                 if (has_capability_noaudit(current, CAP_SYSLOG))
>                         return 1;
>         /* fallthrough */
>         default:
>                 return 0;
>         }
> }

What are folks thoughts on this:
1. create function show_symbols_for_perf() that replaces
kallsyms_show_value(), maybe in linux/ftrace.c (since linux/ftrace.h
is included in kernel/trace/trace_printk.c and kernel/kallsyms.c).
2. use new show_symbols_for_perf() in kernel/kallsyms.c and
kernel/trace/trace_printk.c

Where the implementation of show_symbols_for_perf() is
kallsyms_show_value() implementation-wise (just renamed since it's no
longer kallsyms specific).  Does that make sense, or should I just
send a patch?  Does it make sense to check whether
kernel/trace/trace_printk.c#t_show() should print an address based on
the same checks done in kallsyms_show_value()?

-- 
Thanks,
~Nick Desaulniers
