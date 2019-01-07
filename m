Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E4BC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1CB218A3
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kJJNX04H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfAGVAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:00:18 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37535 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfAGVAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:00:16 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so3124345iti.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 13:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1dGmlsl2ggM3PP7wEwKB6XSnVzrhlhr5HAdICVnfq1o=;
        b=kJJNX04HdtkKUMnHhvIxfIcUVPsYb9foLnbcmq+6YCLkRr6VCFLdHd3Z9iH+hPdcC9
         D1DnIJB/ND8F6oTQXadqDPPVgKZMx+sJtXpBbHn1j3HUfVJ9WtmvdBXjptof8NXMdGHj
         lL5dOEQdVOwU57cgfrfsuEWVadeg03RCaTkmPInHwuQfzpS0sGNucOzEhND1H0dpvkxK
         J3Ai5/87AFviW7tZcaCVKmgMA76gejgAEyYjlj++c+AxJntIRYoRHji9OYxg/IYdgYkP
         BafHBOfhayjTgtb4QqXAM+9otJHEKF74fVPbrzzMg+k1s1MjTHyGJIVI7YnoC7K88s8Z
         LnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1dGmlsl2ggM3PP7wEwKB6XSnVzrhlhr5HAdICVnfq1o=;
        b=H7/mXArozwl/kGgJzqz87roZyE2WikjMMKhix2WVXsPntUskGgXk1mF/y+RTMexL1X
         0SknyIHSZvrXUJwhPM4LrAaeQ42M8YKsrYWhNGAAEB8yu6S+0tyHL8kx6d+M/f4KMXK9
         rGFTDPGBiUURKQ71ids3MTMXFxhGXggwTSmDIXeK4PfgJMp4yFHGNv+OYNOPtvNZ7UQq
         zJ6oi3yj8MAnf/LF1TKs1tDhxucgG5Gs7CZqM8aFal8EtqgVCKrrLbsTDFA+EpqhG8kW
         ni15/x6GbkL0Shf1jgRd/v2aPWcGeVbA9cC3xdgO/08lhNPOlbXFbkdOtOsnYlw9d2E1
         2fxw==
X-Gm-Message-State: AA+aEWamrTE3zaFynRkkHoBlVGukXO/1N2YAOd+kT/vVWie5AiTo3dCn
        VOByVxpPzOOUZDclqyfybaUKGXhXdna+3GnbEbARpA==
X-Google-Smtp-Source: AFSGD/XXIhvY8wuhMoMdRc27e572Ad31pZJq4+fWI5GGHxIiXi9EyR/1F7bpQX9K2UHX8RtnHgOaag9rY75vVIsA9JM=
X-Received: by 2002:a02:7b09:: with SMTP id q9mr42673211jac.39.1546894814761;
 Mon, 07 Jan 2019 13:00:14 -0800 (PST)
MIME-Version: 1.0
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com>
 <1545816338-1171-6-git-send-email-wei.w.wang@intel.com> <CALMp9eTOV3Twep9gL-9S+Pe_k-=v17CcJTLb5=+7_pjvWf9RfQ@mail.gmail.com>
 <5C2DC132.9050103@intel.com> <CALMp9eQ0nzKBP7az72G+eRe8C4KQQUBdj+7oD_WJHSFfYkj+Vw@mail.gmail.com>
 <5C3318A1.9090009@intel.com> <CALMp9eSyC5arXkrFdJKCx=cG7uF6tVgkbSJbUJArf4cFje13rQ@mail.gmail.com>
 <20190107182012.GL6118@tassilo.jf.intel.com> <CALMp9eT2J=qFTEEpsym_aqeCRwyCquTYnY8=taZ3nY3rs8WeJA@mail.gmail.com>
 <20190107201447.GM6118@tassilo.jf.intel.com>
In-Reply-To: <20190107201447.GM6118@tassilo.jf.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 7 Jan 2019 13:00:03 -0800
Message-ID: <CALMp9eSPFSS5Q-S8cAkb3ht7DthS4Qj05rZEMCp2GeBqgBerCQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] KVM/x86: expose MSR_IA32_PERF_CAPABILITIES to
 the guest
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Wei Wang <wei.w.wang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        like.xu@intel.com, Jann Horn <jannh@google.com>,
        arei.gonglei@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 12:14 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> On Mon, Jan 07, 2019 at 10:48:38AM -0800, Jim Mattson wrote:
> > On Mon, Jan 7, 2019 at 10:20 AM Andi Kleen <ak@linux.intel.com> wrote:
> > >
> > > > The issue is compatibility. Prior to your change, reading this MSR
> > > > from a VM would raise #GP. After your change, it won't. That means
> > > > that if you have a VM migrating between hosts with kernel versions
> > > > before and after this change, the results will be inconsistent. In the
> > >
> > > No it will not be. All Linux kernel uses of this MSR are guarded
> > > by a CPUID check.
> >
> > Linux usage is irrelevant to the architected behavior of the virtual
> > CPU. According to volume 4 of the SDM, this MSR is only supported when
> > CPUID.01H:ECX.PDCM [bit 15] is set. Therefore, kvm should raise #GP
> > whenever a guest tries to read this MSR and the guest's
> > CPUID.01H:ECX.PDCM [bit 15] is clear.
>
> That's not general practice in KVM. There are lots of MSRs
> that don't fault even if their CPUID doesn't support them.

KVM doesn't really have a "general practice" in this regard. True,
there are lots of MSRs that don't fault even if unsupported. But there
are quite a few that do fault if unsupported. On the Intel side,
MSR_IA32_SPEC_CTRL, MSR_IA32_ARCH_CAPABILITIES, MSR_IA32_BNDCFGS, and
MSR_TSC_AUX all check for the corresponding capabilities in guest
CPUID. In the "common" code, MSR_IA32_TSC_ADJUST,
MSR_AMD64_OSVW_ID_LENGTH, and MSR_AMD64_OSVW_STATUS all check for the
corresponding capabilities in guest CPUID.

> It's also not generally true for instructions, where it is even
> impossible.

Yes, sometimes it is impossible to #UD for instructions that are
supported on the host but not in the guest. However, sometimes it is
possible, and kvm sometimes does enforce this. Some examples that come
to mind are RDTSCP and INVPCID. In fact, kvm goes so far as to require
that the guest CPUID must enumerate PCID support in order to enumerate
INVPCID support, and INVPCID will raise #UD unless both capabilities
are enumerated!

> You could argue it should be done for MSRs, but that would
> be a much larger patch for lots of MSRs. It seems pointless
> to single out this particular one.

Past sloppiness isn't really a compelling argument for continued
sloppiness going forward. And there are existing MSRs that do the
appropriate checks, so I'm not singling this one out.

> In practice I doubt it will make any difference for
> real software either way.

Perhaps, but when the correct behavior is so easy to implement, why
not just do it right in the first place?
