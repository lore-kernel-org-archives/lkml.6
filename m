Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C18C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 14:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CF020854
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 14:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CF020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbeIISxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 14:53:19 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37868 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbeIISxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 14:53:18 -0400
Received: by mail-oi0-f67.google.com with SMTP id p84-v6so35437942oic.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 07:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9v0oWjiA/0vEv6M5PTbwag6kWsZl6tMBluejWQsS99c=;
        b=FwBdlSVqU3SxFPAKwg9XzchkhHQdiHLNbF6EGoWnJIU6DCurjBrxN8y3Xde/aYjMZB
         VsZI+S3h4ThMvCI4Dt7k6pq1JxREid+V6CIRH/29emyZshNvsmOGufMtA+q95lM2c1Aj
         vcffoDA/jD1PmrUA1jhYblGEdci9j3asA5go8wJsE5ZXjqSoBzE8VhcAtpBTW549X1U3
         j3qd6FJV4RIhjU1LbjzZ/ilgaDeVIpjAE15fyVI/S5mFtx7IWAADKYa9O4JsbSYYRnJi
         Jgo/VZZuW6vm08BSbzxZyteMBroObG3MiVkZqchpHwtgIrbxpqHzDd83yUdkBBfh2zif
         lmVQ==
X-Gm-Message-State: APzg51Cgt/k6uo5ppl673+EjGHlzQGmtpGwj7mllpQZjHr9rS6a3MIIE
        O1+61gbFXjb9n/T6hLEfK03XjnBhXTqhaZKGbu5VQw==
X-Google-Smtp-Source: ANB0VdYMm91opNv9ui/4iYK/NAQVix8PMXv+1Dh0qggCpb/DXl5x8TZfqQHc/HziWqwpdE8NCFxTRs/+BYiQCHTvLeU=
X-Received: by 2002:aca:cf44:: with SMTP id f65-v6mr18352566oig.356.1536501810853;
 Sun, 09 Sep 2018 07:03:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:554b:0:0:0:0:0 with HTTP; Sun, 9 Sep 2018 07:03:30 -0700 (PDT)
In-Reply-To: <20180907135235.GE24106@hirez.programming.kicks-ass.net>
References: <CAE4VaGC+FcE4cTUwzTLuCRd8rnd-=MhSZHfjKstiRTKcYq-39g@mail.gmail.com>
 <20180907125649.GA3995@linux.vnet.ibm.com> <20180907131923.GB24106@hirez.programming.kicks-ass.net>
 <20180907134420.GD3995@linux.vnet.ibm.com> <20180907135235.GE24106@hirez.programming.kicks-ass.net>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Sun, 9 Sep 2018 16:03:30 +0200
Message-ID: <CAE4VaGBeTy-du_tThkr3w-r2KbYW8m+sRcpDPn9sYeENUy_x4g@mail.gmail.com>
Subject: Re: [SCHEDULER] Performance drop in 4.19 compared to 4.18 kernel
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Jakub Ra??ek" <jracek@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kkolakow@redhat.com" <kkolakow@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and Srikar,

thanks a lot for the information and for the patches to test!

> I have bounced the 5 patches to you, (one of the 6 has not been applied by
> Peter) so I have skipped that.
> They can also be fetched from
> http://lore.kernel.org/lkml/1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com

We have started the benchmarks, I will report the results on Monday.

> I generally run specjbb2005 (single and multi instance).
We also run a single and multi-instance specjbb2005 test.

> I have tried running NAS but I couldn't set it up properly.
We run the OMP variant and we control the number of threads with the
OMP_NUM_THREADS env variable. The setup is quite simple:

cd NPB_sources/config/
mv suite_x86_64.def suite.def
cd ..
make suite

FYI - starting from 4.17 kernel there is a significant performance
drop compared to 4.16 kernel. Mel has come up with a
sched-numa-fast-crossnode-v1r12 patch series
git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git which we have
tested extensively and with it, the benchmarks results are back at
4.16 level. As I understand it, Mel's patch series depends on your
patch series and can be only merged when your patches are completed.

Thanks!
Jirka


On Fri, Sep 7, 2018 at 3:52 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Sep 07, 2018 at 07:14:20PM +0530, Srikar Dronamraju wrote:
> > * Peter Zijlstra <peterz@infradead.org> [2018-09-07 15:19:23]:
> >
> > > On Fri, Sep 07, 2018 at 06:26:49PM +0530, Srikar Dronamraju wrote:
> > >
> > > > Can you please pick
> > > >
> > > >
> > > > 1. 69bb3230297e881c797bbc4b3dbf73514078bc9d sched/numa: Stop multiple tasks
> > > > from moving to the cpu at the same time
> > > > 2. dc62cfdac5e5b7a61cd8a2bd4190e80b9bb408fc sched/numa: Avoid task migration
> > > > for small numa improvement
> > > > 3. 76e18a67cdd9e3609716c8a074c03168734736f9 sched/numa: Pass destination cpu as
> > > > a parameter to migrate_task_rq
> > > > 4.  489c19b440ebdbabffe530b9a41389d0a8b315d9 sched/numa: Reset scan rate
> > > > whenever task moves across nodes
> > > > 5.  b7e9ae1ae3825f35cd0f38f1f0c8e91ea145bc30 sched/numa: Limit the
> > > > conditions where scan period is reset
> > > >
> > > > from https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/kernel/sched
> > >
> > > That is not a stable tree; the whole thing is re-generated from my quilt
> > > set every time I feel like it.
> > >
> > > It is likely those commit ids will no longer exist in a few hours.
> > >
> >
> > Okay, I will forward the relevant mails to Jirka.
>
> Or he can click on that link and find new IDs :-)
