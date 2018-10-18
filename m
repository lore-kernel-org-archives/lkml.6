Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A6DC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3553621477
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3553621477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeJRSGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 14:06:46 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44586 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeJRSGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 14:06:46 -0400
Received: by mail-oi1-f195.google.com with SMTP id u74-v6so23511909oia.11;
        Thu, 18 Oct 2018 03:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WwzdNZx3gJx2M0KmABNdu06gDJeek7qBjHjTpkhBEu8=;
        b=JTorg/Nemp83H+nyXqIM0zaWGe0KLdfPHSPYe09cglZEobbynndNKU8dGoBEQCAz07
         ug6EN8aRg7rXnkjZa2fjyH3QuSiQ98zocUnPNOu9TkgP7rpHsVlNpGFimphgnmnXTnqw
         aSIbckwlyJqhIQfO5kLudS/G+fn2XtsPEPh9aeEU9boWg0ZWm0BBQ6bIU5VxaRtksmNm
         I42wDXDzlucq6XZIh6j7TrEEBoEpk+gJwNdNkVUr+dO42Su8fm3+bj2zm38n3mo7/mr7
         BWsXTBQMbfM2WuAhRu3JX378vXf0+iahKYY7Hk3SsDlGl0ONeTIfv5hEKgPU5jn4yxUk
         LGqw==
X-Gm-Message-State: ABuFfog8HY5+waFRT4WL9PKAPlmuYsVgabv8/pO6d4xqegz0UBG8ulYq
        ffiPha9aA+oMuxHoNlzg3uFw9w1tDluS1mt2EoiXCQ==
X-Google-Smtp-Source: ACcGV61VLY2S2kZuR40/INyVl7ZaPaDxJQJXtw1xgVg8IjcK+oQI3esH1nhJBtrqkZGLYDv3M32GfZ1c065npZRkPWs=
X-Received: by 2002:aca:6244:: with SMTP id w65-v6mr16271308oib.76.1539857189606;
 Thu, 18 Oct 2018 03:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0iALqLw+Y_tKw86dh2oxnmvALhoVJxEcWWA+x1jU3GjdA@mail.gmail.com>
 <1539855372-11472-1-git-send-email-daniel.lezcano@linaro.org>
 <CAJZ5v0ikpPk12PshjB7EwtGSz6kF5WJyKgDHB8cnXaEusy38UQ@mail.gmail.com> <8585bac0-c72c-edf4-2e93-c8740a3b1b6c@linaro.org>
In-Reply-To: <8585bac0-c72c-edf4-2e93-c8740a3b1b6c@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Oct 2018 12:06:18 +0200
Message-ID: <CAJZ5v0ia6jc80=xTkOSZofhmx80UXn2Kv-mPJ6B4JZ-Sc75kBA@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/cpufreq: Reorganize the cpufreq files
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Quentin Perret <quentin.perret@arm.com>,
        ionela.voinescu@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 11:54 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 18/10/2018 11:42, Rafael J. Wysocki wrote:
> > On Thu, Oct 18, 2018 at 11:36 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> It was suggested to set the scene for the PM components in the
> >> scheduler code organization in the recent discussion about making the
> >> scheduler aware of the capacity capping from the thermal framework.
> >>
> >> Move the cpufreq files into its own directory as suggested at:
> >>
> >> https://lkml.org/lkml/2018/10/18/353
> >> https://lkml.org/lkml/2018/10/18/408
> >
> > Fair enough, but do we need to do that right now?
>
> I'm not planning to do more code reorg than this patch right now. Up to
> you to decide if you are willing to take them.

The SPDX one certainly is applicable, but I'm not sure about the other one TBH.

Why don't you add the SPDX IDs to those files as they are for now?
