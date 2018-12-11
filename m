Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25091C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB34F2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543738;
	bh=WgxmQ+9iH8amCu4F0Ty7H3z69D4NhQzkBojErOE23Pw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=HiopxyqOAEptVL22z7P1Z3KsnxAMvwjwbqwN4lO1eaYGwwESlqTZDNtbV3TeCGrer
	 jcIqHauKNI13/rGQH9xc5esg5FscMMbQJBpnb9tPNk6A4RUdnfvS2eUSr2/tbhBeZh
	 kv1caphjVNHXVaeI0jT36oyZS4PGKlhupNRCDI1A=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB34F2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbeLKPzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:55:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730162AbeLKPze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:55:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAF61205C9;
        Tue, 11 Dec 2018 15:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543732;
        bh=WgxmQ+9iH8amCu4F0Ty7H3z69D4NhQzkBojErOE23Pw=;
        h=From:To:Cc:Subject:Date:From;
        b=CwuyivZZZRXvv+vrGHlmegxIHuGlj8bJVs0rFBtstzmiC+jTRbEEc1bzpZ6BQ3yXf
         YF8ZaS4tk+0fgVKn6NM6b8AnKGghpmfJyoq60NrbvZVxwOtCoyZWyx32Bo6T8649+Y
         b8g2I9Y1a2TCxDjzKpM0occcr2AQYK/4xjpIztk4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 000/118] 4.19.9-stable review
Date:   Tue, 11 Dec 2018 16:40:19 +0100
Message-Id: <20181211151644.216668863@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.9-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.9-rc1
X-KernelTest-Deadline: 2018-12-13T15:16+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.9 release.
There are 118 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Dec 13 15:16:10 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.9-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.9-rc1

Nic Soudée <nsoudee@gmail.com>
    HID: quirks: fix RetroUSB.com devices

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    mac80211: ignore NullFunc frames in the duplicate detection

Felix Fietkau <nbd@nbd.name>
    mac80211: fix reordering of buffered broadcast packets

Felix Fietkau <nbd@nbd.name>
    mac80211: ignore tx status for PS stations in ieee80211_tx_status_ext

Ben Greear <greearb@candelatech.com>
    mac80211: Clear beacon_int in ieee80211_do_stop

Yan-Hsuan Chuang <yhchuang@realtek.com>
    mac80211: fix GFP_KERNEL under tasklet context

Vasyl Vavrychuk <vasyl.vavrychuk@globallogic.com>
    mac80211_hwsim: Timer should be initialized before device registered

Jouni Malinen <jouni@codeaurora.org>
    cfg80211: Fix busy loop regression in ieee80211_ie_split_ric()

Dan Williams <dan.j.williams@intel.com>
    libnvdimm, pfn: Pad pfn namespaces relative to other regions

Macpaul Lin <macpaul@gmail.com>
    kgdboc: fix KASAN global-out-of-bounds bug in param_set_kgdboc_var()

Johan Hovold <johan@kernel.org>
    gnss: sirf: fix activation retry handling

Chanho Park <parkch98@gmail.com>
    tty: do not set TTY_IO_ERROR flag if console port

Peter Shih <pihsun@chromium.org>
    tty: serial: 8250_mtk: always resume the device in probe.

Dexuan Cui <decui@microsoft.com>
    Drivers: hv: vmbus: Offload the handling of channels to two workqueues

Eric Snowberg <eric.snowberg@oracle.com>
    x86/efi: Allocate e820 buffer before calling efi_exit_boot_service

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes/x86: Fix instruction patching corruption when copying more than one RIP-relative instruction

Chris Wilson <chris@chris-wilson.co.uk>
    drm/i915: Downgrade Gen9 Plane WM latency error

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/gmc8: always load MC firmware in the driver

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/gmc8: update MC firmware for polaris

Robert Foss <robert.foss@collabora.com>
    drm/msm: Move fence put to where failure occurs

Daniel Vetter <daniel.vetter@ffwll.ch>
    drm/lease: Send a distinct uevent

Junwei Zhang <Jerry.Zhang@amd.com>
    drm/amdgpu: update mc firmware image for polaris12 variants

Pan Bian <bianpan2016@163.com>
    crypto: do not free algorithm before using

Young Xiao <YangX92@hotmail.com>
    Revert commit ef9209b642f "staging: rtl8723bs: Fix indenting errors and an off-by-one mistake in core/rtw_mlme_ext.c"

Young Xiao <YangX92@hotmail.com>
    staging: rtl8712: Fix possible buffer overrun

Paulo Alcantara <palcantara@suse.com>
    cifs: Fix separator when building path from dentry

Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
    Revert "x86/e820: put !E820_TYPE_RAM regions into memblock.reserved"

Sasha Levin <sashal@kernel.org>
    arm64: dts: rockchip: remove vdd_log from rock960 to fix a stability issues

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Prevent U1/U2 link pm states if exit latency is too long

Sandeep Singh <sandeep.singh@amd.com>
    xhci: workaround CSS timeout on AMD SNPS 3.0 xHC

Kees Cook <keescook@chromium.org>
    ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE

Bin Liu <b-liu@ti.com>
    dmaengine: cppi41: delete channel from pending list when stop channel

Lucas Stach <l.stach@pengutronix.de>
    dmaengine: imx-sdma: use GFP_NOWAIT for dma descriptor allocations

Lucas Stach <l.stach@pengutronix.de>
    dmaengine: imx-sdma: implement channel termination via worker

Lucas Stach <l.stach@pengutronix.de>
    Revert "dmaengine: imx-sdma: alloclate bd memory from dma pool"

Lucas Stach <l.stach@pengutronix.de>
    Revert "dmaengine: imx-sdma: Use GFP_NOWAIT for dma allocations"

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    dmaengine: dw: Fix FIFO size for Intel Merrifield

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Fix leak of krb5p encode pages

Will Deacon <will.deacon@arm.com>
    arm64: hibernate: Avoid sending cross-calling with interrupts disabled

Stefan Hajnoczi <stefanha@redhat.com>
    vhost/vsock: fix use-after-free in network stack callers

Halil Pasic <pasic@linux.ibm.com>
    virtio/s390: fix race in ccw_io_helper()

Halil Pasic <pasic@linux.ibm.com>
    virtio/s390: avoid race on vcdev->config

Helge Deller <deller@gmx.de>
    parisc: Enable -ffunction-sections for modules on 32-bit kernel

Enric Balletbo i Serra <enric.balletbo@collabora.com>
    Revert "mfd: cros_ec: Use devm_kzalloc for private data"

Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
    media: dvb-pll: don't re-validate tuner frequencies

Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
    media: dvb-pll: fix tuner frequency ranges

Hans Verkuil <hverkuil@xs4all.nl>
    media: vicodec: fix memchr() kernel oops

Hans Verkuil <hverkuil@xs4all.nl>
    media: gspca: fix frame overflow error

Chris Chiu <chiu@endlessm.com>
    ALSA: hda/realtek: Fix mic issue on Acer AIO Veriton Z4860G/Z6860G

Chris Chiu <chiu@endlessm.com>
    ALSA: hda/realtek: Fix mic issue on Acer AIO Veriton Z4660G

Chris Chiu <chiu@endlessm.com>
    ALSA: hda/realtek - Add support for Acer Aspire C24-860 headset mic

Chris Chiu <chiu@endlessm.com>
    ALSA: hda/realtek: ALC286 mic and headset-mode fixups for Acer Aspire U27-880

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/realtek - Fix speaker output regression on Thinkpad T570

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix interval evaluation with openmin/max

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Call snd_pcm_unlink() conditionally at closing

Chanho Min <chanho.min@lge.com>
    ALSA: pcm: Fix starvation on down_write_nonblock()

Kai-Heng Feng <kai.heng.feng@canonical.com>
    ALSA: hda: Add support for AMD Stoney Ridge

Hui Peng <benquike@gmail.com>
    ALSA: usb-audio: Fix UAF decrement if card has no live interfaces in card.c

Tony Das <tdas444@gmail.com>
    ALSA: usb-audio: Add SMSL D1 to quirks for native DSD support

Johan Hovold <johan@kernel.org>
    USB: serial: console: fix reported terminal settings

Mathias Payer <mathias.payer@nebelwelt.net>
    USB: check usb_get_extra_descriptor for proper size

Alexander Theissen <alex.theissen@me.com>
    usb: appledisplay: Add 27" Apple Cinema Display

Harry Pan <harry.pan@intel.com>
    usb: quirk: add no-LPM quirk on SanDisk Ultra Flair device

Yangtao Li <tiny.windzz@gmail.com>
    net: amd: add missing of_node_put()

Hangbin Liu <liuhangbin@gmail.com>
    team: no need to do team_notify_peers or team_mcast_rejoin when disabling port

Thomas Falcon <tlfalcon@linux.ibm.com>
    ibmvnic: Update driver queues after change in ring size support

Thomas Falcon <tlfalcon@linux.ibm.com>
    ibmvnic: Fix RX queue buffer cleanup

Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
    flexfiles: use per-mirror specified stateid for IO

Olga Kornievskaia <kolga@netapp.com>
    NFSv4.2 copy do not allocate memory under the lock

Pan Bian <bianpan2016@163.com>
    iommu/vt-d: Use memunmap to free memremap

Vincent Chen <vincentc@andestech.com>
    net: faraday: ftmac100: remove netif_running(netdev) check before disabling interrupts

David Abdurachmanov <david.abdurachmanov@gmail.com>
    riscv: fix warning in arch/riscv/include/asm/module.h

Juliet Kim <julietk@linux.vnet.ibm.com>
    net/ibmnvic: Fix deadlock problem in reset

Denis Bolotin <denis.bolotin@cavium.com>
    qed: Fix QM getters to always return a valid pq

Denis Bolotin <denis.bolotin@cavium.com>
    qed: Fix bitmap_weight() check

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4: Fix a NFSv4 state manager deadlock

Arthur Kiyanovski <akiyano@amazon.com>
    net: ena: fix crash during failed resume from hibernation

Thor Thayer <thor.thayer@linux.intel.com>
    mtd: spi-nor: Fix Cadence QSPI page fault kernel panic

Kai-Heng Feng <kai.heng.feng@canonical.com>
    HID: multitouch: Add pointstick support for Cirque Touchpad

David Herrmann <dh.herrmann@gmail.com>
    Revert "HID: uhid: use strlcpy() instead of strncpy()"

Dave Gerlach <d-gerlach@ti.com>
    cpufreq: ti-cpufreq: Only register platform_device when supported

Olof Johansson <olof@lixom.net>
    mtd: rawnand: qcom: Namespace prefix some commands

Brenda J. Butler <bjb@mojatatu.com>
    tc-testing: tdc.py: Guard against lack of returncode in executed command

Lucas Bates <lucasb@mojatatu.com>
    tc-testing: tdc.py: ignore errors when decoding stdout/stderr

Bartosz Golaszewski <brgl@bgdev.pl>
    gpio: mockup: fix indicated direction

Robert Jarzmik <robert.jarzmik@free.fr>
    gpio: pxa: fix legacy non pinctrl aware builds again

Andrew Morton <akpm@linux-foundation.org>
    drivers/net/ethernet/qlogic/qed/qed_rdma.h: fix typo

Aya Levin <ayal@mellanox.com>
    net/mlx4: Fix UBSAN warning of signed integer overflow

Tariq Toukan <tariqt@mellanox.com>
    net/mlx4_core: Fix uninitialized variable compilation warning

Jack Morgenstein <jackm@dev.mellanox.co.il>
    net/mlx4_core: Zero out lkey field in SW2HW_MPT fw command

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Support amdgpu "max bpc" connector property (v2)

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amdgpu: Add amdgpu "max bpc" connector property (v2)

Vasundhara Volam <vasundhara-v.volam@broadcom.com>
    bnxt_en: Fix filling time in bnxt_fill_coredump_record()

James Smart <jsmart2021@gmail.com>
    nvme-fc: resolve io failures during connect

Ursula Braun <ubraun@linux.ibm.com>
    s390/ism: clear dmbe_mask bit before SMC IRQ handling

Shen Jing <jingx.shen@intel.com>
    Revert "usb: gadget: ffs: Fix BUG when userland exits with submitted AIO transfers"

Dan Carpenter <dan.carpenter@oracle.com>
    usb: dwc2: pci: Fix an error code in probe

Denis Bolotin <denis.bolotin@cavium.com>
    qed: Fix reading wrong value in loop condition

Michal Kalderon <michal.kalderon@cavium.com>
    qed: Fix rdma_info structure allocation

Denis Bolotin <denis.bolotin@cavium.com>
    qed: Fix overriding offload_tc by protocols without APP TLV

Denis Bolotin <denis.bolotin@cavium.com>
    qed: Fix PTT leak in qed_drain()

Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
    bnx2x: Assign unique DMAE channel number for FW DMAE transactions.

Filippo Sironi <sironi@amazon.de>
    amd/iommu: Fix Guest Virtual APIC Log Tail Address Register

Sven Eckelmann <sven@narfation.org>
    batman-adv: Expand merged fragment buffer for full packet

Sven Eckelmann <sven@narfation.org>
    batman-adv: Use explicit tvlv padding for ELP packets

Benson Leung <bleung@chromium.org>
    HID: input: Ignore battery reported by Symbol DS4308

Colin Ian King <colin.king@canonical.com>
    test_firmware: fix error return getting clobbered

Fabrizio Castro <fabrizio.castro@bp.renesas.com>
    can: rcar_can: Fix erroneous registration

YueHaibing <yuehaibing@huawei.com>
    can: ucan: remove set but not used variable 'udev'

Wei Li <liwei213@huawei.com>
    scsi: ufs: Fix hynix ufs bug with quirk on hi36xx SoC

Geert Uytterhoeven <geert+renesas@glider.be>
    iommu/ipmmu-vmsa: Fix crash on early domain free

Arnd Bergmann <arnd@arndb.de>
    mt76: fix building without CONFIG_LEDS_CLASS

Rafał Miłecki <rafal@milecki.pl>
    brcmutil: really fix decoding channel info for 160 MHz bandwidth

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Fix NULL pointer dereference in prq_event_thread()

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: ipu3-cio2: Unregister device nodes first, then release resources

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: omap3isp: Unregister media device as first

Hans Verkuil <hverkuil@xs4all.nl>
    media: cec: check for non-OK/NACK conditions while claiming a LA

Hans Verkuil <hverkuil@xs4all.nl>
    media: vicodec: lower minimum height to 360


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/probes/kprobes/opt-arm.c                  |   2 +-
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts      |  12 --
 arch/arm64/kernel/hibernate.c                      |   2 +-
 arch/parisc/Makefile                               |   7 +
 arch/riscv/include/asm/module.h                    |   1 +
 arch/x86/boot/compressed/eboot.c                   |  65 ++++---
 arch/x86/kernel/e820.c                             |  15 +-
 arch/x86/kernel/kprobes/opt.c                      |   2 +-
 crypto/cbc.c                                       |   6 +-
 crypto/cfb.c                                       |   6 +-
 crypto/pcbc.c                                      |   6 +-
 drivers/cpufreq/ti-cpufreq.c                       |  26 ++-
 drivers/dma/dw/core.c                              |   6 +-
 drivers/dma/imx-sdma.c                             |  69 +++++---
 drivers/dma/ti/cppi41.c                            |  16 +-
 drivers/gnss/sirf.c                                |   6 +-
 drivers/gpio/gpio-mockup.c                         |   6 +-
 drivers/gpio/gpio-pxa.c                            |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |   7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |   2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |  44 +++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  16 ++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   1 +
 drivers/gpu/drm/drm_internal.h                     |   2 +
 drivers/gpu/drm/drm_lease.c                        |   2 +-
 drivers/gpu/drm/drm_sysfs.c                        |  10 ++
 drivers/gpu/drm/i915/intel_pm.c                    |   4 +-
 drivers/gpu/drm/msm/msm_gem_submit.c               |  15 +-
 drivers/hid/hid-ids.h                              |   8 +
 drivers/hid/hid-input.c                            |   3 +
 drivers/hid/hid-multitouch.c                       |   6 +
 drivers/hid/hid-quirks.c                           |   2 +
 drivers/hid/uhid.c                                 |  13 +-
 drivers/hv/channel_mgmt.c                          | 189 ++++++++++++++-------
 drivers/hv/connection.c                            |  24 ++-
 drivers/hv/hyperv_vmbus.h                          |   7 +
 drivers/iommu/amd_iommu_init.c                     |   3 +-
 drivers/iommu/intel-iommu.c                        |   2 +-
 drivers/iommu/intel-svm.c                          |   2 +-
 drivers/iommu/ipmmu-vmsa.c                         |   3 +
 drivers/media/cec/cec-adap.c                       |  47 +++--
 drivers/media/dvb-frontends/dvb-pll.c              | 106 ++++++------
 drivers/media/pci/intel/ipu3/ipu3-cio2.c           |   4 +-
 drivers/media/platform/omap3isp/isp.c              |   3 +-
 drivers/media/platform/vicodec/vicodec-core.c      |   5 +-
 drivers/media/usb/gspca/gspca.c                    |  11 +-
 drivers/mfd/cros_ec_dev.c                          |   8 +-
 drivers/mtd/nand/raw/qcom_nandc.c                  |  32 ++--
 drivers/mtd/spi-nor/cadence-quadspi.c              |  19 ++-
 drivers/net/can/rcar/rcar_can.c                    |   5 +-
 drivers/net/can/usb/ucan.c                         |   3 -
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |   2 +-
 drivers/net/ethernet/amd/sunlance.c                |   4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |   7 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c     |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   4 +-
 drivers/net/ethernet/faraday/ftmac100.c            |   7 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |  72 ++++----
 drivers/net/ethernet/ibm/ibmvnic.h                 |   2 +-
 drivers/net/ethernet/mellanox/mlx4/alloc.c         |   2 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4.h          |   4 +-
 drivers/net/ethernet/mellanox/mlx4/mr.c            |   1 +
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c         |  14 +-
 drivers/net/ethernet/qlogic/qed/qed_dev.c          |  44 ++++-
 drivers/net/ethernet/qlogic/qed/qed_int.c          |   2 +
 drivers/net/ethernet/qlogic/qed/qed_main.c         |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_rdma.c         |  50 +++---
 drivers/net/ethernet/qlogic/qed/qed_rdma.h         |   5 +
 drivers/net/team/team.c                            |   2 -
 .../net/wireless/broadcom/brcm80211/brcmutil/d11.c |   3 +
 drivers/net/wireless/mac80211_hwsim.c              |   8 +-
 drivers/net/wireless/mediatek/mt76/Kconfig         |   6 +
 drivers/net/wireless/mediatek/mt76/mac80211.c      |   8 +-
 drivers/net/wireless/mediatek/mt76/mt76x2_init.c   |   6 +-
 drivers/nvdimm/nd-core.h                           |   2 +
 drivers/nvdimm/pfn_devs.c                          |  64 ++++---
 drivers/nvdimm/region_devs.c                       |  41 +++++
 drivers/nvme/host/fc.c                             |  73 ++++++--
 drivers/s390/net/ism_drv.c                         |   2 +-
 drivers/s390/virtio/virtio_ccw.c                   |  17 +-
 drivers/scsi/ufs/ufs-hisi.c                        |   9 +
 drivers/scsi/ufs/ufs_quirks.h                      |   6 +
 drivers/scsi/ufs/ufshcd.c                          |   2 +
 drivers/staging/rtl8712/mlme_linux.c               |   2 +-
 drivers/staging/rtl8712/rtl871x_mlme.c             |   2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      |   2 +-
 drivers/tty/serial/8250/8250_mtk.c                 |  16 +-
 drivers/tty/serial/kgdboc.c                        |   4 +-
 drivers/tty/tty_io.c                               |  11 +-
 drivers/tty/tty_port.c                             |   3 +-
 drivers/usb/core/hub.c                             |   2 +-
 drivers/usb/core/quirks.c                          |   4 +
 drivers/usb/core/usb.c                             |   6 +-
 drivers/usb/dwc2/pci.c                             |   1 +
 drivers/usb/gadget/function/f_fs.c                 |  26 +--
 drivers/usb/host/hwa-hc.c                          |   2 +-
 drivers/usb/host/xhci-pci.c                        |   4 +
 drivers/usb/host/xhci.c                            |  42 ++++-
 drivers/usb/host/xhci.h                            |   3 +
 drivers/usb/misc/appledisplay.c                    |   1 +
 drivers/usb/serial/console.c                       |   2 +-
 drivers/vhost/vsock.c                              |  57 ++++---
 fs/cifs/dir.c                                      |   2 +-
 fs/nfs/callback_proc.c                             |  22 +--
 fs/nfs/flexfilelayout/flexfilelayout.c             |  21 +--
 fs/nfs/flexfilelayout/flexfilelayout.h             |   4 +
 fs/nfs/flexfilelayout/flexfilelayoutdev.c          |  19 +++
 fs/nfs/nfs42proc.c                                 |  19 ++-
 fs/nfs/nfs4_fs.h                                   |   2 +
 fs/nfs/nfs4state.c                                 |  16 +-
 include/linux/hyperv.h                             |   7 +
 include/linux/tty.h                                |   1 +
 include/linux/usb.h                                |   4 +-
 include/sound/pcm_params.h                         |   4 +-
 lib/test_firmware.c                                |   1 +
 net/batman-adv/bat_v_elp.c                         |   6 +-
 net/batman-adv/fragmentation.c                     |   2 +-
 net/mac80211/iface.c                               |   2 +
 net/mac80211/rx.c                                  |   5 +-
 net/mac80211/status.c                              |   2 +
 net/mac80211/tx.c                                  |   4 +-
 net/sunrpc/auth_gss/auth_gss.c                     |   4 +
 net/wireless/util.c                                |   2 +
 sound/core/pcm_native.c                            |  14 +-
 sound/pci/hda/hda_intel.c                          |   4 +
 sound/pci/hda/patch_realtek.c                      |  27 +++
 sound/usb/card.c                                   |   5 +-
 sound/usb/quirks.c                                 |   1 +
 tools/testing/selftests/tc-testing/tdc.py          |  18 +-
 130 files changed, 1178 insertions(+), 571 deletions(-)


