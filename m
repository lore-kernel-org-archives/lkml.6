Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F18C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AC720685
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="srbsS4y5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7AC720685
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbeI1Vgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:36:40 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35276 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeI1Vgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:36:40 -0400
Received: by mail-ot1-f68.google.com with SMTP id j9-v6so6392221otl.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 08:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xoBYo6N7zbY1DvK4OsFzf7y7du6uFe0yJXGaCutdLr0=;
        b=srbsS4y5MtYxN1Nsxo4Tns+7gy1u3Lt0RDRyQKc8ezJl3SFaYaNppw/tILpbBTkNQE
         1hrWiXGQUpHliUW+LExxU+YENLqGrtT+aXOPgWYzprY3lgmLzBqbP2OeoaIOjzkR3eNv
         Nf2xpWJ+4d/Eb7r5E7ht3PcsCRfHKIbs6lUMsqKIhP2W2l3DeUUuj8FGcxTKvqCEmk4b
         cR3LjMn/O6epjnkjPI3xFzosdAElDsq47cV5K7taIcaMeA8Npu1WTiBa/VZXIxpPe9bR
         LGtElGS5a8MS7DLSk/bRjmjyjpojXFkBXgdymU2Ap8ZnlR1AtnzQYO6Oe6KzYhiWFvVi
         HvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xoBYo6N7zbY1DvK4OsFzf7y7du6uFe0yJXGaCutdLr0=;
        b=TdtNY2PpZ779S7l7tyFdwGD8C3o1SuMDcb1JgVfQi/YKA8ApSZBV9nSYOJkO3JG6yJ
         5bEob6jElxASBXA3gfZkjQ1+YV6QAyG+T3MJAOxBAlRncQ0OxSZn4fd1v56kX78HYJBA
         x2MeEr81JyACFbTkh05RNqg1k/YWJuhzRYNshDxDgDIoGhubmldaxQJ0j9fInnDH6ErQ
         A/g7+CdD60ro0dZJPspNYcrT4sTaxuaRKrg6Kz7HWlKYKlfURFLTNxiWZiH3cekOb8wV
         jiZB4u31pW3GCEMhAtzomz2cDBgrdNGjZPKoo7VPe0j+n777kkrn9OPkRSkOLjDVOc6i
         RVYg==
X-Gm-Message-State: ABuFfojz+zP7VnRhkiJAhITCfPKVaC7eu24U7033Kr6a9YuJqSA5Y+i7
        tREyG2AEBOE8UnwwaV/bRPb6YbFfAXUGpE7GZf3CCA==
X-Google-Smtp-Source: ACcGV60lOe0Va13zZi7EMojx6aMlNP0cA+69gKrRC54RBpkEKWIGKYhemsdiBaOBYYW98Rph8LTuG6aCCnoJHUWw1VQ=
X-Received: by 2002:a9d:3ea2:: with SMTP id b31-v6mr9311650otc.292.1538147546541;
 Fri, 28 Sep 2018 08:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
 <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de> <e89ec139-1a97-803e-343c-76eedf244d65@linux.intel.com>
In-Reply-To: <e89ec139-1a97-803e-343c-76eedf244d65@linux.intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 28 Sep 2018 17:12:00 +0200
Message-ID: <CAG48ez17MOP4hLavskqJDj8KwF=otrNiwV6+cizFPwM_L0k6gA@mail.gmail.com>
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
To:     tvrtko.ursulin@linux.intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>, tursulin@ursulin.net,
        kernel list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, maddy@linux.vnet.ibm.com,
        Andi Kleen <ak@linux.intel.com>,
        alexey.budankov@linux.intel.com, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 3:22 PM Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
> On 28/09/2018 11:26, Thomas Gleixner wrote:
> > On Wed, 19 Sep 2018, Tvrtko Ursulin wrote:
> >> For situations where sysadmins might want to allow different level of
> >> access control for different PMUs, we start creating per-PMU
> >> perf_event_paranoid controls in sysfs.
> >>
> >> These work in equivalent fashion as the existing perf_event_paranoid
> >> sysctl, which now becomes the parent control for each PMU.
> >>
> >> On PMU registration the global/parent value will be inherited by each PMU,
> >> as it will be propagated to all registered PMUs when the sysctl is
> >> updated.
> >>
> >> At any later point individual PMU access controls, located in
> >> <sysfs>/device/<pmu-name>/perf_event_paranoid, can be adjusted to achieve
> >> fine grained access control.
> >>
> >> Discussion from previous posting:
> >> https://lkml.org/lkml/2018/5/21/156
> >
> > This is really not helpful. The cover letter and the change logs should
> > contain a summary of that discussion and a proper justification of the
> > proposed change. Just saying 'sysadmins might want to allow' is not useful
> > at all, it's yet another 'I want a pony' thing.
>
> Okay, for the next round I will expand the cover letter with at least
> one concrete example on how it is usable and summarize the discussion a bit.
>
> > I read through the previous thread and there was a clear request to involve
> > security people into this. Especially those who are deeply involved with
> > hardware side channels. I don't see anyone Cc'ed on the whole series.
>
> Who would you recommend I add? Because I really don't know..
>
> > For the record, I'm not buying the handwavy 'more noise' argument at
> > all. It wants a proper analysis and we need to come up with criteria which
> > PMUs can be exposed at all.
> >
> > All of this want's a proper documentation clearly explaining the risks and
> > scope of these knobs per PMU. Just throwing magic knobs at sysadmins and
> > then saying 'its their problem to figure it out' is not acceptable.
>
> Presumably you see adding fine grained control as diminishing the
> overall security rather than raising it? Could you explain why? Because
> incompetent sysadmin will turn it off for some PMU, while without having
> the fine-grained control they wouldn't turn it off globally?
>
> This feature was requested by the exact opposite concern, that in order
> to access the i915 PMU, one has to compromise the security of the entire
> system by allowing access to *all* PMU's.
>
> Making this ability fine-grained sounds like a logical solution for
> solving this weakening of security controls.
>
> Concrete example was that on video transcoding farms users want to
> monitor the utilization of GPU engines (like CPU cores) and they can do
> that via the i915 PMU. But for that to work today they have to dial down
> the global perf_event_paranoid setting. Obvious improvement was to allow
> them to only dial down the i915.perf_event_paranoid setting. As such,
> for this specific use case at least, the security is increased.

Which paranoia level would be used for the i915.perf_event_paranoid
setting in such a case?

Perhaps also CC kernel-hardening@lists.openwall.com on the next version.
