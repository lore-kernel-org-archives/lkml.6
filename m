Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2733426-1524409458-2-16303425206278965531
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524409457; b=rj0WEjXPnaLqV01CUgBHiNQbZAKVVFr9fgGTnzXtZq9WtNJeMq
    yHyEtY94bNLJ7qTMC+SNidtHr09GvbFXfEYLHpLZ5Xmk+gskgT5SFcvOSfnnIa4D
    aFvPTKi0TMkyKRA44od7EhDsfqzSxKfTnq2+m+xgtPwWkkq5/HVcNNK9zlyh1nxr
    AbPd3kNefiz6OX1RdsDttQdrRIh26wRam/5IiZ2txSAQx0faXmtgaBpMy1OhgNZA
    LXYWH98UMRQygep+7IyOYeA3BbuKRSjGa+fKqighCWAeKgw9gFm/212j2Rg/1Jr/
    MwZAYZfYZ5SwA010DEHgg0YwUxzjxFH5EL/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1524409457; bh=osE5LVE/V1LOQ9M8OISVjqC+zT2k6X
    sWSRl5WfznuUw=; b=sfoLb/58AGQ8GgHXJmYgguHWr8gIdLSiAiViBgs8GGXmC0
    WN6SNNxyi4cjHFXVMhWqCgWmoUCTuI685285RHalmbUl3fvPOjokmka0DjYJlOit
    Na8VnIF+PeVjym1S6e2mssbIlMidAbdHAPSFEOwnbumMwIAIe+y+2xD6Jss7WLK2
    UNTc5hSLu8GzPrSIWhZnrhcyrQF08D1/09vvxutzwVasBLLKvIowXIJCPnndDsYF
    hQaGBLzyyaBvzj981QneHkRwnebc9m+ydo9rHOq1Xlnmuv6RuLjrQeezHZGwosq/
    ybffYITPkb5GjdATQ9X3C6NRKoYwiYUx9TmvyRFw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE1o2B1IzoAHU2szVIdEN+W7VDty16wFttXkW0M5I8Mi3TzvTABAkXcp/sNe+6vBgBnik4BNVe7VWdK14sgQCxQtU1KeFBhxvDwIzYdvLWa9Rfn/gPhm
    EtU5lu1gtdcHQA/DuFbk6Tkie8PrsL+zpb/tasQbA0dG1VSPbqv92IOMyLMiTPzfeNCYTHRIvCRgJm7vDmOjazBbf/0vWTBfO4BLXfXfuITg64weC2zpkNq+
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=RMlRvZAwo0AA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=69EAbJreAAAA:8
    a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=jUFqNg-nAAAA:8
    a=drOt6m5kAAAA:8 a=uAS_uZ3KAAAA:8 a=gPJu0pBYAAAA:8 a=s_NOnkg2AAAA:8
    a=CjxXgO3LAAAA:8 a=7CQSdrXTAAAA:8 a=zd2uoN0lAAAA:8 a=cm27Pg_UAAAA:8
    a=20KFwNOVAAAA:8 a=mpaa-ttXAAAA:8 a=tCkLEFQzAAAA:8 a=yC-0_ovQAAAA:8
    a=P-IC7800AAAA:8 a=r_1tXGB3AAAA:8 a=QyXUC8HyAAAA:8 a=Q-BEZFIeAAAA:8
    a=UGG5zPGqAAAA:8 a=JF9118EUAAAA:8 a=WTJdmG3rAAAA:8 a=Ikd4Dj_1AAAA:8
    a=DfNHnWVPAAAA:8 a=jIQo8A4GAAAA:8 a=yPCof4ZbAAAA:8 a=XYAwZIGsAAAA:8
    a=hD80L64hAAAA:8 a=Z4Rwk6OoAAAA:8 a=7vM-3zkYczvFnKriFFEA:9
    a=on0IuRp93qX-byNt:21 a=H1zLtuJzykiq7ABL:21 a=QEXdDO2ut3YA:10
    a=V0ZB0er3tgIA:10 a=kIYM4FBh2PkA:10 a=RdtxUbJDZeoA:10 a=ktRoTHy9pvUA:10
    a=dH3AY38zAK4A:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=-tElvS_Zar9K8zhlwiSp:22 a=RMMjzBEyIzXRtoq5n5K6:22 a=_KzJdI3Ai4rueFdl_XLO:22
    a=AlIIF0cMT2hfDT4axODj:22 a=rnSQA9y58HElrkoqsYbd:22 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=xmb-EsYY8bH0VWELuYED:22 a=6heAxKwa5pAsJatQ0mat:22 a=bfrCAK1mvQf1AxxUnQma:22
    a=QsnFDINu91a9xkgZirup:22 a=d3PnA9EDa4IxuAV0gXij:22 a=t8nPyN_e6usw4ciXM-Pk:22
    a=5ZtAvbtPDreVYrn1SqM_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754269AbeDVPEE (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 11:04:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54770 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756609AbeDVOMC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:12:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/95] 4.9.96-stable review
Date: Sun, 22 Apr 2018 15:52:29 +0200
Message-Id: <20180422135210.432103639@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.96-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.96-rc1
X-KernelTest-Deadline: 2018-04-24T13:52+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.9.96 release.
There are 95 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue Apr 24 13:51:53 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.96-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.96-rc1

Wanpeng Li <wanpeng.li@hotmail.com>
    block/mq: fix potential deadlock during cpu hotplug

Greg Thelen <gthelen@google.com>
    writeback: safer lock nesting

Amir Goldstein <amir73il@gmail.com>
    fanotify: fix logic of events on child

Matthew Wilcox <mawilcox@microsoft.com>
    mm/filemap.c: fix NULL pointer in page_cache_tree_insert()

Ian Kent <raven@themaw.net>
    autofs: mount point create should honour passed in mode

Al Viro <viro@zeniv.linux.org.uk>
    Don't leak MNT_INTERNAL away from internal mounts

Al Viro <viro@zeniv.linux.org.uk>
    rpc_pipefs: fix double-dput()

Al Viro <viro@zeniv.linux.org.uk>
    orangefs_kill_sb(): deal with allocation failures

Al Viro <viro@zeniv.linux.org.uk>
    hypfs_kill_super(): deal with failed allocations

Al Viro <viro@zeniv.linux.org.uk>
    jffs2_kill_sb(): deal with failed allocations

Jan Kara <jack@suse.cz>
    udf: Fix leak of UTF-16 surrogates into encoded strings

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/lib: Fix off-by-one in alternate feature patching

Michael Neuling <mikey@neuling.org>
    powerpc/eeh: Fix enabling bridge MMIO windows

Matt Redfearn <matt.redfearn@mips.com>
    MIPS: memset.S: Fix clobber of v1 in last_fixup

Matt Redfearn <matt.redfearn@mips.com>
    MIPS: memset.S: Fix return of __clear_user from Lpartial_fixup

Matt Redfearn <matt.redfearn@mips.com>
    MIPS: memset.S: EVA & fault support for small_memset

Matt Redfearn <matt.redfearn@mips.com>
    MIPS: uaccess: Add micromips clobbers to bzero invocation

Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
    HID: hidraw: Fix crash on HIDIOCGFEATURE with a destroyed device

Theodore Ts'o <tytso@mit.edu>
    random: add new ioctl RNDRESEEDCRNG

Theodore Ts'o <tytso@mit.edu>
    random: crng_reseed() should lock the crng instance that it is modifying

Theodore Ts'o <tytso@mit.edu>
    random: set up the NUMA crng instances after the CRNG is fully initialized

Theodore Ts'o <tytso@mit.edu>
    random: fix crng_ready() test

David Wang <davidwang@zhaoxin.com>
    ALSA: hda - New VIA controller suppor no-snoop path

Takashi Iwai <tiwai@suse.de>
    ALSA: rawmidi: Fix missing input substream checks in compat ioctls

Fabián Inostroza <soulsonceonfire@gmail.com>
    ALSA: line6: Use correct endpoint type for midi output

Paul Parsons <lost.distance@yahoo.com>
    drm/radeon: Fix PCIe lane width calculation

Marc Zyngier <marc.zyngier@arm.com>
    drm/rockchip: Clear all interrupts before requesting the IRQ

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: Fix PCIe lane width calculation

Bas Nieuwenhuizen <basni@chromium.org>
    drm/amdgpu: Fix always_valid bos multiple LRU insertions.

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: Add an ATPX quirk for hybrid laptop

Theodore Ts'o <tytso@mit.edu>
    ext4: don't allow r/w mounts if metadata blocks overlap the superblock

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix endless loop for XRUN recovery in OSS emulation

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix mutex unbalance in OSS emulation ioctls

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Return -EBUSY for OSS ioctls changing busy streams

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Avoid potential races between OSS ioctls and read/write

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Use ERESTARTSYS instead of EINTR in OSS emulation

Alex Williamson <alex.williamson@redhat.com>
    vfio/pci: Virtualize Maximum Read Request Size

Igor Pylypiv <igor.pylypiv@gmail.com>
    watchdog: f71808e_wdt: Fix WD_EN register read

Sean Wang <sean.wang@mediatek.com>
    dt-bindings: clock: mediatek: add binding for fixed-factor clock axisel_d4

Mikhail Lappo <mikhail.lappo@esrlabs.com>
    thermal: imx: Fix race condition in imx_thermal_probe()

Ryo Kodama <ryo.kodama.vz@renesas.com>
    pwm: rcar: Fix a condition to prevent mismatch value setting to duty

Boris Brezillon <boris.brezillon@bootlin.com>
    clk: bcm2835: De-assert/assert PLL reset signal when appropriate

Arnd Bergmann <arnd@arndb.de>
    clk: fix false-positive Wmaybe-uninitialized warning

Richard Genoud <richard.genoud@gmail.com>
    clk: mvebu: armada-38x: add support for missing clocks

Ralph Sennhauser <ralph.sennhauser@gmail.com>
    clk: mvebu: armada-38x: add support for 1866MHz variants

Alex Smith <alex.smith@imgtec.com>
    mmc: jz4740: Fix race condition in IRQ mask update

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Fix a potential memory leak

Krzysztof Mazur <krzysiek@podlesie.net>
    um: Use POSIX ucontext_t instead of struct ucontext

Jason A. Donenfeld <Jason@zx2c4.com>
    um: Compile with modern headers

Dan Williams <dan.j.williams@intel.com>
    nfit, address-range-scrub: fix scrub in-progress reporting

Dan Williams <dan.j.williams@intel.com>
    libnvdimm, namespace: use a safe lookup for dimm device name

Maxime Jayat <maxime.jayat@mobile-devices.fr>
    dmaengine: at_xdmac: fix rare residue corruption

Bart Van Assche <bart.vanassche@wdc.com>
    IB/srp: Fix completion vector assignment algorithm

Bart Van Assche <bart.vanassche@wdc.com>
    IB/srp: Fix srp_abort()

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix UAF at PCM release via PCM timer access

Bart Van Assche <bart.vanassche@wdc.com>
    RDMA/rxe: Fix an out-of-bounds read

Roland Dreier <roland@purestorage.com>
    RDMA/ucma: Don't allow setting RDMA_OPTION_IB_PATH without an RDMA device

Theodore Ts'o <tytso@mit.edu>
    ext4: fail ext4_iget for root directory if unallocated

Theodore Ts'o <tytso@mit.edu>
    ext4: add validity checks for bitmap block numbers

Eryu Guan <guaneryu@gmail.com>
    ext4: protect i_disksize update by i_data_sem in direct write path

Theodore Ts'o <tytso@mit.edu>
    ext4: don't update checksum of new initialized bitmaps

Theodore Ts'o <tytso@mit.edu>
    jbd2: if the journal is aborted then don't allow update of the log tail

Theodore Ts'o <tytso@mit.edu>
    random: use a tighter cap in credit_entropy_bits_safe()

Aniruddha Banerjee <aniruddhab@nvidia.com>
    irqchip/gic: Take lock when updating irq type

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Resume control channel after hibernation image is created

James Kelly <jamespeterkelly@gmail.com>
    ASoC: ssm2602: Replace reg_default_raw with reg_default

Aaron Ma <aaron.ma@canonical.com>
    HID: core: Fix size as type u32

Aaron Ma <aaron.ma@canonical.com>
    HID: Fix hid_report_len usage

Nicholas Piggin <npiggin@gmail.com>
    powerpc/powernv: Fix OPAL NVRAM driver OPAL_BUSY loops

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64: Fix smp_wmb barrier definition use use lwsync consistently

Nicholas Piggin <npiggin@gmail.com>
    powerpc/powernv: Handle unknown OPAL errors in opal_nvram_write()

Aaron Ma <aaron.ma@canonical.com>
    HID: i2c-hid: fix size check and type usage

Steve French <stfrench@microsoft.com>
    smb3: Fix root directory when server returns inode number of zero

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: pci: Properly cleanup resource

Zhengjun Xing <zhengjun.xing@linux.intel.com>
    USB:fix USB3 devices behind USB3 hubs not resuming at hibernate thaw

Yavuz, Tuba <tuba@ece.ufl.edu>
    USB: gadget: f_midi: fixing a possible double-free in f_midi

Mika Westerberg <mika.westerberg@linux.intel.com>
    ACPI / hotplug / PCI: Check presence of slot itself in get_slot_status()

Hans de Goede <hdegoede@redhat.com>
    ACPI / video: Add quirk to force acpi-video backlight on Samsung 670Z5E

Dan Carpenter <dan.carpenter@oracle.com>
    regmap: Fix reversed bounds check in regmap_raw_write()

Jason Andryuk <jandryuk@gmail.com>
    xen-netfront: Fix hang on device removal

Maxime Chevallier <maxime.chevallier@bootlin.com>
    spi: Fix scatterlist elements size in spi_map_buf

Santiago Esteban <Santiago.Esteban@microchip.com>
    ARM: dts: at91: sama5d4: fix pinctrl compatible string

Marek Szyprowski <m.szyprowski@samsung.com>
    ARM: dts: exynos: Fix IOMMU support for GScaler devices on Exynos5250

Nicolas Ferre <nicolas.ferre@microchip.com>
    ARM: dts: at91: at91sam9g25: fix mux-mask pinctrl property

Felipe Balbi <felipe.balbi@linux.intel.com>
    usb: gadget: udc: core: update usb_ep_queue() documentation

Heinrich Schuchardt <xypron.glpk@gmx.de>
    usb: musb: gadget: misplaced out of bounds check

Vlastimil Babka <vbabka@suse.cz>
    mm, slab: reschedule cache_reap() on the same CPU

Eric Biggers <ebiggers@google.com>
    ipc/shm: fix use-after-free of shm file via remap_file_pages()

Takashi Iwai <tiwai@suse.de>
    resource: fix integer overflow at reallocation

Andrew Morton <akpm@linux-foundation.org>
    fs/reiserfs/journal.c: add missing resierfs_warning() arg

Richard Weinberger <richard@nod.at>
    ubi: Reject MLC NAND

Romain Izard <romain.izard.pro@gmail.com>
    ubi: Fix error for write access

Richard Weinberger <richard@nod.at>
    ubi: fastmap: Don't flush fastmap work on detach

Richard Weinberger <richard@nod.at>
    ubifs: Check ubifs_wbuf_sync() return code

Tejun Heo <tj@kernel.org>
    tty: make n_tty_read() always abort if hangup is in progress


-------------

Diffstat:

 Makefile                                         |   4 +-
 arch/arm/boot/dts/at91sam9g25.dtsi               |   2 +-
 arch/arm/boot/dts/exynos5250.dtsi                |   8 +-
 arch/arm/boot/dts/sama5d4.dtsi                   |   2 +-
 arch/mips/include/asm/uaccess.h                  |  11 +-
 arch/mips/lib/memset.S                           |  11 +-
 arch/powerpc/include/asm/barrier.h               |   3 +-
 arch/powerpc/include/asm/synch.h                 |   4 -
 arch/powerpc/kernel/eeh_pe.c                     |   3 +-
 arch/powerpc/lib/feature-fixups.c                |   2 +-
 arch/powerpc/platforms/powernv/opal-nvram.c      |  11 +-
 arch/s390/hypfs/inode.c                          |   2 +-
 arch/um/os-Linux/file.c                          |   1 +
 arch/um/os-Linux/signal.c                        |   3 +-
 arch/x86/um/stub_segv.c                          |   3 +-
 block/blk-mq.c                                   |   4 +-
 drivers/acpi/nfit/core.c                         |   5 +-
 drivers/acpi/video_detect.c                      |   9 ++
 drivers/base/regmap/regmap.c                     |   2 +-
 drivers/char/random.c                            |  75 +++++----
 drivers/clk/bcm/clk-bcm2835.c                    |   8 +-
 drivers/clk/mvebu/armada-38x.c                   |  15 +-
 drivers/clk/renesas/clk-sh73a0.c                 |   6 +-
 drivers/dma/at_xdmac.c                           |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c      |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |   2 +-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c              |   4 +-
 drivers/gpu/drm/radeon/si_dpm.c                  |   4 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c      |  23 +--
 drivers/hid/hid-core.c                           |  10 +-
 drivers/hid/hid-input.c                          |   3 +-
 drivers/hid/hid-multitouch.c                     |   5 +-
 drivers/hid/hid-rmi.c                            |   4 +-
 drivers/hid/hidraw.c                             |   5 +
 drivers/hid/i2c-hid/i2c-hid.c                    |  13 +-
 drivers/hid/wacom_sys.c                          |   2 +-
 drivers/infiniband/core/ucma.c                   |   3 +
 drivers/infiniband/sw/rxe/rxe_verbs.c            |   5 +-
 drivers/infiniband/ulp/srp/ib_srp.c              |  18 +--
 drivers/iommu/intel-svm.c                        |   1 +
 drivers/irqchip/irq-gic-common.c                 |   9 +-
 drivers/mmc/host/jz4740_mmc.c                    |   2 +-
 drivers/mtd/ubi/block.c                          |   2 +-
 drivers/mtd/ubi/build.c                          |  11 ++
 drivers/mtd/ubi/fastmap-wl.c                     |   1 -
 drivers/net/xen-netfront.c                       |   7 +-
 drivers/nvdimm/namespace_devs.c                  |   4 +-
 drivers/pci/hotplug/acpiphp_glue.c               |  23 ++-
 drivers/pwm/pwm-rcar.c                           |   8 +-
 drivers/spi/spi.c                                |  10 +-
 drivers/thermal/imx_thermal.c                    |   6 +-
 drivers/thunderbolt/nhi.c                        |   1 +
 drivers/tty/n_tty.c                              |   6 +
 drivers/tty/tty_io.c                             |   9 ++
 drivers/usb/core/generic.c                       |   9 +-
 drivers/usb/dwc3/dwc3-pci.c                      |   2 +-
 drivers/usb/gadget/function/f_midi.c             |   3 +-
 drivers/usb/gadget/u_f.h                         |   2 +
 drivers/usb/gadget/udc/core.c                    |   3 +
 drivers/usb/musb/musb_gadget_ep0.c               |  14 +-
 drivers/vfio/pci/vfio_pci_config.c               |  29 +++-
 drivers/watchdog/f71808e_wdt.c                   |   2 +-
 fs/autofs4/root.c                                |   2 +-
 fs/cifs/cifsglob.h                               |   1 +
 fs/cifs/inode.c                                  |  33 ++++
 fs/ext4/balloc.c                                 |  19 ++-
 fs/ext4/ialloc.c                                 |  54 ++-----
 fs/ext4/inode.c                                  |  11 +-
 fs/ext4/super.c                                  |   6 +
 fs/fs-writeback.c                                |   7 +-
 fs/jbd2/journal.c                                |   5 +-
 fs/jffs2/super.c                                 |   2 +-
 fs/namespace.c                                   |   3 +-
 fs/notify/fanotify/fanotify.c                    |  34 ++---
 fs/orangefs/super.c                              |   5 +
 fs/reiserfs/journal.c                            |   2 +-
 fs/ubifs/super.c                                 |  14 +-
 fs/udf/unicode.c                                 |   6 +
 include/dt-bindings/clock/mt2701-clk.h           |   3 +-
 include/linux/backing-dev-defs.h                 |   5 +
 include/linux/backing-dev.h                      |  30 ++--
 include/linux/hid.h                              |   6 +-
 include/linux/tty.h                              |   1 +
 include/sound/pcm_oss.h                          |   1 +
 include/uapi/linux/random.h                      |   3 +
 ipc/shm.c                                        |  23 ++-
 kernel/resource.c                                |   3 +-
 mm/filemap.c                                     |   9 +-
 mm/page-writeback.c                              |  18 +--
 mm/slab.c                                        |   3 +-
 net/sunrpc/rpc_pipe.c                            |   1 +
 sound/core/oss/pcm_oss.c                         | 186 ++++++++++++++++++-----
 sound/core/pcm.c                                 |   8 +-
 sound/core/rawmidi_compat.c                      |  18 ++-
 sound/pci/hda/hda_intel.c                        |   3 +-
 sound/soc/codecs/ssm2602.c                       |  19 ++-
 sound/usb/line6/midi.c                           |   2 +-
 98 files changed, 694 insertions(+), 322 deletions(-)
