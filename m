Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00845C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73EB21720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QF1KVOGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbeLTPmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:42:10 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44636 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731661AbeLTPmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:42:10 -0500
Received: by mail-vk1-f195.google.com with SMTP id h128so467630vkg.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 07:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DQRrUWaCRcky+rMmXJm4LzdTZV0tSdXB2y0mUMPH6Co=;
        b=QF1KVOGwZZrPj7VsRMmRp8gZL4LjIpdRComBLoRvIYK1lTmZkCKJPQhBKVD9IOq9sK
         H2cAcpmgy5ukZ1tpZRhF4NKP89dpP5dSoGHLObkJLxpvHNBCjdkQoAvngCqfsZhHDd3K
         Rb96nSoiToTMPEfBvYY3qfqm0DPpnSI8xRE7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DQRrUWaCRcky+rMmXJm4LzdTZV0tSdXB2y0mUMPH6Co=;
        b=Q1kmST45ePv6z+82OtYaShNrziA/IV09mwWV3kxjIoAMhqJzwjs1rmbsUSIa/8tG1B
         R8VNdpiwTSwAI8hvBKXfRusVnfwDwENisyuBk1qsYjhMykYy7RueNLDWsLaLOS/DVH7+
         AePwnsKEy05jJ2rVX52x+qN+wNqyQUiChL20bVDakScW70nqPB6GDGz8eM5HNmm4yrh3
         6BBiE9y9i3QvcbF65EvwgCYYiJQH0JVs77e5oFKAO6zQTx9Ey3U5WiFKT/+FgFNVIVLW
         GVZYfcpa7qKRJa9rrHH/RwpWjzLcuqX4hph566InfSAOmxkQbikhRB5mNUGFMXWSuQWj
         8Wzg==
X-Gm-Message-State: AA+aEWaZxtLOqD4VFvO149eSGjOk1cxfLCFUFMuqaRPhWEseSw/8w1Cn
        qSVT10JQfbMWi/fhX+dH4MeTR3z+mkSE5OPVDY2exg==
X-Google-Smtp-Source: AFSGD/VG+v6LFSlb6/GsgO01KqCnG7CCaHllP8FIKk0+ekvO079m5l2VJzCrq1ZsScdFqzo347H0RHG7CvtUUNaQESs=
X-Received: by 2002:a1f:9042:: with SMTP id s63mr11399093vkd.17.1545320527573;
 Thu, 20 Dec 2018 07:42:07 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-17-ulf.hansson@linaro.org> <20e1c04b-870f-3213-835d-28724ef4f530@linaro.org>
In-Reply-To: <20e1c04b-870f-3213-835d-28724ef4f530@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 20 Dec 2018 16:41:31 +0100
Message-ID: <CAPDyKFqwB0X6DwamGqYgYKsGRcZRzStT=o_AL2wGExuOkQ2rgw@mail.gmail.com>
Subject: Re: [PATCH v10 16/27] drivers: firmware: psci: Prepare to use OS
 initiated suspend mode
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2018 at 15:09, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 29/11/2018 18:46, Ulf Hansson wrote:
> > To enable the OS initiated mode, the CPU topology needs to be described
> > using the hierarchical model in DT. When used, the idle state bits for the
> > CPU are created by ORing the bits for PM domain's idle state.
> >
> > Let's prepare the PSCI driver to deal with this, via introducing a per CPU
> > variable called domain_state and by adding internal helpers to read/write
> > the value of the variable.
>
> What are the domain states ? What values can they have ?

The existing psci_power_state, also defined as a per cpu variable,
contains fixed values reflecting the corresponding
arm,psci-suspend-param for the idle state in question.

This isn't sufficient, when using the hierarchical CPU topology in DT
and when OSI mode is supported, because of the way we vote with the
PSCI CPU suspend parameter. Parts of this parameter shall inform about
what state to allow for the cluster, while other parts tells the state
for the CPU.

The new "domain states" per CPU variable, gets dynamically changed
when actively used by following patches that implements the PSCI PM
domain support. Depending on what state the PM domain picks, the genpd
->power_off() callback sets a new "domain states" value, reflecting
the state for the cluster.

Does it makes sense? If you like, I can try to update the changelog to
clarify this?

>
> > Cc: Lina Iyer <ilina@codeaurora.org>
> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v10:
> >       - Use __this_cpu_read|write() rather than this_cpu_read|write().
> >
> > ---
> >  drivers/firmware/psci/psci.c | 26 ++++++++++++++++++++++----
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > index 4f0cbc95e41b..8dbcdecc2ae4 100644
> > --- a/drivers/firmware/psci/psci.c
> > +++ b/drivers/firmware/psci/psci.c
> > @@ -87,8 +87,19 @@ static u32 psci_function_id[PSCI_FN_MAX];
> >                               (PSCI_1_0_EXT_POWER_STATE_ID_MASK | \
> >                               PSCI_1_0_EXT_POWER_STATE_TYPE_MASK)
> >
> > +static DEFINE_PER_CPU(u32, domain_state);
> >  static u32 psci_cpu_suspend_feature;
> >
> > +static inline u32 psci_get_domain_state(void)
> > +{
> > +     return __this_cpu_read(domain_state);
> > +}
> > +
> > +static inline void psci_set_domain_state(u32 state)
> > +{
> > +     __this_cpu_write(domain_state, state);
> > +}
> > +
> >  static inline bool psci_has_ext_power_state(void)
> >  {
> >       return psci_cpu_suspend_feature &
> > @@ -187,6 +198,8 @@ static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
> >
> >       fn = psci_function_id[PSCI_FN_CPU_ON];
> >       err = invoke_psci_fn(fn, cpuid, entry_point, 0);
> > +     /* Clear the domain state to start fresh. */
> > +     psci_set_domain_state(0);
> >       return psci_to_linux_errno(err);
>
> I think this change is ambiguous:
>
>  - if it is a change of the state because of the cpu_on, then I was
> expecting a similar change in cpu_off and the change only if
> invoke_psci_fn() succeeds.

You are right. This rather belongs to patch 24, as its intent is to
deal with CPU hotplug.

>
>  - if it is a change to take opportunity of the code path to initialize
> the domain state, I suggest to remove it from there and make it very
> explicit with static DEFINE_PER_CPU(u32, domain_state) = { 0 };

We shouldn't need to explicitly set static variables to zero, as that
should be managed by the compiler.

Let me simply remove the call to  psci_set_domain_state(0) and instead
consider it for patch 24.

[...]

Thanks for reviewing!

Kind regards
Uffe
