Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523CEC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5362081B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kB8J/tJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5362081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbeLEM6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:58:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40366 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbeLEM6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:58:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so12729328wmf.5;
        Wed, 05 Dec 2018 04:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1xKUxRZCD0KmBrrzVGHFaFLA7pcHSE7Vxhv5dQ+ga9E=;
        b=kB8J/tJSXOl8XBTBu6mMA3VWyw9kOCLjXjVURSalHB4hbaWevFvu7e+JP/KMz6Vfsw
         Oy5/hD9k8o3PJ/cuw2fOuvh+H/uXvMYIXQlufrZqTR6+MEWmNhfRnOPqahvH2/eYJkPs
         b7UnQipHTK9ZCo/ffSKoXYV49QWr5unHIIc3HsSdV5mn/VpJ21AL/0r8JdmR/BLQ3aJz
         pFWSecGhEz1FbvWoHRYTJiGVMIKYiEqaBgUGWphPSbVlJwtXmRlqqZlmvkuLZbS1H6K4
         jiTs2h0ygjBiGRDaSsiUlGK+KcigiRqqbSw2W2M/nGMTTP8hhalKyrhnjEehDJsBO63v
         JfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1xKUxRZCD0KmBrrzVGHFaFLA7pcHSE7Vxhv5dQ+ga9E=;
        b=gqsvFvU7silIJ3XBKLfpWCcy20AbC/93ptA1bXoUSAsEtdBuhbSmnE07qEfy4TcAk0
         BeT2bA3Gd+fO2GQiy/QLDnlRBlOw6fa52SrF1GJ1vt3AHbLgz/KCrBBzdK0YoFLUEhGc
         P6D+9TI3Va+35R4FH7Ted5PBgeZW2cHtNtStfZiPiLWnHwDsDV3KOCnUMSTT6vj1nSLp
         WQnPz4jKtzlFm1dag6Ij+jqH16KjM9frILvQSOncG1UeIatL71uYlLBA+IzI0o+QGx/q
         FKa2PzxeovLI3eJY7auv1C4D2kar3A30PXO1rPlcnX3rm2Rb0Kz7ZLpDJFdf1SGhC5WH
         7LWw==
X-Gm-Message-State: AA+aEWbsLb/zrwRfTWLdT+IP7NvLeQMmiLAcoEnNdBJWeXii3vWhjaOa
        Yj9eaSLm46d/aQPfJrBjkye/qEoZfdmVesUD+p8=
X-Google-Smtp-Source: AFSGD/XGcIsfVvU3F2cq2bFOTMqHa9rNMYlkwOOax9Q98Bd40MkSkr7WPYjkxEROhy0gV7qH/W2c6uR0Bqp7UUZpJ20=
X-Received: by 2002:a1c:9692:: with SMTP id y140mr16645135wmd.67.1544014698977;
 Wed, 05 Dec 2018 04:58:18 -0800 (PST)
MIME-Version: 1.0
References: <065643a0-f9aa-a361-715a-03ca978d9228@roeck-us.net>
 <20181128041555.GE31885@thunk.org> <en52df-5dh.ln1@banana.localnet>
 <2547416.7Vy7A2kRpU@siriux> <CA+PODjo-da79FKQCmpcH9Z9CBq35HbWu2m+nB3si7WgD9w-kGA@mail.gmail.com>
 <cbdb2e6b-31a2-1e19-f51f-067dcbdcf183@mailbox.org> <CA+PODjpLRuc1u4SNSRqfWtx+Z+C8NGi6fs7yFuyKK0DwHggEdg@mail.gmail.com>
 <de67b507-ca54-e827-867e-76d57e531cb9@mailbox.org>
In-Reply-To: <de67b507-ca54-e827-867e-76d57e531cb9@mailbox.org>
From:   Andrey Melnikov <temnota.am@gmail.com>
Date:   Wed, 5 Dec 2018 15:58:06 +0300
Message-ID: <CA+PODjrT=pXg-jbhk=q=M6j6-v0x+c05s4Lmi3+MLm0P4iirqg@mail.gmail.com>
Subject: Re: ext4 file system corruption with v4.19.3 / v4.19.4
To:     jrf@mailbox.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D0=BD, 3 =D0=B4=D0=B5=D0=BA. 2018 =D0=B3. =D0=B2 01:11, Rainer Fiebi=
g <jrf@mailbox.org>:
>
> Am 02.12.18 um 21:19 schrieb Andrey Melnikov:
> > =D1=87=D1=82, 29 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 01:08, R=
ainer Fiebig <jrf@mailbox.org>:
> >>
> >> Am 28.11.18 um 22:13 schrieb Andrey Melnikov:
> >>> =D1=81=D1=80, 28 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 18:55,=
 Rainer Fiebig <jrf@mailbox.org>:
> >>>>
> >>>> Am Mittwoch, 28. November 2018, 13:02:56 schrieb Andrey Jr. Melnikov=
:
> >>>>> In gmane.comp.file-systems.ext4 Theodore Y. Ts'o <tytso@mit.edu> wr=
ote:
> >>>>>> On Wed, Nov 28, 2018 at 03:16:33AM +0300, Andrey Jr. Melnikov wrot=
e:
> >>>>>>> Corrupted inodes - always directory, not touched at least year or
> >>>>>>> more for writing. Something wrong when updating atime?
> >>>>>>
> >>>>>> We're not sure.  The frustrating thing is that it's not reproducin=
g
> >>>>>> for me.  I run extensive regression tests, and I'm using 4.19 on m=
y
> >>>>>> development laptop without notcing any problems.  If I could repro=
duce
> >>>>>> it, I could debug it, but since I can't, I need to rely on those w=
ho
> >>>>>> are seeing the problem to help pinpoint the problem.
> >>>>>
> >>>>> My workstation hit this bug every time after boot. If you have an i=
dea - I
> >>>>> may test it.
> >>>>>
> >>>>>> I'm trying to figure out common factors from those people who are
> >>>>>> reporting problems.
> >>>>>>
> >>>>>> (a) What distribution are you running (it appears that many people
> >>>>>> reporting problems are running Ubuntu, but this may be a sampling
> >>>>>> issue; lots of people run Ubuntu)?  (For the record, I'm using Deb=
ian
> >>>>>> Testing.)
> >>>>>
> >>>>> Debian sid but self-build kernel from ubuntu mainline-ppa.
> >>>>
> >>>> You could try a vanilla 4.19.5 from https://www.kernel.org/
> >>>> and compile it with your current .config.
> >>>
> >>> mainline-ppa use vanilla kernel. Patches only adds debian specific
> >>> build infrastructure.
> >>>
> >>>> If you still see the errors, at least the Ubuntu-kernel could be rul=
ed out.
> >>>>
> >>>> In addition, if you still see the errors:
> >>>>
> >>>> - backup your .config in a *different* folder (so that you can later=
 re-use
> >>>> it)
> >>>> - do a "make mrproper" (deletes the .config, see above)
> >>>> - do a "make defconfig"
> >>>> - and compile the kernel with that new .config
> >>>
> >>> defconfig is great - for abstract hardware in vacuum.
> >>>
> >>>> If you still have the problem after that, you may want to learn how =
to bisect.
> >>>> ;)
> >>> I'm already know how-to bisect. From kernel 2.0 era. Without git ;)
> >>>
> >>> This problem simply non-bisectable, when same kernel corrupt FS on my
> >>> workstation but normally working on other servers.
> >>> And now - FS corrupted again with disabled CONFIG_EXT4_ENCRYPTION. Gr=
eat.
> >>
> >> OK, - and now we are looking forward to *your* ideas how to solve this=
.
> >
> > After four days playing games around git bisect - real winner is
> > debian gcc-8.2.0-9. Upgrade it to 8.2.0-10 or use 7.3.0-30 version for
> > same kernel + config - does not exhibit ext4 corruption.
> >
> > I think I hit this https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D87859
> > with 8.2.0-9 version.
> >
> Good that it works for you. But others used gcc 5.4.0 or 6.3.0 and were
> hit anyway: https://bugzilla.kernel.org/show_bug.cgi?id=3D201685#c165

Depends on workload pattern. 4.19.5 built with 8.2.0-10 and 7.3.0-30 -
crashed after 4 hours of usage (previous build crash in 5 min).
So my assumption about broken gcc is wrong.
