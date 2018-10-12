Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CE9C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00992075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UNKl1fLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00992075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbeJLXT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:19:59 -0400
Received: from mail-it1-f175.google.com ([209.85.166.175]:54186 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbeJLXT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:19:59 -0400
Received: by mail-it1-f175.google.com with SMTP id q70-v6so19400382itb.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hY8ZOWDGNqj6KCXufqqzVSUm88ZOQNNpDSkg7zN+Z3Y=;
        b=UNKl1fLtRDHTHQT05UruYoX0lIdUNZgypRIrVm52s8uKDqHU3wvl9eD/hNscGVVCty
         r22NH9nxKJZT2Ro57vDwAEugZD5UxijcAomPY91PrVVl3R5XqgJwZtrf0/WNnmg9nUgM
         N/Fjhb271tWi2a4cDHOkxtLPg3L4e6RRvG1GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hY8ZOWDGNqj6KCXufqqzVSUm88ZOQNNpDSkg7zN+Z3Y=;
        b=uJFULq8zTqE2LtNA0/wB3GVmMMeElQF1igySTF5IJBPRo2EYvbbIsDlriTE8nXY3a2
         QsIMKEHDGVq/HE72aoaCt6YefI4z8yh1gz9cGU6EybsNEJxFlxXSQvFZGahpugTtapgd
         IIKqne8qGj/hpjV4r0J5fJz5UI3PoHpdG7MiTxsRMeQS/b3qqzFNb4c7GYv8fgQopiZk
         gh7X54d0fopW/QHzgk/xk8FbCrNRZD2FGXuxXfh9rGacqBbmVXSQbAazfNggxjppxvKQ
         1eFrxjoXm4Q824xZHX4y41WdhRrDwgf8gKapETiS/trWMLQSeKbhKHJk+fbDHwvRy2zd
         fcWg==
X-Gm-Message-State: ABuFfohD3cc24p3nDNXOQw1LJb2nCIhUTHJqXVc6Zg5t+RShxsiiSMMm
        e2yIPbaNq23U6jajBv4Pbe8sZjYLrIENWLXJ4hnyjQ==
X-Google-Smtp-Source: ACcGV62fU9yZcWnt8RRVbd7kw4bnVGVPWuAXvr6DsQqL473xSsbVhzY3A4bEX/c72vQl06HaoBL+krHkhsuD1YenA7Y=
X-Received: by 2002:a24:6b4d:: with SMTP id v74-v6mr4924522itc.26.1539359214104;
 Fri, 12 Oct 2018 08:46:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 08:46:13
 -0700 (PDT)
In-Reply-To: <20181012150429.GH3401@e107155-lin>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
 <20181011112013.GC32752@e107155-lin> <20181011160053.GA2371@codeaurora.org>
 <20181011161927.GC28583@e107155-lin> <20181011165822.GB2371@codeaurora.org>
 <20181011173733.GA26447@e107155-lin> <20181011210609.GD2371@codeaurora.org> <20181012150429.GH3401@e107155-lin>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 12 Oct 2018 17:46:13 +0200
Message-ID: <CAPDyKFpNuTMav__wTvuMbxU65QpiQPftH_OXkEwztcPAG9FbTw@mail.gmail.com>
Subject: Re: [PATCH RFC v1 7/8] drivers: qcom: cpu_pd: Handle cpu hotplug in
 the domain
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lina Iyer <ilina@codeaurora.org>
Cc:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 October 2018 at 17:04, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Thu, Oct 11, 2018 at 03:06:09PM -0600, Lina Iyer wrote:
>> On Thu, Oct 11 2018 at 11:37 -0600, Sudeep Holla wrote:
> [...]
>
>> >
>> > Is DDR managed by Linux ? I assumed it was handled by higher exception
>> > levels. Can you give examples of resources used by CPU in this context.
>> > When CPU can be powered on or woken up without Linux intervention, the
>> > same holds true for CPU power down or sleep states. I still see no reason
>> > other than the firmware has no support to talk to RPMH.
>> >
>> DDR, shared clocks, regulators etc. Imagine you are running something on
>> the screen and CPUs enter low power mode, while the CPUs were active,
>> there was a need for bunch of display resources, and things the app may
>> have requested resources, while the CPU powered down the requests may
>> not be needed the full extent as when the CPU was running, so they can
>> voted down to a lower state of in some cases turn off the resources
>> completely. What the driver voted for is dependent on the runtime state
>> and the usecase currently active. The 'sleep' state value is also
>> determined by the driver/framework.
>>
>
> Why does CPU going down says that another (screen - supposedly shared)
> resource needs to be relinquished ? Shouldn't display decide that on it's
> own ? I have no idea why screen/display is brought into this discussion.
> CPU can just say: hey I am going down and I don't need my resource.
> How can it say: hey I am going down and display or screen also doesn't
> need the resource. On a multi-cluster, how will the last CPU on one know
> that it needs to act on behalf of the shared resource instead of another
> cluster.

Apologize for sidetracking the discussion, just want to fold in a few comments.

This is becoming a complicated story. May I suggest we pick the GIC as
an example instead?

Let's assume the simple case, we have one cluster and when the cluster
becomes powered off, the GIC needs to be re-configured and wakeups
must be routed through some "always on" external logic.

The PSCI spec mentions nothing about how to manage this and not the
rest of the SoC topology for that matter. Hence if the GIC is managed
by Linux - then Linux also needs to take actions before cluster power
down and after cluster power up. So, if PSCI FW can't deal with GIC,
how would manage it?

>
> I think we are mixing the system sleep states with CPU idle here.
> If it's system sleeps states, the we need to deal it in some system ops
> when it's the last CPU in the system and not the cluster/power domain.

What is really a system sleep state? One could consider it just being
another idles state, having heaver residency targets and greater
enter/exit latency values, couldn't you?

In the end, there is no reason to keep things powered on, unless they
are being in used (or soon to be used), that is main point.

We are also working on S2I at Linaro. We strive towards being able to
show the same power numbers as for S2R, but then we need to get these
cluster-idle things right.

[...]

Have a nice weekend!

Kind regards
Uffe
