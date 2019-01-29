Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250D7C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12A82087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548800545;
	bh=duB/OEPVnAOweVIX/fmi4WSu5Y1wsCapFzlboDlEZm4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AhdnsvHHHCZ2841YTD0CtvJTE6sCXBQAzZUmL52GL0pUgIKx7kbMLQYPSynHbhAGO
	 V6ElBSaiT+dC5LLYSK7xegvWxkEhyScPTwpI5KRGc1hrMZFEMVtcRNQFPH+9ZLr1Yh
	 g18i8dFKHxsKkB3yRZP9WSgPq4n8SbGsIeIimbco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfA2WWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:22:23 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39486 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfA2WWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 17:22:23 -0500
Received: by mail-ot1-f65.google.com with SMTP id n8so19397582otl.6;
        Tue, 29 Jan 2019 14:22:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ro/e6q+5fmr4HNR3iePe/0fUq89Iub3wrVXm/j6/h6Q=;
        b=JZERG/NfAsybeV1jP0+ZVU7x6zFGLXhFFH5fJrj602oTKMEqTCGc1gJUBG00PQEHrk
         qvcqbdOQ4GaOxm2mibQoX7CKO3xSL/AX6qcv95rxMZQRYj9OTrflH9vCYd5oAawa1jbh
         AS5C/RL7VT/09d6bHF3wuWL78WJxLH6ChK+q1jNF5C/JFbcbB9vTT5kWvSaZSIw4bEOA
         Zx5lD5s8cfGu6R9jcvmDJ9FJnIdPyM8j3a8PnRWTRYq65CvoS1WfgTml2MwOpVMvEXSj
         dZnjjpE1AfEZC9844ztAP3r+mXRO3yM2Fn4v6JqVoMov57zu2VatJTIKoKG43197Uty+
         pKXw==
X-Gm-Message-State: AJcUukdjpvwEqDYpmg+gVpJqxArYA3Wf2yPPOPWtW8K1zvodzWuu6RAl
        xmoVxSJalIwEckEMCrHdgWXKTOOu0Vn85MfebKE=
X-Google-Smtp-Source: ALg8bN5xcxTGHWqbJR/2yneWxu1+gy/wE7MTDj8IOAdmFLO+FBkSUJtjcIm5+/xwNdMvk8sDL78oOKXpR8guIpjkoTI=
X-Received: by 2002:a9d:2062:: with SMTP id n89mr19853990ota.244.1548800541861;
 Tue, 29 Jan 2019 14:22:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548737236.git.amit.kucheria@linaro.org>
 <6077cb33d7e078bb0e85776bad99fdb476f16d0c.1548737236.git.amit.kucheria@linaro.org>
 <20190129053618.laa6nscfvlmhhkb5@vireshk-i7> <CAP245DVk+Bbkqh5xzNnL+RG3zZDJJR+ZLJqmEhSWjjSK1FH8rw@mail.gmail.com>
 <CAJZ5v0hs2Af9DJoxiyMmFt7R5nYbGOCqgG5cvPOL8yrQXN-ZUw@mail.gmail.com> <CAHLCerN-+57hH8r5e0ZyNY6+w102tHHhWORXk2admf1EU_=jjA@mail.gmail.com>
In-Reply-To: <CAHLCerN-+57hH8r5e0ZyNY6+w102tHHhWORXk2admf1EU_=jjA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Jan 2019 23:22:11 +0100
Message-ID: <CAJZ5v0iwq15mwoa-LBN07fgNNurtBGodG6urgfnvMbGWj8vyAw@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 9:20 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> On Tue, Jan 29, 2019 at 2:43 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Jan 29, 2019 at 6:46 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> > >
> > > On Tue, Jan 29, 2019 at 11:06 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > On 29-01-19, 10:25, Amit Kucheria wrote:
> > > > > All cpufreq drivers do similar things to register as a cooling device.
> > > > > Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> > > > > to register the cooling device on their behalf. This allows us to get
> > > > > rid of duplicated code in the drivers.
> > > > >
> > > > > In order to allow this, we add a struct thermal_cooling_device pointer
> > > > > to struct cpufreq_policy so that drivers don't need to store it in a
> > > > > private data structure.
> > > > >
> > > > > Suggested-by: Stephen Boyd <swboyd@chromium.org>
> > > > > Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > > > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > > > > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> > > > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > > ---
> > > > >  drivers/cpufreq/cpufreq.c | 13 +++++++++++++
> > > > >  include/linux/cpufreq.h   |  9 +++++++++
> > > > >  2 files changed, 22 insertions(+)
> > > > >
> > > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > > index e35a886e00bc..0f9b50d3ee91 100644
> > > > > --- a/drivers/cpufreq/cpufreq.c
> > > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > > @@ -19,6 +19,7 @@
> > > > >
> > > > >  #include <linux/cpu.h>
> > > > >  #include <linux/cpufreq.h>
> > > > > +#include <linux/cpu_cooling.h>
> > > > >  #include <linux/delay.h>
> > > > >  #include <linux/device.h>
> > > > >  #include <linux/init.h>
> > > > > @@ -1318,6 +1319,11 @@ static int cpufreq_online(unsigned int cpu)
> > > > >       if (cpufreq_driver->ready)
> > > > >               cpufreq_driver->ready(policy);
> > > > >
> > > > > +#if IS_ENABLED(CONFIG_CPU_THERMAL)
> > > > > +     if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
> > > > > +             policy->cdev = of_cpufreq_cooling_register(policy);
> > > > > +#endif
> > > >
> > > > I am not sure if Rafael wanted it this way but maybe something like this:
> > > >
> > > >         if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
> > > >             cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV))
> > > >                 policy->cdev = of_cpufreq_cooling_register(policy);
> > > >
> > > > We never wanted ifdef hackery to be in there :)
> > >
> > > OK, that makes more sense. Should I just send out a fixup patch or the
> > > entire series?
> >
> > Just a fixup patch, please.
>
> Please find attached a fixup patch suitable to add to the top of the
> series and use git rebase --autosquash on.

This isn't Patchwork-friendly, so can you send the complete patch
instead, please?
