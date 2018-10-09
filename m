Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C6BC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEF820C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT4pinsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEF820C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeJIXYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:24:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35666 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIXYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:24:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id o14-v6so2095070ljj.2;
        Tue, 09 Oct 2018 09:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bQTlw73l9cuRf/gwTXV0f0JT0pvjZXObC6lg1TPZ8no=;
        b=OT4pinsK2u5mutPgFE2idrbGg41GvvHlExTux5ohH7mA8vJn2X9CVM9GVvQs3eOxh3
         779Uh+MjB/55nfvQrtvvCfUtPFSLv4hoE2l/zhiywh5c5XsbQwe+ZXA1TghHliM70GvG
         Egp9DwX/DG1SNC7SlwPMhSss2KR90WTKrra5hm3BxKqKXwwgqnQA9wVJMf6BdqdCjdHX
         9iajWZGOHFOn7X3loSGx2MNtTwQSbsDkkOwwHrY60dejJIkNcNUmvAzwfxKsUxVjed0T
         +7pdyq8hm6g2cEGcppi7Ge6qKoJjZUdC6Y87KWiH7YLBZo0aWc76WaY3wFoWhPx9XFDy
         g60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQTlw73l9cuRf/gwTXV0f0JT0pvjZXObC6lg1TPZ8no=;
        b=C22gTs1FdULZqsAXPMxGx4UWeQhTRZ758PguNkdzZwhVJ+xaUp1njHJUHEiV96bnuL
         fl3mFTjCtJXVIot7UyEopNSXyUyVqE6MQjsngPWexuquPnMbOnUy8woDyIB4/GbITr5Y
         8LVz4v/V9PlURZo1rAL0bznreIjeIIycOSj8hhWgCVm98csPzI6bFDvM65W8LB2IlAYM
         P25Mz7/OV+tF40X1RrQrDnyY04HQZWtW47Us2+nI1dhUoRmThfhqT7axtgsdd6q1X/QU
         SGxws3pgMg3dwo9k5RxeT7RwYPuvk1s+WlfGwCA2EtJATOcUg8d1HnjosPjqT0jr/mac
         t+WA==
X-Gm-Message-State: ABuFfoiOl1U8dUODGkO5Dx9rVs9QMB5J/P01i8IUyftFO25gSveHfR2/
        8twmTUF5RWtZ3hRPcgNjtlyvf++L6f00d6AZveo=
X-Google-Smtp-Source: ACcGV63J1gsgUBOIlsOuZJ9Pj+ptchghLTV0k/pUmW4/UYXyosjrlemVTi8WomjYD0LRKbY22MM686sVd1xXYB+8D/E=
X-Received: by 2002:a2e:2205:: with SMTP id i5-v6mr15867224lji.15.1539101205326;
 Tue, 09 Oct 2018 09:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20181008150901.19667-1-waldemar.rymarkiewicz@gmail.com> <CAJZ5v0j0GLHgKS9+mafm3eoFMuNEo6VPa3LhRthg+H5OKHhFqA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j0GLHgKS9+mafm3eoFMuNEo6VPa3LhRthg+H5OKHhFqA@mail.gmail.com>
From:   Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Date:   Tue, 9 Oct 2018 18:06:08 +0200
Message-ID: <CAHKzcEMx2V-uvkM7_gUXiL1jEiYDwNn3KoGHqneqXAwmUQJ+0w@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: conservative: Fix requested_freq handling
To:     rafael@kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Bartholomae, Thomas" <t.bartholomae@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2018 at 09:47, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Oct 8, 2018 at 5:11 PM Waldemar Rymarkiewicz
> <waldemar.rymarkiewicz@gmail.com> wrote:
> >
> > From: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
> >
> > The governor updates dbs_info->requested_freq only after increasing or
> > decreasing frequency. There is, however, an use case when this is not
> > sufficient.
> >
> > Imagine, external module constraining cpufreq policy in a way that policy->max
>
> Is the "external module" here a utility or a demon running in user space?

No, this is a driver that communicates with a firmware and makes sure
CPU is running at the highest rate in specific time.
It uses verify_within_limits  and update_policy, a standard way to
constraint cpufreq policy limits.

> > @@ -136,10 +135,10 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
> >                         requested_freq = policy->min;
> >
> >                 __cpufreq_driver_target(policy, requested_freq, CPUFREQ_RELATION_L);
> > -               dbs_info->requested_freq = requested_freq;
> >         }
> >
> >   out:
> > +       dbs_info->requested_freq = requested_freq;
>
> This will have a side effect when requested_freq is updated before the
> thresholds checks due to the policy_dbs->idle_periods < UINT_MAX
> check.
>
> Shouldn't that be avoided?

I would say we should.

A hardware design I use is running 4.9 kernel where the check does not
exist yet, so there is not a problem.
Anyway, the check policy_dbs->idle_periods < UINT_MAX  can change
requested_freq  either to requested_freq = policy->min or
requested_freq -= freq_steps;. The first case will not change anything
for us as policy->max=min=cur. The second, however, will force to
update freq which is definitely not expected when limits are set to
min=max. Simply it will not go out  here:

if (load < cs_tuners->down_threshold) {
      if (requested_freq == policy->min)
           goto out;   <---
...
}

Am I right here? If so, shouldn't we check explicitly

/*
* If requested_freq is out of range, it is likely that the limits
* changed in the meantime, so fall back to current frequency in that
* case.
*/
if (requested_freq > policy->max || requested_freq < policy->min)
       requested_freq = policy->cur;

+/*
+* If the the new limits min,max are equal, there is no point to process further
+*/
+
+if (requested_freq == policy->max  &&  requested_freq == policy->min)
+     goto out;

Thanks,
/Waldek
