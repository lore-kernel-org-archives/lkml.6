Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E40C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985F9206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FgYuSjBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985F9206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbeJCGeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 02:34:04 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:65236 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725744AbeJCGeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 02:34:04 -0400
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w92Nlo7g013028
        for <linux-kernel@vger.kernel.org>; Wed, 3 Oct 2018 08:47:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w92Nlo7g013028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538524071;
        bh=eu2r3S1hn7VapmmSwKZPRziUT5NfKau70Q7cnaasl+A=;
        h=From:Date:Subject:To:Cc:From;
        b=FgYuSjBvf2ZHS2ctrw8xpgXbiC/djVB5suCJoPQtlE24LniCmC4F+tXA3XH6Vc1sd
         icDT1J3ia939IMoy7KqQh+f+4wlMXrs4VRDM3d0Y1bLIxyX4M0R/MjG4vvdbwKX1++
         DynaRAoITlYSBFmAsJaAwAKYKQMwqfTqn55es+i/IlxApGFkM21DKo7JTqHYEgV5Gr
         rclxORbw4JoItRoNq2aZGuLJAXFLVwFmV9DfecZGg2M0CjnDBy6q2oefAZevsdTIDY
         vCoXYODJOBiLIvlwF8Ql5UrpppBERiFlu+JCOXH4I80Ly7rpSoR/LypJ1qU2OaeZRX
         FbaN6eY6/sM2w==
X-Nifty-SrcIP: [209.85.221.171]
Received: by mail-vk1-f171.google.com with SMTP id g80-v6so800407vke.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 16:47:51 -0700 (PDT)
X-Gm-Message-State: ABuFfojj+bkpU9K2m/23CQF5MqKNM7RpnEP+Oq6iRTumV7ultv4YPdf4
        qcQ/CBi6Rp6Clhv0G9Eo69T/lP0lEdjqB+uXs30=
X-Google-Smtp-Source: ACcGV62NPPhrEIoH1UImSf+vV1T89l1TsAK1loSs9SHU3LOfkrWEWa9/Uu59vZK8DkJ2IBg7HZWfj4TuNxzwSacha2w=
X-Received: by 2002:a1f:32ce:: with SMTP id y197-v6mr6571068vky.64.1538524070073;
 Tue, 02 Oct 2018 16:47:50 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 3 Oct 2018 08:47:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQnPeNwmmKL_BWSnzEsUCq+MW+5c2TXWnuszOBi32iybg@mail.gmail.com>
Message-ID: <CAK7LNAQnPeNwmmKL_BWSnzEsUCq+MW+5c2TXWnuszOBi32iybg@mail.gmail.com>
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.20
To:     Arnd Bergmann <arnd@arndb.de>, arm-soc <arm@kernel.org>,
        Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Olof,

Please pull UniPhier DT updates for the v4.20 MW.

In this cycle, I queued up all arm/arm64 changes
into a single branch to avoid build errors.

Thanks!





The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v4.20

for you to fetch changes up to 84a9c4d55907feece68c6012d3c030cf5c841ceb:

  arm64: dts: uniphier: add SD controller nodes (2018-10-03 08:21:27 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v4.20

- Add more clocks to NAND controller nodes

- Add SPI controller nodes

- Add SD controller nodes

----------------------------------------------------------------
Kunihiko Hayashi (3):
      ARM: dts: uniphier: add SPI pin-mux node
      ARM: dts: uniphier: add SPI node for UniPhier 32bit SoCs
      arm64: dts: uniphier: add SPI node for LD20, LD11 and PXs3

Masahiro Yamada (4):
      ARM: uniphier: dts: add more clocks to Denali NAND controller node
      arm64: uniphier: dts: add more clocks to Denali NAND controller node
      ARM: dts: uniphier: add SD/eMMC controller nodes
      arm64: dts: uniphier: add SD controller nodes

 arch/arm/boot/dts/uniphier-ld4-ref.dts            |  4 ++
 arch/arm/boot/dts/uniphier-ld4.dtsi               | 48 ++++++++++++++-
 arch/arm/boot/dts/uniphier-ld6b-ref.dts           |  4 ++
 arch/arm/boot/dts/uniphier-pinctrl.dtsi           | 25 ++++++++
 arch/arm/boot/dts/uniphier-pro4-ace.dts           |  4 ++
 arch/arm/boot/dts/uniphier-pro4-ref.dts           |  4 ++
 arch/arm/boot/dts/uniphier-pro4-sanji.dts         |  4 ++
 arch/arm/boot/dts/uniphier-pro4.dtsi              | 62 +++++++++++++++++++-
 arch/arm/boot/dts/uniphier-pro5.dtsi              | 59 ++++++++++++++++++-
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts        |  4 ++
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts         |  4 ++
 arch/arm/boot/dts/uniphier-pxs2.dtsi              | 59 ++++++++++++++++++-
 arch/arm/boot/dts/uniphier-sld8-ref.dts           |  4 ++
 arch/arm/boot/dts/uniphier-sld8.dtsi              | 48 ++++++++++++++-
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi  | 25 +++++++-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi  | 61 ++++++++++++++++++-
 .../boot/dts/socionext/uniphier-pxs3-ref.dts      |  4 ++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi  | 43 +++++++++++++-
 18 files changed, 458 insertions(+), 8 deletions(-)


-- 
Best Regards
Masahiro Yamada
