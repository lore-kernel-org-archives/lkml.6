Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537A2C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 05:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21182147C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 05:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21182147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeHVIjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 04:39:32 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50568 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeHVIjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 04:39:32 -0400
Received: from localhost (unknown [172.58.46.230])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EE20010316847;
        Tue, 21 Aug 2018 22:16:17 -0700 (PDT)
Date:   Tue, 21 Aug 2018 22:16:12 -0700 (PDT)
Message-Id: <20180821.221612.1820997428691874754.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Sparc
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 Aug 2018 22:16:18 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nothing super serious:

1) Convert sparc32 over to NO_BOOTMEM, from Mike Rapoport.

2) Use dma_noncoherent_ops on sparc32, from Christoph Hellwig

3) Fix kbuild defconfig handling on sparc32, from Masahiro Yamada.

Please pull, thanks a lot.

The following changes since commit 778a33959a8ad4cb1ea2f4c5119f9e1e8b9f9d9b:

  Merge tag 'please-pull-noboot' of git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux (2018-08-20 19:37:09 -0700)

are available in the Git repository at:

  gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to c84ca616b1260949782f408271336f0eda056c61:

  sparc: fix KBUILD_DEFCONFIG for ARCH=sparc32 (2018-08-21 12:41:12 -0700)

----------------------------------------------------------------
Christoph Hellwig (1):
      sparc: use generic dma_noncoherent_ops

David S. Miller (1):
      Merge branch 'sparc32-NO_BOOTMEM'

Masahiro Yamada (1):
      sparc: fix KBUILD_DEFCONFIG for ARCH=sparc32

Mike Rapoport (3):
      sparc: mm/init_32: kill trailing whitespace
      sparc32: switch to NO_BOOTMEM
      sparc32: split ramdisk detection and reservation to a helper function

 arch/sparc/Kconfig                   |   6 ++--
 arch/sparc/Makefile                  |   6 ++--
 arch/sparc/include/asm/dma-mapping.h |   5 ++-
 arch/sparc/kernel/ioport.c           | 193 +++++++++++++++++---------------------------------------------------------------------------------------
 arch/sparc/mm/init_32.c              | 127 ++++++++++++++++++++++++++------------------------------------------
 5 files changed, 88 insertions(+), 249 deletions(-)
