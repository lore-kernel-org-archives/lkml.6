Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45767ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31182083A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="cPvT4fHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31182083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388984AbeIUKCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 06:02:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40702 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388722AbeIUKCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 06:02:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id l63-v6so5426213pga.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 21:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CFzU4xNhQ8VibDl5mMbxaobpFQgP5M6ePUtNz6ViwAw=;
        b=cPvT4fHq/Oxq2F0a5KxFHI4UILZq495RIUo2aqsvVCVVs1UP3ryd7YYvRqTiLBX1yE
         5+j9BYssrNtXEMIEI6il6XSTFInCKoqG//f0lO7JfTdgB8jCC96+HquuUkTD3Nm8jZvR
         M+zfuMRV+daEeiZtdDxbuU8Y/tBhfb2musgVEBBzRClNFiKeO8nRqLdqW+MQTc8eXq3W
         hVms5KTuA0ixTlP0DX7ji206ix+GMwFk5pJpoyeSucXpT/+pyvcuGJTYbshuh8iwh3eE
         Zl/oxnYYUwCSH0RVq3nSNsCQ2PgxddqlCE2rBcJ1xLz4MI4YP24CpFayfJX7w5sOxBf8
         0xZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CFzU4xNhQ8VibDl5mMbxaobpFQgP5M6ePUtNz6ViwAw=;
        b=iROubQ3h63tvT91G381bDXf2IC46Iuh52jMo0xyKTcfl4jtuwP4XrvEBd3gM7P2dVt
         oMxwOKJW63EoTwgEnkjWw7HdtzLgtcO18ahZ7+/ZeCosaqBJ8mwYtcsXIjIrDxoDf3j5
         eLd1xtv/3Xz4m+40Mfazm/JxomSO7CE/KCtS1/So3fva0OZ5rTpoB96+7sryLUIVqPDJ
         ov1mG3nqkHpxyjqPJL8Iu3v4d95vW0T4mEijtGeF0WuJgeTpPH7IDDjTBrKlVyMdscKt
         pClSMGczhLInvq3GZ4fph0vj9NcdRqHFoscai++CxHZvMGFe+NJ+hUtEQhuK2Qmz/IUg
         ts/g==
X-Gm-Message-State: APzg51AI0BjSyzoQirUxlGnxQ+j3FpDBEOMFW/tThBmoQd0HJCVoTyVw
        BfT3mveNTm9Bjt40SjiEgdEOMA==
X-Google-Smtp-Source: ANB0VdaczDPUw5kAfUN3aMebQQoCk/f3imtiR0pYPfoPN957QaVykPCv7PuP5bqR/8yXBhh3WpCb9g==
X-Received: by 2002:a62:8559:: with SMTP id u86-v6mr44593382pfd.32.1537503338129;
        Thu, 20 Sep 2018 21:15:38 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:413c:2b8f:d2ea:80b3? ([2601:646:c200:7429:413c:2b8f:d2ea:80b3])
        by smtp.gmail.com with ESMTPSA id d66-v6sm44279156pfd.121.2018.09.20.21.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 21:15:36 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 10/10] x86/fpu: defer FPU state load until return to userspace
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <D5D1FB08-9CE8-498B-9636-C0390153814A@amacapital.net>
Date:   Thu, 20 Sep 2018 21:15:35 -0700
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A5B266A3-1EF7-44A4-9AAF-1AA1858CEFCF@amacapital.net>
References: <20180912133353.20595-1-bigeasy@linutronix.de> <20180912133353.20595-11-bigeasy@linutronix.de> <650FC457-7E4C-473A-9E5F-EAFC74F6444B@amacapital.net> <20180919170515.ptqmmpsxrdjsi64j@linutronix.de> <D5D1FB08-9CE8-498B-9636-C0390153814A@amacapital.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 20, 2018, at 8:45 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>=20
>=20
>=20
>> On Sep 19, 2018, at 10:05 AM, Sebastian Andrzej Siewior <bigeasy@linutron=
ix.de> wrote:
>>=20
>> On 2018-09-12 08:47:19 [-0700], Andy Lutomirski wrote:
>>>> --- a/arch/x86/kernel/fpu/core.c
>>>> +++ b/arch/x86/kernel/fpu/core.c
>>>> @@ -101,14 +101,14 @@ void __kernel_fpu_begin(void)
>>>>=20
>>>>  kernel_fpu_disable();
>>>>=20
>>>> -    if (fpu->initialized) {
>>>> +    __cpu_invalidate_fpregs_state();
>>>> +
>>>> +    if (!test_and_set_thread_flag(TIF_LOAD_FPU)) {
>>>=20
>>> Since the already-TIF_LOAD_FPU path is supposed to be fast here, use tes=
t_thread_flag() instead. test_and_set operations do unconditional RMW operat=
ions and are always full barriers, so they=E2=80=99re slow.
>> okay.
>>=20
>>> Also, on top of this patch, there should be lots of cleanups available. I=
n particular, all the fpu state accessors could probably be reworked to take=
 TIF_LOAD_FPU into account, which would simplify the callers and maybe even t=
he mess of variables tracking whether the state is in regs.
>>=20
>> Do you refer to the fpu.initilized check or something else?
>>=20
>=20
> I mean the fpu.initialized variable entirely. AFAIK, its only use is for k=
ernel threads =E2=80=94 setting it to false lets us switch to a kernel threa=
d and back without saving and restoring. But TIF_LOAD_FPU should be able to r=
eplace it: when we have FPU regs loaded and we switch to *any* thread, kerne=
l or otherwise, we can set TIF_LOAD_FPU and leave the old regs loaded.  So w=
e don=E2=80=99t need the special case for kernel threads.
>=20
> Which reminds me: if you haven=E2=80=99t already done so, can you add a he=
lper to sanity check the current context?  It should check that the combinat=
ion of owner_ctx, last_cpu, and TIF_LOAD_FPU is sane. For example, if owner_=
ctx or last_cpu is says the cpu regs are invalid for current but TIF_LOAD_FP=
U is clear, it should warn.  I think that at least switch_fpu_finish should c=
all it.  Arguably switch_fpu_prepare should too, at the beginning.

Looking some more, the =E2=80=9Cpreload=E2=80=9D variable needs to go away o=
r be renamed. It hasn=E2=80=99t had anything to do with preloading for some t=
ime.

Also, the interaction between TIF_LOAD_FPU and FPU emulation needs to be doc=
umented somewhere.  Probably FPU-less systems should never have TIF_LOAD_FPU=
 set.

Or we could decide that no one uses FPU emulation any more.=
