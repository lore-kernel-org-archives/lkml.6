Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766CFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2C120824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="x4zsJtrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2C120824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441167AbeKXFZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:25:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34055 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437404AbeKXFZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 00:25:01 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so3698067pfg.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 10:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jZO8+4aX1s1i7kfLfvKjRhlTHMG92kmcFX86kOZOXHE=;
        b=x4zsJtrLmQFrQnzEvcRHTlTcSnwkUh4a4mRTk/3X55M2k510RTPHH9WvmeIrrWPw3F
         eCLKKQgb7zy1r0F4zvVTsScjJrNnLgx/lrOMFP72mAiwRZfGpt3IcAfu0s848M3dXp+N
         8ICS1I9oJBqZmjp/fs1mgbdjr1/aU1U1i5prDChx6wh+KThiyldbQ6784YJShaqjX/qo
         mc4mmIj0/2DQhcHulw24RBKebg12Ca00/Ik8WdBcr6p8tBeM92rgVJ1QmT+fgBAIDYOP
         +eHmNL6jloaiXI2x72ZpvGmunn+aoAGcjlgLRXOK+isRZeYnEvAKomSbaIOj6lrJtE2z
         fVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jZO8+4aX1s1i7kfLfvKjRhlTHMG92kmcFX86kOZOXHE=;
        b=DhYacPjd1sTNL/IgcGnVN9u53driX0s6CfzC8CKaprK5MaRj2UVpUwmjLU7smg2A95
         sfa+G0z+PEXPZ85RCDF3acKzE2D/UzTuqSu2ShF1PtRtL3A1a2ADY0aYNYjUdm9T0X6a
         nQdSNGoaqBHL6OhYhELCi+4X+C/rsTCwTTpLdfM6nAxqLduoVhJdfl1a7F0sv+lGqH6O
         TjOsDphx6wSe6YOHF0EzA4vTmgA2WZWDSBIDcfYplbhqB+pUaEwDGqoXNtpypizInEA1
         U0QNb88RzR+YiUR/M1smTu4yw3qoQ2vHdbVJw1qDjJ7gCbAU+NUg4ctlXe9kqnYQTszN
         0NIw==
X-Gm-Message-State: AGRZ1gKBPkoa9dVmC12LNbMG7G7Cf7O2zZUkNF+BDFYq9wyBy9oTfWlP
        3utuf/0qbVHK6zDE8sRg0YmlCQ==
X-Google-Smtp-Source: AJdET5eXXbxP3VCP+wZwVbz0t+7FWTW6/FlcMHnqZhDS6EPeJpL2AShIlVp9v3xMh0L7BZZpZc2Rdg==
X-Received: by 2002:a62:d0c1:: with SMTP id p184mr16901519pfg.245.1542998375366;
        Fri, 23 Nov 2018 10:39:35 -0800 (PST)
Received: from [10.255.101.131] (22.sub-97-41-132.myvzw.com. [97.41.132.22])
        by smtp.gmail.com with ESMTPSA id x3sm37051567pgk.18.2018.11.23.10.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 10:39:34 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <CAHk-=wjrdrZW5VgnKXqdayafYmQC2HBEA4kzMWYTyaj5jgURdA@mail.gmail.com>
Date:   Fri, 23 Nov 2018 11:39:29 -0700
Cc:     David.Laight@aculab.com, Andrew Lutomirski <luto@kernel.org>,
        dvlasenk@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, brgerst@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C74CD745-0E6D-410C-B942-416AF365B492@amacapital.net>
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk> <20181121063609.GA109082@gmail.com> <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk> <26eff539-7de7-784c-0c88-f1d30753299d@redhat.com> <7ea44458b90b4d41a08ba9012818d273@AcuMS.aculab.com> <CAHk-=wjLNuNpHRfuVTb6awstC9OOmSb3S8aP51ufep-Th4dXKw@mail.gmail.com> <CALCETrW=hMZLUM_nPEEgUW9x9Bmhm2LZ6ZRDiRRguxVT=-_BWA@mail.gmail.com> <CAHk-=wiEUVpSU-GxpKDvN9wnH2yDxkJgE7Vqh46A+fmnvhubyw@mail.gmail.com> <cd11d9423c8b46ecbf97753f8317c294@AcuMS.aculab.com> <64fd67993af04579b5262c270a7a4694@AcuMS.aculab.com> <CAHk-=wj9DA-mH8jahuEPUWxO4EgbCcPRgdOJAQD58DBtCCrHcQ@mail.gmail.com> <CAHk-=wjrdrZW5VgnKXqdayafYmQC2HBEA4kzMWYTyaj5jgURdA@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 23, 2018, at 10:42 AM, Linus Torvalds <torvalds@linux-foundation.or=
g> wrote:
>=20
> On Fri, Nov 23, 2018 at 8:36 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>=20
>> Let me write a generic routine in lib/iomap_copy.c (which already does
>> the "user specifies chunk size" cases), and hook it up for x86.
>=20
> Something like this?
>=20
> ENTIRELY UNTESTED! It might not compile. Seriously. And if it does
> compile, it might not work.
>=20
> And this doesn't actually do the memset_io() function at all, just the
> memcpy ones.
>=20
> Finally, it's worth noting that on x86, we have this:
>=20
>  /*
>   * override generic version in lib/iomap_copy.c
>   */
>  ENTRY(__iowrite32_copy)
>          movl %edx,%ecx
>          rep movsd
>          ret
>  ENDPROC(__iowrite32_copy)
>=20
> because back in 2006, we did this:
>=20
>    [PATCH] Add faster __iowrite32_copy routine for x86_64
>=20
>    This assembly version is measurably faster than the generic version in
>    lib/iomap_copy.c.
>=20
> which actually implies that "rep movsd" is faster than doing
> __raw_writel() by hand.
>=20
> So it is possible that this should all be arch-specific code rather
> than that butt-ugly "generic" code I wrote in this patch.
>=20
> End result: I'm not really all that  happy about this patch, but it's
> perhaps worth testing, and it's definitely worth discussing. Because
> our current memcpy_{to,from}io() is truly broken garbage.
>=20
>                  =20

What is memcpy_to_io even supposed to do?  I=E2=80=99m guessing it=E2=80=99s=
 defined as something like =E2=80=9Ccopy this data to IO space using at most=
 long-sized writes, all aligned, and writing each byte exactly once, in orde=
r.=E2=80=9D  That sounds... dubiously useful.  I could see a function that w=
rites to aligned memory in specified-sized chunks.  And I can see a use for a=
 function to just write it in whatever size chunks the architecture thinks i=
s fastest, and *that* should probably use MOVDIR64B.

Or is there some subtlety I=E2=80=99m missing?=
