Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E17C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F11B21522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="t6TGjcvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F11B21522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389170AbeIUJcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 05:32:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36802 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388944AbeIUJcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 05:32:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so5344491pfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 20:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OkR0EEmHjd/g+8mpgc80h8botRsNUF/CTCsPMtxMXPY=;
        b=t6TGjcvqBVZL8z9FEEXU787pqQTzgSyo1/KICHdPItJpoqwt7+toeMfgxKe4UW9VjJ
         O4ZPfNktdgWk6oOBp35vNhsYPYE0QH6T05EkajTHcxPTsLxwatKRKBjeMwLfxUAPmjk2
         Q3OH7NIen2PMG6SPKVYUTa2X4s2bBpoX/rpFjnzqRVF2wZ3xWAnSIN91QfiBDRiDXLB5
         jOcvXBrlahkN3EONobp1gQvgoEvkr8Ux9lI4jlssgIYxwmYalWYkulEieg/3HIhkd69n
         KRnZbrqTkwY/sf++fzfgu3umutC9sabuHlGkN9dcDgOvKwYFKhyDln2Gsgi3LkTX3nmj
         /OFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OkR0EEmHjd/g+8mpgc80h8botRsNUF/CTCsPMtxMXPY=;
        b=sD39Yb3qNJ2QI6xrgJhTXIX8s7VQoWBz+3Cqs2gv93m7bwpCPAVvQJqepz/ZsSY0bk
         uDnzgRh7ozI1mnXd8rJDQKyR4pi9Y+kp4ehnCBthQD2HlbbVMnHEYuqZqUION98VIrwD
         7H/TBpqEXUYioi99QQLNXr2QJJVgBcdrhYhzg+DHkTwHFAdIT09sPUkhs/bMEu0GkNRX
         Qws+xql+52IQ3PFC1iCixJglXPR7BPT+Wk3pzxhx1cWfzqfwIOemdiTSFtYZ7U9fb8Jr
         4nGf1cY7H7JEv6YAxetquLOuIiwdiFCdchQwEFmHzCRTSlkHVPQTQR58sqZigtSmcUFX
         XOlQ==
X-Gm-Message-State: APzg51DMzaTn47bFyyIHUbSfTmnEFEv65RZXMqr2oZNm+st1iSFWsuIQ
        ndy+pORnSmXpDMyu928OcyOBrQ==
X-Google-Smtp-Source: ANB0VdYIJuq6qcXcLipHK+AZu7Q9CbCa1DhqwcC3n3/MxMUm6wBR96J0/6rBSfNN+FyYypBUE3oP9Q==
X-Received: by 2002:a63:2fc6:: with SMTP id v189-v6mr39506877pgv.61.1537501558980;
        Thu, 20 Sep 2018 20:45:58 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:413c:2b8f:d2ea:80b3? ([2601:646:c200:7429:413c:2b8f:d2ea:80b3])
        by smtp.gmail.com with ESMTPSA id m10-v6sm1133911pgp.94.2018.09.20.20.45.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 20:45:57 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 10/10] x86/fpu: defer FPU state load until return to userspace
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20180919170515.ptqmmpsxrdjsi64j@linutronix.de>
Date:   Thu, 20 Sep 2018 20:45:56 -0700
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D5D1FB08-9CE8-498B-9636-C0390153814A@amacapital.net>
References: <20180912133353.20595-1-bigeasy@linutronix.de> <20180912133353.20595-11-bigeasy@linutronix.de> <650FC457-7E4C-473A-9E5F-EAFC74F6444B@amacapital.net> <20180919170515.ptqmmpsxrdjsi64j@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 19, 2018, at 10:05 AM, Sebastian Andrzej Siewior <bigeasy@linutroni=
x.de> wrote:
>=20
> On 2018-09-12 08:47:19 [-0700], Andy Lutomirski wrote:
>>> --- a/arch/x86/kernel/fpu/core.c
>>> +++ b/arch/x86/kernel/fpu/core.c
>>> @@ -101,14 +101,14 @@ void __kernel_fpu_begin(void)
>>>=20
>>>   kernel_fpu_disable();
>>>=20
>>> -    if (fpu->initialized) {
>>> +    __cpu_invalidate_fpregs_state();
>>> +
>>> +    if (!test_and_set_thread_flag(TIF_LOAD_FPU)) {
>>=20
>> Since the already-TIF_LOAD_FPU path is supposed to be fast here, use test=
_thread_flag() instead. test_and_set operations do unconditional RMW operati=
ons and are always full barriers, so they=E2=80=99re slow.
> okay.
>=20
>> Also, on top of this patch, there should be lots of cleanups available. I=
n particular, all the fpu state accessors could probably be reworked to take=
 TIF_LOAD_FPU into account, which would simplify the callers and maybe even t=
he mess of variables tracking whether the state is in regs.
>=20
> Do you refer to the fpu.initilized check or something else?
>=20

I mean the fpu.initialized variable entirely. AFAIK, its only use is for ker=
nel threads =E2=80=94 setting it to false lets us switch to a kernel thread a=
nd back without saving and restoring. But TIF_LOAD_FPU should be able to rep=
lace it: when we have FPU regs loaded and we switch to *any* thread, kernel o=
r otherwise, we can set TIF_LOAD_FPU and leave the old regs loaded.  So we d=
on=E2=80=99t need the special case for kernel threads.

Which reminds me: if you haven=E2=80=99t already done so, can you add a help=
er to sanity check the current context?  It should check that the combinatio=
n of owner_ctx, last_cpu, and TIF_LOAD_FPU is sane. For example, if owner_ct=
x or last_cpu is says the cpu regs are invalid for current but TIF_LOAD_FPU i=
s clear, it should warn.  I think that at least switch_fpu_finish should cal=
l it.  Arguably switch_fpu_prepare should too, at the beginning.=
