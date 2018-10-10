Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0C2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BFE20870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgRaP0Uk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BFE20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeJJUMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:12:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38455 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeJJUMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:12:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id 193-v6so5599846wme.3;
        Wed, 10 Oct 2018 05:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q6H2RkjdYJ9dOgf//cL2kQO3iV8MOCmgeDmaXmfkjjQ=;
        b=IgRaP0UkWritTfjrO0qmGrFzOQHnYm/5fLSdxkHcBjBfxUJIxZy2kYnXl6beWtJ2LB
         qHEjps85WxkarkUoU1ltMOcmq5pOWT04r6k+8+hy/Axdw6MCTbknbJTWGwUZRj2ukAf8
         lDMd0KDZ8qIhu/tSf6sfamntM8n4CXbYgWQGLOwHsM2AGNrBWHb6XMFR4AfQomWdfimR
         3YJthySYLFiWsJNXWnKtqzUgFk4cnhhT/zp9AcIKvZIsVOLgH5LixT5QueEq0wI4/4R2
         E6zkFzICAgUD8PJgiWZU8TWTlvnUns9pNh8GzU1PJiAucfO9WGwB8CU3W6iNnAEdR1Q1
         BzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q6H2RkjdYJ9dOgf//cL2kQO3iV8MOCmgeDmaXmfkjjQ=;
        b=ZO1mc9fWDDEV5lvecLHYC71m0aRR2b8e0776C1VTETuM2TeflelhGMJpjgw926BkV9
         gYWyLlJRxFgY/BGpfROY/0oYwltMYMTE997gteBypzGSXdjaA8cJnkJp96tG2UnsBZjQ
         ffMgo4NlU29who/TPDhVRUUB5S7zYb8tsYxxGPLDpcPeCUorMUdhsAkx4fXtCE/J8arS
         ugNZ7ATw4LEcQSm5tab0gj40ia1yRReieq3YiR6YKbWGCd67TR+W/YurzwHuuNxmkpF2
         gOhRhami+xg8nPTEtPvbz2xrTJaZuHxui9wGWe5hmtnQBl4+zq4VN9DJp69T4cA7olr8
         +xHA==
X-Gm-Message-State: ABuFfohySdJmu95zAfo4OsfloveA3niwVEK7yZeLQo82pphp/PsGZikn
        AClyQXFReZvoliWqS9Z4AOU=
X-Google-Smtp-Source: ACcGV60hhrVFcaROuQKrMs1LFcobzcR4JnvkHbb6T5nffLDcoNVbOeSxVjcVtSwcE2wAHg0gwI6W8g==
X-Received: by 2002:a1c:bc82:: with SMTP id m124-v6mr812079wmf.76.1539175838503;
        Wed, 10 Oct 2018 05:50:38 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BD31613C1F2E846AEDA540D.dip0.t-ipconnect.de. [2003:ef:2bd3:1613:c1f2:e846:aeda:540d])
        by smtp.gmail.com with ESMTPSA id o3-v6sm17369297wrw.93.2018.10.10.05.50.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 05:50:37 -0700 (PDT)
Date:   Wed, 10 Oct 2018 14:50:33 +0200
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
Message-ID: <20181010125033.GP9130@localhost.localdomain>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com>
 <20181010082933.4ful4dzk7rkijcwu@queper01-lin>
 <CAKfTPtA1sgf77xLUPr74iEEb+W8PGCMCkgu+Kw8xM_Jxx7_hjQ@mail.gmail.com>
 <20181010095459.orw2gse75klpwosx@queper01-lin>
 <CAKfTPtA+FWrMnerQhrNQhvmvVSK_S86da=8shpdET-807zZgVg@mail.gmail.com>
 <20181010103623.ttjexasymdpi66lu@queper01-lin>
 <CAKfTPtBM24F99OhtjWU-cx4DdFFpvUMMDYuqZH_vaJg9HEpPTw@mail.gmail.com>
 <20181010122348.GL9130@localhost.localdomain>
 <CAKfTPtCVryjWWT_M1zEZfJUjGkt2JPUiBK6vt0YiJTK4qVoqbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCVryjWWT_M1zEZfJUjGkt2JPUiBK6vt0YiJTK4qVoqbA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18 14:34, Vincent Guittot wrote:
> Hi  Juri,
> 
> On Wed, 10 Oct 2018 at 14:23, Juri Lelli <juri.lelli@gmail.com> wrote:
> >
> > On 10/10/18 14:04, Vincent Guittot wrote:
> >
> > [...]
> >
> > > The problem was the same with RT, the cfs utilization was lower than
> > > reality because RT steals soem cycle to CFS
> > > So schedutil was selecting a lower frequency when cfs was running
> > > whereas the CPU was fully used.
> > > The same can happen with thermal:
> > > cap the max freq because of thermal
> > > the utilization with decrease.
> > > remove the cap
> > > the utilization is still low and you will select a low OPP because you
> > > don't take into account cycle stolen by thermal like with RT
> >
> > What if we scale frequency component considering the capped temporary
> > max?
> 
> Do you mean using a kind of scale_thermal_capacity in accumulate_sum
> when computing utilization ?

Yeah, something like that I guess. So that we account for temporary
"fake" 1024..
