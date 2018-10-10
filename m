Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB6FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A652087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRiD1Yw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A652087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeJJU5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:57:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41176 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJJU5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:57:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id x12-v6so5761647wru.8;
        Wed, 10 Oct 2018 06:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uffYuZBcMQvGeIQZqgL1IShi2mtpdHBe+6jz9Yahix8=;
        b=BRiD1Yw1enEy4aFmnKPAkK48TJRPR7jnObfk+edc1b8mBHLM7x2+vDICL8Fl417kEW
         t3i1WISlqJOBYtsJka58D+Pat35xQNGPbh5GePwAv29rz4nkVGijlpKIeXMscdlkvjYU
         ltiuyaM3PUE3qLB8sUA6QsVE0dRxvIcQwB9qB/IIq0lnJ7bpgmT5WWi37nFGV/c+PgtY
         7cKC/fdiL1NexEGMyPtXWoCR7Ls8pBUPPid98D/dsFsWqyC8DdUTz5AV0PMDvXcJ7ZgK
         6lYIvUloKwbI0Zhm9ejw7WlL29EJNXVDweUml+HDA9TaA2GMVw09mHwO6JZKCzQ7OpZm
         KFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uffYuZBcMQvGeIQZqgL1IShi2mtpdHBe+6jz9Yahix8=;
        b=ggsCyvK6NfDWqB8zS9DG/2BveDJ/IsMYqtFvKQW3k9trU7wfnJ7R/z11lacIt5/lqo
         ETrv7Tx/0kDA/TCSeM+wlrkIbUHZ9FDSo2v7cNYORGmBa7WnriL+2m05hnhKao3garMV
         GKUxy5AA62EOB/A0gQCzO66iT1Ol84eohDEsaYpDLvqQZc7VFwpIIXxRNqAgBDlYejPF
         95L7Mu8d7sKYj1dIWh7YU9/6A+Qo7QNxKkbLRpiLnwXyUYB+ic19CLj6Ruko+MHYUDe2
         05RgxX8GNt5inwZtm3nNnIs5FszDvqlkA05om6yTtn6GAf1xHD8Pe8dg6kreIWrY8dh9
         ghyg==
X-Gm-Message-State: ABuFfoiDApImvq4FMFQNoekDYqT3C7tj2eEWWbByauFvUWWI8h2kTDJL
        oLfdvcV6BCgdYiT2R+wMDuw=
X-Google-Smtp-Source: ACcGV63ZCXq2IQVuZqz8x4E0RlzyJSomfHF9X+ZWiBkLf9pDw5KVyy20wBN55y7wPH4tuZxvdZSDCg==
X-Received: by 2002:adf:f8cd:: with SMTP id f13-v6mr23780598wrq.265.1539178503555;
        Wed, 10 Oct 2018 06:35:03 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BD31613C1F2E846AEDA540D.dip0.t-ipconnect.de. [2003:ef:2bd3:1613:c1f2:e846:aeda:540d])
        by smtp.gmail.com with ESMTPSA id e196-v6sm10058822wmf.43.2018.10.10.06.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 06:35:02 -0700 (PDT)
Date:   Wed, 10 Oct 2018 15:34:43 +0200
From:   Juri Lelli <juri.lelli@gmail.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
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
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Message-ID: <20181010133443.GR9130@localhost.localdomain>
References: <20181010082933.4ful4dzk7rkijcwu@queper01-lin>
 <CAKfTPtA1sgf77xLUPr74iEEb+W8PGCMCkgu+Kw8xM_Jxx7_hjQ@mail.gmail.com>
 <20181010095459.orw2gse75klpwosx@queper01-lin>
 <CAKfTPtA+FWrMnerQhrNQhvmvVSK_S86da=8shpdET-807zZgVg@mail.gmail.com>
 <20181010103623.ttjexasymdpi66lu@queper01-lin>
 <CAKfTPtBM24F99OhtjWU-cx4DdFFpvUMMDYuqZH_vaJg9HEpPTw@mail.gmail.com>
 <20181010122348.GL9130@localhost.localdomain>
 <CAKfTPtCVryjWWT_M1zEZfJUjGkt2JPUiBK6vt0YiJTK4qVoqbA@mail.gmail.com>
 <20181010125033.GP9130@localhost.localdomain>
 <CAKfTPtAL5b0ZAOY_85ajskOX+thLf3j3M-xJ+Pt_NrM+N8udPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAL5b0ZAOY_85ajskOX+thLf3j3M-xJ+Pt_NrM+N8udPw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18 15:08, Vincent Guittot wrote:
> On Wed, 10 Oct 2018 at 14:50, Juri Lelli <juri.lelli@gmail.com> wrote:
> >
> > On 10/10/18 14:34, Vincent Guittot wrote:
> > > Hi  Juri,
> > >
> > > On Wed, 10 Oct 2018 at 14:23, Juri Lelli <juri.lelli@gmail.com> wrote:
> > > >
> > > > On 10/10/18 14:04, Vincent Guittot wrote:
> > > >
> > > > [...]
> > > >
> > > > > The problem was the same with RT, the cfs utilization was lower than
> > > > > reality because RT steals soem cycle to CFS
> > > > > So schedutil was selecting a lower frequency when cfs was running
> > > > > whereas the CPU was fully used.
> > > > > The same can happen with thermal:
> > > > > cap the max freq because of thermal
> > > > > the utilization with decrease.
> > > > > remove the cap
> > > > > the utilization is still low and you will select a low OPP because you
> > > > > don't take into account cycle stolen by thermal like with RT
> > > >
> > > > What if we scale frequency component considering the capped temporary
> > > > max?
> > >
> > > Do you mean using a kind of scale_thermal_capacity in accumulate_sum
> > > when computing utilization ?
> >
> > Yeah, something like that I guess. So that we account for temporary
> > "fake" 1024..
> 
> But the utilization will not be invariant anymore across the system

Mmm, I guess I might be wrong, but I was thinking we should be able to
deal with this similarly to what we do with cpus with different max
capacities. So, another factor?  Because then, how do we handle other
ways in which max freq can be restricted (e.g. from userspace as Javi
was also mentioning)?
