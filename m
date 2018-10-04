Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A756C00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CFF213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YzAVhjas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CFF213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbeJDHpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 03:45:16 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:62804 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeJDHpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 03:45:16 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w940sOdu003328
        for <linux-kernel@vger.kernel.org>; Thu, 4 Oct 2018 09:54:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w940sOdu003328
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538614465;
        bh=TRD8gFMjv78UfY2xvFIpjl5q9W42lyhVO7AMnwUYdE0=;
        h=From:Date:Subject:To:Cc:From;
        b=YzAVhjasr+L8KGEXdWZ7p0OsvP/pzj4tliP4X2nxX/OOY22a8CmyhraAWtldp2ucs
         ftKiVTVGKcplAOBedKEXUNHdUCCJyc176Ndm0Yr6a7wXNZ1hhSbUf1PkQX1mNA0e/7
         h5PBo8nJRkq3g7Pi5H4j7HiO/opc9XHTLlylk0hoex/MAj+CY/L3ng1AIbSJFTl1qH
         Oy2sRB7NpvAi/1myo1yi7yQvcjaXhPurtzr5VeNzT0IXDfSpXJgN97tWik5WRDVSWN
         qPfbsoR7HP+QbhW0UV/6AchIWnBQeHh3Dqz3I2rUHWzfuXfRxzJbbcR4ruulkZLcv2
         IwUJ9AD9qgQZQ==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id a202so1206254vsd.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 17:54:25 -0700 (PDT)
X-Gm-Message-State: ABuFfoibVqXlkhexaKit/7rC+Rjg0U9SYSJ4uxsMGEAAtJn9bzwO7yHd
        zlq1HkRfdc24D1NgFHfznRtonMIBOkRnGbDQF/4=
X-Google-Smtp-Source: ACcGV61EE9X3+3Bs/n3UN17K2nHEBFkhtThSa/P/IDvUH6RL5U5/zmxQ0KFXWzl8v6j2gU+ZDE7AmKoqajjRCVATGTE=
X-Received: by 2002:a67:3793:: with SMTP id j19mr1386060vsi.215.1538614464497;
 Wed, 03 Oct 2018 17:54:24 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 4 Oct 2018 09:53:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR90vJA6vyEP_6_zmW_CAoxrHQC8-iAK0ixn6+o2uQfkg@mail.gmail.com>
Message-ID: <CAK7LNAR90vJA6vyEP_6_zmW_CAoxrHQC8-iAK0ixn6+o2uQfkg@mail.gmail.com>
Subject: [GIT PULL v2] ARM: dts: uniphier: UniPhier DT updates for v4.20
To:     arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Olof,

Please pull UniPhier DT updates for the v4.20 MW.

This is v2, for which I picked up a little more patches.


In this cycle, I queued up all arm/arm64 changes
into a single branch to avoid build errors.

Thanks!



The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v4.20

for you to fetch changes up to 546cba0623df695ac84c10a821cf98fea24b2a18:

  arm64: dts: uniphier: Add USB2 PHY nodes (2018-10-04 09:41:06 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v4.20

- Add more clocks to NAND controller nodes

- Add SPI controller nodes

- Add SD controller nodes

- Add USB 3.0 and its PHY nodes

- Add PHY nodes for USB 2.0

----------------------------------------------------------------
Kunihiko Hayashi (7):
      ARM: dts: uniphier: add SPI pin-mux node
      ARM: dts: uniphier: add SPI node for UniPhier 32bit SoCs
      arm64: dts: uniphier: add SPI node for LD20, LD11 and PXs3
      ARM: dts: uniphier: Add USB3 controller nodes
      ARM: dts: uniphier: Add USB2 PHY nodes
      arm64: dts: uniphier: Add USB3 controller nodes
      arm64: dts: uniphier: Add USB2 PHY nodes

Masahiro Yamada (4):
      ARM: uniphier: dts: add more clocks to Denali NAND controller node
      arm64: uniphier: dts: add more clocks to Denali NAND controller node
      ARM: dts: uniphier: add SD/eMMC controller nodes
      arm64: dts: uniphier: add SD controller nodes

 arch/arm/boot/dts/uniphier-ld4-ref.dts                 |   4 +
 arch/arm/boot/dts/uniphier-ld4.dtsi                    |  48 +++-
 arch/arm/boot/dts/uniphier-ld6b-ref.dts                |  12 +
 arch/arm/boot/dts/uniphier-pinctrl.dtsi                |  25 ++
 arch/arm/boot/dts/uniphier-pro4-ace.dts                |  12 +
 arch/arm/boot/dts/uniphier-pro4-ref.dts                |  12 +
 arch/arm/boot/dts/uniphier-pro4-sanji.dts              |  12 +
 arch/arm/boot/dts/uniphier-pro4.dtsi                   | 189 ++++++++++++++-
 arch/arm/boot/dts/uniphier-pro5.dtsi                   |  59 ++++-
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts             |  12 +
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts              |   8 +
 arch/arm/boot/dts/uniphier-pxs2.dtsi                   | 239
++++++++++++++++++-
 arch/arm/boot/dts/uniphier-sld8-ref.dts                |   4 +
 arch/arm/boot/dts/uniphier-sld8.dtsi                   |  48 +++-
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi       |  52 ++++-
 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts |   4 +
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts    |   4 +
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi       | 255
+++++++++++++++++++-
 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts    |  12 +
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi       | 283
++++++++++++++++++++++-
 20 files changed, 1286 insertions(+), 8 deletions(-)



-- 
Best Regards
Masahiro Yamada
