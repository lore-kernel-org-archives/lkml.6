Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29168C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A370420838
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HbvqYacm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfBVAaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:30:12 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:51255 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfBVAaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:30:11 -0500
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x1M0U3GE017144;
        Fri, 22 Feb 2019 09:30:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x1M0U3GE017144
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550795404;
        bh=LE4jsmg/pYaBDgl2h5YQItVZWFXOchrSMljt6gZO+4E=;
        h=From:Date:Subject:To:Cc:From;
        b=HbvqYacmEm3S4QPezvQIcOaeDbceza/VDnBmaQD3RXyJnIJItO4eQXnVJ1oR7SW8H
         mcHNvhfPTiIgGRgsDyIf1baG438ibRHv9pQzi/GEX+SGP179cK+rUl+P29Rf8z0X9P
         LKopY/WcpXS0ga3N/A+s+sAfUUqiC/9gW28854m1F1P1NN6d+rqANHHkFUv4cgbAeM
         /DcuBGiFDxIbmyGzjDV+lrKwkRmTDie/XKhIGVeUedWdNkeIhUzJTjDro9pCF2OvqC
         9vlPuQ2JO5AFAXBbB3FL16LCmVzSLl4uEh1apLf08/osKB9FebltKBerNT4CtiYcfT
         /JQseiORfi8ew==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id j3so465999uap.3;
        Thu, 21 Feb 2019 16:30:04 -0800 (PST)
X-Gm-Message-State: AHQUAubH7PWsqEgfPPpFSI0miK+w7z4lNJcjJpBLE9TaRNSn3OcNhJLJ
        iJ4DBQlO/J1kFmBSWWXUkWzkkX/PwK6HByH82hI=
X-Google-Smtp-Source: AHgI3IYho/yO2ZET2dyJJEy1Rb9y/80VQF9c6BuG/uqUHFoN4tyOjP+28TjL6C+iokeimpBZ/nsps8vgtCdb2guWb5U=
X-Received: by 2002:ab0:c07:: with SMTP id a7mr810847uak.55.1550795403122;
 Thu, 21 Feb 2019 16:30:03 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 22 Feb 2019 09:29:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNATwe3NwhApYFQyCob4+xSrr4a9zUY34EX-QN8pWoocvoA@mail.gmail.com>
Message-ID: <CAK7LNATwe3NwhApYFQyCob4+xSrr4a9zUY34EX-QN8pWoocvoA@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v5.0(-rc8)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull a little more Kbuild fixes.

Thanks.




The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40:

  Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v5.0-2

for you to fetch changes up to 207a369e3c085799e7836221f64e7a7329985fb6:

  sh: fix build error for invisible CONFIG_BUILTIN_DTB_SOURCE
(2019-02-13 23:29:42 +0900)

----------------------------------------------------------------
Kbuild fixes for v5.0 (2nd)

 - fix scripts/kallsyms.c to correctly check too long symbol names

 - fix sh build error for the combination of CONFIG_OF_EARLY_FLATTREE=y
   and CONFIG_USE_BUILTIN_DTB=n

----------------------------------------------------------------
Eugene Loh (1):
      kallsyms: Handle too long symbols in kallsyms.c

Masahiro Yamada (1):
      sh: fix build error for invisible CONFIG_BUILTIN_DTB_SOURCE

 arch/sh/boot/dts/Makefile | 2 +-
 scripts/kallsyms.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)


-- 
Best Regards
Masahiro Yamada
