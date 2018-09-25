Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ED9C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A285208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A285208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbeIYUbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:31:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50878 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbeIYUbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:31:33 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 51F34E23;
        Tue, 25 Sep 2018 14:23:47 +0000 (UTC)
Date:   Tue, 25 Sep 2018 16:23:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 4.19-rc6
Message-ID: <20180925142344.GA26980@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Yes, the oddity of sending a pull request to myself is not lost on me...]

The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804:

  Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-4.19-rc4

for you to fetch changes up to 422b3db2a5036add39a82425b1dd9fb6c96481e8:

  firmware: Fix security issue with request_firmware_into_buf() (2018-09-12 09:31:00 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 4.19-rc4

Here are a small handful of char/misc driver fixes for 4.19-rc4.

All of them are simple, resolving reported problems in a few drivers.
Full details are in the shortlog.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Usyskin (1):
      mei: ignore not found client in the enumeration

Bryant G. Ly (1):
      misc: ibmvsm: Fix wrong assignment of return code

Gustavo A. R. Silva (1):
      misc: hmc6352: fix potential Spectre v1

John Hubbard (1):
      mei: fix use-after-free in mei_cl_write

K. Y. Srinivasan (1):
      Tools: hv: Fix a bug in the key delete code

Minchan Kim (1):
      android: binder: fix the race mmap and alloc_new_buf_locked

Rishabh Bhatnagar (1):
      firmware: Fix security issue with request_firmware_into_buf()

Stephen Hemminger (1):
      vmbus: don't return values for uninitalized channels

Tomas Winkler (2):
      mei: bus: fix hw module get/put balance
      mei: bus: need to unlink client before freeing

Wei Yongjun (1):
      fpga: dfl: fme: fix return value check in in pr_mgmt_init()

 drivers/android/binder_alloc.c      | 43 ++++++++++++++++++++++++++++++-------
 drivers/base/firmware_loader/main.c | 30 +++++++++++++++-----------
 drivers/fpga/dfl-fme-pr.c           |  2 +-
 drivers/hv/vmbus_drv.c              |  3 +++
 drivers/misc/hmc6352.c              |  2 ++
 drivers/misc/ibmvmc.c               |  2 +-
 drivers/misc/mei/bus.c              | 12 +++++------
 drivers/misc/mei/client.c           |  2 +-
 drivers/misc/mei/hbm.c              |  9 +++++---
 tools/hv/hv_kvp_daemon.c            |  2 +-
 10 files changed, 73 insertions(+), 34 deletions(-)
