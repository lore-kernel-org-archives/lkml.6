Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3604181-1521489387-2-3983472007824901085
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521489385; b=FT1W6vYnV8FIRXodprXemDJdEEu2Qcq/MdhIwgewE1YtPRm
    MEklBiVBJliBCYMuTcYRjmC/ext2vjs7lywDzSCSem93r4sPY+LBPibM4NbaZNom
    CxiGzdsswf/GA7BiB+hmblaioCxDb6Ms5Dv9hX+AEmHH/Fhl72VY59oIypBLii2Y
    kTGcpmF1sUX0Kx9oaSSLRsLlEw7xV/athctiJ7hUGPDpi0B454k8K3SobPDtH4NC
    Z7zhQgMle60t1c7ffj5qiqUGjPaYGcdUbR5z1emjDadcboO2xDrFF6UrrBlaXM0c
    BRn/n/U4891h54JmcUeUhyYzJupl1vRzpHQoaYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1521489385; bh=XeNZXVFlLERMFHm4+LxdqpCjqn
    pnhQHa7f9yh+hEsqE=; b=iY+Wp+vK1AvTrmHjkIveMHk5is34ddUvgoMtNTytl6
    dqmEbZ9LuF9PaQFXWYfq3+jxz/OOn5JSxTJges52Yz5OpE12YPSntQLR19mRqaU7
    t7Mbg8vNNNNVHPrs0XfCopCRzAD4H0pslo4u7b514HZrEGEGztsNsS+ZVTf6LjB0
    HFnRlBLAw1q6oZoAOrrbkxj4+6FRwkuNFqGIqsweD4EyzuHwiCNbSb4UgV/JMFnW
    cfIKQkM2Mp0TLZbPhD84UzBaXdgcUDjypdtrEKUzUQYAnFxijNoNJPfsWVqL5Nk2
    gH5w76T1IizCS7bKGikal9gAUMm2LQTK2Nk7/MoDrMyw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddufeduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffogggftgfgshhpjeesthekfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepgeeftddtudenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddufeduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffogggftgfgshhpjeesthekfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepgeeftddtudenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969412AbeCSTzr (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 15:55:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46882 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966415AbeCSSTM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:19:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 000/241] 4.9.89-stable review
Date: Mon, 19 Mar 2018 19:04:25 +0100
Message-Id: <20180319180751.172155436@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.89-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.89-rc1
X-KernelTest-Deadline: 2018-03-21T18:08+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.9.89 release.
There are 241 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Mar 21 18:07:03 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.89-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.89-rc1

Srinath Mannam <srinath.mannam@broadcom.com>
    usb: gadget: bdc: 64-bit pointer capability check

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: Fix GDBGFIFOSPACE_TYPE values

Wei Yongjun <weiyongjun1@huawei.com>
    USB: gadget: udc: Add missing platform_device_put() on error in bdc_pci_probe()

Bill Kuzeja <William.Kuzeja@stratus.com>
    scsi: qla2xxx: Fix extraneous ref on sp's after adapter break

Nikolay Borisov <nborisov@suse.com>
    btrfs: Fix use-after-free when cleaning up fs_devs with a single stale device

Hans van Kranenburg <hans.van.kranenburg@mendix.com>
    btrfs: alloc_chunk: fix DUP stripe size handling

Johannes Thumshirn <jthumshirn@suse.de>
    scsi: sg: only check for dxfer_len greater than 256M

Johannes Thumshirn <jthumshirn@suse.de>
    scsi: sg: fix static checker warning in sg_is_valid_dxfer

Johannes Thumshirn <jthumshirn@suse.de>
    scsi: sg: fix SG_DXFER_FROM_DEV transfers

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    irqchip/gic-v3-its: Ensure nr_ites >= nr_lpis

Tejun Heo <tj@kernel.org>
    fs/aio: Use RCU accessors for kioctx_table->table[]

Tejun Heo <tj@kernel.org>
    fs/aio: Add explicit RCU grace period when freeing kioctx

Al Viro <viro@zeniv.linux.org.uk>
    lock_parent() needs to recheck if dentry got __dentry_kill'ed under it

Eric W. Biederman <ebiederm@xmission.com>
    fs: Teach path_connected to handle nfs filesystems with multiple roots.

Michel Dänzer <michel.daenzer@amd.com>
    drm/amdgpu/dce: Don't turn off DP sink when disconnected

Christian König <christian.koenig@amd.com>
    drm/amdgpu: fix prime teardown order

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Clear client entry before deleting else at closing

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Fix possible UAF in snd_seq_check_queue()

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Revert power_save option default value

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix UAF in snd_pcm_oss_get_formats()

John David Anglin <dave.anglin@bell.net>
    parisc: Handle case where flush_cache_range is called with no context

Toshi Kani <toshi.kani@hpe.com>
    x86/mm: Fix vmalloc_fault to use pXd_large

Alexander Sergeyev <sergeev917@gmail.com>
    x86/speculation: Remove Skylake C2 from Speculation Control microcode blacklist

Andy Whitcroft <apw@canonical.com>
    x86/speculation, objtool: Annotate indirect calls/jumps for objtool on 32-bit kernels

Andy Lutomirski <luto@kernel.org>
    x86/vm86/32: Fix POPF emulation

Andy Lutomirski <luto@kernel.org>
    selftests/x86/entry_from_vm86: Add test cases for POPF

Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
    selftests/x86: Add tests for the STR and SLDT instructions

Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
    selftests/x86: Add tests for User-Mode Instruction Prevention

Andy Lutomirski <luto@kernel.org>
    selftests/x86/entry_from_vm86: Exit with 1 if we fail

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/cpufeatures: Add Intel PCONFIG cpufeature

Andy Lutomirski <luto@kernel.org>
    x86/boot/32: Fix UP boot on Quark and possibly other platforms

Salil <salil.mehta@huawei.com>
    net: hns: Some checkpatch.pl script & warning fixes

Mimi Zohar <zohar@linux.vnet.ibm.com>
    ima: relax requiring a file signature for new files with zero length

Davidlohr Bueso <dave@stgolabs.net>
    locking/locktorture: Fix num reader/writer corner cases

SeongJae Park <sj38.park@gmail.com>
    rcutorture/configinit: Fix build directory error message

Mahesh Bandewar <maheshb@google.com>
    ipvlan: add L2 check for packets arriving via virtual devices

Dan Carpenter <dan.carpenter@oracle.com>
    ASoC: nuc900: Fix a loop timeout test

Luca Coelho <luciano.coelho@intel.com>
    mac80211: remove BUG() when interface type is invalid

Adiel Aloni <adiel.aloni@intel.com>
    mac80211_hwsim: enforce PS_MANUAL_POLL to be set after PS_ENABLED

Chris Wilson <chris@chris-wilson.co.uk>
    agp/intel: Flush all chipset writes after updating the GGTT

Josh Poimboeuf <jpoimboe@redhat.com>
    powerpc/modules: Don't try to restore r2 after a sibling call

Yong Zhao <yong.zhao@amd.com>
    drm/amdkfd: Fix memory leaks in kfd topology

Stephen Hemminger <stephen@networkplumber.org>
    veth: set peer GSO values

Dan Carpenter <dan.carpenter@oracle.com>
    media: cpia2: Fix a couple off by one bugs

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

Axel Lin <axel.lin@ingics.com>
    pwm: stmpe: Fix wrong register offset for hwpwm=2 case

Li Dongyang <dongyang.li@anu.edu.au>
    scsi: ses: don't ask for diagnostic pages repeatedly during probe

Peter Ujfalusi <peter.ujfalusi@ti.com>
    dmaengine: bcm2835-dma: Use vchan_terminate_vdesc() instead of desc_free

Manikanta Pubbisetty <mpubbise@qti.qualcomm.com>
    ath10k: update tdls teardown state to target

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    power: supply: ab8500_charger: Bail out in case of error in 'ab8500_charger_init_hw_registers()'

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    power: supply: ab8500_charger: Fix an error handling path

Bjorn Andersson <bjorn.andersson@linaro.org>
    leds: pm8058: Silence pointer to integer size warning

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

Michael Hennerich <michael.hennerich@analog.com>
    net: ieee802154: adf7242: Fix bug if defined DEBUG

Luis R. Rodriguez <mcgrof@kernel.org>
    test_firmware: fix setting old custom fw path back on exit

Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    sched: Stop resched_cpu() from sending IPIs to offline CPUs

Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    sched: Stop switched_to_rt() from sending IPIs to offline CPUs

Simon Shields <simon@lineageos.org>
    ARM: dts: exynos: Correct Trats2 panel reset line

Yixun Lan <yixun.lan@amlogic.com>
    clk: meson: gxbb: fix wrong clock for SARADC/SANA

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    iwlwifi: mvm: rs: don't override the rate history in the search cycle

Jiri Kosina <jkosina@suse.cz>
    HID: elo: clear BTN_LEFT mapping

Ville Syrjälä <ville.syrjala@linux.intel.com>
    video/hdmi: Allow "empty" HDMI infoframes

Jani Nikula <jani.nikula@intel.com>
    drm/edid: set ELD connector type in drm_edid_to_eld()

Ganapathi Bhat <gbhat@marvell.com>
    mwifiex: Fix invalid port issue

Stephane Eranian <eranian@google.com>
    perf stat: Fix bug in handling events in error state

Dedy Lansky <qca_dlansky@qca.qualcomm.com>
    wil6210: fix memory access violation in wil_memcpy_from/toio_32

Hamad Kadmany <qca_hkadmany@qca.qualcomm.com>
    wil6210: fix protection against connections during reset

Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
    ath10k: fix compile time sanity check for CE4 buffer size

Johannes Berg <johannes.berg@intel.com>
    mac80211_hwsim: use per-interface power level

Michael Scott <michael.scott@linaro.org>
    Bluetooth: 6lowpan: fix delay work init in add_peer_chan()

Dean Jenkins <Dean_Jenkins@mentor.com>
    Bluetooth: Avoid bt_accept_unlink() double unlinking

Rajendra Nayak <rnayak@codeaurora.org>
    clk: qcom: msm8996: Fix the vfe1 powerdomain name

Laxman Dewangan <ldewangan@nvidia.com>
    pwm: tegra: Increase precision in PWM rate calculation

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes/x86: Set kprobes pages read-only

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes/x86: Fix kprobe-booster not to boost far call instructions

Subhransu S. Prusty <subhransu.s.prusty@intel.com>
    ALSA: hda: Add Geminilake id to SKL_PLUS

Hannes Reinecke <hare@suse.de>
    scsi: sg: close race condition in sg_remove_sfp_usercontext()

Johannes Thumshirn <jthumshirn@suse.de>
    scsi: sg: check for valid direction before starting the request

Alexey Kardashevskiy <aik@ozlabs.ru>
    vfio/spapr_tce: Check kzalloc() return when preregistering memory

Alexey Kardashevskiy <aik@ozlabs.ru>
    vfio/powerpc/spapr_tce: Enforce IOMMU type compatibility check

David Carrillo-Cisneros <davidcc@google.com>
    perf session: Don't rely on evlist in pipe mode

Fugang Duan <fugang.duan@nxp.com>
    net: fec: add phy-reset-gpios PROBE_DEFER check

David Carrillo-Cisneros <davidcc@google.com>
    perf inject: Copy events when reordering events in pipe mode

Mark Rutland <mark.rutland@arm.com>
    drivers/perf: arm_pmu: handle no platform_device

Johannes Berg <johannes.berg@intel.com>
    iwlwifi: mvm: fix RX SKB header size and align it properly

Jin Yao <yao.jin@linux.intel.com>
    perf evsel: Return exact sub event which failed with EPERM for wildcards

Yuyang Du <yuyang.du@intel.com>
    usb: gadget: dummy_hcd: Fix wrong power status bit clear/reset in dummy_hub_control()

John Stultz <john.stultz@linaro.org>
    usb: dwc2: Make sure we disconnect the gadget state

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/nohash: Fix use of mmu_has_feature() in setup_initial_memory_limit()

Zhilong Liu <zlliu@suse.com>
    md.c:didn't unlock the mddev before return EINVAL in array_size_store

NeilBrown <neilb@suse.com>
    md/raid6: Fix anomily when recovering a single device in RAID6.

Vincent Stehlé <vincent.stehle@laposte.net>
    regulator: isl9305: fix array size

Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
    v4l: vsp1: Register pipe with output WPF

Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
    v4l: vsp1: Prevent multiple streamon race commencing pipeline early

Aleksandar Markovic <aleksandar.markovic@imgtec.com>
    MIPS: r2-on-r6-emu: Clear BLTZALL and BGEZALL debugfs counters

Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
    MIPS: r2-on-r6-emu: Fix BLEZL and BGTZL identification

David Daney <david.daney@cavium.com>
    MIPS: BPF: Fix multiple problems in JIT skb access helpers.

David Daney <david.daney@cavium.com>
    MIPS: BPF: Quit clobbering callee saved registers in JIT code.

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    serial: imx: setup DCEDTE early and ensure DCD and RI irqs to be off

Jayachandran C <jnair@caviumnetworks.com>
    tty: amba-pl011: Fix spurious TX interrupts

Arnd Bergmann <arnd@arndb.de>
    lkdtm: turn off kcov for lkdtm_rodata_do_nothing:

Mike Leach <mike.leach@linaro.org>
    coresight: Fixes coresight DT parse to get correct output port ID.

Mitch Williams <mitch.a.williams@intel.com>
    i40e: only register client on iWarp-capable devices

Jeffy Chen <jeffy.chen@rock-chips.com>
    drm/rockchip: vop: Enable pm domain before vop_initial

Christopher James Halse Rogers <christopher.halse.rogers@canonical.com>
    drm/amdgpu: Fail fb creation from imported dma-bufs. (v2)

Christopher James Halse Rogers <christopher.halse.rogers@canonical.com>
    drm/radeon: Fail fb creation from imported dma-bufs.

Liam Beguin <lbeguin@tycoint.com>
    video: ARM CLCD: fix dma allocation size

Jim Mattson <jmattson@google.com>
    kvm: nVMX: Disallow userspace-injected exceptions in guest mode

Borislav Petkov <bp@suse.de>
    kvm/svm: Setup MCG_CAP on AMD properly

Nate Watterson <nwatters@codeaurora.org>
    iommu/iova: Fix underflow bug in __alloc_and_insert_iova_range

John Johansen <john.johansen@canonical.com>
    apparmor: Make path_max parameter readonly

Mintz, Yuval <Yuval.Mintz@cavium.com>
    qed: Correct MSI-x for storage

Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
    scsi: ses: don't get power status of SES device slot on probe

Thor Thayer <thor.thayer@linux.intel.com>
    EDAC, altera: Fix peripheral warnings for Cyclone5

Phil Turnbull <phil.turnbull@oracle.com>
    fm10k: correctly check if interface is removed

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: firewire-digi00x: handle all MIDI messages on streaming packets

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: firewire-digi00x: add support for console models of Digi00x series

Easwar Hariharan <easwar.hariharan@intel.com>
    IB/hfi1: Check for QSFP presence before attempting reads

Javier Martinez Canillas <javier@osg.samsung.com>
    ASoC: rt5677: Add OF device ID table

Jan Kara <jack@suse.cz>
    reiserfs: Make cancel_old_flush() reliable

Chen-Yu Tsai <wens@csie.org>
    clk: sunxi-ng: a33: Add offset and minimum value for DDR1 PLL N factor

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: koelsch: Correct clock frequency of X2 DU clock input

Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
    drm: rcar-du: Handle event when disabling CRTCs

Arnd Bergmann <arnd@arndb.de>
    soc/tegra: Fix link errors with PMC disabled

Petr Mladek <pmladek@suse.com>
    printk: Correctly handle preemption in console_unlock()

Peter Zijlstra <peterz@infradead.org>
    rtmutex: Fix PI chain order integrity

Michal Kalderon <Michal.Kalderon@cavium.com>
    qed: Fix TM block ILT allocation

Andrew Lunn <andrew@lunn.ch>
    net/faraday: Add missing include of of.h

lipeng <lipeng321@huawei.com>
    net: hns: Correct HNS RSS key set function

Anton Blanchard <anton@samba.org>
    powerpc: Avoid taking a data miss on every userspace instruction miss

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: r8a7793: Correct parent of SSI[0-9] clocks

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: r8a7791: Correct parent of SSI[0-9] clocks

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: r8a7790: Correct parent of SSI[0-9] clocks

Chris Brandt <chris.brandt@renesas.com>
    ARM: dts: r7s72100: fix ethernet clock parent

Andrey Rusalin <arusalin@dev.rtsoft.ru>
    NFC: pn533: change order of free_irq and dev unregistration

Dan Carpenter <dan.carpenter@oracle.com>
    NFC: nfcmrvl: double free on error path

Tobias Klauser <tklauser@distanz.ch>
    NFC: nfcmrvl: Include unaligned.h instead of access_ok.h

Felix Manlunas <felix.manlunas@cavium.com>
    vxlan: vxlan dev should inherit lowerdev's gso_max_size

Sinclair Yeh <syeh@vmware.com>
    drm/vmwgfx: Fixes to vmwgfx_fb

Samuel Thibault <samuel.thibault@ens-lyon.org>
    braille-console: Fix value returned by _braille_console_setup

Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
    powerpc/mm/hugetlb: Filter out hugepage size not supported by page table layout

Manish Jaggi <mjaggi@caviumnetworks.com>
    PCI: Apply Cavium ACS quirk only to CN81xx/CN83xx/CN88xx devices

Eric Dumazet <edumazet@google.com>
    bonding: refine bond_fold_stats() wrap detection

Nicolai Hähnle <nicolai.haehnle@amd.com>
    drm/ttm: never add BO that failed to validate to the LRU list

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: relax node version check for victim data in gc

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf trace: Handle unpaired raw_syscalls:sys_exit event

Matthias Kaehlcke <mka@chromium.org>
    regulator: core: Limit propagation of parent voltage count and list

Roger Quadros <rogerq@ti.com>
    ARM: DRA7: hwmod_data: Prevent wait_target_disable error for usb_otg_ss

Shaohua Li <shli@fb.com>
    blk-throttle: make sure expire time isn't too big

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: silk: Correct clock of DU1

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: r8a7794: Correct clock of DU1

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: firewire-lib: add a quirk of packet without valid EOH in CIP format

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    mm: Fix false-positive VM_BUG_ON() in page_cache_{get,add}_speculative()

Mahesh Bandewar <maheshb@google.com>
    bonding: make speed, duplex setting consistent with link state

Shikhar Dogra <shidogra@cisco.com>
    driver: (adm1275) set the m,b and R coefficients correctly for power

Jitendra Bhivare <jitendra.bhivare@broadcom.com>
    scsi: be2iscsi: Check tag in beiscsi_mccq_compl_wait

Alexander Duyck <alexander.h.duyck@intel.com>
    i40e/i40evf: Fix use after free in Rx cleanup path

Tommi Rantala <tommi.t.rantala@nokia.com>
    perf buildid: Do not assume that readlink() returns a null terminated string

Taeung Song <treeze.taeung@gmail.com>
    perf annotate: Fix a bug following symbolic link of a build-id file

Baruch Siach <baruch@tkos.co.il>
    ARM: dts: bcm2835: add index to the ethernet alias

Felipe Balbi <felipe.balbi@linux.intel.com>
    usb: dwc3: make sure UX_EXIT_PX is cleared

Jiada Wang <jiada_wang@mentor.com>
    dmaengine: imx-sdma: add 1ms delay to ensure SDMA channel is stopped

Gao Feng <fgao@ikuai8.com>
    tcp: sysctl: Fix a race to avoid unexpected 0 window from space

Akinobu Mita <akinobu.mita@gmail.com>
    spi: omap2-mcspi: poll OMAP2_MCSPI_CHSTAT_RXS for PIO transfer

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: rcar: ssi: don't set SSICR.CKDV = 000 with SSIWSR.CONT

Long Li <longli@microsoft.com>
    PCI: hv: Lock PCI bus on device eject

Long Li <longli@microsoft.com>
    PCI: hv: Properly handle PCI bus remove

Davide Caratti <dcaratti@redhat.com>
    sched: act_csum: don't mangle TCP and UDP GSO packets

Javier Martinez Canillas <javier@osg.samsung.com>
    Input: qt1070 - add OF device ID table

Tom Hromatka <tom.hromatka@oracle.com>
    sysrq: Reset the watchdog timers while displaying high-resolution timers

David Engraf <david.engraf@sysgo.com>
    timers, sched_clock: Update timeout for clock wrap

Janusz Krzysztofik <jmkrzyszt@gmail.com>
    media: i2c/soc_camera: fix ov6650 sensor getting wrong clock

Brian King <brking@linux.vnet.ibm.com>
    scsi: ipr: Fix missed EH wakeup

Satish Kharat <satishkh@cisco.com>
    scsi: fnic: Fix for "Number of Active IOs" in fnicstats becoming negative

Andy Lutomirski <luto@kernel.org>
    x86/boot/32: Defer resyncing initial_page_table until per-cpu is set up

Anton Sviridenko <anton@corp.bluecherry.net>
    solo6x10: release vb2 buffers in solo_stop_streaming()

Rob Herring <robh@kernel.org>
    of: fix of_device_get_modalias returned length when truncating buffers

Andreas Pape <APape@phoenixcontact.com>
    batman-adv: handle race condition for claims between gateways

Johan Hovold <johan@kernel.org>
    zd1211rw: fix NULL-deref at probe

Heiko Carstens <heiko.carstens@de.ibm.com>
    s390/topology: fix typo in early topology code

Mintz, Yuval <Yuval.Mintz@cavium.com>
    qed: Always publish VF link from leading hwfn

Linus Walleij <linus.walleij@linaro.org>
    ARM: dts: Adjust moxart IRQ controller and flags

Andrey Vagin <avagin@openvz.org>
    net/8021q: create device with all possible features in wanted_features

Tomasz Kramkowski <tk@the-tk.com>
    HID: clamp input to logical range if no null state

Kefeng Wang <wangkefeng.wang@huawei.com>
    perf probe: Return errno when not hitting any event

Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
    perf probe: Fix concat_probe_trace_events

Arvind Yadav <arvind.yadav.cs@gmail.com>
    omapfb: dss: Handle return errors in dss_init_ports()

Yazen Ghannam <Yazen.Ghannam@amd.com>
    x86/mce: Init some CPU features early

Nik Unger <njunger@uwaterloo.ca>
    netem: apply correct delay when rate throttling

Steve Lin <steven.lin1@broadcom.com>
    net: ethernet: bgmac: Allow MAC address to be specified in DTB

Stefan Wahren <stefan.wahren@i2se.com>
    ARM: bcm2835: Enable missing CMA settings for VC4 driver

Oliver Neukum <oneukum@suse.com>
    usb: misc: lvs: fix race condition in disconnect handling

Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
    ath10k: fix fetching channel during potential radar detection

Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
    ath10k: disallow DFS simulation if DFS channel is not enabled

Chris Wilson <chris@chris-wilson.co.uk>
    drm: Defer disabling the vblank IRQ until the next interrupt (for instant-off)

Iyappan Subramanian <isubramanian@apm.com>
    drivers: net: xgene: Fix Rx checksum validation logic

Quan Nguyen <qnguyen@apm.com>
    drivers: net: xgene: Fix wrong logical operation

Quan Nguyen <qnguyen@apm.com>
    drivers: net: phy: xgene: Fix mdio write

Quan Nguyen <qnguyen@apm.com>
    drivers: net: xgene: Fix hardware checksum setting

Al Cooper <alcooperx@gmail.com>
    ARM: brcmstb: Enable ZONE_DMA for non 64-bit capable peripherals

Stephane Eranian <eranian@google.com>
    perf tools: Make perf_event__synthesize_mmap_events() scale

Lihong Yang <lihong.yang@intel.com>
    i40e: fix ethtool to get EEPROM data from X722 interface

Aaron Salter <aaron.k.salter@intel.com>
    i40e: Acquire NVM lock before reads on all devices

Greg KH <gregkh@linuxfoundation.org>
    eventpoll.h: fix epoll event masks

Xunlei Pang <xlpang@redhat.com>
    x86/mce: Handle broadcasted MCE gracefully with kexec

Changbin Du <changbin.du@intel.com>
    perf sort: Fix segfault with basic block 'cycles' sort dimension

Dmitry Safonov <dsafonov@virtuozzo.com>
    x86/mm: Make mmap(MAP_32BIT) work correctly

Alexander Potapenko <glider@google.com>
    selinux: check for address length in selinux_socket_bind()

Prarit Bhargava <prarit@redhat.com>
    PCI/MSI: Stop disabling MSI/MSI-X in pci_device_shutdown()

Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
    net: mvpp2: set dma mask and coherent dma mask on PPv2.2

Chen-Yu Tsai <wens@csie.org>
    drm/sun4i: Fix TCON clock and regmap initialization sequence

Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
    ath10k: fix a warning during channel switch with multiple vaps

Chen-Yu Tsai <wens@csie.org>
    drm/sun4i: Set drm_crtc.port to the underlying TCON's output port node

Chen-Yu Tsai <wens@csie.org>
    drm/sun4i: Fix up error path cleanup for master bind function

Geert Uytterhoeven <geert+renesas@glider.be>
    arm64: dts: r8a7796: Remove unit-address and reg from integrated cache

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: r8a7794: Remove unit-address and reg from integrated cache

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: r8a7793: Remove unit-address and reg from integrated cache

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: r8a7792: Remove unit-address and reg from integrated cache

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: r8a7791: Remove unit-address and reg from integrated cache

Gabriel Krisman Bertazi <krisman@collabora.co.uk>
    drm: qxl: Don't alloc fbdev if emulation is not supported

Valtteri Heikkilä <rnd@nic.fi>
    HID: reject input outside logical range only if null state is set

Colin Ian King <colin.king@canonical.com>
    staging: wilc1000: add check for kmalloc allocation failure.

Varsha Rao <rvarsha016@gmail.com>
    staging: speakup: Replace BUG_ON() with WARN_ON().

Borislav Petkov <bp@suse.de>
    perf stat: Issue a HW watchdog disable hint

H. Nikolaus Schaller <hns@goldelico.com>
    Input: tsc2007 - check for presence and power down tsc2007 during probe

Hou Tao <houtao1@huawei.com>
    blkcg: fix double free of new_blkg in blkcg_init_queue


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/am335x-pepper.dts                |   2 +-
 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi        |   2 +-
 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi        |   2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            |   2 +-
 arch/arm/boot/dts/moxart-uc7112lx.dts              |   2 +-
 arch/arm/boot/dts/moxart.dtsi                      |  17 +--
 arch/arm/boot/dts/omap3-n900.dts                   |   4 +-
 arch/arm/boot/dts/r7s72100.dtsi                    |   2 +-
 arch/arm/boot/dts/r8a7790.dtsi                     |   7 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts              |   2 +-
 arch/arm/boot/dts/r8a7791.dtsi                     |  10 +-
 arch/arm/boot/dts/r8a7792.dtsi                     |   3 +-
 arch/arm/boot/dts/r8a7793.dtsi                     |  10 +-
 arch/arm/boot/dts/r8a7794-silk.dts                 |   2 +-
 arch/arm/boot/dts/r8a7794.dtsi                     |   5 +-
 arch/arm/configs/bcm2835_defconfig                 |   4 +-
 arch/arm/mach-bcm/Kconfig                          |   1 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |   2 +
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |   3 +-
 arch/mips/kernel/mips-r2-to-r6-emul.c              |  16 ++-
 arch/mips/net/bpf_jit.c                            |  16 ++-
 arch/mips/net/bpf_jit_asm.S                        |  23 ++--
 arch/parisc/kernel/cache.c                         |  41 ++++++--
 arch/powerpc/include/asm/code-patching.h           |   1 +
 arch/powerpc/kernel/module_64.c                    |  12 ++-
 arch/powerpc/lib/code-patching.c                   |   5 +
 arch/powerpc/mm/fault.c                            |   2 +-
 arch/powerpc/mm/hugetlbpage.c                      |  18 ++++
 arch/powerpc/mm/tlb_nohash.c                       |   2 +-
 arch/s390/kernel/early.c                           |   2 +-
 arch/x86/include/asm/cpufeatures.h                 |   1 +
 arch/x86/include/asm/nospec-branch.h               |   5 +-
 arch/x86/include/asm/reboot.h                      |   1 +
 arch/x86/kernel/cpu/intel.c                        |   3 +-
 arch/x86/kernel/cpu/mcheck/mce.c                   |  48 ++++++---
 arch/x86/kernel/kprobes/core.c                     |   6 ++
 arch/x86/kernel/kprobes/opt.c                      |   3 +
 arch/x86/kernel/reboot.c                           |   5 +-
 arch/x86/kernel/setup_percpu.c                     |  21 ++++
 arch/x86/kernel/sys_x86_64.c                       |   4 +-
 arch/x86/kernel/vm86_32.c                          |   3 +-
 arch/x86/kvm/svm.c                                 |   7 ++
 arch/x86/kvm/x86.c                                 |   3 +-
 arch/x86/mm/fault.c                                |   6 +-
 block/blk-cgroup.c                                 |   4 +-
 block/blk-throttle.c                               |  11 ++
 drivers/char/agp/intel-gtt.c                       |   2 +
 drivers/clk/meson/gxbb.c                           |   4 +-
 drivers/clk/qcom/gcc-msm8916.c                     |   1 +
 drivers/clk/qcom/mmcc-msm8996.c                    |   2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c               |  18 ++--
 drivers/dma/bcm2835-dma.c                          |  10 +-
 drivers/dma/imx-sdma.c                             |  17 ++-
 drivers/edac/altera_edac.c                         |  22 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |  31 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |   6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |  10 ++
 drivers/gpu/drm/drm_edid.c                         |   9 +-
 drivers/gpu/drm/drm_irq.c                          |  14 ++-
 drivers/gpu/drm/qxl/qxl_fb.c                       |   9 +-
 drivers/gpu/drm/radeon/radeon_display.c            |   6 ++
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c             |   7 ++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  29 +++--
 drivers/gpu/drm/sun4i/sun4i_crtc.c                 |   5 +
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |  16 ++-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  22 ++--
 drivers/gpu/drm/ttm/ttm_bo.c                       |  12 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                 |   4 +-
 drivers/hid/hid-elo.c                              |   6 ++
 drivers/hid/hid-input.c                            |  20 ++--
 drivers/hwmon/pmbus/adm1275.c                      |   4 +-
 drivers/hwtracing/coresight/of_coresight.c         |   2 +-
 drivers/infiniband/hw/hfi1/chip.c                  |   7 +-
 drivers/input/keyboard/qt1070.c                    |   9 ++
 drivers/input/touchscreen/tsc2007.c                |   8 ++
 drivers/iommu/iova.c                               |   2 +-
 drivers/irqchip/irq-gic-v3-its.c                   |   9 +-
 drivers/leds/leds-pm8058.c                         |   2 +-
 drivers/md/md.c                                    |   4 +-
 drivers/md/raid5.c                                 |  13 ++-
 drivers/media/i2c/soc_camera/ov6650.c              |   2 +-
 drivers/media/pci/solo6x10/solo6x10-v4l2.c         |  11 ++
 drivers/media/platform/vsp1/vsp1_drm.c             |   1 +
 drivers/media/platform/vsp1/vsp1_drv.c             |  16 ++-
 drivers/media/platform/vsp1/vsp1_video.c           |  13 +++
 drivers/media/usb/cpia2/cpia2_v4l.c                |   4 +-
 drivers/misc/Makefile                              |   2 +
 drivers/misc/enclosure.c                           |   7 +-
 drivers/mtd/nand/fsl_ifc_nand.c                    |   7 ++
 drivers/mtd/nand/nand_base.c                       |   9 +-
 drivers/net/bonding/bond_main.c                    |  35 +++---
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c     |   1 +
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h     |   1 +
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c   |  31 +++---
 drivers/net/ethernet/broadcom/bgmac-bcma.c         |  39 ++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  10 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |   5 +
 drivers/net/ethernet/faraday/ftgmac100.c           |   1 +
 drivers/net/ethernet/freescale/fec_main.c          |  26 +++--
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c  |  23 ++--
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |  11 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c  |   1 -
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |   5 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   |   8 +-
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c   |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   5 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  19 ++--
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         |  12 +--
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   1 +
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |   1 +
 drivers/net/ethernet/marvell/mvpp2.c               |  14 +++
 drivers/net/ethernet/qlogic/qed/qed_cxt.c          |  32 ++++--
 drivers/net/ethernet/qlogic/qed/qed_main.c         |   3 +-
 drivers/net/ethernet/qlogic/qed/qed_sriov.c        |  13 ++-
 drivers/net/ieee802154/adf7242.c                   |   4 +-
 drivers/net/ipvlan/ipvlan_core.c                   |   4 +
 drivers/net/phy/mdio-xgene.c                       |   2 +-
 drivers/net/veth.c                                 |   3 +
 drivers/net/vxlan.c                                |   5 +
 drivers/net/wireless/ath/ath10k/ce.c               |   2 +-
 drivers/net/wireless/ath/ath10k/debug.c            |   9 ++
 drivers/net/wireless/ath/ath10k/mac.c              |  12 ++-
 drivers/net/wireless/ath/ath10k/wmi.c              |   5 +
 drivers/net/wireless/ath/ath10k/wmi.h              |   3 +-
 drivers/net/wireless/ath/wil6210/main.c            |  20 +++-
 drivers/net/wireless/ath/wil6210/wmi.c             |  11 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c        |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |  18 +++-
 drivers/net/wireless/mac80211_hwsim.c              |  26 ++---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |   6 ++
 drivers/net/wireless/marvell/mwifiex/sdio.c        |   4 +-
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c       |   3 +
 drivers/nfc/nfcmrvl/fw_dnld.c                      |   2 +-
 drivers/nfc/nfcmrvl/spi.c                          |   5 +-
 drivers/nfc/pn533/i2c.c                            |   4 +-
 drivers/of/device.c                                |   2 +-
 drivers/pci/host/pci-hyperv.c                      |  24 ++++-
 drivers/pci/pci-driver.c                           |   2 -
 drivers/pci/quirks.c                               |   3 +
 drivers/perf/arm_pmu.c                             |  12 ++-
 drivers/power/supply/ab8500_charger.c              |   6 +-
 drivers/pwm/pwm-stmpe.c                            |   2 +-
 drivers/pwm/pwm-tegra.c                            |   7 +-
 drivers/regulator/core.c                           |   9 +-
 drivers/scsi/be2iscsi/be_cmds.c                    |   6 ++
 drivers/scsi/fnic/fnic_scsi.c                      |  16 +--
 drivers/scsi/ipr.c                                 |  16 ++-
 drivers/scsi/qla2xxx/qla_os.c                      |   8 +-
 drivers/scsi/scsi_devinfo.c                        |   9 +-
 drivers/scsi/scsi_dh.c                             |   5 +-
 drivers/scsi/ses.c                                 |  12 ++-
 drivers/scsi/sg.c                                  |  35 +++---
 drivers/spi/spi-omap2-mcspi.c                      |   9 +-
 drivers/spi/spi-sun6i.c                            |   2 +-
 drivers/staging/speakup/kobjects.c                 |   8 +-
 drivers/staging/wilc1000/host_interface.c          |   2 +
 drivers/tty/serial/amba-pl011.c                    |  23 ++--
 drivers/tty/serial/imx.c                           |  36 ++++---
 drivers/usb/dwc2/hcd.c                             |   1 +
 drivers/usb/dwc3/core.c                            |   6 ++
 drivers/usb/dwc3/core.h                            |  17 +--
 drivers/usb/gadget/udc/bdc/bdc_core.c              |   2 +-
 drivers/usb/gadget/udc/bdc/bdc_pci.c               |   1 +
 drivers/usb/gadget/udc/dummy_hcd.c                 |  20 ++--
 drivers/usb/misc/lvstest.c                         |   1 +
 drivers/vfio/vfio_iommu_spapr_tce.c                |  13 +++
 drivers/video/fbdev/amba-clcd.c                    |   4 +-
 drivers/video/fbdev/omap2/omapfb/dss/dss.c         |  16 ++-
 drivers/video/hdmi.c                               |  51 +++++----
 fs/aio.c                                           |  44 +++++---
 fs/btrfs/volumes.c                                 |  12 ++-
 fs/dcache.c                                        |  11 +-
 fs/f2fs/gc.c                                       |   6 +-
 fs/namei.c                                         |   8 +-
 fs/nfs/super.c                                     |   2 +
 fs/reiserfs/journal.c                              |   2 +-
 fs/reiserfs/reiserfs.h                             |   1 +
 fs/reiserfs/super.c                                |  21 ++--
 include/linux/fs.h                                 |   1 +
 include/linux/pagemap.h                            |   4 +-
 include/linux/platform_data/isl9305.h              |   2 +-
 include/linux/regulator/driver.h                   |   2 +
 include/net/tcp.h                                  |   8 +-
 include/soc/tegra/pmc.h                            |  29 +++--
 include/uapi/linux/eventpoll.h                     |   8 +-
 kernel/locking/locktorture.c                       |  76 +++++++------
 kernel/locking/rtmutex.c                           |  29 ++++-
 kernel/locking/rtmutex_common.h                    |   1 +
 kernel/printk/braille.c                            |  15 +--
 kernel/printk/braille.h                            |  13 ++-
 kernel/printk/printk.c                             |   8 +-
 kernel/sched/core.c                                |   3 +-
 kernel/sched/rt.c                                  |   2 +-
 kernel/time/sched_clock.c                          |   5 +
 kernel/time/timer_list.c                           |   6 ++
 net/8021q/vlan_dev.c                               |   3 +-
 net/batman-adv/bridge_loop_avoidance.c             |  20 +++-
 net/bluetooth/6lowpan.c                            |  10 +-
 net/bluetooth/af_bluetooth.c                       |  24 +++++
 net/mac80211/iface.c                               |   2 +-
 net/sched/act_csum.c                               |  12 +++
 net/sched/sch_netem.c                              |  26 +++--
 net/xfrm/xfrm_policy.c                             |   2 +-
 net/xfrm/xfrm_state.c                              |   7 ++
 security/apparmor/lsm.c                            |   2 +-
 security/integrity/ima/ima_appraise.c              |   3 +-
 security/selinux/hooks.c                           |   8 ++
 sound/core/oss/pcm_oss.c                           |  10 +-
 sound/core/seq/seq_clientmgr.c                     |   4 +-
 sound/core/seq/seq_prioq.c                         |  28 ++---
 sound/core/seq/seq_prioq.h                         |   6 +-
 sound/core/seq/seq_queue.c                         |  28 ++---
 sound/firewire/amdtp-stream.c                      |   5 +-
 sound/firewire/amdtp-stream.h                      |   3 +
 sound/firewire/digi00x/amdtp-dot.c                 |  55 ++++++----
 sound/firewire/digi00x/digi00x.c                   |  13 ++-
 sound/firewire/digi00x/digi00x.h                   |   1 +
 sound/pci/hda/hda_intel.c                          |  13 ++-
 sound/soc/codecs/rt5677.c                          |   7 ++
 sound/soc/nuc900/nuc900-ac97.c                     |   4 +-
 sound/soc/sh/rcar/ssi.c                            |   9 ++
 tools/perf/builtin-probe.c                         |   6 +-
 tools/perf/builtin-stat.c                          |  23 +++-
 tools/perf/builtin-trace.c                         |  43 ++++++--
 tools/perf/util/annotate.c                         |  10 +-
 tools/perf/util/build-id.c                         |   6 +-
 tools/perf/util/event.c                            |   4 +-
 tools/perf/util/evsel.c                            |  12 ++-
 tools/perf/util/ordered-events.c                   |   3 +-
 tools/perf/util/probe-event.c                      |   2 +-
 tools/perf/util/session.c                          |  17 ++-
 tools/perf/util/sort.c                             |   5 +
 tools/testing/selftests/firmware/fw_filesystem.sh  |   5 +-
 .../testing/selftests/rcutorture/bin/configinit.sh |   2 +-
 tools/testing/selftests/x86/entry_from_vm86.c      | 117 ++++++++++++++++++++-
 tools/usb/usbip/src/usbipd.c                       |   2 +-
 240 files changed, 1802 insertions(+), 691 deletions(-)
