Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F76C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CB5208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CB5208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeJRQOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:14:30 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38396 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbeJRQOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:14:30 -0400
Received: by mail-ot1-f67.google.com with SMTP id l1so28906339otj.5;
        Thu, 18 Oct 2018 01:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rZKFmPC9IalVIT7m9226OSd7RJ+swyggK4K3FEGQKRk=;
        b=CNzplIOiFw4vQ48rkOIdjm2y5kqog21KiKbWpineJVmzu5ZUkp2g7TqfRk/i22jGVz
         YiwhqllNS7FLBlScVcuOgqqR8Seo3Ewixa9fDKtfRIp8JkGP1yfg/YglIR2NMA/720Dt
         RPbpxH79IDHASSY6KTtFUfV6Ufn3NfiyrUzt0RYtW8eRIe3i61QRYKfkRtKYziXiOpJF
         T5/13K3Qu10CNJWiKTzDqnJp88m4zMIxinIg7zBRW3eOJagoXguIoRVfdFCYYKF92O4z
         c6HUf0sqIvRswfpoNQHj6Pvnh0VzdTSTskbQHFvi/KOcl03u5vqLdQKzN1YmtvZLkt+D
         mTpw==
X-Gm-Message-State: ABuFfoh13lznPpKWmkyWliRGzxMHgUxu4A7MtrNWkbdX+ptDG5lQrak8
        heg8Bz1KCr6wl9313pu5tXcTgOksY3/lzNryRYQ=
X-Google-Smtp-Source: ACcGV606A55A8+I9aYgtE9VNtPoAX2YTZ90Meop6BagPV1sdpusH6FMDCP8HBtnuwh+uQZUoEGpebhxUDlIStsNJ1Bs=
X-Received: by 2002:a9d:538c:: with SMTP id w12mr19648054otg.139.1539850479302;
 Thu, 18 Oct 2018 01:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com> <5BBE1E1F.3030308@linaro.org>
 <20181016073305.GA64994@gmail.com> <5BC76181.90105@linaro.org>
 <20181018064849.GA42813@gmail.com> <CAJZ5v0g=CnAv6HC6H68ub0KbO8Z8Fx4BtW=mjfEshNsnNX407w@mail.gmail.com>
 <20181018075033.GA58819@gmail.com>
In-Reply-To: <20181018075033.GA58819@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Oct 2018 10:14:28 +0200
Message-ID: <CAJZ5v0iALqLw+Y_tKw86dh2oxnmvALhoVJxEcWWA+x1jU3GjdA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Quentin Perret <quentin.perret@arm.com>,
        ionela.voinescu@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 9:50 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> > > The only long term maintainable solution is to move all high level
> > > cpufreq logic and policy handling code into kernel/sched/cpufreq*.c,
> > > which has been done to a fair degree already in the past ~2 years - but
> > > it's unclear to me to what extent this is true for thermal throttling
> > > policy currently: there might be more governor surgery and code
> > > reshuffling required?
> >
> > It doesn't cover thermal management directly ATM.
> >
> > The EAS work kind of hopes to make a connection in there by adding a
> > common energy model to underlie both the performance scaling and
> > thermal management, but it doesn't change the thermal decision making
> > part AFAICS.
> >
> > So it is fair to say that additional governor surgery and code
> > reshuffling will be required IMO.
>
> BTW., when factoring out high level thermal management code it might make
> sense to increase the prominence of the cpufreq code within the scheduler
> and organize it a bit better, by introducing its own
> kernel/sched/cpufreq/ directory and renaming things the following way:
>
>   kernel/sched/cpufreq.c                => kernel/sched/cpufreq/core.c
>   kernel/sched/cpufreq_schedutil.c      => kernel/sched/cpufreq/metrics.c
>   kernel/sched/thermal.c                => kernel/sched/cpufreq/thermal.c
>
> ... or so?
>
> With no change to functionality, this is just a re-organization and
> expansion/preparation for the bright future. =B-)

No disagreement here. :-)

Cheers,
Rafael
