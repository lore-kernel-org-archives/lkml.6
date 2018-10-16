Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5EAC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C1D208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C1D208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeJPK1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:27:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41624 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbeJPK1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:27:52 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id ABFA21449BE5F;
        Mon, 15 Oct 2018 19:39:47 -0700 (PDT)
Date:   Mon, 15 Oct 2018 19:39:45 -0700 (PDT)
Message-Id: <20181015.193945.304905055642913000.davem@davemloft.net>
To:     gregkh@linuxfoundation.org
CC:     akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Sparc
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 15 Oct 2018 19:39:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Revert the %pOF change, it causes regressions.

2) Wire up io_pgetevents().

3) Fix perf events on single-PCR sparc64 cpus.

4) Do proper perf event throttling like arm and x86.

Please pull, thanks a lot!

The following changes since commit 0854ba5ff5c938307cd783e996b62c83f1ce923b:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc (2018-10-08 16:25:01 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to a06ecbfe784ceb22e56ae3cd75fe77138e7cfa0b:

  Revert "sparc: Convert to using %pOFn instead of device_node.name" (2018-10-15 18:32:54 -0700)

----------------------------------------------------------------
David S. Miller (6):
      sparc: Wire up io_pgetevents system call.
      sparc: Fix single-pcr perf event counter management.
      sparc: Throttle perf events properly.
      sparc64: Make proc_id signed.
      sparc64: Set %l4 properly on trap return after handling signals.
      Revert "sparc: Convert to using %pOFn instead of device_node.name"

Kees Cook (1):
      sunvdc: Remove VLA usage

 arch/sparc/include/asm/cpudata_64.h  |  2 +-
 arch/sparc/include/uapi/asm/unistd.h |  3 ++-
 arch/sparc/kernel/auxio_64.c         |  4 ++--
 arch/sparc/kernel/perf_event.c       | 26 ++++++++++++++++++++++----
 arch/sparc/kernel/power.c            |  4 ++--
 arch/sparc/kernel/prom_32.c          | 26 +++++++++++++-------------
 arch/sparc/kernel/prom_64.c          | 68 ++++++++++++++++++++++++++++++++++----------------------------------
 arch/sparc/kernel/rtrap_64.S         |  3 ++-
 arch/sparc/kernel/systbls_32.S       |  2 +-
 arch/sparc/kernel/systbls_64.S       |  4 ++--
 drivers/block/sunvdc.c               | 14 ++++++++++----
 11 files changed, 91 insertions(+), 65 deletions(-)
