Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71695C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3055C2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="x8GT7vpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3055C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeLJQh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:37:57 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:50006 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeLJQh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:37:57 -0500
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wBAGbm37029656
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:37:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wBAGbm37029656
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544459869;
        bh=/09BAeUYB8iUjP94wpzm0QDj+hLuRBKIsYBzMFRONBc=;
        h=From:Date:Subject:To:Cc:From;
        b=x8GT7vprCQ6aqxJCueEBM9nBqPWavWyWqx/0EXHtUDqoJKK5+LH2wUGyBXhZ9qUXW
         pfF16eQDEIcxHA8jAaflut0c/8XSAanueidA447CXADQOuEnRFW8UY3CK1fqeKSN7Q
         WpklURGbpHRzZbTYUDfSEgZgfJwrXBM4Xw8GRGulJMWY2ZTRNYecLAvcSouZ+ukyYs
         9rJ1jfKVyzg95e049bnGsF2IeV89IjoXaBDpjGSVi6682sgiWh0IggpgrJeFe9fd6K
         7t7IUbNCFN5RP5KXnPq5vdw7TlEXpfXRl8u8wVNb/lNHGwrdlKpLhlMDIU4NQoHeh3
         dpenl0WB30Zbw==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id h18so7027453vsj.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:37:49 -0800 (PST)
X-Gm-Message-State: AA+aEWYYjlOwQft4SWks/8BOYDdtyUXNtoIIgGf0sG5BK5+BSuc0GuZh
        q47cNKnKAxS/XUSUn+guIPYHv91DqszoSxQfEN8=
X-Google-Smtp-Source: AFSGD/VOkI1lw4lAr9aAns341OI4YLslTbNcqRkXoDUA9tokX2kh15nGkaAJKmBCm61vA8SO0mY+BBcuNyuW8qGZ7MY=
X-Received: by 2002:a67:5f03:: with SMTP id t3mr5751599vsb.155.1544459867985;
 Mon, 10 Dec 2018 08:37:47 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 11 Dec 2018 01:37:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNAROrpzx96gT4CnJ8ZkiBa3Yf38_nNqVpMQ7NyH+hK+kOg@mail.gmail.com>
Message-ID: <CAK7LNAROrpzx96gT4CnJ8ZkiBa3Yf38_nNqVpMQ7NyH+hK+kOg@mail.gmail.com>
Subject: [GIT PULL RESEND] ARM: dts: uniphier: UniPhier DT updates for v4.21/v5.0
To:     arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
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

for you to fetch changes up to 5fd98eb7e8ce0f7d7e4f3c138e5b46fc98389804:

  ARM: dts: uniphier: add MIO DMAC nodes (2018-12-11 01:31:17 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v4.21

- Add bindings for all SoCs/boards of UniPhier platform

- Move binding docs to socionext directory

- Add all CPUs in cooling maps

- Add MIO DMAC nodes

----------------------------------------------------------------
Masahiro Yamada (3):
      dt-bindings: uniphier: add bindings for UniPhier SoC family
      dt-bindings: uniphier: move cache-uniphier.txt to vendor directory
      ARM: dts: uniphier: add MIO DMAC nodes

Viresh Kumar (2):
      ARM: dts: uniphier: Add all CPUs in cooling maps
      arm64: dts: uniphier: Add all CPUs in cooling maps

 .../arm/{uniphier => socionext}/cache-uniphier.txt |  0
 .../devicetree/bindings/arm/socionext/uniphier.txt | 47 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 arch/arm/boot/dts/uniphier-ld4.dtsi                | 14 +++++++
 arch/arm/boot/dts/uniphier-pro4.dtsi               | 16 ++++++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi               |  6 ++-
 arch/arm/boot/dts/uniphier-sld8.dtsi               | 14 +++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 11 ++---
 8 files changed, 100 insertions(+), 9 deletions(-)
 rename Documentation/devicetree/bindings/arm/{uniphier =>
socionext}/cache-uniphier.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/arm/socionext/uniphier.txt


-- 
Best Regards
Masahiro Yamada
