Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CABECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516FF20869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516FF20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeJ0Hr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 03:47:26 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52182 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbeJ0HrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 03:47:25 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2A9E8148D5088;
        Fri, 26 Oct 2018 16:08:29 -0700 (PDT)
Date:   Fri, 26 Oct 2018 16:08:28 -0700 (PDT)
Message-Id: <20181026.160828.636318063368651002.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Sparc
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 26 Oct 2018 16:08:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Some more sparc fixups, mostly aimed at getting the allmodconfig build
up and clean again.

Please pull, thanks a lot!

The following changes since commit caf539cd1087f7c36b9c4df271575e9aee49fde5:

  sparc: Fix VDSO build with older binutils. (2018-10-25 10:36:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 6c2fc9cddc1ffdef8ada1dc8404e5affae849953:

  sparc64: Rework xchg() definition to avoid warnings. (2018-10-26 15:39:49 -0700)

----------------------------------------------------------------
David Miller (1):
      sparc64: Make corrupted user stacks more debuggable.

David S. Miller (2):
      sparc64: Export __node_distance.
      sparc64: Rework xchg() definition to avoid warnings.

 arch/sparc/include/asm/cmpxchg_64.h   |  7 ++++++-
 arch/sparc/include/asm/switch_to_64.h |  3 ++-
 arch/sparc/kernel/process_64.c        | 25 +++++++++++++++++++------
 arch/sparc/kernel/rtrap_64.S          |  1 +
 arch/sparc/kernel/signal32.c          | 12 ++++++++++--
 arch/sparc/kernel/signal_64.c         |  6 +++++-
 arch/sparc/mm/init_64.c               |  1 +
 7 files changed, 44 insertions(+), 11 deletions(-)
