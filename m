Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEAFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D1B214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="LWLRMLEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D1B214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeKVFBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:01:39 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51383 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeKVFBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:01:39 -0500
Received: by mail-it1-f194.google.com with SMTP id x19so10346228itl.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 10:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ebioLp4ic9tMdxQIR9aEXri8te0F+96neNj4gXWYDP0=;
        b=LWLRMLEHe0fvuBu5kOziGTBLQKbvwco7PqMfTS+g04VaLvvK2pKBwlKHchxPr5+HmZ
         68y2vhgUFMBeTJN3maWvzW4FdSvedkhxhlPAXCuU8H+z/wHmEdBg1e97qA8VxjtZJd/B
         AGg8Vzo2CIDZI8zMTniwGjkvWGWTVXVcFsH9RD/acXQeLFiERQqkVCsgXUJHiQe2G8KG
         ts3exwR5Z9NbvxUCpU2FXv3l7RscSqLyNEpWQoOk6WTxhbZqRkBKQIeIdA6LshvBmCuF
         d0TCMj8FSyuYDq+pLqLJtLYwuJj01f12Jx2MSMBZlpWjjGPyuNOvpkMmkDzRKb1cZjbb
         c8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ebioLp4ic9tMdxQIR9aEXri8te0F+96neNj4gXWYDP0=;
        b=dg3c2pqIZZ0nJ0jd3tJveTje2ymcfiB3ECCCMCN19uliDozgDrFupmNfgynWjcZovc
         98uBEaIOm83pJMFY5U4dQm8FwL2zOw65E45g2sEqH9PiXkqJiQcXbDt6TmaLqjPaAo2j
         u8k6Rwj4F+Z17UzUHUXgeYtK5/EUHo2LeKdYkWPv3MnfpRJdGINwGO3843JrlEdtWoec
         Ma09BvbAGmROpA+VmammP7qIDHxn13TniYWSTslGYAERGJVqlzJQKzNHtBnU2a8ysn2q
         4lira71QyiHI4wEn38dn6QJBttOP5LQrMyA/g0+6dBVz7ip0uCQGE1Gv0haNT2clBfIZ
         ZGLA==
X-Gm-Message-State: AA+aEWahDJF0FcLSiBkGVMYWr7IXSqiC11UqJyLuynxQFEpcHAl5lwBq
        gUt9fx0ebK8Enk41+wb5vR3vyw==
X-Google-Smtp-Source: AFSGD/XCWSihHoY/v2RU8Jii/ibCTj+Zg+hLQwptV6dnRjyqWkMJccNnzrTN+zORaVaMWGPk+3dZ3w==
X-Received: by 2002:a02:b697:: with SMTP id i23mr6548339jam.119.1542824772214;
        Wed, 21 Nov 2018 10:26:12 -0800 (PST)
Received: from ?IPv6:2600:100e:b040:b126:ec78:48dd:44e2:e165? ([2600:100e:b040:b126:ec78:48dd:44e2:e165])
        by smtp.gmail.com with ESMTPSA id f7-v6sm14510477iog.30.2018.11.21.10.26.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 10:26:11 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <658cdb28-e3e5-c0af-368f-c26daf9986ac@kernel.dk>
Date:   Wed, 21 Nov 2018 11:26:09 -0700
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, pabeni@redhat.com,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, dvlasenk@redhat.com,
        brgerst@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E7DFB44-8A2A-48CF-972E-6CB5122CCA20@amacapital.net>
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk> <20181121063609.GA109082@gmail.com> <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk> <1c22125bb5d22c2dcd686d0d3b390f115894f746.camel@redhat.com> <CAHk-=wgnjB+=o0771=J_YkQzabU5aadh6pN3x9Vk4HPs3MHL3g@mail.gmail.com> <658cdb28-e3e5-c0af-368f-c26daf9986ac@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>, dave.hansen@intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 21, 2018, at 11:04 AM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
>> On 11/21/18 10:27 AM, Linus Torvalds wrote:
>>> On Wed, Nov 21, 2018 at 5:45 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>>=20
>>> In my experiments 64 bytes was the break even point for all the CPUs I
>>> had handy, but I guess that may change with other models.
>>=20
>> Note that experiments with memcpy speed are almost invariably broken.
>> microbenchmarks don't show the impact of I$, but they also don't show
>> the impact of _behavior_.
>>=20
>> For example, there might be things like "repeat strings do cacheline
>> optimizations" that end up meaning that cachelines stay in L2, for
>> example, and are never brought into L1. That can be a really good
>> thing, but it can also mean that now the result isn't as close to the
>> CPU, and the subsequent use of the cacheline can be costlier.
>=20
> Totally agree, which is why all my testing was NOT microbenchmarking.
>=20
>> I say "go for upping the limit to 128 bytes".
>=20
> See below...
>=20
>> That said, if the aio user copy is _so_ critical that it's this
>> noticeable, there may be other issues. Sometimes _real_ cost of small
>> user copies is often the STAC/CLAC, more so than the "rep movs".
>>=20
>> It would be interesting to know exactly which copy it is that matters
>> so much...  *inlining* the erms case might show that nicely in
>> profiles.
>=20
> Oh I totally agree, which is why I since went a different route. The
> copy that matters is the copy_from_user() of the iocb, which is 64
> bytes. Even for 4k IOs, copying 64b per IO is somewhat counter
> productive for O_DIRECT.

Can we maybe use this as an excuse to ask for some reasonable instructions t=
o access user memory?  Intel already did all the dirty work of giving someth=
ing resembling sane semantics for the kernel doing a user-privileged access w=
ith WRUSS.  How about WRUSER, RDUSER, and maybe even the REP variants?  And I=
 suppose LOCK CMPXCHGUSER.

Or Intel could try to make STAC and CLAC be genuinely fast (0 or 1 cycles an=
d no stalls *ought* to be possible if it were handled in the front end, as l=
ong as there aren=E2=80=99t any PUSHF or POPF instructions in the pipeline).=
  As it stands, I assume that both instructions prevent any following memory=
 accesses from starting until they retire, and they might even be nastily mi=
crocoded to handle the overloading of AC.
