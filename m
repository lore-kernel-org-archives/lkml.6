Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8810CC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3317A206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vu+jwOMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3317A206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeI2E2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:28:46 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44059 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeI2E2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:28:46 -0400
Received: by mail-oi1-f196.google.com with SMTP id u74-v6so6675563oia.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 15:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hlQhvcOu+7OVuUVkgP+0YkFabn5JNPb5a7R7knpXp3A=;
        b=Vu+jwOMbVJjBQS04HMvX/Hj7ryO3t759iYpIs7dkdnYfR3cRxZRw7QFTnKtdYzlkOZ
         QIOp5B6eKoB/38cWKGZnsbshtEnSP47rskw99sSnC+peEIs2DDsMKQ/PBot+twizo0Jb
         MmNnU32aojRRVzsB6AqEZcZf+ERExegFWPh07cPLygZl9sUVBYtjkJB4IM5ZxCVLbjZ4
         WfQP5aYl5tORrsMq1PIjiefAPmsia+nwbCyVmj3L9VjCQRmDgGbeUsU4Cyums2C+Bszg
         Tom1LFIYvW2HM92It+Zze11981oiHULDqm9AnmXpXsedWyfskg6+06086FMFCNLJ/kpp
         kxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hlQhvcOu+7OVuUVkgP+0YkFabn5JNPb5a7R7knpXp3A=;
        b=kGiEArd0+n0ZGVqEmPwess9vnlxn8U+eycAg4HvMxhAB1PQhgPhKHbvgrG4bB1ucFN
         qJyGiHbh2PyB5Ikd5aJsKr4rGQsrTTUhWScNYE1uqWpv7I8njqbXfKKuWUOkVEVuYpxz
         51lM5H/O09cZ2zN8E3at6qaNEMkh6alISM8WUQk1BQFqR+Qz0km4tB7g7XjiSdzFNM/4
         feQPsC3CRIVcy/qkoT0vteYNi+sV48A7BMzVrVinrkiRpS/e9e04q6j8e9NzDVaOex6b
         4Id3RLMsjROwq1cV3tL050Yfgar4nGRO202a4WJ+70KmpRBmzc+lgWYluCrNiVvgpk+C
         SOew==
X-Gm-Message-State: ABuFfojDEPjcD8EXE7u6xPgaFCaSPiICV4q5eIh2f2qBsUe3jK6YS9lp
        NYqzLnsHMyNsTL7EKGG7e7XcxxhEIiEqj71GmmwggA==
X-Google-Smtp-Source: ACcGV62WlGarIEdlZmvR5F5z5WMYfJ5xDw9lPBFVCYDz2jVi1Z5MceS6VQu2sNaaLbHEi5vp96XrACuBHz7ZogW8L0c=
X-Received: by 2002:aca:3b45:: with SMTP id i66-v6mr310583oia.312.1538172180668;
 Fri, 28 Sep 2018 15:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
 <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de>
 <e89ec139-1a97-803e-343c-76eedf244d65@linux.intel.com> <CAG48ez17MOP4hLavskqJDj8KwF=otrNiwV6+cizFPwM_L0k6gA@mail.gmail.com>
In-Reply-To: <CAG48ez17MOP4hLavskqJDj8KwF=otrNiwV6+cizFPwM_L0k6gA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 29 Sep 2018 00:02:34 +0200
Message-ID: <CAG48ez0Ux6p-Bcu9ymNm_eMpydLm0-DSBYKp4XJRv27XO_QqeA@mail.gmail.com>
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

On Fri, Sep 28, 2018 at 5:12 PM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Sep 28, 2018 at 3:22 PM Tvrtko Ursulin
> <tvrtko.ursulin@linux.intel.com> wrote:
> > On 28/09/2018 11:26, Thomas Gleixner wrote:
> > > On Wed, 19 Sep 2018, Tvrtko Ursulin wrote:
> > >> For situations where sysadmins might want to allow different level of
> > >> access control for different PMUs, we start creating per-PMU
> > >> perf_event_paranoid controls in sysfs.
> > >>
> > >> These work in equivalent fashion as the existing perf_event_paranoid
> > >> sysctl, which now becomes the parent control for each PMU.
> > >>
> > >> On PMU registration the global/parent value will be inherited by each PMU,
> > >> as it will be propagated to all registered PMUs when the sysctl is
> > >> updated.
> > >>
> > >> At any later point individual PMU access controls, located in
> > >> <sysfs>/device/<pmu-name>/perf_event_paranoid, can be adjusted to achieve
> > >> fine grained access control.
> > >>
> > >> Discussion from previous posting:
> > >> https://lkml.org/lkml/2018/5/21/156
> > >
> > > This is really not helpful. The cover letter and the change logs should
> > > contain a summary of that discussion and a proper justification of the
> > > proposed change. Just saying 'sysadmins might want to allow' is not useful
> > > at all, it's yet another 'I want a pony' thing.
> >
> > Okay, for the next round I will expand the cover letter with at least
> > one concrete example on how it is usable and summarize the discussion a bit.
> >
> > > I read through the previous thread and there was a clear request to involve
> > > security people into this. Especially those who are deeply involved with
> > > hardware side channels. I don't see anyone Cc'ed on the whole series.
> >
> > Who would you recommend I add? Because I really don't know..
> >
> > > For the record, I'm not buying the handwavy 'more noise' argument at
> > > all. It wants a proper analysis and we need to come up with criteria which
> > > PMUs can be exposed at all.
> > >
> > > All of this want's a proper documentation clearly explaining the risks and
> > > scope of these knobs per PMU. Just throwing magic knobs at sysadmins and
> > > then saying 'its their problem to figure it out' is not acceptable.
> >
> > Presumably you see adding fine grained control as diminishing the
> > overall security rather than raising it? Could you explain why? Because
> > incompetent sysadmin will turn it off for some PMU, while without having
> > the fine-grained control they wouldn't turn it off globally?
> >
> > This feature was requested by the exact opposite concern, that in order
> > to access the i915 PMU, one has to compromise the security of the entire
> > system by allowing access to *all* PMU's.
> >
> > Making this ability fine-grained sounds like a logical solution for
> > solving this weakening of security controls.
> >
> > Concrete example was that on video transcoding farms users want to
> > monitor the utilization of GPU engines (like CPU cores) and they can do
> > that via the i915 PMU. But for that to work today they have to dial down
> > the global perf_event_paranoid setting. Obvious improvement was to allow
> > them to only dial down the i915.perf_event_paranoid setting. As such,
> > for this specific use case at least, the security is increased.
>
> Which paranoia level would be used for the i915.perf_event_paranoid
> setting in such a case?

Ah, I guess the answer is "0", since you want to see data about what
other users are doing.

Does the i915 PMU expose sampling events, counting events, or both?
The thing about sampling events is that they AFAIK always let the user
pick arbitrary data to collect - like register contents, or userspace
stack memory -, and independent of the performance counter being
monitored, this kind of access should not be permitted to other
contexts. (But it might be that I misunderstand how perf works - I'm
not super familiar with its API.)
