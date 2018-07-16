Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D58ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C17B20864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C17B20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388877AbeGPIIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:08:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47866 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbeGPIIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:08:54 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 74E72C03;
        Mon, 16 Jul 2018 07:42:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/32] 4.9.113-stable review
Date:   Mon, 16 Jul 2018 09:36:08 +0200
Message-Id: <20180716073504.433996952@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.113-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.113-rc1
X-KernelTest-Deadline: 2018-07-18T07:35+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.113 release.
There are 32 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Jul 18 07:34:43 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.113-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.113-rc1

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    loop: remember whether sysfs_create_group() was done

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucm: Mark UCM interface as BROKEN

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    PM / hibernate: Fix oops at snapshot_write()

Theodore Ts'o <tytso@mit.edu>
    loop: add recursion validation to LOOP_CHANGE_FD

Florian Westphal <fw@strlen.de>
    netfilter: x_tables: initialise match/target check parameter struct

Eric Dumazet <edumazet@google.com>
    netfilter: nf_queue: augment nfqa_cfg_policy

Oleg Nesterov <oleg@redhat.com>
    uprobes/x86: Remove incorrect WARN_ON() in uprobe_init_insn()

Keith Busch <keith.busch@intel.com>
    nvme-pci: Remap CMB SQ entries on every controller reset

Steve Wise <swise@opengridcomputing.com>
    iw_cxgb4: correctly enforce the max reg_mr depth

Jon Hunter <jonathanh@nvidia.com>
    i2c: tegra: Fix NACK error handling

Paul Menzel <pmenzel@molgen.mpg.de>
    tools build: fix # escaping in .cmd files for future Make

Oscar Salvador <osalvador@suse.de>
    fs, elf: make sure to page align bss in load_elf_library

Chris Wilson <chris@chris-wilson.co.uk>
    ALSA: hda - Handle pm failure during hotplug

Linus Torvalds <torvalds@linux-foundation.org>
    Fix up non-directory creation in SGID directories

Tomasz Kramkowski <tk@the-tk.com>
    HID: usbhid: add quirk for innomedia INNEX GENESIS/ATARI adapter

Dan Carpenter <dan.carpenter@oracle.com>
    xhci: xhci-mem: off by one in xhci_stream_id_to_ring()

Nico Sneck <snecknico@gmail.com>
    usb: quirks: add delay quirks for Corsair Strafe

Johan Hovold <johan@kernel.org>
    USB: serial: mos7840: fix status-register error handling

Jann Horn <jannh@google.com>
    USB: yurex: fix out-of-bounds uaccess in read handler

Johan Hovold <johan@kernel.org>
    USB: serial: keyspan_pda: fix modem-status error handling

Olli Salonen <olli.salonen@iki.fi>
    USB: serial: cp210x: add another USB ID for Qivicon ZigBee stick

Dan Carpenter <dan.carpenter@oracle.com>
    USB: serial: ch341: fix type promotion bug in ch341_control_in()

Hans de Goede <hdegoede@redhat.com>
    ahci: Disable LPM on Lenovo 50 series laptops with a too old BIOS

Nadav Amit <namit@vmware.com>
    vmw_balloon: fix inflation with batching

Damien Le Moal <damien.lemoal@wdc.com>
    ata: Fix ZBC_OUT all bit handling

Damien Le Moal <damien.lemoal@wdc.com>
    ata: Fix ZBC_OUT command block check

Jann Horn <jannh@google.com>
    ibmasm: don't write out of bounds in read handler

x00270170 <xiaqing17@hisilicon.com>
    mmc: dw_mmc: fix card threshold control configuration

Paul Burton <paul.burton@mips.com>
    MIPS: Fix ioremap() RAM check

Paul Burton <paul.burton@mips.com>
    MIPS: Use async IPIs for arch_trigger_cpumask_backtrace()

Paul Burton <paul.burton@mips.com>
    MIPS: Call dump_stack() from show_regs()

Scott Bauer <scott.bauer@intel.com>
    nvme: validate admin queue before unquiesce


-------------

Diffstat:

 Makefile                          |  4 +-
 arch/mips/kernel/process.c        | 43 ++++++++++++++-------
 arch/mips/kernel/traps.c          |  1 +
 arch/mips/mm/ioremap.c            | 37 ++++++++++++------
 arch/x86/kernel/uprobes.c         |  2 +-
 drivers/ata/ahci.c                | 59 +++++++++++++++++++++++++++++
 drivers/ata/libata-core.c         |  3 ++
 drivers/ata/libata-scsi.c         | 18 ++++++---
 drivers/block/loop.c              | 79 ++++++++++++++++++++++-----------------
 drivers/block/loop.h              |  1 +
 drivers/hid/hid-ids.h             |  3 ++
 drivers/hid/usbhid/hid-quirks.c   |  1 +
 drivers/i2c/busses/i2c-tegra.c    | 17 ++++-----
 drivers/infiniband/Kconfig        | 12 ++++++
 drivers/infiniband/core/Makefile  |  4 +-
 drivers/infiniband/hw/cxgb4/mem.c |  2 +-
 drivers/misc/ibmasm/ibmasmfs.c    | 27 ++-----------
 drivers/misc/vmw_balloon.c        |  4 +-
 drivers/mmc/host/dw_mmc.c         |  7 ++--
 drivers/nvme/host/core.c          |  3 +-
 drivers/nvme/host/pci.c           | 27 +++++++------
 drivers/usb/core/quirks.c         |  4 ++
 drivers/usb/host/xhci-mem.c       |  2 +-
 drivers/usb/misc/yurex.c          | 23 +++---------
 drivers/usb/serial/ch341.c        |  2 +-
 drivers/usb/serial/cp210x.c       |  1 +
 drivers/usb/serial/keyspan_pda.c  |  4 +-
 drivers/usb/serial/mos7840.c      |  3 ++
 fs/binfmt_elf.c                   |  5 +--
 fs/inode.c                        |  6 +++
 include/linux/libata.h            |  1 +
 kernel/power/user.c               |  5 +++
 net/bridge/netfilter/ebtables.c   |  2 +
 net/ipv4/netfilter/ip_tables.c    |  1 +
 net/ipv6/netfilter/ip6_tables.c   |  1 +
 net/netfilter/nfnetlink_queue.c   |  3 ++
 sound/pci/hda/patch_hdmi.c        | 19 +++++++---
 tools/build/Build.include         |  4 +-
 38 files changed, 287 insertions(+), 153 deletions(-)


