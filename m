Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B219C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51B720658
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdDmC/PT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51B720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeHQJvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 05:51:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeHQJvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 05:51:48 -0400
Received: from redbean (ip5f5adbdf.dynamic.kabel-deutschland.de [95.90.219.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69FFC21857;
        Fri, 17 Aug 2018 06:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534488577;
        bh=40tOcY8Sk6iIeR1e6cPJ9CIY0DMlUeBeB7/+HiPpUK8=;
        h=Date:From:To:Cc:Subject:From;
        b=SdDmC/PTVpnEV0tGAkmdz9cnOM3qxluIfXhYGgQFJJtGb8TPxAu9bhqCqnrQ1uubc
         m22w3O9xS1YrDm2kGZyoZywcLDAHp/1BNQLiFppHzIB3PsqvI4nFmsIVSWlSC5ksTR
         jBt93aOnhG+uqMC0d/ZWpqfd0Uypgher80wW1hBQ=
Date:   Fri, 17 Aug 2018 08:49:32 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules updates for v4.19
Message-ID: <20180817064932.oofueqxmgkk4ujyh@redbean>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull below to receive modules updates for the 4.19 merge window.
Details can be found in the signed tag.

Thanks,

Jessica

---
The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v4.19

for you to fetch changes up to 9be936f4b3a2ec101f54cff9cf1a6abf67263c50:

  kernel/module: Use kmemdup to replace kmalloc+memcpy (2018-08-02 18:03:17 +0200)

----------------------------------------------------------------
Modules updates for v4.19

Summary of modules changes for the 4.19 merge window:

- Fix modules kallsyms for livepatch. Livepatch modules can have
  SHN_UNDEF symbols in their module symbol tables for later symbol
  resolution, but kallsyms shouldn't be returning these symbols

- Some code cleanups and minor reshuffling in load_module() were done to
  log the module name when module signature verification fails

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: module: fix modsign build error

Jason A. Donenfeld (1):
      module: print sensible error code

Jessica Yu (4):
      module: exclude SHN_UNDEF symbols from kallsyms api
      module: make it clear when we're handling the module copy in info->hdr
      module: setup load info before module_sig_check()
      modsign: log module name in the event of an error

Masahiro Yamada (1):
      module: replace VMLINUX_SYMBOL_STR() with __stringify() or string literal

zhong jiang (1):
      kernel/module: Use kmemdup to replace kmalloc+memcpy

 arch/arm/include/asm/module.h |   1 +
 include/linux/module.h        |   4 +-
 kernel/module-internal.h      |  25 +++++++-
 kernel/module.c               | 143 +++++++++++++++++++-----------------------
 kernel/module_signing.c       |  12 ++--
 5 files changed, 100 insertions(+), 85 deletions(-)
