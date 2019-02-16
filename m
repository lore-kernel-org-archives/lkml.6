Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA80C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 22:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7115221A4C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 22:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="SKdIo21G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfBPWuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 17:50:21 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40195 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfBPWuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 17:50:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id u9so3048664pgo.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 14:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=M8Xn+Q6RCQZjxFFq1HSfHofT5ZHEM2T8+R/l3ipzJes=;
        b=SKdIo21GVI4bifdPA7mwZa59Amy5XGEElBGFt9D9nzmyqVoQjF1lfxxeX/DouS47Av
         yOoTGCCwaOWSjN0eCwNLyanPOX+AclVs5SZVjeG0Zt3TCtCEjwwUV5Oa2MVjKBEQPoVx
         pyjw6wGjKGaaZogRajbKOysGtk+Nf2XhRwewGC/XKCdKnxwyhTSgdeKNHG59L4COLoL0
         Sc3rQlESPbvFE1Uo4U5OZLDF/w1HbSvIRMU6frHZXo0NSFYNQ7I/g/q4m35zgPbJK8Gp
         qzY8LEU1yA2auTJLqzdhKQlaXwJTYpa/YgE7SfZkuqah0kS0h2NoFZr79kMnvjMcCPS5
         RQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=M8Xn+Q6RCQZjxFFq1HSfHofT5ZHEM2T8+R/l3ipzJes=;
        b=tFxbAivU0qjYN5rIQTPImuztKafg7OfJCDmjW+S0VIFSIbXzFcgVWn41Fjb155xKzQ
         wBbgS4FAO2cmtQCXWqz8jHU0IKnICdoZB2KeIS3M72lmTWY54hcZx3ntZMRpNA7mMVuW
         X7oUZfbTg/j4VSfZfOJoTn83S/L0tiICbvakEisumib4v4x/ikMHPhQJ+GyGC/Phh3sm
         GOP++QF3SJWGtgUMgYZfV6lhaqxhcT3RU/5hr4SwxmCCOOejRyyo8fQAQYoBiNSUsHXf
         gqo07E4WGl1pJMoE90x0jLitYHBkqePV2q02CI4ZeNSvB2mshsbmDFbIijUwy+9bKN/L
         O/Jw==
X-Gm-Message-State: AHQUAua7XPwwjsQShPucB1VCUVGle1xlCT6kayqZWhDppQWXuNVG5Vvo
        e4vC5MxhWegPFLqL591nnl1Nn2NHrds=
X-Google-Smtp-Source: AHgI3IY+eA4aJJ26pfOBkWYzybqWqY+nd5R7Os5oBI2kNgxE9SQAjjFMxgZnvx200tngVn7Ry0lYuA==
X-Received: by 2002:a65:6149:: with SMTP id o9mr11838290pgv.315.1550357418849;
        Sat, 16 Feb 2019 14:50:18 -0800 (PST)
Received: from ?IPv6:2600:1010:b01d:e8ca:a1cf:e098:145e:ed28? ([2600:1010:b01d:e8ca:a1cf:e098:145e:ed28])
        by smtp.gmail.com with ESMTPSA id z18sm9531828pfl.164.2019.02.16.14.50.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 14:50:17 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86: uaccess: fix regression in unsafe_get_user
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <alpine.DEB.2.21.1902161358160.1683@nanos.tec.linutronix.de>
Date:   Sat, 16 Feb 2019 14:50:15 -0800
Cc:     Jann Horn <jannh@google.com>, baloo@gandi.net,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Pascal Bouchareine <pascal@gandi.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F2693EA-1553-4F09-9475-781305540DBC@amacapital.net>
References: <20190215235901.23541-1-baloo@gandi.net> <CAG48ez2tYizTKncevLF=AMQ2nm3D=SqGHH5bM5f-U0fhQ1nL9Q@mail.gmail.com> <alpine.DEB.2.21.1902161358160.1683@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 16, 2019, at 12:18 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
>> On Sat, 16 Feb 2019, Jann Horn wrote:
>>> On Sat, Feb 16, 2019 at 12:59 AM <baloo@gandi.net> wrote:
>>> When extracting an initramfs, a filename may be near an allocation bound=
ary.
>>> Should that happen, strncopy_from_user will invoke unsafe_get_user which=

>>> may cross the allocation boundary. Should that happen, unsafe_get_user w=
ill
>>> trigger a page fault, and strncopy_from_user would then bailout to
>>> byte_at_a_time behavior.
>>>=20
>>> unsafe_get_user is unsafe by nature, and rely on pagefault to detect bou=
ndaries.
>>> After 9da3f2b74054 ("x86/fault: BUG() when uaccess helpers fault on kern=
el addresses")
>>> it may no longer rely on pagefault as the new page fault handler would
>>> trigger a BUG().
>>>=20
>>> This commit allows unsafe_get_user to explicitly trigger pagefaults and
>>> handle them directly with the error target label.
>>=20
>> Oof. So basically the init code is full of things that just call
>> syscalls instead of using VFS functions (which don't actually exist
>> for everything), and the VFS syscalls use getname_flags(), which uses
>> strncpy_from_user(), which can access out-of-bounds pages on
>> architectures that set CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS, and
>> that in summary means that all the init code is potentially prone to
>> tripping over this?
>=20
> Not all init code. It should be only the initramfs decompression.
>=20
>> I don't particularly like this approach to fixing it, but I also don't
>> have any better ideas, so I guess unless someone else has a bright
>> idea, this patch might have to go in.
>=20
> So we know that this happens in the context of decompress() which calls
> flush_buffer() for every chunk. flush_buffer() gets the start_address and
> the length. We also know that the fault can only happen within:
>=20
>    start_address <=3D fault_address < start_address + length + 8;
>=20
> So something like the untested workaround below should cover the initramfs=

> oddity and avoid to weaken the protection for all other cases.

What is the actual problem?  We=E2=80=99re not actually demand-faulting this=
 data, are we?  Are we just overrunning the buffer because the from_user hel=
pers are too clever?  Can we fix it for real by having the fancy helpers do *=
aligned* loads so that they don=E2=80=99t overrun the buffer?  Heck, this mi=
ght be faster, too.
