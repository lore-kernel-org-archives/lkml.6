Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141CCC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D4620868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D6Cju/XP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D4620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbeJLQzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:55:22 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52148 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbeJLQzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:55:21 -0400
Received: by mail-it1-f196.google.com with SMTP id 74-v6so17771900itw.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 02:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=L4bz17i2/iilgYIT15dkUzlQNdkQ6txC1AG67nSk9Wg=;
        b=D6Cju/XPCKRyEjKP02BkQyU+BNaKy5O+jnaAl6ANKegCORct6PsU8gBQFlBqCWwavW
         gVEYadgxwTIRm/bXOUaaLjHhg4X2PkRhdJ6w4CE1W0T3a/O1I2I7jBoEM3IFqAZpPB+Y
         8MRIYJ1Xg9PwzIx50DZxjM3Dr6VmHuWMxHju4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=L4bz17i2/iilgYIT15dkUzlQNdkQ6txC1AG67nSk9Wg=;
        b=Hf6A3w958T1T1PngFb8GBgZ0tBUw5TUc0/rrOCQUVxQSMEVdj5kk1pTpuGEJM6aDnG
         Hy9Ah6yKwWjKVm3ns/s/VHLCN/bZ7+1c9Bxmbe7r7F7tYaBDhH5HKnKWUJFb4bDn49Sj
         pz5dydMdNJHR37V0BpiESqs9dzZ0a0GfW6dDTp7zjaSA6M6qbxFwl76cz6nfHQJSs0eK
         x4shf1jw0uYlSjU7mX/bHmDZmCsC13KaNXMk2mAsNZc/znRDTIhJpocyZCeA9tnGObuO
         8rYuoFAp5eHmRSkw1HYcvqSfbxXVoYI/RPbWxia32WDZC7e8CRbJSd5bKKmASBt3+lA+
         Ol5g==
X-Gm-Message-State: ABuFfogHbJFdGQ6ssTOmH2l86oBxuGnQQUxsG953YBVwcKIaWyEIwr89
        vm4t8OAFH1L+FotaGm8RTCys+nxDVpvNnWvpvQFrPw==
X-Google-Smtp-Source: ACcGV61LfpEC7F3X90CRRFAsEjdhBu4U4O2yn++tkzneefsVXUxKgFX0N29wwyciasuYQNUhRg9J3IFpyDWSFA4o/jo=
X-Received: by 2002:a24:554c:: with SMTP id e73-v6mr4073888itb.157.1539336230618;
 Fri, 12 Oct 2018 02:23:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 02:23:10
 -0700 (PDT)
In-Reply-To: <20181011155956.GA28583@e107155-lin>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-5-git-send-email-rplsssn@codeaurora.org>
 <20181011111306.GB32752@e107155-lin> <CAPDyKFpXJ4MbqFOmDboBuR_1sziyuDi3qgKVvhokaAnQQ+kzjA@mail.gmail.com>
 <20181011155956.GA28583@e107155-lin>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 12 Oct 2018 11:23:10 +0200
Message-ID: <CAPDyKFoVv99HN080p_pV_Qbmrk9Jeq3kgYBrpTToP6jwuaUo5A@mail.gmail.com>
Subject: Re: [PATCH RFC v1 4/8] drivers: qcom: cpu_pd: add cpu power domain
 support using genpd
To:     Sudeep Holla <sudeep.holla@arm.com>
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
        Doug Anderson <dianders@chromium.org>, mka@chromium.org,
        Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 October 2018 at 17:59, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Thu, Oct 11, 2018 at 05:27:59PM +0200, Ulf Hansson wrote:
>> On 11 October 2018 at 13:13, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> > On Thu, Oct 11, 2018 at 02:50:51AM +0530, Raju P.L.S.S.S.N wrote:
>> >> RPMH based targets require that the sleep and wake state request votes
>> >> be sent during system low power mode entry. The votes help reduce the
>> >> power consumption when the AP is not using them. The votes sent by the
>> >> clients are cached in RPMH controller and needs to be flushed when the
>> >> last cpu enters low power mode. So add cpu power domain using Linux
>> >> generic power domain infrastructure to perform necessary tasks as part
>> >> of domain power down.
>> >>
>> >
>> > You seem to have either randomly chosen just 3 patches from Lina/Ulf's
>> > CPU genpd series or this series doesn't entirely depend on it ?
>>
>> Yep, it not easy to follow. But I do understand what you are trying to do here.
>>
>> >
>> > If latter, how does this work with PSCI CPU_SUSPEND operations ?
>> >
>> > And why this can be part of PSCI firmware implementation. Only PSCI
>> > firmware needs if RPMH votes need to be flushed or not. So, honestly
>> > I don't see the need for this in Linux.
>>
>> I do think there is clear need for this in Linux. More precisely,
>> since the PSCI firmware have knowledge solely about CPUs (and clusters
>> of CPUs), but not about other shared resources/devices present on the
>> SoC.
>>
>
> I disagree. Even with OSI, you indicate the cluster power off though
> PSCI CPU_SUSPEND call. If for any async wakeup reasons, firmware decides
> not to enter cluster OFF, then it may skip flushing RPMH vote. So doing
> it in PSCI is more correct and elegant to avoid such corner cases.
>
>> What Raju is trying to do here, is to manage those resources which
>> needs special treatment, before and after the CPU (likely cluster) is
>> going idle and returns from idle.
>>
>
> OK I get that, but why is Linux better than PSCI. I have my reasoning
> above.

I assume Lina, in the other thread from Raju, have provided you the
details why PSCI is not the place to do this and why Linux need to be
involved. In any case, let's continue that discussion in that thread
rather than here.

>
>> One question here though, what particular idle state is relevant for
>> the QCOM SoC to take last-man-actions for? I assume it's only cluster
>> idle states, and not about cpu idle states, no? Raju, can you please
>> clarify?
>>
>
> I assume so. I did see some comment or commit message to indicate the
> same.
>
>> Historically, the typical solution have been to use the
>> cpu_cluster_pm_enter|exit() notifiers. Those could potentially be
>> replaced by instead building a hierarchical topology, using
>> master/subdomain of genpd/"power-domains", along the lines of what
>> Raju is doing. However, I am not sure if that is the correct approach,
>> at least we need to make sure it models the HW in DT correctly.
>>
>
> Indeed. I am not sure how to represent both PSCI and this power domains ?
> Though I believe the latter is not required at all.

After my re-work of the PSCI power domain series, I believe the
power-domain that Raju is adding, should then be modeled as the master
power-domain of the PSCI *cluster* power domain. But, as stated, I am
not sure if it's the correct way to model the HW/topology. Maybe it
is.

The other option is to explore the cpu_cluster_pm_enter|exit(), which
today is the only viable solution in the kernel. In principle we then
need to call cpu_cluster_pm_enter() from the PSCI's cluster PM domain
genpd ->power_off() callback, and cpu_cluster_pm_exit() from the
->power_on() callback.

Or maybe we simply need something entirely new, like genpd PM
domain-on/off notifiers, which may scale better. It has even been
suggested on the mailing list, long time ago.

Kind regards
Uffe
