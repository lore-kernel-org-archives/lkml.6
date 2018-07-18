Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61A0ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585FF2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="RSzrftq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585FF2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbeGRXmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:42:50 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:30597 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeGRXmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:42:50 -0400
Received: from mail-ua0-f170.google.com (mail-ua0-f170.google.com [209.85.217.170]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w6IN2PAK008363
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 08:02:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w6IN2PAK008363
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531954945;
        bh=BQblNVPSG5RNBT910EbrKrjlFmr6hJeVtjYQZaJkA9A=;
        h=From:Date:Subject:To:Cc:From;
        b=RSzrftq7F0DyRNGN7yqihOaJQPGIU6IWWg5jOhw4uZnpB4N0Oe35ftvu9hIqZs13F
         xoAjRndZRRne0WSBrmAeVYLR3xnpwAvSy9Gnelc6omstuHi4c1I66BTpTdKXDJR1iA
         N/R4zvRPWX4WPDp3UxnOl92AxkKwjh2tx2ui5FBAWRvetiiWOLw0UvqXkNGNONlVG2
         zqNaQG37asjjqZ/T3ZnItQNn7NIZYCTel9pmhblj97VynZSdIpMbvwV0XPzCwZK0gG
         90aHvmoa2Q4wrPxcpTIHSKPDUVSk1qByT1zmGFsfgF7xHR7gQaIxlx3L5ocAX3aqGP
         bSQOoQMPfTBng==
X-Nifty-SrcIP: [209.85.217.170]
Received: by mail-ua0-f170.google.com with SMTP id i4-v6so3998400uak.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 16:02:25 -0700 (PDT)
X-Gm-Message-State: AOUpUlHuSlexmNNERs5/CySXxFSEgw9Sq/REIY/W9G8FCQYBRRGyoar9
        DDwnvPveG+nRD94EydAEblSavsq++5qcKR5rVNQ=
X-Google-Smtp-Source: AAOMgpfj49jYR5xWHIQDPXJB6TX1OhprKTBMa1lYF+CHUp4NfefMa6RN0uFK4mT5PLqC0MDA2C/36nnIPd2tesjRbPE=
X-Received: by 2002:ab0:4705:: with SMTP id h5-v6mr5238847uac.140.1531954944613;
 Wed, 18 Jul 2018 16:02:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 16:01:44
 -0700 (PDT)
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 19 Jul 2018 08:01:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAStvWBsimKG2uBe9ROAU8dAV2Zi6F=6VrOS4pFnQgNhAg@mail.gmail.com>
Message-ID: <CAK7LNAStvWBsimKG2uBe9ROAU8dAV2Zi6F=6VrOS4pFnQgNhAg@mail.gmail.com>
Subject: [GIT PULL 2/3] arm64: dts: uniphier: UniPhier DT updates for v4.19
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

Please pull UniPhier DT (64bit) updates for the v4.19 MW.

Thanks!



The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt64-v4.19

for you to fetch changes up to 1470075d5e354da8f46f5aa2e6956de794eb406a:

  arm64: dts: uniphier: add headphone detect gpio for LD11 global
board (2018-07-19 06:43:12 +0900)

----------------------------------------------------------------
UniPhier ARM64 SoC DT updates for v4.19

- Add missing #cooling-cells properties

- Add hp-det-gpio property to detect headphone via GPIO

----------------------------------------------------------------
Katsuhiro Suzuki (2):
      arm64: dts: uniphier: add headphone detect gpio for LD20 global board
      arm64: dts: uniphier: add headphone detect gpio for LD11 global board

Viresh Kumar (1):
      arm64: dts: uniphier: Add missing cooling device properties for CPUs

 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts | 1 +
 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts | 1 +
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi       | 2 ++
 3 files changed, 4 insertions(+)


-- 
Best Regards
Masahiro Yamada
