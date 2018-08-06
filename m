Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEE1C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EBE21A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O4r/KRMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EBE21A04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbeHFMyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:54:24 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36813 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeHFMyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:54:23 -0400
Received: by mail-io0-f193.google.com with SMTP id r15-v6so10611929ioa.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 03:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IQ5++oWmOP3AaMNPmLyTB69q9qI8tUOzsdyvxXK/noM=;
        b=O4r/KRMWmvU0uGBWDF2aF75ZoB0mQblB//kJScp/EVUfbXvgDsyALHtOG+JXA0oM2q
         Oy2+D4KWbZv55RfYAnb3IKHhsEo/FB5Xm98Ga7KJxxMqEfXaCmJTxvyDuXutqBEISxKj
         lfLf8V50gq6kcAcfxwza/LO2J1wsFMGP3hmBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IQ5++oWmOP3AaMNPmLyTB69q9qI8tUOzsdyvxXK/noM=;
        b=uZ7TM2DEI5/WFgbsSPoIXamTZq+dcdNjOS4I7cHn4fowvZVYmqhO1cxUt/9LeCV+WZ
         3KVxau2xAj2e8B3+6qQFOnASevfc9YuzBbdNsxWANQfafSyBLuXfipubYsNxNlEGjYrh
         1r/lDMZsPSQ+ekleF+5hmC25ZKmaZYclo+89FETj/FVw44laZScTeH1FiOyXpe4hAGGj
         pXMNcv7sSFwQxMqR37vD/PCPgPbxR7qcnl3p8M5aZ9CwV77i84KM+DGe7LpcHYIkQlA2
         Swux5mtguDSPGxWQGosxz8ei7y+qy4tp3g0OwHef4KIw50ngpF3Z399AtSppCgKNzWKh
         gxsg==
X-Gm-Message-State: AOUpUlFfBCWpQOqhNqyzHDdcqP7nA1ILMAMpi+z8B84PWhRpXynBSfF7
        9gWICBBOomnO9ph96ZXXVIdz1qinKZHwBbVPTPX+5Q==
X-Google-Smtp-Source: AAOMgpeDtgRGTcJqi/53qLKRLcMCdQ6vkF2s30eu2Gl37PNqNkFJxBmGscc0o1ZxiB4PFa9aNZZ80JTH3f3gxtepI2M=
X-Received: by 2002:a5e:8341:: with SMTP id y1-v6mr13696900iom.183.1533552355181;
 Mon, 06 Aug 2018 03:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180802160009.uhwwj3tqrqmv7q5a@queper01-lin> <CAKfTPtB_tWgOPCB3q2Q2rESKczTPGBDUojcXDY7uP8YTQddBMg@mail.gmail.com>
 <20180802161027.v2ctgscuc4uxbb7u@queper01-lin> <CAKfTPtDtaF9Qs4NWkKWUSr8Ryi-ScYNmPyacocPQUPxT00XAYg@mail.gmail.com>
 <20180802165924.7ywgoxj2jwftxycz@queper01-lin> <CAKfTPtDsG4FJy5xBO8+6pJzehEM668=SZ4yQ-szVTduofN3QZg@mail.gmail.com>
 <20180803081850.hj7bp5ognuywapmd@queper01-lin> <CAKfTPtDkJY=JYicZk8sM9_mJ-iq+Jwse0oVRbW=wpxXKKnEoeQ@mail.gmail.com>
 <20180803155547.sxlhxpmhwcoappit@queper01-lin> <CAKfTPtBT-p-Z0EneirfOTwUw=5jEeDGa+4_EE4ogi2Ht7GU9Bg@mail.gmail.com>
 <20180806094342.lonjz4g3lspcatcy@queper01-lin>
In-Reply-To: <20180806094342.lonjz4g3lspcatcy@queper01-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 6 Aug 2018 12:45:44 +0200
Message-ID: <CAKfTPtBh2Z8Lc28avBOzOtz72eN-6vyuQZ1=5Wgbj4kJ=yn8FA@mail.gmail.com>
Subject: Re: [PATCH v5 09/14] sched: Add over-utilization/tipping point indicator
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com,
        "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2018 at 11:43, Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Monday 06 Aug 2018 at 10:40:46 (+0200), Vincent Guittot wrote:
> > On Fri, 3 Aug 2018 at 17:55, Quentin Perret <quentin.perret@arm.com> wrote:
> > For every new task, the cpu selection is done assuming it's a heavy
> > task with the max possible load_avg,  and it looks for the idlest cpu.
> > This means that if the system is lightly loaded, scheduler will select
> > most probably a idle big core.
>
> Agreed, that is what should happen if the system is lightly loaded.
> However, I'm still not totally convinced this is wrong. It's
> definitely not _always_ wrong, at least. Just like starting new tasks
> on little CPUs isn't always wrong either.

As explained before, IMHO, this is not wrong if you looks for
performance but this is wrong if you looks for power saving

>
> > selecting big or Little is not the problem here. The problem is that
> > we don't use Energy Model so we will most probably do the wrong
> > choice. Nevertheless,  putting a task on big is clearly the wrong
> > choice  in the case I mentioned above " shell script on hikey960".
>
> _You_ can say it's wrong because _you_ know the task composition. The
> scheduler has no way to tell. You could come up with a script that
> spawns heavy tasks every once in a while, and in this case putting
> those on big cores would be beneficial ...
>
> > Having something in the middle like taking into account load and/org
> > utilization of the parent in order to mitigate big task starting with
> > small utilization and small task starting with big utilization.
> > It's probably not perfect because big tasks can create small ones and
> > the opposite but if there are already big tasks, assuming that the new
> > one is also a big one should have less power impact as we are already
> > consuming power for the current bigs. At the opposite, if little are
> > running, assuming that new task is little will not harm the power
> > consumption unnecessarily.
>
> Right, we can definitely come up with something more conservative than
> what I'm currently proposing. I had a quick chat with Morten about this
> the other day and one suggestion he had was to pick the CPU with the max
> spare cap in the frequency domain in which the parent task is running ...
>
> In any case, I really feel like there isn't an obvious right decision
> here, so I'd prefer to keep things simple for now. This patch-set is a
> first step, and fine-grained tuning for new tasks is probably something
> that can be done later, if need be. What do you think ?

I would have preferred to have a full power policy for all task when
EAS is in used by default and then see if there is any performance
problem instead of letting some UC unclear but that's a personal
opinion.
so IMO, the minimum is to add a comment in the code that describes
this behavior for fork tasks so people will understand why EAS puts
newly created task on not "EAS friendly" cpus when they will look at
the code trying to understand the behavior

>
> Thanks,
> Quentin
