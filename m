Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C99AECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC40220869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajaFMpao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC40220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeJSWx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:53:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36013 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJSWx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:53:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so37744902wrw.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+kqQcne43yBtKD0A4xPWMBbdtznaufs+fBWnD76mFs=;
        b=ajaFMpaoYsmG0R762tYUnDS3ksRvUUxalZbggHmdQC2PI9u6nq8evZSodJ/XAin/Wh
         XqbjxeKHlW2iHvn+sI2gzmNoelDy4u3qX7ZSleOKVwZkcHWoe1fADaJ+rKfkJA1MgfXi
         Jzzwesil0arauW0D1ynGEzK/EKqmxMkXYRHmXpHhsihBS2NjM+HBOBCL8Yyroy4bq6zV
         hpqreRvdzpRC829K4sw9n3Q22bYOEwDnCo37zs9vjG+7F/97pf34sdEiOARFp2vr5ofA
         CpDGk5OY5yq9zel17C4DDVe0KijNkCT3pF7EfhMBQKhscaHtOrnkWgrR4tuOTA3l0uJg
         v53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+kqQcne43yBtKD0A4xPWMBbdtznaufs+fBWnD76mFs=;
        b=BpKemf3blsSiV+rDy/FgAMpGp3qgp2s2f15xPIO6XcNUmfyIEyDx5BlqayjxIjmFWX
         xq8OJfofuboFGkFz1N4IgDdn+7Tb506UZaOcIiJ/3PrmyodkMJCbuWt2AkC9bFkRqln2
         SKKBRnMxka41rm8Uo7WWOPh/cBwqTaZi2Gpzb+2Ubt1TPw8eCjdx0TfXA1XhYzTS+Rn0
         ZjBlOdFImjFfWEqg5y3gxZiVxfHfbK295lEwT0+fhjfbHIxrBn9tEUDCjn0OisCcRQlM
         r4wGoaXQZ9te2UopG+CcD1ubBzEYwNTYVkzOav9queKeARh+ftrMaUcQ+Fx1qcXT7MbB
         pRbw==
X-Gm-Message-State: ABuFfojGmTUPjlACsvIiaDe4d0QaWOsLH+Y8MtFQbcs+Jn8vRl77fq5v
        OVmkdUF3dWynAHg8J3vgAsZrYaoTkIRERTpWWqg=
X-Google-Smtp-Source: ACcGV634pvV/ZWhB3UDnctkJjOFMmd9ukQLKaEzSLetJJIKIg3mkncIqeEzdntN3xC8i9P2UjxqRVSMTZCKzlQRqT3U=
X-Received: by 2002:adf:f712:: with SMTP id r18-v6mr34293605wrp.85.1539960450696;
 Fri, 19 Oct 2018 07:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20181018005420.82993-1-namit@vmware.com> <20181018005420.82993-2-namit@vmware.com>
 <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net> <07255D2B-0243-4254-B62A-37050C44207E@vmware.com>
 <CALCETrXEG8OrMpB3VBS9RF41O_MwtPmXBazkdSGE0ohZmXDcBw@mail.gmail.com>
 <925F22EA-F8CB-4194-B96B-378409ED7918@vmware.com> <2626124E-7344-42F3-AD07-0BB34D62A9EE@amacapital.net>
 <6F1FD9DA-5E86-42A2-8EAF-05F5D70FE2EF@vmware.com> <CALCETrWjeqMs7Z6auStk9VGT9vAn+U5REGE+=TBv1Yh4kmOF3w@mail.gmail.com>
 <20181019050051.bs2kk4sagu7hpwxx@ast-mbp.dhcp.thefacebook.com> <20181019082202.GB3121@hirez.programming.kicks-ass.net>
In-Reply-To: <20181019082202.GB3121@hirez.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 19 Oct 2018 07:47:18 -0700
Message-ID: <CAADnVQ+et48gk7+gsJb5Wmp6pGuU3t=Yg5t73sKxPJOdbu8K8Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] x86: introduce preemption disable prefix
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Nadav Amit <namit@vmware.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 1:22 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Oct 18, 2018 at 10:00:53PM -0700, Alexei Starovoitov wrote:
> > >
> > > >
> > > > Another example is __BPF_PROG_RUN_ARRAY(), which also uses
> > > > preempt_enable_no_resched().
> > >
> > > Alexei, I think this code is just wrong.
> >
> > why 'just wrong' ?
>
> Because you lost a preemption point, this is a no-no.
>
> >
> > > Do you know why it uses
> > > preempt_enable_no_resched()?
> >
> > dont recall precisely.
> > we could be preemptable at the point where macro is called.
> > I think the goal of no_resched was to avoid adding scheduling points
> > where they didn't exist before just because a prog ran for few nsec.
> > May be Daniel or Roman remember.
>
> No, you did the exact opposite, where there previously was a preemption,
> you just ate it. The band saw didn't get stopped in time, you loose your
> hand etc..

Let me do few experiments then.
We will fix it up.
