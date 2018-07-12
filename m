Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D1BC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C48920C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="byYKGzRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C48920C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbeGLILq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:11:46 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:56352 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeGLILo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:11:44 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w6C81cQf012716;
        Thu, 12 Jul 2018 17:01:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w6C81cQf012716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531382500;
        bh=oHPMtn1maAPdf5s1G4yfmUzHxpHQ1UlHhwhFDZaST9o=;
        h=From:To:Cc:Subject:Date:From;
        b=byYKGzRljFTHKMojv2RgD3fQ5as7vYJqxfROaj0GqhuDlDNWCRuXxi71sP7hbV/Kr
         zCNGEl17CxuoA83mlOYISZa6TgjDYca21u2NZzjZGmO5nFWIFSFaXlQgstt2uy35DY
         HIQWRae12CSqAHrMtUSABX6UX0J21AOn3bJq6peOGLKAiPUHKDNQssQQ2XGp2F6dJo
         XW0ZPG98badM8Uwmsaf0zywcDR8nhWolPZbZG5P5jVHqDmWznu3cz8lnhmQ8/hMZHe
         5vEl6cwe0yEqv6zo8zlE/uUkPAdZCFxpo1+qBvYZ1I1lH09HZFzbMV0akq21LnQSEv
         jVDP1mly+U/Cg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>, x86@kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        openrisc@lists.librecores.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Jeff Dike <jdike@addtoit.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/6] kbuild: clean-up and rename LDFLAGS to KBUILD_LDFLAGS
Date:   Thu, 12 Jul 2018 17:01:30 +0900
Message-Id: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series renames LDFLAGS to KBUILD_LDFLAGS
after some Makefile cleanups.

Currently, the last patch does not apply to Linus' tree
due to missing pre-requisite patches.

I will resolve conflicts as needed.



Masahiro Yamada (6):
  um: remove redundant 'export LDFLAGS' in arch/x86/Makefile.um
  ARM: vfp: clean-up arch/arm/vfp/Makefile
  kbuild: remove redundant LDFLAGS clearing in arch/*/Makefile
  kbuild: replace $(LDFLAGS) $(ldflags-y) with $(ld_flags)
  kbuild: change ld_flags to contain LDFLAGS_$(@F)
  kbuild: rename LDFLAGS to KBUILD_LDFLAGS

 Makefile                           | 6 +++---
 arch/arc/Makefile                  | 2 +-
 arch/arm/Makefile                  | 7 ++-----
 arch/arm/vfp/Makefile              | 5 +----
 arch/arm64/Makefile                | 4 ++--
 arch/c6x/Makefile                  | 3 +--
 arch/h8300/Makefile                | 2 +-
 arch/hexagon/Makefile              | 4 +---
 arch/m68k/Makefile                 | 2 +-
 arch/microblaze/Makefile           | 4 ++--
 arch/mips/Makefile                 | 2 +-
 arch/mips/boot/compressed/Makefile | 2 +-
 arch/mips/lasat/image/Makefile     | 2 +-
 arch/nds32/Makefile                | 4 ++--
 arch/openrisc/Makefile             | 1 -
 arch/powerpc/Makefile              | 6 +++---
 arch/riscv/Makefile                | 5 ++---
 arch/s390/Makefile                 | 2 +-
 arch/sh/Makefile                   | 4 ++--
 arch/sparc/Makefile                | 4 ++--
 arch/um/Makefile                   | 2 +-
 arch/um/drivers/Makefile           | 4 ++--
 arch/x86/Makefile                  | 4 ++--
 arch/x86/Makefile.um               | 4 +---
 arch/x86/boot/compressed/Makefile  | 6 +++---
 arch/xtensa/Makefile               | 2 +-
 arch/xtensa/boot/boot-elf/Makefile | 2 +-
 scripts/Kbuild.include             | 4 ++--
 scripts/Makefile.build             | 4 ++--
 scripts/Makefile.lib               | 5 ++---
 scripts/Makefile.modpost           | 2 +-
 31 files changed, 48 insertions(+), 62 deletions(-)

-- 
2.7.4

