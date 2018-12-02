Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9C0C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B013F20881
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kh2SqR34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B013F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbeLBUTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:19:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38783 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbeLBUTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:19:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so3659178wml.3;
        Sun, 02 Dec 2018 12:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yuzelb+NeLk3ZLJQJ1kIIlasA01mlSN3zSUvyqBHEng=;
        b=kh2SqR34BF+7N1dSdgsm/bIFIRdLaaXgsH+8WNpmylBWLp3xobRtxidohVmGtFghNj
         sDdugIbKnQ8B11HIL/4Aqsc2/HP9lY+H33bJYdJjy4F4A4mVOTWaI/SZqh8eX5L5XYYi
         Ox8TYOlbojsyrPxs/A4zmvaMxSjW3Vk0vmjmM3y10g/JI1mYCwSsLXNjjfhhq8WcpFXx
         lIIuakUAMiQsRfN0COOGdYzMkcUEkd9TIRouywxWyCyJRbqNFGTguiodXS3UoqE7vi04
         PQn7wSYCY7d6vkM0Zd0RRnIyAsGvdcWBLx7BKZH6aNiFd/yIWc6CSHp0PB1Mgv3pvcWn
         /0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yuzelb+NeLk3ZLJQJ1kIIlasA01mlSN3zSUvyqBHEng=;
        b=jvhVcI8D7VVEHC7TVgSnaPAS/podDzf35dYqs7MZ+ERAbvrYTGViJ3nw3ZQeUa2SGw
         jeqdpuCV2I97ONpbfR2UQxN6MiiXeNozXhjA1LFka05x+83qXREVYS+ebpcfULoe2PNo
         tuuotPpcUN8EJcbeh+Z19gYgTmJbTx/B15KyaUpTxszVOgDrtE0p+E6Fl/hy5THZAzAu
         yT0yornnvk/qWtCcy8gVoD7oy86KqoKALxi/uxu6HYjE6HYdrLd36GkXOWKxOEp6CsYS
         I2iAiLzLK2I2Y7PtGWu1WDIDPOi+rxr+bU0KFkk4Y5D/IrKMQMXwFa4+R0rK0yfBGog2
         7dOw==
X-Gm-Message-State: AA+aEWZ0ThShjqDKnQ72eqgnIFSsHLUt3cc6SJZfskrjlJorEc5BviG6
        65mNhLNYC9rzFCX6tFWDhaQbPu5dnYcgDa9bWoQt9mioKMw=
X-Google-Smtp-Source: AFSGD/X0xGXu4NijjAuWS10Jz1bCyzsEb5lbGA3zmFI/6m0qvb14RnWHckEjAYByWHLuRoqs7UXELCrfNF7pk9kpMVI=
X-Received: by 2002:a1c:9692:: with SMTP id y140mr6173763wmd.67.1543781982183;
 Sun, 02 Dec 2018 12:19:42 -0800 (PST)
MIME-Version: 1.0
References: <065643a0-f9aa-a361-715a-03ca978d9228@roeck-us.net>
 <20181128041555.GE31885@thunk.org> <en52df-5dh.ln1@banana.localnet>
 <2547416.7Vy7A2kRpU@siriux> <CA+PODjo-da79FKQCmpcH9Z9CBq35HbWu2m+nB3si7WgD9w-kGA@mail.gmail.com>
 <cbdb2e6b-31a2-1e19-f51f-067dcbdcf183@mailbox.org>
In-Reply-To: <cbdb2e6b-31a2-1e19-f51f-067dcbdcf183@mailbox.org>
From:   Andrey Melnikov <temnota.am@gmail.com>
Date:   Sun, 2 Dec 2018 23:19:30 +0300
Message-ID: <CA+PODjpLRuc1u4SNSRqfWtx+Z+C8NGi6fs7yFuyKK0DwHggEdg@mail.gmail.com>
Subject: Re: ext4 file system corruption with v4.19.3 / v4.19.4
To:     jrf@mailbox.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=87=D1=82, 29 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 01:08, Raine=
r Fiebig <jrf@mailbox.org>:
>
> Am 28.11.18 um 22:13 schrieb Andrey Melnikov:
> > =D1=81=D1=80, 28 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 18:55, R=
ainer Fiebig <jrf@mailbox.org>:
> >>
> >> Am Mittwoch, 28. November 2018, 13:02:56 schrieb Andrey Jr. Melnikov:
> >>> In gmane.comp.file-systems.ext4 Theodore Y. Ts'o <tytso@mit.edu> wrot=
e:
> >>>> On Wed, Nov 28, 2018 at 03:16:33AM +0300, Andrey Jr. Melnikov wrote:
> >>>>> Corrupted inodes - always directory, not touched at least year or
> >>>>> more for writing. Something wrong when updating atime?
> >>>>
> >>>> We're not sure.  The frustrating thing is that it's not reproducing
> >>>> for me.  I run extensive regression tests, and I'm using 4.19 on my
> >>>> development laptop without notcing any problems.  If I could reprodu=
ce
> >>>> it, I could debug it, but since I can't, I need to rely on those who
> >>>> are seeing the problem to help pinpoint the problem.
> >>>
> >>> My workstation hit this bug every time after boot. If you have an ide=
a - I
> >>> may test it.
> >>>
> >>>> I'm trying to figure out common factors from those people who are
> >>>> reporting problems.
> >>>>
> >>>> (a) What distribution are you running (it appears that many people
> >>>> reporting problems are running Ubuntu, but this may be a sampling
> >>>> issue; lots of people run Ubuntu)?  (For the record, I'm using Debia=
n
> >>>> Testing.)
> >>>
> >>> Debian sid but self-build kernel from ubuntu mainline-ppa.
> >>
> >> You could try a vanilla 4.19.5 from https://www.kernel.org/
> >> and compile it with your current .config.
> >
> > mainline-ppa use vanilla kernel. Patches only adds debian specific
> > build infrastructure.
> >
> >> If you still see the errors, at least the Ubuntu-kernel could be ruled=
 out.
> >>
> >> In addition, if you still see the errors:
> >>
> >> - backup your .config in a *different* folder (so that you can later r=
e-use
> >> it)
> >> - do a "make mrproper" (deletes the .config, see above)
> >> - do a "make defconfig"
> >> - and compile the kernel with that new .config
> >
> > defconfig is great - for abstract hardware in vacuum.
> >
> >> If you still have the problem after that, you may want to learn how to=
 bisect.
> >> ;)
> > I'm already know how-to bisect. From kernel 2.0 era. Without git ;)
> >
> > This problem simply non-bisectable, when same kernel corrupt FS on my
> > workstation but normally working on other servers.
> > And now - FS corrupted again with disabled CONFIG_EXT4_ENCRYPTION. Grea=
t.
>
> OK, - and now we are looking forward to *your* ideas how to solve this.

After four days playing games around git bisect - real winner is
debian gcc-8.2.0-9. Upgrade it to 8.2.0-10 or use 7.3.0-30 version for
same kernel + config - does not exhibit ext4 corruption.

I think I hit this https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D87859
with 8.2.0-9 version.
