Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF09C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BD82098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="NwcAGVgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BD82098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeJCVJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:09:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36207 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeJCVJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:09:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id y11-v6so419893plt.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 07:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0u7aFXMRCz0LMThvMU6QvhX239Wk/UjHjFvdT9aMSP4=;
        b=NwcAGVgT1cJ0xLmM3bb2P1RzG8Q64n0caQclhHbzqW8HATGr4Dzmsfbm6IEGwSzM4Z
         Wb97E1bRP1rAKgy+IzsEnDdebWXw7dkbrrYk0Qzv7iMpOpxX06qZc7H7D789FvmQExwX
         V4M7wJ9ybfLPtjMPCfjTLs3Ml7nMM5Bz5DKXtrOh1AFcbMxpNbzToK0RuGaF/oMMxsOA
         YFM/fAIyWAJVbee+t48xF46lAWaGYEhb1Na2nBIc/fqo1LrPJ/5BPeYgFKdpcjdEUv08
         NWkz0BCvLfs1WEwJGZDAiBPCLm60QmOixFTMGCMNR+w+nxmTXoEaFvBvPCSbT1W66p7R
         PGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0u7aFXMRCz0LMThvMU6QvhX239Wk/UjHjFvdT9aMSP4=;
        b=B9+kOcCUxQvNbErdnMaYup2qI4TKk4YZa5JZbNE6tM3BcVMJOXkO/GGqGnK5N9mddu
         nyq5nFvF1X71+ZobY6aOXlh1GKbKT6/ukSVZQk0LwJIRYa2leldSWgFTiT1W/xPJtWpW
         ZEQ0BTcmEKAyBcTupv3wtl5J8dA1+BAZzHpapfgq5QiMqzJNjh+G3LS5xp/FFn2hdLE5
         3QULAbpG3ygtIbk3qgFRREovWM1IHqDSLwiAK42l9bYqkAJc1ODXY1APjZQK15k0u6xs
         o99mSb2caiCTKvJuV/8A9e+s1TjyiJRvh+qXbp7rHEYtCQkS2T+OW3ngr8uszKZQ4Kto
         O0PQ==
X-Gm-Message-State: ABuFfoioqrN0MVn9oUZTHpfTtnGO0ZPLeb1CM5LjcuE+TKhJo3akaMZP
        aBCnwEqGyJX11dvyyulOCIYZyQ==
X-Google-Smtp-Source: ACcGV63NiKX0itQ+4idGsJiHj4TNQeI3MQWJj/UudcIyzSYjinDxUNgiHXCTdf7bYXx0IYbRhjpMDQ==
X-Received: by 2002:a17:902:32c3:: with SMTP id z61-v6mr1882966plb.324.1538576450174;
        Wed, 03 Oct 2018 07:20:50 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:4492:ec6e:54db:bcc9? ([2601:646:c200:7429:4492:ec6e:54db:bcc9])
        by smtp.gmail.com with ESMTPSA id d7-v6sm6453796pfm.23.2018.10.03.07.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 07:20:48 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI support
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <87murvdysd.fsf@vitty.brq.redhat.com>
Date:   Wed, 3 Oct 2018 07:20:48 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        devel@linuxdriverproject.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8C316427-8BEC-4979-8AB2-5E385066BB6F@amacapital.net>
References: <20180914125006.349747096@linutronix.de> <CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com> <87sh1ne64t.fsf@vitty.brq.redhat.com> <4B6A97E1-17E6-40F2-A7A0-87731668A07C@amacapital.net> <87murvdysd.fsf@vitty.brq.redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 3, 2018, at 5:01 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>=20
> Andy Lutomirski <luto@amacapital.net> writes:
>=20
>>> On Oct 3, 2018, at 2:22 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote=
:
>>>=20
>>> Andy Lutomirski <luto@kernel.org> writes:
>>>=20
>>>> Hi Vitaly, Paolo, Radim, etc.,
>>>>=20
>>> The notification you're talking about exists, it is called
>>> Reenligntenment, see 0092e4346f49 "x86/kvm: Support Hyper-V
>>> reenlightenment"). When TSC page changes (and this only happens when L1
>>> is migrated to a different host with a different TSC frequency and TSC
>>> scaling is not supported by the CPU) we receive an interrupt in L1 (at
>>> this moment all TSC accesses are emulated which guarantees the
>>> correctness of the readings), pause all L2 guests, update their kvmclock=

>>> structures with new data (we already know the new TSC frequency) and
>>> then tell L0 that we're done and it can stop emulating TSC accesses.
>>=20
>> That=E2=80=99s delightful!  Does the emulation magic also work for L1 use=
r
>> mode?
>=20
> As far as I understand - yes, all rdtsc* calls will trap into L0.
>=20
>> If so, couldn=E2=80=99t we drop the HyperV vclock entirely and just
>> fold the adjustment into the core timekeeping data?  (Preferably the
>> actual core data, which would require core changes, but it could
>> plausibly be done in arch code, too.)
>=20
> Not all Hyper-V hosts support reenlightenment notifications (and, if I'm
> not mistaken, you need to enable nesting for the VM to get the feature -
> and most VMs don't have this) so I think we'll have to keep Hyper-V
> vclock for the time being.
>=20
>=20

But this does suggest that the correct way to pass a clock through to an L2 g=
uest where L0 is HV is to make L1 use the =E2=80=9Ctsc=E2=80=9D clock and L2=
 use kvmclock (or something newer and better).  This would require adding su=
pport for atomic frequency changes all the way through the timekeeping and a=
rch code.

John, tglx, would that be okay or crazy?=
