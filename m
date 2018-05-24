Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqgipybCIrD57mPvPf19DIMhtNoTeR+XDKYCU3tWwUnyRdVdTHt61XPfky42PSQYmWJJPlv
ARC-Seal: i=1; a=rsa-sha256; t=1527156006; cv=none;
        d=google.com; s=arc-20160816;
        b=TWZAwdi4MCO1s9pA22Goyt2srlR60qc2oog+OBMbU9V1wKMkvKQijo2gq6Jv7MV/3Q
         rbqrS+E1f6xYk8t4/ogLkovuhfFdaTV22ozW6Qu+pL8lVsJMMabjpfcTZdsLM/YHVOSb
         knw2jUPwmzggH8nRuFe3uqawusQi9h6cpohV3gg4fN2kNS01glbT1AqmhJY4MzZ26fjU
         HucH/TYWzPuY4j0O+9tkMMrgFMPUj1ZqEN62WvKo2sJV8+xyyT8d8Poi6GiOgwETUlL6
         mHtQCeYwPxaSK5rhivS0SVx1RIHFNehKrtRCIzvgCALz0fxNPy9h27LXR07OAB7uHWVg
         2TMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=DUZwX4vOn5GBdt4IaqTZE1Zxxt5jiCicE1sTJ121OGM=;
        b=P7Wiw73w0awY/OM5RSt6ur9eQ6gS81Mzj504H74lJyzJijNWEugibrC3o/c9v9S3LR
         LeeYGJH6lmP7+Teh3/UpnivxaFv0GpG9sgxSRXnG26TN1j8njkMyRkixIT6y5uosaQ5L
         6/Q1BzN8CW64moZY5xn/jrM68Q2R1T+LN7OISvxxO5qzFWJKF8WJn92kmoDzyEWNUNIE
         LPwRLFoYPovpNfCf28aqX5UQkAf4LUJvQ8eTEMXnRtPjDf3B7y6ZwAZIKuxDuZ8EvI6v
         74QYOEt0v2Ls6ceHu1kjZ5LDtFAUNRQxUgvJHh3asDretkp/jHA58bd7XBonNZeioIE1
         F6nA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LaL3a96c;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LaL3a96c;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: [PATCH 4.16 000/161] 4.16.12-stable review
Date: Thu, 24 May 2018 11:37:05 +0200
Message-Id: <20180524093018.331893860@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.12-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.16.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.16.12-rc1
X-KernelTest-Deadline: 2018-05-26T09:30+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601339136054826375?=
X-GMAIL-MSGID: =?utf-8?q?1601339136054826375?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.16.12 release.
There are 161 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat May 26 09:29:22 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.12-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.16.12-rc1

James Hogan <jhogan@kernel.org>
    rtc: goldfish: Add missing MODULE_LICENSE

Alexandre Belloni <alexandre.belloni@bootlin.com>
    rtc: rp5c01: fix possible race condition

Colin Ian King <colin.king@canonical.com>
    rtc: tx4939: avoid unintended sign extension on a 24 bit shift

Alexandre Belloni <alexandre.belloni@bootlin.com>
    rtc: m41t80: fix race conditions

Alexandre Belloni <alexandre.belloni@bootlin.com>
    rtc: rk808: fix possible race condition

Alexandre Belloni <alexandre.belloni@bootlin.com>
    rtc: hctosys: Ensure system time doesn't overflow time_t

Bryan O'Donoghue <pure.logic@nexus-software.ie>
    rtc: snvs: Fix usage of snvs_rtc_enable

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    serial: altera: ensure port->regshift is honored consistently

Vignesh R <vigneshr@ti.com>
    serial: 8250: Don't service RX FIFO if interrupts are disabled

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: arc_uart: Fix out-of-bounds access through DT alias

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: fsl_lpuart: Fix out-of-bounds access through DT alias

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: imx: Fix out-of-bounds access through serial port index

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: mxs-auart: Fix out-of-bounds access through serial port index

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: samsung: Fix out-of-bounds access through serial port index

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: sh-sci: Fix out-of-bounds access through DT alias

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: xuartps: Fix out-of-bounds access through DT alias

Gabriel Matni <gabriel.matni@exfo.com>
    serial: mvebu-uart: fix tx lost characters

Colin Ian King <colin.king@canonical.com>
    media: cx25821: prevent out-of-bounds read on array card

Hans Verkuil <hverkuil@xs4all.nl>
    media: vivid: fix incorrect capabilities for radio

Masami Hiramatsu <mhiramat@kernel.org>
    media: vb2: Fix videobuf2 to map correct area

Kieran Bingham <kieran.bingham@ideasonboard.com>
    media: i2c: adv748x: fix HDMI field heights

Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
    media: v4l: vsp1: Fix display stalls when requesting too many inputs

Brad Love <brad@nextdimension.cc>
    media: em28xx: Add Hauppauge SoloHD/DualHD bulk models

Brad Love <brad@nextdimension.cc>
    media: lgdt3306a: Fix a double kfree on i2c device remove

Arnd Bergmann <arnd@arndb.de>
    media: s3c-camif: fix out-of-bounds array access

Brad Love <brad@nextdimension.cc>
    media: cx23885: Set subdev host data to clk_freq pointer

Brad Love <brad@nextdimension.cc>
    media: cx23885: Override 888 ImpactVCBe crystal frequency

Akinobu Mita <akinobu.mita@gmail.com>
    media: ov5645: add missing of_node_put() in error path

Jerome Brunet <jbrunet@baylibre.com>
    clk: meson: axg: add the fractional part of the fixed_pll

Yixun Lan <yixun.lan@amlogic.com>
    clk: meson: axg: fix the od shift of the sys_pll

Andrzej Hajda <a.hajda@samsung.com>
    clk: samsung: exynos3250: Fix PLL rates

Andrzej Hajda <a.hajda@samsung.com>
    clk: samsung: exynos5250: Fix PLL rates

Andrzej Hajda <a.hajda@samsung.com>
    clk: samsung: exynos5433: Fix PLL rates

Andrzej Hajda <a.hajda@samsung.com>
    clk: samsung: exynos5260: Fix PLL rates

Andrzej Hajda <a.hajda@samsung.com>
    clk: samsung: exynos7: Fix PLL rates

Andrzej Hajda <a.hajda@samsung.com>
    clk: samsung: s3c2410: Fix PLL rates

Shawn Lin <shawn.lin@rock-chips.com>
    clk: rockchip: Prevent calculating mmc phase if clock rate is zero

Marcel Ziswiler <marcel@ziswiler.com>
    clk: tegra: Fix pll_u rate configuration

Arnd Bergmann <arnd@arndb.de>
    clk: hisilicon: mark wdt_mux_p[] as const

Shawn Lin <shawn.lin@rock-chips.com>
    clk: Don't show the incorrect clock phase

Shawn Lin <shawn.lin@rock-chips.com>
    clk: rockchip: Fix wrong parent for SDMMC phase clock for rk3228

Sylwester Nawrocki <s.nawrocki@samsung.com>
    ASoC: samsung: i2s: Ensure the RCLK rate is properly determined

Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
    ASoC: topology: create TLV data for dapm widgets

Sylwester Nawrocki <s.nawrocki@samsung.com>
    ASoC: samsung: odroid: Fix 32000 sample rate handling

Ezequiel Garcia <ezequiel@collabora.co.uk>
    ASoC: rockchip: rk3288-hdmi-analog: Select needed codecs

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Fix frequency of Release WQE CQEs

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Fix IO failure during hba reset testing with nvme io.

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Fix soft lockup in lpfc worker thread during LIP testing

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Fix nonrecovery of NVME controller after cable swap.

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Fix issue_lip if link is disabled

Wilfried Weissmann <wilfried.weissmann@gmx.at>
    scsi: mvsas: fix wrong endianness of sgpio api

Douglas Gilbert <dgilbert@interlog.com>
    scsi: core: Make SCSI Status CONDITION MET equivalent to GOOD

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Fix NVME Initiator FirstBurst

Xose Vazquez Perez <xose.vazquez@gmail.com>
    scsi: devinfo: add HP DISK-SUBSYSTEM device, for HP XP arrays

Dave Carroll <david.carroll@microsemi.com>
    scsi: aacraid: Insure command thread is not recursively stopped

Antoine Tenart <antoine.tenart@bootlin.com>
    crypto: inside-secure - fix the invalidation step during cra_exit

Peter Robinson <pbrobinson@gmail.com>
    crypto: sunxi-ss - Add MODULE_ALIAS to sun4i-ss

Antoine Tenart <antoine.tenart@bootlin.com>
    crypto: inside-secure - do not overwrite the threshold value

Antoine Tenart <antoine.tenart@bootlin.com>
    crypto: inside-secure - fix the extra cache computation

Antoine Tenart <antoine.tenart@bootlin.com>
    crypto: inside-secure - fix the cache_len computation

Antoine Tenart <antoine.tenart@bootlin.com>
    crypto: inside-secure - do not process request if no command was issued

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    crypto: ccp - don't disable interrupts while setting up debugfs

Antoine Tenart <antoine.tenart@bootlin.com>
    crypto: atmel-aes - fix the keys zeroing on errors

Antoine Tenart <antoine.tenart@bootlin.com>
    crypto: inside-secure - wait for the request to complete if in the backlog

Antoine Tenart <antoine.tenart@bootlin.com>
    crypto: inside-secure - move the digest to the request context

NeilBrown <neilb@suse.com>
    staging: lustre: lmv: correctly iput lmo_root

Quytelda Kahja <quytelda@tamalin.org>
    staging: ks7010: Use constants from ieee80211_eid instead of literal ints.

Colin Ian King <colin.king@canonical.com>
    staging: rtl8192u: return -ENOMEM on failed allocation of priv->oldaddr

Ioana Radulescu <ruxandra.radulescu@nxp.com>
    staging: fsl-dpaa2/eth: Fix incorrect casts

NeilBrown <neilb@suse.com>
    staging: lustre: fix bug in osc_enter_cache_try

Ioana Radulescu <ruxandra.radulescu@nxp.com>
    staging: fsl-dpaa2/eth: Fix incorrect kfree

Kirill Marinushkin <k.marinushkin@gmail.com>
    staging: bcm2835-audio: Release resources on module_exit()

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    x86/kexec: Avoid double free_page() upon do_kexec_load() failure

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    hfsplus: stop workqueue when fill_super() failed

Johannes Berg <johannes.berg@intel.com>
    cfg80211: limit wiphy names to 128 bytes

Omar Sandoval <osandov@fb.com>
    loop: fix LOOP_GET_STATUS lock imbalance

Omar Sandoval <osandov@fb.com>
    loop: don't call into filesystem while holding lo_ctl_mutex

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Show what USB release number the xHC supports from protocol capablity

Tedd Ho-Jeong An <tedd.an@intel.com>
    Bluetooth: btusb: Add support for Intel Bluetooth device 22560 [8087:0026]

Larry Finger <Larry.Finger@lwfinger.net>
    Bluetooth: btusb: Add device ID for RTL8822BE

Brad Love <brad@nextdimension.cc>
    media: em28xx: USB bulk packet size fix

Brad Love <brad@nextdimension.cc>
    media: lgdt3306a: Fix module count mismatch on usb unplug

Chris Dickens <christopher.a.dickens@gmail.com>
    usb: gadget: composite: fix incorrect handling of OS desc requests

Wolfram Sang <wsa+renesas@sang-engineering.com>
    usb: gadget: udc: change comparison to bitshift when dealing with a mask

Ben Hutchings <ben@decadent.org.uk>
    usbip: Correct maximum value of CONFIG_USBIP_VHCI_HC_PORTS

Lars-Peter Clausen <lars@metafoo.de>
    usb: gadget: ffs: Execute copy_to_user() with USER_DS set

Lars-Peter Clausen <lars@metafoo.de>
    usb: gadget: ffs: Let setup() return USB_GADGET_DELAYED_STATUS

Minas Harutyunyan <hminas@synopsys.com>
    usb: dwc2: host: Fix transaction errors in host mode

Minas Harutyunyan <hminas@synopsys.com>
    usb: dwc2: hcd: Fix host channel halt flow

Grigor Tovmasyan <Grigor.Tovmasyan@synopsys.com>
    usb: dwc2: Fix interval type issue

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: zero usb device slot_id member when disabling and freeing a xhci slot

Felipe Balbi <felipe.balbi@linux.intel.com>
    usb: dwc3: Makefile: fix link error on randconfig

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: Update DWC_usb31 GTXFIFOSIZ reg fields

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: Add SoftReset PHY synchonization delay

Nobutaka Okabe <nob77413@gmail.com>
    ALSA: usb-audio: Add native DSD support for Luxman DA-06

Vicente Bergas <vicencb@gmail.com>
    Bluetooth: btusb: Add USB ID 7392:a611 for Edimax EW-7611ULB

Jens Remus <jremus@linux.ibm.com>
    scsi: zfcp: fix infinite iteration on ERP ready list

Alexander Potapenko <glider@google.com>
    scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: use expoline thunks in the BPF JIT

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: extend expoline to BC instructions

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: move spectre sysfs attribute code

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/kernel: use expoline for indirect branches

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/ftrace: use expoline for indirect branches

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/lib: use expoline for indirect branches

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/crc32-vx: use expoline for indirect branches

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: move expoline assembler macros to a header

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: correct module section names for expoline code revert

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: correct nospec auto detection init order

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: add assembler macros for CPU alternatives

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: add sysfs attributes for spectre

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: report spectre mitigation via syslog

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: add automatic detection of the spectre defense

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: move nobp parameter functions to nospec-branch.c

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s: Add support for a store forwarding barrier at kernel entry/exit

Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
    powerpc: Move default security feature flags

Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
    powerpc/pseries: Fix clearing of security feature flags

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Wire up cpu_show_spectre_v2()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Wire up cpu_show_spectre_v1()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/pseries: Use the security flags in pseries_setup_rfi_flush()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/powernv: Use the security flags in pnv_setup_rfi_flush()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Enhance the information in cpu_show_meltdown()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Move cpu_show_meltdown()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/powernv: Set or clear security feature flags

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/pseries: Set or clear security feature flags

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/pseries: Add new H_GET_CPU_CHARACTERISTICS flags

Michael Ellerman <mpe@ellerman.id.au>
    powerpc: Add security feature flags for Spectre/Meltdown

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/rfi-flush: Always enable fallback flush on pseries

Al Viro <viro@zeniv.linux.org.uk>
    ext2: fix a block leak

Arvind Yadav <arvind.yadav.cs@gmail.com>
    sparc: vio: use put_device() instead of kfree()

Michal Kalderon <Michal.Kalderon@cavium.com>
    qed: Fix LL2 race during connection terminate

Michal Kalderon <Michal.Kalderon@cavium.com>
    qed: Fix possibility of list corruption during rmmod flows

Michal Kalderon <Michal.Kalderon@cavium.com>
    qed: LL2 flush isles when connection is closed

William Tu <u9012063@gmail.com>
    net: ip6_gre: fix tunnel metadata device sharing.

Petr Machata <petrm@mellanox.com>
    net: ip6_gre: Fix ip6erspan hlen calculation

Petr Machata <petrm@mellanox.com>
    net: ip6_gre: Split up ip6gre_changelink()

Petr Machata <petrm@mellanox.com>
    net: ip6_gre: Split up ip6gre_newlink()

Petr Machata <petrm@mellanox.com>
    net: ip6_gre: Split up ip6gre_tnl_change()

Petr Machata <petrm@mellanox.com>
    net: ip6_gre: Split up ip6gre_tnl_link_config()

Petr Machata <petrm@mellanox.com>
    net: ip6_gre: Fix headroom request in ip6erspan_tunnel_xmit()

Petr Machata <petrm@mellanox.com>
    net: ip6_gre: Request headroom in __gre6_xmit()

hpreg@vmware.com <hpreg@vmware.com>
    vmxnet3: use DMA memory barriers where required

hpreg@vmware.com <hpreg@vmware.com>
    vmxnet3: set the DMA mask before the first DMA map operation

Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
    cxgb4: fix offset in collecting TX rate limit info

Christoph Hellwig <hch@lst.de>
    3c59x: convert to generic DMA API

Florian Fainelli <f.fainelli@gmail.com>
    net: dsa: bcm_sf2: Fix IPv6 rule half deletion

Florian Fainelli <f.fainelli@gmail.com>
    net: dsa: bcm_sf2: Fix IPv6 rules and chain ID

Florian Fainelli <f.fainelli@gmail.com>
    net: dsa: Do not register devlink for unused ports

Florian Fainelli <f.fainelli@gmail.com>
    net: dsa: bcm_sf2: Fix RX_CLS_LOC_ANY overwrite for last rule

Kumar Sanghvi <kumaras@chelsio.com>
    cxgb4: Correct ntuple mask validation for hash filters

Jason Wang <jasowang@redhat.com>
    tuntap: fix use after free during release

Jason Wang <jasowang@redhat.com>
    tun: fix use after free for ptr_ring

Eric Dumazet <edumazet@google.com>
    tcp: purge write queue in tcp_connect_init()

Eric Dumazet <edumazet@google.com>
    sock_diag: fix use-after-free read in __sk_free

Willem de Bruijn <willemb@google.com>
    packet: in packet_snd start writing at link layer allocation

Willem de Bruijn <willemb@google.com>
    net: test tailroom before appending to linear skb

Eric Biggers <ebiggers@google.com>
    net/smc: check for missing nlattrs in SMC_PNETID messages

Paolo Abeni <pabeni@redhat.com>
    net: sched: red: avoid hashing NULL child

Davide Caratti <dcaratti@redhat.com>
    net/sched: fix refcnt leak in the error path of tcf_vlan_init()

Tarick Bedeir <tarick@google.com>
    net/mlx4_core: Fix error handling in mlx4_init_port_info.

Amritha Nambiar <amritha.nambiar@intel.com>
    net: Fix a bug in removing queues from XPS map

Saeed Mahameed <saeedm@mellanox.com>
    net/mlx5: Fix build break when CONFIG_SMP=n


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/powerpc/include/asm/exception-64s.h           |  29 +++
 arch/powerpc/include/asm/feature-fixups.h          |  19 ++
 arch/powerpc/include/asm/hvcall.h                  |   3 +
 arch/powerpc/include/asm/security_features.h       |  85 +++++++
 arch/powerpc/kernel/Makefile                       |   2 +-
 arch/powerpc/kernel/exceptions-64s.S               |  19 +-
 arch/powerpc/kernel/security.c                     | 237 +++++++++++++++++
 arch/powerpc/kernel/setup_64.c                     |   8 -
 arch/powerpc/kernel/vmlinux.lds.S                  |  14 +
 arch/powerpc/lib/feature-fixups.c                  | 115 +++++++++
 arch/powerpc/platforms/powernv/setup.c             |  96 ++++---
 arch/powerpc/platforms/pseries/setup.c             |  71 ++++--
 arch/s390/Kconfig                                  |   3 +-
 arch/s390/Makefile                                 |   2 +-
 arch/s390/crypto/crc32be-vx.S                      |   5 +-
 arch/s390/crypto/crc32le-vx.S                      |   4 +-
 arch/s390/include/asm/alternative-asm.h            | 108 ++++++++
 arch/s390/include/asm/nospec-branch.h              |   7 +-
 arch/s390/include/asm/nospec-insn.h                | 196 ++++++++++++++
 arch/s390/kernel/Makefile                          |   5 +-
 arch/s390/kernel/alternative.c                     |  24 +-
 arch/s390/kernel/asm-offsets.c                     |   1 +
 arch/s390/kernel/base.S                            |  24 +-
 arch/s390/kernel/entry.S                           | 105 ++------
 arch/s390/kernel/mcount.S                          |  14 +-
 arch/s390/kernel/module.c                          |  15 +-
 arch/s390/kernel/nospec-branch.c                   | 123 ++++++---
 arch/s390/kernel/nospec-sysfs.c                    |  21 ++
 arch/s390/kernel/reipl.S                           |   7 +-
 arch/s390/kernel/setup.c                           |   3 +
 arch/s390/kernel/swsusp.S                          |  10 +-
 arch/s390/lib/mem.S                                |  19 +-
 arch/s390/net/bpf_jit.S                            |  16 +-
 arch/s390/net/bpf_jit_comp.c                       |  63 ++++-
 arch/sparc/kernel/vio.c                            |   2 +-
 arch/x86/kernel/machine_kexec_32.c                 |   6 +-
 arch/x86/kernel/machine_kexec_64.c                 |   5 +-
 drivers/block/loop.c                               |  71 +++---
 drivers/bluetooth/btusb.c                          |  13 +
 drivers/clk/clk.c                                  |   3 +
 drivers/clk/hisilicon/crg-hi3516cv300.c            |   2 +-
 drivers/clk/meson/axg.c                            |   7 +-
 drivers/clk/rockchip/clk-mmc-phase.c               |  23 ++
 drivers/clk/rockchip/clk-rk3228.c                  |   2 +-
 drivers/clk/samsung/clk-exynos3250.c               |   4 +-
 drivers/clk/samsung/clk-exynos5250.c               |   8 +-
 drivers/clk/samsung/clk-exynos5260.c               |   2 +-
 drivers/clk/samsung/clk-exynos5433.c               |  12 +-
 drivers/clk/samsung/clk-exynos7.c                  |   2 +-
 drivers/clk/samsung/clk-s3c2410.c                  |  16 +-
 drivers/clk/tegra/clk-pll.c                        |   2 +
 drivers/crypto/atmel-aes.c                         |   2 +-
 drivers/crypto/ccp/ccp-debugfs.c                   |   7 +-
 drivers/crypto/inside-secure/safexcel.c            |  12 +-
 drivers/crypto/inside-secure/safexcel_cipher.c     |   2 +-
 drivers/crypto/inside-secure/safexcel_hash.c       |  38 +--
 drivers/crypto/sunxi-ss/sun4i-ss-core.c            |   1 +
 drivers/media/common/videobuf2/videobuf2-vmalloc.c |   2 +-
 drivers/media/dvb-frontends/lgdt3306a.c            |  10 +-
 drivers/media/i2c/adv748x/adv748x-hdmi.c           |   3 +
 drivers/media/i2c/ov5645.c                         |   5 +-
 drivers/media/pci/cx23885/cx23885-cards.c          |   4 +
 drivers/media/pci/cx23885/cx23885-core.c           |  10 +
 drivers/media/pci/cx25821/cx25821-core.c           |   7 +-
 drivers/media/platform/s3c-camif/camif-capture.c   |   7 +-
 drivers/media/platform/vivid/vivid-ctrls.c         |   2 +
 drivers/media/platform/vsp1/vsp1_drm.c             |   9 +
 drivers/media/usb/em28xx/em28xx-cards.c            |  22 +-
 drivers/media/usb/em28xx/em28xx.h                  |   2 +-
 drivers/net/dsa/bcm_sf2_cfp.c                      |  36 ++-
 drivers/net/ethernet/3com/3c59x.c                  | 104 ++++----
 drivers/net/ethernet/chelsio/cxgb4/cudbg_entity.h  |  28 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c  |  88 +++----
 drivers/net/ethernet/mellanox/mlx4/main.c          |   4 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.c          |  61 ++++-
 drivers/net/tun.c                                  |  27 +-
 drivers/net/vmxnet3/vmxnet3_drv.c                  |  72 ++++--
 drivers/net/vmxnet3/vmxnet3_int.h                  |   8 +-
 drivers/rtc/hctosys.c                              |   5 +
 drivers/rtc/rtc-goldfish.c                         |   2 +
 drivers/rtc/rtc-m41t80.c                           |  18 +-
 drivers/rtc/rtc-rk808.c                            |  14 +-
 drivers/rtc/rtc-rp5c01.c                           |  12 +-
 drivers/rtc/rtc-snvs.c                             |  15 +-
 drivers/rtc/rtc-tx4939.c                           |   6 +-
 drivers/s390/scsi/zfcp_dbf.c                       |  23 +-
 drivers/s390/scsi/zfcp_ext.h                       |   5 +-
 drivers/s390/scsi/zfcp_scsi.c                      |  14 +-
 drivers/scsi/aacraid/commsup.c                     |   4 +-
 drivers/scsi/aacraid/linit.c                       |   1 +
 drivers/scsi/lpfc/lpfc_attr.c                      |   5 +
 drivers/scsi/lpfc/lpfc_hbadisc.c                   |   5 +-
 drivers/scsi/lpfc/lpfc_nportdisc.c                 |  15 +-
 drivers/scsi/lpfc/lpfc_nvme.c                      |  28 +-
 drivers/scsi/lpfc/lpfc_nvme.h                      |   2 +
 drivers/scsi/lpfc/lpfc_sli.c                       |   2 +
 drivers/scsi/mvsas/mv_94xx.c                       |  23 +-
 drivers/scsi/scsi_devinfo.c                        |   1 +
 drivers/scsi/scsi_lib.c                            |  11 +
 drivers/scsi/sg.c                                  |   2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     |  16 +-
 drivers/staging/ks7010/ks_hostif.c                 |  31 ++-
 drivers/staging/ks7010/ks_hostif.h                 |   1 +
 drivers/staging/lustre/lustre/include/obd.h        |   2 +-
 drivers/staging/lustre/lustre/lmv/lmv_obd.c        |   2 +-
 drivers/staging/lustre/lustre/osc/osc_cache.c      |   2 +-
 drivers/staging/rtl8192u/r8192U_core.c             |   2 +
 .../staging/vc04_services/bcm2835-audio/bcm2835.c  |  54 ++--
 drivers/tty/serial/8250/8250_port.c                |   3 +-
 drivers/tty/serial/altera_uart.c                   |  12 +-
 drivers/tty/serial/arc_uart.c                      |   5 +
 drivers/tty/serial/fsl_lpuart.c                    |   4 +
 drivers/tty/serial/imx.c                           |   6 +
 drivers/tty/serial/mvebu-uart.c                    |   2 +-
 drivers/tty/serial/mxs-auart.c                     |   4 +
 drivers/tty/serial/samsung.c                       |   4 +
 drivers/tty/serial/sh-sci.c                        |   4 +
 drivers/tty/serial/xilinx_uartps.c                 |   2 +-
 drivers/usb/dwc2/core.h                            |   2 +-
 drivers/usb/dwc2/hcd.c                             |  32 ++-
 drivers/usb/dwc3/Makefile                          |   2 +-
 drivers/usb/dwc3/core.c                            |  13 +-
 drivers/usb/dwc3/core.h                            |   2 +
 drivers/usb/gadget/composite.c                     |  40 ++-
 drivers/usb/gadget/function/f_fs.c                 |   6 +-
 drivers/usb/gadget/udc/goku_udc.h                  |   2 +-
 drivers/usb/host/xhci-mem.c                        |   2 +
 drivers/usb/host/xhci.c                            |  14 +-
 drivers/usb/usbip/Kconfig                          |   2 +-
 fs/ext2/inode.c                                    |  10 -
 fs/hfsplus/super.c                                 |   1 +
 include/linux/mlx5/driver.h                        |  12 +-
 include/linux/usb/composite.h                      |   3 +
 include/scsi/scsi.h                                |   2 +
 include/uapi/linux/nl80211.h                       |   2 +
 net/core/dev.c                                     |   2 +-
 net/core/sock.c                                    |   2 +-
 net/dsa/dsa2.c                                     |   9 +-
 net/ipv4/ip_output.c                               |   3 +-
 net/ipv4/tcp_output.c                              |   7 +-
 net/ipv6/ip6_gre.c                                 | 281 ++++++++++++++++-----
 net/ipv6/ip6_output.c                              |   3 +-
 net/packet/af_packet.c                             |   4 +-
 net/sched/act_vlan.c                               |   2 +
 net/sched/sch_red.c                                |   5 +-
 net/sched/sch_tbf.c                                |   5 +-
 net/smc/smc_pnet.c                                 |  71 +++---
 net/wireless/core.c                                |   3 +
 sound/soc/rockchip/Kconfig                         |   3 +
 sound/soc/samsung/i2s.c                            |  13 +-
 sound/soc/samsung/odroid.c                         |  11 +-
 sound/soc/soc-topology.c                           |   3 +
 sound/usb/quirks.c                                 |  29 ++-
 154 files changed, 2356 insertions(+), 846 deletions(-)
