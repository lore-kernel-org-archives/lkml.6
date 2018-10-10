Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EA9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2BAC2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BGn26J5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2BAC2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeJJT4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:56:43 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37773 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJT4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:56:42 -0400
Received: by mail-it1-f194.google.com with SMTP id e74-v6so7672377ita.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 05:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cF8e0940EhTdq/A/X0zHKvzVE/vZUBeRt2St8pXKHLA=;
        b=BGn26J5q3DdwtAkziyvsKv8pCwB5DbhcQDHTxD0RCJRKDoT7UOztg963tkZjrxZfFZ
         MKGmt6yy6bpVfM2//kR8BLATLahDFRxv2j33C0sFdv71OIBIk+NdLy1n468+aHkz8qYg
         XfnP2g+SLDp42xinbr5pRuCC484KAGXJzRHmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cF8e0940EhTdq/A/X0zHKvzVE/vZUBeRt2St8pXKHLA=;
        b=J/OGagsU5FmSKBp2ia+R7a/0vG1ALm71VNMYI50l6YEob9iDeyoTEWEntehJHeIZzT
         IR9pfxJmuw9PXPMPb2vj55uKWWBZNVnJ1ks0YpOQXXHtZcvJX4d/I7UhKQZr5BSRCDZ5
         Doi8DYBl8uxIbsc9fQVyESRoPmPy0gwOzJg7raeMOXh/bX4ASnBI1iVdSBS8D9Dp4n4u
         ejrc2pXSGtuYw+xoX0XfQcpm1r2hEtk0pYVYDCqaDEhnv2vVpXoHkKp+mUiAemutOJ/8
         530Fb5N0FFAYPzaC3krZ702GJVp3C/So2IoLymFjhPdkHwfoqwLc0Z/N1SkA9TV+hYcP
         MVGw==
X-Gm-Message-State: ABuFfog/yKpTAWAcJ7A7vkHGmfaR6MVFJYTPNoLmo0B+yYhfWPSf/TD1
        /pOsP/NLzRn1Uqae859J6rrlcIgtEqvNJlW1P26plA==
X-Google-Smtp-Source: ACcGV63/qqDPxcGhzU2iGbup4IGkAUVMgAB7ZJ98+Zro6V8aUUJYnF+2JKlkLuaIhOWuiKQir/tJz20T1FVqL8MTfBw=
X-Received: by 2002:a02:844c:: with SMTP id l12-v6mr26657212jah.137.1539174883436;
 Wed, 10 Oct 2018 05:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com> <20181010082933.4ful4dzk7rkijcwu@queper01-lin>
 <CAKfTPtA1sgf77xLUPr74iEEb+W8PGCMCkgu+Kw8xM_Jxx7_hjQ@mail.gmail.com>
 <20181010095459.orw2gse75klpwosx@queper01-lin> <CAKfTPtA+FWrMnerQhrNQhvmvVSK_S86da=8shpdET-807zZgVg@mail.gmail.com>
 <20181010103623.ttjexasymdpi66lu@queper01-lin> <CAKfTPtBM24F99OhtjWU-cx4DdFFpvUMMDYuqZH_vaJg9HEpPTw@mail.gmail.com>
 <20181010122348.GL9130@localhost.localdomain>
In-Reply-To: <20181010122348.GL9130@localhost.localdomain>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 10 Oct 2018 14:34:32 +0200
Message-ID: <CAKfTPtCVryjWWT_M1zEZfJUjGkt2JPUiBK6vt0YiJTK4qVoqbA@mail.gmail.com>
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

Hi  Juri,

On Wed, 10 Oct 2018 at 14:23, Juri Lelli <juri.lelli@gmail.com> wrote:
>
> On 10/10/18 14:04, Vincent Guittot wrote:
>
> [...]
>
> > The problem was the same with RT, the cfs utilization was lower than
> > reality because RT steals soem cycle to CFS
> > So schedutil was selecting a lower frequency when cfs was running
> > whereas the CPU was fully used.
> > The same can happen with thermal:
> > cap the max freq because of thermal
> > the utilization with decrease.
> > remove the cap
> > the utilization is still low and you will select a low OPP because you
> > don't take into account cycle stolen by thermal like with RT
>
> What if we scale frequency component considering the capped temporary
> max?

Do you mean using a kind of scale_thermal_capacity in accumulate_sum
when computing utilization ?
