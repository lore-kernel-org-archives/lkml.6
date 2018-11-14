Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929DEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5742222419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ARN1IqqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5742222419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732795AbeKOAuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 19:50:22 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44856 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731585AbeKOAuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 19:50:22 -0500
Received: by mail-pf1-f195.google.com with SMTP id b81-v6so7528814pfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 06:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=W3sFTVqoMCN6K1QTPVzp8weQHt0OD13B9CzH5+cV9rA=;
        b=ARN1IqqYwdF61QrSyGZ5ifwSV3G4N/df/dIGnKa7oQrvHw1kRkgQ1deHujgA6g6IUV
         7VkM3td68ptd1r1SSpGaD4hUOVzkPbf2AACNbvpSuDuVCK4VzYSg9I5X1+JSloRiHDdT
         0QGINTM7KWRk+T6LTX2Z1poMgFRvJPSEeNO3cI9zoqNN9JuF/xkjYFXg6JjhSEdHPCGL
         oXHs6/LbXbo/kj6ARrN9LdOpK2ur+2Y7NABQpGaDbuVZ2gLAGcNCaAgtZ/JSyAPVk/b+
         FBQUayH7gKK1IFgaAel59tHG/5G3wwofTjlJbkZz0O22WUrJsZV5EGyW543xlEBgpoC6
         TccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=W3sFTVqoMCN6K1QTPVzp8weQHt0OD13B9CzH5+cV9rA=;
        b=BXx92AkyaMx0Gayw2hwdn/NLl8X4ZleN1TwscWcO4FrLwFWjiKKNMScB2UYb6bI9+X
         IlNeBpJLh7YkVYXbEyD5yDVC3tFu93E+8/DtxbyIcDnrHPkzS/X8WRfh3YbtYEcWpzsC
         TUNyHh7C3wnVrXYl0MAsYgsMHGvwprNMxKHo7wsXrDHExY2yMsjsdhvxISm1AHoeeYUB
         fYhDAusdNll59NF4yzmytXbj4JWOzbml/YDNUvbXMDhRnV36CC/MeGL8KDI2vseB2Gj2
         TldjsnJQ4MzBKkZRpxXU0m+PlV1fQb3PzVVbBrx0XQMnexjpus0qIPXH7mn6YQW1NZnz
         Exkw==
X-Gm-Message-State: AGRZ1gKxZn3rpK+37wkDViGhteMx1g2QQHe1qi0Brs08JMSFG4PHGIr3
        2VMhHjD9tvj1xBmAYAcrGGVW9Q==
X-Google-Smtp-Source: AJdET5c3aC4XCdfrwiKO9vtT7QnQ4K7bNDTLN1spKSGX63rdrpc615WXqTbcC+kawfwskSsWzSQCVA==
X-Received: by 2002:a63:9b11:: with SMTP id r17mr2021249pgd.416.1542206810165;
        Wed, 14 Nov 2018 06:46:50 -0800 (PST)
Received: from ?IPv6:2600:1012:b00f:2d6f:bc21:1d37:c350:a8ba? ([2600:1012:b00f:2d6f:bc21:1d37:c350:a8ba])
        by smtp.gmail.com with ESMTPSA id u6sm24530364pgr.79.2018.11.14.06.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 06:46:48 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Official Linux system wrapper library?
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <5853c297-9d84-86e5-dede-aa2957562c6b@arm.com>
Date:   Wed, 14 Nov 2018 06:46:47 -0800
Cc:     Dave P Martin <Dave.Martin@arm.com>,
        Daniel Colascione <dancol@google.com>, nd <nd@arm.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1C1B38FC-1266-4A91-B8F6-20A0C49ED1E2@amacapital.net>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com> <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com> <877ehjx447.fsf@oldenburg.str.redhat.com> <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com> <875zx2vhpd.fsf@oldenburg.str.redhat.com> <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com> <20181113193859.GJ3505@e103592.cambridge.arm.com> <5853c297-9d84-86e5-dede-aa2957562c6b@arm.com>
To:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> On Nov 14, 2018, at 3:58 AM, Szabolcs Nagy <Szabolcs.Nagy@arm.com> wrote:
>=20
>> On 13/11/18 19:39, Dave Martin wrote:
>>> On Mon, Nov 12, 2018 at 05:19:14AM -0800, Daniel Colascione wrote:
>>> We should adopt a similar approach. Shipping a lower-level
>>> "liblinux.so" tightly bound to the kernel would not only let the
>>> kernel bypass glibc's "editorial discretion" in exposing new
>>> facilities to userspace, but would also allow for tighter user-kernel
>>> integration that one can achieve with a simplistic syscall(2)-style
>>> escape hatch. (For example, for a long time now, I've wanted to go
>>> beyond POSIX and improve the system's signal handling API, and this
>>> improvement requires userspace cooperation.) The vdso is probably too
>>> small and simplistic to serve in this role; I'd want a real library.
>>=20
>> Can you expand on your reasoning here?
>=20
> such lib creates a useless abi+api layer that
> somebody has to maintain and document (with or
> without vdso).

I=E2=80=99m not so sure it=E2=80=99s useless. Historically, POSIX systems ha=
ve, in practice and almost by definition, been very C focused, but the world=
 is changing. A less crufty library could be useful for newer languages:

>=20
> it obviously cannot work together with a posix
> conform libc implementation for which it would
> require knowledge about
>=20
> thread cancellation internals,

Thread cancellation is a big mess, and we only really need to support it bec=
ause on legacy code. The whole mechanism should IMO be considered extremely d=
eprecated.

> potentially TLS
> for errno,

errno is IMO a libc thing, full stop. A lower level library should *not* sup=
port errno.

> know libc types even ones that are
> based on compile time feature macros (and expose
> them in headers in a way that does not collide
> with libc headers),

This one is tricky. I wonder if we could instead get a C compiler extension t=
o set libc declare that a given struct is a layout-compatible variant of ano=
ther.

> abi variants the libc supports
> (e.g. softfp, security hardened abi),

Hmm.

> libc
> internal signals (for anything that's changing
> signal masks),

This is nasty, but see my cancellation comment above.

> thread internals for syscalls that
> require coordination between all user created
> threads (setxid),

We should just deal with this in the kernel. The current state of affairs is=
 nuts.

> libc internal state for syscalls
> that create/destroy threads.

I disagree. If you make or destroy threads behind libc=E2=80=99s back, I thi=
nk you get to keep both pieces.

