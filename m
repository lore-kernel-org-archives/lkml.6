Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D5FC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F8B20B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F8B20B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388221AbeGJSaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:30:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45676 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732400AbeGJSay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:30:54 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 813A7EC6;
        Tue, 10 Jul 2018 18:30:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/52] 4.9.112-stable review
Date:   Tue, 10 Jul 2018 20:24:28 +0200
Message-Id: <20180710182449.285532226@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.112-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.112-rc1
X-KernelTest-Deadline: 2018-07-12T18:24+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.112 release.
There are 52 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Jul 12 18:24:30 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.112-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.112-rc1

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

Mikulas Patocka <mpatocka@redhat.com>
    dm bufio: don't take the lock in dm_bufio_shrink_count

Martin Kaiser <martin@kaiser.cx>
    mtd: rawnand: mxc: set spare area size register explicitly

Mikulas Patocka <mpatocka@redhat.com>
    dm bufio: drop the lock when doing GFP_NOIO allocation

Douglas Anderson <dianders@chromium.org>
    dm bufio: avoid sleeping while holding the dm_bufio lock

Vlastimil Babka <vbabka@suse.cz>
    mm, page_alloc: do not break __GFP_THISNODE by zonelist reset

Brad Love <brad@nextdimension.cc>
    media: cx25840: Use subdev host data for PLL override

Rasmus Villemoes <linux@rasmusvillemoes.dk>
    Kbuild: fix # escaping in .cmd files for future Make

Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
    PM / OPP: Update voltage in case freq == old_freq

Daniel Rosenberg <drosen@google.com>
    HID: debug: check length before copy_to_user()

Gustavo A. R. Silva <gustavo@embeddedor.com>
    HID: hiddev: fix potential Spectre v1

Jason Andryuk <jandryuk@gmail.com>
    HID: i2c-hid: Fix "incomplete report" noise

Ido Schimmel <idosch@mellanox.com>
    mlxsw: spectrum: Forbid linking of VLAN devices to devices that have uppers

Jon Derrick <jonathan.derrick@intel.com>
    ext4: check superblock mapped prior to committing

Theodore Ts'o <tytso@mit.edu>
    ext4: add more mount time checks of the superblock

Theodore Ts'o <tytso@mit.edu>
    ext4: add more inode number paranoia checks

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
    jbd2: don't mark block as modified if the handle is out of credits

Mikulas Patocka <mpatocka@redhat.com>
    drm/udl: fix display corruption of the last line

Paulo Alcantara <paulo@paulo.ac>
    cifs: Fix infinite loop when using hard mount option

Lars Ellenberg <lars.ellenberg@linbit.com>
    drbd: fix access after free

Christian Borntraeger <borntraeger@de.ibm.com>
    s390: Correct register corruption in critical section cleanup

Jann Horn <jannh@google.com>
    scsi: sg: mitigate read/write abuse

Changbin Du <changbin.du@intel.com>
    tracing: Fix missing return symbol in function_graph output

Cannon Matthews <cannonmatthews@google.com>
    mm: hugetlb: yield when prepping struct pages

Andy Lutomirski <luto@kernel.org>
    x86/cpu: Re-apply forced caps every time CPU caps are re-read

Juergen Gross <jgross@suse.com>
    x86/xen: Add call of speculative_store_bypass_ht_init() to PV paths

Mike Marciniszyn <mike.marciniszyn@intel.com>
    IB/hfi1: Fix user context tail allocation for DMA_RTAIL

Sean Nyekjaer <sean.nyekjaer@prevas.dk>
    ARM: dts: imx6q: Use correct SDMA script for SPI5 core

Grygorii Strashko <grygorii.strashko@ti.com>
    net: phy: micrel: fix crash when statistic requested for KSZ9031 phy

David S. Miller <davem@davemloft.net>
    Revert "sit: reload iphdr in ipip6_rcv"

Taehee Yoo <ap420073@gmail.com>
    netfilter: nf_tables: use WARN_ON_ONCE instead of BUG_ON in nft_do_chain()

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes/x86: Do not modify singlestep buffer while resuming

Ben Hutchings <ben.hutchings@codethink.co.uk>
    ipv4: Fix error return value in fib_convert_metrics()

Wolfram Sang <wsa+renesas@sang-engineering.com>
    i2c: rcar: fix resume by always initializing registers before transfer

Alexander Potapenko <glider@google.com>
    vt: prevent leaking uninitialized data to userspace via /dev/vcs*

Laura Abbott <labbott@redhat.com>
    staging: android: ion: Return an ERR_PTR in ion_map_kernel

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    n_tty: Access echo_* variables carefully.

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    n_tty: Fix stall at n_tty_receive_char_special().

William Wu <william.wu@rock-chips.com>
    usb: dwc2: fix the incorrect bitmaps for the ports of multi_tt hub

Karoly Pados <pados@pados.hu>
    USB: serial: cp210x: add Silicon Labs IDs for Windows Update

Johan Hovold <johan@kernel.org>
    USB: serial: cp210x: add CESINEL device ids

Houston Yaroschoff <hstn@4ever3.net>
    usb: cdc_acm: Add quirk for Uniden UBC125 scanner


-------------

Diffstat:

 Makefile                                         |  4 +-
 arch/arm/boot/dts/imx6q.dtsi                     |  2 +-
 arch/s390/kernel/entry.S                         |  4 +-
 arch/x86/kernel/cpu/common.c                     |  7 ++
 arch/x86/kernel/kprobes/core.c                   | 42 ++++++------
 arch/x86/xen/smp.c                               |  5 ++
 drivers/base/power/opp/core.c                    |  2 +-
 drivers/block/drbd/drbd_worker.c                 |  2 +-
 drivers/gpu/drm/udl/udl_fb.c                     |  5 +-
 drivers/gpu/drm/udl/udl_transfer.c               | 11 +--
 drivers/hid/hid-debug.c                          |  8 ++-
 drivers/hid/i2c-hid/i2c-hid.c                    |  2 +-
 drivers/hid/usbhid/hiddev.c                      | 11 +++
 drivers/i2c/busses/i2c-rcar.c                    |  4 +-
 drivers/infiniband/hw/hfi1/chip.c                |  8 +--
 drivers/infiniband/hw/hfi1/file_ops.c            |  2 +-
 drivers/infiniband/hw/hfi1/init.c                |  9 ++-
 drivers/md/dm-bufio.c                            | 31 +++++----
 drivers/media/i2c/cx25840/cx25840-core.c         | 28 ++++++--
 drivers/mtd/chips/cfi_cmdset_0002.c              | 30 ++++++---
 drivers/mtd/nand/mxc_nand.c                      |  5 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c   |  6 +-
 drivers/net/phy/micrel.c                         | 17 +----
 drivers/scsi/sg.c                                | 42 +++++++++++-
 drivers/staging/android/ion/ion_heap.c           |  2 +-
 drivers/staging/comedi/drivers/quatech_daqp_cs.c |  2 +-
 drivers/tty/n_tty.c                              | 55 ++++++++-------
 drivers/tty/vt/vt.c                              |  4 +-
 drivers/usb/class/cdc-acm.c                      |  3 +
 drivers/usb/dwc2/hcd_queue.c                     |  2 +-
 drivers/usb/serial/cp210x.c                      | 14 ++++
 fs/cifs/cifssmb.c                                | 10 ++-
 fs/cifs/smb2pdu.c                                | 18 +++--
 fs/ext4/balloc.c                                 | 21 +++---
 fs/ext4/ext4.h                                   |  5 --
 fs/ext4/ext4_extents.h                           |  1 +
 fs/ext4/extents.c                                |  6 ++
 fs/ext4/ialloc.c                                 | 14 +++-
 fs/ext4/inline.c                                 |  1 +
 fs/ext4/inode.c                                  |  7 +-
 fs/ext4/mballoc.c                                |  6 +-
 fs/ext4/super.c                                  | 86 ++++++++++++++++++++----
 fs/jbd2/transaction.c                            |  9 ++-
 kernel/trace/trace_functions_graph.c             |  5 +-
 mm/hugetlb.c                                     |  1 +
 mm/page_alloc.c                                  |  1 -
 net/ipv4/fib_semantics.c                         |  2 +-
 net/ipv6/sit.c                                   |  1 -
 net/netfilter/nf_log.c                           |  9 ++-
 net/netfilter/nf_tables_core.c                   |  3 +-
 scripts/Kbuild.include                           |  5 +-
 tools/build/Build.include                        |  5 +-
 tools/objtool/Makefile                           |  2 +-
 tools/scripts/Makefile.include                   |  2 +
 54 files changed, 408 insertions(+), 181 deletions(-)


