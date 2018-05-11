Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751388AbeEKPrh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:47:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54988 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbeEKPrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:47:35 -0400
X-Google-Smtp-Source: AB8JxZrzQiUf1MXJx+R8vBkrt5ofj3QY6MriBoJ06QVPQN3e776R+Zzrkqt7IbrhJtDRHw7aspGvrA==
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 4.17-rc5
Date: Fri, 11 May 2018 17:46:47 +0200
Message-Id: <1526053607-11159-1-git-send-email-idryomov@gmail.com>
X-Mailer: git-send-email 2.4.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 75bc37fefc4471e718ba8e651aa74673d4e0a9eb:

  Linux 4.17-rc4 (2018-05-06 16:57:38 -1000)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.17-rc5

for you to fetch changes up to fc218544fbc800d1c91348ec834cacfb257348f7:

  ceph: fix iov_iter issues in ceph_direct_read_write() (2018-05-10 10:15:12 +0200)

----------------------------------------------------------------
These patches fix two long-standing bugs in the DIO code path, one of
which is a crash trivially triggerable with splice().

----------------------------------------------------------------
Ilya Dryomov (3):
      ceph: fix rsize/wsize capping in ceph_direct_read_write()
      libceph: add osd_req_op_extent_osd_data_bvecs()
      ceph: fix iov_iter issues in ceph_direct_read_write()

 drivers/block/rbd.c             |   4 +-
 fs/ceph/file.c                  | 205 ++++++++++++++++++++++++----------------
 include/linux/ceph/osd_client.h |  12 ++-
 net/ceph/osd_client.c           |  27 +++++-
 4 files changed, 158 insertions(+), 90 deletions(-)
