Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEF7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB032145D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9Oast7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB032145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbeK1EBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:01:02 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34087 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeK1EBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:01:02 -0500
Received: by mail-yb1-f193.google.com with SMTP id a67-v6so7819491ybg.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aJywAevii2RT5FY+K1FiO59eTApeSkzVEUb16XGRmlU=;
        b=O9Oast7AggQiUYblGK7Xae2Vn2+uHa7a7zxQE2V0yJcX0ZjkMpxZHTXZP0KNQv5u0I
         tj5/TRVqQGo6c7Lt7OJziOXEae7ZnRp1CeFPL01oS/SZmRUclE0zQOwrhmxS9vM+nLxV
         qh27KHqbhAivIhK5Ssd5YKVaqAlWx9/9hh/mRkHElnX2tySQm6SMd13Av5/IEqDTY982
         NzHH3HXcBWgiJaxFet15dtoULspzTqBXM+Mvbzw0iPQUtfLSgIvxGhH/xmd59sZbWDid
         /eZPWkhaBgxV6UjMgTTac/MjLxNewKWFLSgYzwWL/5ezKHRcI/0RGfEJkan5ILp16Xdw
         gUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aJywAevii2RT5FY+K1FiO59eTApeSkzVEUb16XGRmlU=;
        b=WC6UXggvRgOKOpP2Izg2O3ETwPANHqf5/CbBYzsGxW73POcj2yePr29EEmEfzZRKfO
         aJiINa7IQ56/vAdiuXKgdT8dsaDKVng1em3JPuUURm98PnAMPjJ3hXB7yp3h8wTdEJBB
         UxlCT5N0N8+92TfMyjlIUzXa2LfHK6M7MJcuxBhO5JE8Vdy6PYPtfR0c455HmOlP78uH
         vxAfV0F4Vrb3qaWNL8Nk1b784oxPiCNtGTAkpRWsEvpWgNHgBiiBbqipjKEzp+WA/wuZ
         nNvwowdALShmNrKOTKgupY/VrPPB/K42d4XF7Gn97zXMgkuNc0X6rDeBa786sdDY0MVC
         VsCg==
X-Gm-Message-State: AA+aEWa1GZXQ6NVDu4/MSv3OaTjVSfUsTsW9G0c/hVlxNUn7f5Ef9tU4
        vXgXyNdSbTNiiEZobPintpWdWjooHI6QCedvhFQ=
X-Google-Smtp-Source: AJdET5dzuRvgMtQ2qHUUEkXPUl5ePN9DJoPtPwf8t8n4Zaped+S+6a0hVKWhGVIed8GlLCZPTEzSQIDXI5WFxAOidbc=
X-Received: by 2002:a25:6604:: with SMTP id a4-v6mr34046006ybc.92.1543338148596;
 Tue, 27 Nov 2018 09:02:28 -0800 (PST)
MIME-Version: 1.0
References: <1541665796-21092-1-git-send-email-frieder.schrempf@kontron.de>
 <0fc1f198-0e87-01af-5a0e-3d21613c39f3@kontron.de> <CAJiuCceD=qyasCUPqjyGQso3JGoxz4g_yg3uj18wP-2CKY9wyg@mail.gmail.com>
 <1655b66f-37e2-427f-a047-8305f86fc22c@kontron.de>
In-Reply-To: <1655b66f-37e2-427f-a047-8305f86fc22c@kontron.de>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 27 Nov 2018 18:02:17 +0100
Message-ID: <CAJiuCcdnqeJO4MQh8Ru010amQkvG1Wc3=N3o1_X4QAhF-_M7tA@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: spi: Add initial support for Toshiba TC58CVG2S0H
To:     frieder.schrempf@kontron.de
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>, richard@nod.at,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marek.vasut@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder,

On Tue, 27 Nov 2018 at 17:42, Schrempf Frieder
<frieder.schrempf@kontron.de> wrote:
>
> Hi Cl=C3=A9ment,
>
> On 27.11.18 16:18, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Frieder,
> >
> > On Tue, 27 Nov 2018 at 16:08, Schrempf Frieder
> > <frieder.schrempf@kontron.de> wrote:
> >>
> >> +Cl=C3=A9ment P=C3=A9ron
> >>
> >> Hi Cl=C3=A9ment,
> >>
> >> FYI, this has already been merged to nand/next.
> > Just want to point the difference that I made when I try to introduce m=
y driver.
> > The datasheet I used is this one :
> > https://media.digikey.com/pdf/Data%20Sheets/Toshiba%20PDFs/TC58CVG2S0Hx=
AIx_Rev1.1_2016-11-08.pdf
> >
> >>
> >> Regards,
> >> Frieder
> >>
> >> On 08.11.18 09:29, Frieder Schrempf wrote:
> >>> Add minimal support for the Toshiba TC58CVG2S0H SPI NAND chip.
> >>>
> >>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>> ---
> >>>    drivers/mtd/nand/spi/Makefile  |   2 +-
> >>>    drivers/mtd/nand/spi/core.c    |   1 +
> >>>    drivers/mtd/nand/spi/toshiba.c | 136 +++++++++++++++++++++++++++++=
+++++++
> >>>    include/linux/mtd/spinand.h    |   1 +
> >>>    4 files changed, 139 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Mak=
efile
> >>> index b74e074..be5f735 100644
> >>> --- a/drivers/mtd/nand/spi/Makefile
> >>> +++ b/drivers/mtd/nand/spi/Makefile
> >>> @@ -1,3 +1,3 @@
> >>>    # SPDX-License-Identifier: GPL-2.0
> >>> -spinand-objs :=3D core.o macronix.o micron.o winbond.o
> >>> +spinand-objs :=3D core.o macronix.o micron.o toshiba.o winbond.o
> >>>    obj-$(CONFIG_MTD_SPI_NAND) +=3D spinand.o
> >>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.=
c
> >>> index 30f8364..87bdf2a 100644
> >>> --- a/drivers/mtd/nand/spi/core.c
> >>> +++ b/drivers/mtd/nand/spi/core.c
> >>> @@ -766,6 +766,7 @@ static const struct nand_ops spinand_ops =3D {
> >>>    static const struct spinand_manufacturer *spinand_manufacturers[] =
=3D {
> >>>        &macronix_spinand_manufacturer,
> >>>        &micron_spinand_manufacturer,
> >>> +     &toshiba_spinand_manufacturer,
> >>>        &winbond_spinand_manufacturer,
> >>>    };
> >>>
> >>> diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/to=
shiba.c
> >>> new file mode 100644
> >>> index 0000000..294bcf6
> >>> --- /dev/null
> >>> +++ b/drivers/mtd/nand/spi/toshiba.c
> >>> @@ -0,0 +1,136 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> + * Copyright (c) 2018 exceet electronics GmbH
> >>> + * Copyright (c) 2018 Kontron Electronics GmbH
> >>> + *
> >>> + * Author: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>> + */
> >>> +
> >>> +#include <linux/device.h>
> >>> +#include <linux/kernel.h>
> >>> +#include <linux/mtd/spinand.h>
> >>> +
> >>> +#define SPINAND_MFR_TOSHIBA          0x98
> >>> +
> >>> +static SPINAND_OP_VARIANTS(read_cache_variants,
> >>> +             SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> >>> +             SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> >>> +             SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> >>> +             SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> >>> +
> >>> +static SPINAND_OP_VARIANTS(write_cache_variants,
> >>> +             SPINAND_PROG_LOAD(true, 0, NULL, 0));
> >>> +
> >>> +static SPINAND_OP_VARIANTS(update_cache_variants,
> >>> +             SPINAND_PROG_LOAD(false, 0, NULL, 0));
> >>> +
> >>> +static int tc58cvg2s0h_ooblayout_ecc(struct mtd_info *mtd, int secti=
on,
> >>> +                                  struct mtd_oob_region *region)
> >>> +{
> >>> +     if (section > 7)
> >>> +             return -ERANGE;
> >>> +
> >>> +     region->offset =3D 128 + 16 * section;
> >>> +     region->length =3D 16;
> >
> > Here you expose the ECC bits has 8 sections of 16 bytes.
> > But regarding the datasheet this should not be accessed page 32.
> > "The ECC parity code generated by internal ECC is stored in column
> > addresses 4224-4351 and the users cannot access to these specific
> > addresses when internal ECC is enabled."
>
> This is just to let the other layers know, where the bytes used for ECC
> are. As long as the driver uses the on-chip ECC it won't write to this
> area. So this is correct unless I misunderstood this concept. All the
> other supported SPI NAND chips use the same approach.

Ok for not write, but are you sure that if we try to read them the SPI
will respond something logic and not some garbage ?
When I read the datasheet it looks like that the read cmd will stop or
send some random value when trying to read these columns.

>
> >
> >>> +
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static int tc58cvg2s0h_ooblayout_free(struct mtd_info *mtd, int sect=
ion,
> >>> +                                   struct mtd_oob_region *region)
> >>> +{
> >>> +     if (section > 7)
> >>> +             return -ERANGE;
> >>> +
> >>> +     region->offset =3D 2 + 16 * section;
> >>> +     region->length =3D 14;
> >
> > This reserved 2 bytes for BBM for each section.
> > But maybe we could declare this as 1 section of 128bytes:
> >
> > if (section)
> >           return -ERANGE;
> >
> > region->offset =3D 2;
> > region->length =3D 126;
>
> The datasheet (p. 32) describes that the OOB data of a page is divided
> into 8 sections. So why should we not reflect this in the software?
> Probably it would be sufficient to reserve two bytes for the bad block
> marker at the beginning, instead of two bytes in each section. But I'm
> not sure about this and it doesn't really hurt.

If the OOB are used one day (I think it's not the case actually), It
will be more efficient to do only one request.

Regards, Clement

> >
> >>> +
> >>>
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static const struct mtd_ooblayout_ops tc58cvg2s0h_ooblayout =3D {
> >>> +     .ecc =3D tc58cvg2s0h_ooblayout_ecc,
> >>> +     .free =3D tc58cvg2s0h_ooblayout_free,
> >>> +};
> >>> +
> >>> +static int tc58cvg2s0h_ecc_get_status(struct spinand_device *spinand=
,
> >>> +                                   u8 status)
> >>> +{
> >>> +     struct nand_device *nand =3D spinand_to_nand(spinand);
> >>> +     u8 mbf =3D 0;
> >>> +     struct spi_mem_op op =3D SPINAND_GET_FEATURE_OP(0x30, &mbf);
> >>> +
> >>> +     switch (status & STATUS_ECC_MASK) {
> >>> +     case STATUS_ECC_NO_BITFLIPS:
> >>> +             return 0;
> >>> +
> >>> +     case STATUS_ECC_UNCOR_ERROR:
> >>> +             return -EBADMSG;
> >>> +
> >>> +     case STATUS_ECC_HAS_BITFLIPS:
> >>> +             /*
> >>> +              * Let's try to retrieve the real maximum number of bit=
flips
> >>> +              * in order to avoid forcing the wear-leveling layer to=
 move
> >>> +              * data around if it's not necessary.
> >>> +              */
> >>> +             if (spi_mem_exec_op(spinand->spimem, &op))
> >>> +                     return nand->eccreq.strength;
> >>> +
> >>> +             mbf >>=3D 4;
> >>> +
> >>> +             if (WARN_ON(mbf > nand->eccreq.strength || !mbf))
> >>> +                     return nand->eccreq.strength;
> >>> +
> >>> +             return mbf;
> >>> +
> >
> > These take take care of 0, 0x1 and 0x2 but not 0x3 which is valid
>
> Hm, you're right. We don't care if it is 0x1 or 0x3 (both mean that
> bitflips were corrected), but we currently only check for 0x1.
>
> I will send a fix for this tomorrow.
>
> Thanks,
> Frieder
>
> > page 26 of the datasheet :
> >
> > ECC status bits indicate the status of internal ECC operation
> > 00b: No bit flips were detected in previous page read.
> > 01b: Bit flips were detected and corrected. Bit flip count did not
> > exceed the bit flip detection threshold. The threshold is set by bits
> > [7:4] in address 10h in the feature table.
> > 10b: Multiple bit flips were detected and not corrected.
> > 11b: Bit flips were detected and corrected. Bit flip count exceeded
> > the bit flip detection threshold. The threshold is set by bits [7:4]
> > in address 10h in the feature table
> >
> > Regards,
> > Clement
> >
> >>> +     default:
> >>> +             break;
> >>> +     }
> >>> +
> >>> +     return -EINVAL;
> >>> +}
> >>> +
> >>> +static const struct spinand_info toshiba_spinand_table[] =3D {
> >>> +     SPINAND_INFO("TC58CVG2S0H", 0xCD,
> >>> +                  NAND_MEMORG(1, 4096, 256, 64, 2048, 1, 1, 1),
> >>> +                  NAND_ECCREQ(8, 512),
> >>> +                  SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> >>> +                                           &write_cache_variants,
> >>> +                                           &update_cache_variants),
> >>> +                  SPINAND_HAS_QE_BIT,
> >>> +                  SPINAND_ECCINFO(&tc58cvg2s0h_ooblayout,
> >>> +                                  tc58cvg2s0h_ecc_get_status)),
> >>> +};
> >>> +
> >>> +static int toshiba_spinand_detect(struct spinand_device *spinand)
> >>> +{
> >>> +     u8 *id =3D spinand->id.data;
> >>> +     int ret;
> >>> +
> >>> +     /*
> >>> +      * Toshiba SPI NAND read ID needs a dummy byte,
> >>> +      * so the first byte in id is garbage.
> >>> +      */
> >>> +     if (id[1] !=3D SPINAND_MFR_TOSHIBA)
> >>> +             return 0;
> >>> +
> >>> +     ret =3D spinand_match_and_init(spinand, toshiba_spinand_table,
> >>> +                                  ARRAY_SIZE(toshiba_spinand_table),
> >>> +                                  id[2]);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     return 1;
> >>> +}
> >>> +
> >>> +static const struct spinand_manufacturer_ops toshiba_spinand_manuf_o=
ps =3D {
> >>> +     .detect =3D toshiba_spinand_detect,
> >>> +};
> >>> +
> >>> +const struct spinand_manufacturer toshiba_spinand_manufacturer =3D {
> >>> +     .id =3D SPINAND_MFR_TOSHIBA,
> >>> +     .name =3D "Toshiba",
> >>> +     .ops =3D &toshiba_spinand_manuf_ops,
> >>> +};
> >>> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.=
h
> >>> index 088ff96..816c4b0 100644
> >>> --- a/include/linux/mtd/spinand.h
> >>> +++ b/include/linux/mtd/spinand.h
> >>> @@ -196,6 +196,7 @@ struct spinand_manufacturer {
> >>>    /* SPI NAND manufacturers */
> >>>    extern const struct spinand_manufacturer macronix_spinand_manufact=
urer;
> >>>    extern const struct spinand_manufacturer micron_spinand_manufactur=
er;
> >>> +extern const struct spinand_manufacturer toshiba_spinand_manufacture=
r;
> >>>    extern const struct spinand_manufacturer winbond_spinand_manufactu=
rer;
> >>>
> >>>    /**
> >>>
