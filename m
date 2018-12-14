Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C224C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F3A20643
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WmHAur5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbeLNUNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:13:24 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43276 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbeLNUNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:13:24 -0500
Received: by mail-lf1-f65.google.com with SMTP id u18so5168977lff.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 12:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KqEkWFkAWUVvYJVVihWdKF2X1UUmRvfpRzMIa8xE/f0=;
        b=WmHAur5wUEIB+VBnKyv4hlZRbrrTjUOjMuE2uY0ERLXNjFL8VbHqf2e33XSOYP1CuR
         ZmUgmg1+LIztSsfuPkcs7cDE9KilT2EWhXdNhj/qYOy/1Xc6jc2jCgoOFh8YrR3S+nNn
         g8rXXOxxJvWAw8RSrfmTq15kyRFoM1IwXJAys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KqEkWFkAWUVvYJVVihWdKF2X1UUmRvfpRzMIa8xE/f0=;
        b=sk8rlSPtiOXqTVDoFqooRXJ9KSH+c5ru7vU6V1m3G/DnH2/pRA9EI8jsZEae/7z+ma
         FQc3OwcSQP3iIRicnU004UQ+7iNt2VUDOtEMO8+srn03KCKECz8p88vlEL7Dd+LKBGNr
         6u+38qYONc9WAysDioiFGP7o6bR6bjWH2Q4d9Q4CQO7A9OcTU+SiZruz1sLUfw06fxgE
         czW5ErVb2PUvPQEvjfqTjh461mUz/GUDCfPrC5mQSdqbhVz8GbvcXh7DWiSL8gGfZfvJ
         R4Hddht5OmpVEX5kPvpRkKhTAsM+ssOKJ0vfG6/0l1dbKrCHx7ngZyXI+VwdFPjCBlln
         gTfA==
X-Gm-Message-State: AA+aEWaFXLSYFpLgQVZljM3ouMF0ux05d4jXdYZpWraMq3xqbHqISJgt
        9qkAEffpGpY+y4uNzf/T1e28grrhJD4=
X-Google-Smtp-Source: AFSGD/WJ3uEJLVxTXUPf/dxWs1Yhk4QjhWcdQJhFZkgmXNKxBTinsvfouajTOqRkhr7si3C3effQMA==
X-Received: by 2002:ac2:42c5:: with SMTP id n5mr2520886lfl.115.1544818401774;
        Fri, 14 Dec 2018 12:13:21 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id u21-v6sm1022502lju.46.2018.12.14.12.13.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 12:13:19 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id e26so5191335lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 12:13:18 -0800 (PST)
X-Received: by 2002:a19:982:: with SMTP id 124mr2500991lfj.138.1544818398271;
 Fri, 14 Dec 2018 12:13:18 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <70bb54b2-8ed3-b5ee-c02d-6ef66c4f27eb@physik.fu-berlin.de>
 <20181213160242.GV23599@brightrain.aerifal.cx> <c8987b31-ed79-acef-a300-31ebf2c29d2e@petrovitsch.priv.at>
 <20181214161732.GY23599@brightrain.aerifal.cx> <87mup8gj1y.fsf@oldenburg2.str.redhat.com>
 <20181214165535.GZ23599@brightrain.aerifal.cx> <EC1F028D-4382-41D6-B539-A9662FD53820@amacapital.net>
In-Reply-To: <EC1F028D-4382-41D6-B539-A9662FD53820@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Dec 2018 12:13:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj0ejxYVV1xPfNX5YD6ZakRoSx+wQR==rFoj4J4SzLWhg@mail.gmail.com>
Message-ID: <CAHk-=wj0ejxYVV1xPfNX5YD6ZakRoSx+wQR==rFoj4J4SzLWhg@mail.gmail.com>
Subject: Re: Can we drop upstream Linux x32 support?
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     dalias@libc.org, fweimer@redhat.com, bernd@petrovitsch.priv.at,
        glaubitz@physik.fu-berlin.de, Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, bp@alien8.de,
        vapier@gentoo.org, hjl.tools@gmail.com, x32@buildd.debian.org,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 10:58 AM Andy Lutomirski <luto@amacapital.net> wrot=
e:
>
> Does anyone know *why* Linux=E2=80=99s x32 has __kernel_long_t defined as=
 long long?

It *needs* to be long long, since the headers are used for builds in
user mode using ILP32.

Since __kernel_long_t is a 64-bit (the _kernel_ is not ILP32), you
need to use "long long" when building in ILP32.

Obviously, it could be something like

   #ifdef __KERNEL__
    typedef long __kernel_long_t;
   #else
    typedef long long __kernel_long_t;
   #endif

or similar to make it more obvious what's going on.

Or we could encourage all the uapi header files to always just use
explicit sizing like __u64, but some of the structures really end up
being "kernel long size" for sad historical reasons. Not lovely, but
there we are..

              Linus
