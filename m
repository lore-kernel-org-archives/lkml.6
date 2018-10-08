Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93715C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A892087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A892087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbeJHN6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:58:44 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48726 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeJHN6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:58:44 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F15B91434B9EB;
        Sun,  7 Oct 2018 23:48:32 -0700 (PDT)
Date:   Sun, 07 Oct 2018 23:48:32 -0700 (PDT)
Message-Id: <20181007.234832.1963273306260975472.davem@davemloft.net>
To:     gregkh@linuxfoundation.org
CC:     akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Sparc
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 07 Oct 2018 23:48:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I've been moving so haven't had access to my Sparc boxes during this
time.  That's been resolved, and now I can get the patches flowing
again.

1) Minor fallthru comment tweaks from Gustavo A. R. Silva.

2) VLA removal from Kees Cook.

3) Make sparc vdso Makefile match x86, from Masahiro Yamada.

4) Fix clock divider programming in mach64 driver, from Mikulas
   Patocka.

Please pull, thanks a lot!

The following changes since commit c1d84a1b42ef70d8ae601df9cadedc7ed4f1beb1:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-10-06 02:11:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to b7dc10b64f6190a008f05baf697d4d8fa9b8ed51:

  sparc64: fix fall-through annotation (2018-10-07 22:42:02 -0700)

----------------------------------------------------------------
Colin Ian King (1):
      oradax: remove redundant null check before kfree

Gustavo A. R. Silva (2):
      sparc32: fix fall-through annotation
      sparc64: fix fall-through annotation

Kees Cook (1):
      sparc64: viohs: Remove VLA usage

Masahiro Yamada (1):
      sparc: vdso: clean-up vdso Makefile

Mikulas Patocka (1):
      mach64: detect the dot clock divider correctly on sparc

Rob Herring (2):
      sparc: Convert to using %pOFn instead of device_node.name
      sbus: Use of_get_child_by_name helper

 arch/sparc/kernel/auxio_64.c         |  4 ++--
 arch/sparc/kernel/kgdb_32.c          |  2 +-
 arch/sparc/kernel/kgdb_64.c          |  2 +-
 arch/sparc/kernel/power.c            |  4 ++--
 arch/sparc/kernel/prom_32.c          | 26 +++++++++++++-------------
 arch/sparc/kernel/prom_64.c          | 68 ++++++++++++++++++++++++++++++++++----------------------------------
 arch/sparc/kernel/viohs.c            | 12 +++++++++---
 arch/sparc/vdso/Makefile             |  8 +++-----
 drivers/sbus/char/openprom.c         | 11 +----------
 drivers/sbus/char/oradax.c           |  3 +--
 drivers/video/fbdev/aty/atyfb.h      |  3 ++-
 drivers/video/fbdev/aty/atyfb_base.c |  7 ++++---
 drivers/video/fbdev/aty/mach64_ct.c  | 10 +++++-----
 13 files changed, 78 insertions(+), 82 deletions(-)
