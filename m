Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C2BC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 05:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542F720684
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 05:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Sx5NVzGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542F720684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeI3MGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 08:06:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37149 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbeI3MGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 08:06:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id c10-v6so7220064pgq.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 22:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Hw+rj1N66K7gBqIRzOZfOiGRZHP8ByIeOFODJa3Dv6k=;
        b=Sx5NVzGt6GiPfpjQ88JFxxouvBfqnuuggtB/I2eB/J170Tu4Buo8+8lNLlXXY3LWfO
         dAtX1iEez9Cza6Pah+fFXlJVcvMLzJRhwMuB1+mdyUQmgH5nkI3IEUWM52jL8x2KjBgo
         pjN9sJSvoWML373dhrZ5UhWX+Jcr7/yGPWyOMbS0ZmgHIx/rpDOQwIGzRiM1GcoBWGyE
         vI4W00PWBJG+rj1FdSC7ipV2zZMduqDcOJWwlU7vU5xtjTgUXMUa2Vy31r3d+wiMLTgP
         bMZTZhhMbISKDs1DGQzeMhrxc/Jwfd1o6ol9pSYG56WREciU1frY4LO/caJvf7fL0YYM
         SyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Hw+rj1N66K7gBqIRzOZfOiGRZHP8ByIeOFODJa3Dv6k=;
        b=Be7sp5wmv3TDj2/OPyka9+0Wza1eGRvHRZNDOk+8iELsjlI9OWf0NmdN6q62CFPmWh
         x0rQ47TZrU1Vex3lUQf2FN1mI8i2zZFpj8RjPIfxhzB0PM3H32qWwr6wL2DamTQtGiXY
         UXxB3QTsXwWw9n1xbBT5AZRaigD/3Qs3q16J1J2Jtp63ycT2jWizgM+hkurcVvgTKVIa
         LHTXT6+UL7gUMdzMhvogJDpPXvs/Bt1VlBNVsFJJv0+amiZQiugcF2+ECxwtG8JYSU5H
         pCbHhXo7w6CapcQiSUyDpQ/XyMn1xcvjmXqQcshJKkR/kSqgXoZqbaJIH5Mq+CGh7mlW
         CUcg==
X-Gm-Message-State: ABuFfogNDnc6m0Myv6jqI5h7STBbGxWItXXriH883ABf4cOX03MjH96g
        69HVI6kYtQSkroxpqEmAs/Bzdg==
X-Google-Smtp-Source: ACcGV63hh3wVobeZNuuEKiZOywqv/DI4+O8xDXSU0CzdEqjdx/qYRZiVXYFZS4uMgga0PfsnLEhf8Q==
X-Received: by 2002:a17:902:6909:: with SMTP id j9-v6mr5811474plk.196.1538285716552;
        Sat, 29 Sep 2018 22:35:16 -0700 (PDT)
Received: from ?IPv6:2600:1010:b029:4fc8:d7f:8889:342e:40b? ([2600:1010:b029:4fc8:d7f:8889:342e:40b])
        by smtp.gmail.com with ESMTPSA id 22-v6sm14377964pfl.126.2018.09.29.22.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 22:35:14 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net-next v6 01/23] asm: simd context helper API
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <8afdd3b1c51587708db6ae878eb0a7e9f8b5673a.camel@perches.com>
Date:   Sat, 29 Sep 2018 22:35:13 -0700
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <3E9E1888-026E-45C1-8AA7-DADA211EDBDF@amacapital.net>
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-2-Jason@zx2c4.com> <CAKv+Gu9e35+AyktmSq9qeNE0LR83_yrEEB3DiQv0bmyArivqRQ@mail.gmail.com> <CAKv+Gu9kbLPZH4W0zKAfuv-b11mcDaZ05HUauvh9gMZVGVR0AQ@mail.gmail.com> <CAHmME9pfs0_MsD9QAGfSm31_w-=6BCF_gZO04XkfhD=mEoZmtQ@mail.gmail.com> <CAKv+Gu__7mZFFq6qC=8yh0OuaV+TCCLFt6nm8yJfaANHUPrJ=A@mail.gmail.com> <CAHmME9owF+3aQaZUkK4KkfnJna+DK=GoWV8yf-Wb+gH4w3y9eg@mail.gmail.com> <CAKv+Gu9FAVVOiYyGovYZ19-107_6sK9Ya6LnK=AQkTgctMmu5A@mail.gmail.com> <CAHmME9rqsOid6UOx+VTsFzJLEiaXpTP_z_wvHC6MbeAQUeEtHg@mail.gmail.com> <8afdd3b1c51587708db6ae878eb0a7e9f8b5673a.camel@perches.com>
To:     Joe Perches <joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 29, 2018, at 9:20 PM, Joe Perches <joe@perches.com> wrote:
>=20
>> On Fri, 2018-09-28 at 16:01 +0200, Jason A. Donenfeld wrote:
>> On Fri, Sep 28, 2018 at 4:00 PM Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>>=20
>>>> On 28 September 2018 at 15:59, Jason A. Donenfeld <Jason@zx2c4.com> wro=
te:
>>>> On Fri, Sep 28, 2018 at 3:58 PM Ard Biesheuvel
>>>> <ard.biesheuvel@linaro.org> wrote:
>>>>>=20
>>>>>> On 28 September 2018 at 15:47, Jason A. Donenfeld <Jason@zx2c4.com> w=
rote:
>>>>>> On Fri, Sep 28, 2018 at 10:49 AM Ard Biesheuvel
>>>>>> <ard.biesheuvel@linaro.org> wrote:
>>>>>>>>> +typedef enum {
>>>>>>>>> +       HAVE_NO_SIMD =3D 1 << 0,
>>>>>>>>> +       HAVE_FULL_SIMD =3D 1 << 1,
>>>>>>>>> +       HAVE_SIMD_IN_USE =3D 1 << 31
>>>>>>>>> +} simd_context_t;
>>>>>>>>> +
>>>>>>>=20
>>>>>>> Oh, and another thing (and I'm surprised checkpatch.pl didn't compla=
in
>>>>>>> about it): the use of typedef in new code is strongly discouraged.
>>>>>>> This policy predates my involvement, so perhaps Joe can elaborate on=

>>>>>>> the rationale?
>>>>>>=20
>>>>>> In case it matters, the motivation for making this a typedef is I
>>>>>> could imagine this at some point turning into a more complicated
>>>>>> struct on certain platforms and that would make refactoring easier. I=

>>>>>> could just make it `struct simd_context` now with 1 member though...
>>>>>=20
>>>>> Yes that makes sense
>>>>=20
>>>> The rationale for it being a typedef or moving to a struct now?
>>>=20
>>> Yes just switch to a struct.
>>=20
>> Okay. No problem with that, but will wait to hear from Joe first.
>=20
> Why do you need to hear from me again?
>=20
> As far as I know, the only info about typedef avoidance are in
> Documentation/process/coding-style.rst section 5.
>=20
>=20

I personally prefer it with the typedef. If this were my code, I=E2=80=99d s=
ay the coding style is silly for opaque tiny structs like this.=
