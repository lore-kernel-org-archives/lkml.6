Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9435CC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420682145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420682145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeJSHgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 03:36:42 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42742 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbeJSHgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 03:36:41 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AB85F140C2BA6;
        Thu, 18 Oct 2018 16:33:23 -0700 (PDT)
Date:   Thu, 18 Oct 2018 16:33:23 -0700 (PDT)
Message-Id: <20181018.163323.331525365210775149.davem@davemloft.net>
To:     gregkh@linuxfoundation.org
CC:     akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Sparc
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 18 Oct 2018 16:33:23 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The main bit here is fixing how fallback system calls are handled in
the sparc vDSO.

Unfortunately, I fat fingered the commit and some perf debugging hacks
slipped into the vDSO fix, which I revert in the very next commit.

Please pull, thanks a lot!

The following changes since commit c343db455eb3105f11bb5ac290d77ab2006b0209:

  Merge branch 'parisc-4.19-3' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux (2018-10-17 14:01:00 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 27faeebd00813cd52a140e8944b6b32729b50e61:

  sparc: Revert unintended perf changes. (2018-10-18 11:32:29 -0700)

----------------------------------------------------------------
Dan Carpenter (1):
      sparc: vDSO: Silence an uninitialized variable warning

David S. Miller (2):
      sparc: Fix syscall fallback bugs in VDSO.
      sparc: Revert unintended perf changes.

 arch/sparc/vdso/vclock_gettime.c | 12 +++++++++++-
 arch/sparc/vdso/vma.c            |  4 +++-
 2 files changed, 14 insertions(+), 2 deletions(-)
