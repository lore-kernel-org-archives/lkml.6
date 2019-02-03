Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0197DC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93B62148E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ks4iRHfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfBCO4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:56:49 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:46512 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfBCO4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549205806; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wNKZuuIMT/F4ZlDDRuayhE2fRI2B3Oamtag4L65TEag=;
        b=ks4iRHfQpngU7+iiY2hvJg/sReAsYlMQTk8IKA0my9ORE2TxIu+EJbQgjlq/+MyBaWa2gF
        /ldSYQRDIaOIQiOe190oSxFKbyV+rpity7EHL/FV1QZkM5kE6TS17Wi1bkNRFZTqRoyXzT
        Negla4dyGxtq7k0pjtSwOu6wuzoeDDM=
Date:   Sun, 03 Feb 2019 11:56:32 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 9/9] mtd: rawnand: jz4780-bch: Add support for the
 JZ4740
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1549205792.1588.0@crapouillou.net>
In-Reply-To: <20190203151604.23061e2a@bbrezillon>
References: <20190202231926.2444-1-paul@crapouillou.net>
        <20190202231926.2444-10-paul@crapouillou.net>
        <20190203083505.4dc52278@bbrezillon> <1549202293.1950.2@crapouillou.net>
        <20190203151604.23061e2a@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le dim. 3 f=E9vr. 2019 =E0 11:16, Boris Brezillon <bbrezillon@kernel.org>=20
a =E9crit :
> On Sun, 03 Feb 2019 10:58:13 -0300
> Paul Cercueil <paul@crapouillou.net> wrote:
>=20
>>  Le dim. 3 f=E9vr. 2019 =E0 4:35, Boris Brezillon=20
>> <bbrezillon@kernel.org>
>>  a =E9crit :
>>  > On Sat,  2 Feb 2019 20:19:26 -0300
>>  > Paul Cercueil <paul@crapouillou.net> wrote:
>>  >
>>  >>  Add the backend code for the jz4780-bch driver to support the=20
>> JZ4740
>>  >>  SoC from Ingenic.
>>  >>
>>  >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  >>  ---
>>  >>
>>  >>  Changes:
>>  >>
>>  >>  v2: New patch
>>  >>
>>  >>   drivers/mtd/nand/raw/ingenic/Makefile         |   2 +-
>>  >>   drivers/mtd/nand/raw/ingenic/jz4740_bch.c     | 173
>>  >> ++++++++++++++++++
>>  >>   .../mtd/nand/raw/ingenic/jz4780_bch_common.c  |   1 +
>>  >>   .../nand/raw/ingenic/jz4780_bch_internal.h    |   1 +
>>  >>   4 files changed, 176 insertions(+), 1 deletion(-)
>>  >>   create mode 100644 drivers/mtd/nand/raw/ingenic/jz4740_bch.c
>>  >>
>>  >>  diff --git a/drivers/mtd/nand/raw/ingenic/Makefile
>>  >> b/drivers/mtd/nand/raw/ingenic/Makefile
>>  >>  index f38b467490cf..d16c96113a93 100644
>>  >>  --- a/drivers/mtd/nand/raw/ingenic/Makefile
>>  >>  +++ b/drivers/mtd/nand/raw/ingenic/Makefile
>>  >>  @@ -1,3 +1,3 @@
>>  >>   obj-$(CONFIG_MTD_NAND_JZ4740) +=3D jz4740_nand.o
>>  >>   obj-$(CONFIG_MTD_NAND_JZ4780) +=3D jz4780_nand.o=20
>> jz4780_bch_common.o
>>  >> \
>>  >>  -				 jz4780_bch.o jz4725b_bch.o
>>  >>  +				 jz4780_bch.o jz4725b_bch.o jz4740_bch.o
>>  >
>>  > I still don't see the point of the jz4780_bch_common/jz47xxx_bch
>>  > separation. You seem to always embed all objects anyway, so you=20
>> can
>>  > just put the code for both engines in the same source file and=20
>> decide
>>  > which one to use based on the compat (which you already do=20
>> anyway).
>>=20
>>  Each SoC has a different set of registers for the BCH hardware. I=20
>> can
>>  try to
>>  cram everything into one file, but it won't be that much cleaner.
>=20
> Then maybe they deserve separate drivers/modules.
>=20
> BTW, didn't you say that one IP uses Reed-Salomon instead of BCH. I'd
> suggest prefixing structs and functions with jz47xx_ecc instead of
> jz47xx_bch and naming the common part jz47xx_ecc.c to reflect that.

Would it be a good idea to make a generic ECC API that the jz47xx_nand
driver could use? Then the three jz47xx BCH codepaths could be separate
drivers that register with the generic ECC core.
=

