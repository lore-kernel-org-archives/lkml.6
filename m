Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-133548-1522173368-2-13491558683180540633
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_BLACK 1.7,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522173367; b=kloRDBLQwIulA9CfdCcLdLKqxwLoPSdokOFyDnvFcGk1l0f
    BrAtFIqvoBzySXq/ifbx7js3z+ivpQC9Q/iuaZTNoy92CLf/9iMf+ibOoUtm4sS8
    4jcXAuXqzFpJD8T7fUGV9Wd9TCCFH051rhmKR25Vf7HsKzg9qZcwh8ATMWPgcgXh
    Pk8NAuiSzG+5JLxTjbNP05V9iomj7Cva5saae4XQL6yqMkhXJzPjKpnSbz898wci
    P9LkKCW5Yxihv/Y+HLVkTzvrki7HrYlbqHI1Fi7THEOxC8a6epKR4uwTCUt3+Txy
    kuzua5Gi5wcizrUNlG2FEQ8ssej74e9dJTwGZVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1522173367; bh=t9tHseXJ5USOYDcEH1BGDVoeBV
    CcW8WxT+8SC4iNOsU=; b=W4yYwA8JwHxZLNEcvud/3sM2EfTupvWK3NfGbMmoam
    UO5pUJ+tijxNB9WDMZ2keMNI5L45eZBaa9CH4cksur7r6TpzbNbu7JS4ICdElC/S
    H9MgJrcIQu7G+51YUeC5Bm4bSQQzSaHn5ekp4mhcJgKAHMoDuSpEbZUxtd4chAeP
    KlZGv+ekQkjWvaNoD4JTVOeMF9YilSWSwNR79taX2/3SSY46rsnYjt1PDrcqTtO/
    n49M3iL48X3DrHE7eE8+fx1NpPO00IwIN7e2a+7S8Q36rrgFO7ohyQ70m5GYacu7
    Z4hpx4KE9UuuEHB1Tso4tDG/YEiBTzMLMMOf+i+H5ZBw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfFMy9QgvqSIXfG25g4iuC4nV4c7ENoPInC0WifSmlSUfN1AmiDzo3ZtdknRdgcfgFxakR3sMCWkNyiDzAEnKDSl52sfZ67WaELGaldF5PZzFSozieoWx
    axa3g1dFoQKTZKsiI5g6jzTzKItmZEbNoF3CLVQR0a/KImcgz3/cLo7kN7uRc0WQ2bYrYWXKtb8m2x+2wKN0ft1orzBbJ+3ZuCMJ6w6fdhhBTjx0JwiXRZ5T
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=ONKqiAgnDjwA:10
    a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=hWMQpYRtAAAA:8
    a=1XWaLZrsAAAA:8 a=QyXUC8HyAAAA:8 a=PtDNVHqPAAAA:8 a=eh1Yez-EAAAA:8
    a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8 a=JqEG_dyiAAAA:8 a=pGLkceISAAAA:8
    a=Z4Rwk6OoAAAA:8 a=nTPwkA1SAAAA:8 a=8AirrxEcAAAA:8 a=06TC-2EVAAAA:8
    a=yQdBAQUQAAAA:8 a=Q-fNiiVtAAAA:8 a=zd2uoN0lAAAA:8 a=MvuuwTCpAAAA:8
    a=20KFwNOVAAAA:8 a=DfNHnWVPAAAA:8 a=zu6OG0ZhAAAA:8 a=P-IC7800AAAA:8
    a=jIQo8A4GAAAA:8 a=yl7zrpXIfGMSnYcznlkA:9 a=iOdq4fvdqVP9bOxT:21
    a=uwAmA68NwyLld3fv:21 a=QEXdDO2ut3YA:10 a=2t5KsnBapy4A:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=KCsI-UfzjElwHeZNREa_:22
    a=BpimnaHY1jUKGyF_4-AF:22 a=cvBusfyB2V15izCimMoJ:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=Her_73y7XSQQkpQYGz2D:22 a=ST-jHhOKWsTCqRlWije3:22 a=bPPcmhrZmmaHPY_0WkiZ:22
    a=SzazLyfi1tnkUD6oumHU:22 a=Fp8MccfUoT0GBdDC_Lng:22 a=dVHiktpip_riXrfdqayU:22
    a=rjTVMONInIDnV1a_A2c_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbeC0QbN (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:31:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42830 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbeC0QbL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:31:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/67] 4.9.91-stable review
Date: Tue, 27 Mar 2018 18:26:52 +0200
Message-Id: <20180327162726.702411083@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.91-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.91-rc1
X-KernelTest-Deadline: 2018-03-29T16:27+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.9.91 release.
There are 67 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Mar 29 16:27:08 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.91-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.91-rc1

Daniel Borkmann <daniel@iogearbox.net>
    bpf, x64: increase number of passes

Chenbo Feng <fengc@google.com>
    bpf: skip unnecessary capability check

Daniel Borkmann <daniel@iogearbox.net>
    kbuild: disable clang's default use of -fmerge-all-constants

Shuah Khan <shuah@kernel.org>
    selftests: x86: sysret_ss_attrs doesn't build on a PIE build

Dave Hansen <dave.hansen@linux.intel.com>
    x86/pkeys/selftests: Rename 'si_pkey' to 'siginfo_pkey'

Eric W. Biederman <ebiederm@xmission.com>
    signal/testing: Don't look for __SI_FAULT in userspace

Andy Lutomirski <luto@kernel.org>
    selftests/x86/protection_keys: Fix syscall NR redefinition warnings

Dave Hansen <dave.hansen@linux.intel.com>
    selftests, x86, protection_keys: fix wrong offset in siginfo

Nadav Amit <namit@vmware.com>
    staging: lustre: ptlrpc: kfree used instead of kvfree

Linus Walleij <linus.walleij@linaro.org>
    iio: ABI: Fix name of timestamp sysfs file

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel/uncore: Fix multi-domain PCI CHA enumeration bug on Skylake servers

Dan Carpenter <dan.carpenter@oracle.com>
    perf/x86/intel: Don't accidentally clear high bits in bdw_limit_period()

Ilya Pronin <ipronin@twitter.com>
    perf stat: Fix CVS output format for non-supported counters

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel/uncore: Fix Skylake UPI event format

Andy Lutomirski <luto@kernel.org>
    x86/entry/64: Don't use IST entry for #BP stack

H.J. Lu <hjl.tools@gmail.com>
    x86/boot/64: Verify alignment of the LOAD segment

H.J. Lu <hjl.tools@gmail.com>
    x86/build/64: Force the linker to use 2MB page size

Linus Torvalds <torvalds@linux-foundation.org>
    kvm/x86: fix icebp instruction handling

Andy Lutomirski <luto@kernel.org>
    selftests/x86/ptrace_syscall: Fix for yet more glibc interference

Linus Torvalds <torvalds@linux-foundation.org>
    tty: vt: fix up tabstops properly

Andri Yngvason <andri.yngvason@marel.com>
    can: cc770: Fix use after free in cc770_tx_interrupt()

Andri Yngvason <andri.yngvason@marel.com>
    can: cc770: Fix queue stall & dropped RTR reply

Andri Yngvason <andri.yngvason@marel.com>
    can: cc770: Fix stalls on rt-linux, remove redundant IRQ ack

Marek Vasut <marex@denx.de>
    can: ifi: Check core revision upon probe

Marek Vasut <marex@denx.de>
    can: ifi: Repair the error handling

Dan Carpenter <dan.carpenter@oracle.com>
    staging: ncpfs: memory corruption in ncp_read_kernel()

Jagdish Gediya <jagdish.gediya@nxp.com>
    mtd: nand: fsl_ifc: Read ECCSTAT0 and ECCSTAT1 registers for IFC 2.0

Jagdish Gediya <jagdish.gediya@nxp.com>
    mtd: nand: fsl_ifc: Fix eccstat array overflow for IFC ver >= 2.0.0

Jagdish Gediya <jagdish.gediya@nxp.com>
    mtd: nand: fsl_ifc: Fix nand waitfunc return value

OuYang ZhiZhong <ouyzz@yealink.com>
    mtdchar: fix usage of mtd_ooblayout_ecc()

Masami Hiramatsu <mhiramat@kernel.org>
    tracing: probeevent: Fix to support minus offset from symbol

Larry Finger <Larry.Finger@lwfinger.net>
    rtlwifi: rtl8723be: Fix loss of signal

Arend Van Spriel <arend.vanspriel@broadcom.com>
    brcmfmac: fix P2P_DEVICE ethernet address generation

Vishal Verma <vishal.l.verma@intel.com>
    libnvdimm, {btt, blk}: do integrity setup before add_disk()

Takashi Iwai <tiwai@suse.de>
    ACPI / watchdog: Fix off-by-one error at resource assignment

Dan Williams <dan.j.williams@intel.com>
    acpi, numa: fix pxm to online numa node associations

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    drm: udl: Properly check framebuffer mmap offsets

Michel Dänzer <michel.daenzer@amd.com>
    drm/radeon: Don't turn off DP sink when disconnected

Thomas Hellstrom <thellstrom@vmware.com>
    drm/vmwgfx: Fix a destoy-while-held mutex problem.

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    mm/shmem: do not wait for lock_page() in shmem_unused_huge_shrink()

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    mm/thp: do not wait for lock_page() in deferred_split_scan()

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    mm/khugepaged.c: convert VM_BUG_ON() to collapse fail

Toshi Kani <toshi.kani@hpe.com>
    x86/mm: implement free pmd/pte page interfaces

Toshi Kani <toshi.kani@hpe.com>
    mm/vmalloc: add interfaces to free unmapped page table

Jeff Layton <jlayton@redhat.com>
    nfsd: remove blocked locks on client teardown

Hans de Goede <hdegoede@redhat.com>
    libata: Modify quirks for MX100 to limit NCQ_TRIM quirk to MU01 version

Hans de Goede <hdegoede@redhat.com>
    libata: Make Crucial BX100 500GB LPM quirk apply to all firmware versions

Hans de Goede <hdegoede@redhat.com>
    libata: Apply NOLPM quirk to Crucial M500 480 and 960GB SSDs

Ju Hyung Park <qkrwngud825@gmail.com>
    libata: Enable queued TRIM for Samsung SSD 860

Kai-Heng Feng <kai.heng.feng@canonical.com>
    libata: disable LPM for Crucial BX100 SSD 500GB drive

Hans de Goede <hdegoede@redhat.com>
    libata: Apply NOLPM quirk to Crucial MX100 512GB SSDs

Eric Biggers <ebiggers@google.com>
    libata: don't try to pass through NCQ commands to non-NCQ devices

Eric Biggers <ebiggers@google.com>
    libata: remove WARN() for DMA or PIO command without data

Eric Biggers <ebiggers@google.com>
    libata: fix length validation of ATAPI-relayed SCSI commands

Takashi Iwai <tiwai@suse.de>
    Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174

Chen-Yu Tsai <wens@csie.org>
    clk: sunxi-ng: a31: Fix CLK_OUT_* clock ops

Boris Brezillon <boris.brezillon@bootlin.com>
    clk: bcm2835: Protect sections updating shared registers

Boris Brezillon <boris.brezillon@bootlin.com>
    clk: bcm2835: Fix ana->maskX definitions

Hans de Goede <hdegoede@redhat.com>
    ahci: Add PCI-id for the Highpoint Rocketraid 644L card

Hans de Goede <hdegoede@redhat.com>
    PCI: Add function 1 DMA alias quirk for Highpoint RocketRAID 644L

Evgeniy Didin <Evgeniy.Didin@synopsys.com>
    mmc: dw_mmc: fix falling from idmac to PIO mode when dw_mci_reset occurs

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/realtek - Always immediately update mute LED with pin VREF

Takashi Iwai <tiwai@suse.de>
    ALSA: aloop: Fix access to not-yet-ready substream via cable

Takashi Iwai <tiwai@suse.de>
    ALSA: aloop: Sync stale timer before release

Kirill Marinushkin <k.marinushkin@gmail.com>
    ALSA: usb-audio: Fix parsing descriptor of UAC2 processing unit

Michael Nosthoff <committed@heine.so>
    iio: st_pressure: st_accel: pass correct platform data to init

NeilBrown <neil@brown.name>
    MIPS: ralink: Remove ralink_halt()


-------------

Diffstat:

 Documentation/ABI/testing/sysfs-bus-iio            |   2 +-
 Makefile                                           |  13 ++-
 arch/arm64/mm/mmu.c                                |  10 +++
 arch/mips/ralink/reset.c                           |   7 --
 arch/x86/Makefile                                  |   9 ++
 arch/x86/boot/compressed/misc.c                    |   4 +
 arch/x86/entry/entry_64.S                          |   2 +-
 arch/x86/events/intel/core.c                       |   2 +-
 arch/x86/events/intel/uncore_snbep.c               |  33 +++----
 arch/x86/include/asm/vmx.h                         |   1 +
 arch/x86/kernel/traps.c                            |  24 +++--
 arch/x86/kvm/vmx.c                                 |   9 +-
 arch/x86/mm/pgtable.c                              |  48 ++++++++++
 arch/x86/net/bpf_jit_comp.c                        |   3 +-
 drivers/acpi/acpi_watchdog.c                       |   4 +-
 drivers/acpi/numa.c                                |  10 ++-
 drivers/ata/ahci.c                                 |   4 +-
 drivers/ata/libata-core.c                          |  26 +++++-
 drivers/ata/libata-scsi.c                          |  10 ++-
 drivers/bluetooth/btusb.c                          |   2 +-
 drivers/clk/bcm/clk-bcm2835.c                      |  12 ++-
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c               |   6 +-
 drivers/gpu/drm/radeon/radeon_connectors.c         |  31 +++----
 drivers/gpu/drm/udl/udl_fb.c                       |   9 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |  28 ++++--
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |  12 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |   5 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |   5 +-
 drivers/iio/accel/st_accel_core.c                  |   2 +-
 drivers/iio/pressure/st_pressure_core.c            |   2 +-
 drivers/mmc/host/dw_mmc.c                          |   6 +-
 drivers/mtd/mtdchar.c                              |   4 +-
 drivers/mtd/nand/fsl_ifc_nand.c                    |  32 +++----
 drivers/net/can/cc770/cc770.c                      | 100 +++++++++++++--------
 drivers/net/can/cc770/cc770.h                      |   2 +
 drivers/net/can/ifi_canfd/ifi_canfd.c              |  75 ++++++++++------
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c |  24 +++--
 .../net/wireless/realtek/rtlwifi/rtl8723be/hw.c    |   3 +-
 drivers/nvdimm/blk.c                               |   3 +-
 drivers/nvdimm/btt.c                               |   3 +-
 drivers/pci/quirks.c                               |   2 +
 drivers/staging/lustre/lustre/ptlrpc/sec.c         |   2 +-
 drivers/tty/vt/vt.c                                |   8 +-
 drivers/watchdog/wdat_wdt.c                        |   2 +-
 fs/ncpfs/ncplib_kernel.c                           |   4 +
 fs/nfsd/nfs4state.c                                |  62 +++++++++----
 include/asm-generic/pgtable.h                      |  10 +++
 include/linux/fsl_ifc.h                            |   6 +-
 include/uapi/linux/usb/audio.h                     |   4 +-
 kernel/bpf/syscall.c                               |   2 +-
 kernel/trace/trace_kprobe.c                        |   4 +-
 kernel/trace/trace_probe.c                         |   8 +-
 kernel/trace/trace_probe.h                         |   2 +-
 lib/ioremap.c                                      |   6 +-
 mm/huge_memory.c                                   |   4 +-
 mm/khugepaged.c                                    |   7 +-
 mm/shmem.c                                         |  31 ++++---
 sound/drivers/aloop.c                              |  17 +++-
 sound/pci/hda/patch_realtek.c                      |   6 +-
 tools/perf/builtin-stat.c                          |   2 +-
 tools/testing/selftests/x86/Makefile               |   2 +-
 tools/testing/selftests/x86/mpx-mini-test.c        |   3 +-
 tools/testing/selftests/x86/protection_keys.c      |  49 ++++++----
 tools/testing/selftests/x86/ptrace_syscall.c       |   8 +-
 64 files changed, 546 insertions(+), 292 deletions(-)
