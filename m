Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9654AECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A0320882
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+yi01bd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A0320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeIOGhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:37:51 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35134 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725746AbeIOGhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:37:51 -0400
Received: by mail-qt0-f193.google.com with SMTP id j7-v6so10494663qtp.2;
        Fri, 14 Sep 2018 18:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bQFUf4CE1xts/aF6MMKroo2UrvrAeve9ybZOKVzV0c4=;
        b=D+yi01bdTKNQSI2BRI++aWKm3gQu7VrODhQem5ePO2aK8+ZBa38HGLTbJbL02sIcPS
         rRBhXN3Z6/bGJTIcEyh3YRUZ5wimBNg9Uwe2Gm2yHw2p7SnpvuUGpaRAqbYdrM80OJGI
         PHo48JHslugIe01BwWqE3SYPsWooXqCztiCAk7LsVJnXn/z3rlRuEYhhO4nsGnL+ASyL
         bFbjlMeQahZbOAG8UUS+ifs4K8yviX7ahUVq9NVvsnuukB1Qo4pnrG8vkkaMrB42RGst
         nXvKGdU/4aEoau72onIYLTJvZhlIA9sqBeyP8m+4Tf6lfQVRwyeKB7oHwLKn0VDkiM0Y
         Ihyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bQFUf4CE1xts/aF6MMKroo2UrvrAeve9ybZOKVzV0c4=;
        b=Kedc1bZzNhzZ8pS6dNqBBJoS6/4iyMa+INNr7F1cmYoaH3tcj+OqFEfKMQIlBWX+89
         AHdekSXOeZ3z2J2p7vOOhVK4uX10BGZou0pwuCNtGH2LAVcaD0fyCTxf2pDcU3sfrlbW
         RGEkReyTJR3dswI2vCUHEvb0oFwFKBQoAV54iaYLeM9J+//bn7Jar076dXtPXxmZ5luR
         TAe52mlQd56WPB89NZXpz3S4fzDSqA4CTbgR/fabyij15rH7iISHddmAayJ/GbSRpcYE
         mexuLgiX0G0+42MQRhFJ0mOM/2H8NrYK8P93pxszPMLzZ2X7HB2p/jNfW2LSTM3y2vfq
         Z8Sg==
X-Gm-Message-State: APzg51D/oSwF3jEnCWtrR20pVg4cw91/nPCcVmUrYgIJcq56S6PEdKLU
        Ru/7Zn3vf0hLTjahKluwxkt3CAj4C4UB5jbreTI=
X-Google-Smtp-Source: ANB0VdZbQ3EHtehy4b2maqep5zjXLwqSXfQCPZcY1XDDgSwn4NbOS0m8nuWrQWIVS8pqlmwK70ZitAk7cl0K2U/CZTc=
X-Received: by 2002:a0c:ae71:: with SMTP id z46-v6mr10967900qvc.108.1536974455433;
 Fri, 14 Sep 2018 18:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180914101259.4169-1-cdbdyx@163.com>
In-Reply-To: <20180914101259.4169-1-cdbdyx@163.com>
From:   Junhui Tang <tang.junhui.linux@gmail.com>
Date:   Sat, 15 Sep 2018 09:20:11 +0800
Message-ID: <CA+NNRhER-MdM=ufG0-gOPRvGysR5FuDvFRJtRNf7TX6yQDpH7w@mail.gmail.com>
Subject: Re: [PATCH 2/2] add some safety checks for label store interface of
 flash dev in sysfs
To:     cdbdyx@163.com
Cc:     colyli@suse.de, Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems something wrong
when  size =3D SB_LABEL_SIZE and   u->label[size - 1] !=3D '\n'
please check again.

---------------------------------------------------------------------------
Tang Junhui
Forever me is me
---------------------------------------------------------------------------

Dongbo Cao <cdbdyx@163.com> =E4=BA=8E2018=E5=B9=B49=E6=9C=8814=E6=97=A5=E5=
=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:13=E5=86=99=E9=81=93=EF=BC=9A
>
> do some checks on the label's length and ending.
>
> Signed-off-by: Dongbo Cao <cdbdyx@163.com>
> ---
>  drivers/md/bcache/sysfs.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
> index e64c718f..cce793ef 100644
> --- a/drivers/md/bcache/sysfs.c
> +++ b/drivers/md/bcache/sysfs.c
> @@ -447,8 +447,15 @@ STORE(__bch_flash_dev)
>         }
>
>         if (attr =3D=3D &sysfs_label) {
> +               if (size > SB_LABEL_SIZE)
> +                       return -EINVAL;
>                 memcpy(u->label, buf, SB_LABEL_SIZE);
> -               bch_uuid_write(d->c);
> +               if (size < SB_LABEL_SIZE)
> +                       u->label[size] =3D '\0';
> +               if (size && u->label[size - 1] =3D=3D '\n')
> +                       u->label[size - 1] =3D '\0';
> +               if(d->c)
> +                       bch_uuid_write(d->c);
>         }
>
>         if (attr =3D=3D &sysfs_unregister) {
> --
> 2.17.1
>
>
