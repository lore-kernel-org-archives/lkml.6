Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1591105-1523025873-2-14286084897182748910
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523025871; b=a36jD8xgizwPLzZEfgjJzor0+FfGZGe4n+7Kj8yN/2wmQEZn9N
    KMZHDyhkwYh/8qpIBSAk167M9Lr7j5nQu3JaYXxUGvZKhb4Dv2NLhurcOe3IiNE8
    vQ2AwwOVKwKDM77GgPGB6lLJYOh8VGPZkpXUdUbx8FaTCefAdc1dcdaS5wZ0FgUJ
    EFMGYI68PFQDg+rKjNjgHCNzfSTdrm9zAlUaciSuGBO2q6rrlaXHL9iS2d4Mi0Ke
    FLeI7a4gIEjsO7HWaNLzQGHAd7icB5wWv8b/BCPcbB8+JUuT1AEA1dOEpNhZ3P0Q
    G9sDYsWPpfeAfkyPhy6j8UjIR5WZWPmQ+zaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523025871; bh=Ridg8hLTBLl3bwL90rLpA2d5xTiuLy
    fz9ESkCiaKrpI=; b=ACR0DGvvqniu3SlvQBYMEoZna6KpFGHeOaFvRxf6E2YN6L
    uJdOnuGi6C0XI8UtEJFZi0tkBHFCFEtwgxynMEkdHZ2bHpRfNiECo03ThW6ioP+9
    uJdwAKyfH7O5R0nnSg/UGeHl2aw2ShtiYKQiD1vwYqXzsf5h3NU2k/Yxn5qEzvut
    aqffr5pjBJFQJ5xrToHy2JTLYQbJlwjSAkSy7bfEMvrK/SLZZ/0nZt0lRakPnuj0
    wBSFFgXdhU0FfUZf5v7uonE2/c3ezPcKR9KvcawJz1SdF0tbEmIo7r6wySEilxdZ
    4JlzfeTp6CMV8V7V/aX2V3BxqQi+zBbLsVUK5Dsg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfNJ9rtLn9nGHfaMMqQZTGcoADYDtaHrEypnhsWUKweAW1sMQZtfmimf15DdX5gS1BQX6UGe3oW9Qk+t2C/K9zV7LwcaHffmvrsB8Y/Jav6gWd/7frHrn
    4yThFrqRLyoD6x2vpY1fZIW2p8wPPmtiYWLkNGMrxRXDEzXEU+Q7NoVg/0n91n4lkU4LsRmECzCivZsJIgCrpbxnGLYbOKAToNjn10aw8rvk3hb3yOUox2T9
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=zoehSAk54XIA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8
    a=iox4zFpeAAAA:8 a=sozttTNsAAAA:8 a=cm27Pg_UAAAA:8 a=AgaioDkCAAAA:8
    a=7ZN4cI0QAAAA:8 a=CEwII1yZAAAA:8 a=1XWaLZrsAAAA:8 a=FNyBlpCuAAAA:8
    a=ttLlOQO2AAAA:8 a=DfNHnWVPAAAA:8 a=xLcVsCfpAAAA:8 a=7CQSdrXTAAAA:8
    a=enOvQawGAAAA:8 a=KKAkSRfTAAAA:8 a=WTJdmG3rAAAA:8 a=CbDCq_QkAAAA:8
    a=yPCof4ZbAAAA:8 a=Z4Rwk6OoAAAA:8 a=aHr7xeNNrKMY3m4Tx8cA:9
    a=fSAqPH4FmJAU5_3a:21 a=gud0FQcXJYPqvJum:21 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=aeg5Gbbo78KNqacMgKqU:22
    a=xmb-EsYY8bH0VWELuYED:22 a=eNS--96rZ24oWIaEtn_1:22 a=Dl0WHwQvj8hGZljrFLtM:22
    a=4LuAaoAPjBjBTe8K2uIj:22 a=RlW-AWeGUCXs_Nkyno-6:22 a=1BJeXTq6bvZE9X1NrNaC:22
    a=rjTVMONInIDnV1a_A2c_:22 a=4-ZGFxpmiTxXQSWJmrgh:22 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=OuzhcWw_GC9nAYdNdRwA:22 a=cvBusfyB2V15izCimMoJ:22 a=q3NGepEMMmKWaCv8Sx90:22
    a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755763AbeDFNeH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:34:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58116 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755731AbeDFNeB (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:34:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 000/102] 4.9.93-stable review
Date: Fri,  6 Apr 2018 15:22:41 +0200
Message-Id: <20180406084331.507038179@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.93-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.93-rc1
X-KernelTest-Deadline: 2018-04-08T08:43+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.9.93 release.
There are 102 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Apr  8 08:42:55 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.93-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.93-rc1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    spi: davinci: fix up dma_mapping_error() incorrect patch

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "ip6_vti: adjust vti mtu according to mtu of lower device"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "mtip32xx: use runtime tag to initialize command header"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "spi: bcm-qspi: shut up warning about cfi header inclusion"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "ARM: dts: omap3-n900: Fix the audio CODEC's reset pin"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "ARM: dts: am335x-pepper: Fix the audio CODEC's reset pin"

Mikulas Patocka <mpatocka@redhat.com>
    Fix slab name "biovec-(1<<(21-12))"

Matthias Brugger <matthias.bgg@gmail.com>
    net: hns: Fix ethtool private flags

Guoqing Jiang <gqjiang@suse.com>
    md/raid10: reset the 'first' at the end of loop

Keerthy <j-keerthy@ti.com>
    ARM: dts: am57xx-idk-common: Add overide powerhold property

Keerthy <j-keerthy@ti.com>
    ARM: dts: am57xx-beagle-x15-common: Add overide powerhold property

Keerthy <j-keerthy@ti.com>
    ARM: dts: dra7: Add power hold and power controller properties to palmas

Keerthy <j-keerthy@ti.com>
    Documentation: pinctrl: palmas: Add ti,palmas-powerhold-override property definition

Mike Frysinger <vapier@chromium.org>
    vt: change SGR 21 to follow the standards

Ondrej Zary <linux@rainbow-software.org>
    Input: i8042 - enable MUX on Sony VAIO VGN-CS series to fix touchpad

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    Input: i8042 - add Lenovo ThinkPad L460 to i8042 reset list

Masaki Ota <masaki.ota@jp.alps.com>
    Input: ALPS - fix TrackStick detection on Thinkpad L570 and Latitude 7370

Frank Mori Hess <fmh6jj@gmail.com>
    staging: comedi: ni_mio_common: ack ai fifo error interrupts.

Eric Biggers <ebiggers@google.com>
    crypto: x86/cast5-avx - fix ECB encryption when long sg follows short one

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: ahash - Fix early termination in hash walk

Alexander Gerasiov <gq@redlab-i.ru>
    parport_pc: Add support for WCH CH382L PCI-E single parallel port card.

Oliver Neukum <oneukum@suse.com>
    media: usbtv: prevent double free in error case

Colin Ian King <colin.king@canonical.com>
    mei: remove dev_err message on an unsupported ioctl

Johan Hovold <johan@kernel.org>
    USB: serial: cp210x: add ELDAT Easywave RX09 id

Clemens Werther <clemens.werther@gmail.com>
    USB: serial: ftdi_sio: add support for Harman FirmwareHubEmulator

Major Hayden <major@mhtx.net>
    USB: serial: ftdi_sio: add RT Systems VX-8 cable

Will Deacon <will.deacon@arm.com>
    arm64: idmap: Use "awx" flags for .idmap.text .pushsection directives

Will Deacon <will.deacon@arm.com>
    arm64: entry: Reword comment about post_ttbr_update_workaround

Marc Zyngier <marc.zyngier@arm.com>
    arm64: Force KPTI to be disabled on Cavium ThunderX

Will Deacon <will.deacon@arm.com>
    arm64: kpti: Add ->enable callback to remap swapper using nG mappings

Will Deacon <will.deacon@arm.com>
    arm64: kpti: Make use of nG dependent on arm64_kernel_unmapped_at_el0()

Jayachandran C <jnair@caviumnetworks.com>
    arm64: Turn on KPTI only on CPUs that need it

Jayachandran C <jnair@caviumnetworks.com>
    arm64: cputype: Add MIDR values for Cavium ThunderX2 CPUs

Suzuki K Poulose <suzuki.poulose@arm.com>
    arm64: capabilities: Handle duplicate entries for a capability

Marc Zyngier <marc.zyngier@arm.com>
    arm64: Allow checking of a CPU-local erratum

Will Deacon <will.deacon@arm.com>
    arm64: Take into account ID_AA64PFR0_EL1.CSV3

Will Deacon <will.deacon@arm.com>
    arm64: Kconfig: Reword UNMAP_KERNEL_AT_EL0 kconfig entry

Will Deacon <will.deacon@arm.com>
    arm64: Kconfig: Add CONFIG_UNMAP_KERNEL_AT_EL0

Will Deacon <will.deacon@arm.com>
    arm64: use RET instruction for exiting the trampoline

Will Deacon <will.deacon@arm.com>
    arm64: kaslr: Put kernel vectors address in separate data page

Will Deacon <will.deacon@arm.com>
    arm64: entry: Add fake CPU feature for unmapping the kernel at EL0

Will Deacon <will.deacon@arm.com>
    arm64: tls: Avoid unconditional zeroing of tpidrro_el0 for native tasks

Will Deacon <will.deacon@arm.com>
    arm64: entry: Hook up entry trampoline to exception vectors

Will Deacon <will.deacon@arm.com>
    arm64: entry: Explicitly pass exception level to kernel_ventry macro

Will Deacon <will.deacon@arm.com>
    arm64: mm: Map entry trampoline into trampoline and kernel page tables

Will Deacon <will.deacon@arm.com>
    arm64: entry: Add exception trampoline page for exceptions from EL0

AKASHI Takahiro <takahiro.akashi@linaro.org>
    module: extend 'rodata=off' boot cmdline parameter to module mappings

Mark Rutland <mark.rutland@arm.com>
    arm64: factor out entry stack manipulation

Will Deacon <will.deacon@arm.com>
    arm64: mm: Invalidate both kernel and user ASIDs when performing TLBI

Will Deacon <will.deacon@arm.com>
    arm64: mm: Add arm64_kernel_unmapped_at_el0 helper

Will Deacon <will.deacon@arm.com>
    arm64: mm: Allocate ASIDs in pairs

Will Deacon <will.deacon@arm.com>
    arm64: mm: Move ASID from TTBR0 to TTBR1

Will Deacon <will.deacon@arm.com>
    arm64: mm: Use non-global mappings for kernel space

John Stultz <john.stultz@linaro.org>
    usb: dwc2: Improve gadget state disconnection handling

Paolo Bonzini <pbonzini@redhat.com>
    scsi: virtio_scsi: always read VPD pages for multiqueue too

Alexander Potapenko <glider@google.com>
    llist: clang: introduce member_address_is_nonnull()

Szymon Janc <szymon.janc@codecoup.pl>
    Bluetooth: Fix missing encryption refresh on Security Request

Florian Westphal <fw@strlen.de>
    netfilter: x_tables: add and use xt_check_proc_name

Florian Westphal <fw@strlen.de>
    netfilter: bridge: ebt_among: add more missing match size checks

Steffen Klassert <steffen.klassert@secunet.com>
    xfrm: Refuse to insert 32 bit userspace socket policies on 64 bit systems

Greg Hackmann <ghackmann@google.com>
    net: xfrm: use preempt-safe this_cpu_read() in ipcomp_alloc_tfms()

Roland Dreier <roland@purestorage.com>
    RDMA/ucma: Introduce safer rdma_addr_size() variants

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Check that device exists prior to accessing it

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Check that device is connected prior to access it

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Ensure that CM_ID exists prior to access it

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Fix use-after-free access in ucma_close

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Check AF family prior resolving address

Florian Westphal <fw@strlen.de>
    xfrm_user: uncoditionally validate esn replay attribute struct

Nick Desaulniers <nick.desaulniers@gmail.com>
    mm/vmscan.c: fix unsequenced modification and access warning

Matthias Kaehlcke <mka@chromium.org>
    selinux: Remove redundant check for unknown labeling behavior

Nick Desaulniers <ndesaulniers@google.com>
    arm64: avoid overflow in VA_START and PAGE_OFFSET

Matthias Kaehlcke <mka@chromium.org>
    btrfs: Remove extra parentheses from condition in copy_items()

Matthias Kaehlcke <mka@chromium.org>
    mac80211: ibss: Fix channel type enum in ieee80211_sta_join_ibss()

Matthias Kaehlcke <mka@chromium.org>
    mac80211: Fix clang warning about constant operand in logical operation

Matthias Kaehlcke <mka@chromium.org>
    netfilter: ctnetlink: Make some parameters integer to avoid enum mismatch

Frank Praznik <frank.praznik@gmail.com>
    HID: sony: Use LED_CORE_SUSPENDRESUME

Matthias Kaehlcke <mka@chromium.org>
    cfg80211: Fix array-bounds warning in fragment copy

Matthias Kaehlcke <mka@chromium.org>
    nl80211: Fix enum type of variable in nl80211_put_sta_rate()

Arnd Bergmann <arnd@arndb.de>
    xgene_enet: remove bogus forward declarations

Stefan Agner <stefan@agner.ch>
    usb: gadget: remove redundant self assignment

Matthias Kaehlcke <mka@chromium.org>
    frv: declare jiffies to be located in the .data section

Matthias Kaehlcke <mka@chromium.org>
    jiffies.h: declare jiffies and jiffies_64 with ____cacheline_aligned_in_smp

Mark Charlebois <charlebm@gmail.com>
    fs: compat: Remove warning from COMPATIBLE_IOCTL

Matthias Kaehlcke <mka@chromium.org>
    selinux: Remove unnecessary check of array base in selinux_set_mapping()

Matthias Kaehlcke <mka@chromium.org>
    cpumask: Add helper cpumask_available()

Matthias Kaehlcke <mka@chromium.org>
    genirq: Use cpumask_available() for check of cpumask variable

Nick Desaulniers <ndesaulniers@google.com>
    netfilter: nf_nat_h323: fix logical-not-parentheses warning

Nick Desaulniers <nick.desaulniers@gmail.com>
    Input: mousedev - fix implicit conversion warning

Matthias Kaehlcke <mka@chromium.org>
    dm ioctl: remove double parentheses

Matthias Kaehlcke <mka@chromium.org>
    PCI: Make PCI_ROM_ADDRESS_MASK a 32-bit constant

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes/x86: Fix to set RWX bits correctly before releasing trampoline

Richard Narron <comet.berkeley@gmail.com>
    partitions/msdos: Unable to mount UFS 44bsd partitions

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s: Fix i-side SLB miss bad address handler saving nonvolatile GPRs

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s: Fix lost pending interrupt due to race causing lost update to irq_happened

Mike Kravetz <mike.kravetz@oracle.com>
    ipc/shm.c: add split function to shm_vm_ops

Yan, Zheng <zyan@redhat.com>
    ceph: only dirty ITER_IOVEC pages for direct read

Linus Torvalds <torvalds@linux-foundation.org>
    perf/hwbp: Simplify the perf-hwbp code, fix documentation

Dan Carpenter <dan.carpenter@oracle.com>
    ALSA: pcm: potential uninitialized return values

Stefan Roese <sr@denx.de>
    ALSA: pcm: Use dma_bytes as size parameter in dma_mmap_coherent()

Nobutaka Okabe <nob77413@gmail.com>
    ALSA: usb-audio: Add native DSD support for TEAC UD-301

Linus Walleij <linus.walleij@linaro.org>
    mtd: jedec_probe: Fix crash in jedec_read_mfr()

Fabio Estevam <festevam@gmail.com>
    ARM: 8746/1: vfp: Go back to clearing vfp_current_hw_state[]


-------------

Diffstat:

 .../devicetree/bindings/pinctrl/pinctrl-palmas.txt |   9 +
 Makefile                                           |   4 +-
 arch/arm/boot/dts/am335x-pepper.dts                |   2 +-
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi    |   1 +
 arch/arm/boot/dts/am57xx-idk-common.dtsi           |   1 +
 arch/arm/boot/dts/dra7-evm.dts                     |   2 +
 arch/arm/boot/dts/omap3-n900.dts                   |   4 +-
 arch/arm/vfp/vfpmodule.c                           |   2 +-
 arch/arm64/Kconfig                                 |  12 ++
 arch/arm64/include/asm/assembler.h                 |   3 +
 arch/arm64/include/asm/cpucaps.h                   |   3 +-
 arch/arm64/include/asm/cputype.h                   |   3 +
 arch/arm64/include/asm/fixmap.h                    |   6 +
 arch/arm64/include/asm/memory.h                    |   6 +-
 arch/arm64/include/asm/mmu.h                       |  11 ++
 arch/arm64/include/asm/mmu_context.h               |   7 +
 arch/arm64/include/asm/pgtable-hwdef.h             |   1 +
 arch/arm64/include/asm/pgtable-prot.h              |  35 ++--
 arch/arm64/include/asm/pgtable.h                   |   1 +
 arch/arm64/include/asm/proc-fns.h                  |   6 -
 arch/arm64/include/asm/sysreg.h                    |   1 +
 arch/arm64/include/asm/tlbflush.h                  |  16 +-
 arch/arm64/kernel/asm-offsets.c                    |   6 +-
 arch/arm64/kernel/cpu-reset.S                      |   2 +-
 arch/arm64/kernel/cpufeature.c                     | 135 +++++++++++--
 arch/arm64/kernel/entry.S                          | 188 +++++++++++++++---
 arch/arm64/kernel/head.S                           |   2 +-
 arch/arm64/kernel/process.c                        |  12 +-
 arch/arm64/kernel/sleep.S                          |   2 +-
 arch/arm64/kernel/vmlinux.lds.S                    |  22 ++-
 arch/arm64/mm/context.c                            |  25 ++-
 arch/arm64/mm/mmu.c                                |  31 +++
 arch/arm64/mm/proc.S                               | 216 +++++++++++++++++++--
 arch/frv/include/asm/timex.h                       |   6 +
 arch/powerpc/kernel/exceptions-64s.S               |   2 +-
 arch/powerpc/kernel/irq.c                          |   8 +
 arch/x86/crypto/cast5_avx_glue.c                   |   3 +-
 arch/x86/kernel/kprobes/core.c                     |   9 +
 block/bio.c                                        |   4 +-
 block/partitions/msdos.c                           |   4 +-
 crypto/ahash.c                                     |   7 +-
 drivers/block/mtip32xx/mtip32xx.c                  |  36 ++--
 drivers/hid/hid-sony.c                             |  45 ++---
 drivers/infiniband/core/addr.c                     |  16 ++
 drivers/infiniband/core/ucma.c                     |  61 +++---
 drivers/input/mouse/alps.c                         |  24 ++-
 drivers/input/mousedev.c                           |  62 +++---
 drivers/input/serio/i8042-x86ia64io.h              |  24 +++
 drivers/md/dm-ioctl.c                              |   4 +-
 drivers/md/raid10.c                                |   1 +
 drivers/media/usb/usbtv/usbtv-core.c               |   2 +
 drivers/misc/mei/main.c                            |   1 -
 drivers/mtd/chips/jedec_probe.c                    |   2 +
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c   |  50 +++--
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c  |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c  |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   |   4 +-
 drivers/net/phy/mdio-xgene.c                       |  50 +++--
 drivers/net/phy/mdio-xgene.h                       |   4 -
 drivers/parport/parport_pc.c                       |   4 +
 drivers/pci/probe.c                                |   2 +-
 drivers/pci/setup-res.c                            |   2 +-
 drivers/scsi/virtio_scsi.c                         |   1 +
 drivers/spi/Kconfig                                |   1 -
 drivers/spi/spi-davinci.c                          |   2 +-
 drivers/staging/comedi/drivers/ni_mio_common.c     |   2 +
 drivers/tty/vt/vt.c                                |   6 +-
 drivers/usb/dwc2/hcd.c                             |   7 +-
 drivers/usb/gadget/udc/core.c                      |   4 +-
 drivers/usb/serial/cp210x.c                        |   1 +
 drivers/usb/serial/ftdi_sio.c                      |   2 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   9 +
 fs/btrfs/tree-log.c                                |   2 +-
 fs/ceph/file.c                                     |   9 +-
 fs/compat_ioctl.c                                  |   2 +-
 include/linux/cpumask.h                            |  10 +
 include/linux/init.h                               |   3 +
 include/linux/jiffies.h                            |  13 +-
 include/linux/llist.h                              |  21 +-
 include/linux/netfilter/x_tables.h                 |   2 +
 include/rdma/ib_addr.h                             |   2 +
 include/uapi/linux/pci_regs.h                      |   2 +-
 init/main.c                                        |   7 +-
 ipc/shm.c                                          |  12 ++
 kernel/events/hw_breakpoint.c                      |  30 +--
 kernel/irq/manage.c                                |   2 +-
 kernel/kprobes.c                                   |   2 +-
 kernel/module.c                                    |  20 +-
 mm/vmscan.c                                        |  13 +-
 net/bluetooth/smp.c                                |   8 +-
 net/bridge/netfilter/ebt_among.c                   |  34 ++++
 net/ipv4/netfilter/nf_nat_h323.c                   |  57 +++---
 net/ipv6/ip6_vti.c                                 |  20 --
 net/mac80211/ibss.c                                |   4 +-
 net/mac80211/rate.c                                |   6 +-
 net/netfilter/nf_conntrack_netlink.c               |   7 +-
 net/netfilter/x_tables.c                           |  30 +++
 net/netfilter/xt_hashlimit.c                       |  11 +-
 net/netfilter/xt_recent.c                          |   6 +-
 net/wireless/nl80211.c                             |   2 +-
 net/wireless/util.c                                |   6 +-
 net/xfrm/xfrm_ipcomp.c                             |   2 +-
 net/xfrm/xfrm_state.c                              |   5 +
 net/xfrm/xfrm_user.c                               |  21 +-
 security/selinux/hooks.c                           |  16 --
 security/selinux/ss/services.c                     |   2 +-
 sound/core/oss/pcm_oss.c                           |   4 +-
 sound/core/pcm_native.c                            |   2 +-
 sound/usb/quirks.c                                 |   1 +
 110 files changed, 1205 insertions(+), 446 deletions(-)
