Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDC4C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B402146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQr/Aa4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B402146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeLDLJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:09:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728742AbeLDLJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:09:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 058AD214DB;
        Tue,  4 Dec 2018 11:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921751;
        bh=shJmaalloJtvp0zP7vqEJyLk5k8ftHI59/p+p9PMFS0=;
        h=From:To:Cc:Subject:Date:From;
        b=XQr/Aa4oKTAVTqvYpW6ByBMpT4MPjHPUv1OQNgrtGKgLLMhXthO+Fkfe942QzVbc8
         tC3YmbsJCopUbFpFvtpQbLJVElcy5drrboVp+9zw1al13tHXUm6rVsjhcA8qmbNKyO
         L3x/hKaUQWGpT3EuWXxABwMpEmXdz540nhAUgkRo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/50] 4.9.143-stable review
Date:   Tue,  4 Dec 2018 11:49:55 +0100
Message-Id: <20181204103714.485546262@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.143-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.143-rc1
X-KernelTest-Deadline: 2018-12-06T10:37+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.143 release.
There are 50 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Dec  6 10:36:59 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.143-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.143-rc1

Chris Fries <cfries@google.com>
    kbuild: Set KBUILD_CFLAGS before incl. arch Makefile

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    efi/libstub: Make file I/O chunking x86-specific

Arnd Bergmann <arnd@arndb.de>
    workqueue: avoid clang warning

Stefan Agner <stefan@agner.ch>
    ARM: trusted_foundations: do not use naked function

Stefan Agner <stefan@agner.ch>
    bus: arm-cci: remove unnecessary unreachable()

Stefan Agner <stefan@agner.ch>
    ARM: 8767/1: add support for building ARM kernel with clang

Stefan Agner <stefan@agner.ch>
    ARM: 8766/1: drop no-thumb-interwork in EABI mode

Alistair Strachan <astrachan@google.com>
    efi/libstub: arm: support building with clang

YueHaibing <yuehaibing@huawei.com>
    misc: mic/scif: fix copy-paste error in scif_create_remote_lookup

Dexuan Cui <decui@microsoft.com>
    Drivers: hv: vmbus: check the creation_status in vmbus_establish_gpadl()

Yu Zhao <yuzhao@google.com>
    mm: use swp_offset as key in shmem_replace_page()

Martin Kelly <martin@martingkelly.com>
    iio:st_magn: Fix enable device after trigger

Felipe Balbi <felipe.balbi@linux.intel.com>
    Revert "usb: dwc3: gadget: skip Set/Clear Halt when invalid"

Michael Niewöhner <linux@mniewoehner.de>
    usb: core: quirks: add RESET_RESUME quirk for Cherry G230 Stream series

Kai-Heng Feng <kai.heng.feng@canonical.com>
    USB: usb-storage: Add new IDs to ums-realtek

Josef Bacik <josef@toxicpanda.com>
    btrfs: release metadata before running delayed refs

Richard Genoud <richard.genoud@gmail.com>
    dmaengine: at_hdmac: fix module unloading

Richard Genoud <richard.genoud@gmail.com>
    dmaengine: at_hdmac: fix memory leak in at_dma_xlate()

Pan Bian <bianpan2016@163.com>
    ext2: fix potential use after free

Takashi Iwai <tiwai@suse.de>
    ALSA: sparc: Fix invalid snd_free_pages() at error path

Takashi Iwai <tiwai@suse.de>
    ALSA: control: Fix race between adding and removing a user element

Takashi Iwai <tiwai@suse.de>
    ALSA: ac97: Fix incorrect bit shift at AC97-SPSA control write

Takashi Iwai <tiwai@suse.de>
    ALSA: wss: Fix invalid snd_free_pages() at error path

Maximilian Heyne <mheyne@amazon.de>
    fs: fix lost error code in dio_complete

Jiri Olsa <jolsa@kernel.org>
    perf/x86/intel: Add generic branch tracing check to intel_pmu_has_bts()

Jiri Olsa <jolsa@kernel.org>
    perf/x86/intel: Move branch tracing setup to the Intel-specific source file

Filipe Manana <fdmanana@suse.com>
    Btrfs: ensure path name is null terminated at btrfs_control_ioctl

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: fix coprocessor context offset definitions

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: enable coprocessors that are being flushed

Wanpeng Li <wanpengli@tencent.com>
    KVM: X86: Fix scan ioapic use-before-initialization

Jim Mattson <jmattson@google.com>
    kvm: svm: Ensure an IBPB on all affected CPUs when freeing a vmcb

Junaid Shahid <junaids@google.com>
    kvm: mmu: Fix race in emulated page table writes

Bernd Eckstein <3erndeckstein@gmail.com>
    usbnet: ipheth: fix potential recvmsg bug and recvmsg bug 2

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: fix length check in SNMP processing

Pan Bian <bianpan2016@163.com>
    rapidio/rionet: do not free skb before reading its length

Petr Machata <petrm@mellanox.com>
    net: skb_scrub_packet(): Scrub offload_fwd_mark

Sasha Levin <sashal@kernel.org>
    Revert "wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_timeout()"

Matthias Schwarzott <zzam@gentoo.org>
    media: em28xx: Fix use-after-free when disconnecting

Hugh Dickins <hughd@google.com>
    mm/khugepaged: collapse_shmem() do not crash on Compound

Hugh Dickins <hughd@google.com>
    mm/khugepaged: collapse_shmem() without freezing new_page

Hugh Dickins <hughd@google.com>
    mm/khugepaged: minor reorderings in collapse_shmem()

Hugh Dickins <hughd@google.com>
    mm/khugepaged: collapse_shmem() remember to clear holes

Hugh Dickins <hughd@google.com>
    mm/khugepaged: fix crashes due to misaccounted holes

Mike Rapoport <rppt@linux.vnet.ibm.com>
    shmem: introduce shmem_inode_acct_block

Mike Rapoport <rppt@linux.vnet.ibm.com>
    shmem: shmem_charge: verify max_block is not exceeded before inode update

Hugh Dickins <hughd@google.com>
    mm/khugepaged: collapse_shmem() stop if punched or truncated

Hugh Dickins <hughd@google.com>
    mm/huge_memory: fix lockdep complaint on 32-bit i_size_read()

Hugh Dickins <hughd@google.com>
    mm/huge_memory: splitting set mapping+index before unfreeze

Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
    mm/huge_memory.c: reorder operations in __split_huge_page_tail()

Hugh Dickins <hughd@google.com>
    mm/huge_memory: rename freeze_page() to unmap_page()


-------------

Diffstat:

 Makefile                                       |  69 ++++++-------
 arch/arm/Makefile                              |   2 +-
 arch/arm/boot/compressed/Makefile              |   2 +-
 arch/arm/firmware/trusted_foundations.c        |  14 ++-
 arch/x86/events/core.c                         |  20 ----
 arch/x86/events/intel/core.c                   |  52 +++++++---
 arch/x86/events/perf_event.h                   |  13 ++-
 arch/x86/kvm/mmu.c                             |  27 ++----
 arch/x86/kvm/svm.c                             |  20 +++-
 arch/x86/kvm/x86.c                             |   3 +-
 arch/xtensa/kernel/asm-offsets.c               |  16 +--
 arch/xtensa/kernel/process.c                   |   5 +-
 drivers/bus/arm-cci.c                          |   2 -
 drivers/dma/at_hdmac.c                         |  10 +-
 drivers/firmware/efi/libstub/Makefile          |   3 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c |  11 ++-
 drivers/hv/channel.c                           |   8 ++
 drivers/iio/magnetometer/st_magn_buffer.c      |  12 +--
 drivers/media/usb/em28xx/em28xx-dvb.c          |   3 +-
 drivers/misc/mic/scif/scif_rma.c               |   2 +-
 drivers/net/rionet.c                           |   2 +-
 drivers/net/usb/ipheth.c                       |  10 +-
 drivers/net/wireless/ti/wlcore/cmd.c           |   6 --
 drivers/s390/net/qeth_core_main.c              |  27 +++---
 drivers/usb/core/quirks.c                      |   3 +
 drivers/usb/dwc3/gadget.c                      |   5 -
 drivers/usb/storage/unusual_realtek.h          |  10 ++
 fs/btrfs/super.c                               |   1 +
 fs/btrfs/transaction.c                         |   6 +-
 fs/direct-io.c                                 |   4 +-
 fs/ext2/xattr.c                                |   2 +-
 include/linux/workqueue.h                      |   4 +-
 mm/huge_memory.c                               |  79 +++++++--------
 mm/khugepaged.c                                | 129 ++++++++++++++-----------
 mm/shmem.c                                     |  97 ++++++++++---------
 net/core/skbuff.c                              |   4 +
 sound/core/control.c                           |  80 ++++++++-------
 sound/isa/wss/wss_lib.c                        |   2 -
 sound/pci/ac97/ac97_codec.c                    |   2 +-
 sound/sparc/cs4231.c                           |   8 +-
 40 files changed, 424 insertions(+), 351 deletions(-)


