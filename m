Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2606BC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8F320C0A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="iVFEFBTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8F320C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbeI1Ufq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:35:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46449 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1Ufp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:35:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id b129-v6so4547345pga.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3N8yfkIrpBSEevfe1Y2pYDq7wRXxT17HdmFhv74hm7w=;
        b=iVFEFBTRjCrLbF6wB2HQo8GLV0NjohO2/TcepI11PjTXZC5DBQLu0uobBTDwZudPoI
         pDXggnH/G69Eo5UV4LVT95ejcQobIYPLSIzEaXnTSIfI9S8zCmxoG4LbV2P8NO/vjBAQ
         4y9v7uJKM+KJy6ooZpo+Fd1/W+1NO74xzG+a4clTOnR6cg4MxejZdx5mbVdT25yrb+qK
         /z0Eu6sovfo02G0BY0oCtAA2GuO+aHuJX6fmmO2+5pkaLxjeXsRaaXUGz718lQtZ9HPE
         uyLpbdv9rwK7lRhCyqV/EK8u0gM9MsdvLvz59Y3CBD3LVCmHXpc5ncizGBY1FMbMcGF5
         bq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3N8yfkIrpBSEevfe1Y2pYDq7wRXxT17HdmFhv74hm7w=;
        b=fUMWZI15uaNeWm77DJnO5m6eAEKREIiXTLLsLa+YJpPDOG8SUJ7jNSzW7Cs2FVHYPq
         zvHT8a/gXbmY3RHf2nj1c4KWAtQY3bapBD/qU5acZI+ls+/DPpimYPlFdyynnwdA929U
         vWCcuqBT/4jAMy5MnH9Ad9eSm/ZSTujIC3fCeeIF05NSjJXL25OOaxElQ8qKFzMM+SoW
         aGX/gAK67bkRgur+Y2kG1tX2SNn21lCwULrzCQbPezDQE2AcIM3AEANb7wVvdZVdqHls
         qcf+6aiH+DD+/M9EcHSpC6FMS+NdcB2+cDuIMgOQHstUv7d5PX7B+FxC0QG4qdF464tC
         J+OQ==
X-Gm-Message-State: ABuFfoho0CIpiKbHbEgeFfMooZaYRkqzc5oXmCXqn4e3a2u8Dis2s+Ix
        XR+6jFx5dlS27lrWTpxl/gzxKw==
X-Google-Smtp-Source: ACcGV63esjzQrCf9ARjl+1/VyjsXMfcCA8BQXDi/bbIFaaKBlyrpr3y6hm0Z6zxe7bVWpc0plqzo5A==
X-Received: by 2002:a63:db44:: with SMTP id x4-v6mr15397792pgi.285.1538143906695;
        Fri, 28 Sep 2018 07:11:46 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:11d5:3956:df08:f0eb? ([2601:646:c200:7429:11d5:3956:df08:f0eb])
        by smtp.gmail.com with ESMTPSA id f184-v6sm12706825pfc.88.2018.09.28.07.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 07:11:45 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] futex: Set USER_DS for the futex_detect_cmpxchg() test
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <alpine.DEB.2.21.1809281041420.2004@nanos.tec.linutronix.de>
Date:   Fri, 28 Sep 2018 07:11:44 -0700
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Finn Thain <fthain@telegraphics.com.au>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0B38810F-3E22-45A8-9D5D-EDEABD214148@amacapital.net>
References: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org> <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de> <CAMuHMdWWxgvo0a+8UvesiVikWS_45yOXRhM39F31Vn17kN+Ptg@mail.gmail.com> <20180928103726.07761672@mschwideX1> <alpine.DEB.2.21.1809281041420.2004@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 28, 2018, at 1:42 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
>> On Fri, 28 Sep 2018, Martin Schwidefsky wrote:
>> On Fri, 28 Sep 2018 09:12:10 +0200
>> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>> I don't know if that has happened, and whether it would work on s390 now=
.
>>=20
>> commit 03b8c7b623c80af264c4c8d6111e5c6289933666
>> Author: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Date:   Sun Mar 2 13:09:47 2014 +0100
>>=20
>>    futex: Allow architectures to skip futex_atomic_cmpxchg_inatomic() tes=
t
>>=20
>>    If an architecture has futex_atomic_cmpxchg_inatomic() implemented and=
 there
>>    is no runtime check necessary, allow to skip the test within futex_ini=
t().
>>=20
>>    This allows to get rid of some code which would always give the same r=
esult,
>>    and also allows the compiler to optimize a couple of if statements awa=
y.
>>=20
>>    Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
>>    Cc: Finn Thain <fthain@telegraphics.com.au>
>>    Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>>    Link: http://lkml.kernel.org/r/20140302120947.GA3641@osiris
>>    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>=20
>>=20
>> Heiko created the CONFIG_HAVE_FUTEX_CMPXCHG to get around this issue.
>> We just skip the runtime check as well as arc, m68k and sh. Not sure
>> about xtensa, the set it config option only for !MMU.
>=20
> Duh. grep would have told me. -ENOTENOUGHCOFFEE
>=20
>=20

There=E2=80=99s another way to skin this cat: keep KERNEL_DS but pass a vali=
d pointer. I don=E2=80=99t suppose you remember why you didn=E2=80=99t do th=
at?=
