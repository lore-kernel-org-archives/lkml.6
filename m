Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83F7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A9820675
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tytqg4+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfAQB53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 20:57:29 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38114 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfAQB53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 20:57:29 -0500
Received: by mail-ot1-f66.google.com with SMTP id e12so9724758otl.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 17:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EXIW7bVzHWS1DHDPDbxMnongYlAY8CFRBhpc/tSDLb4=;
        b=tytqg4+veE2PMT5iR8Y5szfVVaeuogXMa+zTTIZ1ZQX7ZJ1ViMPbDfv0JuYClrVGfC
         apu0vIZgdyUNztXMZOc5bPi+bgkHbUhUV5JZWsu2wUBbBWlPfY1/AHUACsSN0/QRtonF
         4Y5tylh2zP4PWsn6dEdJ/xLE7YZDzW3SAJ3FIQUMsPU9PraGJXhWZFP0wL537ZONjEk3
         wFP28/4apl3ucv5BLKTeu9QQaAOnjNeosypY4Y/w6nJPGdJzQeUIlEvRiviVYFXUUKz8
         Tc5pkGAN2eo6/jgS9yRwWTDBWfXaIJJvIpBRWYUBiTg9VhdBn5FhOg9ln/IxJ1MEbVI5
         6MRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EXIW7bVzHWS1DHDPDbxMnongYlAY8CFRBhpc/tSDLb4=;
        b=GFeGE8JHKYdPYJNgAWbmicJkDt2fIxDp7x8SpzjPMS4rw1ofivY/EehTuOuB7ZRCKk
         EWdz3EqaMXXMZkURaV9pqnCsDPRf7U3kt93ynR6REcpJn63elNibncc/iGkkEY28GyPH
         QxY1vmgkUghqGiGmUp8E+Yfba5tsXUNso47fhwCb19bduQHvcg2fY8zESdGmAp5l3MiD
         gYrNAW17Gc2kaRC+ZbXaOP/1wZsJJX22TQe5488dfEIZUM+udlRTeeVZfWRAoNIR0hoj
         ZUq01drKhu3jiQqR7tSLbsJ84tNIW6+IDhsVRGhO1xml6B1vx0fGC6DX67ks6dx2eWa7
         +AKA==
X-Gm-Message-State: AJcUukfDfT8gfef54N4PwvV3gQnEMTY5s5jorsBWJ8B1sjIZAqL7LoPg
        ZJ8OWRfuAwLHmSWB1TXytiy/BX1ce13HsmlM2g8=
X-Google-Smtp-Source: ALg8bN5G9TaEfXLRTOiePuLXcauYHgMHYMvkWnOb0X++S+smEQIY0R+7XyL5Cf1+Y5NDExQPgDmuZ5bbjc5uw5HFkN4=
X-Received: by 2002:a05:6830:1584:: with SMTP id i4mr7042971otr.116.1547690248430;
 Wed, 16 Jan 2019 17:57:28 -0800 (PST)
MIME-Version: 1.0
References: <CAKwPUowmzZ2BNi-RmJm3=ENrZ5sxPf1SeT+b9A9iHHSCUQQAUw@mail.gmail.com>
 <20190116164817.GG1910@brain-police>
In-Reply-To: <20190116164817.GG1910@brain-police>
From:   Kassey <kassey1216@gmail.com>
Date:   Thu, 17 Jan 2019 09:57:17 +0800
Message-ID: <CAKwPUoyWy64-o2NgB5iPXNs4UR7bmYjmKk3Ub0X6DND40fCtPA@mail.gmail.com>
Subject: Re: arm64: copy_from_user access the last page of ddr has problem on
 4.14 kernel
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org, kassey@126.com,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, robin.murphy@arm.com,
        ard.biesheuvel@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Will
      it is hard to try on v5.0-rc2 kernel, since there is much port
job to be done.
     dst kernel buffer is looks overwriten by some same(fix) patter
start with "mmap"    (0x6d6d7061)  see below code (data from vmalloc),
and file is mmaped (include the last phy page of ddr.)
     see below pattern and pieces of code.
     not sure if there is boundary issue for copy_from_user, please
help to suggest if you got some idea from the pattern, thanks.

0079c00 6d6d 7061 0000 0000 0848 fd8f 0001 0000
0079c10 0048 fd8f 0001 0000 0001 0000 0003 0000
0079c20 2000 fd83 0001 0000 1fff fd86 0001 0000
0079c30 0000 0000 0000 0000 700f 0000 0000 0000
0079c40 6d6d 7061 0000 0000 f448 ffff 0001 0000
0079c50 f748 ffff 0001 0000 0001 0000 0004 0000
0079c60 3000 fd8c 0001 0000 2fff fd8e 0001 0000
0079c70 0000 0000 0000 0000 700f 0000 0000 0000
0079c80 c103 0606 0100 be00 1009 3b00 3b07 0607
0079c90 0100 5700 1006 e800 8c03 3103 0100 0a00
0079ca0 0000 cf00 bf08 0a00 0100 5700 1006 3700
0079cb0 3906 0606 0100 1600 0004 4700 9902 0207
0079cc0 6d6d 7061 0000 0000 f808 ffff 0001 0000
0079cd0 f1c8 ffff 0001 0000 0001 0000 0005 0000
0079ce0 d000 fff8 0001 0000 efff fffa 0001 0000
0079cf0 0000 0000 0000 0000 700f 0000 0000 0000
0079d00 6d6d 7061 0000 0000 f1c8 ffff 0001 0000
0079d10 f388 ffff 0001 0000 0001 0000 0003 0000
0079d20 c000 ffdf 0001 0000 6fff fff8 0001 0000
0079d30 0000 0000 0000 0000 700f 0000 0000 0000
0079d40 9407 0901 0100 5300 0204 b400 d503 0a04
0079d50 0100 0000 0001 0200 7309 0202 0100 0200
0079d60 5000 0200 7309 0202 0400 ff00 f7ff 94ff
0079d70 b400 0208 0100 dc00 0000 b400 5803 0607
0079d80 6d6d 7061 0000 0000 f7c8 ffff 0001 0000


static ssize_t sel_write_load(struct file *file, const char __user *buf,
     size_t count, loff_t *ppos)

{
ssize_t length;
void *data =3D NULL;

mutex_lock(&sel_mutex);

length =3D avc_has_perm(current_sid(), SECINITSID_SECURITY,
     SECCLASS_SECURITY, SECURITY__LOAD_POLICY, NULL);
if (length)
goto out;

/* No partial writes. */
length =3D -EINVAL;
if (*ppos !=3D 0)
goto out;

length =3D -EFBIG;
if (count > 64 * 1024 * 1024)
goto out;

length =3D -ENOMEM;
data =3D vmalloc(count);            // dst buffer in kernel
if (!data)
goto out;

length =3D -EFAULT;
if (copy_from_user(data, buf, count) !=3D 0)
goto out;




BR
Kassey

Will Deacon <will.deacon@arm.com> =E4=BA=8E2019=E5=B9=B41=E6=9C=8817=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:48=E5=86=99=E9=81=93=EF=BC=9A
>
> [I'm due to get on a long flight shortly, so I've added LAKML and a few
> others to CC]
>
> On Wed, Jan 16, 2019 at 11:25:15AM +0800, Kassey wrote:
> > Hi, Will and team:
> >
> >    we met a issue when copy_from_user to access the last page of DDR
> > on 4.14 kenrel, below is the detail steps,
> >    can you help to suggest if there is know fix or debug something ?
> >
> > 1. we mmap ( in userspace)  a region of  phy address that is not
> > continous  but include the last page of ddr
> >
> >   for example our ddr end is 0x200000000
> >   the last page is fall in below addr:
> >   0x1fffff000  to  0x200000000
> >
> > 2. we using copy_from_user to copy these mmap address to kernel buffer
> >
> > 3. and we find everytime when trying to copy_from_user  the last page
> > in phy of ddr,
> >     the dst kernel buffer is looks overwrite by some same patten start
> > with "mmap" in this last page ,but the src in the last page of ddr is
> > still correct.
> >
> > is there any know issue for copy_from_user to accces the last page of
> > phy ddr mmaped by userspace  ?
>
> Not that I'm aware of. Are you using defconfig and can you reproduce the
> problem with mainline (e.g. v5.0-rc2)? What exactly do you mean by:
>
>   "the fst kernel buffer is looks overwrite by some same patten start wit=
h
>   "mmap""?
>
> Does the copy_from_user fail (what does it return?) or does it succeed bu=
t
> the data copied appears to be junk? Is it deterministic? Could you share =
an
> example of what the corrupted data looks like, please?
>
> Cheers,
>
> Will



--=20
Best regards
Kassey
