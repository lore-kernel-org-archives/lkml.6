Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753226AbeAaV2M (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 16:28:12 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37360 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbeAaV2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 16:28:11 -0500
Date: Wed, 31 Jan 2018 21:28:10 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git pull] iov_iter: make vmci use that
Message-ID: <20180131212810.GD30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Get rid of "is it an iovec or an entire array?" flags in there -
just use iov_iter.  Simplifies the living hell out of that code...

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.vmci

for you to fetch changes up to d1038084415c413b3c11c536f28fc5571ed00153:

  vmci: the same on the send side... (2017-12-02 21:24:03 -0500)

----------------------------------------------------------------
Al Viro (4):
      vmci: fix buf_size in case of iovec-based accesses
      vmci: get rid of qp_memcpy_from_queue()
      vmci: simplify qp_dequeue_locked()
      vmci: the same on the send side...

 drivers/misc/vmw_vmci/vmci_queue_pair.c | 179 ++++++++------------------------
 1 file changed, 46 insertions(+), 133 deletions(-)
