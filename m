Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2587BECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2CA2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NCzHHoU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2CA2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbeGRXmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:42:02 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:17015 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeGRXmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:42:02 -0400
Received: from mail-vk0-f42.google.com (mail-vk0-f42.google.com [209.85.213.42]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w6IN1lVP010614
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 08:01:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w6IN1lVP010614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531954908;
        bh=sXP+TQq+NWEMQB+JgGbUi0bOGJ3unBwu3IqWultRY4k=;
        h=From:Date:Subject:To:Cc:From;
        b=NCzHHoU5WlEXxSLH+pTUPYcRI1Y6QzDy4g4UDI8qbqq892AlkzfHKyBBJBfma1KEx
         HgUqUKH1I2PQQe6Jga3NIuH1ru0U5Ozae06JvF+JdO3NTAeIvpiVF2APQ8j/eY7oF7
         y6GtpGGSJ1pz0EvzKzWGLBD6DKFF55VlnXxKQbEUMe0MVFIlqXAiwSkblA3jvpJJSu
         0S3dHnmTppV/wKwiKmaUzul/ZBYNOr+N1kv7lBKGz3kVGIRA6Td2SPnQmjGq8zO2Gi
         d8wkyJCjmMXotJu2epnGQahZqJmHE7tEn+nUBzyL3vrRqXHDkZcHOisxsDUSNMseDR
         pUSTuH73OBkpQ==
X-Nifty-SrcIP: [209.85.213.42]
Received: by mail-vk0-f42.google.com with SMTP id o82-v6so1576692vko.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 16:01:48 -0700 (PDT)
X-Gm-Message-State: AOUpUlHfziuw8AEl6ul2+UhwiJgduI4qXefT7dPPpAL6ctQa69R69Hbm
        DmBm/6MSj7b37ddT211TguZsBn2z8+eFCvNF/o0=
X-Google-Smtp-Source: AAOMgpfSQLQS+FeFJvD62noXIBuA8gHsN1zbc878gHXdGCBUj9/+D6XdDIjgvFCXizgsC8LtDEJsI5xfCv84KWW1mbA=
X-Received: by 2002:a1f:a945:: with SMTP id s66-v6mr4820966vke.54.1531954907303;
 Wed, 18 Jul 2018 16:01:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 16:01:06
 -0700 (PDT)
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 19 Jul 2018 08:01:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNASA08wMtQaEfZy66u-EubV7X-u+z6KcTrtq_yXzWyzPvw@mail.gmail.com>
Message-ID: <CAK7LNASA08wMtQaEfZy66u-EubV7X-u+z6KcTrtq_yXzWyzPvw@mail.gmail.com>
Subject: [GIT PULL 1/3] ARM: dts: uniphier: UniPhier DT updates for v4.19
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

Please pull UniPhier DT (32bit) updates for the v4.19 MW.

Thanks!



The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v4.19

for you to fetch changes up to 38dc27c85e642cd6229f3a4b2c85128501852158:

  ARM: dts: uniphier: Add missing cooling device properties for CPUs
(2018-07-19 06:42:16 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v4.19

- Add missing #cooling-cells properties

----------------------------------------------------------------
Viresh Kumar (1):
      ARM: dts: uniphier: Add missing cooling device properties for CPUs

 arch/arm/boot/dts/uniphier-pxs2.dtsi | 3 +++
 1 file changed, 3 insertions(+)


-- 
Best Regards
Masahiro Yamada
