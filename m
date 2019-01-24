Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6BEC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D050218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358214;
	bh=LllID3vLfiVoGe2KVWNe5iphRFkujxUTRx4LzA0bXL8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GbnSMVAKEioFvlZ9nvD5VIYoGGxBU7kpe2P1evpgDxKMaVzbwrMUPdmWtxDP/e9Bk
	 GVlDSzLlc0ImQK+sLHiX5hKJN2cdDekOO8UMft7OGvS3fb9VL1KsFWDZUXOpaY4Ogb
	 obh9T276GloktxMZTwqUVF6uVlXc2zk2GKS5i1Y8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbfAXTaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:30:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:57630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731341AbfAXTaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:30:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2662218E2;
        Thu, 24 Jan 2019 19:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358210;
        bh=LllID3vLfiVoGe2KVWNe5iphRFkujxUTRx4LzA0bXL8=;
        h=From:To:Cc:Subject:Date:From;
        b=luNVGKqbesxhwGdIB+S4pjqX+tTRc2ImGZRdS5brj/6OI6wGG6U4R5YJR0pRYiXGP
         gdF6qmSGPhrdAt2cdDg3btck1vRiW6jskznEeCNqW34QMxf7hNlfVLvCrtfnYsHLO6
         M+Yo715G8Z7bj6Wghhea4FkWGR82mcnqxJOkumVk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/39] 4.9.153-stable review
Date:   Thu, 24 Jan 2019 20:20:03 +0100
Message-Id: <20190124190448.232316246@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.153-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.153-rc1
X-KernelTest-Deadline: 2019-01-26T19:04+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.153 release.
There are 39 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Jan 26 19:04:38 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.153-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.153-rc1

Dave Airlie <airlied@redhat.com>
    locking/qspinlock: Pull in asm/byteorder.h to ensure correct endianness

Corey Minyard <cminyard@mvista.com>
    ipmi:ssif: Fix handling of multi-part return messages

Michal Hocko <mhocko@suse.com>
    mm, proc: be more verbose about unstable VMA flags in /proc/<pid>/smaps

Brian Foster <bfoster@redhat.com>
    mm/page-writeback.c: don't break integrity writeback on ->writepage() error

Junxiao Bi <junxiao.bi@oracle.com>
    ocfs2: fix panic due to unrecovered local alloc

Qian Cai <cai@lca.pw>
    scsi: megaraid: fix out-of-bound array accesses

Kevin Barnett <kevin.barnett@microsemi.com>
    scsi: smartpqi: correct lun reset issues

Daniel Vetter <daniel.vetter@ffwll.ch>
    sysfs: Disable lockdep for driver bind/unbind files

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: bebob: fix model-id of unit for Apogee Ensemble

Nikos Tsironis <ntsironis@arrikto.com>
    dm snapshot: Fix excessive memory usage and workqueue stalls

Arnaldo Carvalho de Melo <acme@redhat.com>
    tools lib subcmd: Don't add the kernel sources to the include path

Nikos Tsironis <ntsironis@arrikto.com>
    dm kcopyd: Fix bug causing workqueue stalls

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf parse-events: Fix unchecked usage of strncpy()

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf svghelper: Fix unchecked usage of strncpy()

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix error with config term "pt=0"

Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
    tty/serial: do not free trasnmit buffer page under port lock

Jonas Danielsson <jonas@orbital-systems.com>
    mmc: atmel-mci: do not assume idle after atmci_request_end

Masahiro Yamada <yamada.masahiro@socionext.com>
    kconfig: fix memory leak when EOF is encountered in quotation

Masahiro Yamada <yamada.masahiro@socionext.com>
    kconfig: fix file name and line number of warn_ignored_character()

Lucas Stach <l.stach@pengutronix.de>
    clk: imx6q: reset exclusive gates on init

David Disseldorp <ddiss@suse.de>
    scsi: target: use consistent left-aligned ASCII INQUIRY data

yupeng <yupeng0921@gmail.com>
    net: call sk_dst_reset when set SO_DONTROUTE

Nathan Chancellor <natechancellor@gmail.com>
    media: firewire: Fix app_info parameter type in avc_ca{,_app}_info

Breno Leitao <leitao@debian.org>
    powerpc/pseries/cpuidle: Fix preempt warning

Breno Leitao <leitao@debian.org>
    powerpc/xmon: Fix invocation inside lock region

Joel Fernandes (Google) <joel@joelfernandes.org>
    pstore/ram: Do not treat empty buffers as valid

Daniel Santos <daniel.santos@pobox.com>
    jffs2: Fix use of uninitialized delayed_work, lockdep breakage

Chuck Lever <chuck.lever@oracle.com>
    rxe: IB_WR_REG_MR does not capture MR's iova field

Ondrej Mosnacek <omosnace@redhat.com>
    selinux: always allow mounting submounts

Anders Roxell <anders.roxell@linaro.org>
    arm64: perf: set suppress_bind_attrs flag to true

Maciej W. Rozycki <macro@linux-mips.org>
    MIPS: SiByte: Enable swiotlb for SWARM, LittleSur and BigSur

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: oxfw: add support for APOGEE duet FireWire

Anders Roxell <anders.roxell@linaro.org>
    serial: set suppress_bind_attrs flag only if builtin

Anders Roxell <anders.roxell@linaro.org>
    writeback: don't decrement wb->refcnt if !wb->bdi

Miroslav Lichvar <mlichvar@redhat.com>
    e1000e: allow non-monotonic SYSTIM readings

João Paulo Rechi Vita <jprvita@gmail.com>
    platform/x86: asus-wmi: Tell the EC the OS will handle the display off hotkey

David Ahern <dsahern@gmail.com>
    ipv6: Take rcu_read_lock in __inet6_bind for mapped addresses

David Ahern <dsahern@gmail.com>
    ipv6: Consider sk_bound_dev_if when binding a socket to a v4 mapped address

Kai-Heng Feng <kai.heng.feng@canonical.com>
    r8169: Add support for new Realtek Ethernet


-------------

Diffstat:

 Documentation/filesystems/proc.txt          |  4 +++-
 Makefile                                    |  4 ++--
 arch/arm64/kernel/perf_event.c              |  1 +
 arch/mips/Kconfig                           |  3 +++
 arch/mips/sibyte/common/Makefile            |  1 +
 arch/mips/sibyte/common/dma.c               | 14 ++++++++++++
 arch/powerpc/xmon/xmon.c                    | 18 +++++++++++----
 drivers/base/bus.c                          |  7 ++++--
 drivers/char/ipmi/ipmi_ssif.c               | 25 ++++++++++++++-------
 drivers/clk/imx/clk-imx6q.c                 |  6 ++++-
 drivers/cpuidle/cpuidle-pseries.c           |  8 ++++++-
 drivers/infiniband/sw/rxe/rxe_req.c         |  1 +
 drivers/md/dm-kcopyd.c                      | 19 +++++++++++-----
 drivers/md/dm-snap.c                        | 22 ++++++++++++++++++
 drivers/media/firewire/firedtv-avc.c        |  6 +++--
 drivers/media/firewire/firedtv.h            |  6 +++--
 drivers/mmc/host/atmel-mci.c                |  3 ++-
 drivers/net/ethernet/intel/e1000e/ptp.c     | 13 ++++++++---
 drivers/net/ethernet/realtek/r8169.c        |  2 ++
 drivers/platform/x86/asus-wmi.c             |  3 ++-
 drivers/scsi/megaraid/megaraid_sas_fp.c     |  2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c |  2 +-
 drivers/scsi/smartpqi/smartpqi_init.c       |  3 +++
 drivers/target/target_core_spc.c            | 17 +++++++++-----
 drivers/tty/serial/amba-pl011.c             |  2 ++
 drivers/tty/serial/pic32_uart.c             |  1 +
 drivers/tty/serial/serial_core.c            | 22 +++++++++++++-----
 drivers/tty/serial/xilinx_uartps.c          |  1 +
 fs/jffs2/super.c                            |  3 ++-
 fs/ocfs2/localalloc.c                       |  9 ++++++--
 fs/pstore/ram_core.c                        |  5 +++++
 include/asm-generic/qspinlock_types.h       |  2 ++
 include/linux/backing-dev-defs.h            |  8 +++++++
 mm/page-writeback.c                         | 35 +++++++++++++++++------------
 net/core/sock.c                             |  1 +
 net/ipv6/af_inet6.c                         | 14 +++++++++++-
 scripts/kconfig/zconf.l                     |  4 +++-
 security/selinux/hooks.c                    |  2 +-
 sound/firewire/Kconfig                      |  1 +
 sound/firewire/bebob/bebob.c                |  2 +-
 sound/firewire/oxfw/oxfw.c                  |  8 +++++++
 tools/lib/subcmd/Makefile                   |  2 --
 tools/perf/arch/x86/util/intel-pt.c         | 11 +++++++++
 tools/perf/util/parse-events.c              |  2 +-
 tools/perf/util/svghelper.c                 |  2 +-
 45 files changed, 256 insertions(+), 71 deletions(-)


