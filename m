Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E67C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6553D2083C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6553D2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732598AbeGKLBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:01:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55852 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732517AbeGKLBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:01:10 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B4FB3D48;
        Wed, 11 Jul 2018 10:57:24 +0000 (UTC)
Date:   Wed, 11 Jul 2018 12:57:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 4.18-rc5
Message-ID: <20180711105722.GA18131@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/ tags/char-misc-4.18-rc5

for you to fetch changes up to 87ed1405ef09d29a14df43295f7b6a93b63bfe6e:

  nvmem: Don't let a NULL cell_id for nvmem_cell_get() crash us (2018-07-07 17:30:25 +0200)

----------------------------------------------------------------
Char/Misc fixes for 4.18-rc5

Here are a few char/misc driver fixes for 4.18-rc5.

The "largest" stuff here is fixes for the UIO changes in 4.18-rc1 that
caused breakages for some people.  Thanks to Xiubo Li for fixing them
quickly.  Other than that, minor fixes for thunderbolt, vmw_balloon,
nvmem, mei, ibmasm, and mei drivers.  There's also a MAINTAINERS update
where Rafael is offering to help out with reviewing driver core patches.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Usyskin (1):
      mei: discard messages from not connected client during power down.

Christophe Jaillet (1):
      fpga: altera-cvp: Fix an error handling path in 'altera_cvp_probe()'

Douglas Anderson (1):
      nvmem: Don't let a NULL cell_id for nvmem_cell_get() crash us

Jann Horn (1):
      ibmasm: don't write out of bounds in read handler

Mika Westerberg (1):
      thunderbolt: Notify userspace when boot_acl is changed

Nadav Amit (1):
      vmw_balloon: fix inflation with batching

Rafael J. Wysocki (1):
      MAINTAINERS: Add myself as driver core changes reviewer

Xiubo Li (3):
      uio: use request_threaded_irq instead
      uio: change to use the mutex lock instead of the spin lock
      uio: fix crash after the device is unregistered

 MAINTAINERS                    |   1 +
 drivers/fpga/altera-cvp.c      |   6 +-
 drivers/misc/ibmasm/ibmasmfs.c |  27 +-------
 drivers/misc/mei/interrupt.c   |   5 +-
 drivers/misc/vmw_balloon.c     |   4 +-
 drivers/nvmem/core.c           |   4 ++
 drivers/thunderbolt/domain.c   |   4 ++
 drivers/uio/uio.c              | 139 ++++++++++++++++++++++++++++++-----------
 include/linux/uio_driver.h     |   2 +-
 9 files changed, 126 insertions(+), 66 deletions(-)
