Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1631012-1527152560-2-17917246757452705045
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527152559; b=KNjekFc2cA3mWOQETWWjZDtylXiT0bBuO9dO+KGB85wsg5ZecJ
    5gcPpZ6yvSPJdxFAsekeUuiqCT37XXe0waI/N3r/zvtAecyUXi/vTSpd8ckcRX02
    eXXejYG7TsIwB3gZdwDPE9/DdjOTLPeaLbDkAMyr03qE2YiZrHx0XkhdKSZf1s42
    KsQbSTPxveT5mn3TJ5lXTdPdw1OSwGtD4HGLhLKIyfe00reUqaqq21e8Y1LbwybD
    NfF1mE+Jojah+vPbE2ceSMm8mTTEoq4eqoVyCvyIzmIoUEU5I6qDsVWCteaSocIw
    m+ER08N/QfKmeGYo42+8lREjuoZIWbXWiwdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1527152559; bh=67vyWhaZWVaygLuqfdo3zT/JqISyVw
    +OArBrmDxMxk8=; b=bvFOFOl9JJu2LqI7HQvBnEqEt51LtZUWmeaUOdDgUcKiT3
    dKlYtC4nbGyk8Uvc+bh1U1WMmgvgC3jVKXxhjKl2Abr99jC8Q/kRj67lp1zP2Fju
    Zd9vniMqbuVepGDIdTp936Kxb4IHsJMmrFp7w363FLUSeEPcly12k7pi88Zo3yXx
    VjoE8ow91TY3XU3T72PhfLjCVLU4xYClQY6XyL+yIaHtNQw5HD1Udgg5hpYZwRul
    5CyJGLTgPcsu9ZuMv3LRXOvSg79x+toRyI3aDjNCJ3O4qvy8g7md4GPh7rkKWCkU
    L4tGwZhXOL//pOfAC1vVCFzI1qhEuYokFTdXL2Fg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPbtJFp1ExM5Ac7SVUcmnSWUvOXG0FDgoXHxsKF/dq4R6JMucbl+voB+FvaEFMooFMWpx1hnKUVZ7V8s2TSRFuw0AqqCB2Klk0h2LWbZENpq57Ixt4gI
    zkgzf8kT4AjlDAuRI5e1foJ43tQX44hB0kmX69kkFyPcRp53xtT9Bm0Y1WcIq/igwkKav1mhki38kWRvugU1awtEcS2sY3wFK+Iyy2mslL0k5T+epAYWtKt0
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=NEAV23lmAAAA:8
    a=gu6fZOg2AAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=drOt6m5kAAAA:8
    a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=37rDS-QxAAAA:8 a=yPCof4ZbAAAA:8
    a=XaidAQxGKJ7caUU2OUMA:9 a=IpYK-eP6kDbDj0c5:21 a=Sl5uYa67oUzp736l:21
    a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
    a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22 a=RMMjzBEyIzXRtoq5n5K6:22
    a=k1Nq6YrhK2t884LQW06G:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965724AbeEXJCi (ORCPT <rfc822;linux@kroah.com>);
        Thu, 24 May 2018 05:02:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965714AbeEXJCc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 May 2018 05:02:32 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>
Subject: [PATCH V5 00/33] block: support multipage bvec
Date: Thu, 24 May 2018 17:01:05 +0800
Message-Id: <20180524090139.2150-1-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

This patchset brings multipage bvec into block layer:

1) what is multipage bvec?

Multipage bvecs means that one 'struct bio_bvec' can hold multiple pages
which are physically contiguous instead of one single page used in linux
kernel for long time.

2) why is multipage bvec introduced?

Kent proposed the idea[1] first. 

As system's RAM becomes much bigger than before, and huge page, transparent
huge page and memory compaction are widely used, it is a bit easy now
to see physically contiguous pages from fs in I/O. On the other hand, from
block layer's view, it isn't necessary to store intermediate pages into bvec,
and it is enough to just store the physicallly contiguous 'segment' in each
io vector.

Also huge pages are being brought to filesystem and swap [2][6], we can
do IO on a hugepage each time[3], which requires that one bio can transfer
at least one huge page one time. Turns out it isn't flexiable to change
BIO_MAX_PAGES simply[3][5]. Multipage bvec can fit in this case very well.
As we saw, if CONFIG_THP_SWAP is enabled, BIO_MAX_PAGES can be configured
as much bigger, such as 512, which requires at least two 4K pages for holding
the bvec table.

With multipage bvec:

- Inside block layer, both bio splitting and sg map can become more
efficient than before by just traversing the physically contiguous
'segment' instead of each page.

- segment handling in block layer can be improved much in future since it
should be quite easy to convert multipage bvec into segment easily. For
example, we might just store segment in each bvec directly in future.

- bio size can be increased and it should improve some high-bandwidth IO
case in theory[4].

- there is opportunity in future to improve memory footprint of bvecs. 

3) how is multipage bvec implemented in this patchset?

The 1st 3 patches are prepare patches for multipage bvec, and one big
change is to rename bio_for_each_segment*() as bio_for_each_page*().

The patches of 4~31 implement multipage bvec in block layer:

	- put all tricks into bvec/bio/rq iterators, and as far as
	drivers and fs use these standard iterators, they are happy
	with multipage bvec

	- use multipage bvec to split bio and map sg

	- introduce bio_for_each_segment*() for iterating bio segment by
	  segment

	- make current bio_for_each_page*() to itereate page by page and
	make sure current uses won't be broken

The patch 32 redefines BIO_MAX_PAGES as 256.

The patch 33 documents usages of bio iterator helpers.

These patches can be found in the following git tree:

	gitweb: https://github.com/ming1/linux/commits/v4.17-rc-blk-next-mp_bvec_v5
	git:  https://github.com/ming1/linux.git  #v4.17-rc-blk-next-mp_bvec_v5

Lots of test(blktest, xfstests, ltp io, ...) have been run with this patchset,
and not see regression.

Thanks Christoph for reviewing the early version and providing very good
suggestions, such as: introduce bio_init_with_vec_table(), remove another
unnecessary helpers for cleanup and so on.

Any comments are welcome!

V5:
	- remove some of prepare patches, which have been merged already
	- add bio_clone_seg_bioset() to fix DM's bio clone, which
	is introduced by 18a25da84354c6b (dm: ensure bio submission follows
	a depth-first tree walk)
	- rebase on the latest block for-v4.18

V4:
	- rename bio_for_each_segment*() as bio_for_each_page*(), rename
	bio_segments() as bio_pages(), rename rq_for_each_segment() as
	rq_for_each_pages(), because these helpers never return real
	segment, and they always return single page bvec
	
	- introducing segment_for_each_page_all()

	- introduce new bio_for_each_segment*()/rq_for_each_segment()/bio_segments()
	for returning real multipage segment

	- rewrite segment_last_page()

	- rename bvec iterator helper as suggested by Christoph

	- replace comment with applying bio helpers as suggested by Christoph

	- document usage of bio iterator helpers

	- redefine BIO_MAX_PAGES as 256 to make the biggest bvec table
	accommodated in 4K page

	- move bio_alloc_pages() into bcache as suggested by Christoph

V3:
	- rebase on v4.13-rc3 with for-next of block tree
	- run more xfstests: xfs/ext4 over NVMe, Sata, DM(linear),
	MD(raid1), and not see regressions triggered
	- add Reviewed-by on some btrfs patches
	- remove two MD patches because both are merged to linus tree
	  already

V2:
	- bvec table direct access in raid has been cleaned, so NO_MP
	flag is dropped
	- rebase on recent Neil Brown's change on bio and bounce code
	- reorganize the patchset

V1:
	- against v4.10-rc1 and some cleanup in V0 are in -linus already
	- handle queue_virt_boundary() in mp bvec change and make NVMe happy
	- further BTRFS cleanup
	- remove QUEUE_FLAG_SPLIT_MP
	- rename for two new helpers of bio_for_each_segment_all()
	- fix bounce convertion
	- address comments in V0

[1], http://marc.info/?l=linux-kernel&m=141680246629547&w=2
[2], https://patchwork.kernel.org/patch/9451523/
[3], http://marc.info/?t=147735447100001&r=1&w=2
[4], http://marc.info/?l=linux-mm&m=147745525801433&w=2
[5], http://marc.info/?t=149569484500007&r=1&w=2
[6], http://marc.info/?t=149820215300004&r=1&w=2

Ming Lei (33):
  block: rename bio_for_each_segment* with bio_for_each_page*
  block: rename rq_for_each_segment as rq_for_each_page
  block: rename bio_segments() with bio_pages()
  block: introduce multipage page bvec helpers
  block: introduce bio_for_each_segment()
  block: use bio_for_each_segment() to compute segments count
  block: use bio_for_each_segment() to map sg
  block: introduce segment_last_page()
  fs/buffer.c: use bvec iterator to truncate the bio
  btrfs: use segment_last_page to get bio's last page
  block: implement bio_pages_all() via bio_for_each_page_all()
  block: introduce bio_segments()
  block: introduce rq_for_each_segment()
  block: loop: pass segments to iov_iter
  block: introduce bio_clone_seg_bioset()
  dm: clone bio via bio_clone_seg_bioset
  block: bio: introduce bio_for_each_page_all2 and
    bio_for_each_segment_all
  block: deal with dirtying pages for multipage bvec
  block: convert to bio_for_each_page_all2()
  md/dm/bcache: conver to bio_for_each_page_all2 and
    bio_for_each_segment
  fs: conver to bio_for_each_page_all2
  btrfs: conver to bio_for_each_page_all2
  ext4: conver to bio_for_each_page_all2
  f2fs: conver to bio_for_each_page_all2
  xfs: conver to bio_for_each_page_all2
  exofs: conver to bio_for_each_page_all2
  gfs2: conver to bio_for_each_page_all2
  block: kill bio_for_each_page_all()
  block: rename bio_for_each_page_all2 as bio_for_each_page_all
  block: enable multipage bvecs
  block: bio: pass segments to bio if bio_add_page() is bypassed
  block: always define BIO_MAX_PAGES as 256
  block: document usage of bio iterator helpers

 Documentation/block/biodoc.txt      |   6 +-
 Documentation/block/biovecs.txt     |  36 ++++++-
 arch/m68k/emu/nfblock.c             |   2 +-
 arch/xtensa/platforms/iss/simdisk.c |   2 +-
 block/bio-integrity.c               |   2 +-
 block/bio.c                         | 186 +++++++++++++++++++++++++++++-------
 block/blk-core.c                    |   2 +-
 block/blk-merge.c                   | 158 +++++++++++++++++++++++-------
 block/blk-zoned.c                   |   5 +-
 block/bounce.c                      |  10 +-
 drivers/block/aoe/aoecmd.c          |   4 +-
 drivers/block/brd.c                 |   2 +-
 drivers/block/drbd/drbd_main.c      |   4 +-
 drivers/block/drbd/drbd_receiver.c  |   2 +-
 drivers/block/drbd/drbd_worker.c    |   2 +-
 drivers/block/floppy.c              |   4 +-
 drivers/block/loop.c                |  10 +-
 drivers/block/nbd.c                 |   4 +-
 drivers/block/null_blk.c            |   4 +-
 drivers/block/ps3disk.c             |   4 +-
 drivers/block/ps3vram.c             |   2 +-
 drivers/block/rsxx/dma.c            |   2 +-
 drivers/block/zram/zram_drv.c       |   2 +-
 drivers/md/bcache/btree.c           |   3 +-
 drivers/md/bcache/debug.c           |   2 +-
 drivers/md/bcache/request.c         |   2 +-
 drivers/md/dm-crypt.c               |   3 +-
 drivers/md/dm-integrity.c           |   4 +-
 drivers/md/dm-log-writes.c          |   4 +-
 drivers/md/dm.c                     |   6 +-
 drivers/md/raid1.c                  |   3 +-
 drivers/md/raid5.c                  |   2 +-
 drivers/nvdimm/blk.c                |   2 +-
 drivers/nvdimm/btt.c                |   2 +-
 drivers/nvdimm/pmem.c               |   2 +-
 drivers/s390/block/dasd_diag.c      |   4 +-
 drivers/s390/block/dasd_eckd.c      |  16 ++--
 drivers/s390/block/dasd_fba.c       |   6 +-
 drivers/s390/block/dcssblk.c        |   2 +-
 drivers/s390/block/scm_blk.c        |   2 +-
 drivers/s390/block/xpram.c          |   2 +-
 drivers/target/target_core_pscsi.c  |   2 +-
 fs/block_dev.c                      |   6 +-
 fs/btrfs/check-integrity.c          |   6 +-
 fs/btrfs/compression.c              |   8 +-
 fs/btrfs/disk-io.c                  |   3 +-
 fs/btrfs/extent_io.c                |  14 ++-
 fs/btrfs/file-item.c                |   4 +-
 fs/btrfs/inode.c                    |  12 ++-
 fs/btrfs/raid56.c                   |   5 +-
 fs/buffer.c                         |   5 +-
 fs/crypto/bio.c                     |   3 +-
 fs/direct-io.c                      |   4 +-
 fs/exofs/ore.c                      |   3 +-
 fs/exofs/ore_raid.c                 |   3 +-
 fs/ext4/page-io.c                   |   3 +-
 fs/ext4/readpage.c                  |   3 +-
 fs/f2fs/data.c                      |   9 +-
 fs/gfs2/lops.c                      |   6 +-
 fs/gfs2/meta_io.c                   |   3 +-
 fs/iomap.c                          |   3 +-
 fs/mpage.c                          |   3 +-
 fs/xfs/xfs_aops.c                   |   5 +-
 include/linux/bio.h                 |  98 +++++++++++++++----
 include/linux/blkdev.h              |   6 +-
 include/linux/bvec.h                | 134 ++++++++++++++++++++++++--
 include/linux/ceph/messenger.h      |   2 +-
 67 files changed, 671 insertions(+), 204 deletions(-)

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
cc:	Huang Ying <ying.huang@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: "Darrick J . Wong" <darrick.wong@oracle.com>
Cc: Coly Li <colyli@suse.de>
Cc: Filipe Manana <fdmanana@gmail.com>

-- 
2.9.5
