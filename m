Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622CEECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2412F20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNDHOsL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2412F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbeKACne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:43:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45646 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729966AbeKACnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:43:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id n5-v6so17422587wrw.12;
        Wed, 31 Oct 2018 10:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FxDe//++3rYHQqoWCSTCBm2Wxv3TGPHy+es+c9Mz66k=;
        b=YNDHOsL7eMiu/ml+/4CN8ssUudhL15kDWWJxRtXaAB8EGk9NtUEc3HWfzLetigA+M1
         LdvobWUDXUhCVW1q1DhAdGBJyZwxZABFmrAvGX07oNCn240/9A52pSsdFk5CyX+062KP
         Is4NNS6ngEdx19OH+V7ScSJRDzJZhnCIMmFd4C1oNqBuqNx2X6E0go8jKgxW3F/sQW2+
         S4J4jY2OayQ5vXu+u+rEKQYTc4+dIcxsqsitSezioQwF8P6xxkkvVKHYAo2OIZVGbykE
         kMqf4cRXt6UmyCLDztE5YRckffLYLAj2GVZzRsjKlFOMnqjPa2CVUVxfWHfgl9DusnIz
         bIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FxDe//++3rYHQqoWCSTCBm2Wxv3TGPHy+es+c9Mz66k=;
        b=pKXGrxS3PsdyY6cK6eSxe4358v0dPkQW2InWvuWDPvpuYEHv0Bzj7bwK7QdQRqWIGx
         COpDwz2F7hmnHsMgrHPYQIj7oBWRQqaqRuSn2VqIp9zCnNFlgrFVOiHrVaPpxDGgTDkf
         RLSdBC95vLaAPfxkxdnQPZZVpQcJkBwofKe5zcbNLkdgQVFPgkeWXjFjKKShB2Kp3jwi
         yH4PSF4lYGe2vCyT+15nbxARV1peBxUoEbXi296Lz/EmKYZpL9Dhb+MzykvcbhBTpIqS
         kAUYSX9WOQ1XnsBByOu9GQp0Re7GC1lrMO4f1ojhnqVs7cG3NfC6YaWZmuqt2maJHBVd
         FgVQ==
X-Gm-Message-State: AGRZ1gIi+If8XRDVaMa0yDaDq1VvmToBbMIKVgH6L3nHldaPEvzbU0ER
        b1gkJpkrwgiP9MV0hENHF23uIh3q
X-Google-Smtp-Source: AJdET5eEGOCbmm9/RVCKbgn4uTzn16VHQ21zmgSmK13divFy8TURiyp6H0cnPWE/sM69uoIaZDRPtg==
X-Received: by 2002:adf:fc8b:: with SMTP id g11-v6mr3604254wrr.78.1541007871571;
        Wed, 31 Oct 2018 10:44:31 -0700 (PDT)
Received: from orange.redhat.com ([213.175.37.12])
        by smtp.gmail.com with ESMTPSA id j72-v6sm16286281wrj.7.2018.10.31.10.44.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 10:44:30 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph updates for 4.20-rc1
Date:   Wed, 31 Oct 2018 18:44:25 +0100
Message-Id: <20181031174425.27372-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d:

  Linux 4.19 (2018-10-22 07:37:37 +0100)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.20-rc1

for you to fetch changes up to ea4cdc548e5e74a529cdd1aea885d74b4aa8f1b3:

  ceph: new mount option to disable usage of copy-from op (2018-10-22 10:28:24 +0200)

----------------------------------------------------------------
The highlights are:

- a series that fixes some old memory allocation issues in libceph
  (myself).  We no longer allocate memory in places where allocation
  failures cannot be handled and BUG when the allocation fails.

- support for copy_file_range() syscall (Luis Henriques).  If size and
  alignment conditions are met, it leverages RADOS copy-from operation.
  Otherwise, a local copy is performed.

- a patch that reduces memory requirement of ceph_sync_read() from the
  size of the entire read to the size of one object (Zheng Yan).

- fallocate() syscall is now restricted to FALLOC_FL_PUNCH_HOLE (Luis
  Henriques)

----------------------------------------------------------------
Chengguang Xu (3):
      ceph: reset cap hold timeout only for requeued inode
      rbd: add __init/__exit annotations
      ceph: check snap first in ceph_set_acl()

Ilya Dryomov (12):
      libceph: bump CEPH_MSG_MAX_DATA_LEN
      libceph: osd_req_op_cls_init() doesn't need to take opcode
      libceph: introduce ceph_pagelist_alloc()
      libceph: don't consume a ref on pagelist in ceph_msg_data_add_pagelist()
      libceph: no need to call osd_req_opcode_valid() in osd_req_encode_op()
      ceph: num_ops is off by one in ceph_aio_retry_work()
      libceph: enable fallback to ceph_msg_new() in ceph_msgpool_get()
      libceph: assign cookies in linger_submit()
      libceph: introduce alloc_watch_request()
      libceph, rbd, ceph: move ceph_osdc_alloc_messages() calls
      libceph: preallocate message data items
      libceph: check reply num_data_items in setup_request_data()

Luis Henriques (5):
      ceph: only allow punch hole mode in fallocate
      ceph: add non-blocking parameter to ceph_try_get_caps()
      libceph: support the RADOS copy-from operation
      ceph: support copy_file_range file operation
      ceph: new mount option to disable usage of copy-from op

Xuehan Xu (1):
      ceph: set timeout conditionally in __cap_delay_requeue

Yan, Zheng (4):
      Revert "ceph: fix dentry leak in splice_dentry()"
      ceph: fix dentry leak in ceph_readdir_prepopulate
      ceph: check if LOOKUPNAME request was aborted when filling trace
      ceph: refactor ceph_sync_read()

 Documentation/filesystems/ceph.txt |   5 +
 drivers/block/rbd.c                |  28 +-
 fs/ceph/acl.c                      |  13 +-
 fs/ceph/addr.c                     |   2 +-
 fs/ceph/caps.c                     |  21 +-
 fs/ceph/file.c                     | 573 +++++++++++++++++++++++++++----------
 fs/ceph/inode.c                    |  13 +-
 fs/ceph/mds_client.c               |   9 +-
 fs/ceph/super.c                    |  13 +
 fs/ceph/super.h                    |   3 +-
 fs/ceph/xattr.c                    |   3 +-
 include/linux/ceph/libceph.h       |   8 +-
 include/linux/ceph/messenger.h     |  24 +-
 include/linux/ceph/msgpool.h       |  11 +-
 include/linux/ceph/osd_client.h    |  22 +-
 include/linux/ceph/pagelist.h      |  11 +-
 include/linux/ceph/rados.h         |  28 ++
 net/ceph/messenger.c               | 107 +++----
 net/ceph/msgpool.c                 |  27 +-
 net/ceph/osd_client.c              | 363 +++++++++++++++++------
 net/ceph/pagelist.c                |  20 ++
 21 files changed, 900 insertions(+), 404 deletions(-)
