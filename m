Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C54C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5F22085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZHLONgxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5F22085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeJJUbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:31:11 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53597 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJUbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:31:11 -0400
Received: by mail-it1-f193.google.com with SMTP id q70-v6so7886062itb.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 06:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=goG6rHNh3lqZ02ed0+4cIJ9377dB25xd+6dYr0fdBjA=;
        b=ZHLONgxITl1yvMkCxDaxsrmAHbXD0LsWiTsCbqKea1tRqdDNW4ktRX2lmetoYzWrq5
         Mv7PbQeRJA8+7RCNOIXNRToNlc2WQamg7vgJ5ze8qZPpkNsN835v4QLYwiysVftlybWf
         JcOJhYJ84PxGvap9C974BMV58bhAhCDtlxnAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=goG6rHNh3lqZ02ed0+4cIJ9377dB25xd+6dYr0fdBjA=;
        b=XtH4LYy6knZjTBDGHDCJ5uST4v57soIkhjSa9k2oSOLwU4cOUdTS3O+muswVDcgJ6M
         cRZyXtSWg7hifN0ARJpop4cGAB83VFfgk/q+uQHOKzahnhZ1o22dOyDLwHprivkyi11q
         F3WwsNJ5xXRr6AGvh70cFxmrwCUOG9XA2W7nRhoFIylAbejqybtBCoDnma42+h6LNjuU
         I+2R75AYmLRqduSCvJlzbZTe6QW4cGwGWKjngqFDzarvdc4RbgC5lx9DTZs+CbcpoiDg
         Cl0X58XowBamP+Gi0b45fM3HrCETcpt3V7Kkci1UIGPDbaGXNC1maEEHUwbNDmnGpdTd
         okDg==
X-Gm-Message-State: ABuFfogs7kj48JDDPzKZ7E05lrosF2y7KGs0Us43P3g837p5SrRMf/aL
        v+dNb2p+rvDecdxpKi2aRsQoYLjOxf1Yu3S2xTdiEA==
X-Google-Smtp-Source: ACcGV63GnGU0wbuHb9H1vfBOZwQqw8UbiOXi3daGSWLfPF5bolZVeBBEHq2utLNwrathjF/VwQ4ZLZTbyGeXtU94uRo=
X-Received: by 2002:a24:670a:: with SMTP id u10-v6mr688682itc.114.1539176943770;
 Wed, 10 Oct 2018 06:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com> <20181010082933.4ful4dzk7rkijcwu@queper01-lin>
 <CAKfTPtA1sgf77xLUPr74iEEb+W8PGCMCkgu+Kw8xM_Jxx7_hjQ@mail.gmail.com>
 <20181010095459.orw2gse75klpwosx@queper01-lin> <CAKfTPtA+FWrMnerQhrNQhvmvVSK_S86da=8shpdET-807zZgVg@mail.gmail.com>
 <20181010103623.ttjexasymdpi66lu@queper01-lin> <CAKfTPtBM24F99OhtjWU-cx4DdFFpvUMMDYuqZH_vaJg9HEpPTw@mail.gmail.com>
 <20181010122348.GL9130@localhost.localdomain> <CAKfTPtCVryjWWT_M1zEZfJUjGkt2JPUiBK6vt0YiJTK4qVoqbA@mail.gmail.com>
 <20181010125033.GP9130@localhost.localdomain>
In-Reply-To: <20181010125033.GP9130@localhost.localdomain>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 10 Oct 2018 15:08:52 +0200
Message-ID: <CAKfTPtAL5b0ZAOY_85ajskOX+thLf3j3M-xJ+Pt_NrM+N8udPw@mail.gmail.com>
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

On Wed, 10 Oct 2018 at 14:50, Juri Lelli <juri.lelli@gmail.com> wrote:
>
> On 10/10/18 14:34, Vincent Guittot wrote:
> > Hi  Juri,
> >
> > On Wed, 10 Oct 2018 at 14:23, Juri Lelli <juri.lelli@gmail.com> wrote:
> > >
> > > On 10/10/18 14:04, Vincent Guittot wrote:
> > >
> > > [...]
> > >
> > > > The problem was the same with RT, the cfs utilization was lower than
> > > > reality because RT steals soem cycle to CFS
> > > > So schedutil was selecting a lower frequency when cfs was running
> > > > whereas the CPU was fully used.
> > > > The same can happen with thermal:
> > > > cap the max freq because of thermal
> > > > the utilization with decrease.
> > > > remove the cap
> > > > the utilization is still low and you will select a low OPP because you
> > > > don't take into account cycle stolen by thermal like with RT
> > >
> > > What if we scale frequency component considering the capped temporary
> > > max?
> >
> > Do you mean using a kind of scale_thermal_capacity in accumulate_sum
> > when computing utilization ?
>
> Yeah, something like that I guess. So that we account for temporary
> "fake" 1024..

But the utilization will not be invariant anymore across the system
