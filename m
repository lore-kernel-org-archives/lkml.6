Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7732C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3598425B2B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="myETV8NA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3598425B2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934360AbeFYONv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:13:51 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:48938 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934339AbeFYONu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:13:50 -0400
Received: from mail-ua0-f180.google.com (mail-ua0-f180.google.com [209.85.217.180]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w5PEDjYc010427
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 23:13:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w5PEDjYc010427
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529936026;
        bh=wopuVFV/wL7CI08Jse434uuW4yZdHsiRB7bavvBNHVw=;
        h=From:Date:Subject:To:Cc:From;
        b=myETV8NA+GLxTzKh7X0OFKmDBhFpoktT1u4jN7hIGH6IbAMnECiJskcOY2+H+pEg4
         tVMDrpbEd0iwwIAdGJ7YDEPsNZSrCZ4I9WB1pq9OhcBNalGZLakHVDiJcu3s7aZ3N6
         5Ht0RvTmWgArq9bWamOkwfA0onV3c+DV+2du56bk37Qpj4bjPp/o1Mk/xgMx3FRhPV
         6+qQf7CwQfgyCGTzOc/m2TyOkzX5w1W4nU+++fE+HHUbnC9ZoP3eli7KkRILL5BZIq
         WTWbiwGUcUqGUMBW04jQ0ZDPwrYqlOKo+gTxrI+qSgEtj8Walg4rMN2FJ1OaD6JD4r
         poop237l9JdgA==
X-Nifty-SrcIP: [209.85.217.180]
Received: by mail-ua0-f180.google.com with SMTP id m21-v6so8729565uan.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 07:13:46 -0700 (PDT)
X-Gm-Message-State: APt69E3H4AWnqXgBywpPrqivMxoSHvYuGFdJbJlU6ccb12FnQg0EE9B0
        T8uyyaVSUYIJlQ1nHc5aa+Xzxh4/Nbf5KqXHjjw=
X-Google-Smtp-Source: ADUXVKJXG5Sgt4mWA2UFY9kFeD7fBxOOOQ+dyqpnks/xgHxrUeC1woiP1CZbgtrfVycdyb/vfEcV8McB8BUBrP1Oidw=
X-Received: by 2002:ab0:15ad:: with SMTP id i42-v6mr7889792uae.199.1529936025287;
 Mon, 25 Jun 2018 07:13:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 07:13:04
 -0700 (PDT)
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 25 Jun 2018 23:13:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNARAMcUgV2K1_dDdkupaWdtLqGMz==+huurHJKyW=JVWxQ@mail.gmail.com>
Message-ID: <CAK7LNARAMcUgV2K1_dDdkupaWdtLqGMz==+huurHJKyW=JVWxQ@mail.gmail.com>
Subject: [GIT PULL] ARM: uniphier: fixes for v4.18
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm-soc <arm@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Olof,

Please pull some fixes of ARM UniPhier platform.



The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-fixes-v4.18

for you to fetch changes up to 4e62893c25bd3d5758058e15958364df3ca15fbc:

  arm64: uniphier: select RESET_CONTROLLER (2018-06-25 23:00:31 +0900)

----------------------------------------------------------------
UniPhier ARM SoC fixes for v4.18

 - add missing cooling device properties for CPUS

 - fix widget name of headphone

 - select RESET_CONTROLLER

----------------------------------------------------------------
Katsuhiro Suzuki (1):
      arm64: dts: uniphier: fix widget name of headphone for LD11/LD20 boards

Masahiro Yamada (2):
      ARM: uniphier: select RESET_CONTROLLER
      arm64: uniphier: select RESET_CONTROLLER

Viresh Kumar (2):
      ARM: dts: uniphier: Add missing cooling device properties for CPUs
      arm64: dts: uniphier: Add missing cooling device properties for CPUs

 arch/arm/boot/dts/uniphier-pxs2.dtsi                   | 3 +++
 arch/arm/mach-uniphier/Kconfig                         | 1 +
 arch/arm64/Kconfig.platforms                           | 1 +
 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi       | 2 ++
 6 files changed, 9 insertions(+), 2 deletions(-)


-- 
Best Regards
Masahiro Yamada
