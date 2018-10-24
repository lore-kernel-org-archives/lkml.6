Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E246C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF382081B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEoCn93x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF382081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeJXO4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 10:56:15 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38289 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeJXO4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 10:56:14 -0400
Received: by mail-io1-f68.google.com with SMTP id q18-v6so2427233iod.5;
        Tue, 23 Oct 2018 23:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wXdf8BDrIZKELcZtcP1tg4b3groSGYcdIxpKfxnCfwk=;
        b=GEoCn93xCylMT4OwpIcBaiqCA2dLHPjLNwDYNp7a8dmLovYj77AybJvmdEQ4srzb/w
         4+TsZpFHgGp95Q9fZnpPgKiZtcD/ZO/ijf2bXmcOqmGBOi+SBhRv1fyGli7nCJHhtv6F
         5xRqV9vaAn3Xzvt99iVsPXK9ETgfzcmOWNlF0EJeXT1plj1rAls02GP58xFc3d+zSN9z
         w0RXbw8nScCEFY8TdJF5bXG/lMpuKGCmqaf9W8tcz99ZVmn1RDMCZxhm1ZAAJUlxSUmm
         9ly5krbWOKdBdpYrThtlOkeyamXqgrGoP5ycKaVzZZmzwB7ER2PMFA+YLuggyEuxFvDZ
         44Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wXdf8BDrIZKELcZtcP1tg4b3groSGYcdIxpKfxnCfwk=;
        b=PpVGTbLuBF/BsmaujaXI8xgPcDREOqpoKYe3JNzf6QmMH+wGICt+OxPYAyRcCRMRN/
         Tsz3KHIYrJ5eoFf0YlbCZ1R3vWGXR7RMXmd/LWfThgbDxFiLodm8AN6Ruh5C0mDFJubI
         2U2v6y2rcYFRS8SNH57zg9hIDg4hzQ7FdpDic/thvsUCazQFcV/+ZBuTIdnNLe+wp4dT
         u0hzBnpepEW+HJM6jaSOmb5kd+qWhJnOnvnGs6uy8dx41W3lBGFU9aABYHcCVaYebyl6
         75tzh5pQpKewFYVHwWYdiUsUTW1N/wj+zHCQhYQlH8SHC/Gvuk4lGi72E2US4ZS/y8eu
         jzzA==
X-Gm-Message-State: AGRZ1gJWnLhMaY55cCSKWFv9CmDbpWADFJHj23OGDT7h228PGuIS4nHf
        omOnAjdFI73bLdf+BizMT55fO3p1+3AkrvAxOrA=
X-Google-Smtp-Source: AJdET5e98txJEX8hpF8aY80BAjq1C8tDuTNxTE3l8CqqWGFcB1ECg3grcLolZ/I1i46F14sYCYBC9/s19KBmjPal26I=
X-Received: by 2002:a6b:d307:: with SMTP id s7-v6mr10331408iob.190.1540362573610;
 Tue, 23 Oct 2018 23:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAEAjamtML1yMLL0DsV5JkD1H6P0Yg19F2DVq+_c-u09RaCKuDw@mail.gmail.com>
 <fcad3085-6801-71f9-b2cf-4c1702889d70@kernel.dk>
In-Reply-To: <fcad3085-6801-71f9-b2cf-4c1702889d70@kernel.dk>
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Wed, 24 Oct 2018 02:29:22 -0400
Message-ID: <CAEAjamtJrbLZyN+f97Y+LOMbogveYNBdxM-pVvfqUMhaGsH2uw@mail.gmail.com>
Subject: Re: UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32
To:     axboe@kernel.dk
Cc:     jikos@kernel.org, Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. The following should work.

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index a8cfa01..41160a1 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3146,6 +3146,9 @@ static int raw_cmd_copyin(int cmd, void __user *param=
,
                         */
                return -EINVAL;

+       if (ptr->cmd_count > ARRAY_SIZE(ptr->cmd))
+         return -EINVAL;
+
        for (i =3D 0; i < 16; i++)
                ptr->reply[i] =3D 0;
        ptr->resultcode =3D 0;
On Tue, Oct 23, 2018 at 6:01 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 10/22/18 5:20 PM, Kyungtae Kim wrote:
> > We report a bug found in v4.19-rc2 (v4.19-rc8 as well):
> > UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32
> >
> > kernel config: https://kt0755.github.io/etc/config_v2-4.19
> > repro: https://kt0755.github.io/etc/repro.b4076.c
> >
> > Analysis:
> >
> > struct floppy_raw_cmd {
> >    unsigned char cmd_count;
> >    unsigned char cmd[16];
> >   ...
> > };
> >
> > for (i=3D0; i<raw_cmd->cmd_count; i++)
> >     output_byte(raw_cmd->cmd[i])
> >
> > In driver/block/floppy.c:1495, the code snippet above is trying to
> > write some bytes to the floppy disk controller, depending on "cmd_count=
".
> > As you see "struct floppy_raw_cmd" above, the size of array =E2=80=9Ccm=
d=E2=80=9D is
> > fixed as 16.
> > The thing is, there is no boundary check for the index of array "cmd"
> > when this is used. Besides, "cmd_count" can be manipulated by raw_cmd_i=
octl
> > which is derived from ioctl system call.
> > We observed that cmd_count is set at line 2540 (or 2111), but that is
> > after such a bug arose in our experiment. So by manipulating system cal=
l ioctl,
> > user program can have illegitimate memory access.
> >
> > The following is a simple patch to stop this. (This might not be the
> > best.)
> >
> > diff --git a/linux-4.19-rc2/drivers/block/floppy.c
> > b/linux-4.19-rc2/drivers/block/floppy.c
> > index f2b6f4d..a3610c9 100644
> > --- a/linux-4.19-rc2/drivers/block/floppy.c
> > +++ b/linux-4.19-rc2/drivers/block/floppy.c
> > @@ -3149,6 +3149,8 @@ static int raw_cmd_copyin(int cmd, void __user *p=
aram,
> >                          */
> >                 return -EINVAL;
> >
> > +       if (ptr->cmd_count > ARRAY_SIZE(ptr->cmd)) {
> > +               return -EINVAL;
> > +
> >         for (i =3D 0; i < 16; i++)
> >                 ptr->reply[i] =3D 0;
> >         ptr->resultcode =3D 0;
>
> I think that's a decent way to fix it, but you probably want to
> test your patch - it doesn't compile. Send something you've
> tested that works.
>
> --
> Jens Axboe
>
