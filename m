Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDFBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FDB2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="qlBkmww6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FDB2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403800AbeKVKtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:49:00 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:36661 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390796AbeKVKsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:48:51 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5B3A489159;
        Thu, 22 Nov 2018 13:12:07 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1542845527;
        bh=L0w5SO4aGb8+EaGr26WEECA6bYLCHp6N2Bk/RRYD7bA=;
        h=From:To:Cc:Subject:Date;
        b=qlBkmww6S62Q6bbj4kcrbsT+Mb8q+eoDfZUn4y/IcXf6pkNg5ZNvh1rA74vpRnWHx
         VF5fe4VcXaAU1uiwDaiH+wAt07mKy4lcuDN9Vgg4/Cs9LE4+iAkjyhuiDRu341+BMG
         TQ0aZB7Q+5M3uj/zvHhyQbXtjnFoYYss8NRxEN6ixOjSjNFBZuNKhicf7Fc3aThqKx
         MzeXTAZLP+mA+V6s9/igkBV+myqjcZrDOTkxXetjxQWOfIg6J3U3wpuO2tXEM2r3Mu
         dCLw/7weidUeOYsaRFTbBDbrDP5YWqy+0FgnIHuTNmUlWyiV0QT3CafrySEJGp1tjp
         OgV85FGO+UJnQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5bf5f4520000>; Thu, 22 Nov 2018 13:12:07 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 6B69F13EEED;
        Thu, 22 Nov 2018 13:12:07 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id F40021E08D9; Thu, 22 Nov 2018 13:12:01 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk, bp@alien8.de, arnd@arndb.de,
        jlu@pengutronix.de, gregory.clement@bootlin.com,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v7 0/9] EDAC drivers for Armada XP L2 and DDR
Date:   Thu, 22 Nov 2018 13:11:33 +1300
Message-Id: <20181122001142.19187-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current plan is for these to go in via the ARM tree once appropriate
Reviews/Acks have been given

http://lists.infradead.org/pipermail/linux-arm-kernel/2017-August/525561.=
html

This series adds drivers for the L2 cache and DDR RAM ECC functionality a=
s
found on the MV78230/MV78x60 SoCs. Jan has tested these changes with the
MV78460 (on a custom board with a DDR3 ECC DIMM), Chris has tested these
changes with 88F6820 and 98dx3236 (both a custom boards with fixed DDR3 +=
=20ECC).

Also contained in this series is an additional debugfs wrapper.

Compared to the previous v6 series I've dropped the marvell,ecc-disable
property.

Compared to the previous v5 series I've split the dt-binding documentatio=
n into
its own patch and updated armada_xp_edac.c to use a SPDX license.

Compared to the previous v4 series I've added my s-o-b to some of Jan's
patches and rebased against v4.19.0.

Compared to the previous v3 series, the following changes have been made:=

- Use shorter names for the AURORA ECC and parity registers
- Numerous formatting changes to edac/armada_xp.c (as requested by Boris)=

- Added support for Armada-38x and 98dx3236 SoCs

Compared to the previous v2 series, the following changes have been made:=

- Allocate EDAC structures later during probing and drop devres support
=20 patches (requested by Boris)
- Make drvdata->width usage consistent according to the comment (suggeste=
d by
=20 Chris)

Compared to the previous v1 series, the following changes have been made:=

- Add the aurora-l2 register defines earlier in the series (suggested by
=20 Russell King and Gregory CLEMENT )
- Changed the DT vendor prefix from "arm" to "marvell" for the ecc-enable=
/disable
=20 properties on the aurora-l2 (suggested by Russell King)
- Fix some warnings reported by checkpatch

Compared to the original RFC series, the following changes have been made=
:
- Integrated Chris' patches for parity and ECC configuration via DT
- Merged the DDR RAM and L2 cache drivers (as requested by Boris, analogo=
us
=20 to fsl_ddr_edac.c and mpc85xx_edac.c)
- Added myself to MAINTAINERS (requested by Boris)
- L2 cache: Track the msg size and use snprintf (review comment by Chris)=

- L2 cache: Split error injection from the check function (review comment=
=20by
=20 Chris)
- DDR RAM: Allow 16 bit width in addition to 32 and 64 bit (review commen=
t by
=20 Chris)
- Use of_match_ptr() (review comments by Chris)
- Minor checkpatch cleanups

Chris Packham (4):
=20 ARM: l2x0: support parity-enable/disable on aurora
=20 dt-bindings: ARM: document marvell,ecc-enable binding
=20 ARM: l2x0: add marvell,ecc-enable property for aurora
=20 EDAC: armada_xp: Add support for more SoCs

Jan Luebbe (5):
=20 ARM: l2c: move cache-aurora-l2.h to asm/hardware
=20 ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
=20 ARM: aurora-l2: add defines for parity and ECC registers
=20 EDAC: Add missing debugfs_create_x32 wrapper
=20 EDAC: Add driver for the Marvell Armada XP SDRAM and L2 cache ECC

=20.../devicetree/bindings/arm/l2c2x0.txt        |   1 +
=20MAINTAINERS                                   |   6 +
=20.../asm/hardware}/cache-aurora-l2.h           |  50 +-
=20arch/arm/mm/cache-l2x0.c                      |  18 +-
=20drivers/edac/Kconfig                          |   7 +
=20drivers/edac/Makefile                         |   1 +
=20drivers/edac/armada_xp_edac.c                 | 635 ++++++++++++++++++=

=20drivers/edac/debugfs.c                        |  11 +
=20drivers/edac/edac_module.h                    |   5 +
=209 files changed, 730 insertions(+), 4 deletions(-)
=20rename arch/arm/{mm =3D> include/asm/hardware}/cache-aurora-l2.h (50%)=

=20create mode 100644 drivers/edac/armada_xp_edac.c

--=20
2.19.1
