Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43128C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38F421547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Zuik0yFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38F421547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeI0U7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:59:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46333 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeI0U7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:59:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id d8-v6so2052046pfo.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=60nCAir1PGjGMBK+U/3RcSGcSVVouC3TH3bY/jjtnvs=;
        b=Zuik0yFMnIJAgZAEoK2yExASPX4BFhf+w7/EKYwunA+PPIhTs9pySF2NSstf1D2YNJ
         h9im+nmWTTVG8+kZLh/o8e7Srq5H0nahIPl0GGLKpE7t2WN4cPqr7nUJrPlcF6xIvZwr
         VQ0/losgwJKqGrN4k/CGTFVc04/Il7hzrZZS7y4YeXTYLb72OeqokP30N46aftvmkpsq
         lzTZJ764hZltpEj16umSjIkIdvAHQFsrenNlm4vrhRaL+UYTAnQukuNM5aWKjKge80WF
         3ySVUpiCO4Ny4HveC9lQLBhMOLx6r+LiGL3qRvYAWIuLB/mcGNI1EFh9riHoVcmyU+ie
         lt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=60nCAir1PGjGMBK+U/3RcSGcSVVouC3TH3bY/jjtnvs=;
        b=XIjabIyK68OvbaALaufz7jNZvw0cJVXZTRlCyUFr2uq8yqnL+dtWdTvPB5P0qR5Qb2
         14pXxTmcLVqEgmkr9TGe3uNfl1ZSs38EtIFA2dn3uZAoHb4Oq41DpRvEGQi2In2jK7xI
         q+2LCR3nPA+09fe4ZK/hOVHqjxgAa9BPZcU0TOJP5APCgPIQRU/f6h6HEI6KLfAm9Uog
         Cqnnfd7dRqD3lv3zIvUh4On1Al9KwbouB0lG4hCVSDzZ/doGp3hTGhfA2astAVdEAKZZ
         YQweyJGip9zYfYS5vcWaR2FxSSbwHecDzVu8UCtulFasTLckAJ9ypF17z35l8CcPQG4L
         xdhg==
X-Gm-Message-State: ABuFfoi9uCyIOx1IlCUKvs7GVOVZcdeDqAnWpFYuO8reBTF0yh9QLNWw
        Foh+16JYjxDG7teujgiI/wT2BGL5wTc=
X-Google-Smtp-Source: ACcGV61CoALXbwvAPyVz+A/8iw9TbBokrVrsFCb908jx7LZw0DYqIWcmaVoo7P7LVGWFKM31dtYz1Q==
X-Received: by 2002:a62:438f:: with SMTP id l15-v6mr12028806pfi.196.1538059262380;
        Thu, 27 Sep 2018 07:41:02 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:65ac:9fec:cd12:82c1? ([2601:646:c200:7429:65ac:9fec:cd12:82c1])
        by smtp.gmail.com with ESMTPSA id 203-v6sm2898779pgb.14.2018.09.27.07.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 07:41:01 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v14 09/19] x86/mm: x86/sgx: Signal SEGV_SGXERR for #PFs w/ PF_SGX
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <20180927142158.GG8242@linux.intel.com>
Date:   Thu, 27 Sep 2018 07:41:00 -0700
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        nhorman@redhat.com, npmccallum@redhat.com,
        "Ayoun, Serge" <serge.ayoun@intel.com>, shay.katz-zamir@intel.com,
        linux-sgx@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CDE2F14E-97B8-4648-B1F3-4B21703BDDB3@amacapital.net>
References: <20180925130845.9962-10-jarkko.sakkinen@linux.intel.com> <CALCETrVAhiwv+g5fzVO3ZSHZgcQKbeeG8r3HUcXO9k7Gi94NdQ@mail.gmail.com> <20180926173516.GA10920@linux.intel.com> <2D60780F-ADB4-48A4-AB74-15683493D369@amacapital.net> <9835e288-ba98-2f9e-ac73-504db9512bb9@intel.com> <20180926204400.GA11446@linux.intel.com> <b7e14c6e-fc05-93fa-eef9-5e3f06ab4729@intel.com> <CALCETrXByb2UVuZ6AXUeOd8y90NAikbZuvdN3wf_TjHZ+CxNhA@mail.gmail.com> <992b1d6d-cc0f-776f-d938-2a1f7cad52c8@intel.com> <CALCETrXyjRh1sBk1V21iTtjdhiWGCYsHnUNktkJC5xFiZy6c9A@mail.gmail.com> <20180927142158.GG8242@linux.intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 27, 2018, at 7:21 AM, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.=
com> wrote:
>=20
>> On Wed, Sep 26, 2018 at 03:37:45PM -0700, Andy Lutomirski wrote:
>> Yeah.  Maybe like this: > > xorl %eax,%eax > eenter_insn:
>> ENCLU[whatever]
>> eenter_landing_pad:
>> ret
>>=20
>> And the kernel would use the existing vdso2c vdso-symbol-finding
>> mechanism to do the fixup.
>>=20
>>>=20
>>> How would a syscall work, though?  I assume we can't just enter the
>>> enclave from ring0.
>>=20
>> My understanding of how AEX works is a bit vague, but maybe a syscall
>> could reuse the mechanism?  The vDSO approach seems considerably
>> simpler.
>>=20
>> We do need to make sure that a fault that happens on or after return
>> from an AEX event does the right thing.  But I'm still vague on how
>> that works, sigh.
>>=20
>> --Andy
>=20
> Returning from AEX does not differ from any other memory access event so
> AFAIK it should be handled right with the proposed solution already.
> For convenience I think we could have a fixed trampoline for AEX e.g.
> this how it is implemented in the open source LE that I did:
>=20
> sgx_get_token:
>    push    %rbx
>    mov    $0x02, %rax
>    mov    %rsi, %rbx
>    mov    %rdx, %rsi
>    mov    $sgx_async_exit, %rcx
> sgx_async_exit:
>    ENCLU
>    pop    %rbx
>    ret
>=20
> BTW, if I converted the in-kernel LE as a standalone test program, would
> that be useful for basic testing of the series?
>=20
>=20

Definitely. Especially if you stick it in selftests/x86 and make it exit cle=
anly (error code 0) on unsupported hardware.=
