Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591AFC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 07:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F34204EC
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 07:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ObDW5zDZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F34204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbeIILwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 07:52:13 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:54124 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbeIILwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 07:52:13 -0400
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w8973VJ3020107;
        Sun, 9 Sep 2018 16:03:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w8973VJ3020107
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536476611;
        bh=ywZrNDZhbyp6Fa5/ppqnqeC/7/aiWrd7+1CGPOAq1cs=;
        h=From:Date:Subject:To:Cc:From;
        b=ObDW5zDZXc0ByG2j/4TgGqkz9jcWWEcSojkqecKIBhTWWWfveRZBxaIHo97+XVLd6
         7aQvNABEp5CNStXe/NIyOXJTMDLF2sgZdRE8SmQlXNrP6sC2MPgb/ZSAs6CXvMf09A
         8x+e04TnqmErx4dsMj1Y0sgNN0hMDFfEGfx4KI+xR1i+FunlDPizuDVltcyXSia8rN
         QMS/funRV+JQv2okQtjbSmZrPSHHLDuFt/olpef4hux6TM7N8RFFSb9MsXJCZeGv95
         OE0jzljsdWLiWkPBp1q0/JAUnIEhALttTW7YBnEOLv20fzcWwlclbCQx795/Irv5Hm
         ppaKLCywKE5PA==
X-Nifty-SrcIP: [209.85.221.169]
Received: by mail-vk1-f169.google.com with SMTP id q184-v6so2267852vke.7;
        Sun, 09 Sep 2018 00:03:31 -0700 (PDT)
X-Gm-Message-State: APzg51CuFgjM4VTHHZnEE94aGvP+5mvccHt1+U2LxRbS1VIerc8DphXR
        Vl75G33lT3WO9Z7xV1i9eKZEouugYR+KBXBaVEk=
X-Google-Smtp-Source: ANB0VdbIJdA2WzPsKkEHj1c3ZuJg0I4q1B4sb502RhQzoaptS6AXT3x5/LAVhF3rl7uTmbshcMBx1zfpb069bTM8cJI=
X-Received: by 2002:a1f:9004:: with SMTP id s4-v6mr4824629vkd.10.1536476610497;
 Sun, 09 Sep 2018 00:03:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Sun, 9 Sep 2018 00:02:50 -0700 (PDT)
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 9 Sep 2018 16:02:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT7fEjvbBTQVHvK3k5qF6K61_k+g-TNLHjspKX2C_B7hA@mail.gmail.com>
Message-ID: <CAK7LNAT7fEjvbBTQVHvK3k5qF6K61_k+g-TNLHjspKX2C_B7hA@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v4.19-rc3
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

Please pull some Kbuild fixes.

Thanks!




The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v4.19

for you to fetch changes up to f0b0d88a825149ef3b06656886bc211c71dcb852:

  kbuild: modules_install: warn when missing System.map file
(2018-09-09 09:14:07 +0900)

----------------------------------------------------------------
Kbuild fixes for v4.19

 - make setlocalversion more robust about -dirty check

 - loosen the pkg-config requirement for Kconfig

 - change missing depmod to a warning from an error

 - warn modules_install when System.map is missing

----------------------------------------------------------------
Genki Sky (1):
      scripts/setlocalversion: git: Make -dirty check more robust

Lukas Bulwahn (1):
      kconfig: remove a spurious self-assignment

Masahiro Yamada (1):
      kconfig: do not require pkg-config on make {menu,n}config

Randy Dunlap (2):
      kbuild: make missing $DEPMOD a Warning instead of an Error
      kbuild: modules_install: warn when missing System.map file

 Documentation/process/changes.rst  |  2 +-
 scripts/depmod.sh                  |  5 +++--
 scripts/kconfig/Makefile           |  1 -
 scripts/kconfig/check-pkgconfig.sh |  8 --------
 scripts/kconfig/gconf-cfg.sh       |  7 +++++++
 scripts/kconfig/mconf-cfg.sh       | 25 ++++++++++++++-----------
 scripts/kconfig/mconf.c            |  1 -
 scripts/kconfig/nconf-cfg.sh       | 25 ++++++++++++++-----------
 scripts/kconfig/qconf-cfg.sh       |  7 +++++++
 scripts/setlocalversion            |  2 +-
 10 files changed, 47 insertions(+), 36 deletions(-)
 delete mode 100644 scripts/kconfig/check-pkgconfig.sh


-- 
Best Regards
Masahiro Yamada
