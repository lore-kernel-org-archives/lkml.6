Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id S5MlOw3iG1utfgAAmS7hNA
	; Sat, 09 Jun 2018 14:20:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 15D09608C8; Sat,  9 Jun 2018 14:20:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0D503601C3;
	Sat,  9 Jun 2018 14:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D503601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753343AbeFIOUG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 10:20:06 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:56614 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753207AbeFIOUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 10:20:04 -0400
Received: from localhost (unknown [209.117.102.182])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 56D6B136B6558;
        Sat,  9 Jun 2018 07:20:03 -0700 (PDT)
Date: Sat, 09 Jun 2018 10:20:02 -0400 (EDT)
Message-Id: <20180609.102002.1007793250109793345.davem@davemloft.net>
To: torvalds@linux-foundation.org
CC: akpm@linux-foundation.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] IDE
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 09 Jun 2018 07:20:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull to get these IDE updates.  Primarily IRQ disabling
avoidance changes from Sebastian Andrzej Siewior.

Thanks!

The following changes since commit 5037be168f0e4ee910602935b1180291082d3aac:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2018-06-05 11:13:17 -0700)

are available in the Git repository at:

  gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/ide.git 

for you to fetch changes up to 47b82e88180c3c6db795a43373beab47cb073f7a:

  ide: don't enable/disable interrupts in force threaded-IRQ mode (2018-06-05 16:26:47 -0400)

----------------------------------------------------------------
Sebastian Andrzej Siewior (4):
      alim15x3: move irq-restore before pci_dev_put()
      ide: Handle irq disabling consistently
      ide: don't disable interrupts during kmap_atomic()
      ide: don't enable/disable interrupts in force threaded-IRQ mode

 drivers/ide/alim15x3.c     |  2 +-
 drivers/ide/ide-io.c       |  4 ++--
 drivers/ide/ide-iops.c     | 13 +++++++++----
 drivers/ide/ide-taskfile.c | 10 +---------
 kernel/irq/manage.c        |  1 +
 5 files changed, 14 insertions(+), 16 deletions(-)
