Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94C1C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A257E2152C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="G2fPxZNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A257E2152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbeIZWfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:35:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40998 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeIZWfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:35:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id m77-v6so4975943pfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IItGuF9Cd6xIR7yEn1bw/RTknS2eJDnbTUJYwwXhwDI=;
        b=G2fPxZNz6ir7ab/bXLz5shQfyXpggsEI1j6RxPBgrFfibLosh/+86haXoZ2nmxgV8G
         Cw70WDJgOXL+Z/wHBgrG4drJOqUoXn6Et+20RkzR4waXnpEKhjz9BFrPHsi/u85LLOha
         UWYJNIePnJIgbqhmRO5Ts4RdANfCdeVIPlzqrpSbtrHBATIZTz5RZ2VvSmhVfzdoS7yF
         DQs3NY/xfmVG/lGfcaRb0IOkkDCkrfSSriL/ymhd+59RD1C9galuv1lYokaEs7z/N/OQ
         QsxJCM8R4tZtbi2x9aQNdtd+hD/IEl3jdsjqSp5Ls3Xt3+g4yeYEH3PE679JDKjeGHiN
         HKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IItGuF9Cd6xIR7yEn1bw/RTknS2eJDnbTUJYwwXhwDI=;
        b=Dn0cKlVhknVIEvOTKc/hzddcgacJk79b+NJfK1NUf6HJxed9rZBJHDCYSTD23RrKFH
         GmlAQx7jlF2Et255uQMUAaohwYCQg09CNZC2UlCR2wkYcmEFxQKjUkU7qzDZxaWVTmnE
         Ft58+txi2IRxb0WnwXFPsb74xPpy/+rdZInjiez/QtSjLwB6UlAKL0KxhDU5RxNVy/zD
         9ng9TBWUx+LIycQuT+DfTn5hizegZ4YfLpktWV2YQyL5xgS2gunRQQcLyHmdsignHzpQ
         mXjJdUDgtoVa6uhXP7kr2PGw0Y3hvnCp5VLhsnLqMqFDRrxIorDERkcHv4AdT7AH5Fb+
         P6Hg==
X-Gm-Message-State: ABuFfoh6y3OC3ci0h/+DZ2LUOfCWD2uJnL/mtX7vdnHhvtmC0n/boF5f
        9P6wrfSCK4uOHOWyC0NiwG02SA==
X-Google-Smtp-Source: ACcGV63Ajv0t2W0EWPREEa+78y1EIExCvQ/w2zwVy5HD/ET6VBjI5uFIIjtZa5xiw8OgIfBrXjmoaA==
X-Received: by 2002:a62:7885:: with SMTP id t127-v6mr7091641pfc.6.1537978885682;
        Wed, 26 Sep 2018 09:21:25 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:583:1c0b:7305:80fc? ([2601:646:c200:7429:583:1c0b:7305:80fc])
        by smtp.gmail.com with ESMTPSA id a1-v6sm9643049pfc.28.2018.09.26.09.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 09:21:24 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64 implementations
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
Date:   Wed, 26 Sep 2018 09:21:23 -0700
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D93C2C15-DC70-4A95-9350-AD4036C9556A@amacapital.net>
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-8-Jason@zx2c4.com> <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com> <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com> <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 26, 2018, at 7:02 AM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wr=
ote:
>=20
> (+ Herbert, Thomas)
>=20
>> On Wed, 26 Sep 2018 at 15:33, Jason A. Donenfeld <Jason@zx2c4.com> wrote:=

>>=20
>> Hi Ard,
>> .
>=20
>> And if it becomes one,
>> this is something we can address *later*, but certainly there's no use
>> of adding additional complexity to the initial patchset to do this
>> now.
>>=20
>=20
> You are introducing a very useful SIMD abstraction, but it lets code
> run with preemption disabled for unbounded amounts of time, and so now
> is the time to ensure we get it right.
>=20
> Part of the [justified] criticism on the current state of the crypto
> API is on its complexity, and so I don't think it makes sense to keep
> it simple now and add the complexity later (and the same concern
> applies to async support btw).

Are, is what you=E2=80=99re saying that the Zinc chacha20 functions should c=
all simd_relax() every n bytes automatically for some reasonable value of n?=
  If so, seems sensible, except that some care might be needed to make sure t=
hey interact with preemption correctly.

What I mean is: the public Zinc entry points should either be callable in an=
 atomic context or they should not be.  I think this should be checked at ru=
ntime in an appropriate place with an __might_sleep or similar.  Or simd_rel=
ax should learn to *not* schedule if the result of preempt_enable() leaves i=
t atomic. (And the latter needs to be done in a way that works even on non-p=
reempt kernels, and I don=E2=80=99t remember whether that=E2=80=99s possible=
.). And this should happen regardless of how many bytes are processed. IOW, c=
alling into Zinc should be equally not atomic-safe for 100 bytes and for 10 M=
B.

As for async, ISTM a really good WireGuard accelerator would expose a differ=
ent interface than crypto API supports, and it probably makes sense to wait f=
or such hardware to show up before figuring out how to use it.  And no matte=
r what form it takes, I don=E2=80=99t think it should complicate the basic Z=
inc crypto entry points.=
