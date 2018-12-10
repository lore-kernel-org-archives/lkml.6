Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B445C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BB72082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="I5WTLZKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BB72082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeLJQZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:25:40 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:28733 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJQZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:25:39 -0500
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id wBAGPBUR004551
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:25:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wBAGPBUR004551
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544459112;
        bh=HTpUEVT8Rl5xqjHZP4AHzyHMs5MebJM2JoSaIhZfpvg=;
        h=From:Date:Subject:To:Cc:From;
        b=I5WTLZKB8KXgzoBySx/G1k2Qf5Z3WX/Ob2mN4DAHayXRA5Dr1CTkWT0+F4X3eLmTN
         ZywfpGn0wyKrSDSVYPqVbve1X5rQnvq+CS3JSkwxfpt4+WnEtsBC7TiLYtI5bnCpEn
         bNeIbobpHIxVjgQGVkBxOMoQoCl4WGDiUzXfac/NmpSOnO+vVhPjUsC9LwdbYLOu2m
         CZ5uWe9N+sCyNLGM5Ytp/h8ZDZRDbYOhtihTsYWPFWnLOHhnw9o0mNoRUcLRIXnVwv
         8TaHMhufgB0Z+GcLupUxadZdS8WkjGtZOZY8wPYum9irBbT46Wmqvj5p+Dhx3ximNO
         hS9aUb6vnHAtw==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id n10so6978207vso.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:25:12 -0800 (PST)
X-Gm-Message-State: AA+aEWZyyb8xjL4pzpnu2ITk7R2v32UW4F8bhdrfiMuUk7QwawcENBH1
        DgiFNIHaO7ijrX2eycUpHLkGiKz7z5vYTrHgHI8=
X-Google-Smtp-Source: AFSGD/UwkiRC58xItJ3x5SKHjGQjPTJ0Cxn6hXYZj8vly0q/lIwRoKuIElm8+OeEGFRNZM68NYmRXvTX+MYwvx7sGjA=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr5509561vsm.181.1544459110820;
 Mon, 10 Dec 2018 08:25:10 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 11 Dec 2018 01:24:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAToKE7dv8UHOhQhJN+6Q6qVs=noQvLedGCEQszSgmVvXg@mail.gmail.com>
Message-ID: <CAK7LNAToKE7dv8UHOhQhJN+6Q6qVs=noQvLedGCEQszSgmVvXg@mail.gmail.com>
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.21/v5.0
To:     arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Olof,

Please pull UniPhier DT updates for the v4.21/v5.0 MW.


Thanks!




The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v4.21

for you to fetch changes up to f911160a215c2ee63633d058d673881986568fb1:

  ARM: dts: uniphier: add MIO DMAC nodes (2018-12-11 00:58:54 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v4.21

- Add bindings for all SoCs/boards of UniPhier platform

- Move binding docs to the socionext directory

- Add all CPUs in cooling maps

- Add MIO DMAC nodes

----------------------------------------------------------------
Masahiro Yamada (3):
      dt-bindings: uniphier: add bindings for UniPhier SoC family
      dt-bindings: uniphier: move cache-uniphier.txt to vendor directory
      ARM: dts: uniphier: add MIO DMAC nodes

Viresh Kumar (1):
      ARM: dts: uniphier: Add all CPUs in cooling maps

 .../arm/{uniphier => socionext}/cache-uniphier.txt |  0
 .../devicetree/bindings/arm/socionext/uniphier.txt | 47 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 arch/arm/boot/dts/uniphier-ld4.dtsi                | 14 +++++++
 arch/arm/boot/dts/uniphier-pro4.dtsi               | 16 ++++++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi               |  6 ++-
 arch/arm/boot/dts/uniphier-sld8.dtsi               | 14 +++++++
 7 files changed, 96 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/arm/{uniphier =>
socionext}/cache-uniphier.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/arm/socionext/uniphier.txt



-- 
Best Regards
Masahiro Yamada
