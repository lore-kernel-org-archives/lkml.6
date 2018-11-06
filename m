Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605FBC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C19620827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muxHiwzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C19620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbeKFRqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 12:46:30 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39272 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbeKFRq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 12:46:29 -0500
Received: by mail-it1-f194.google.com with SMTP id m15so16502593itl.4;
        Tue, 06 Nov 2018 00:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6rxzsygFvwgvMPvbNpVhzKak9pVrH5QZwWfnwr46so=;
        b=muxHiwzdr8WyfEqcUiX6+3QgglH1UFmNM0/YTC4KeDnCZintzSvAAUFBH+MiaeE8Y8
         3LyZkGMQK7wMDUeRUNdEXS9O/8r3hlWi4kodQWZis3soa7UeWOTbfBhyLJwSaAjgEaR9
         CUY7sRzLdonXUMgNx4ELTF3FIzwvJvB63UBjvGY0VeUyVG9+vwvlXmK3bC0JMoCTP2Oc
         qneMNBPfDyWeE9682rU7IIX8BnOyL8Km/vw6FXhCpXh7Dz4P8JKooQ7fO4r3deV/4Ev/
         TSYpuPxTDKZWzZvfETBSTXfDM9MEKm5j9eNIYfxSNdqfWlbvQap2pqWL1lYDwFysPj7O
         EDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6rxzsygFvwgvMPvbNpVhzKak9pVrH5QZwWfnwr46so=;
        b=tQnKLFY4+bgga6j2y2v+8by+HPLuz8oXKVqHd4VbPmUmYsx8AFD/NaLjG2tWM310sU
         /1yAJUebLHkJFJd8H3P3R7YOh+49mxH8UXX9f4VrNhLDsW7YF7DV7EZO0L20q/A3T5UP
         oOLqoga0XHtSbHOHhJjVUeVnLpzPgaFYgYstuxEDbvvT8FpfxpmBYAP0ZY5p/pjbG2j5
         yI2wUFE9jYPmksk2qpselVdXp5adzODxYBGWKlvDSzoDdz+sPGxJDqjxFhjVGG1C6R1A
         i3FqIV9KxrpfHjBBiztKzFhl5cLqsN9e4zGZMdcI8ZOnbBn+L5W+CutSwqZTLVD8wEuz
         5w1Q==
X-Gm-Message-State: AGRZ1gJb+EXiGfgV0we0THYhu4ZMNCamIZMISL3e4WJTsyl62bjR3ORK
        pKv05ZVaB2DcSWJPaM3t39MjTkAw5ofubNKf6Qg=
X-Google-Smtp-Source: AJdET5eOjoJsmcD203XA5vvtc70L5DqRGP4W7QFoXbWL1KPZRh4jUCRUMyuZXt8WAL7zF+wIbwCzqIQNmzZYJNnPdAo=
X-Received: by 2002:a05:660c:342:: with SMTP id b2mr1076435itl.167.1541492545314;
 Tue, 06 Nov 2018 00:22:25 -0800 (PST)
MIME-Version: 1.0
References: <CADvbK_dNN34=5V3qtk3_vBzKNts55ACR4c-erPafgNuAQ-eRuw@mail.gmail.com>
 <20181102102616.GC5458@krava> <CADvbK_cr_vhtyaid=xbECdNs+xCr4Oi8pJJc83jZa+XJOWAjJw@mail.gmail.com>
 <20181104191754.GB18517@krava> <CADvbK_cgp7S-8Q-6GArwViCDBhCoB9LcZvJaGM6QFAg9qNOeHw@mail.gmail.com>
 <20181105084906.GA30951@krava>
In-Reply-To: <20181105084906.GA30951@krava>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Tue, 6 Nov 2018 17:22:13 +0900
Message-ID: <CADvbK_fTk=kFwOG9QucE9yDdp6+BD9wAvphZtifZ5UPJL8NK8g@mail.gmail.com>
Subject: Re: perf script doesn't dump a normal call trace
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 5:49 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Nov 05, 2018 at 03:20:15PM +0900, Xin Long wrote:
>
> SNIP
>
> > > > > [root@ibm-x3650m4-02 perf]# ./perf probe 'consume_skb'
> > > > > [root@ibm-x3650m4-02 perf]# ./perf record -g -e probe:consume_skb* -aR ^C
> > > > >
> > > > Thanks Jiri,
> > > >
> > > > My debugging script is using tracepoint with some filters which I
> > > > don't think probe can support.
> > > > Any one have fixes for this tracepoint issue?
> > >
> > > trying to bisect that.. looks like orc code issue,
> > > it works for me when you switch to fp unwind:
> > >   CONFIG_UNWINDER_FRAME_POINTER
> > >
> >
> > That's a good workaround, thanks.
> >
> > Another problem is when I'm using perf built manually from upstream kernel tree,
> > I couldn't see the function's names.
> > # perf --version
> > perf version 4.19.g26f1de
> >
> > # perf report -T
> > # To display the perf.data header info, please use
> > --header/--header-only options.
> > #
> > #
> > # Total Lost Samples: 0
> > #
> > # Samples: 97  of event 'probe:consume_skb'
> > # Event count (approx.): 97
> > #
> > # Children      Self  Trace output
> > # ........  ........  ..................
> > #
> >    100.00%   100.00%  (ffffffff86f090f0)
> >             |
> >             |--93.81%--0xffffffff868000e6
> >             |          0xffffffff8684ed7f
> >             |          0xffffffff868e97ad
> >             |          0xffffffff868e953a
> >             |          0xffffffff87087623
> >             |          0xffffffff8682a06f
> >             |          0xffffffff870872ad
> >             |          |
> >             |          |--89.69%--0xffffffff8720098f
> >             |          |          0xffffffff87201b69
> >             |          |          0xffffffff868b9c2e
> >
> >
> > The below is with rhel7's perf
> > # perf --version
> > perf version 3.10.0-957.el7.x86_64.debug
> > # perf report -T
> > # To display the perf.data header info, please use
> > --header/--header-only options.
> > #
> > #
> > # Total Lost Samples: 0
> > #
> > # Samples: 97  of event 'probe:consume_skb'
> > # Event count (approx.): 97
> > #
> > # Children      Self  Trace output
> > # ........  ........  ..................
> > #
> >    100.00%   100.00%  (ffffffff86f090f0)
> >             |
> >             |--93.81%--0x2000e6
> >             |          start_secondary
> >             |          cpu_startup_entry
> >             |          do_idle
> >             |          default_idle_call
> >             |          arch_cpu_idle
> >             |          default_idle
> >             |          |
> >             |          |--89.69%--ret_from_intr
> >             |          |          do_IRQ
> >             |          |          irq_exit
>
> I think that's already fixed on Arnaldo's perf/urgent branch,
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
>
> but perhaps this post as well:
>   https://lore.kernel.org/lkml/20181031091043.23465-1-adrian.hunter@intel.com/
>
> please give it a try.. it should be merged in soon
I will try it later, I have another question?
# perf report -T

# Samples: 97  of event 'probe:consume_skb'
# Event count (approx.): 97
#
# Children      Self  Trace output
# ........  ........  ..................
#
   100.00%   100.00%  (ffffffff86f090f0)
            |
            |--93.81%--0x2000e6
            |          start_secondary
            |          cpu_startup_entry
            |          do_idle
            |          default_idle_call
            |          arch_cpu_idle
          [...]
            |          |                     |
            |          |                      --2.06%--arp_process
            |          |                                neigh_update
            |          |                                __neigh_notify
            |          |                                rtnl_notify
            |          |                                nlmsg_notify
            |          |                                consume_skb  <-----[1]


This command can show a nice tree, and it has the total samples number 97.
But I couldn't see how many of them are from [1]?
Do you know how to count each path's numbers?
Is there an option for "perf report" to do these statistics?
Thanks.
