Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C42C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D44B2238B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVddHVwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D44B2238B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeHIUbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:31:47 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:34485 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeHIUbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:31:47 -0400
Received: by mail-pf1-f170.google.com with SMTP id k19-v6so3222707pfi.1;
        Thu, 09 Aug 2018 11:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=PZqjhRp+9V5e9tCiCT1sTHPS4/xjvxqEFLN9Deix5kA=;
        b=OVddHVwEofK2qasNhPMycEfYC0bCCz2W9+9YmgPLFpv04dq5IOE1V8O0qElXuFp8uA
         Vhxu+4O+KLfMPZdzGuUlQ+sgWwIx16x03Z4a26FoTsdSsdvfwLIMFm4LKCHuAwu5pC/C
         2AiTgEzjEDggoxe6ufH83htWfohFnMGhzLIoMHvKMYKCfD121juAjb2jLhU7RfEwR7dj
         Fwpb40/1nVFgFmgmwEyofHKad3LgWEw+qaNn1mbj+RfBXLEbOpIUIEQ9YR7XKa1P0FTt
         6bB2WTJhT7ahjKl1+c7wZzEPPZTWMh6BKmKPOmYkYSZl1O/8mRKfQLKYpT/dR+Mg0Q0c
         4F+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=PZqjhRp+9V5e9tCiCT1sTHPS4/xjvxqEFLN9Deix5kA=;
        b=h7h3BjEatBWkT37N6zlwHA1HM6D6YVxAKbDCLjVxoUyjm20DvpFEFMLd5ANhEFkcBi
         gT568h8/7fW7yTDfDDRqHwCCtLaCfvNb9G96bnJBYJvs3cS9GRjlC8TgmWtPdjmse5SP
         eCdOQfj2EzlBFcXUeSiCjJyBQHM4uGRYgUohVzghz6w5yA4nUOndUCI7W0WRgxkgF2y2
         uT/E3018xmygN/OwO5f9/dUFUAT5WWcA5l7UBC2oGXUmLi15BSq3juQBLxNwnDaLf+NT
         NHvmdXf5L22CjDfzY0g81fSIrWF/N9MnHv/qlHuk1qAvrRgp384K/tw9i4VzR3IYUQF9
         5F5g==
X-Gm-Message-State: AOUpUlHC9u2iAw/4BqZXiPAAcplPAl1QxSltU/qomtwU3OuP48iTCYaf
        zdOQqppbhkY2FJ/J8aSTczJP20jAt50=
X-Google-Smtp-Source: AA+uWPy1+cRL2PkFQY7L48DefDOVPQ2mwjdsnlntf+zByw5O37cB6ze1SbODmD16jtGzejz9XgGnxw==
X-Received: by 2002:a62:2459:: with SMTP id r86-v6mr3428703pfj.31.1533837947760;
        Thu, 09 Aug 2018 11:05:47 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id g28-v6sm14440260pfe.41.2018.08.09.11.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:05:47 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 00/17] btrfs zoned block device support
Date:   Fri, 10 Aug 2018 03:04:33 +0900
Message-Id: <20180809180450.5091-1-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds zoned block device support to btrfs.

A zoned block device consists of a number of zones. Zones are either
conventional and accepting random writes or sequential and requiring that
writes be issued in LBA order from each zone write pointer position. This
patch series ensures that the sequential write constraint of sequential
zones is respected while fundamentally not changing BtrFS block and I/O
management for block stored in conventional zones.

To achieve this, the default dev extent size of btrfs is changed on zoned
block devices so that dev extents are always aligned to a zone. Allocation
of blocks within a block group is changed so that the allocation is always
sequential from the beginning of the block groups. To do so, an allocation
pointer is added to block groups and used as the allocation hint.  The
allocation changes also ensures that block freed below the allocation
pointer are ignored, resulting in sequential block allocation regardless of
the block group usage.

While the introduction of the allocation pointer ensure that blocks will be
allocated sequentially, I/Os to write out newly allocated blocks may be
issued out of order, causing errors when writing to sequential zones. This
problem s solved by introducing a submit_buffer() function and changes to
the internal I/O scheduler to ensure in-order issuing of write I/Os for
each chunk and corresponding to the block allocation order in the chunk.

The zones of a chunk are reset to allow reusing of the zone only when the
block group is being freed, that is, when all the extents of the block group
are unused.

For btrfs volumes composed of multiple zoned disks, restrictions are added
to ensure that all disks have the same zone size. This matches the existing
constraint that all dev extents in a chunk must have the same size.

It requires zoned block devices to test the patchset. Even if you don't
have zone devices, you can use tcmu-runner [1] to emulate zoned block
devices. It can export emulated zoned block devices via iSCSI. Please see
the README.md of tcmu-runner [2] for howtos to generate a zoned block
device on tcmu-runner.

[1] https://github.com/open-iscsi/tcmu-runner
[2] https://github.com/open-iscsi/tcmu-runner/blob/master/README.md

Patch 1 introduces the HMZONED incompatible feature flag to indicate that
the btrfs volume was formatted for use on zoned block devices.

Patches 2 and 3 implement functions to gather information on the zones of
the device (zones type and write pointer position).

Patch 4 restrict the possible locations of super blocks to conventional
zones to preserve the existing update in-place mechanism for the super
blocks.

Patches 5 to 7 disable features which are not compatible with the sequential
write constraints of zoned block devices. This includes fallocate and
direct I/O support. Device replace is also disabled for now.

Patches 8 and 9 tweak the extent buffer allocation for HMZONED mode to
implement sequential block allocation in block groups and chunks.

Patches 10 to 12 implement the new submit buffer I/O path to ensure sequential
write I/O delivery to the device zones.

Patches 13 to 16 modify several parts of btrfs to handle free blocks
without breaking the sequential block allocation and sequential write order
as well as zone reset for unused chunks.

Finally, patch 17 adds the HMZONED feature to the list of supported
features.

Naohiro Aota (17):
  btrfs: introduce HMZONED feature flag
  btrfs: Get zone information of zoned block devices
  btrfs: Check and enable HMZONED mode
  btrfs: limit super block locations in HMZONED mode
  btrfs: disable fallocate in HMZONED mode
  btrfs: disable direct IO in HMZONED mode
  btrfs: disable device replace in HMZONED mode
  btrfs: align extent allocation to zone boundary
  btrfs: do sequential allocation on HMZONED drives
  btrfs: split btrfs_map_bio()
  btrfs: introduce submit buffer
  btrfs: expire submit buffer on timeout
  btrfs: avoid sync IO prioritization on checksum in HMZONED mode
  btrfs: redirty released extent buffers in sequential BGs
  btrfs: reset zones of unused block groups
  btrfs: wait existing extents before truncating
  btrfs: enable to mount HMZONED incompat flag

 fs/btrfs/async-thread.c     |   1 +
 fs/btrfs/async-thread.h     |   1 +
 fs/btrfs/ctree.h            |  36 ++-
 fs/btrfs/dev-replace.c      |  10 +
 fs/btrfs/disk-io.c          |  48 +++-
 fs/btrfs/extent-tree.c      | 281 +++++++++++++++++-
 fs/btrfs/extent_io.c        |   1 +
 fs/btrfs/extent_io.h        |   1 +
 fs/btrfs/file.c             |   4 +
 fs/btrfs/free-space-cache.c |  36 +++
 fs/btrfs/free-space-cache.h |  10 +
 fs/btrfs/inode.c            |  14 +
 fs/btrfs/super.c            |  32 ++-
 fs/btrfs/sysfs.c            |   2 +
 fs/btrfs/transaction.c      |  32 +++
 fs/btrfs/transaction.h      |   3 +
 fs/btrfs/volumes.c          | 551 ++++++++++++++++++++++++++++++++++--
 fs/btrfs/volumes.h          |  37 +++
 include/uapi/linux/btrfs.h  |   1 +
 19 files changed, 1061 insertions(+), 40 deletions(-)

-- 
2.18.0

