Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A98C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F84020936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F84020936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732651AbeGJS0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:26:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43608 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732630AbeGJS0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:26:02 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 97E66D71;
        Tue, 10 Jul 2018 18:25:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/23] 3.18.115-stable review
Date:   Tue, 10 Jul 2018 20:24:33 +0200
Message-Id: <20180710182308.877332304@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.115-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.115-rc1
X-KernelTest-Deadline: 2018-07-12T18:23+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.18.115 release.
There are 23 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Jul 12 18:22:59 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.115-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.115-rc1

Jann Horn <jannh@google.com>
    netfilter: nf_log: don't hold nf_log_mutex during user access

Tokunori Ikegami <ikegami@allied-telesis.co.jp>
    mtd: cfi_cmdset_0002: Change erase functions to check chip good only

Tokunori Ikegami <ikegami@allied-telesis.co.jp>
    mtd: cfi_cmdset_0002: Change erase functions to retry for error

Tokunori Ikegami <ikegami@allied-telesis.co.jp>
    mtd: cfi_cmdset_0002: Change definition naming to retry write operation

Martin Kaiser <martin@kaiser.cx>
    mtd: rawnand: mxc: set spare area size register explicitly

Mikulas Patocka <mpatocka@redhat.com>
    dm bufio: drop the lock when doing GFP_NOIO allocation

Douglas Anderson <dianders@chromium.org>
    dm bufio: avoid sleeping while holding the dm_bufio lock

Brad Love <brad@nextdimension.cc>
    media: cx25840: Use subdev host data for PLL override

Daniel Rosenberg <drosen@google.com>
    HID: debug: check length before copy_to_user()

Jason Andryuk <jandryuk@gmail.com>
    HID: i2c-hid: Fix "incomplete report" noise

Theodore Ts'o <tytso@mit.edu>
    ext4: add more mount time checks of the superblock

Theodore Ts'o <tytso@mit.edu>
    ext4: clear i_data in ext4_inode_info when removing inline data

Theodore Ts'o <tytso@mit.edu>
    ext4: make sure bitmaps and the inode table don't overlap with bg descriptors

Paulo Alcantara <paulo@paulo.ac>
    cifs: Fix infinite loop when using hard mount option

Jann Horn <jannh@google.com>
    scsi: sg: mitigate read/write abuse

Finn Thain <fthain@telegraphics.com.au>
    net/sonic: Use dma_mapping_error()

Josh Hill <josh@joshuajhill.com>
    net: qmi_wwan: Add Netgear Aircard 779S

Ivan Bornyakov <brnkv.i1@gmail.com>
    atm: zatm: fix memcmp casting

Paolo Abeni <pabeni@redhat.com>
    netfilter: ebtables: handle string from userspace with care

Richard Weinberger <richard@nod.at>
    ubi: fastmap: Correctly handle interrupted erasures in EBA

Dave Hansen <dave.hansen@linux.intel.com>
    x86/boot: Fix early command-line parsing when matching at end

Laura Abbott <labbott@redhat.com>
    staging: android: ion: Return an ERR_PTR in ion_map_kernel

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    n_tty: Fix stall at n_tty_receive_char_special().


-------------

Diffstat:

 Makefile                                 |  4 +-
 arch/x86/lib/cmdline.c                   | 34 ++++++++----
 drivers/atm/zatm.c                       |  4 +-
 drivers/hid/hid-debug.c                  |  8 ++-
 drivers/hid/i2c-hid/i2c-hid.c            |  2 +-
 drivers/md/dm-bufio.c                    | 15 +++++-
 drivers/media/i2c/cx25840/cx25840-core.c | 28 +++++++---
 drivers/mtd/chips/cfi_cmdset_0002.c      | 30 +++++++----
 drivers/mtd/nand/mxc_nand.c              |  5 +-
 drivers/mtd/ubi/eba.c                    | 92 +++++++++++++++++++++++++++++++-
 drivers/net/ethernet/natsemi/sonic.c     |  2 +-
 drivers/net/usb/qmi_wwan.c               |  1 +
 drivers/scsi/sg.c                        | 42 ++++++++++++++-
 drivers/staging/android/ion/ion_heap.c   |  2 +-
 drivers/tty/n_tty.c                      | 13 +++--
 fs/cifs/cifssmb.c                        | 10 +++-
 fs/cifs/smb2pdu.c                        | 18 ++++---
 fs/ext4/inline.c                         |  1 +
 fs/ext4/super.c                          | 62 +++++++++++++++++----
 net/bridge/netfilter/ebtables.c          |  3 +-
 net/netfilter/nf_log.c                   |  9 ++--
 21 files changed, 318 insertions(+), 67 deletions(-)


