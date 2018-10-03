Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6E7C64EBD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 02:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E16208AE
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 02:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="z4VBtKyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E16208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeJCIwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 04:52:24 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:29067 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeJCIwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 04:52:24 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w93261em030138
        for <linux-kernel@vger.kernel.org>; Wed, 3 Oct 2018 11:06:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w93261em030138
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538532362;
        bh=UpT730c8SSUSABSDIj6+fGeKx+1gOx6Hv3x4s+jCH9A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z4VBtKyhKaENWBEK6PdEjNCADmAaChhLdEOeaWG7Sh2XiBLEZjBMXjdfg2xdPP1+x
         gCnKozSX0CwP+zH937pd7a5LXEXsmRpXI5/pYEZjgw6inGv3tJthFlMY9fOiCVVIY8
         9/uc6KdPueO6BFlttOrEjcw+vtK9+YGFM/jJ1/yaMWp1u1yR2cQFzZDmR/ZwYqS8Dw
         B4/IGYydBGSnZzmikKmLjwHgQfz02Yz5MiSUaMoEhik9WducB7r62DiW1XcJjm87G5
         QCiRa87jw5a9vbMA+BjzxPQLkqPPxUU4oO2C26ZS/2bHfYBIR9A/3M28J94VPsQvq/
         /ZYKLeC+r+Qwg==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id z19-v6so2318941vso.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 19:06:02 -0700 (PDT)
X-Gm-Message-State: ABuFfoiAGCgwjTDpLxlkj/fFvF8BUYuldGJwxE5Ny3Q0AJGTm/jST6kp
        ourx0U3BAi+dS9rimAWcTJMmQ1QigIW2gPBagDE=
X-Google-Smtp-Source: ACcGV60MYLVK2hzbQNNVbzjCw5iv9wyhsCvQDf/Yvi2fJqzZM7zXtEYG3IHD17CGOkanVqpao5Rrm8EOhKN/BTmOlTQ=
X-Received: by 2002:a67:5e05:: with SMTP id s5-v6mr5255477vsb.215.1538532361274;
 Tue, 02 Oct 2018 19:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAQnPeNwmmKL_BWSnzEsUCq+MW+5c2TXWnuszOBi32iybg@mail.gmail.com>
In-Reply-To: <CAK7LNAQnPeNwmmKL_BWSnzEsUCq+MW+5c2TXWnuszOBi32iybg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 3 Oct 2018 11:05:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNATVRmQ5n6F5zdCD53kkiaK110Rx734Tm=YLihFQBEwbLg@mail.gmail.com>
Message-ID: <CAK7LNATVRmQ5n6F5zdCD53kkiaK110Rx734Tm=YLihFQBEwbLg@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.20
To:     Arnd Bergmann <arnd@arndb.de>, arm-soc <arm@kernel.org>,
        Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Olof,


Please hold on.

I've received a little more patches.

I will queue up them, and send a respin later on.

Thanks.


On Wed, Oct 3, 2018 at 8:47 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Arnd, Olof,
>
> Please pull UniPhier DT updates for the v4.20 MW.
>
> In this cycle, I queued up all arm/arm64 changes
> into a single branch to avoid build errors.
>
> Thanks!
>
>
>
>
>
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
>
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> tags/uniphier-dt-v4.20
>
> for you to fetch changes up to 84a9c4d55907feece68c6012d3c030cf5c841ceb:
>
>   arm64: dts: uniphier: add SD controller nodes (2018-10-03 08:21:27 +0900)
>
> ----------------------------------------------------------------
> UniPhier ARM SoC DT updates for v4.20
>
> - Add more clocks to NAND controller nodes
>
> - Add SPI controller nodes
>
> - Add SD controller nodes
>
> ----------------------------------------------------------------
> Kunihiko Hayashi (3):
>       ARM: dts: uniphier: add SPI pin-mux node
>       ARM: dts: uniphier: add SPI node for UniPhier 32bit SoCs
>       arm64: dts: uniphier: add SPI node for LD20, LD11 and PXs3
>
> Masahiro Yamada (4):
>       ARM: uniphier: dts: add more clocks to Denali NAND controller node
>       arm64: uniphier: dts: add more clocks to Denali NAND controller node
>       ARM: dts: uniphier: add SD/eMMC controller nodes
>       arm64: dts: uniphier: add SD controller nodes
>
>  arch/arm/boot/dts/uniphier-ld4-ref.dts            |  4 ++
>  arch/arm/boot/dts/uniphier-ld4.dtsi               | 48 ++++++++++++++-
>  arch/arm/boot/dts/uniphier-ld6b-ref.dts           |  4 ++
>  arch/arm/boot/dts/uniphier-pinctrl.dtsi           | 25 ++++++++
>  arch/arm/boot/dts/uniphier-pro4-ace.dts           |  4 ++
>  arch/arm/boot/dts/uniphier-pro4-ref.dts           |  4 ++
>  arch/arm/boot/dts/uniphier-pro4-sanji.dts         |  4 ++
>  arch/arm/boot/dts/uniphier-pro4.dtsi              | 62 +++++++++++++++++++-
>  arch/arm/boot/dts/uniphier-pro5.dtsi              | 59 ++++++++++++++++++-
>  arch/arm/boot/dts/uniphier-pxs2-gentil.dts        |  4 ++
>  arch/arm/boot/dts/uniphier-pxs2-vodka.dts         |  4 ++
>  arch/arm/boot/dts/uniphier-pxs2.dtsi              | 59 ++++++++++++++++++-
>  arch/arm/boot/dts/uniphier-sld8-ref.dts           |  4 ++
>  arch/arm/boot/dts/uniphier-sld8.dtsi              | 48 ++++++++++++++-
>  arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi  | 25 +++++++-
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi  | 61 ++++++++++++++++++-
>  .../boot/dts/socionext/uniphier-pxs3-ref.dts      |  4 ++
>  arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi  | 43 +++++++++++++-
>  18 files changed, 458 insertions(+), 8 deletions(-)
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
