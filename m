Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D4DC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952B220868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XE8ZlfFa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XX5UCr9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952B220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbeJLXuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:50:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33754 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbeJLXuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:50:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 75B4860B0D; Fri, 12 Oct 2018 16:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539361015;
        bh=bxzVnVk5sPZB9LiKtjlSqU2fMat4on/95l3ds3Hy7XI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XE8ZlfFaVMEy+axgDiWa6ghN8xejHI+wlBZ17sd2d5fthmIPm0sUTssySCsHwqPv6
         Th9XnsXAPNqVW1x0ju3vyczM/aGrwNU5kJpVO/0CYpK49sscfN7Ev4OYl4A7GZrmqy
         78SOxsxLL3efMhHA74soVipKJ2ueZu+99plwusEg=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A4AA607DC;
        Fri, 12 Oct 2018 16:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539361014;
        bh=bxzVnVk5sPZB9LiKtjlSqU2fMat4on/95l3ds3Hy7XI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XX5UCr9VljjtzYzt51NQvOEng2QnJ7p9vXGLwB/qYIiipDZKIvBQzYmL+Ecipt1Fu
         xK8E+3d6GBVEk0UJfBFU2bXz5w1f9Rvz9jUuiqVGMzAANNlc1YP7USVMX8h0p/MiVu
         uRKvhoIaxW0h2rzGBbl0cVRpifcTZ6aVsQP1t+sk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A4AA607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Fri, 12 Oct 2018 10:16:53 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
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
Subject: Re: [PATCH RFC v1 7/8] drivers: qcom: cpu_pd: Handle cpu hotplug in
 the domain
Message-ID: <20181012161653.GH2371@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
 <20181011112013.GC32752@e107155-lin>
 <20181011160053.GA2371@codeaurora.org>
 <20181011161927.GC28583@e107155-lin>
 <20181011165822.GB2371@codeaurora.org>
 <20181011173733.GA26447@e107155-lin>
 <20181011210609.GD2371@codeaurora.org>
 <20181012150429.GH3401@e107155-lin>
 <CAPDyKFpNuTMav__wTvuMbxU65QpiQPftH_OXkEwztcPAG9FbTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPDyKFpNuTMav__wTvuMbxU65QpiQPftH_OXkEwztcPAG9FbTw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12 2018 at 09:46 -0600, Ulf Hansson wrote:
>On 12 October 2018 at 17:04, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> On Thu, Oct 11, 2018 at 03:06:09PM -0600, Lina Iyer wrote:
>>> On Thu, Oct 11 2018 at 11:37 -0600, Sudeep Holla wrote:
>> [...]
>>
>>> >
>>> > Is DDR managed by Linux ? I assumed it was handled by higher exception
>>> > levels. Can you give examples of resources used by CPU in this context.
>>> > When CPU can be powered on or woken up without Linux intervention, the
>>> > same holds true for CPU power down or sleep states. I still see no reason
>>> > other than the firmware has no support to talk to RPMH.
>>> >
>>> DDR, shared clocks, regulators etc. Imagine you are running something on
>>> the screen and CPUs enter low power mode, while the CPUs were active,
>>> there was a need for bunch of display resources, and things the app may
>>> have requested resources, while the CPU powered down the requests may
>>> not be needed the full extent as when the CPU was running, so they can
>>> voted down to a lower state of in some cases turn off the resources
>>> completely. What the driver voted for is dependent on the runtime state
>>> and the usecase currently active. The 'sleep' state value is also
>>> determined by the driver/framework.
>>>
>>
>> Why does CPU going down says that another (screen - supposedly shared)
>> resource needs to be relinquished ? Shouldn't display decide that on it's
>> own ? I have no idea why screen/display is brought into this discussion.
>> CPU can just say: hey I am going down and I don't need my resource.
>> How can it say: hey I am going down and display or screen also doesn't
>> need the resource. On a multi-cluster, how will the last CPU on one know
>> that it needs to act on behalf of the shared resource instead of another
>> cluster.
>
>Apologize for sidetracking the discussion, just want to fold in a few comments.
>
No, this is perfect to warp the whole thing around. Thanks Ulf.

>This is becoming a complicated story. May I suggest we pick the GIC as
>an example instead?
>
>Let's assume the simple case, we have one cluster and when the cluster
>becomes powered off, the GIC needs to be re-configured and wakeups
>must be routed through some "always on" external logic.
>
>The PSCI spec mentions nothing about how to manage this and not the
>rest of the SoC topology for that matter. Hence if the GIC is managed
>by Linux - then Linux also needs to take actions before cluster power
>down and after cluster power up. So, if PSCI FW can't deal with GIC,
>how would manage it?
>
>>
>> I think we are mixing the system sleep states with CPU idle here.
>> If it's system sleeps states, the we need to deal it in some system ops
>> when it's the last CPU in the system and not the cluster/power domain.
>
>What is really a system sleep state? One could consider it just being
>another idles state, having heaver residency targets and greater
>enter/exit latency values, couldn't you?
>
While I explained the driver's side of the story, for the CPUs, system
sleep is a deeper low power mode that ties in with OSI.

Thanks,
Lina

>In the end, there is no reason to keep things powered on, unless they
>are being in used (or soon to be used), that is main point.
>
>We are also working on S2I at Linaro. We strive towards being able to
>show the same power numbers as for S2R, but then we need to get these
>cluster-idle things right.
>
>[...]
>
>Have a nice weekend!
>
>Kind regards
>Uffe
