Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0168DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAEE82075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gXmVcyqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAEE82075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeJJVBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:01:24 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54085 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeJJVBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:01:23 -0400
Received: by mail-it1-f196.google.com with SMTP id q70-v6so8037130itb.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 06:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6YQ8CO3YMjzfA2gYVu5dxFhovXelNBSF33wEAhFkAhQ=;
        b=gXmVcyqulKb9JQ+qP0oVvCAJWDUhONvUaTed/mUVSwibUOE9VY6VFR9EWEjRSI8YGl
         PTJ1KAN52NFK+D8Gak2Vhwm0vqVf8rs//cmdk7h6ajw4tp8sbhsdbBTtgDK1oEpNPfPv
         zAUypsOyMryVP/Ihc7H3bqM+Gx/GbtqMLPF+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6YQ8CO3YMjzfA2gYVu5dxFhovXelNBSF33wEAhFkAhQ=;
        b=mnbxhOmmJ9LupYzq91NcCor2eN4Cz7xPPWe6bB0W7DaBLtGLQ9lhGrJxojNmnwpN7N
         OSPO+ARSSpIpPfLJe4OvoZzu4VKooXcO+wPxmnMkSIsmli0bbiRU8RD1CZNgrAaozOQE
         JWd5z2cyvgeQDod6qg2bVbDcLFgL79hghpEIVQGXz+eHCfJivBueLHGYwV/uTe5V5A+I
         Oshsn7Zp/c4M4YVevGT/53D9JO9c40I3l9zTq5fka/U5dBqdJOgTb0PZT7sXR/OqJv8h
         VQbv6avoIBU132CYD1MF5D+srUPKDlClKBPNopUa5FAB51m1B/f6wlKV0KuZ6mKevLvw
         n16w==
X-Gm-Message-State: ABuFfojAfiTX6mOa4QBYTjA8rJwVoehU9RfYClIcBowiw+FV84V4fFKU
        V7CftqYsetgAFB7Q4kBKxBtClgbXudAwR9UFlg3dNQ==
X-Google-Smtp-Source: ACcGV63HN4e86xDUwGRyHaKy1R9cuLswPXUnsjaY5289Ivu9QfOpBicw1Nji3UpuY/zt+WW/FBAWMXKNZH/Yg2guFJQ=
X-Received: by 2002:a02:844c:: with SMTP id l12-v6mr26897876jah.137.1539178749213;
 Wed, 10 Oct 2018 06:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181010082933.4ful4dzk7rkijcwu@queper01-lin> <CAKfTPtA1sgf77xLUPr74iEEb+W8PGCMCkgu+Kw8xM_Jxx7_hjQ@mail.gmail.com>
 <20181010095459.orw2gse75klpwosx@queper01-lin> <CAKfTPtA+FWrMnerQhrNQhvmvVSK_S86da=8shpdET-807zZgVg@mail.gmail.com>
 <20181010103623.ttjexasymdpi66lu@queper01-lin> <CAKfTPtBM24F99OhtjWU-cx4DdFFpvUMMDYuqZH_vaJg9HEpPTw@mail.gmail.com>
 <20181010122348.GL9130@localhost.localdomain> <CAKfTPtCVryjWWT_M1zEZfJUjGkt2JPUiBK6vt0YiJTK4qVoqbA@mail.gmail.com>
 <20181010125033.GP9130@localhost.localdomain> <CAKfTPtAL5b0ZAOY_85ajskOX+thLf3j3M-xJ+Pt_NrM+N8udPw@mail.gmail.com>
 <20181010133443.GR9130@localhost.localdomain>
In-Reply-To: <20181010133443.GR9130@localhost.localdomain>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 10 Oct 2018 15:38:57 +0200
Message-ID: <CAKfTPtAyhXtKH3XeQHUHZLK+uvdsAzh5H=X+1OOAWFpP9o-L5w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     Juri Lelli <juri.lelli@gmail.com>
Cc:     Quentin Perret <quentin.perret@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2018 at 15:35, Juri Lelli <juri.lelli@gmail.com> wrote:
>
> On 10/10/18 15:08, Vincent Guittot wrote:
> > On Wed, 10 Oct 2018 at 14:50, Juri Lelli <juri.lelli@gmail.com> wrote:
> > >
> > > On 10/10/18 14:34, Vincent Guittot wrote:
> > > > Hi  Juri,
> > > >
> > > > On Wed, 10 Oct 2018 at 14:23, Juri Lelli <juri.lelli@gmail.com> wrote:
> > > > >
> > > > > On 10/10/18 14:04, Vincent Guittot wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > The problem was the same with RT, the cfs utilization was lower than
> > > > > > reality because RT steals soem cycle to CFS
> > > > > > So schedutil was selecting a lower frequency when cfs was running
> > > > > > whereas the CPU was fully used.
> > > > > > The same can happen with thermal:
> > > > > > cap the max freq because of thermal
> > > > > > the utilization with decrease.
> > > > > > remove the cap
> > > > > > the utilization is still low and you will select a low OPP because you
> > > > > > don't take into account cycle stolen by thermal like with RT
> > > > >
> > > > > What if we scale frequency component considering the capped temporary
> > > > > max?
> > > >
> > > > Do you mean using a kind of scale_thermal_capacity in accumulate_sum
> > > > when computing utilization ?
> > >
> > > Yeah, something like that I guess. So that we account for temporary
> > > "fake" 1024..
> >
> > But the utilization will not be invariant anymore across the system
>
> Mmm, I guess I might be wrong, but I was thinking we should be able to
> deal with this similarly to what we do with cpus with different max
> capacities. So, another factor?  Because then, how do we handle other
> ways in which max freq can be restricted (e.g. from userspace as Javi
> was also mentioning)?

IMHO, userspace capping is a different story because it is not
expected to happen so often but it should stay for a while and in this
case, a solution is probably to rebuild the sched_domain and update
all the cpu_capacity struct and fields
