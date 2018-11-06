Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E49C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E302083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="feX3s/kL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E302083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbeKGFjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:39:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44988 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeKGFjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 00:39:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id w3-v6so6284260pgs.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 12:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=p/2YV/foJ7fESOKT5qFmLLlt78/aH5zyuVRwSgAdvlk=;
        b=feX3s/kLE5r1AviZTfPOnUJ29usFK2vHonU0AhCF7MoRz0nRET5Io2hCVd+zqhi6ch
         sRunlmrEObF9xWqgK7DUqUE8HM9Gb4unVhTSDYU1AQqVWglAw1UKenxmbZ2Few416rIA
         iFRXC+uV03UkxEnFa+7G4sYwRvxcfR6WwJvdH8Ba8rrADK8cn7HV10BL5foQQu1ZOAzF
         NUjt3qNnKQnt/2M/1qRJslJOB6kMgvM2akC6TZaPb7QmSVVyB9JKreIllJ0yj8L6srUJ
         iHbbtebby0+80VQ9aC2tBFa5/vIxBSVZZHd+izkjWFJzSlRc/cYNcUY7W64yHikbpnkX
         qj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=p/2YV/foJ7fESOKT5qFmLLlt78/aH5zyuVRwSgAdvlk=;
        b=nr8Y4e0Ezju420ZvRQT0D5+zDP5XnXY00pgoTvDMcAVfPA+9Pp5IGvEg5tsmSd7ccl
         ahWlsls7oIK/3VhYk755aG2AtclCoAbsahc2HHf+kN5xuLKDMFbfeDVBESL1RG2o1GxQ
         BmIvBkL1L8nbKUHc2SwQgprGI7eXPSq2pHqMuRKhokoNzgU2VCWhlw1D2LWIXGFWAzp1
         qUL6ePW++pEYC++qcEcufw2jTTl+CbFJfy13gEPa4c9kUk8odVChlAjFxjVpeQxFYLMB
         16QM/junSnzdRgp7ybsQiyzpbIWhzSa0SMKsOuuItFCCWrpOpAQoCRMzaRwHp4PvkZY/
         MgJQ==
X-Gm-Message-State: AGRZ1gJwJnu1eW18F+h+bgwEQd2Cu+MAbKg+B+FqeoknX3xv/Ssh5lJX
        0a8M7O92fWODf09KqZQyRi9M2w==
X-Google-Smtp-Source: AJdET5eYIrqkLG8M92Y4/r4cfcpHadEg45G8Cj1AEzpw9Fvp7nlrXuBJqztL6Lw6BpqfPl+CsRoEOQ==
X-Received: by 2002:a62:cac4:: with SMTP id y65-v6mr27554542pfk.27.1541535139712;
        Tue, 06 Nov 2018 12:12:19 -0800 (PST)
Received: from ?IPv6:2601:646:c200:7429:4032:437d:ec46:1726? ([2601:646:c200:7429:4032:437d:ec46:1726])
        by smtp.gmail.com with ESMTPSA id v191sm27343115pgb.77.2018.11.06.12.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 12:12:18 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: RFC: userspace exception fixups
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <b9c53669-cd27-e3bc-3d62-f47c77029c43@intel.com>
Date:   Tue, 6 Nov 2018 12:12:17 -0800
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rich Felker <dalias@libc.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        Linux API <linux-api@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, nhorman@redhat.com,
        npmccallum@redhat.com, "Ayoun, Serge" <serge.ayoun@intel.com>,
        shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Carlos O'Donell <carlos@redhat.com>,
        adhemerval.zanella@linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1C426267-492F-4AE7-8BE8-C7FE278531F9@amacapital.net>
References: <CAHk-=wiYSpmDOfpi9n7ETsxK2UrUKfT4kM=Y3yqRSaZuFFPY1A@mail.gmail.com>
 <20181102163034.GB7393@linux.intel.com> <7050972d-a874-dc08-3214-93e81181da60@intel.com>
 <20181102170627.GD7393@linux.intel.com> <a4d2b3ec-43ec-f062-e180-c6e5a0d9fab8@intel.com>
 <20181102173350.GF7393@linux.intel.com> <CALCETrUQVPN0LSEz+5aNsbfFc=rQ33JHiOoRXVbvEEb9is9DDQ@mail.gmail.com>
 <20181102182712.GG7393@linux.intel.com> <CAG48ez0x7ZPcKvLt01WS-VrLm59WfvYE3nE1xbnyn3Qsp5T2rA@mail.gmail.com>
 <20181102220437.GI7393@linux.intel.com> <CAG48ez1+nGDbuBaKJVPAOzEwiBkXqHHs7vmyAqvbeM42r0nFHg@mail.gmail.com>
 <CALCETrXq1Kj=McxnPVjkscNq-b_7LeoFOdu7qKjHdvwcfFh9Og@mail.gmail.com>
 <1541518670.7839.31.camel@intel.com> <AF4A5C77-0A79-403F-A205-0F93B7CD6E26@amacapital.net>
 <1541524750.7839.51.camel@intel.com> <22596E35-F5D1-4935-86AB-B510DCA0FABE@amacapital.net>
 <c9659222-efc6-b73a-ce48-30be8bdc5397@intel.com> <CALCETrWBV=1JbAKYn2Jy2LxkGZQvKRtFRnrWUMoejrwQe73VHw@mail.gmail.com>
 <b9c53669-cd27-e3bc-3d62-f47c77029c43@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 6, 2018, at 11:22 AM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
>> On 11/6/18 11:02 AM, Andy Lutomirski wrote:
>>> On Tue, Nov 6, 2018 at 10:41 AM Dave Hansen <dave.hansen@intel.com> wrot=
e:
>>>=20
>>>> On 11/6/18 10:20 AM, Andy Lutomirski wrote:
>>>> I almost feel like the right solution is to call into SGX on its own
>>>> private stack or maybe even its own private address space.
>>>=20
>>> Yeah, I had the same gut feeling.  Couldn't the debugger even treat the
>>> enclave like its own "thread" with its own stack and its own set of
>>> registers and context?  That seems like a much more workable model than
>>> trying to weave it together with the EENTER context.
>>=20
>> So maybe the API should be, roughly
>>=20
>> sgx_exit_reason_t sgx_enter_enclave(pointer_to_enclave, struct
>> host_state *state);
>> sgx_exit_reason_t sgx_resume_enclave(same args);
>>=20
>> where host_state is something like:
>>=20
>> struct host_state {
>>  unsigned long bp, sp, ax, bx, cx, dx, si, di;
>> };
>>=20
>> and the values in host_state explicitly have nothing to do with the
>> actual host registers.  So, if you want to use the outcall mechanism,
>> you'd allocate some memory, point sp to that memory, call
>> sgx_enter_enclave(), and then read that memory to do the outcall.
>=20
> Ah, so instead of the enclave rudely "hijacking" the EENTER context, we
> have it nicely return and nicely _hint_ to the calling context what it
> would like to do.  Then, the EENTER context can make a controlled
> transition over to the requested context.

Exactly. And existing enclaves keep working =E2=80=94 their rudeness is just=
 magically translated into a hint!

>=20
>> Actually implementing this would be distinctly nontrivial, and would
>> almost certainly need some degree of kernel help to avoid an explosion
>> when a signal gets delivered while we have host_state.sp loaded into
>> the actual SP register.  Maybe rseq could help with this?
>=20
> As long as the memory pointed to by host_state.sp is valid and can hold
> the signal frame (grows down without clobbering anything), what goes
> boom?  The signal handling would push a signal frame and call the
> handler.  It would have a shallow-looking stack, but the handler could
> just do its normal business and return from the signal where the frame
> would get popped and continue with %rsp=3Dhost_state.sp, blissfully
> unaware of the signal ever having happened.

True, but what if we have a nasty enclave that writes to memory just below S=
P *before* decrementing SP?

I suspect that rseq really can be used for this with only minimal-ish modifi=
cations.  Or we could stick this in the vDSO with some appropriate fixups in=
 the kernel.=
