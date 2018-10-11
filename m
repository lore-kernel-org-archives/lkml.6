Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FD6C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FEB2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="bAR6ZyXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FEB2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeJLBbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 21:31:39 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39013 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbeJLBbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 21:31:39 -0400
Received: by mail-oi1-f194.google.com with SMTP id y81-v6so7796420oia.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 11:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MLw2Qqw10+kZEYNtT4nrNXzblopNaVgaK5XKcCnlg3c=;
        b=bAR6ZyXdUZxw7LR13MyxmwLET1uYLql3XLEc9DX/+V/Br3lS59ucpPBr5usGs9uQ9k
         ZnhrSTegn03CptX1S4BjzBEBv+dZw/pSDD7ZMRvrP6J9j3Dy7UqwDzkCojsc5EPDa33S
         ig+QVtIygCfLTWYBbSitQHVikIjthxWFdN0vm7tQLmFeVZkG5LiwF+OzDkC6odsnNWDc
         3JYerJBIeMDSjDln4wbQ13mfJOeNrU2KPc/8KvqrRW7kxNwbsIhRNhZ4GwMHfwTP8mrf
         huiWWeHGgQGSv0se3owFv19EgbZGCLTvhdB/XMnKRkaOSFCkOBo1gp9UID5KSsvL09uy
         f7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MLw2Qqw10+kZEYNtT4nrNXzblopNaVgaK5XKcCnlg3c=;
        b=VUNcGft2gjChGeQHWPMoQTuuvPMDVpQ/lcGe9vwrMRPHHdAfdK+qJAXrd+WYAi4s1Q
         le+pf5QPy5frWMH2Hd8ETr4V5AoVe9W7/v4m/mDzy7dklrnSA4MQFHvQC5J6Utn6VrGp
         16hzNhiur0ADg1zliOmm7zXLy3W9Qp9Qq1mn+GgShj6cO3wV5cIZJWzrPE6AScdJKxGi
         12czzSKPdFm3A6HEBt61gVPhA0l2e4wU8wTN9MWrJzGXQdTzGSobFQdudxEQQJCxuGgf
         Zv3gJYWpzl0YuIcML99btzG9VuNschPGnsTMP/+xy4zruyRCIKgEisWfOHePRDdj2R69
         cSlw==
X-Gm-Message-State: ABuFfoivm0Cd2FYlxdO2PfLVXZtGjPZmhuzmqbrzTIlQTY1bsJ8m11wf
        D7vNWSMbhqd1JRPrZabWS5Dm9PwO8ZREHiwMbrWtYg==
X-Google-Smtp-Source: ACcGV60VG4a38Qp/8RPmEkCwvw2Hw7+/b9TR/O16cE0e+RlNRiRa9xXrb0Ld8fPgQMJJYektNOTcTzCIuSn0wVUZEf8=
X-Received: by 2002:aca:3ad4:: with SMTP id h203-v6mr1384418oia.235.1539280999694;
 Thu, 11 Oct 2018 11:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <153861931865.2863953.11185006931458762795.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181004074457.GD22173@dhcp22.suse.cz> <CAPcyv4ht=ueiZwPTWuY5Y4y1BUOi_z+pHMjfoiXG+Bjd-h55jA@mail.gmail.com>
 <20181009112216.GM8528@dhcp22.suse.cz> <CAPcyv4gAsyw7Tpp6QKQUA=P3k-Gw=KzutS-PzBiisnxQ1R24gw@mail.gmail.com>
 <20181010084731.GB5873@dhcp22.suse.cz> <CAPcyv4j1QZSk_soYY=xpMiv0exYzdGoa0uqWppSs_dJwF4TPnw@mail.gmail.com>
 <20181011115238.GU5873@dhcp22.suse.cz>
In-Reply-To: <20181011115238.GU5873@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 11 Oct 2018 11:03:07 -0700
Message-ID: <CAPcyv4i38LAh1-bDE5cAAV=pAWMQeOYSmWF7ucM+Qt2O+GYMWw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Randomize free memory
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 4:56 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 10-10-18 17:13:14, Dan Williams wrote:
> [...]
> > On Wed, Oct 10, 2018 at 1:48 AM Michal Hocko <mhocko@kernel.org> wrote:
> > ...and now that I've made that argument I think I've come around to
> > your point about the shuffle_page_order parameter. The only entity
> > that might have a better clue about "safer" shuffle orders than
> > MAX_ORDER is the distribution provider.
>
> And how is somebody providing a kernel for large variety of workloads
> supposed to know?

True, this would be a much easier discussion with a wider / deeper data set.

>
> [...]
>
> > Note, you can also think about this just on pure architecture terms.
> > I.e. that for a direct mapped cache anywhere in a system you can have
> > a near zero cache conflict rate on a first run of a workload and high
> > conflict rate on a second run based on how lucky you are with memory
> > allocation placement relative to the first run. Randomization keeps
> > you out of such performance troughs and provides more reliable average
> > performance.
>
> I am not disagreeing here. That reliable average might be worse than
> what you get with the non-randomized case. And that might be a fair
> deal for some workloads. You are, however, providing a functionality
> which is enabled by default without any actual numbers (well except for
> _a_java_ workload that seems to benefit) so you should really do your
> homework stop handwaving and give us some numbers and/or convincing
> arguments please.

The latest version of the patches no longer enable it by default. I'm
giving you the data I can give with respect to pre-production
hardware.

> > With the numa emulation patch I referenced an
> > administrator could constrain a workload to run in a cache-sized
> > subset of the available memory if they really know what they are doing
> > and need firmer guarantees.
>
> Then mention how and what you can achieve by that in the changelog.

The numa_emulation aspect is orthogonal to the randomization
implementation. It does not belong in the randomization changelog.

> > The risk if Linux does not have this capability is unstable hacks like
> > zonesort and rebooting, as referenced in that KNL article, which are
> > not suitable for a general purpose kernel / platform.
>
> We could have lived without those for quite some time so this doesn't
> seem to be anything super urgent to push through without a proper
> justification.

We lived without them previously because memory-side-caches were
limited to niche hardware, now this is moving into general purpose
server platforms and the urgency / impact goes up accordingly.

> > > > > Many years back while at a university I was playing
> > > > > with page coloring as a method to reach a more stable performance
> > > > > results due to reduced cache conflicts. It was not always a performance
> > > > > gain but it definitely allowed for more stable run-to-run comparable
> > > > > results. I can imagine that a randomization might lead to a similar effect
> > > > > although I am not sure how much and it would be more interesting to hear
> > > > > about that effect.
> > > >
> > > > Cache coloring is effective up until your workload no longer fits in
> > > > that color.
> > >
> > > Yes, that was my observation back then more or less. But even when you
> > > do not fit into the cache a color aware strategy (I was playing with bin
> > > hoping as well) produced a more deterministic/stable results. But that
> > > is just a side note as it doesn't directly relate to your change.
> > >
> > > > Randomization helps to attenuate the cache conflict rate
> > > > when that happens.
> > >
> > > I can imagine that. Do we have any numbers to actually back that claim
> > > though?
> > >
> >
> > Yes, 2.5X cache conflict rate reduction, in the change log.
>
> Which is a single benchmark result which is not even described in detail
> to be able to reproduce that measurement. I am sorry for nagging
> here but I would expect something less obscure.

No need to apologize.

> How does this behave for
> usual workloads that we test cache sensitive workloads. I myself am not
> a benchmark person but I am pretty sure there are people who can help
> you to find proper ones to run and evaluate.

I wouldn't pick benchmarks that are cpu-cache sensitive since those
are small number of MBs in size, a memory-side cache is on the order
of 10s of GBs.

>
> > > > For workloads that may fit in the cache, and/or
> > > > environments that need more explicit cache control we have the recent
> > > > changes to numa_emulation [1] to arrange for cache sized numa nodes.
> > >
> > > Could you point me to some more documentation. My google-fu is failing
> > > me and "5.2.27.5 Memory Side Cache Information Structure" doesn't point
> > > to anything official (except for your patch referencing it).
> >
> > http://www.uefi.org/sites/default/files/resources/ACPI%206_2_A_Sept29.pdf
>
> Thanks!
>
> [...]
>
> > > With all that being said, I think the overal idea makes sense but you
> > > should try much harder to explain _why_ we need it and back your
> > > justification by actual _data_ before I would consider my ack.
> >
> > I don't have a known CVE, I only have the ack of people more
> > knowledgeable about security than myself like Kees to say in effect,
> > "yes, this complicates attacks". If you won't take Kees' word for it,
> > I'm not sure what other justification I can present on the security
> > aspect.
>
> In general (nothing against Kees here of course), I prefer a stronger
> justification than "somebody said it will make attacks harder". At least
> my concern about fragmented memory which is not really hard to achieve
> at all should be reasonably clarified. I am fully aware there is no
> absolute measure here but making something harder under ideal conditions
> doesn't really help for common attack strategies which can prepare the
> system into an actual state to exploit allocation predictability. I am
> no expert here but if an attacker can deduce the allocation pattern then
> fragmenting the memory is one easy step to overcome what people would
> consider a security measure.
>
> So color me unconvinced for now.

Another way to attack heap randomization without fragmentation is to
just perform heap spraying and hope that lands the data the attacker
needs in the right place. I still think that allocation entropy > 0 is
positive benefit, but I don't know how to determine the curve of
security benefit relative to shuffle order.

> > 2.5X cache conflict reduction on a Java benchmark workload that the
> > exceeds the cache size by multiple factors is the data I can provide
> > today. Post launch it becomes easier to share more precise data, but
> > that's post 4.20. The hope of course is to have this capability
> > available in an upstream released kernel in advance of wider hardware
> > availability.
>
> I will not comment on timing but in general, any performance related
> changes should come with numbers for a wider variety of workloads.

That's fair.

> In any case, I believe the change itself is not controversial as long it
> is opt-in (potentially autotuned based on specific HW)

Do you mean disable shuffling on systems that don't have a
memory-side-cache unless / until we can devise a security benefit
curve relative to shuffle-order? The former I can do, the latter, I'm
at a loss.

> with a reasonable
> API. And no I do not consider $RANDOM_ORDER a good interface.

I think the current v4 proposal of compile-time setting is reasonable
once we have consensus / guidance on the default shuffle-order.
