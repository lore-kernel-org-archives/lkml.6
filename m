Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8913C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BF52084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BF52084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeJZDCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:02:04 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56132 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbeJZDCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:02:04 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1DA8D1478AD9E;
        Thu, 25 Oct 2018 11:28:12 -0700 (PDT)
Date:   Thu, 25 Oct 2018 11:28:09 -0700 (PDT)
Message-Id: <20181025.112809.1174535381380570860.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Sparc
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 25 Oct 2018 11:28:12 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull to get this build regression fix.

Thank you.

The following changes since commit 44adbac8f7217040be97928cd19998259d9d4418:

  Merge branch 'work.tty-ioctl' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2018-10-24 14:43:41 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to caf539cd1087f7c36b9c4df271575e9aee49fde5:

  sparc: Fix VDSO build with older binutils. (2018-10-25 10:36:19 -0700)

----------------------------------------------------------------
David S. Miller (1):
      sparc: Fix VDSO build with older binutils.

 arch/sparc/include/asm/vdso.h       |   2 --
 arch/sparc/vdso/vclock_gettime.c    | 149 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 arch/sparc/vdso/vdso-layout.lds.S   |   3 --
 arch/sparc/vdso/vdso.lds.S          |   2 ++
 arch/sparc/vdso/vdso2c.h            |  17 +---------
 arch/sparc/vdso/vdso32/vdso32.lds.S |   2 ++
 arch/sparc/vdso/vma.c               | 222 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 7 files changed, 335 insertions(+), 62 deletions(-)
