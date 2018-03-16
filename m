Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtUWJmmUWtKhPGsXbigepgsksl6UeZUlRvxQMlABpf1CCbRmFr5Cr6C6NbO/knRV43S7up2
ARC-Seal: i=1; a=rsa-sha256; t=1521214514; cv=none;
        d=google.com; s=arc-20160816;
        b=nBTbkNlo8+ffCkl9ZH0l5hNWntn3rI/nfS9GG/UpkI0tiHQqZtCYHfiipIB4cl0HgG
         oZPxzhVOUdsJYg6d8LGaVzmssI3/nSDg8kH6S3YxG7T84wrfWL4Bb+ObCOIrSh2HDJYG
         lWq+2SA7bHc7HBsrq+yCVRHXxjNcdVPY/8ccfD8l06FL6KN96AHJWFf+1x4LythgCtlE
         UNzyola+5p7DaxXC2EIrTbBp/c8xZx5lVARG5HawGRVZdB0o62H2Uy4O1LAoddq92cUK
         zrrhuPS3hSPq4ZzAZtCm3+2F00auwbSq5aeU+SiBDzjrnBnrqE/H5NK1yAPQ5TokPV/+
         mCOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=o4K0rLNZ91uOXrc34ufC/JJeU0AdfH8JI8LEhukubyo=;
        b=OTFO0o98fTLXndzMkcVOu/wJeHipLrhMO28LP5VihVkQ/pzBEfeJPtzNuZJNvHDTX8
         SQ9jNBIp+4n924caamZJIkoheYBK9B5vT6OBLR/c3+pTb15c5PUgbx0XwZHsimbTr4QU
         72JZ+hBP9SK9b/yENNMz3ImKnqNnmBlBhRIasm58OG9ey6p6RbfsV7Zck1PHCMuiFRR3
         JBSZpoHsO+ZoZjTkrz3uzpFcCclNQjE/l3Y6eyvtzA1PHhcwWvNstC7QILjdD9tgD3NT
         ZkGUpHDCFSR4OUN+aYdYx56vD8/CgSmFfIV4jWJHW2fS2tX8xPCGtvh0RhkCQ3Vp5rsa
         hM7w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuahkh@osg.samsung.com,
	patches@kernelci.org,
	ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: [PATCH 4.14 000/109] 4.14.28-stable review
Date: Fri, 16 Mar 2018 16:22:29 +0100
Message-Id: <20180316152329.844663293@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.28-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.28-rc1
X-KernelTest-Deadline: 2018-03-18T15:23+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109030771020666?=
X-GMAIL-MSGID: =?utf-8?q?1595109030771020666?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.14.28 release.
There are 109 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Mar 18 15:22:53 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.28-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.28-rc1

Anusha Srivatsa <anusha.srivatsa@intel.com>
    drm/i915/glk: Disable Guc and HuC on GLK

Sinan Kaya <okaya@codeaurora.org>
    dmaengine: qcom_hidma: check pending interrupts

Arnd Bergmann <arnd@arndb.de>
    IB/mlx5: revisit -Wmaybe-uninitialized warning

Mimi Zohar <zohar@linux.vnet.ibm.com>
    ima: relax requiring a file signature for new files with zero length

Davidlohr Bueso <dave@stgolabs.net>
    locking/locktorture: Fix num reader/writer corner cases

SeongJae Park <sj38.park@gmail.com>
    rcutorture/configinit: Fix build directory error message

Mahesh Bandewar <maheshb@google.com>
    ipvlan: add L2 check for packets arriving via virtual devices

Christophe Leroy <christophe.leroy@c-s.fr>
    Fix misannotated out-of-line _copy_to_user()

Adrian Hunter <adrian.hunter@intel.com>
    mmc: mmc_test: Ensure command queue is disabled for testing

Dan Carpenter <dan.carpenter@oracle.com>
    ASoC: nuc900: Fix a loop timeout test

Horia Geantă <horia.geanta@nxp.com>
    crypto: caam/qi - use correct print specifier for size_t

Luca Coelho <luciano.coelho@intel.com>
    mac80211: remove BUG() when interface type is invalid

Adiel Aloni <adiel.aloni@intel.com>
    mac80211_hwsim: enforce PS_MANUAL_POLL to be set after PS_ENABLED

Chris Wilson <chris@chris-wilson.co.uk>
    agp/intel: Flush all chipset writes after updating the GGTT

Geert Uytterhoeven <geert+renesas@glider.be>
    arm64: dts: renesas: salvator-common: Add EthernetAVB PHY reset

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64: Don't trace irqs-off at interrupt return to soft-disabled context

Josh Poimboeuf <jpoimboe@redhat.com>
    powerpc/modules: Don't try to restore r2 after a sibling call

Yong Zhao <yong.zhao@amd.com>
    drm/amdkfd: Fix memory leaks in kfd topology

Stephen Hemminger <stephen@networkplumber.org>
    veth: set peer GSO values

John Fastabend <john.fastabend@gmail.com>
    net: sched: drop qdisc_reset from dev_graft_qdisc

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    virtio_net: Disable interrupts if napi_complete_done rescheduled napi

Gustavo A. R. Silva <garsilva@embeddedor.com>
    media: davinci: vpif_capture: add NULL check on devm_kzalloc return value

Dan Carpenter <dan.carpenter@oracle.com>
    media: cpia2: Fix a couple off by one bugs

Heinz Mauelshagen <heinzm@redhat.com>
    dm raid: fix raid set size revalidation

Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
    media: vsp1: Prevent suspending and resuming DRM pipelines

Xose Vazquez Perez <xose.vazquez@gmail.com>
    scsi: dh: add new rdac devices

Xose Vazquez Perez <xose.vazquez@gmail.com>
    scsi: devinfo: apply to HP XP the same flags as Hitachi VSP

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: core: scsi_get_device_flags_keyed(): Always return device flags

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Don't print "Link speed -1 no longer supported" messages.

Tobias Jordan <Tobias.Jordan@elektrobit.com>
    spi: sun6i: disable/unprepare clocks on remove

Julien BOIBESSOT <julien.boibessot@armadeus.com>
    tools/usbip: fixes build with musl libc toolchain

Ben Greear <greearb@candelatech.com>
    ath10k: fix invalid STS_CAP_OFFSET_MASK

Limin Zhu <liminzhu@marvell.com>
    mwifiex: cfg80211: do not change virtual interface during scan processing

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    clk: qcom: msm8916: fix mnd_width for codec_digcodec

Monk Liu <Monk.Liu@amd.com>
    drm/amdgpu:fix virtual dce bug

Sara Sharon <sara.sharon@intel.com>
    iwlwifi: mvm: avoid dumping assert log when device is stopped

Thomas Richter <tmricht@linux.vnet.ibm.com>
    perf annotate: Fix objdump comment parsing for Intel mov dissassembly

Thomas Richter <tmricht@linux.vnet.ibm.com>
    perf annotate: Fix unnecessary memory allocation for s390x

Takeshi Kihara <takeshi.kihara.df@renesas.com>
    pinctrl: sh-pfc: r8a7795-es1: Fix MOD_SEL1 bit[25:24] to 0x3 when using STP_ISEN_1_D

Fabrizio Castro <fabrizio.castro@bp.renesas.com>
    pinctrl: sh-pfc: r8a7791: Add can_clk function

Jernej Skrabec <jernej.skrabec@siol.net>
    drm/sun4i: Fix format mask in DE2 driver

Axel Lin <axel.lin@ingics.com>
    pwm: stmpe: Fix wrong register offset for hwpwm=2 case

Li Dongyang <dongyang.li@anu.edu.au>
    scsi: ses: don't ask for diagnostic pages repeatedly during probe

Monk Liu <Monk.Liu@amd.com>
    drm/amdgpu:fix random missing of FLR NOTIFY

Peter Ujfalusi <peter.ujfalusi@ti.com>
    dmaengine: amba-pl08x: Use vchan_terminate_vdesc() instead of desc_free

Peter Ujfalusi <peter.ujfalusi@ti.com>
    dmaengine: bcm2835-dma: Use vchan_terminate_vdesc() instead of desc_free

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    cpufreq: Fix governor module removal race

Manikanta Pubbisetty <mpubbise@qti.qualcomm.com>
    ath10k: update tdls teardown state to target

Peter Meerwald-Stadler <pmeerw@pmeerw.net>
    iio: health: max30102: Add power enable parameter to get_temp function

Stefan Brüns <stefan.bruens@rwth-aachen.de>
    iio: adc: ina2xx: Shift bus voltage register to mask flag bits

Philipp Zabel <p.zabel@pengutronix.de>
    drm/etnaviv: make THERMAL selectable

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    power: supply: ab8500_charger: Bail out in case of error in 'ab8500_charger_init_hw_registers()'

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    power: supply: ab8500_charger: Fix an error handling path

Tero Kristo <t-kristo@ti.com>
    clk: ti: clkctrl: add support for retrying failed init

Bjorn Andersson <bjorn.andersson@linaro.org>
    leds: pm8058: Silence pointer to integer size warning

Yossef Efraim <yossefe@mellanox.com>
    xfrm: Fix xfrm_replay_overflow_offload_esn

Eric W. Biederman <ebiederm@xmission.com>
    userns: Don't fail follow_automount based on s_user_ns

Jagdish Gediya <jagdish.gediya@nxp.com>
    mtd: nand: ifc: update bufnum mask for ver >= 2.0.0

Andrew F. Davis <afd@ti.com>
    ARM: dts: omap3-n900: Fix the audio CODEC's reset pin

Andrew F. Davis <afd@ti.com>
    ARM: dts: am335x-pepper: Fix the audio CODEC's reset pin

Sunil Goutham <sgoutham@cavium.com>
    net: thunderx: Set max queue count taking XDP_TX into account

Miquel Raynal <miquel.raynal@free-electrons.com>
    mtd: nand: fix interpretation of NAND_CMD_NONE in nand_command[_lp]()

Lorenzo Colitti <lorenzo@google.com>
    net: xfrm: allow clearing socket xfrm policies.

Alexey Khoroshilov <khoroshilov@ispras.ru>
    rtc: brcmstb-waketimer: fix error handling in brcmstb_waketmr_probe()

Michael Hennerich <michael.hennerich@analog.com>
    net: ieee802154: adf7242: Fix bug if defined DEBUG

Luis R. Rodriguez <mcgrof@kernel.org>
    test_firmware: fix setting old custom fw path back on exit

Colin Ian King <colin.king@canonical.com>
    crypto: cavium - fix memory leak on info

Pierre <pinaraf@pinaraf.info>
    crypto: ecc - Fix NULL pointer deref. on no default_rng

Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    sched: Stop resched_cpu() from sending IPIs to offline CPUs

Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    sched: Stop switched_to_rt() from sending IPIs to offline CPUs

Johan Hovold <johan@kernel.org>
    USB: ledtrig-usbport: fix of-node leak

Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
    typec: tcpm: fusb302: Resolve out of order messaging events

Colin Ian King <colin.king@canonical.com>
    staging: rtl8822be: fix missing null check on dev_alloc_skb return

Felix Kuehling <Felix.Kuehling@amd.com>
    drm/amdgpu: fix get_max_engine_clock_in_mhz

Simon Shields <simon@lineageos.org>
    ARM: dts: exynos: Correct Trats2 panel reset line

Yixun Lan <yixun.lan@amlogic.com>
    clk: meson: gxbb: fix wrong clock for SARADC/SANA

Simon Horman <horms+renesas@verge.net.au>
    ARM: dts: koelsch: Move cec_clock to root node

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    iwlwifi: mvm: rs: don't override the rate history in the search cycle

Jiri Kosina <jkosina@suse.cz>
    HID: elo: clear BTN_LEFT mapping

Hans de Goede <hdegoede@redhat.com>
    HID: multitouch: Only look at non touch fields in first packet of a frame

Ville Syrjälä <ville.syrjala@linux.intel.com>
    video/hdmi: Allow "empty" HDMI infoframes

Chris Wilson <chris@chris-wilson.co.uk>
    dma-buf/fence: Fix lock inversion within dma-fence-array

Jani Nikula <jani.nikula@intel.com>
    drm/edid: set ELD connector type in drm_edid_to_eld()

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "btrfs: use proper endianness accessors for super_copy"

Steffen Maier <maier@linux.vnet.ibm.com>
    dm mpath: fix passing integrity data

Greentime Hu <green.hu@gmail.com>
    earlycon: add reg-offset to physical address before mapping

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    serial: core: mark port as initialized in autoconfig

Nikola Ciprich <nikola.ciprich@linuxbox.cz>
    serial: 8250_pci: Add Brainboxes UC-260 4 port serial device

Roger Quadros <rogerq@ti.com>
    usb: dwc3: Fix lock-up on ID change during system suspend/resume

Xinyong <xinyong.fang@linux.alibaba.com>
    usb: gadget: f_fs: Fix use-after-free in ffs_fs_kill_sb()

Pete Zaitcev <zaitcev@kotori.zaitcev.us>
    usb: usbmon: Read text within supplied buffer size

Danilo Krummrich <danilokrummrich@dk-develop.de>
    usb: quirks: add control message delay for 1b1c:1b20

Colin Ian King <colin.king@canonical.com>
    usbip: vudc: fix null pointer dereference on udc->lock

Teijo Kinnunen <teijo.kinnunen@code-q.fi>
    USB: storage: Add JMicron bridge 152d:2567 to unusual_devs.h

Joel Fernandes <joelaf@google.com>
    staging: android: ashmem: Fix lockdep issue during llseek

Frank Mori Hess <fmh6jj@gmail.com>
    staging: comedi: fix comedi_nsamples_left.

Oliver Neukum <oneukum@suse.com>
    uas: fix comparison for error code

Jonas Danielsson <jonas@orbital-systems.com>
    tty/serial: atmel: add new version check for usart

Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
    serial: sh-sci: prevent lockup on full TTY buffers

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: fix endpoint context tracer output

Kai-Heng Feng <kai.heng.feng@canonical.com>
    xhci: Fix front USB ports on ASUS PRIME B350M-A

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    usb: host: xhci-rcar: add support for r8a77965

Hans de Goede <hdegoede@redhat.com>
    ASoC: rt5651: Fix regcache sync errors on resume

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: wm_adsp: For TLV controls only register TLV get/set

Fabio Estevam <fabio.estevam@nxp.com>
    ASoC: sgtl5000: Fix suspend/resume

Yong Deng <yong.deng@magewell.com>
    ASoC: sun4i-i2s: Fix RX slot number of SUN8I

H.J. Lu <hjl.tools@gmail.com>
    x86: Treat R_X86_64_PLT32 as R_X86_64_PC32

Andrew Lunn <andrew@lunn.ch>
    net: phy: Restore phy_resume() locking assumption

Russell King <rmk+kernel@armlinux.org.uk>
    net: phy: fix resume handling


-------------

Diffstat:

 Documentation/devicetree/bindings/usb/usb-xhci.txt |   1 +
 Makefile                                           |   4 +-
 arch/arm/boot/dts/am335x-pepper.dts                |   2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            |   2 +-
 arch/arm/boot/dts/omap3-n900.dts                   |   4 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts              |  12 +-
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |   1 +
 arch/powerpc/include/asm/code-patching.h           |   1 +
 arch/powerpc/kernel/entry_64.S                     |  10 +-
 arch/powerpc/kernel/module_64.c                    |  12 +-
 arch/powerpc/lib/code-patching.c                   |   5 +
 arch/x86/kernel/machine_kexec_64.c                 |   1 +
 arch/x86/kernel/module.c                           |   1 +
 arch/x86/tools/relocs.c                            |   3 +
 crypto/ecc.c                                       |   2 +-
 drivers/base/Kconfig                               |   1 +
 drivers/char/agp/intel-gtt.c                       |   2 +
 drivers/clk/meson/gxbb.c                           |   4 +-
 drivers/clk/qcom/gcc-msm8916.c                     |   1 +
 drivers/clk/ti/clkctrl.c                           |  12 +-
 drivers/cpufreq/cpufreq.c                          |   6 +
 drivers/crypto/caam/caamalg_qi.c                   |   6 +-
 drivers/crypto/cavium/cpt/cptvf_reqmanager.c       |   3 +-
 drivers/dma-buf/dma-fence-array.c                  |  14 ++-
 drivers/dma/amba-pl08x.c                           |  11 +-
 drivers/dma/bcm2835-dma.c                          |  10 +-
 drivers/dma/qcom/hidma_ll.c                        |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   7 +-
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c           |   4 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c              |  14 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |  10 ++
 drivers/gpu/drm/drm_edid.c                         |   9 +-
 drivers/gpu/drm/etnaviv/Kconfig                    |   9 ++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c              |   8 +-
 drivers/gpu/drm/i915/intel_guc_loader.c            |   9 --
 drivers/gpu/drm/i915/intel_huc.c                   |  11 --
 drivers/gpu/drm/sun4i/sun8i_mixer.h                |   2 +-
 drivers/hid/hid-elo.c                              |   6 +
 drivers/hid/hid-multitouch.c                       |  17 ++-
 drivers/iio/adc/ina2xx-adc.c                       |  26 +++--
 drivers/iio/health/max30102.c                      |  36 +++---
 drivers/infiniband/hw/mlx5/mr.c                    |   3 +
 drivers/leds/leds-pm8058.c                         |   2 +-
 drivers/md/dm-mpath.c                              |   5 +-
 drivers/md/dm-raid.c                               |  30 +++--
 drivers/media/platform/davinci/vpif_capture.c      |   2 +
 drivers/media/platform/vsp1/vsp1_drv.c             |  16 ++-
 drivers/media/usb/cpia2/cpia2_v4l.c                |   4 +-
 drivers/mmc/core/mmc_test.c                        |  11 +-
 drivers/mtd/nand/fsl_ifc_nand.c                    |   7 ++
 drivers/mtd/nand/nand_base.c                       |   9 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  10 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |   5 +
 drivers/net/ieee802154/adf7242.c                   |   4 +-
 drivers/net/ipvlan/ipvlan_core.c                   |   4 +
 drivers/net/phy/at803x.c                           |   4 -
 drivers/net/phy/phy.c                              |   9 +-
 drivers/net/phy/phy_device.c                       |  20 +++-
 drivers/net/veth.c                                 |   3 +
 drivers/net/virtio_net.c                           |   9 +-
 drivers/net/wireless/ath/ath10k/mac.c              |  10 ++
 drivers/net/wireless/ath/ath10k/wmi.h              |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c        |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |   6 +
 drivers/net/wireless/mac80211_hwsim.c              |  17 ++-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |   6 +
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c               |  22 +++-
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c           |   2 +-
 drivers/power/supply/ab8500_charger.c              |   6 +-
 drivers/pwm/pwm-stmpe.c                            |   2 +-
 drivers/rtc/rtc-brcmstb-waketimer.c                |  15 ++-
 drivers/scsi/scsi_devinfo.c                        |   9 +-
 drivers/scsi/scsi_dh.c                             |   5 +-
 drivers/scsi/ses.c                                 |  11 +-
 drivers/spi/spi-sun6i.c                            |   2 +-
 drivers/staging/android/ashmem.c                   |  15 ++-
 drivers/staging/comedi/drivers.c                   |   3 +-
 drivers/staging/rtlwifi/rtl8822be/fw.c             |   2 +
 drivers/staging/typec/fusb302/fusb302.c            |  21 +++-
 drivers/tty/serial/8250/8250_pci.c                 |  11 ++
 drivers/tty/serial/atmel_serial.c                  |   1 +
 drivers/tty/serial/earlycon.c                      |   3 +-
 drivers/tty/serial/serial_core.c                   |   2 +
 drivers/tty/serial/sh-sci.c                        |   2 +
 drivers/usb/core/ledtrig-usbport.c                 |   8 +-
 drivers/usb/core/message.c                         |   4 +
 drivers/usb/core/quirks.c                          |   3 +-
 drivers/usb/dwc3/core.c                            |   2 +-
 drivers/usb/gadget/function/f_fs.c                 |   1 -
 drivers/usb/host/xhci-pci.c                        |   3 +
 drivers/usb/host/xhci-rcar.c                       |   4 +
 drivers/usb/host/xhci.c                            |   3 +
 drivers/usb/host/xhci.h                            |  23 ++--
 drivers/usb/mon/mon_text.c                         | 126 +++++++++++++--------
 drivers/usb/storage/uas.c                          |   2 +-
 drivers/usb/storage/unusual_devs.h                 |   7 ++
 drivers/usb/usbip/vudc_sysfs.c                     |   8 +-
 drivers/video/hdmi.c                               |  51 +++++----
 fs/btrfs/sysfs.c                                   |   8 +-
 fs/btrfs/transaction.c                             |  20 ++--
 fs/namei.c                                         |   3 -
 include/linux/dma-fence-array.h                    |   3 +
 include/linux/phy.h                                |   1 +
 include/linux/usb/quirks.h                         |   3 +
 kernel/locking/locktorture.c                       |  76 +++++++------
 kernel/sched/core.c                                |   3 +-
 kernel/sched/rt.c                                  |   2 +-
 lib/usercopy.c                                     |   2 +-
 net/mac80211/iface.c                               |   2 +-
 net/sched/sch_generic.c                            |  28 +++--
 net/xfrm/xfrm_policy.c                             |   2 +-
 net/xfrm/xfrm_replay.c                             |   3 +-
 net/xfrm/xfrm_state.c                              |   7 ++
 security/integrity/ima/ima_appraise.c              |   3 +-
 sound/soc/codecs/rt5651.c                          |   1 +
 sound/soc/codecs/sgtl5000.c                        |  11 ++
 sound/soc/codecs/wm_adsp.c                         |  14 ++-
 sound/soc/nuc900/nuc900-ac97.c                     |   4 +-
 sound/soc/sunxi/sun4i-i2s.c                        |   2 +-
 tools/perf/arch/s390/annotate/instructions.c       |   3 +-
 tools/perf/util/annotate.c                         |   8 +-
 tools/testing/selftests/firmware/fw_filesystem.sh  |   5 +-
 .../testing/selftests/rcutorture/bin/configinit.sh |   2 +-
 tools/usb/usbip/src/usbipd.c                       |   2 +-
 124 files changed, 763 insertions(+), 345 deletions(-)
