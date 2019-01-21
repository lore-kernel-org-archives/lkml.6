Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B812FC3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E602089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="CQteFF3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfAUWDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:03:25 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:35383 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfAUWDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:03:25 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 10C928365B;
        Tue, 22 Jan 2019 11:03:22 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1548108202;
        bh=G/32QpsGo6AFzQcVyNK2GChIpMKMjYacMxXz4BGbi+w=;
        h=From:To:CC:Subject:Date:References;
        b=CQteFF3caP5dbpHbj3cLofbmL4phiah55cVGnMHkmgNsUkABUytFWykP3xQBEzBMs
         HKnnVzYONv6TtUSk9oNVsK9c5ZmR0cw4ebjJP4X2Tz9WG75cTqPF8VmzCLNVQEUqQA
         ZPlsCOjk5YOhlx8npNaA0xhqC8mwIEoa1TzzTknXglfNp1Dw36nyKrANpShMG3VHZV
         psXq0iS0h6FKn2XY+AaKHk76JcJIWNFZO/W84mw2ldENv57RhL/19ME8KkbOjH5U7N
         GquuWqU5rJy7t2nE73CUjiTrHR6vZMiZtKc1cXSoycomt4GJzqeL5mk2VIfcZ07C9n
         pJLzit9ntiaWA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c4641aa0001>; Tue, 22 Jan 2019 11:03:22 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Tue, 22 Jan 2019 11:03:21 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Tue, 22 Jan 2019 11:03:21 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "bp@alien8.de" <bp@alien8.de>, "arnd@arndb.de" <arnd@arndb.de>,
        "jlu@pengutronix.de" <jlu@pengutronix.de>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/9] EDAC drivers for Armada XP L2 and DDR
Thread-Topic: [PATCH v7 0/9] EDAC drivers for Armada XP L2 and DDR
Thread-Index: AQHUgfgBrJjSADzRCEun9Iucv3y9fg==
Date:   Mon, 21 Jan 2019 22:03:21 +0000
Message-ID: <f40952f1bc7b4a209328b1213fd517b1@svr-chch-ex1.atlnz.lc>
References: <20181122001142.19187-1-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,=0A=
=0A=
On 22/11/18 1:12 PM, Chris Packham wrote:=0A=
> The current plan is for these to go in via the ARM tree once appropriate=
=0A=
> Reviews/Acks have been given=0A=
> =0A=
> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-August/525561.=
html=0A=
=0A=
Is there anything I need to be doing to move this series along? It seems =
=0A=
to have dropped off the radar.=0A=
=0A=
> =0A=
> This series adds drivers for the L2 cache and DDR RAM ECC functionality a=
s=0A=
> found on the MV78230/MV78x60 SoCs. Jan has tested these changes with the=
=0A=
> MV78460 (on a custom board with a DDR3 ECC DIMM), Chris has tested these=
=0A=
> changes with 88F6820 and 98dx3236 (both a custom boards with fixed DDR3 +=
 ECC).=0A=
> =0A=
> Also contained in this series is an additional debugfs wrapper.=0A=
> =0A=
> Compared to the previous v6 series I've dropped the marvell,ecc-disable=
=0A=
> property.=0A=
> =0A=
> Compared to the previous v5 series I've split the dt-binding documentatio=
n into=0A=
> its own patch and updated armada_xp_edac.c to use a SPDX license.=0A=
> =0A=
> Compared to the previous v4 series I've added my s-o-b to some of Jan's=
=0A=
> patches and rebased against v4.19.0.=0A=
> =0A=
> Compared to the previous v3 series, the following changes have been made:=
=0A=
> - Use shorter names for the AURORA ECC and parity registers=0A=
> - Numerous formatting changes to edac/armada_xp.c (as requested by Boris)=
=0A=
> - Added support for Armada-38x and 98dx3236 SoCs=0A=
> =0A=
> Compared to the previous v2 series, the following changes have been made:=
=0A=
> - Allocate EDAC structures later during probing and drop devres support=
=0A=
>    patches (requested by Boris)=0A=
> - Make drvdata->width usage consistent according to the comment (suggeste=
d by=0A=
>    Chris)=0A=
> =0A=
> Compared to the previous v1 series, the following changes have been made:=
=0A=
> - Add the aurora-l2 register defines earlier in the series (suggested by=
=0A=
>    Russell King and Gregory CLEMENT )=0A=
> - Changed the DT vendor prefix from "arm" to "marvell" for the ecc-enable=
/disable=0A=
>    properties on the aurora-l2 (suggested by Russell King)=0A=
> - Fix some warnings reported by checkpatch=0A=
> =0A=
> Compared to the original RFC series, the following changes have been made=
:=0A=
> - Integrated Chris' patches for parity and ECC configuration via DT=0A=
> - Merged the DDR RAM and L2 cache drivers (as requested by Boris, analogo=
us=0A=
>    to fsl_ddr_edac.c and mpc85xx_edac.c)=0A=
> - Added myself to MAINTAINERS (requested by Boris)=0A=
> - L2 cache: Track the msg size and use snprintf (review comment by Chris)=
=0A=
> - L2 cache: Split error injection from the check function (review comment=
 by=0A=
>    Chris)=0A=
> - DDR RAM: Allow 16 bit width in addition to 32 and 64 bit (review commen=
t by=0A=
>    Chris)=0A=
> - Use of_match_ptr() (review comments by Chris)=0A=
> - Minor checkpatch cleanups=0A=
> =0A=
> Chris Packham (4):=0A=
>    ARM: l2x0: support parity-enable/disable on aurora=0A=
>    dt-bindings: ARM: document marvell,ecc-enable binding=0A=
>    ARM: l2x0: add marvell,ecc-enable property for aurora=0A=
>    EDAC: armada_xp: Add support for more SoCs=0A=
> =0A=
> Jan Luebbe (5):=0A=
>    ARM: l2c: move cache-aurora-l2.h to asm/hardware=0A=
>    ARM: aurora-l2: add prefix to MAX_RANGE_SIZE=0A=
>    ARM: aurora-l2: add defines for parity and ECC registers=0A=
>    EDAC: Add missing debugfs_create_x32 wrapper=0A=
>    EDAC: Add driver for the Marvell Armada XP SDRAM and L2 cache ECC=0A=
> =0A=
>   .../devicetree/bindings/arm/l2c2x0.txt        |   1 +=0A=
>   MAINTAINERS                                   |   6 +=0A=
>   .../asm/hardware}/cache-aurora-l2.h           |  50 +-=0A=
>   arch/arm/mm/cache-l2x0.c                      |  18 +-=0A=
>   drivers/edac/Kconfig                          |   7 +=0A=
>   drivers/edac/Makefile                         |   1 +=0A=
>   drivers/edac/armada_xp_edac.c                 | 635 ++++++++++++++++++=
=0A=
>   drivers/edac/debugfs.c                        |  11 +=0A=
>   drivers/edac/edac_module.h                    |   5 +=0A=
>   9 files changed, 730 insertions(+), 4 deletions(-)=0A=
>   rename arch/arm/{mm =3D> include/asm/hardware}/cache-aurora-l2.h (50%)=
=0A=
>   create mode 100644 drivers/edac/armada_xp_edac.c=0A=
> =0A=
=0A=
