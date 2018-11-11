Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6917DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9342148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="r7tCVcL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9342148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbeKLCuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 21:50:18 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:24133 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729222AbeKLCuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 21:50:18 -0500
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wABH14p8002885;
        Mon, 12 Nov 2018 02:01:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wABH14p8002885
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541955665;
        bh=75ORlgavqN1w3O3MMWTjnP8BCuZ4aPvPbtpjuHVki0w=;
        h=From:Date:Subject:To:Cc:From;
        b=r7tCVcL5J5pSwcuLAKtImbo4FaaZnYgsoflIT0Wj4GLcAygq173Ms3NoI7YawSQL/
         Ji30O7+CYa2+pmTdImxkjgSUJmBlwouXp4KEg/JzQwY5rg7pZb5zf1PWupd2dQJQ4E
         NGf08VOYYLn20AepEfEgM4ESUAuLF9q7+czN+trIHDJgSg0YI5zQYAB9wCSW2DMPdj
         arVqa9CRsI5JufBhOo7tzcVbNeq7bJWZ45Uq7PAZtwoMoLagmmblML68kw5NBJdSvi
         lkGROwTNS3vcnI5EnTikFszyf3U+xvSWEUT0FPAvtEgiVBOXjnpdbxm8MQdxAgTp4P
         PMHNrJq3DCe/g==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id p74so3816265vsc.0;
        Sun, 11 Nov 2018 09:01:04 -0800 (PST)
X-Gm-Message-State: AGRZ1gJBz0yzSEK6yIqkfxspDVNye79/03lzM8C7ujgwX7s+PndJ9pMK
        Os82Ff/LWSmDlafZtPZLz4paDVrUhsTBiJ0ft20=
X-Google-Smtp-Source: AJdET5egBq3v+N/kfjtk4lblEyy+2+cpT9LmW+pAwjO0kTq8fAQgKrqDL0Pq7F2hkBHLhXp157CMzqva1xn3h3REI54=
X-Received: by 2002:a67:5f03:: with SMTP id t3mr7130998vsb.155.1541955663409;
 Sun, 11 Nov 2018 09:01:03 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 12 Nov 2018 02:00:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNASb25Js1sDLmRsfKrEyimat7-fETn-MEDGJtfQ9EfgUbw@mail.gmail.com>
Message-ID: <CAK7LNASb25Js1sDLmRsfKrEyimat7-fETn-MEDGJtfQ9EfgUbw@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v4.20-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull Kbuild fixes.

Thanks!




The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v4.20

for you to fetch changes up to d5615e472d23e854e96192103b6ae7977e705f01:

  builddeb: Fix inclusion of dtbs in debian package (2018-11-11 23:04:53 +0900)

----------------------------------------------------------------
Kbuild fixes for v4.20

 - fix build errors in binrpm-pkg and bindeb-pkg targets

 - fix false positive matches in merge_config.sh

 - fix build version mismatch in deb-pkg target

 - fix dtbs_install handling in (bin)deb-pkg target

 - revert a commit that allows setlocalversion to write to source tree

----------------------------------------------------------------
Guenter Roeck (1):
      Revert "scripts/setlocalversion: git: Make -dirty check more robust"

Masahiro Yamada (4):
      kbuild: rpm-pkg: fix binrpm-pkg breakage when O= is used
      kbuild: deb-pkg: fix bindeb-pkg breakage when O= is used
      kconfig: merge_config: avoid false positive matches from comment lines
      kbuild: deb-pkg: fix too low build version number

Rob Herring (1):
      builddeb: Fix inclusion of dtbs in debian package

 scripts/kconfig/merge_config.sh |  7 ++++---
 scripts/package/builddeb        |  6 +++---
 scripts/package/mkdebian        |  7 +++++--
 scripts/package/mkspec          | 11 ++++++-----
 scripts/setlocalversion         |  2 +-
 5 files changed, 19 insertions(+), 14 deletions(-)


-- 
Best Regards
Masahiro Yamada
