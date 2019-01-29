Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88336C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42350214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762693;
	bh=GXD6iFOmZNRgsr3KA1EBylzbnaef5Drh4zKPaQ2B9B8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1NGyVDzMcec8TKsXr16M1TFdUGbNfd/EgoowN8J/5rUjeDZ7VN11+AyvbYaU58k4A
	 J2LlRmYDOn9kpBWbZ0ZL7RpEg6iUtVHMQgN56TbT2J89+Sl82UHd4ay7V45TwjSqZA
	 f0pgXTGkmgronhMlC1EdyjJrefsPdqs/zHArkdR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731892AbfA2Lvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:51:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:42956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731867AbfA2Lv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:51:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1FED2083B;
        Tue, 29 Jan 2019 11:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762687;
        bh=GXD6iFOmZNRgsr3KA1EBylzbnaef5Drh4zKPaQ2B9B8=;
        h=From:To:Cc:Subject:Date:From;
        b=RQcpNq9lRMfhl7oC3NGnNaSJBFnMhec0CFJiwrlpuB95i3ItTCniiyzZuQc6LHEqo
         TRUJbT+z3SowlIMSTYXZ8roZiRxZloFADRQj2qp83tWQvpGVudEpO5RpYrMY8hy5om
         H0zxwYq3VKoUZp8pM88cCcR9EacKkSRlgXqKGT5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/44] 4.9.154-stable review
Date:   Tue, 29 Jan 2019 12:35:55 +0100
Message-Id: <20190129113139.826927690@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.154-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.154-rc1
X-KernelTest-Deadline: 2019-01-31T11:31+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.154 release.
There are 44 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Jan 31 11:31:22 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.154-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.154-rc1

Anand Jain <anand.jain@oracle.com>
    btrfs: dev-replace: go back to suspended state if target device is missing

Jeff Mahoney <jeffm@suse.com>
    btrfs: fix error handling in btrfs_dev_replace_start

Pan Bian <bianpan2016@163.com>
    f2fs: read page index before freeing

Raju Rangoju <rajur@chelsio.com>
    nvmet-rdma: fix null dereference under heavy load

Israel Rukshin <israelr@mellanox.com>
    nvmet-rdma: Add unlikely for response allocated check

David Hildenbrand <david@redhat.com>
    s390/smp: Fix calling smp_call_ipl_cpu() from ipl CPU

Marc Zyngier <marc.zyngier@arm.com>
    irqchip/gic-v3-its: Align PCI Multi-MSI allocation on their size

Milian Wolff <milian.wolff@kdab.com>
    perf unwind: Take pgoff into account when reporting elf to libdwfl

Martin Vuille <jpmv27@aim.com>
    perf unwind: Unwind with libdw doesn't take symfs into account

Nicolas Pitre <nicolas.pitre@linaro.org>
    vt: invoke notifier on screen size change

Oliver Hartkopp <socketcan@hartkopp.net>
    can: bcm: check timer values before ktime conversion

Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
    can: dev: __can_get_echo_skb(): fix bogous check for non-existing skb by removing it

Daniel Drake <drake@endlessm.com>
    x86/kaslr: Fix incorrect i8254 outb() parameters

Dave Hansen <dave.hansen@linux.intel.com>
    x86/selftests/pkeys: Fork() to check for state being preserved

Alexander Popov <alex.popov@linux.com>
    KVM: x86: Fix single-step debugging

Joe Thornber <ejt@redhat.com>
    dm thin: fix passdown_double_checking_shared_status()

Dan Williams <dan.j.williams@intel.com>
    acpi/nfit: Fix command-supported detection

Dan Williams <dan.j.williams@intel.com>
    acpi/nfit: Block function zero DSMs

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: uinput - fix undefined behavior in uinput_validate_absinfo()

Rasmus Villemoes <linux@rasmusvillemoes.dk>
    compiler.h: enable builtin overflow checkers and add fallback code

Tom Panfil <tom@steelseries.com>
    Input: xpad - add support for SteelSeries Stratus Duo

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Do not reconnect TCP session in add_credits()

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Fix possible hang during async MTU reads and writes

Paul Fulghum <paulkf@microgate.com>
    tty/n_hdlc: fix __might_sleep warning

Samir Virmani <samir@embedur.com>
    uart: Fix crash in uart_write and uart_put_char

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    tty: Handle problem if line discipline does not have receive_buf

Michael Straube <straube.linux@gmail.com>
    staging: rtl8188eu: Add device code for D-Link DWA-121 rev B1

Gustavo A. R. Silva <gustavo@embeddedor.com>
    char/mwave: fix potential Spectre v1 vulnerability

Gerald Schaefer <gerald.schaefer@de.ibm.com>
    s390/smp: fix CPU hotplug deadlock with CPU rescan

Christian Borntraeger <borntraeger@de.ibm.com>
    s390/early: improve machine detection

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARC: perf: map generic branches to correct hardware condition

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARCv2: lib: memeset: fix doing prefetchw outside of buffer

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ASoC: rt5514-spi: Fix potential NULL pointer dereference

Kangjie Lu <kjlu@umn.edu>
    ASoC: atom: fix a missing check of snd_pcm_lib_malloc_pages

Charles Yeh <charlesyeh522@gmail.com>
    USB: serial: pl2303: add new PID to support PL2303TB

Max Schulze <max.schulze@posteo.de>
    USB: serial: simple: add Motorola Tetra TPG2200 device id

Vijay Viswanath <vviswana@codeaurora.org>
    mmc: Kconfig: Enable CONFIG_MMC_SDHCI_IO_ACCESSORS

Paolo Abeni <pabeni@redhat.com>
    ipfrag: really prevent allocation on netns exit

Cong Wang <xiyou.wangcong@gmail.com>
    net_sched: refetch skb protocol for each filter

Ido Schimmel <idosch@mellanox.com>
    net: ipv4: Fix memory leak in network namespace dismantle

Jason Wang <jasowang@redhat.com>
    vhost: log dirty page correctly

Ross Lagerwall <ross.lagerwall@citrix.com>
    openvswitch: Avoid OOB read when parsing flow nlattrs

Ross Lagerwall <ross.lagerwall@citrix.com>
    net: Fix usage of pskb_trim_rcsum

Yunjian Wang <wangyunjian@huawei.com>
    net: bridge: Fix ethernet header pointer before check skb forwardable


-------------

Diffstat:

 Makefile                                      |   4 +-
 arch/arc/include/asm/perf_event.h             |   3 +-
 arch/arc/lib/memset-archs.S                   |  40 ++++-
 arch/s390/kernel/early.c                      |   4 +-
 arch/s390/kernel/setup.c                      |   2 +
 arch/s390/kernel/smp.c                        |  12 +-
 arch/x86/kvm/x86.c                            |   3 +-
 arch/x86/lib/kaslr.c                          |   4 +-
 drivers/acpi/nfit/core.c                      |  57 +++++--
 drivers/char/mwave/mwavedd.c                  |   7 +
 drivers/input/joystick/xpad.c                 |   3 +
 drivers/input/misc/uinput.c                   |   5 +-
 drivers/irqchip/irq-gic-v3-its.c              |  25 ++--
 drivers/md/dm-thin-metadata.c                 |   4 +-
 drivers/md/dm-thin-metadata.h                 |   2 +-
 drivers/md/dm-thin.c                          |  10 +-
 drivers/mmc/host/Kconfig                      |   1 +
 drivers/net/can/dev.c                         |  27 ++--
 drivers/net/ppp/pppoe.c                       |   1 +
 drivers/nvme/target/rdma.c                    |  17 ++-
 drivers/s390/char/sclp_config.c               |   2 +
 drivers/staging/rtl8188eu/os_dep/usb_intf.c   |   1 +
 drivers/tty/n_hdlc.c                          |   1 +
 drivers/tty/serial/serial_core.c              |  12 +-
 drivers/tty/tty_io.c                          |   3 +-
 drivers/tty/vt/vt.c                           |   1 +
 drivers/usb/serial/pl2303.c                   |   1 +
 drivers/usb/serial/pl2303.h                   |   2 +
 drivers/usb/serial/usb-serial-simple.c        |   3 +-
 drivers/vhost/net.c                           |   3 +-
 drivers/vhost/vhost.c                         |  97 ++++++++++--
 drivers/vhost/vhost.h                         |   3 +-
 fs/btrfs/dev-replace.c                        |   9 +-
 fs/cifs/connect.c                             |  21 +++
 fs/cifs/smb2ops.c                             |  38 +++--
 fs/f2fs/node.c                                |   4 +-
 include/linux/compiler-clang.h                |  14 ++
 include/linux/compiler-gcc.h                  |   4 +
 include/linux/compiler-intel.h                |   4 +
 include/linux/overflow.h                      | 205 ++++++++++++++++++++++++++
 include/linux/skbuff.h                        |   1 +
 include/net/ip_fib.h                          |   2 +-
 net/bridge/br_forward.c                       |   9 +-
 net/bridge/br_netfilter_ipv6.c                |   1 +
 net/bridge/netfilter/nft_reject_bridge.c      |   1 +
 net/can/bcm.c                                 |  27 ++++
 net/ipv4/fib_frontend.c                       |   4 +-
 net/ipv4/fib_trie.c                           |  14 +-
 net/ipv4/inet_fragment.c                      |   2 +-
 net/ipv4/ip_input.c                           |   1 +
 net/openvswitch/flow_netlink.c                |   2 +-
 net/sched/sch_api.c                           |   3 +-
 sound/soc/codecs/rt5514-spi.c                 |   2 +
 sound/soc/intel/atom/sst-mfld-platform-pcm.c  |   8 +-
 tools/perf/util/unwind-libdw.c                |   4 +-
 tools/testing/selftests/x86/protection_keys.c |  41 ++++--
 56 files changed, 652 insertions(+), 129 deletions(-)


