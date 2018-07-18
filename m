Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCC0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB04E2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HCdtkBMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB04E2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbeGRXqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:46:03 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:43115 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbeGRXqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:46:03 -0400
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com [209.85.213.46]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w6IN5iAl002867
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 08:05:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w6IN5iAl002867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531955145;
        bh=4vhNDWIIehXvK/P5mBK5aILl9jeoai+AKPlT7OJtfzE=;
        h=From:Date:Subject:To:Cc:From;
        b=HCdtkBMvZleEV7/YfSs+WOx40fgLQwXtQEEa09qvbXv787cmviJC8uxQs4L78duPz
         BzDtf4AUXDUPXq4kESrKz/+Jl6ixfrIylGyhwq1HABA0MzxQ2EFwgEURlnYOe+JbIJ
         euNgwGM1l2AFvLXbwdyr4nU93mMCwtfvEf4ETKWbTiQdC9t4/FbVZ0bytkXbrMW27R
         sRa5FtzsdSetXwp2tUfrwI7MefwYciso4MYd6nyQzoJzSbjNkrVVf0rZDCqQ6KRowH
         rtPMLcsNtzaXTaH0wsWDIeDqAVbz9D8VhS7UNYC97OHvKulpkB3D6ovXUqav64I540
         +80nYs3H5jmSw==
X-Nifty-SrcIP: [209.85.213.46]
Received: by mail-vk0-f46.google.com with SMTP id o82-v6so1580991vko.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 16:05:45 -0700 (PDT)
X-Gm-Message-State: AOUpUlHFHAJp+idJ8KJNF/+MTdYHjINM6BpaNu0NuFfvOv5RSmGtC7Bt
        osrqTX79SJrVE6h6zQ37AvJoNoQ/i3+exi/Zykc=
X-Google-Smtp-Source: AAOMgpfnuIjzInOVJ47t2jOnISf4p8l2gUOaMMqq0I3ZhAdrl4Z/xY+In7peid5Vg2ISEzoR66JmYwv8nGR3ajqJBps=
X-Received: by 2002:a1f:9807:: with SMTP id a7-v6mr4525230vke.65.1531955144344;
 Wed, 18 Jul 2018 16:05:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 16:05:03
 -0700 (PDT)
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 19 Jul 2018 08:05:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNAShLhWqCRR8RfuJ0xBJAFoj-S6WLcSdh9QShg8dGfq9RA@mail.gmail.com>
Message-ID: <CAK7LNAShLhWqCRR8RfuJ0xBJAFoj-S6WLcSdh9QShg8dGfq9RA@mail.gmail.com>
Subject: [GIT PULL 3/3] ARM: uniphier: UniPhier SoC updates for v4.19
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

Please pull UniPhier SoC changes for the v4.19 MW.

Thanks!


The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-soc-v4.19

for you to fetch changes up to ae93e694440a454609fa40725e16619c5a781768:

  ARM: uniphier: remove empty Makefile (2018-07-19 06:53:16 +0900)

----------------------------------------------------------------
UniPhier ARM SoC updates for v4.19

- enable ethernet and thermal drivers from multi_v7_defconfig

- select RESET_CONTROLLER

- remove empty arch/arm/mach-uniphier/Makefile

----------------------------------------------------------------
Kunihiko Hayashi (1):
      ARM: multi_v7_defconfig: add CONFIG_UNIPHIER_THERMAL and CONFIG_SNI_AVE

Masahiro Yamada (3):
      ARM: uniphier: select RESET_CONTROLLER
      arm64: uniphier: select RESET_CONTROLLER
      ARM: uniphier: remove empty Makefile

 arch/arm/Makefile                   | 1 -
 arch/arm/configs/multi_v7_defconfig | 2 ++
 arch/arm/mach-uniphier/Kconfig      | 1 +
 arch/arm/mach-uniphier/Makefile     | 0
 arch/arm64/Kconfig.platforms        | 1 +
 5 files changed, 4 insertions(+), 1 deletion(-)
 delete mode 100644 arch/arm/mach-uniphier/Makefile


-- 
Best Regards
Masahiro Yamada
