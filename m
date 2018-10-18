Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17483C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A0B21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="1qmNJklk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A0B21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbeJSBCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:02:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40435 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbeJSBCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:02:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id g21-v6so8161939pfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 10:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5zEikSzxXVf3Yi7XWwHiObXXQT1zzQeMLYzg5UzCkmk=;
        b=1qmNJklkKtPS/s/y9U4MZYSZ/mRwfQyKff9A9zbrvXsx9fAe1twIYP2VTqYNmI0PHU
         W7fzOfmD8kaORKMWjFgu1wtlECG8VA6yTrW1Qjw3qNZjFWMWCykNEiK7GPAKGrQebosK
         GWJ15gazRhD7RPhm3MvGT1jhZholPYjgPDlDJakA2KP8ehs61VqVpd9Vu/5XATaaKdId
         LMzy8A6HVK7I4vtni920fmsOrD/NYHTf/TA0MPyLd2BKeXyrCmFE0u62P8PWDU/3AHG7
         Pa4fnKUuC6s2rwrqir7sXU+2F2x+EG5+LffZFnc74cvXBQGfg4ODtJeBQMyn5+hGq1XW
         xiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5zEikSzxXVf3Yi7XWwHiObXXQT1zzQeMLYzg5UzCkmk=;
        b=BMazvgiFtJ2JI3VHtSwCpvmZGRzH4cwAwR1qvEFzYRGZhjfeJCVUJStnRRrGOoN9cV
         MGfaZDAvscI/P4wsW3fTETWClrdQ5cMJTNzBoO7kU8MtcJbMTZ1A/jjeerMiPEL4e+5R
         aS2slwwDGDDUHsboUttkOocyNkpvtDh9M5WZ6Ck2IZXC/mQs+P9YJHFKFrnXzMuipSJY
         MH5A8P16jmyfqqGnjfyvX/D/yQmqcVpRb6m800E9SEFFUOepacX3YOHYFDwHs305AejA
         9SLHGzW4qzPIxvPp7FmZNLEqR82iTR/4ird4+61QqF51SjZ0mddzWSU2pVwwz61GLc+F
         Xdnw==
X-Gm-Message-State: ABuFfogsvwS1cEUYPVICSTao7PG6SNODws5bqiio67NfK0JaS/F0+kHC
        sho96HVF8u4N8laIh1wJ915xdnlloQ8=
X-Google-Smtp-Source: ACcGV604Nbh9dGGkNFeK/cERDQ+NwJ4miv9QZKJVbmPrvqmOinIlSv2m2Dmnldt54OLASoAxFbmDHg==
X-Received: by 2002:a63:541e:: with SMTP id i30-v6mr29383959pgb.413.1539882040095;
        Thu, 18 Oct 2018 10:00:40 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:3007:d8c7:a746:3822? ([2601:646:c200:7429:3007:d8c7:a746:3822])
        by smtp.gmail.com with ESMTPSA id h65-v6sm27014180pgc.88.2018.10.18.10.00.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 10:00:38 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 1/5] x86: introduce preemption disable prefix
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <925F22EA-F8CB-4194-B96B-378409ED7918@vmware.com>
Date:   Thu, 18 Oct 2018 10:00:37 -0700
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2626124E-7344-42F3-AD07-0BB34D62A9EE@amacapital.net>
References: <20181018005420.82993-1-namit@vmware.com> <20181018005420.82993-2-namit@vmware.com> <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net> <07255D2B-0243-4254-B62A-37050C44207E@vmware.com> <CALCETrXEG8OrMpB3VBS9RF41O_MwtPmXBazkdSGE0ohZmXDcBw@mail.gmail.com> <925F22EA-F8CB-4194-B96B-378409ED7918@vmware.com>
To:     Nadav Amit <namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 18, 2018, at 9:47 AM, Nadav Amit <namit@vmware.com> wrote:
>=20
> at 8:51 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>=20
>>> On Wed, Oct 17, 2018 at 8:12 PM Nadav Amit <namit@vmware.com> wrote:
>>> at 6:22 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>>=20
>>>>> On Oct 17, 2018, at 5:54 PM, Nadav Amit <namit@vmware.com> wrote:
>>>>>=20
>>>>> It is sometimes beneficial to prevent preemption for very few
>>>>> instructions, or prevent preemption for some instructions that precede=

>>>>> a branch (this latter case will be introduced in the next patches).
>>>>>=20
>>>>> To provide such functionality on x86-64, we use an empty REX-prefix
>>>>> (opcode 0x40) as an indication that preemption is disabled for the
>>>>> following instruction.
>>>>=20
>>>> Nifty!
>>>>=20
>>>> That being said, I think you have a few bugs. First, you can=E2=80=99t j=
ust ignore
>>>> a rescheduling interrupt, as you introduce unbounded latency when this
>>>> happens =E2=80=94 you=E2=80=99re effectively emulating preempt_enable_n=
o_resched(), which
>>>> is not a drop-in replacement for preempt_enable(). To fix this, you may=

>>>> need to jump to a slow-path trampoline that calls schedule() at the end=
 or
>>>> consider rewinding one instruction instead. Or use TF, which is only a
>>>> little bit terrifying=E2=80=A6
>>>=20
>>> Yes, I didn=E2=80=99t pay enough attention here. For my use-case, I thin=
k that the
>>> easiest solution would be to make synchronize_sched() ignore preemptions=

>>> that happen while the prefix is detected. It would slightly change the
>>> meaning of the prefix.
>=20
> So thinking about it further, rewinding the instruction seems the easiest
> and most robust solution. I=E2=80=99ll do it.
>=20
>>>> You also aren=E2=80=99t accounting for the case where you get an except=
ion that
>>>> is, in turn, preempted.
>>>=20
>>> Hmm.. Can you give me an example for such an exception in my use-case? I=

>>> cannot think of an exception that might be preempted (assuming #BP, #MC
>>> cannot be preempted).
>>=20
>> Look for cond_local_irq_enable().
>=20
> I looked at it. Yet, I still don=E2=80=99t see how exceptions might happen=
 in my
> use-case, but having said that - this can be fixed too.

I=E2=80=99m not totally certain there=E2=80=99s a case that matters.  But it=
=E2=80=99s worth checking=20

>=20
> To be frank, I paid relatively little attention to this subject. Any
> feedback about the other parts and especially on the high-level approach? I=
s
> modifying the retpolines in the proposed manner (assembly macros)
> acceptable?
>=20

It=E2=80=99s certainly a neat idea, and it could be a real speedup.

> Thanks,
> Nadav
