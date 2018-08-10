Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EB8C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74BD223F0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74BD223F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeHJKXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:23:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:52766 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727438AbeHJKXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:23:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC4C6ACFA;
        Fri, 10 Aug 2018 07:55:07 +0000 (UTC)
Subject: Re: [RFC PATCH 00/17] btrfs zoned block device support
From:   Nikolay Borisov <nborisov@suse.com>
To:     Naohiro Aota <naota@elisp.net>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>
References: <20180809180450.5091-1-naota@elisp.net>
 <bfbb2001-adbd-64ac-1f46-6b19c01eea9c@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cc3b336f-912e-f98d-8c79-ad85af6330b4@suse.com>
Date:   Fri, 10 Aug 2018 10:55:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bfbb2001-adbd-64ac-1f46-6b19c01eea9c@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.08.2018 10:53, Nikolay Borisov wrote:
> 
> 
> On  9.08.2018 21:04, Naohiro Aota wrote:
>> This series adds zoned block device support to btrfs.
>>
>> A zoned block device consists of a number of zones. Zones are either
>> conventional and accepting random writes or sequential and requiring that
>> writes be issued in LBA order from each zone write pointer position. This
>> patch series ensures that the sequential write constraint of sequential
>> zones is respected while fundamentally not changing BtrFS block and I/O
>> management for block stored in conventional zones.
>>
>> To achieve this, the default dev extent size of btrfs is changed on zoned
>> block devices so that dev extents are always aligned to a zone. Allocation
>> of blocks within a block group is changed so that the allocation is always
>> sequential from the beginning of the block groups. To do so, an allocation
>> pointer is added to block groups and used as the allocation hint.  The
>> allocation changes also ensures that block freed below the allocation
>> pointer are ignored, resulting in sequential block allocation regardless of
>> the block group usage.
>>
>> While the introduction of the allocation pointer ensure that blocks will be
>> allocated sequentially, I/Os to write out newly allocated blocks may be
>> issued out of order, causing errors when writing to sequential zones. This
>> problem s solved by introducing a submit_buffer() function and changes to
>> the internal I/O scheduler to ensure in-order issuing of write I/Os for
>> each chunk and corresponding to the block allocation order in the chunk.
>>
>> The zones of a chunk are reset to allow reusing of the zone only when the
>> block group is being freed, that is, when all the extents of the block group
>> are unused.
>>
>> For btrfs volumes composed of multiple zoned disks, restrictions are added
>> to ensure that all disks have the same zone size. This matches the existing
>> constraint that all dev extents in a chunk must have the same size.
>>
>> It requires zoned block devices to test the patchset. Even if you don't
>> have zone devices, you can use tcmu-runner [1] to emulate zoned block
>> devices. It can export emulated zoned block devices via iSCSI. Please see
>> the README.md of tcmu-runner [2] for howtos to generate a zoned block
>> device on tcmu-runner.
>>
>> [1] https://github.com/open-iscsi/tcmu-runner
>> [2] https://github.com/open-iscsi/tcmu-runner/blob/master/README.md
>>
>> Patch 1 introduces the HMZONED incompatible feature flag to indicate that
>> the btrfs volume was formatted for use on zoned block devices.
>>
>> Patches 2 and 3 implement functions to gather information on the zones of
>> the device (zones type and write pointer position).
>>
>> Patch 4 restrict the possible locations of super blocks to conventional
>> zones to preserve the existing update in-place mechanism for the super
>> blocks.
>>
>> Patches 5 to 7 disable features which are not compatible with the sequential
>> write constraints of zoned block devices. This includes fallocate and
>> direct I/O support. Device replace is also disabled for now.
>>
>> Patches 8 and 9 tweak the extent buffer allocation for HMZONED mode to
>> implement sequential block allocation in block groups and chunks.
>>
>> Patches 10 to 12 implement the new submit buffer I/O path to ensure sequential
>> write I/O delivery to the device zones.
>>
>> Patches 13 to 16 modify several parts of btrfs to handle free blocks
>> without breaking the sequential block allocation and sequential write order
>> as well as zone reset for unused chunks.
>>
>> Finally, patch 17 adds the HMZONED feature to the list of supported
>> features.
>>
>> Naohiro Aota (17):
>>   btrfs: introduce HMZONED feature flag
>>   btrfs: Get zone information of zoned block devices
>>   btrfs: Check and enable HMZONED mode
>>   btrfs: limit super block locations in HMZONED mode
>>   btrfs: disable fallocate in HMZONED mode
>>   btrfs: disable direct IO in HMZONED mode
>>   btrfs: disable device replace in HMZONED mode
>>   btrfs: align extent allocation to zone boundary
>>   btrfs: do sequential allocation on HMZONED drives
>>   btrfs: split btrfs_map_bio()
>>   btrfs: introduce submit buffer
>>   btrfs: expire submit buffer on timeout
>>   btrfs: avoid sync IO prioritization on checksum in HMZONED mode
>>   btrfs: redirty released extent buffers in sequential BGs
>>   btrfs: reset zones of unused block groups
>>   btrfs: wait existing extents before truncating
>>   btrfs: enable to mount HMZONED incompat flag
>>
>>  fs/btrfs/async-thread.c     |   1 +
>>  fs/btrfs/async-thread.h     |   1 +
>>  fs/btrfs/ctree.h            |  36 ++-
>>  fs/btrfs/dev-replace.c      |  10 +
>>  fs/btrfs/disk-io.c          |  48 +++-
>>  fs/btrfs/extent-tree.c      | 281 +++++++++++++++++-
>>  fs/btrfs/extent_io.c        |   1 +
>>  fs/btrfs/extent_io.h        |   1 +
>>  fs/btrfs/file.c             |   4 +
>>  fs/btrfs/free-space-cache.c |  36 +++
>>  fs/btrfs/free-space-cache.h |  10 +
>>  fs/btrfs/inode.c            |  14 +
>>  fs/btrfs/super.c            |  32 ++-
>>  fs/btrfs/sysfs.c            |   2 +
>>  fs/btrfs/transaction.c      |  32 +++
>>  fs/btrfs/transaction.h      |   3 +
>>  fs/btrfs/volumes.c          | 551 ++++++++++++++++++++++++++++++++++--
>>  fs/btrfs/volumes.h          |  37 +++
>>  include/uapi/linux/btrfs.h  |   1 +
>>  19 files changed, 1061 insertions(+), 40 deletions(-)
>>
> 
> There are multiple places where you do naked shifts by
> ilog2(sectorsize). There is a perfectly well named define: SECTOR_SHIFT
> which a lot more informative for someone who doesn't necessarily have
> experience with linux storage/fs layers. Please fix such occurrences of
> magic values shifting.
> 

And Hannes just reminded me that this lannded in commit :
233bde21aa43 ("block: Move SECTOR_SIZE and SECTOR_SHIFT definitions into
<linux/blkdev.h>")

This March so it might fairly recent depending on the tree you've based
your work on.



