Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE1FC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 04:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1BD42098A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 04:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HGptZyOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BD42098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeJBKlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 06:41:44 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:37685 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbeJBKln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 06:41:43 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 0febcb99;
        Tue, 2 Oct 2018 04:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type:content-transfer-encoding; s=mail; bh=6+otpgUArBWY
        RR44p0ZEL5TsnsQ=; b=HGptZyOANAXtkyV7TjIplI/5PR0I1Z9mD9VEwr/nozqu
        KatYCXJsc3E6ijcp7soruhKZz3MsCHzbW5Nd5BaHSHaWmCkaBXxd0g/HPdJO7WXd
        IZvseECPHVFD4qTGxVnGvM0kJENvmqiK9ak0Il2/cDCWVrFhx0sGltI9xVsYge3V
        3gKNoJyuiHoxLuyyrankIIQzDju0pGp2tEhF6GeHIB8bxVaKlC/I1Zlkf67Db15c
        Ro6CPgwENuGBzdrNllO0POQbPztqJ1lYF3zx/ZPrqBc8m8n8AS0zJVWSMNV7EfVc
        mTKfazUtTYVq3cdDYgl9L7nVwPcH3J5Wt3tNKXpj5g==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3d9cd7ce (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 2 Oct 2018 04:00:34 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id c20-v6so563989otl.6;
        Mon, 01 Oct 2018 21:00:35 -0700 (PDT)
X-Gm-Message-State: ABuFfohj8hdCZo7kSbkzzjFH1c6t/0fbVOTROqThrZctSl60CDc64lBA
        jzOZux+TXTXWeVOmJezjEbmc7g4bYiSablXoZxw=
X-Google-Smtp-Source: ACcGV62uuwkslL2JDTFhpDLGtu6bArahFy9wbWZN8VYmvbZNqC050egT3Wj/EWMCpDN0YWYLMrhKTD3TBdLguzJFCJw=
X-Received: by 2002:a9d:17d0:: with SMTP id j74-v6mr4813928otj.268.1538358216583;
 Sun, 30 Sep 2018 18:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-2-Jason@zx2c4.com>
 <CAKv+Gu9e35+AyktmSq9qeNE0LR83_yrEEB3DiQv0bmyArivqRQ@mail.gmail.com>
 <CAKv+Gu9kbLPZH4W0zKAfuv-b11mcDaZ05HUauvh9gMZVGVR0AQ@mail.gmail.com>
 <CAHmME9pfs0_MsD9QAGfSm31_w-=6BCF_gZO04XkfhD=mEoZmtQ@mail.gmail.com>
 <CAKv+Gu__7mZFFq6qC=8yh0OuaV+TCCLFt6nm8yJfaANHUPrJ=A@mail.gmail.com>
 <CAHmME9owF+3aQaZUkK4KkfnJna+DK=GoWV8yf-Wb+gH4w3y9eg@mail.gmail.com>
 <CAKv+Gu9FAVVOiYyGovYZ19-107_6sK9Ya6LnK=AQkTgctMmu5A@mail.gmail.com>
 <CAHmME9rqsOid6UOx+VTsFzJLEiaXpTP_z_wvHC6MbeAQUeEtHg@mail.gmail.com>
 <8afdd3b1c51587708db6ae878eb0a7e9f8b5673a.camel@perches.com> <3E9E1888-026E-45C1-8AA7-DADA211EDBDF@amacapital.net>
In-Reply-To: <3E9E1888-026E-45C1-8AA7-DADA211EDBDF@amacapital.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 1 Oct 2018 03:43:25 +0200
X-Gmail-Original-Message-ID: <CAHmME9o7_Xh=dZfnEHbPCJdqzXW1L5R7qjg=_sqPZiP2KmTc1Q@mail.gmail.com>
Message-ID: <CAHmME9o7_Xh=dZfnEHbPCJdqzXW1L5R7qjg=_sqPZiP2KmTc1Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 01/23] asm: simd context helper API
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Joe Perches <joe@perches.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 7:35 AM Andy Lutomirski <luto@amacapital.net> wrote=
:
> >>>>>>> Oh, and another thing (and I'm surprised checkpatch.pl didn't com=
plain
> >>>>>>> about it): the use of typedef in new code is strongly discouraged=
.
> >>>>>>> This policy predates my involvement, so perhaps Joe can elaborate=
 on
> >>>>>>> the rationale?
> >>>>>>
> >>>>>> In case it matters, the motivation for making this a typedef is I
> >>>>>> could imagine this at some point turning into a more complicated
> >>>>>> struct on certain platforms and that would make refactoring easier=
. I
> >>>>>> could just make it `struct simd_context` now with 1 member though.=
..
> >>>>>
> >>>>> Yes that makes sense
> >>>>
> >>>> The rationale for it being a typedef or moving to a struct now?
> >>>
> >>> Yes just switch to a struct.
> >>
> >> Okay. No problem with that, but will wait to hear from Joe first.
> >
> > Why do you need to hear from me again?
> >
> > As far as I know, the only info about typedef avoidance are in
> > Documentation/process/coding-style.rst section 5.
> >
> >
>
> I personally prefer it with the typedef. If this were my code, I=E2=80=99=
d say the coding style is silly for opaque tiny structs like this.

I'll stick with a typedef. Reading the style guide, this clearly falls
into 5.a, 5.b, and maybe 5.c. For 5.a, at some point this will
possibly contain architecture specific blobs. For 5.b, it is just an
enum (integer) right now.
