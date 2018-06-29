Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A57DC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 05:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1830B24457
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 05:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hDpVsGwq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1830B24457
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933109AbeF2Ftz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 01:49:55 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36842 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932853AbeF2Ftx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 01:49:53 -0400
Received: by mail-io0-f196.google.com with SMTP id k3-v6so7416118iog.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 22:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FvrxnMRdYQ+5DURYdeIeeuFPiKkoXnd/04nvNBxaN1E=;
        b=hDpVsGwqlGFpcb5yBjan7xCtvcBd1GfuYPww5dHpMsLbDbCtc1sTq1//KL/IJDjl14
         RPniCIlTD3U4Vf98JMTFAWkY2PYcp2Si/2r3dqeM+tAbYguOFTBo2whgCtkRf54sstqQ
         NCgptzo6smU/k6k74mX44DCspColjE3FaXF5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvrxnMRdYQ+5DURYdeIeeuFPiKkoXnd/04nvNBxaN1E=;
        b=ltlnFf6mCdTfxl46F+/vJWHIoBKYqfWduqzGsNmg+MjbASpeoFzbWiRX0Q3KJb/tiL
         DdwF4DgYsIPgFlXv2nW3itgTRk7lXwcclsvq7D6HQ5FamFser3470DxFrH54a5FwxMmC
         GJKP+Am8UzK+6MjKgCuV5JyifoySQ2qcxy+t6h6NurZv7Gdhd0mMbMwemneYxUp0cVPn
         UZmU6v3UA670jYFbACcxIQ9w549Z4nVLKMbUPb2L5UdO2yMi+7n7xkiLfWJlZaptY3ph
         O8BygQOByFdgYMs5hKfUEiF3xmGzQlMq6ttsZ+NxP8omDpJpb9l8LIFc2hjO5Jw8+ZDh
         Q1PA==
X-Gm-Message-State: APt69E1DvAOZaVAyVJxUs0ISnMvPUWCJ01Ib1z641hVIqFhldUBs7Mre
        APgn/Mmc8kkW+6C7Ay7YXRtTuGzLJCmSzzN4ONuVzg==
X-Google-Smtp-Source: AAOMgpezJCMCHEyWc09m4o/Ix2fKuesqya91bsrSAOu3VbBmTD6UVH6/CJd5tIJtLAK/9iRKi07E+ypwslYg1ObTHUU=
X-Received: by 2002:a6b:200c:: with SMTP id g12-v6mr11143269iog.18.1530251392899;
 Thu, 28 Jun 2018 22:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
 <1530200714-4504-12-git-send-email-vincent.guittot@linaro.org> <20180628155104.GA331@wotan.suse.de>
In-Reply-To: <20180628155104.GA331@wotan.suse.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 29 Jun 2018 07:49:41 +0200
Message-ID: <CAKfTPtD-SMgG0Z60GEZh_hSeULM=kY74O4D3A0-3RwcubFt6wg@mail.gmail.com>
Subject: Re: [PATCH 11/11] proc/sched: remove unused sched_time_avg_ms
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2018 at 21:03, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
>
> On Thu, Jun 28, 2018 at 05:45:14PM +0200, Vincent Guittot wrote:
> > /proc/sys/kernel/sched_time_avg_ms entry is not used anywhere.
> > Remove it
> >
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Reviewed-by: Luis R. Rodriguez <mcgrof@kernel.org>

Thanks

Vincent

>
>   Luis
