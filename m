Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C26C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C192082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRsDgUA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbfBDMdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:33:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37476 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730138AbfBDMdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:33:03 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so6701243pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 04:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wB9H8jqgyz2EUqzphuqcub7WdveCpX3EBCAZf+vLVx4=;
        b=GRsDgUA85radMr1fM2vbdJcXWXvtABynpRRs/x6Oeuap4jre1TrUXoWEAg/ZxGcQdE
         9gM4+IO2UzQYIP0TBy9gOG0d+E5DHvU+5UX4AObEK2YpaZ9r3UuedO8lWSLc9uTNOLCZ
         OzfuIEmylIfE/dVnKRUOTehkTw5WylYnk0sBgD7SnG6W9fI8BvkaND3VGOCafAiFRxHx
         rudWzpUGTvt227tBJC6XxoVlkFvGPtYDJ4EKxApLvRI1XTo0M4IWn/DRqHkn792SwK/U
         S9TCbLOddmbFLXhn7ic0hzSrdylwB401xKHRYyCnTzBt+pLajVRBhiPcbCzfyHTJshGD
         PV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wB9H8jqgyz2EUqzphuqcub7WdveCpX3EBCAZf+vLVx4=;
        b=o+DDZr+scA98oGH0202Rl2ykXLmOsIrj8whkjAPQiVkS1W10yYwPpSmzc1xiWToEtl
         cMoxjNI3b9e7MzYEZEeXpURUlVMuWotoIdEhtHoKizk/XL0VHO0UIzKwbWa0+HPHUSCr
         9yBraL0+PeDPr4LHhV1AMudc4sX6RxaZZzOcPUk9vWjMTJpn6J5PAEI+YLDWo2K/yius
         siobnsQnReDafALRuM7wfLeCImp/ry8voSEZj9qVg+c3vVzjGecqxhF2OEqlyhAgZG5U
         NPJz8HRKUq+fzWvRdJLerpb+Jt6tc3S4Z8dksK4b2M51tt0LI0T0T1lxTLboevUoZdge
         wo3A==
X-Gm-Message-State: AHQUAubuqCKhjo6pMs9/HPQ4hNLsad18cqiNlb43ye0/r7zm6XpUTLfo
        ac2oIabk3MvUnTyY1oQ6Ya+9OKBrdMLxuIjmFsk=
X-Google-Smtp-Source: AHgI3IZSw1rIjh/+ufuN3We3ogfDte1s/L8oXUlOybDpy/1F438xeubtYnQse8LbOYWrH5uzptcGmePrZtze9LvtdQQ=
X-Received: by 2002:a63:ac1a:: with SMTP id v26mr12925120pge.293.1549283582574;
 Mon, 04 Feb 2019 04:33:02 -0800 (PST)
MIME-Version: 1.0
References: <MN2PR08MB5951FD3B8244ABBA72FF7430B86D0@MN2PR08MB5951.namprd08.prod.outlook.com>
In-Reply-To: <MN2PR08MB5951FD3B8244ABBA72FF7430B86D0@MN2PR08MB5951.namprd08.prod.outlook.com>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Mon, 4 Feb 2019 13:32:50 +0100
Message-ID: <CAO1O6sejw4zYeh7iewT3gRZz=C5K3iOXhY-kO6FgSJNRHOBuKA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: spinand: micron: Support for all Micron SPI NAND flashes
To:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Den m=C3=A5n 4 feb. 2019 kl 12:18 skrev Shivamurthy Shastri (sshivamurthy)
<sshivamurthy@micron.com>:
>
> Driver is redesigned using parameter page to support all the Micron
> SPI NAND flashes.
>
> Parameter page of Micron flashes is similar to ONFI parameter table and
> functionality is same, so copied some of the common functions like crc16
> and bit_wise_majority from nand_onfi.c.
>
> This driver is tested using MT29F2G01ABXGD, MT29F4G01ABXFD, MT29F8G01ADXF=
D,
> MT29F1G01ABXFD.
>

> -static const struct spinand_info micron_spinand_table[] =3D {
> -       SPINAND_INFO("MT29F2G01ABAGD", 0x24,
> -                    NAND_MEMORG(1, 2048, 128, 64, 2048, 2, 1, 1),

> +       deviceinfo.memorg.eraseblocks_per_lun =3D
> +               params->blocks_per_lun * params->lun_count;
> +       deviceinfo.memorg.planes_per_lun =3D params->lun_count;
> +       deviceinfo.memorg.luns_per_target =3D 1;
> +       deviceinfo.memorg.ntargets =3D 1;

> +       __le32 blocks_per_lun;
> +       u8 lun_count;
> +       u8 addr_cycles;
> +       u8 bits_per_cell;
> +       __le16 bb_per_lun;

I have a question about the lun_count. As it is now, the
planes_per_lun parameter is initialized to 2 in NAND_MEMORG. In your
patch, it is instead initialized from the "lun_count" property from
the parameter table. But I looked at a datasheet I found by a simple
Google search (https://www.google.se/search?q=3Dmicron+nand+spi+datasheet),
the first hit is to the 1 Gb flash MT29F1G01AAADD. That device clearly
has two planes per lun (you need the "plane select" bit in the
requests), but still, according to the parameter page data structure,
byte 100, Number of logical units is set to 01h. Also, the "blocks per
lun" count, which is called "blocks per unit" is 1024, which should be
512 if this parameter really meant "blocks per plane" and the
calculation in the patch was correct.

As a reference, the 2 Gb version of the Macronix flash
(http://www.macronix.com/Lists/Datasheet/Attachments/6866/MX35LF2GE4AB,%203=
V,%202Gb,%20v1.5.pdf),
also has two planes per lun. It also sets byte 100, Number of logical
units to 01h.

So what I'm wondering is of course if this parameter is the correct
one to use for planes_per_lun. I tried to locate the correct "planes
per lun" parameter in the table, but didn't find anyone. Maybe it's
the unfortunate fact that "planes per lun" isn't exposed in the
parameter table?

/Emil
