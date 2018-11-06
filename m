Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C85CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E1620827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fL6NNclU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E1620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbeKFRBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 12:01:40 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46179 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbeKFRBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 12:01:39 -0500
Received: by mail-lf1-f68.google.com with SMTP id f23so3529422lfc.13;
        Mon, 05 Nov 2018 23:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nhk9tgRJPO1OgSqC6y/I3b4xengCg3+eMjxq179bAls=;
        b=fL6NNclUFvfRF1HNWDy5QY8QTYWCQhCAdZt3CX6V4hrPSYBlOh2K3QNKvvBNgCQ6xq
         9eK3MjmCjjhDMI1O+hEXIBbyfP1bA7hs3TnSdX5bRR77GJF4g7nSxR2iKUOaH5kaquia
         ktSWLgeV+CH12MTlwME+w13oyOYsQCF8J2rAa9xkOqvqwtbsi9m89MfsoFGESfp+v2gC
         iXCOgmzLvXWYVpjVuN9m9vfLZwuMSifZ6sRCsYdoTQP/WCzT+doFeWcWfOll//fgJrZz
         /37AD1KGS4Pt4Gy0P80Epcr5kUO4DtVj9OLShE2H5ao2gWKvj1krcBKbMiHQW1hYYFWf
         dk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nhk9tgRJPO1OgSqC6y/I3b4xengCg3+eMjxq179bAls=;
        b=FMfoAGR+EP1gKIsalIL88C4+idgZYzknokm4CXlMbUN/yAXARlBAbi7QMTXNfuwgxL
         tl+ADiWbDyRc3RW6gwEsVRVHuai6EaeEg5+a2aoxewAR3rZIxjE+m1SZxsKPRZV/79+F
         zKxICF2jm7tsLZj8F5mAPBgIRau7CSd0NwZf3UZgfH8EfRy7uFnTLb5ofG7hRIWWfRbs
         m6663JB75UNp7PNwP37cDuj64A89BrMAlBcXr4G6Dw7KdEUKEzcldmSYzGXzT3amYHbu
         IuQhehWdBTTPM++AGi333Yi6HWr8zKcM4tOZmuwli35H10JaUyO8cm0b+TW5tgSvUKnR
         9o/A==
X-Gm-Message-State: AGRZ1gKpt75OEJKv99UOTnQ3ou8Z1c4RHUGX7Tic0nAMFrDZzJcYb4ac
        2A8gTDuQHtbhWTUzkxdqfnEYC/a4g0Yp3WF6bCn0d5ZPHKA=
X-Google-Smtp-Source: AJdET5d7xwT5/YAvI7So3dS5H0HyGizcy5bMZ9jSwtEFXtHgcuy4u9FW6jtPyOL2JJaQw9iR9UiLaQYQ+7/+eb4qbP0=
X-Received: by 2002:a19:ec09:: with SMTP id b9mr9946529lfa.65.1541489864164;
 Mon, 05 Nov 2018 23:37:44 -0800 (PST)
MIME-Version: 1.0
References: <20181031230541.28822-1-sashal@kernel.org> <20181031230541.28822-118-sashal@kernel.org>
In-Reply-To: <20181031230541.28822-118-sashal@kernel.org>
From:   Jack Wang <jack.wang.usish@gmail.com>
Date:   Tue, 6 Nov 2018 08:37:32 +0100
Message-ID: <CA+res+QxUmb2B=Owy3+PV_Jgsm0DBshF3RYzhcTEMnGepOZ_qg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 118/146] MD: fix invalid stored role for a disk
To:     sashal@kernel.org
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org, shli@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sasha Levin <sashal@kernel.org> =E4=BA=8E2018=E5=B9=B411=E6=9C=881=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:45=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Shaohua Li <shli@fb.com>
>
> [ Upstream commit d595567dc4f0c1d90685ec1e2e296e2cad2643ac ]
>
> If we change the number of array's device after device is removed from ar=
ray,
> then add the device back to array, we can see that device is added as act=
ive
> role instead of spare which we expected.
>
> Please see the below link for details:
> https://marc.info/?l=3Dlinux-raid&m=3D153736982015076&w=3D2
>
> This is caused by that we prefer to use device's previous role which is
> recorded by saved_raid_disk, but we should respect the new number of
> conf->raid_disks since it could be changed after device is removed.
>
> Reported-by: Gioh Kim <gi-oh.kim@profitbricks.com>
> Tested-by: Gioh Kim <gi-oh.kim@profitbricks.com>
> Acked-by: Guoqing Jiang <gqjiang@suse.com>9e753ba9b9b405e3902d9f08aec5f2e=
a58a0c317
> Signed-off-by: Shaohua Li <shli@fb.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
Hi Sasha,

This patch breaks linear hotadd please also include  commit
9e753ba9b9b405e3902d9f08aec5f2ea58a0c317
MD: fix invalid stored role for a disk - try2

Regards,
Jack Wang

> ---
>  drivers/md/md.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 8668793262d0..85459c17cc60 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -1776,6 +1776,10 @@ static int super_1_validate(struct mddev *mddev, s=
truct md_rdev *rdev)
>                         } else
>                                 set_bit(In_sync, &rdev->flags);
>                         rdev->raid_disk =3D role;
> +                       if (role >=3D mddev->raid_disks) {
> +                               rdev->saved_raid_disk =3D -1;
> +                               rdev->raid_disk =3D -1;
> +                       }
>                         break;
>                 }
>                 if (sb->devflags & WriteMostly1)
> --
> 2.17.1
>
