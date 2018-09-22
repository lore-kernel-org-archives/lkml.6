Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5070ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480CC21569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480CC21569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392039AbeIVGRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:17:30 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44084 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391851AbeIVGKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:43 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vds-0008BL-8v; Sat, 22 Sep 2018 01:19:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdn-0000pg-2S; Sat, 22 Sep 2018 01:19:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     torvalds@linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
        akpm@linux-foundation.org
Date:   Sat, 22 Sep 2018 01:15:41 +0100
Message-ID: <lsq.1537575341.194909669@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 00/63] 3.16.58-rc1 review
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.16.58 release.
There are 63 patches in this series, which will be posted as responses
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon Sep 24 00:15:41 UTC 2018.
Anything received after that time might be too late.

All the patches have also been committed to the linux-3.16.y-rc branch of
https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-stable-rc.git .
A shortlog and diffstat can be found below.

Ben.

-------------

Alexander Potapenko (1):
      scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()
         [a45b599ad808c3c982fdcdc12b0b8611c2f92824]

Alexey Khoroshilov (1):
      usbip: fix error handling in stub_probe()
         [3ff67445750a84de67faaf52c6e1895cb09f2c56]

Andy Lutomirski (1):
      x86/entry/64: Remove %ebx handling from error_entry/exit
         [b3681dd548d06deb2e1573890829dff4b15abf46]

Ben Hutchings (2):
      Revert "vti4: Don't override MTU passed on link creation via IFLA_MTU"
         [not upstream; the reverted commit was correct for upstream]
      x86/fpu: Default eagerfpu if FPU and FXSR are enabled
         [58122bf1d856a4ea9581d62a07c557d997d46a19]

Borislav Petkov (1):
      x86/cpu/AMD: Fix erratum 1076 (CPB bit)
         [f7f3dc00f61261cdc9ccd8b886f21bc4dffd6fd9]

Christoph Paasch (1):
      net: Set sk_prot_creator when cloning sockets to the right proto
         [9d538fa60bad4f7b23193c89e843797a1cf71ef3]

Cong Wang (1):
      infiniband: fix a possible use-after-free bug
         [cb2595c1393b4a5211534e6f0a0fbad369e21ad8]

Dave Chinner (2):
      xfs: catch inode allocation state mismatch corruption
         [ee457001ed6c6f31ddad69c24c1da8f377d8472d]
      xfs: validate cached inodes are free when allocated
         [afca6c5b2595fc44383919fba740c194b0b76aff]

Eric Sandeen (2):
      xfs: don't call xfs_da_shrink_inode with NULL bp
         [bb3d48dcf86a97dc25fe9fc2c11938e19cb4399a]
      xfs: set format back to extents if xfs_bmap_extents_to_btree
         [2c4306f719b083d17df2963bc761777576b8ad1b]

Ernesto A . Fernández (1):
      hfsplus: fix NULL dereference in hfsplus_lookup()
         [a7ec7a4193a2eb3b5341243fc0b621c1ac9e4ec4]

Ingo Molnar (2):
      x86/fpu: Fix the 'nofxsr' boot parameter to also clear X86_FEATURE_FXSR_OPT
         [d364a7656c1855c940dfa4baf4ebcc3c6a9e6fd2]
      x86/speculation: Clean up various Spectre related details
         [21e433bdb95bdf3aa48226fd3d33af608437f293]

Jann Horn (1):
      USB: yurex: fix out-of-bounds uaccess in read handler
         [f1e255d60ae66a9f672ff9a207ee6cd8e33d2679]

Jason Yan (1):
      scsi: libsas: defer ata device eh commands to libata
         [318aaf34f1179b39fa9c30fa0f3288b645beee39]

Jens Axboe (1):
      sr: pass down correctly sized SCSI sense buffer
         [f7068114d45ec55996b9040e98111afa56e010fe]

Jiri Kosina (1):
      x86/speculation: Protect against userspace-userspace spectreRSB
         [fdf82a7856b32d905c39afc85e34364491e46346]

Kees Cook (5):
      seccomp: add "seccomp" syscall
         [48dc92b9fc3926844257316e75ba11eb5c742b2c]
      seccomp: create internal mode-setting function
         [d78ab02c2c194257a03355fbb79eb721b381d105]
      seccomp: extract check/assign mode helpers
         [1f41b450416e689b9b7c8bfb750a98604f687a9b]
      seccomp: split mode setting routines
         [3b23dd12846215eff4afb073366b80c0c4d7543e]
      video: uvesafb: Fix integer overflow in allocation
         [9f645bcc566a1e9f921bdae7528a01ced5bc3713]

Kyle Huey (2):
      x86/process: Correct and optimize TIF_BLOCKSTEP switch
         [b9894a2f5bd18b1691cb6872c9afe32b148d0132]
      x86/process: Optimize TIF checks in __switch_to_xtra()
         [af8b3cd3934ec60f4c2a420d19a9d416554f140b]

Linus Torvalds (2):
      Fix up non-directory creation in SGID directories
         [0fa3ecd87848c9c93c2c828ef4c3a8ca36ce46c7]
      mm: get rid of vmacache_flush_all() entirely
         [7a9cdebdcc17e426fb5287e4a82db1dfe86339b2]

Mark Salyzyn (1):
      Bluetooth: hidp: buffer overflow in hidp_process_report
         [7992c18810e568b95c869b227137a2215702a805]

Mel Gorman (2):
      futex: Remove requirement for lock_page() in get_futex_key()
         [65d8fc777f6dcfee12785c057a6b57f679641c90]
      futex: Remove unnecessary warning from get_futex_key
         [48fb6f4db940e92cfb16cd878cddd59ea6120d06]

Nadav Amit (1):
      KVM: x86: Emulator ignores LDTR/TR extended base on LLDT/LTR
         [e37a75a13cdae5deaa2ea2cbf8d55b5dd08638b6]

Paolo Bonzini (4):
      KVM: x86: introduce linear_{read,write}_system
         [79367a65743975e5cac8d24d08eccc7fdae832b0]
      KVM: x86: introduce num_emulated_msrs
         [62ef68bb4d00f1a662e487f3fc44ce8521c416aa]
      KVM: x86: pass kvm_vcpu to kvm_read_guest_virt and kvm_write_guest_virt_system
         [ce14e868a54edeb2e30cb7a7b104a2fc4b9d76ca]
      kvm: x86: use correct privilege level for sgdt/sidt/fxsave/fxrstor  access
         [3c9fa24ca7c9c47605672916491f79e8ccacb9e6]

Peter Zijlstra (1):
      x86/paravirt: Fix spectre-v2 mitigations for paravirt guests
         [5800dc5c19f34e6e03b5adab1282535cb102fafd]

Piotr Luc (1):
      x86/cpu/intel: Add Knights Mill to Intel family
         [0047f59834e5947d45f34f5f12eb330d158f700b]

Qu Wenruo (1):
      btrfs: relocation: Only remove reloc rb_trees if reloc control has been initialized
         [389305b2aa68723c754f88d9dbd268a400e10664]

Sanjeev Sharma (1):
      uas: replace WARN_ON_ONCE() with lockdep_assert_held()
         [ab945eff8396bc3329cc97274320e8d2c6585077]

Scott Bauer (1):
      cdrom: Fix info leak/OOB read in cdrom_ioctl_drive_status
         [8f3fafc9c2f0ece10832c25f7ffcb07c97a32ad4]

Shankara Pailoor (1):
      jfs: Fix inconsistency between memory allocation and ea_buf->max_size
         [92d34134193e5b129dc24f8d79cb9196626e8d7a]

Shuah Khan (6):
      usbip: usbip_host: delete device from busid_table after rebind
         [1e180f167d4e413afccbbb4a421b48b2de832549]
      usbip: usbip_host: fix NULL-ptr deref and use-after-free errors
         [22076557b07c12086eeb16b8ce2b0b735f7a27e7]
      usbip: usbip_host: fix bad unlock balance during stub_probe()
         [c171654caa875919be3c533d3518da8be5be966e]
      usbip: usbip_host: fix to hold parent lock for device_attach() calls
         [4bfb141bc01312a817d36627cc47c93f801c216d]
      usbip: usbip_host: refine probe and disconnect debug msgs to be  useful
         [28b68acc4a88dcf91fd1dcf2577371dc9bf574cc]
      usbip: usbip_host: run rebind from exit when module is removed
         [7510df3f29d44685bab7b1918b61a8ccd57126a9]

Takashi Iwai (1):
      ALSA: rawmidi: Change resized buffers atomically
         [39675f7a7c7e7702f7d5341f1e0d01db746543a0]

Theodore Ts'o (14):
      ext4: add corruption check in ext4_xattr_set_entry()
         [5369a762c882c0b6e9599e4ebbb3a9ba9eee7e2d]
      ext4: add more inode number paranoia checks
         [c37e9e013469521d9adb932d17a1795c139b36db]
      ext4: always check block group bounds in ext4_init_block_bitmap()
         [819b23f1c501b17b9694325471789e6b5cc2d0d2]
      ext4: always verify the magic number in xattr blocks
         [513f86d73855ce556ea9522b6bfd79f87356dc3a]
      ext4: avoid running out of journal credits when appending to an inline file
         [8bc1379b82b8e809eef77a9fedbb75c6c297be19]
      ext4: clear i_data in ext4_inode_info when removing inline data
         [6e8ab72a812396996035a37e5ca4b3b99b5d214b]
      ext4: don't allow r/w mounts if metadata blocks overlap the superblock
         [18db4b4e6fc31eda838dd1c1296d67dbcb3dc957]
      ext4: fix check to prevent initializing reserved inodes
         [5012284700775a4e6e3fbe7eac4c543c4874b559]
      ext4: fix false negatives *and* false positives in ext4_check_descriptors()
         [44de022c4382541cebdd6de4465d1f4f465ff1dd]
      ext4: make sure bitmaps and the inode table don't overlap with bg descriptors
         [77260807d1170a8cf35dbb06e07461a655f67eee]
      ext4: never move the system.data xattr out of the inode body
         [8cdb5240ec5928b20490a2bb34cb87e9a5f40226]
      ext4: only look at the bg_flags field if it is valid
         [8844618d8aa7a9973e7b527d038a2a589665002c]
      ext4: verify the depth of extent tree in ext4_find_extent()
         [bc890a60247171294acc0bd67d211fa4b88d40ba]
      jbd2: don't mark block as modified if the handle is out of credits
         [e09463f220ca9a1a1ecfda84fcda658f99a1f12a]

 Makefile                              |   4 +-
 arch/Kconfig                          |   1 +
 arch/x86/include/asm/intel-family.h   |   1 +
 arch/x86/include/asm/kvm_emulate.h    |   6 +-
 arch/x86/include/uapi/asm/msr-index.h |   1 +
 arch/x86/kernel/cpu/amd.c             |  13 +++
 arch/x86/kernel/cpu/bugs.c            |  59 ++++----------
 arch/x86/kernel/cpu/common.c          |  17 ++--
 arch/x86/kernel/entry_64.S            |  13 +--
 arch/x86/kernel/i387.c                |  24 ++++++
 arch/x86/kernel/paravirt.c            |  14 +++-
 arch/x86/kernel/process.c             |  62 +++++++++------
 arch/x86/kernel/xsave.c               |  24 +-----
 arch/x86/kvm/emulate.c                |  76 ++++++++++--------
 arch/x86/kvm/vmx.c                    |  20 +++--
 arch/x86/kvm/x86.c                    |  91 ++++++++++++++-------
 arch/x86/kvm/x86.h                    |   4 +-
 arch/x86/syscalls/syscall_32.tbl      |   1 +
 arch/x86/syscalls/syscall_64.tbl      |   1 +
 drivers/cdrom/cdrom.c                 |   2 +-
 drivers/infiniband/core/ucma.c        |   6 +-
 drivers/scsi/libsas/sas_scsi_host.c   |  33 +++-----
 drivers/scsi/sg.c                     |   2 +-
 drivers/scsi/sr_ioctl.c               |  21 ++---
 drivers/staging/usbip/stub.h          |   2 +
 drivers/staging/usbip/stub_dev.c      |  69 +++++++++-------
 drivers/staging/usbip/stub_main.c     | 100 +++++++++++++++++++++--
 drivers/usb/misc/yurex.c              |  23 ++----
 drivers/usb/storage/uas.c             |   8 +-
 drivers/video/fbdev/uvesafb.c         |   3 +-
 fs/btrfs/relocation.c                 |  23 +++---
 fs/ext4/balloc.c                      |  21 +++--
 fs/ext4/ext4.h                        |   8 --
 fs/ext4/ext4_extents.h                |   1 +
 fs/ext4/extents.c                     |   6 ++
 fs/ext4/ialloc.c                      |  19 ++++-
 fs/ext4/inline.c                      |  39 +--------
 fs/ext4/inode.c                       |   3 +-
 fs/ext4/mballoc.c                     |   6 +-
 fs/ext4/super.c                       |  41 +++++++++-
 fs/ext4/xattr.c                       |  49 ++++++------
 fs/hfsplus/dir.c                      |   4 +-
 fs/inode.c                            |   6 ++
 fs/jbd2/transaction.c                 |   2 +-
 fs/jfs/xattr.c                        |  10 ++-
 fs/xfs/xfs_attr_leaf.c                |   5 +-
 fs/xfs/xfs_bmap.c                     |   2 +
 fs/xfs/xfs_icache.c                   |  58 ++++++++++++--
 include/linux/mm_types.h              |   2 +-
 include/linux/sched.h                 |   2 +-
 include/linux/syscalls.h              |   2 +
 include/linux/vmacache.h              |   5 --
 include/uapi/asm-generic/unistd.h     |   4 +-
 include/uapi/linux/seccomp.h          |   4 +
 kernel/futex.c                        |  99 +++++++++++++++++++++--
 kernel/seccomp.c                      | 146 ++++++++++++++++++++++++++++------
 kernel/sys_ni.c                       |   3 +
 mm/vmacache.c                         |  36 ---------
 net/bluetooth/hidp/core.c             |   4 +-
 net/core/sock.c                       |   2 +
 net/ipv4/ip_vti.c                     |   1 +
 sound/core/rawmidi.c                  |  20 +++--
 62 files changed, 847 insertions(+), 487 deletions(-)

-- 
Ben Hutchings
Any sufficiently advanced bug is indistinguishable from a feature.

