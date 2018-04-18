Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeDROwu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:52:50 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36821 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeDROws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:52:48 -0400
X-Google-Smtp-Source: AIpwx48SnFmfkiKVOREG528k9KU4bTOBiA8lD1tiUpdgtnmU0rqSn7gwGmwMt5Lxf/2Kg5FN0D76qw==
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 4.17-rc2
Date: Wed, 18 Apr 2018 16:52:20 +0200
Message-Id: <1524063140-28502-1-git-send-email-idryomov@gmail.com>
X-Mailer: git-send-email 2.4.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.17-rc2

for you to fetch changes up to d93605407af34eb0b7eb8aff6b1eae2cde3cdd22:

  rbd: notrim map option (2018-04-16 09:38:40 +0200)

----------------------------------------------------------------
A couple of follow-up patches for -rc1 changes in rbd, support for
a timeout on waiting for the acquisition of exclusive lock and a fix
for uninitialized memory access in CephFS, marked for stable.

----------------------------------------------------------------
Arnd Bergmann (1):
      rbd: avoid Wreturn-type warnings

Dongsheng Yang (1):
      rbd: support timeout in rbd_wait_state_locked()

Ilya Dryomov (3):
      rbd: refactor rbd_wait_state_locked()
      rbd: adjust queue limits for "fancy" striping
      rbd: notrim map option

Yan, Zheng (1):
      ceph: always update atime/mtime/ctime for new inode

 drivers/block/rbd.c | 101 +++++++++++++++++++++++++++++++++++-----------------
 fs/ceph/inode.c     |  10 ++++--
 2 files changed, 76 insertions(+), 35 deletions(-)
