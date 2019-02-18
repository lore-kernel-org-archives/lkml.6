Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EC6C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25048217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498952;
	bh=wVyI5+JR5etvjoRinOKbUfYP8GhtsNZCWS+qAnBvCoE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=02sB9A39hF8hgkcK3EVsb8cnQjJuWGhuBHSg2dNmm5YcTYkq45WV0PlcQi2HhKdUB
	 uWEY8I5Vuapx8IogPccTgPa+VnSQDBUfzn52gcD6a6sY7a6E0pldCdYEybcJPSXAYm
	 fmZ9UoKrqkceIs4LWwpY0W95nDUAeB8u6wFyOuLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391113AbfBROJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:09:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391090AbfBROJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:09:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 438752173C;
        Mon, 18 Feb 2019 14:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498946;
        bh=wVyI5+JR5etvjoRinOKbUfYP8GhtsNZCWS+qAnBvCoE=;
        h=From:To:Cc:Subject:Date:From;
        b=waiHayH3GrfdR1XF/BwCueAAua6E24UT58pIAUhNlOx9uAsdKr5OjS9gFJz3G5s8q
         d8ulL8u/3cAD8vIIE3RQ9Q5DWR2Fo5qJLHztZj399SS9OUhlEJs08WMzFPVVn3xVov
         wFiKIpgrOlq1FhRv40hR/7loQdFQrD7lSgoRqJVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 000/108] 3.18.135-stable review
Date:   Mon, 18 Feb 2019 14:42:56 +0100
Message-Id: <20190218133519.525507231@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.135-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.135-rc1
X-KernelTest-Deadline: 2019-02-20T13:35+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.18.135 release.
There are 108 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Feb 20 13:34:47 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.135-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.135-rc1

Christian Lamparter <chunkeey@gmail.com>
    pinctrl: msm: fix gpio-hog related boot issues

John Youn <johnyoun@synopsys.com>
    usb: dwc2: Remove unnecessary kfree

Eric Dumazet <edumazet@google.com>
    kaweth: use skb_cow_head() to deal with cloned skbs

James Hughes <james.hughes@raspberrypi.org>
    smsc95xx: Use skb_cow_head to deal with cloned skbs

Borislav Petkov <bp@suse.de>
    x86/a.out: Clear the dump structure initially

Eric W. Biederman <ebiederm@xmission.com>
    signal: Restore the stop PTRACE_EVENT_EXIT

Andreas Ziegler <andreas.ziegler@fau.de>
    tracing/uprobes: Fix output for multiple string arguments

Meelis Roos <mroos@linux.ee>
    alpha: Fix Eiger NR_IRQS to 128

Sergei Trofimovich <slyfox@gentoo.org>
    alpha: fix page fault handling for r16-r18 targets

Matti Kurkela <Matti.Kurkela@iki.fi>
    Input: elantech - enable 3rd button support on Fujitsu CELSIUS H780

Jonathan Bakker <xc-racer2@live.ca>
    Input: bma150 - register input device after setting private data

Manuel Reinhardt <manuel.rhdt@gmail.com>
    ALSA: usb-audio: Fix implicit fb endpoint setup by quirk

Ingo Molnar <mingo@kernel.org>
    perf/core: Fix impossible ring-buffer sizes warning

Ross Lagerwall <ross.lagerwall@citrix.com>
    cifs: Limit memory used by lock request calls to a page

Nicholas Mc Guire <hofrat@osadl.org>
    gpio: pl061: handle failed allocations

Linus Walleij <linus.walleij@linaro.org>
    ARM: dts: kirkwood: Fix polarity of GPIO fan lines

Peter Ujfalusi <peter.ujfalusi@ti.com>
    ARM: dts: da850-evm: Correct the sound card name

Linus Torvalds <torvalds@linux-foundation.org>
    Revert "exec: load_script: don't blindly truncate shebang string"

Andrzej Hajda <a.hajda@samsung.com>
    usb: host: ehci-msm: fix handling platform_get_irq result

Sven Eckelmann <sven@narfation.org>
    batman-adv: Force mac header to start of data on xmit

Sven Eckelmann <sven@narfation.org>
    batman-adv: Avoid WARN on net_device without parent in netns

Florian Westphal <fw@strlen.de>
    xfrm: refine validation of template and selector families

Ilya Dryomov <idryomov@gmail.com>
    libceph: avoid KEEPALIVE_PENDING races in ceph_con_keepalive()

Vladis Dronov <vdronov@redhat.com>
    HID: debug: fix the ring buffer implementation

Thomas Hellstrom <thellstrom@vmware.com>
    drm/vmwgfx: Return error code from vmw_execbuf_copy_fence_user

Thomas Hellstrom <thellstrom@vmware.com>
    drm/vmwgfx: Fix setting of dma masks

Tina Zhang <tina.zhang@intel.com>
    drm/modes: Prevent division by zero htotal

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: iop32x/n2100: fix PCI IRQ mapping

Aaro Koskinen <aaro.koskinen@iki.fi>
    MIPS: OCTEON: don't set octeon_dma_bar_type if PCI is disabled

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    debugfs: fix debugfs_rename parameter checking

Dan Carpenter <dan.carpenter@oracle.com>
    misc: vexpress: Off by one in vexpress_syscfg_exec()

Eric W. Biederman <ebiederm@xmission.com>
    signal: Better detection of synchronous signals

Eric W. Biederman <ebiederm@xmission.com>
    signal: Always notice exiting tasks

Martin Kepplinger <martin.kepplinger@ginzinger.com>
    mtd: rawnand: gpmi: fix MX28 bus master lockup problem

Gustavo A. R. Silva <gustavo@embeddedor.com>
    perf tests evsel-tp-sched: Fix bitwise operator

Mark Rutland <mark.rutland@arm.com>
    perf/core: Don't WARN() for impossible ring-buffer sizes

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel/uncore: Add Node ID mask

Peter Shier <pshier@google.com>
    KVM: nVMX: unconditionally cancel preemption timer in free_nested (CVE-2019-7221)

Paolo Bonzini <pbonzini@redhat.com>
    KVM: x86: work around leak of uninitialized stack contents (CVE-2019-7222)

James Bottomley <James.Bottomley@HansenPartnership.com>
    scsi: aic94xx: fix module loading

Gustavo A. R. Silva <gustavo@embeddedor.com>
    usb: gadget: udc: net2272: Fix bitwise and boolean operations

Bin Liu <b-liu@ti.com>
    usb: phy: am335x: fix race condition in _probe

Leonid Iziumtsev <leonid.iziumtsev@gmail.com>
    dmaengine: imx-dma: fix wrong callback invoke

Miklos Szeredi <mszeredi@redhat.com>
    fuse: handle zero sized retrieve correctly

Miklos Szeredi <mszeredi@redhat.com>
    fuse: decrement NR_WRITEBACK_TEMP on the right page

Jann Horn <jannh@google.com>
    fuse: call pipe_buf_release() under pipe lock

Charles Keepax <ckeepax@opensource.cirrus.com>
    ALSA: compress: Fix stop handling on compressed capture streams

Govindarajulu Varadarajan <gvaradar@cisco.com>
    enic: fix checksum validation for IPv6

Rundong Ge <rdong.ge@gmail.com>
    net: dsa: slave: Don't propagate flag changes on down slave interfaces

Florian Fainelli <f.fainelli@gmail.com>
    net: systemport: Fix WoL with password after deep sleep

Dan Carpenter <dan.carpenter@oracle.com>
    skge: potential memory corruption in skge_get_regs()

Eric Dumazet <edumazet@google.com>
    dccp: fool proof ccid_hc_[rt]x_parse_options()

Eduardo Valentin <edubezval@gmail.com>
    thermal: hwmon: inline helpers when CONFIG_THERMAL_HWMON is not set

Oleg Nesterov <oleg@redhat.com>
    exec: load_script: don't blindly truncate shebang string

Davidlohr Bueso <dave@stgolabs.net>
    fs/epoll: drop ovflist branch prediction

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    kernel/hung_task.c: break RCU locks based on jiffies

Finn Thain <fthain@telegraphics.com.au>
    block/swim3: Fix -EBUSY error when re-opening device after unmount

Wenwen Wang <wang6495@umn.edu>
    gdrom: fix a memory leak bug

Jia-Ju Bai <baijiaju1990@gmail.com>
    isdn: hisax: hfc_pci: Fix a possible concurrency use-after-free bug in HFCPCI_l1hw()

Junxiao Bi <junxiao.bi@oracle.com>
    ocfs2: don't clear bh uptodate for block read

Marc Zyngier <marc.zyngier@arm.com>
    scripts/decode_stacktrace: only strip base path when a prefix of the path

Kangjie Lu <kjlu@umn.edu>
    niu: fix missing checks of niu_pci_eeprom_read

Anton Ivanov <anton.ivanov@cambridgegreys.com>
    um: Avoid marking pages with "changed protection"

Ronnie Sahlberg <lsahlber@redhat.com>
    cifs: check ntwrk_buf_start for NULL before dereferencing it

Nathan Chancellor <natechancellor@gmail.com>
    crypto: ux500 - Use proper enum in hash_set_dma_transfer

Nathan Chancellor <natechancellor@gmail.com>
    crypto: ux500 - Use proper enum in cryp_set_dma_transfer

Kangjie Lu <kjlu@umn.edu>
    hwmon: (lm80) fix a missing check of bus read in lm80 probe

Kangjie Lu <kjlu@umn.edu>
    hwmon: (lm80) fix a missing check of the status of SMBus read

Chris Perl <cperl@janestreet.com>
    NFS: nfs_compare_mount_options always compare auth flavors.

Noralf Trønnes <noralf@tronnes.org>
    fbdev: fbcon: Fix unregister crash when more than one framebuffer

Kai-Heng Feng <kai.heng.feng@canonical.com>
    igb: Fix an issue that PME is not enabled during runtime suspend

Peter Rosin <peda@axentia.se>
    fbdev: fbmem: behave better with small rotated displays and many CPUs

Alexey Khoroshilov <khoroshilov@ispras.ru>
    video: clps711x-fb: release disp device node in probe()

Nathan Chancellor <natechancellor@gmail.com>
    drbd: Avoid Clang warning about pointless switch statment

Lars Ellenberg <lars.ellenberg@linbit.com>
    drbd: skip spurious timeout (ping-timeo) when failing promote

Lars Ellenberg <lars.ellenberg@linbit.com>
    drbd: disconnect, if the wrong UUIDs are attached on a connected peer

Roland Kammerer <roland.kammerer@linbit.com>
    drbd: narrow rcu_read_lock in drbd_sync_handshake

YueHaibing <yuehaibing@huawei.com>
    xfrm6_tunnel: Fix spi check in __xfrm6_tunnel_alloc_spi

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/uaccess: fix warning/error with access_ok()

Mark Rutland <mark.rutland@arm.com>
    arm64: KVM: Skip MMIO insn after emulation

Kai-Heng Feng <kai.heng.feng@canonical.com>
    memstick: Prevent memstick host from getting runtime suspended during card detection

Fabio Estevam <festevam@gmail.com>
    ASoC: fsl: Fix SND_SOC_EUKREA_TLV320 build error on i.MX8M

Arnd Bergmann <arnd@arndb.de>
    ARM: pxa: avoid section mismatch warning

Jan Kara <jack@suse.cz>
    udf: Fix BUG on corrupted inode

Yangtao Li <tiny.windzz@gmail.com>
    cpuidle: big.LITTLE: fix refcount leak

Anson Huang <anson.huang@nxp.com>
    clk: imx6sl: ensure MMDC CH0 handshake is bypassed

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
    sata_rcar: fix deferred probing

Jiong Wang <jiong.wang@netronome.com>
    mips: bpf: fix encoding bug for mm_srlv32_op

Russell King - ARM Linux <linux@armlinux.org.uk>
    ARM: dts: Fix OMAP4430 SDP Ethernet startup

Bart Van Assche <bvanassche@acm.org>
    timekeeping: Use proper seqcount initializer

Mathias Nyman <mathias.nyman@linux.intel.com>
    usb: hub: delay hub autosuspend if USB3 port is still link training

Zoran Markovic <zmarkovic@sierrawireless.com>
    smack: fix access permissions for keyring

Alexey Khoroshilov <khoroshilov@ispras.ru>
    media: DaVinci-VPBE: fix error handling in vpbe_initialize()

Mark Rutland <mark.rutland@arm.com>
    arm64: ftrace: don't adjust the LR value

J. Bruce Fields <bfields@redhat.com>
    nfsd4: fix crash on writing v4_end_grace before nfsd startup

Yunlei He <heyunlei@huawei.com>
    f2fs: move dir data flush to write checkpoint process

Yangtao Li <tiny.windzz@gmail.com>
    soc/tegra: Don't leak device tree node reference

Pu Wen <puwen@hygon.cn>
    perf tools: Add Hygon Dhyana support

Sami Tolvanen <samitolvanen@google.com>
    modpost: validate symbol names also in find_elf_symbol

Nathan Chancellor <natechancellor@gmail.com>
    ARM: OMAP2+: hwmod: Fix some section annotations

Renato Lui Geh <renatogeh@gmail.com>
    staging: iio: ad7780: update voltage on read

Matheus Tavares <matheus.bernardino@usp.br>
    staging:iio:ad2s90: Make probe handle spi_setup failure

Andy Duan <fugang.duan@nxp.com>
    serial: fsl_lpuart: clear parity enable bit when disable parity

Frank Rowand <frank.rowand@sony.com>
    powerpc/pseries: add of_node_put() in dlpar_detach_node()

Colin Ian King <colin.king@canonical.com>
    x86/PCI: Fix Broadcom CNB20LE unintended sign extension (redux)

Bob Peterson <rpeterso@redhat.com>
    dlm: Don't swamp the CPU with callbacks queued during recovery

Yufen Wang <wangyufen@huawei.com>
    ARM: 8808/1: kexec:offline panic_smp_self_stop CPU

Slawomir Stepien <sst@poczta.fm>
    staging: iio: adc: ad7280a: handle error from __ad7280_read32()


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/alpha/include/asm/irq.h                       |   6 +-
 arch/alpha/mm/fault.c                              |   2 +-
 arch/arm/boot/dts/da850-evm.dts                    |   2 +-
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |   4 +-
 arch/arm/boot/dts/omap4-sdp.dts                    |   1 +
 arch/arm/kernel/smp.c                              |  15 +++
 arch/arm/kvm/mmio.c                                |  11 +-
 arch/arm/mach-imx/clk-imx6sl.c                     |   6 +
 arch/arm/mach-integrator/impd1.c                   |   6 +-
 arch/arm/mach-iop32x/n2100.c                       |   3 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |   6 +-
 arch/arm/mach-pxa/cm-x300.c                        |   2 +-
 arch/arm/mach-pxa/littleton.c                      |   2 +-
 arch/arm/mach-pxa/zeus.c                           |   2 +-
 arch/arm64/kernel/entry-ftrace.S                   |   1 -
 arch/mips/include/uapi/asm/inst.h                  |   2 +-
 arch/mips/pci/pci-octeon.c                         |  10 +-
 arch/powerpc/include/asm/uaccess.h                 |   2 +-
 arch/powerpc/platforms/pseries/dlpar.c             |   2 +
 arch/um/include/asm/pgtable.h                      |   9 +-
 arch/x86/ia32/ia32_aout.c                          |   6 +-
 .../x86/kernel/cpu/perf_event_intel_uncore_snbep.c |   4 +-
 arch/x86/kvm/vmx.c                                 |   1 +
 arch/x86/kvm/x86.c                                 |   7 ++
 arch/x86/pci/broadcom_bus.c                        |   4 +-
 drivers/ata/sata_rcar.c                            |   4 +-
 drivers/block/drbd/drbd_nl.c                       |  15 +--
 drivers/block/drbd/drbd_receiver.c                 |  13 ++-
 drivers/block/swim3.c                              |   6 +-
 drivers/cdrom/gdrom.c                              |   1 +
 drivers/cpuidle/cpuidle-big_little.c               |   7 +-
 drivers/crypto/ux500/cryp/cryp_core.c              |   4 +-
 drivers/crypto/ux500/hash/hash_core.c              |   2 +-
 drivers/dma/imx-dma.c                              |   8 +-
 drivers/gpu/drm/drm_modes.c                        |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |   9 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |   2 +-
 drivers/hid/hid-debug.c                            | 121 ++++++++-------------
 drivers/hwmon/lm80.c                               |  26 +++--
 drivers/input/misc/bma150.c                        |   9 +-
 drivers/input/mouse/elantech.c                     |   9 ++
 drivers/isdn/hisax/hfc_pci.c                       |   2 +
 drivers/media/platform/davinci/vpbe.c              |   7 +-
 drivers/memstick/core/memstick.c                   |   3 +
 drivers/misc/vexpress-syscfg.c                     |   2 +-
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c              |  15 ++-
 drivers/net/ethernet/broadcom/bcmsysport.c         |  25 ++---
 drivers/net/ethernet/broadcom/bcmsysport.h         |   2 +
 drivers/net/ethernet/cisco/enic/enic_main.c        |   2 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   8 +-
 drivers/net/ethernet/marvell/skge.c                |   6 +-
 drivers/net/ethernet/sun/niu.c                     |  10 +-
 drivers/net/usb/kaweth.c                           |  18 +--
 drivers/net/usb/smsc95xx.c                         |  12 +-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |  23 +++-
 drivers/scsi/aic94xx/aic94xx_init.c                |   8 +-
 drivers/soc/tegra/common.c                         |   6 +-
 drivers/staging/iio/adc/ad7280a.c                  |  17 ++-
 drivers/staging/iio/adc/ad7780.c                   |   6 +-
 drivers/staging/iio/resolver/ad2s90.c              |   7 +-
 drivers/thermal/thermal_hwmon.h                    |   4 +-
 drivers/tty/serial/fsl_lpuart.c                    |   4 +
 drivers/usb/core/hub.c                             |  10 ++
 drivers/usb/dwc2/hcd.c                             |   1 -
 drivers/usb/gadget/udc/net2272.c                   |   2 +-
 drivers/usb/host/ehci-msm.c                        |   6 +-
 drivers/usb/phy/phy-am335x.c                       |   5 +-
 drivers/video/console/fbcon.c                      |   2 +-
 drivers/video/fbdev/clps711x-fb.c                  |   5 +-
 drivers/video/fbdev/core/fbmem.c                   |   8 +-
 fs/cifs/file.c                                     |   8 ++
 fs/cifs/readdir.c                                  |   9 +-
 fs/cifs/smb2file.c                                 |   4 +
 fs/debugfs/inode.c                                 |   7 ++
 fs/dlm/ast.c                                       |  10 ++
 fs/eventpoll.c                                     |   2 +-
 fs/f2fs/file.c                                     |   3 +
 fs/fuse/dev.c                                      |   5 +-
 fs/fuse/file.c                                     |   2 +-
 fs/nfs/super.c                                     |   3 +-
 fs/nfsd/nfsctl.c                                   |   2 +
 fs/ocfs2/buffer_head_io.c                          |   2 -
 fs/udf/inode.c                                     |   6 +
 include/linux/genl_magic_struct.h                  |   5 +-
 include/linux/hid-debug.h                          |   9 +-
 include/sound/compress_driver.h                    |   6 +-
 kernel/events/ring_buffer.c                        |   3 +
 kernel/hung_task.c                                 |   8 +-
 kernel/signal.c                                    |  61 ++++++++++-
 kernel/time/timekeeping.c                          |   4 +-
 kernel/trace/trace_uprobe.c                        |   9 +-
 net/batman-adv/hard-interface.c                    |   4 +-
 net/batman-adv/soft-interface.c                    |   2 +
 net/ceph/messenger.c                               |   5 +-
 net/dccp/ccid.h                                    |   4 +-
 net/dsa/slave.c                                    |  12 +-
 net/ipv6/xfrm6_tunnel.c                            |   3 +
 net/xfrm/xfrm_user.c                               |  13 ++-
 scripts/decode_stacktrace.sh                       |   2 +-
 scripts/mod/modpost.c                              |  50 +++++----
 security/smack/smack_lsm.c                         |  12 +-
 sound/soc/fsl/Kconfig                              |   2 +-
 sound/usb/pcm.c                                    |   9 +-
 tools/perf/arch/x86/util/kvm-stat.c                |   2 +-
 tools/perf/tests/evsel-tp-sched.c                  |   2 +-
 106 files changed, 575 insertions(+), 299 deletions(-)


