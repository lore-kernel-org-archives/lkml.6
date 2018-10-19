Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA78BECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A472086E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="LsHeM6pA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A472086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeJTBF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 21:05:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35688 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeJTBF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 21:05:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id l17-v6so16743789pff.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 09:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EgIuqaSgojiigZFLuMIWUhWq/pUzvmA1V6mrOexwH88=;
        b=LsHeM6pAGHGaidDL1XhtlxBy3Rdo351Y/XTIO/uZHN5GezLaELDXbXf85VhTetq+4t
         SI16mk+uxOieVnMP2zaaTvRCNTR0F154C0P5Y+NXtCV5/IOg/t1aamJHZOd3NvJaBY83
         sfcnNED1JbTb5RW4FHunWnIYwNRBzT66aLvuZQZ3phs8j3ItGQK72y8vEgBjvmf+PJ9e
         FmsgLXGIf4u1RMgknRG854jaIhBcei2QfiZeD0aqdOOFRcsfl9f5kyC4qUzDNfEYMscp
         Zy+pmQwV30sm1sk4ogfdgnBy5wapslfzThrev1CGpA3s5pZHKEYyWMABf5kMfCYw7Rae
         Lhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EgIuqaSgojiigZFLuMIWUhWq/pUzvmA1V6mrOexwH88=;
        b=dmtknpR/jeyqjnVibqFKYfABuFUipOaEnOOyoynLNcW80iF8eAht2560YfPn9WERUt
         NWYKa9R4VI4CVRFYkp64resrbfl52rpBWHjPVAzLpDlfHZxavJz+rFvVjrDj+ZYY/JNT
         OGv4y0lN963+gxv0WZyBCQ/sszMzz0YAM+o1DaQO+jYv9aubDSUfJut7H8Xx10x0K3g5
         8tBFx8CCwvHUv3wrxgyswsQsrip3wzOi7mTdF7/C5wX4OEFa8T1Ftjtu7y4L6RfUsXpd
         NUJTvnQoEmYVbuvXZf0QAY1VM6/JyTge3Ckrtmv/JLaLPXYjgEHB3JfggORPdYJiQFfv
         PalA==
X-Gm-Message-State: ABuFfoh7sUST9aygC8xGPzuA3NL3oTaqEU+YC9WcIpi9AQ3d73S0QXvZ
        SUgUpiYU++m6B72AaTO/peChXA==
X-Google-Smtp-Source: ACcGV60beFO0WG21jCcfRWTufrgPR1Xa6vqpoNbbkoTk62S0VXR8ZxoUZjLC76ComKsGffiSiOVeVg==
X-Received: by 2002:aa7:8001:: with SMTP id j1-v6mr34897225pfi.73.1539968343461;
        Fri, 19 Oct 2018 09:59:03 -0700 (PDT)
Received: from ?IPv6:2600:1010:b01f:cba8:c05f:3a2c:209d:43f4? ([2600:1010:b01f:cba8:c05f:3a2c:209d:43f4])
        by smtp.gmail.com with ESMTPSA id r23-v6sm26036585pfh.79.2018.10.19.09.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 09:59:02 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 05/11] x86/fpu: set PKRU state for kernel threads
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <2fe82232-4e80-8317-757c-d2235c4633d8@redhat.com>
Date:   Fri, 19 Oct 2018 09:59:00 -0700
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9BAD5065-AA1B-4DEF-A9D4-D7FD9B46667E@amacapital.net>
References: <20181004140547.13014-1-bigeasy@linutronix.de> <20181004140547.13014-6-bigeasy@linutronix.de> <39e0a55f-4920-cfde-9bef-09c51109d211@linux.intel.com> <CALCETrUdxsFA5g0M9uRFktfdi=mxK_g3kBfs-VxwDZ0xWqjFAQ@mail.gmail.com> <20181018162644.qqjkzoqn2fleyi2b@linutronix.de> <CC7B46F7-7A6E-4CAF-A1EB-91271CC7B092@amacapital.net> <20181018182538.vgotfpsdy7qxl2tg@linutronix.de> <CALCETrVjEOkNhdyAF10PaYi_rnFUWKRqPhLRCq3ZV=gxQFETxg@mail.gmail.com> <2fe82232-4e80-8317-757c-d2235c4633d8@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 19, 2018, at 12:44 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 18/10/2018 22:46, Andy Lutomirski wrote:
>>> [0] drivers/usb/gadget/function/f_fs.c::ffs_user_copy_worker()
>>>=20
>>> Sebastian
>> I think we need an entirely new API:
>>=20
>> user_mm_ctx_t ctx =3D user_mm_ctx_get();
>>=20
>> ...
>>=20
>> use_user_mm_ctx(ctx);
>> unuse_user_mm_ctx(ctx);
>>=20
>> ...
>>=20
>> user_mm_ctx_put(ctx);
>>=20
>> and ctx will store a copy of mm and PKRU.
>>=20
>=20
> That looks like a good API in general.  The ffs_user_copy_worker that
> Sebastian mentioned seems to be used by AIO, in which case of course it
> has to happen in a kernel thread.
>=20
> But while the API is good, deciding on the desired semantics is
> "interesting".  The submitting thread might be changing PKRU between the
> time the I/O operation is submitted and the time it is completed, for
> example.

I think there=E2=80=99s only one sensible answer: capture PKRU at the time o=
f submission.=
