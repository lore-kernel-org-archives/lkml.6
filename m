Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916FCC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E382081B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3GHKc9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E382081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeJXPAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 11:00:48 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:34110 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeJXPAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 11:00:48 -0400
Received: by mail-it1-f195.google.com with SMTP id e81-v6so3402975itc.1;
        Tue, 23 Oct 2018 23:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+UvNXmiZwtZyHVA4XEPF2n/w7DO1Fy/It4bFEBqI7PM=;
        b=Z3GHKc9s6uissUYlV5Yg6paumpDIHBGz8aLG38EecIgXx7AtVTFNlGdQYOjCccjB22
         XVq+GHprDBqjkawOKnlgoe9QW0YaN1/3WDaUxlvNTEDfEwu4DCEOPbl5dsUSY7M2T1dR
         xbpeSqx2BRR9oAdmYJ4xH8UIg9BXt4Pbgo5YjJl9v8FIX2g4jZoC0vreKMcK8gANpNwy
         HI8H2CNE2TEDnf5lZlbvW0mQu3wcz33+zHDN2rBAfAlBAkLl0pbN3KmxbuzkrkCpYS4e
         SVUcmK1pRXdoAXYG3rUEiGk0qpemXm7e+eitNTy7ba8kRNVVw3Bh9XzZWlMZ6TINTEZs
         3idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+UvNXmiZwtZyHVA4XEPF2n/w7DO1Fy/It4bFEBqI7PM=;
        b=GA0vRmtPkzUGyS5WrUNtCq6mT1ZJrA73zWMOsZR73hdhov4CimFOBC+l+baurezjsv
         vGSxMwTfimQgsETXgOY/dSV4sB1Zi/DnMgoPBb7Mz0P2vUlE5457sbH3OYkVWitRaGkr
         J8yt2PKNt5O1iB4+G7w7dvyirZrNDJRKToyUy9W2rz9mBvtm68LLw/DUG4IygylaqDsM
         0SpW2frizTOWsHycmwO8hOCxDD/dHrJcGSr4lq70R0M3vaaVp+ErklN/Hno27iJDJBfL
         iVDN7QH/bXHCc3VVcPwhaF/fv3EmiH+StSCcAEhQeC0xGtaw7mfey5/hqbZ9AA6J5BAT
         +TRw==
X-Gm-Message-State: AGRZ1gIDYIZXwlgNkDSJkGkdPwubixNQhPSpca2qJMnQfUznp3QYyPpu
        6w5P8eoOJRR9lNV6n0A/u1km7SIa/jvzo5gN35Y=
X-Google-Smtp-Source: AJdET5dge/ogJJQ026r/+SwdUnptzu4Y99hrPKmaBjJa3BHFRwWDXWl7Cd2AVA0XnTTg1Z3dxofiY9E1xMqvHXvFlcc=
X-Received: by 2002:a24:9790:: with SMTP id k138-v6mr717864ite.69.1540362846432;
 Tue, 23 Oct 2018 23:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAEAjamtML1yMLL0DsV5JkD1H6P0Yg19F2DVq+_c-u09RaCKuDw@mail.gmail.com>
 <fcad3085-6801-71f9-b2cf-4c1702889d70@kernel.dk> <CAEAjamtJrbLZyN+f97Y+LOMbogveYNBdxM-pVvfqUMhaGsH2uw@mail.gmail.com>
In-Reply-To: <CAEAjamtJrbLZyN+f97Y+LOMbogveYNBdxM-pVvfqUMhaGsH2uw@mail.gmail.com>
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Wed, 24 Oct 2018 02:33:55 -0400
Message-ID: <CAEAjams3Y4PE-yDP0FyipCAohOepSF9WgXw3h_CEd1YW+mjS0g@mail.gmail.com>
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

Corrected.


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


Thanks,
Kyungtae Kim
On Wed, Oct 24, 2018 at 2:29 AM Kyungtae Kim <kt0755@gmail.com> wrote:
>
> Thanks. The following should work.
>
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index a8cfa01..41160a1 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -3146,6 +3146,9 @@ static int raw_cmd_copyin(int cmd, void __user *par=
am,
>                          */
>                 return -EINVAL;
>
> +       if (ptr->cmd_count > ARRAY_SIZE(ptr->cmd))
> +         return -EINVAL;
> +
>         for (i =3D 0; i < 16; i++)
>                 ptr->reply[i] =3D 0;
>         ptr->resultcode =3D 0;
> On Tue, Oct 23, 2018 at 6:01 AM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 10/22/18 5:20 PM, Kyungtae Kim wrote:
> > > We report a bug found in v4.19-rc2 (v4.19-rc8 as well):
> > > UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32
> > >
> > > kernel config: https://kt0755.github.io/etc/config_v2-4.19
> > > repro: https://kt0755.github.io/etc/repro.b4076.c
> > >
> > > Analysis:
> > >
> > > struct floppy_raw_cmd {
> > >    unsigned char cmd_count;
> > >    unsigned char cmd[16];
> > >   ...
> > > };
> > >
> > > for (i=3D0; i<raw_cmd->cmd_count; i++)
> > >     output_byte(raw_cmd->cmd[i])
> > >
> > > In driver/block/floppy.c:1495, the code snippet above is trying to
> > > write some bytes to the floppy disk controller, depending on "cmd_cou=
nt".
> > > As you see "struct floppy_raw_cmd" above, the size of array =E2=80=9C=
cmd=E2=80=9D is
> > > fixed as 16.
> > > The thing is, there is no boundary check for the index of array "cmd"
> > > when this is used. Besides, "cmd_count" can be manipulated by raw_cmd=
_ioctl
> > > which is derived from ioctl system call.
> > > We observed that cmd_count is set at line 2540 (or 2111), but that is
> > > after such a bug arose in our experiment. So by manipulating system c=
all ioctl,
> > > user program can have illegitimate memory access.
> > >
> > > The following is a simple patch to stop this. (This might not be the
> > > best.)
> > >
> > > diff --git a/linux-4.19-rc2/drivers/block/floppy.c
> > > b/linux-4.19-rc2/drivers/block/floppy.c
> > > index f2b6f4d..a3610c9 100644
> > > --- a/linux-4.19-rc2/drivers/block/floppy.c
> > > +++ b/linux-4.19-rc2/drivers/block/floppy.c
> > > @@ -3149,6 +3149,8 @@ static int raw_cmd_copyin(int cmd, void __user =
*param,
> > >                          */
> > >                 return -EINVAL;
> > >
> > > +       if (ptr->cmd_count > ARRAY_SIZE(ptr->cmd)) {
> > > +               return -EINVAL;
> > > +
> > >         for (i =3D 0; i < 16; i++)
> > >                 ptr->reply[i] =3D 0;
> > >         ptr->resultcode =3D 0;
> >
> > I think that's a decent way to fix it, but you probably want to
> > test your patch - it doesn't compile. Send something you've
> > tested that works.
> >
> > --
> > Jens Axboe
> >
