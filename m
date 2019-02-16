Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2121C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 22:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0552192D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 22:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="aTgdNVWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387483AbfBPW5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 17:57:40 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40536 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbfBPW5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 17:57:39 -0500
Received: by mail-pg1-f196.google.com with SMTP id u9so3052594pgo.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 14:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GmY1DGvxlDOr0wgTH2Uuo71S9uZUrJX7TeGXSG9WpTY=;
        b=aTgdNVWApi76usC8wUg9nh5WRXFvvxViynMGbSUzB0NHbTV+U3I5/7KMRm+4aWyh7x
         sKBZZWLlNE59K+rbtoGGfOWcdZ+aAiLntiZYo7Y1Y0j0LbIHvYcLfJdUmrwLQdZlrYwb
         IUmCYxPg80NYeTF9dvcZtfVu1wqlO/nfRsUAeiQtMN0wMK93ZP2K4Svqirj2pV3qqy2c
         ejvgAaMAcaVRoQ3Via3GKhJ5nQeiYEun6MQOCLGBwKYvQB1vyHsfMiYl+/eCSbsgOzWK
         453hSNsd38Bz3dOxCiNCPgnxx2BnulSYYVG03w5qhyumYg32UDuevPRYfEjG7OWodylB
         lujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GmY1DGvxlDOr0wgTH2Uuo71S9uZUrJX7TeGXSG9WpTY=;
        b=KvSeGNBGoQUhCMgw0FCUCKPzmlqS6yxUmOTK7o9+kZe4/6MUiJW3wjY5KLbohCRkTu
         1UZbTcR3MfzI0wXLtTCRx3FpSLDFlI346IcsAgdHtFQiJHpUyoTLv+k9B6UIdaUibFQP
         xtTbniCdODsnSowLrn6tJ6WldMmgKqThul0r/rZ1QeDxffgV728x0lG0A5bQK8D1L0rC
         Qw5v7T034ukMzMXHkZsgJND28yKCQ7avyTtOfGYIXsPIJ3caPXOaOh8mDMp319HkyNPc
         Ey+re/DZ9bphrdj2VlEwegE3t97vHDailIqULH4OLSwW7I2SGR0C7ss+3Z+O0ho7f43H
         X4DQ==
X-Gm-Message-State: AHQUAub9/Bg+YGYh2mP0fmruwjzziD8bgVgRfUEfIC18YU+Ber08HEEd
        R/uFBufkLDwZrSuLAdcELTuEjzXmVTo=
X-Google-Smtp-Source: AHgI3Iazqh7GC31kfoK03IVGEdL31YvXfSXI9EPjOp0zyuJTvsq0CberwmGQ5+1oKypHehBpkjS6Wg==
X-Received: by 2002:a63:9246:: with SMTP id s6mr11737385pgn.349.1550357858738;
        Sat, 16 Feb 2019 14:57:38 -0800 (PST)
Received: from ?IPv6:2600:1010:b01d:e8ca:a1cf:e098:145e:ed28? ([2600:1010:b01d:e8ca:a1cf:e098:145e:ed28])
        by smtp.gmail.com with ESMTPSA id 67sm28069777pfl.175.2019.02.16.14.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 14:57:37 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86: uaccess: fix regression in unsafe_get_user
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <4F2693EA-1553-4F09-9475-781305540DBC@amacapital.net>
Date:   Sat, 16 Feb 2019 14:57:36 -0800
Cc:     Jann Horn <jannh@google.com>, baloo@gandi.net,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Pascal Bouchareine <pascal@gandi.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D8D44180-C781-4021-ADAB-D40FD2885D1B@amacapital.net>
References: <20190215235901.23541-1-baloo@gandi.net> <CAG48ez2tYizTKncevLF=AMQ2nm3D=SqGHH5bM5f-U0fhQ1nL9Q@mail.gmail.com> <alpine.DEB.2.21.1902161358160.1683@nanos.tec.linutronix.de> <4F2693EA-1553-4F09-9475-781305540DBC@amacapital.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Feb 16, 2019, at 2:50 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>=20
>=20
>=20
>>> On Feb 16, 2019, at 12:18 PM, Thomas Gleixner <tglx@linutronix.de> wrote=
:
>>>=20
>>>> On Sat, 16 Feb 2019, Jann Horn wrote:
>>>> On Sat, Feb 16, 2019 at 12:59 AM <baloo@gandi.net> wrote:
>>>> When extracting an initramfs, a filename may be near an allocation boun=
dary.
>>>> Should that happen, strncopy_from_user will invoke unsafe_get_user whic=
h
>>>> may cross the allocation boundary. Should that happen, unsafe_get_user w=
ill
>>>> trigger a page fault, and strncopy_from_user would then bailout to
>>>> byte_at_a_time behavior.
>>>>=20
>>>> unsafe_get_user is unsafe by nature, and rely on pagefault to detect bo=
undaries.
>>>> After 9da3f2b74054 ("x86/fault: BUG() when uaccess helpers fault on ker=
nel addresses")
>>>> it may no longer rely on pagefault as the new page fault handler would
>>>> trigger a BUG().
>>>>=20
>>>> This commit allows unsafe_get_user to explicitly trigger pagefaults and=

>>>> handle them directly with the error target label.
>>>=20
>>> Oof. So basically the init code is full of things that just call
>>> syscalls instead of using VFS functions (which don't actually exist
>>> for everything), and the VFS syscalls use getname_flags(), which uses
>>> strncpy_from_user(), which can access out-of-bounds pages on
>>> architectures that set CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS, and
>>> that in summary means that all the init code is potentially prone to
>>> tripping over this?
>>=20
>> Not all init code. It should be only the initramfs decompression.
>>=20
>>> I don't particularly like this approach to fixing it, but I also don't
>>> have any better ideas, so I guess unless someone else has a bright
>>> idea, this patch might have to go in.
>>=20
>> So we know that this happens in the context of decompress() which calls
>> flush_buffer() for every chunk. flush_buffer() gets the start_address and=

>> the length. We also know that the fault can only happen within:
>>=20
>>   start_address <=3D fault_address < start_address + length + 8;
>>=20
>> So something like the untested workaround below should cover the initramf=
s
>> oddity and avoid to weaken the protection for all other cases.
>=20
> What is the actual problem?  We=E2=80=99re not actually demand-faulting th=
is data, are we?  Are we just overrunning the buffer because the from_user h=
elpers are too clever?  Can we fix it for real by having the fancy helpers d=
o *aligned* loads so that they don=E2=80=99t overrun the buffer?  Heck, this=
 might be faster, too.

Indeed.  I would argue that the current code is a bug even in the normal cas=
e.  If I lay out my user address space so that I have f,o,o,o,\0 at the end o=
f a page and I have non-side-effect-free memory after it (MMIO, userfaultfd,=
 etc), then passing a pointer to that =E2=80=9Cfooo=E2=80=9D string to a sys=
call should *not* overrun the buffer.

If I have some time this evening, I=E2=80=99ll see if I can whip up a credib=
le fix.=
