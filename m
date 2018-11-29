Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD0FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E99520834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiCZgyg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E99520834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbeK2VBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:01:04 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37660 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeK2VBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:01:04 -0500
Received: by mail-yw1-f67.google.com with SMTP id h193so514838ywc.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 01:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8lj8HfQlbYp0lUo4X77lG3OK7OV4eosqnu5EAnjc+Eg=;
        b=hiCZgyg+FSDR1cr1WAjmus4korBxUjgDXR7UHKcscFdMvwIf6Cd/IuH5/Jw+aWLfa5
         otiR2xFg4OGNi/gBmOgBwKEpwoDkDvpa6GNutmH9pb4FL7qfUQgKaYu9VvcNJmZYyM/s
         0603xqarUJUbGbLY2sjqrX8nI2d7IhtsjqJKxOVxoKuYoWL6ztITwx69jfFw40WGQNHY
         hk72+aKSXzzNW0OSSxy2NbK6C2PBqI96leMc2PDw8JO7iMcmlqsC5mJ7+2W2Fb3Z4mg3
         djgti1DSAO1S2owSbXLYzjRWBDOgM5JZM6WB25jAvPEEotXmPEXWFpXhfuTehx5XC+MQ
         rwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8lj8HfQlbYp0lUo4X77lG3OK7OV4eosqnu5EAnjc+Eg=;
        b=QOoNajSTnqe1fyOfDf/SjVLaTI6Z7IG1cjtxPiEEOGWFQ6vCocbAe4xS72mmQ/+gaz
         MtLd8x9Ld9q75nb05p4m6vKir6s2rPVOxXpWIpuoktd+i+6kTW7Mz2azn5Jhzzuy7E5S
         /E5qsiUqWQsndgGB5/BBbqfPiCby1NIFC9BEU+8lix1StvsFhOUvMCO3q5cSC2FGDZMM
         7GkNqbuSa2OT6DiSO0BUny79JzcXeUXV2VeDCOZhNXSd6uDhnxD3TdT6b+MqGsKRj6XS
         pVOuk3oF9RQ5ghC++yUY6XYyr4WFFxNFMZHOy7yrD7S9c+4gph+VqyD8SDNeDL3JYdCx
         Lu+A==
X-Gm-Message-State: AA+aEWZqh+i5C0Hi8/vYNUY2rh3Juzqt8KAHkFUBVHbNPjOZMoC6LOky
        ZFtSudL/kuXTYZ4Kas9lSDnkVdaehbuIKAGBoqE=
X-Google-Smtp-Source: AFSGD/VAgm6f7zavqdKkALksa/k70gVExzFpLrmMCU6ipa3XgnVMPWOIm2lmfwGZySWRN2zpzw9EJnsMFaReH4AcJkU=
X-Received: by 2002:a0d:fd05:: with SMTP id n5-v6mr650672ywf.46.1543485373473;
 Thu, 29 Nov 2018 01:56:13 -0800 (PST)
MIME-Version: 1.0
References: <1543411097-24229-1-git-send-email-frieder.schrempf@kontron.de>
In-Reply-To: <1543411097-24229-1-git-send-email-frieder.schrempf@kontron.de>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 29 Nov 2018 10:56:02 +0100
Message-ID: <CAJiuCcdEo4-fZBCvrEJV-GLU_3izbu9VTjj-biCEKaAjeYxOrg@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: spinand: Fix ECC status and OOB layout for
 Toshiba TC58CVG2S0H
To:     frieder.schrempf@kontron.de
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>, richard@nod.at,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder,

On Wed, 28 Nov 2018 at 14:18, Schrempf Frieder
<frieder.schrempf@kontron.de> wrote:
>
> When reading the status of the on-chip ECC, the Toshiba chip returns
> two different states for reporting corrected bitflips. We should check
> for both of them.
>
> Also return the free OOB bytes as one contiguous area, instead of
> multiple sections.
>
> Suggested-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Acked-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
>  drivers/mtd/nand/spi/toshiba.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshib=
a.c
> index 294bcf6..9731752 100644
> --- a/drivers/mtd/nand/spi/toshiba.c
> +++ b/drivers/mtd/nand/spi/toshiba.c
> @@ -11,6 +11,7 @@
>  #include <linux/mtd/spinand.h>
>
>  #define SPINAND_MFR_TOSHIBA            0x98
> +#define TOSH_STATUS_ECC_HAS_BITFLIPS_T (3 << 4)
>
>  static SPINAND_OP_VARIANTS(read_cache_variants,
>                 SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> @@ -33,19 +34,17 @@ static int tc58cvg2s0h_ooblayout_ecc(struct mtd_info =
*mtd, int section,
>         region->offset =3D 128 + 16 * section;
>         region->length =3D 16;
>
> -
>         return 0;
>  }
>
>  static int tc58cvg2s0h_ooblayout_free(struct mtd_info *mtd, int section,
>                                       struct mtd_oob_region *region)
>  {
> -       if (section > 7)
> +       if (section > 0)
>                 return -ERANGE;
>
> -       region->offset =3D 2 + 16 * section;
> -       region->length =3D 14;
> -

I will just add a comment here to say that we reserve 2 bytes for BBM.

Else, it's fine for me.

Regards,
Clement

> +       region->offset =3D 2;
> +       region->length =3D 126;
>
>         return 0;
>  }
> @@ -70,6 +69,7 @@ static int tc58cvg2s0h_ecc_get_status(struct spinand_de=
vice *spinand,
>                 return -EBADMSG;
>
>         case STATUS_ECC_HAS_BITFLIPS:
> +       case TOSH_STATUS_ECC_HAS_BITFLIPS_T:
>                 /*
>                  * Let's try to retrieve the real maximum number of bitfl=
ips
>                  * in order to avoid forcing the wear-leveling layer to m=
ove
> --
> 2.7.4
