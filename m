Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id aCsQCLETGlsVYwAAmS7hNA
	; Fri, 08 Jun 2018 05:27:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DED3B607E4; Fri,  8 Jun 2018 05:27:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E17BB602FC;
	Fri,  8 Jun 2018 05:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E17BB602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751535AbeFHF1r (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 01:27:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35820 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeFHF1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 01:27:46 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fR9w9-0005mZ-8j; Fri, 08 Jun 2018 05:27:45 +0000
Date: Fri, 8 Jun 2018 06:27:45 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] vfs.git - aio ioprio
Message-ID: <20180608052745.GZ30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	The rest of aio stuff for this cycle - Adam's aio ioprio series

The following changes since commit 1da92779e2e8f309d5aecbbed346e7f812b174e8:

  aio: sanitize the limit checking in io_submit(2) (2018-05-29 23:20:17 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.aio

for you to fetch changes up to 9a6d9a62e0fd4b9927c3124db0f25fc6b4fb6576:

  fs: aio ioprio use ioprio_check_cap ret val (2018-06-04 14:20:39 -0400)

----------------------------------------------------------------
Adam Manzanares (7):
      block: add ioprio_check_cap function
      fs: Convert kiocb rw_hint from enum to u16
      fs: Add aio iopriority support
      fs: blkdev set bio prio from kiocb prio
      fs: iomap dio set bio prio from kiocb prio
      fs: aio ioprio add explicit block layer dependence
      fs: aio ioprio use ioprio_check_cap ret val

 block/ioprio.c               | 22 ++++++++++++++++------
 drivers/block/loop.c         |  3 +++
 fs/aio.c                     | 18 +++++++++++++++++-
 fs/block_dev.c               |  2 ++
 fs/iomap.c                   |  1 +
 include/linux/fs.h           | 16 ++++++++++++++--
 include/linux/ioprio.h       |  9 +++++++++
 include/uapi/linux/aio_abi.h |  1 +
 8 files changed, 63 insertions(+), 9 deletions(-)
