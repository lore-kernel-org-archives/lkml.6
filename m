Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C642CC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890B92084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="EJivZJHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890B92084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbeJEWHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:07:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34581 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeJEWHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:07:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id g12-v6so4888542pgs.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 08:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=alDE5Hfszt+ScKCD3O8u014AQQo/tXWyhSxaRXEN6Ok=;
        b=EJivZJHyA5UUFgWMSowXL2LfrP1RKeHAoJS+LjY0JkvqHRZHu47bN7GLA+X3Pyh/Pp
         uGqX9EROhLmH6wI8LWSqODJgJMe387TJqgq9vUHti3BSgbhI3nUkpAkecJIVsTtrbDbX
         bynb5vA2ByZWlbUQJSlzFQiH4jz4oyd9n7rFSfjjP8XH7H1IRWg9muqJYanUnQch6Pqg
         cIvci/cf1oUT9FijZ0jU7cCUtAsmB2McZetaQT8tVTMdVwYMf2DWgxuSV3nPKSQuxbT2
         sJ3duHEbE8fefCH/G5ZpIE/eorKz7m51r0SjWSQqPiuNB7DtSfC6y/QJQ4V5l2OYDAbk
         a6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=alDE5Hfszt+ScKCD3O8u014AQQo/tXWyhSxaRXEN6Ok=;
        b=MZBpiWf9XIAgH4c10Ira/ploO0thPYpr89L3fgY106kH34sswi04B+LFjQeQfMQ0rt
         1NOoSbnh2q1ghep7pxnPOJPEvSzUta9EvjH+/cFpKo56XYxKp9f2VfgnAYClWS/nacLD
         FT9+NU/1D3cYayj09x3dk9UkhAXVYDSWMYpgzYF2ryfwz1/iLqLN9t4Pg9VCWJSePsez
         pmmfsBMgxPAbsFmmKXpSWGsTuda4LGm+6tRcXOPwyObYup2T+WEOK0yzjrJaOtJImEKa
         g6RsLnQ1zMh78oICl7A6tLgyQHoESrq3fxoGNgsalgGFFgQVzknEKD31ZZ243y+QVaSE
         wqHA==
X-Gm-Message-State: ABuFfohIuSzT2GNOgsGAfQf/VPhQ3aXO3q/Rj4fat7EGCeAZBv9eReSE
        3tAY/7YzTz/X2nVBMmoi3oi6J9tsQ9Y=
X-Google-Smtp-Source: ACcGV61oFol6DB+3pV0XWXDGXdkyjNx6hoBZ/3VrUbUTilciFnn58ROyk4r4Mj9ywTfuiJqpiBqF9w==
X-Received: by 2002:a62:18a:: with SMTP id 132-v6mr12403308pfb.207.1538752090767;
        Fri, 05 Oct 2018 08:08:10 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:d01e:eb5d:f949:e221? ([2601:646:c200:7429:d01e:eb5d:f949:e221])
        by smtp.gmail.com with ESMTPSA id v63-v6sm9761718pgd.69.2018.10.05.08.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 08:08:09 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 1/9] kernel: add support for patchable function pointers
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <20181005141433.GS19272@hirez.programming.kicks-ass.net>
Date:   Fri, 5 Oct 2018 08:08:08 -0700
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E0E08C8-0DFC-4E50-A4FA-73208835EF9E@amacapital.net>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org> <20181005081333.15018-2-ard.biesheuvel@linaro.org> <20181005141433.GS19272@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 5, 2018, at 7:14 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Fri, Oct 05, 2018 at 10:13:25AM +0200, Ard Biesheuvel wrote:
>> diff --git a/include/linux/ffp.h b/include/linux/ffp.h
>> new file mode 100644
>> index 000000000000..8fc3b4c9b38f
>> --- /dev/null
>> +++ b/include/linux/ffp.h
>> @@ -0,0 +1,43 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef __LINUX_FFP_H
>> +#define __LINUX_FFP_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/compiler.h>
>> +
>> +#ifdef CONFIG_HAVE_ARCH_FFP
>> +#include <asm/ffp.h>
>> +#else
>> +
>> +struct ffp {
>> +    void    (**fn)(void);
>> +    void    (*default_fn)(void);
>> +};
>> +
>> +#define DECLARE_FFP(_fn, _def)                        \
>> +    extern typeof(_def) *_fn;                    \
>> +    extern struct ffp const __ffp_ ## _fn
>> +
>> +#define DEFINE_FFP(_fn, _def)                        \
>> +    typeof(_def) *_fn =3D &_def;                    \
>> +    struct ffp const __ffp_ ## _fn                    \
>> +        =3D { (void(**)(void))&_fn, (void(*)(void))&_def };    \
>> +    EXPORT_SYMBOL(__ffp_ ## _fn)
>> +
>> +static inline void ffp_set_target(const struct ffp *m, void *new_fn)
>> +{
>> +    WRITE_ONCE(*m->fn, new_fn);
>> +}
>> +
>> +static inline void ffp_reset_target(const struct ffp *m)
>> +{
>> +    WRITE_ONCE(*m->fn, m->default_fn);
>> +}
>> +
>> +#endif
>> +
>> +#define SET_FFP(_fn, _new)    ffp_set_target(&__ffp_ ## _fn, _new)
>> +#define RESET_FFP(_fn)        ffp_reset_target(&__ffp_ ## _fn)
>> +
>> +#endif
>=20
> I don't understand this interface. There is no wrapper for the call
> site, so how are we going to patch all call-sites when you update the
> target?

I=E2=80=99m also confused.

Anyway, we have patchable functions on x86. They=E2=80=99re called PVOPs, an=
d they=E2=80=99re way overcomplicated.

I=E2=80=99ve proposed a better way that should generate better code, be more=
 portable, and be more maintainable.  It goes like this.

To call the function, you literally just call  the default implementation.  I=
t *might* be necessary to call a nonexistent wrapper to avoid annoying optim=
izations. At build time, the kernel is built with relocations, so the object=
 files contain relocation entries for the call. We collect these entries int=
o a table. If we=E2=80=99re using the =E2=80=9Cnonexistent wrapper=E2=80=9D a=
pproach, we can link in a .S or linker script to alias them to the default i=
mplementation.

To patch them, we just patch them. It can=E2=80=99t necessarily be done conc=
urrently because nothing forces the right alignment. But we can do it at boo=
t time and module load time. (Maybe we can patch at runtime on architectures=
 with appropriate instruction alignment.  Or we ask gcc for an extension to a=
lign calls to a function.)

Most of the machinery already exists: this is roughly how the module loader r=
esolves calls outside of a module.=
