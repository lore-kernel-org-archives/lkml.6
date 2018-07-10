Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACA8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5A820A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5A820A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389301AbeGJSee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:34:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48080 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732920AbeGJSed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:34:33 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EB614EB8;
        Tue, 10 Jul 2018 18:34:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.17 00/56] 4.17.6-stable review
Date:   Tue, 10 Jul 2018 20:24:42 +0200
Message-Id: <20180710182503.544433950@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.17.6-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.17.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.17.6-rc1
X-KernelTest-Deadline: 2018-07-12T18:25+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.17.6 release.
There are 56 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Jul 12 18:24:40 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.17.6-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.17.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.17.6-rc1

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Revert mm/vmstat.c: fix vmstat_update() preemption BUG

Dan Carpenter <dan.carpenter@oracle.com>
    staging: comedi: quatech_daqp_cs: fix no-op loop daqp_ao_insn_write()

Jann Horn <jannh@google.com>
    netfilter: nf_log: don't hold nf_log_mutex during user access

Tokunori Ikegami <ikegami@allied-telesis.co.jp>
    mtd: cfi_cmdset_0002: Change erase functions to check chip good only

Tokunori Ikegami <ikegami@allied-telesis.co.jp>
    mtd: cfi_cmdset_0002: Change erase functions to retry for error

Tokunori Ikegami <ikegami@allied-telesis.co.jp>
    mtd: cfi_cmdset_0002: Change definition naming to retry write operation

Ross Zwisler <ross.zwisler@linux.intel.com>
    dm: prevent DAX mounts if not supported

Ross Zwisler <ross.zwisler@linux.intel.com>
    dax: check for QUEUE_FLAG_DAX in bdev_dax_supported()

Dave Jiang <dave.jiang@intel.com>
    dax: change bdev_dax_supported() to support boolean returns

Darrick J. Wong <darrick.wong@oracle.com>
    fs: allow per-device dax status checking for filesystems

Peter Rosin <peda@axentia.se>
    i2c: smbus: kill memory leak on emulated and failed DMA SMBus xfers

Wenwen Wang <wang6495@umn.edu>
    i2c: core: smbus: fix a potential missing-check bug

Benjamin Tissoires <benjamin.tissoires@redhat.com>
    HID: core: allow concurrent registration of drivers

Daniel Rosenberg <drosen@google.com>
    HID: debug: check length before copy_to_user()

Gustavo A. R. Silva <gustavo@embeddedor.com>
    HID: hiddev: fix potential Spectre v1

Jason Andryuk <jandryuk@gmail.com>
    HID: i2c-hid: Fix "incomplete report" noise

Jon Derrick <jonathan.derrick@intel.com>
    ext4: check superblock mapped prior to committing

Theodore Ts'o <tytso@mit.edu>
    ext4: add more mount time checks of the superblock

Theodore Ts'o <tytso@mit.edu>
    ext4: add more inode number paranoia checks

Theodore Ts'o <tytso@mit.edu>
    ext4: avoid running out of journal credits when appending to an inline file

Theodore Ts'o <tytso@mit.edu>
    ext4: never move the system.data xattr out of the inode body

Theodore Ts'o <tytso@mit.edu>
    ext4: clear i_data in ext4_inode_info when removing inline data

Theodore Ts'o <tytso@mit.edu>
    ext4: include the illegal physical block in the bad map ext4_error msg

Theodore Ts'o <tytso@mit.edu>
    ext4: verify the depth of extent tree in ext4_find_extent()

Theodore Ts'o <tytso@mit.edu>
    ext4: only look at the bg_flags field if it is valid

Theodore Ts'o <tytso@mit.edu>
    ext4: always check block group bounds in ext4_init_block_bitmap()

Theodore Ts'o <tytso@mit.edu>
    ext4: make sure bitmaps and the inode table don't overlap with bg descriptors

Theodore Ts'o <tytso@mit.edu>
    ext4: always verify the magic number in xattr blocks

Theodore Ts'o <tytso@mit.edu>
    ext4: add corruption check in ext4_xattr_set_entry()

Theodore Ts'o <tytso@mit.edu>
    jbd2: don't mark block as modified if the handle is out of credits

Lyude Paul <lyude@redhat.com>
    drm/amdgpu: Dynamically probe for ATIF handle (v2)

Lyude Paul <lyude@redhat.com>
    drm/amdgpu: Add amdgpu_atpx_get_dhandle()

Mikulas Patocka <mpatocka@redhat.com>
    drm/udl: fix display corruption of the last line

Michel Dänzer <michel.daenzer@amd.com>
    drm: Use kvzalloc for allocating blob property memory

Paulo Alcantara <paulo@paulo.ac>
    cifs: Fix infinite loop when using hard mount option

Stefano Brivio <sbrivio@redhat.com>
    cifs: Fix slab-out-of-bounds in send_set_info() on SMB2 ACE setting

Paulo Alcantara <paulo@paulo.ac>
    cifs: Fix memory leak in smb2_set_ea()

Lars Persson <lars.persson@axis.com>
    cifs: Fix use after free of a mid_q_entry

Roger Quadros <rogerq@ti.com>
    ARM: dts: dra7: Disable metastability workaround for USB2

Adam Ford <aford173@gmail.com>
    ARM: dts: omap3: Fix am3517 mdio and emac clock references

Nick Dyer <nick@shmanahar.org>
    ARM: dts: imx51-zii-rdu1: fix touchscreen pinctrl

Jason Gunthorpe <jgg@ziepe.ca>
    vfio: Use get_user_pages_longterm correctly

Lars Ellenberg <lars.ellenberg@linbit.com>
    drbd: fix access after free

Christian Borntraeger <borntraeger@de.ibm.com>
    s390: Correct register corruption in critical section cleanup

David Disseldorp <ddiss@suse.de>
    scsi: target: Fix truncated PR-in ReadKeys response

Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>
    scsi: aacraid: Fix PD performance regression over incorrect qd being set

Jann Horn <jannh@google.com>
    scsi: sg: mitigate read/write abuse

Changbin Du <changbin.du@intel.com>
    tracing: Fix missing return symbol in function_graph output

Arnd Bergmann <arnd@arndb.de>
    tracing: Avoid string overflow

Lyude Paul <lyude@redhat.com>
    drm/amdgpu: Make struct amdgpu_atif private to amdgpu_acpi.c

Jouke Witteveen <j.witteveen@gmail.com>
    ACPI / battery: Safe unregistering of hooks

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    ACPICA: Drop leading newlines from error messages

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PCI / ACPI / PM: Resume bridges w/o drivers on suspend-to-RAM

Pavel Tatashin <pasha.tatashin@oracle.com>
    mm: teach dump_page() to correctly output poisoned struct pages

Cannon Matthews <cannonmatthews@google.com>
    mm: hugetlb: yield when prepping struct pages

Janosch Frank <frankja@linux.ibm.com>
    userfaultfd: hugetlbfs: fix userfaultfd_huge_must_wait() pte access


-------------

Diffstat:

 Makefile                                         |   4 +-
 arch/arm/boot/dts/am3517.dtsi                    |   4 +
 arch/arm/boot/dts/dra7.dtsi                      |   2 +-
 arch/arm/boot/dts/imx51-zii-rdu1.dts             |   2 +-
 arch/s390/kernel/entry.S                         |   4 +-
 drivers/acpi/acpica/uterror.c                    |   6 +-
 drivers/acpi/battery.c                           |   9 +-
 drivers/block/drbd/drbd_worker.c                 |   2 +-
 drivers/dax/super.c                              |  48 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu.h              |  46 ++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c         | 131 +++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c |   6 ++
 drivers/gpu/drm/drm_property.c                   |   6 +-
 drivers/gpu/drm/udl/udl_fb.c                     |   5 +-
 drivers/gpu/drm/udl/udl_transfer.c               |  11 +-
 drivers/hid/hid-core.c                           |   5 +-
 drivers/hid/hid-debug.c                          |   8 +-
 drivers/hid/i2c-hid/i2c-hid.c                    |   2 +-
 drivers/hid/usbhid/hiddev.c                      |  11 ++
 drivers/i2c/i2c-core-smbus.c                     |  12 ++-
 drivers/md/dm-table.c                            |   7 +-
 drivers/md/dm.c                                  |   3 +-
 drivers/mtd/chips/cfi_cmdset_0002.c              |  30 ++++--
 drivers/pci/pci-acpi.c                           |  12 +++
 drivers/scsi/aacraid/aachba.c                    |  15 ++-
 drivers/scsi/sg.c                                |  42 +++++++-
 drivers/staging/comedi/drivers/quatech_daqp_cs.c |   2 +-
 drivers/target/target_core_pr.c                  |  15 ++-
 drivers/vfio/vfio_iommu_type1.c                  |  16 ++-
 fs/cifs/cifsglob.h                               |   1 +
 fs/cifs/cifsproto.h                              |   1 +
 fs/cifs/cifssmb.c                                |  10 +-
 fs/cifs/connect.c                                |   8 +-
 fs/cifs/smb1ops.c                                |   1 +
 fs/cifs/smb2ops.c                                |   3 +
 fs/cifs/smb2pdu.c                                |  25 +++--
 fs/cifs/smb2transport.c                          |   1 +
 fs/cifs/transport.c                              |  18 +++-
 fs/ext2/super.c                                  |   3 +-
 fs/ext4/balloc.c                                 |  21 ++--
 fs/ext4/ext4.h                                   |   8 --
 fs/ext4/ext4_extents.h                           |   1 +
 fs/ext4/extents.c                                |   6 ++
 fs/ext4/ialloc.c                                 |  14 ++-
 fs/ext4/inline.c                                 |  39 +------
 fs/ext4/inode.c                                  |   7 +-
 fs/ext4/mballoc.c                                |   6 +-
 fs/ext4/super.c                                  |  89 ++++++++++++---
 fs/ext4/xattr.c                                  |  40 ++++---
 fs/jbd2/transaction.c                            |   9 +-
 fs/userfaultfd.c                                 |  12 ++-
 fs/xfs/xfs_ioctl.c                               |   3 +-
 fs/xfs/xfs_iops.c                                |  30 +++++-
 fs/xfs/xfs_super.c                               |  10 +-
 include/linux/dax.h                              |  11 +-
 include/linux/hid.h                              |   3 +-
 kernel/trace/trace_events_hist.c                 |   2 +-
 kernel/trace/trace_functions_graph.c             |   5 +-
 mm/debug.c                                       |  18 +++-
 mm/hugetlb.c                                     |   1 +
 mm/vmstat.c                                      |   2 -
 net/netfilter/nf_log.c                           |   9 +-
 62 files changed, 596 insertions(+), 287 deletions(-)


