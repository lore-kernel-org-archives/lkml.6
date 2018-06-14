Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 18EB0C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11CE208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcU83FRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11CE208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935877AbeFNK61 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:58:27 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46868 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754982AbeFNK6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:58:14 -0400
Received: by mail-qk0-f195.google.com with SMTP id k86-v6so3301773qkh.13;
        Thu, 14 Jun 2018 03:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7Koh3bFldb5dykeSZoXSd3huJwgJvWIZZP2T5hs2bwE=;
        b=UcU83FREwW4Qg7hc6f23h9z0ZBWi/Fq19mCJOhJfUl9V7xEKi2uNugtYPOinmR9GAv
         NPryRbYc4lcBOR2u2vlUTHw1Xh2QKgh5yVT+JcmoBkLDxgqsPJLK+RVSVty69dYEqCX6
         loVmVVe4AOaE0IExTzdp4rT+X07pYj3Gsh4bqkFrI/3HcohH+GBx91mVTp/jNgLuZ7TZ
         zOimspeeB6FSlCFWr9dVYyL+IAMjoaVCyQjiD7XTUKvYD8WzlsV5AlzaEU1mjxj9hHN0
         nhhtUHGB0JZIA0gaJ2wOlG8OunzaAT7yvXHsYTLVu9aA42NMnS8hC99n/EKZNDMW7Kp0
         KkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7Koh3bFldb5dykeSZoXSd3huJwgJvWIZZP2T5hs2bwE=;
        b=rknahW/XaM9RryYIIm90WSfZJKlyqK+WT+EkDLveoTtyK5H2zDQJAbSKyb9iXSxxzC
         KtRqWObq0sOwmpb4fwVkCWnvPiNYwr2kFpuASk4G4bmMOF+NQ+JEw6Po8jB4lqFjqpHa
         kKzYNY4GxHe2Ukda5gFNx7DpSMLyETQxZeXFcISV1tfg6U4MO2zPpzs2WiEwa+txsM5T
         8VTTw4z1newd0/lLBiWNYEGWj2BwojBq4VulgKXpl0p8MYi0yb2vAgYOZbURdOiG/JuH
         l5fCLd7b5w/qZOt771VM+W2iAjY3zW726rEm+2k0Sl0DtkzJldL7ARmw/LJltcs3R1iR
         X3XA==
X-Gm-Message-State: APt69E0rjC3KFzU7Fxlu35j+AMLCYgUQV3S4teCt3npkiN0XC3qjx19M
        iTaCvRQ76ka/t9/VOWgsdFvuXyOT
X-Google-Smtp-Source: ADUXVKL/g7jsecREmFjyLvcxyVodBzk4PV+tE1ckGXZ3pNwAlGlLgGC0xFgAuFK9pNekH4V0OkbHyw==
X-Received: by 2002:a37:7d42:: with SMTP id y63-v6mr1523328qkc.293.1528973893892;
        Thu, 14 Jun 2018 03:58:13 -0700 (PDT)
Received: from orange.localdomain. ([50.225.197.140])
        by smtp.gmail.com with ESMTPSA id g8-v6sm3066842qtp.9.2018.06.14.03.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 03:58:12 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph updates for 4.18-rc1
Date:   Thu, 14 Jun 2018 12:57:34 +0200
Message-Id: <1528973854-12563-1-git-send-email-idryomov@gmail.com>
X-Mailer: git-send-email 2.4.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 29dcea88779c856c7dc92040a0c01233263101d4:

  Linux 4.17 (2018-06-03 14:15:21 -0700)

are available in the git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.18-rc1

for you to fetch changes up to 23edca864951250af845a11da86bb3ea63522ed2:

  rbd: flush rbd_dev->watch_dwork after watch is unregistered (2018-06-04 20:46:02 +0200)

----------------------------------------------------------------
The main piece is a set of libceph changes that revamps how OSD
requests are aborted, improving CephFS ENOSPC handling and making
"umount -f" actually work (Zheng and myself).  The rest is mostly
mount option handling cleanups from Chengguang and assorted fixes
from Zheng, Luis and Dongsheng.

----------------------------------------------------------------
Chengguang Xu (5):
      libceph, rbd: add error handling for osd_req_op_cls_init()
      ceph: fix alignment of rasize
      ceph: strengthen rsize/wsize/readdir_max_bytes validation
      ceph: show ino32 if the value is different with default
      ceph: update description of some mount options

Dongsheng Yang (1):
      rbd: flush rbd_dev->watch_dwork after watch is unregistered

Ilya Dryomov (13):
      libceph: get rid of more_kvec in try_write()
      libceph: use MSG_TRUNC for discarding received bytes
      ceph: show wsize only if non-default
      libceph: introduce ceph_osdc_abort_requests()
      libceph: no need to call flush_workqueue() before destruction
      libceph: move more code into __complete_request()
      libceph: defer __complete_request() to a workqueue
      libceph: use for_each_request() in ceph_osdc_abort_on_full()
      libceph: don't warn if req->r_abort_on_full is set
      libceph: avoid a use-after-free during map check
      libceph: don't abort reads in ceph_osdc_abort_on_full()
      libceph: make abort_on_full a per-osdc setting
      libceph: allocate the locator string with GFP_NOFAIL

Luis Henriques (2):
      ceph: fix st_nlink stat for directories
      ceph: fix use-after-free in ceph_statfs()

Yan, Zheng (10):
      ceph: use bit flags to define vxattr attributes
      ceph: always get rstat from auth mds
      ceph: update i_files/i_subdirs only when Fs cap is issued
      ceph: define argument structure for handle_cap_grant
      ceph: handle the new nfiles/nsubdirs fields in cap message
      ceph: support file lock on directory
      ceph: abort osd requests on force umount
      ceph: flush pending works before shutdown super
      ceph: fix wrong check for the case of updating link count
      ceph: prevent i_version from going back

 Documentation/filesystems/ceph.txt |   8 +-
 drivers/block/rbd.c                |  11 +-
 fs/ceph/addr.c                     |   1 -
 fs/ceph/caps.c                     | 160 ++++++++++++++++-----------
 fs/ceph/dir.c                      |   2 +
 fs/ceph/file.c                     |   1 -
 fs/ceph/inode.c                    |  67 +++++++-----
 fs/ceph/super.c                    |  35 ++++--
 fs/ceph/xattr.c                    |  60 ++++++-----
 include/linux/ceph/ceph_fs.h       |   1 +
 include/linux/ceph/osd_client.h    |   8 +-
 include/linux/ceph/osdmap.h        |   8 +-
 net/ceph/messenger.c               |  31 ++----
 net/ceph/osd_client.c              | 216 ++++++++++++++++++++++---------------
 net/ceph/osdmap.c                  |  19 ++--
 15 files changed, 372 insertions(+), 256 deletions(-)
