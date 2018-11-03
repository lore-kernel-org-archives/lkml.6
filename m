Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDB9C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 07:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783BC2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 07:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rBrnfC4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783BC2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeKCRI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 13:08:57 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:50535 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeKCRI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 13:08:56 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wA37wE68003231;
        Sat, 3 Nov 2018 16:58:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wA37wE68003231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541231895;
        bh=4+KLFNOokqno/WpbbY8lioywm8K1K3sGFdZA7vB+5lw=;
        h=From:Date:Subject:To:Cc:From;
        b=rBrnfC4LdH49WzDqwGw1ME/S7crxb/wbo4xcUPF8y8cpJxIJ4kI3h0qeLOf/1wpRH
         zh7KJWwsUMbxKSizm7zLcnL1w5mLtwclQcUZqhV4p+M0jy3M7i+WkaNIARGdBVhzJY
         mZB6VS3tA/of+gAIg0/Ubn2D3Kj+ktkQBD77TVANSGgp+R1EA//wGMgOFBc0QORbtu
         JdsrNx41KsH7gfGLTwPVniZuWWo0oVmETKKII6cDmsRGB9VIvNYIJmR4vp+2gYN31x
         rzNYUI9M6TFXkgOtAISLPZUS4lv8YGXstIVbx7txndwKxg1xS/epHCvHk3iPnfv8xG
         df8fTc++iD7MA==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id d19so166539uaq.11;
        Sat, 03 Nov 2018 00:58:14 -0700 (PDT)
X-Gm-Message-State: AGRZ1gIuohYSTdO5acKgkw/RMRK+bvBqxtlJRijDbHxfYslJv6KSrmyD
        Kt3VqKH4XjFWEwMlGr+6pmZch7N52HjAft4QGfE=
X-Google-Smtp-Source: AJdET5dZh+0U7cpNBtFAB7IIqCiqp3eXKWwrIRiQ4zQPDCNlKRvm6QeP3WiKK3HsyQdZOF21vhqP5bRbxi7ZWje3jVY=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr172636uaj.42.1541231893650;
 Sat, 03 Nov 2018 00:58:13 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 3 Nov 2018 16:57:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNATzERTiys46vFOTLWBbZ8TXOdT-EojWW7aKZxWwahkTpg@mail.gmail.com>
Message-ID: <CAK7LNATzERTiys46vFOTLWBbZ8TXOdT-EojWW7aKZxWwahkTpg@mail.gmail.com>
Subject: [GIT PULL] more Kbuild updates for v4.20
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

Please pull a little more Kbuild updates.
Thanks!




The following changes since commit 310c7585e8300ddc46211df0757c11e4299ec482:

  Merge tag 'nfsd-4.20' of git://linux-nfs.org/~bfields/linux
(2018-10-30 13:03:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v4.20-2

for you to fetch changes up to 995167420797c000bff1f0787ab2390ffa1a9784:

  kbuild: remove cc-name variable (2018-11-02 22:49:01 +0900)

----------------------------------------------------------------
Kbuild updates for v4.20 (2nd)

- clean-up leftovers in Kconfig files

- remove stale oldnoconfig and silentoldconfig targets

- remove unneeded cc-fullversion and cc-name variables

- improve merge_config script to allow overriding option prefix

----------------------------------------------------------------
Christoph Hellwig (4):
      scsi: aha152x: rename the PCMCIA define
      powerpc: remove CONFIG_PCI_QSPAN
      powerpc: remove CONFIG_MCA leftovers
      powerpc: PCI_MSI needs PCI

Masahiro Yamada (5):
      kconfig: remove oldnoconfig target
      kconfig: remove silentoldconfig target
      kbuild: remove unused cc-fullversion variable
      kbuild: replace cc-name test with CONFIG_CC_IS_CLANG
      kbuild: remove cc-name variable

Petr Vorel (1):
      merge_config.sh: Allow to define config prefix

 Documentation/kbuild/makefiles.txt | 15 ---------------
 Documentation/networking/ice.rst   |  2 +-
 Makefile                           |  4 ++--
 arch/mips/Makefile                 |  2 +-
 arch/mips/vdso/Makefile            |  2 +-
 arch/powerpc/Kconfig               | 13 -------------
 arch/powerpc/Makefile              |  4 ++--
 arch/powerpc/platforms/40x/Kconfig |  1 +
 arch/powerpc/platforms/44x/Kconfig |  2 ++
 drivers/scsi/Kconfig               |  6 +++---
 drivers/scsi/aha152x.c             | 14 +++++++-------
 drivers/scsi/pcmcia/aha152x_core.c |  2 +-
 scripts/Kbuild.include             |  8 --------
 scripts/Makefile.extrawarn         |  2 +-
 scripts/kconfig/Makefile           | 16 +---------------
 scripts/kconfig/conf.c             |  7 -------
 scripts/kconfig/merge_config.sh    |  6 +++++-
 17 files changed, 28 insertions(+), 78 deletions(-)


-- 
Best Regards
Masahiro Yamada
