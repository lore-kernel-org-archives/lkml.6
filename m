Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D49C7112B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A616205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cbt9dIBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A616205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbeJORTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 13:19:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35201 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeJORTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 13:19:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id o14-v6so16879350ljj.2;
        Mon, 15 Oct 2018 02:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LIt39AmKbuYF9Xi9L0PcQxoFRc9uQgSZbtOQG0mHCmI=;
        b=Cbt9dIBFiC6QiTlzgRsmRXLPOIJD06FpCQ2GNmaMFDFP2LLnATXjraSJsI3jnjSJZM
         ZlfT4budsmA4oe98oqnXnGEa418thWqSRaNVG8xipt2aPLAOA1Hja0keFZjbUnM199MU
         KdZcRC95oqP0FFAoAwJ0Ui9VfkqLKK4X1CzVd5OC89VMBWIbx87TkO5Zkdj+yq+A+pQE
         9JS353K+xECDSYQ5gIAQkXtynl1IijPo3P3X3sBg0nypyLpB573SLCBUDgzGDbZW3Kqb
         CS6UpgabrVKg+VCUZLJMMrjYexOLoRTiwjb+YThL0MFkG4r5H3jijzgVfNIyh3NTLzT1
         md2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LIt39AmKbuYF9Xi9L0PcQxoFRc9uQgSZbtOQG0mHCmI=;
        b=G56AM9tkiFFPJJN48E+Y2BgsHVGtkuOX8HN75SaWjsMH0v1vOhNUofapq0LW9hsU3l
         EhXwbsusvQI4QYgowQ29l00oyVtu4R9LOAci02aT7m1CCBAA/kMz606Swmsf0yFokYmR
         xA0WXbfwseg8i2u2igv54p53KWFPwlzh3HYJa7TnEGY1a2S89DMHhyG4RMa/c1LRrsRz
         tQZHsbJD6jxXnzvlVEk2CHcqaG3FZ1Lu+yjjdu+8S1Ze/9jrnMLfC+3XKM50zqrvOxQI
         YenmO0PZP6vT+CJdGrpn5eSeEXKF6mwDLJyNRra6Pb3Ew3En8XlHPGseJ6/RiZqdB4Ib
         iH0Q==
X-Gm-Message-State: ABuFfogmpIeZ6dT5QdrHRMkYGncoOoKz4kI49xuaRt7zh7NhrSTj1Q7/
        HS018Jz0paNavXRvFLAzV33lBCIPBnWC54HCphs=
X-Google-Smtp-Source: ACcGV60E+TMekVyM3iLrh8hyLFJgbB7lIkJfoaMWNCGlhRHf2tyG3ktiEsaAwDslV5/l1fszNOl+assRR5BqhsqTWno=
X-Received: by 2002:a2e:6353:: with SMTP id x80-v6mr9933954ljb.11.1539596110390;
 Mon, 15 Oct 2018 02:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181008150901.19667-1-waldemar.rymarkiewicz@gmail.com>
 <CAJZ5v0j0GLHgKS9+mafm3eoFMuNEo6VPa3LhRthg+H5OKHhFqA@mail.gmail.com>
 <CAHKzcEMx2V-uvkM7_gUXiL1jEiYDwNn3KoGHqneqXAwmUQJ+0w@mail.gmail.com> <2671493.AgiGORq3CZ@aspire.rjw.lan>
In-Reply-To: <2671493.AgiGORq3CZ@aspire.rjw.lan>
From:   Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Date:   Mon, 15 Oct 2018 11:34:33 +0200
Message-ID: <CAHKzcEPuD7nnmvBjnUNn=wb-5LfN1nHoTYBekAiBFG8Je+oPwA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: conservative: Fix requested_freq handling
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Bartholomae, Thomas" <t.bartholomae@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2018 at 23:10, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, October 9, 2018 6:06:08 PM CEST Waldemar Rymarkiewicz wrote:
> > On Tue, 9 Oct 2018 at 09:47, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Mon, Oct 8, 2018 at 5:11 PM Waldemar Rymarkiewicz
> > > <waldemar.rymarkiewicz@gmail.com> wrote:
> > > >
> > > > From: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
> > > >
> > > > The governor updates dbs_info->requested_freq only after increasing or
> > > > decreasing frequency. There is, however, an use case when this is not
> > > > sufficient.
> > > >
> > > > Imagine, external module constraining cpufreq policy in a way that policy->max
> > >
> > > Is the "external module" here a utility or a demon running in user space?
> >
> > No, this is a driver that communicates with a firmware and makes sure
> > CPU is running at the highest rate in specific time.
> > It uses verify_within_limits  and update_policy, a standard way to
> > constraint cpufreq policy limits.
> >
> > > > @@ -136,10 +135,10 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
> > > >                         requested_freq = policy->min;
> > > >
> > > >                 __cpufreq_driver_target(policy, requested_freq, CPUFREQ_RELATION_L);
> > > > -               dbs_info->requested_freq = requested_freq;
> > > >         }
> > > >
> > > >   out:
> > > > +       dbs_info->requested_freq = requested_freq;
> > >
> > > This will have a side effect when requested_freq is updated before the
> > > thresholds checks due to the policy_dbs->idle_periods < UINT_MAX
> > > check.
> > >
> > > Shouldn't that be avoided?
> >
> > I would say we should.
> >
> > A hardware design I use is running 4.9 kernel where the check does not
> > exist yet, so there is not a problem.
> > Anyway, the check policy_dbs->idle_periods < UINT_MAX  can change
> > requested_freq  either to requested_freq = policy->min or
> > requested_freq -= freq_steps;. The first case will not change anything
> > for us as policy->max=min=cur. The second, however, will force to
> > update freq which is definitely not expected when limits are set to
> > min=max. Simply it will not go out  here:
> >
> > if (load < cs_tuners->down_threshold) {
> >       if (requested_freq == policy->min)
> >            goto out;   <---
> > ...
> > }
> >
> > Am I right here? If so, shouldn't we check explicitly
> >
> > /*
> > * If requested_freq is out of range, it is likely that the limits
> > * changed in the meantime, so fall back to current frequency in that
> > * case.
> > */
> > if (requested_freq > policy->max || requested_freq < policy->min)
> >        requested_freq = policy->cur;
> >
> > +/*
> > +* If the the new limits min,max are equal, there is no point to process further
> > +*/
> > +
> > +if (requested_freq == policy->max  &&  requested_freq == policy->min)
> > +     goto out;
>
> If my understanding of the problem is correct, it would be better to simply
> update dbs_info->requested_freq along with requested_freq when that is found
> to be out of range.  IOW, something like the appended patch (untested).

Yes, this will solve the original problem as well.

I think there could also be a  problem with policy_dbs->idle_periods <
UINT_MAX  check. It it's true it  can modify requested_freq (
requested_freq -= freq_steps) and further it can result in a change of
the freq,  requested_freq == policy->max is not anymore true. I would
expect governor not to change freq (requested_freq) when
policy->max=policy->min=policy->cur.

Thanks,
/Waldek
