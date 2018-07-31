Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D684C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C7E208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WQWrYVL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C7E208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbeGaNv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:51:56 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34421 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731131AbeGaNvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:51:55 -0400
Received: by mail-it0-f66.google.com with SMTP id d70-v6so12213668ith.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 05:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VWDetoB+q1cq2/33ZivvvjDEUM2wwf4OVdVGFVmjqpY=;
        b=WQWrYVL3hZOqcLlIB4O3daAAOJdfQEG41V/s9RdVxoYa/6CQdH7Nx8WxnowQ/alm8H
         YhaDFc7Icktl6Ifj1pF4Ktf/QgB1oTA0f/K6jsnNGu8I6ULd/Fvoz37LnZehZIaENQEY
         NW/CXy6FS4GPTMrs8T8opOWTjRHetEVB0c7Mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VWDetoB+q1cq2/33ZivvvjDEUM2wwf4OVdVGFVmjqpY=;
        b=eArOaLd3exzbHNZ/Sq7CZ8JcwmAitEt13JDapQ6wmQSPi2Sb5uVhSuoNcIt/SaVqin
         3tyyq1LIuowFTTb+HLtpgVl2eNRAU3TRnFvKtOcxgiBJ2+n2E3QR/7S/ni3q475cdUEt
         Kbr/lj2cV3ckcHaf0wVNny68jpUY5zpSHWRGO1vFBBT/5PZl3PSiJPaSrv21GNG18Lpe
         2EtqjdHorZZ0yyQMzOUS0XUfI5wQDMxMri46OxsAthXFvACsLh6RpdqGHeau2/kEBgfR
         cFyZ9LwklNF8OgCaXQW1GK0oxL+ypVBKHDRcNK01FICAmeTQWLsozpESJt51Yey0Sy9u
         t/6g==
X-Gm-Message-State: AOUpUlF1enT6zPBaF4vrfE4zH2owmlaDYZZQ96jrEAthvXR66WSc+dyQ
        wUBOLch/k7SrMX/mXyysPhmMBzT4ivBf27fxrhJRrA==
X-Google-Smtp-Source: AAOMgpcxZ63ML9di7YWqi045YRQAx/gXYCB9QIFd4dVjLvBHLoLuuoSk5rWOnGqmOKbUP1AduEfZyoY1oTuSAp7SULA=
X-Received: by 2002:a24:99c4:: with SMTP id a187-v6mr2662307ite.148.1533039112571;
 Tue, 31 Jul 2018 05:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
 <CAKfTPtB9tRb6vWAHf-CyMpZjMaRtOzUnB7PCuWwAmfsJf_Y6pA@mail.gmail.com> <20180709150839.GA19287@e105550-lin.cambridge.arm.com>
In-Reply-To: <20180709150839.GA19287@e105550-lin.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 31 Jul 2018 14:11:41 +0200
Message-ID: <CAKfTPtCbP5L_V-jQCE63C7SSZSWyke=oFeoSpLZFTZgej8FnNw@mail.gmail.com>
Subject: Re: [PATCHv4 00/12] sched/fair: Migrate 'misfit' tasks on asymmetric
 capacity systems
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gaku.inami.xh@renesas.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2018 at 17:08, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
>
> On Fri, Jul 06, 2018 at 12:18:27PM +0200, Vincent Guittot wrote:
> > Hi Morten,
> >
> > On Wed, 4 Jul 2018 at 12:18, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> > >
> > > On asymmetric cpu capacity systems (e.g. Arm big.LITTLE) it is crucial
> > > for performance that cpu intensive tasks are aggressively migrated to
> > > high capacity cpus as soon as those become available. The capacity
> > > awareness tweaks already in the wake-up path can't handle this as such
> > > tasks might run or be runnable forever. If they happen to be placed on a
> > > low capacity cpu from the beginning they are stuck there forever while
> > > high capacity cpus may have become available in the meantime.
> > >
> > > To address this issue this patch set introduces a new "misfit"
> > > load-balancing scenario in periodic/nohz/newly idle balance which tweaks
> > > the load-balance conditions to ignore load per capacity in certain
> > > cases. Since misfit tasks are commonly running alone on a cpu, more
> > > aggressive active load-balancing is needed too.
> > >
> > > The fundamental idea of this patch set has been in Android kernels for a
> > > long time and is absolutely essential for consistent performance on
> > > asymmetric cpu capacity systems.
> > >
> >
> > As already said , I'm not convinced by the proposal which seems quite
> > complex and also adds some kind of arbitrary and fixed power
> > management policy by deciding which tasks can or not go on big cores
> > whereas there are other frameworks to take such decision like EAS or
> > cgroups.
>
> The misfit patches are a crucial part of the EAS solution but they also

EAS needs  the scheduler to move long running task on big core
(especially when overloaded), and the misfit task is just one proposal

> make sense for some users on their own without an energy model. This is
> why they are posted separately.
>
> We have already discussed at length why the patches are needed and why
> the look like they do here in this thread:
>
> https://lore.kernel.org/lkml/CAKfTPtD4skW_3SAk--vBEC5-m1Ua48bjOQYS0pDqW3nPSpsENg@mail.gmail.com/
>
> > Furthermore, there is already something similar in the kernel
> > with SD_ASYM_PACKING and IMO, it would be better to improve this
> > feature (if needed) instead of adding a new one which often do similar
> > things.
>
> As said in the previous thread, while it might look similar it isn't.
> SD_ASYM_PACKING isn't utilization-based which is the key metric used for
> EAS, schedutil, util_est, and util_clamp. SD_ASYM_PACKING serves a
> different purpose (see previous thread for details).
>
> > I have rerun your tests and got same results than misfit task patchset
> > on my hikey960 with SD_ASYM_PACKING feature for legacy b.L topology
> > and fake dynamiQ topology. And it give better performance when the
> > pinned tasks are short and scheduler has to wait for the task to
> > increase their utilization before getting a chance to migrate on big
> > core.
>
> Right, the test cases are quite simple and could be served better by
> SD_ASYM_PACKING. As we already discussed in that thread, that is due to
> the PELT lag but this the cost we have to pay if we don't have
> additional information about the requirements of the task and we don't
> want to default to big-first with all its implications.
>
> We have covered all this in the thread in early April.
>
> > Then, I have tested SD_ASYM_PACKING with EAS patchset and they work
> > together for b/L and dynamiQ topology
>
> Could you provide some more details about your evaluation? It probably
> works well for some use-cases but it isn't really designed for what we
> need for EAS.
>
> Morten
