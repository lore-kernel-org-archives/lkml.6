Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2903446-1527011246-2-5571028309115904167
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527011246; b=WDEw2fgpJg9B3MNEeD7cZoZiL1fW4BiiRNWXSpS/ztyHD03PSA
    ZJhe58Xax0msZQqC4b9YbLCe0EfPVl7KTXj0Tf6GVOj18OMjFqWAO2iKjkt+tJ5f
    PCBveK4k8CZ9Q4PgSheVUYY1I7oGL5pWI6w/zvHlC6Za5CcjJ4q8dypU28/aGaSL
    u3mmbq/L/stpMvMRurLubWhIn7ReYxwxVQ+GFcsLZruRWLoiH62XdLZVzZDkhM6c
    7yRXAwHPgsFT8AdG8WcTb7UKWaJq2btQWTvbSG+n9S+7CCszsDbtgeTPAwFFbrey
    QsS55J46OMCeJF22sjCo36HkSEZw68lhTA0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1527011246;
    bh=AL6Lf7dKHt94L5VeKkm6Vfc9SaIAHkZt71RsYaGXWVU=; b=TRLLWKJejavx
    oAjcUkK//i8blVUEtilWXVwQg2VYY5qLlVP59r2Nzv9voDar8BRgGoDW8eMp7Gxl
    0V3immGkGVyN34x5afMbQvj3xYBdnYeJftaCds5GM+u2U22h999P9KvSGArp7JpQ
    uxUucPAVhphH1zodY00iBVGEmjmFY7M5VCBnok9ycbx9Ohg/VZyv/wGeo8fzjmAI
    qCRT02grAFUrTczC7NjEtNyyOT8JblBN5c3x5FtTZlUJ5YkSHqNyLFcEZsnWTcsz
    zcMZCIoRTPEumDA/h36O8GMux2i0YBdrlojkn/UkQYtteynfOnrgLRSSmKLFUMJo
    kwQDra0d/A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Wj2sF0r8 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Wj2sF0r8 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEKHv1DGeGESzn6PCB2KbMRiH5qr6m/wyKNQay3WAC3ThAueZoAxttxesPYDSTTtQTHcIo0d5GemZVpXFZYfri6+Ix46iozz/MxiHyEVliaGV8qGwQok
    CqPlsVgI9R4DbepQ1JAV3KTmAae0e2k/paM5gNEfmnqrMjB+Vdn4jdNVoiF7/2HDU+nnVQFrIoi1DedgoWP1SFTQYAwktWcTVPUCf/ffQPaBK6wo4UYERNM5
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=qvLpJysPrfVFzusdfyoA:9 a=CjuIK1q_8ugA:10 a=0OzQoaibGB2mawGQFWUA:9
    a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbeEVRrX (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 13:47:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751932AbeEVRrW (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 22 May 2018 13:47:22 -0400
Date: Tue, 22 May 2018 19:47:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.102
Message-ID: <20180522174702.GA18813@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.102 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-devices-system-cpu |    1=20
 Documentation/kernel-parameters.txt                |   45 ++
 Documentation/spec_ctrl.txt                        |   94 ++++
 Makefile                                           |    2=20
 arch/arm/include/asm/assembler.h                   |   10=20
 arch/arm/include/asm/kvm_mmu.h                     |   16=20
 arch/arm/kernel/traps.c                            |    5=20
 arch/arm/lib/getuser.S                             |   10=20
 arch/arm/probes/kprobes/opt-arm.c                  |    4=20
 arch/arm64/include/asm/kvm_mmu.h                   |   16=20
 arch/powerpc/kernel/setup-common.c                 |   11=20
 arch/powerpc/platforms/powernv/opal-nvram.c        |   14=20
 arch/s390/kernel/irq.c                             |    5=20
 arch/s390/kernel/perf_cpum_sf.c                    |    4=20
 arch/x86/boot/compressed/eboot.c                   |    6=20
 arch/x86/include/asm/cpufeatures.h                 |   20 -
 arch/x86/include/asm/kvm_host.h                    |    2=20
 arch/x86/include/asm/mmu_context.h                 |    2=20
 arch/x86/include/asm/msr-index.h                   |   10=20
 arch/x86/include/asm/nospec-branch.h               |   43 +-
 arch/x86/include/asm/pkeys.h                       |   18=20
 arch/x86/include/asm/spec-ctrl.h                   |   80 ++++
 arch/x86/include/asm/thread_info.h                 |    6=20
 arch/x86/include/asm/tlbflush.h                    |   10=20
 arch/x86/kernel/cpu/amd.c                          |   38 +-
 arch/x86/kernel/cpu/bugs.c                         |  397 ++++++++++++++++=
++++-
 arch/x86/kernel/cpu/common.c                       |   77 +++-
 arch/x86/kernel/cpu/cpu.h                          |    3=20
 arch/x86/kernel/cpu/intel.c                        |    3=20
 arch/x86/kernel/process.c                          |  224 +++++++++--
 arch/x86/kernel/smpboot.c                          |    5=20
 arch/x86/kvm/cpuid.c                               |   21 -
 arch/x86/kvm/cpuid.h                               |   17=20
 arch/x86/kvm/svm.c                                 |   64 ++-
 arch/x86/kvm/vmx.c                                 |   33 +
 arch/x86/kvm/x86.c                                 |   13=20
 arch/x86/mm/pkeys.c                                |   21 -
 arch/x86/xen/enlighten.c                           |    4=20
 arch/x86/xen/mmu.c                                 |    4=20
 drivers/base/cpu.c                                 |    8=20
 drivers/i2c/busses/i2c-designware-core.c           |    5=20
 drivers/s390/cio/qdio_setup.c                      |   12=20
 drivers/spi/spi-bcm-qspi.c                         |   28 -
 drivers/spi/spi-pxa2xx.h                           |    2=20
 drivers/usb/usbip/stub.h                           |    2=20
 drivers/usb/usbip/stub_dev.c                       |   43 +-
 drivers/usb/usbip/stub_main.c                      |  105 ++++-
 fs/btrfs/ctree.c                                   |    6=20
 fs/btrfs/tree-log.c                                |    7=20
 fs/btrfs/volumes.c                                 |    9=20
 fs/proc/array.c                                    |   27 +
 include/linux/cpu.h                                |    2=20
 include/linux/efi.h                                |    8=20
 include/linux/nospec.h                             |   10=20
 include/linux/sched.h                              |    9=20
 include/linux/seccomp.h                            |    3=20
 include/linux/signal.h                             |   17=20
 include/trace/events/xen.h                         |   16=20
 include/uapi/linux/prctl.h                         |   12=20
 include/uapi/linux/seccomp.h                       |    4=20
 kernel/seccomp.c                                   |   21 -
 kernel/signal.c                                    |    7=20
 kernel/sys.c                                       |   23 +
 kernel/time/tick-broadcast.c                       |    8=20
 mm/Kconfig                                         |    1=20
 net/netfilter/nf_tables_api.c                      |   59 +--
 sound/core/control_compat.c                        |    3=20
 sound/pci/hda/hda_intel.c                          |    2=20
 sound/usb/mixer.c                                  |    8=20
 tools/testing/selftests/seccomp/seccomp_bpf.c      |   78 ++++
 virt/kvm/arm/vgic/vgic-its.c                       |   15=20
 71 files changed, 1610 insertions(+), 308 deletions(-)

Alexander Monakov (1):
      i2c: designware: fix poll-after-enable regression

Anand Jain (1):
      btrfs: fix crash when trying to resume balance without the resume flag

Andre Przywara (1):
      KVM: arm/arm64: VGIC/ITS: protect kvm_read_guest() calls with SRCU lo=
ck

Andy Shevchenko (1):
      spi: pxa2xx: Allow 64-bit DMA

Ard Biesheuvel (1):
      efi: Avoid potential crashes, fix the 'struct efi_pci_io_protocol_32'=
 definition for mixed mode

Benjamin Herrenschmidt (1):
      powerpc: Don't preempt_disable() in show_cpuinfo()

Borislav Petkov (4):
      Documentation/spec_ctrl: Do some minor cleanups
      x86/speculation: Use synthetic bits for IBRS/IBPB/STIBP
      x86/cpu/AMD: Fix erratum 1076 (CPB bit)
      x86/bugs: Unify x86_spec_ctrl_{set_guest,restore_host}

Dave Hansen (2):
      x86/pkeys: Override pkey when moving away from PROT_EXEC
      x86/pkeys: Do not special case protection key 0

David Woodhouse (2):
      x86/amd: don't set X86_BUG_SYSRET_SS_ATTRS when running under Xen
      x86/bugs/AMD: Add support to disable RDS on Fam[15,16,17]h if request=
ed

Dexuan Cui (1):
      tick/broadcast: Use for_each_cpu() specially on UP kernels

Federico Cuello (1):
      ALSA: usb: mixer: volume quirk for CM102-A+/102S+

Filipe Manana (1):
      Btrfs: fix xattr loss after power failure

Florian Westphal (1):
      netfilter: nf_tables: can't fail after linking rule into active rule =
list

Greg Kroah-Hartman (1):
      Linux 4.9.102

Hans de Goede (1):
      ALSA: hda: Add Lenovo C50 All in one to the power_save blacklist

Hendrik Brueckner (1):
      s390/cpum_sf: ensure sample frequency of perf event attributes is non=
-zero

Jim Mattson (1):
      x86/cpu: Make alternative_msr_write work for 32-bit code

Jiri Kosina (2):
      x86/bugs: Fix __ssb_select_mitigation() return type
      x86/bugs: Make cpu_show_common() static

Julian Wiedmann (2):
      s390/qdio: fix access to uninitialized qdio_q fields
      s390/qdio: don't release memory in qdio_setup_irq()

Kamal Dasu (2):
      spi: bcm-qspi: Avoid setting MSPI_CDRAM_PCS for spi-nor master
      spi: bcm-qspi: Always read and set BSPI_MAST_N_BOOT_CTRL

Kees Cook (6):
      nospec: Allow getting/setting on non-current task
      proc: Provide details on speculation flaw mitigations
      seccomp: Enable speculation flaw mitigations
      x86/bugs: Make boot modes __ro_after_init
      seccomp: Add filter flag to opt-out of SSB mitigation
      x86/speculation: Make "seccomp" the default mode for Speculative Stor=
e Bypass

Konrad Rzeszutek Wilk (14):
      x86/bugs: Concentrate bug detection into a separate function
      x86/bugs: Concentrate bug reporting into a separate function
      x86/bugs: Read SPEC_CTRL MSR during boot and re-use reserved bits
      x86/bugs, KVM: Support the combination of guest and host IBRS
      x86/bugs: Expose /sys/../spec_store_bypass
      x86/cpufeatures: Add X86_FEATURE_RDS
      x86/bugs: Provide boot parameters for the spec_store_bypass_disable m=
itigation
      x86/bugs/intel: Set proper CPU features and setup RDS
      x86/bugs: Whitelist allowed SPEC_CTRL MSR values
      x86/KVM/VMX: Expose SPEC_CTRL Bit(2) to the guest
      x86/bugs: Rename _RDS to _SSBD
      proc: Use underscores for SSBD in 'status'
      x86/bugs: Fix the parameters alignment and missing void
      x86/bugs: Rename SSBD_NO to SSB_NO

Kyle Huey (2):
      x86/process: Optimize TIF checks in __switch_to_xtra()
      x86/process: Correct and optimize TIF_BLOCKSTEP switch

Linus Torvalds (1):
      x86/nospec: Simplify alternative_msr_write()

Liu Bo (1):
      btrfs: fix reading stale metadata blocks after degraded raid1 mounts

Martin Schwidefsky (1):
      s390: remove indirect branch from do_softirq_own_stack

Masami Hiramatsu (4):
      ARM: 8771/1: kprobes: Prohibit kprobes on do_undefinstr
      ARM: 8769/1: kprobes: Fix to use get_kprobe_ctlblk after irq-disabed
      ARM: 8770/1: kprobes: Prohibit probing on optimized_callback
      ARM: 8772/1: kprobes: Prohibit kprobes on get_user functions

Nicholas Piggin (1):
      powerpc/powernv: Fix NVRAM sleep in invalid context when crashing

Pavel Tatashin (1):
      mm: don't allow deferred pages with NEED_PER_CPU_KM

Shuah Khan (1):
      usbip: usbip_host: refine probe and disconnect debug msgs to be useful

Shuah Khan (Samsung OSG) (4):
      usbip: usbip_host: delete device from busid_table after rebind
      usbip: usbip_host: run rebind from exit when module is removed
      usbip: usbip_host: fix NULL-ptr deref and use-after-free errors
      usbip: usbip_host: fix bad unlock balance during stub_probe()

Steven Rostedt (VMware) (1):
      tracing/x86/xen: Remove zero data size trace events trace_xen_mmu_flu=
sh_tlb{_all}

Thomas Gleixner (19):
      x86/speculation: Create spec-ctrl.h to avoid include hell
      prctl: Add speculation control prctls
      x86/process: Optimize TIF_NOTSC switch
      x86/process: Allow runtime control of Speculative Store Bypass
      x86/speculation: Add prctl for Speculative Store Bypass mitigation
      prctl: Add force disable speculation
      seccomp: Use PR_SPEC_FORCE_DISABLE
      seccomp: Move speculation migitation control to arch code
      KVM: SVM: Move spec control call after restore of GS
      x86/cpufeatures: Disentangle MSR_SPEC_CTRL enumeration from IBRS
      x86/cpufeatures: Disentangle SSBD enumeration
      x86/cpufeatures: Add FEATURE_ZEN
      x86/speculation: Handle HT correctly on AMD
      x86/bugs, KVM: Extend speculation control for VIRT_SPEC_CTRL
      x86/speculation: Rework speculative_store_bypass_update()
      x86/bugs: Expose x86_spec_ctrl_base directly
      x86/bugs: Remove x86_spec_ctrl_set()
      x86/bugs: Rework spec_ctrl base and mask logic
      x86/speculation, KVM: Implement support for VIRT_SPEC_CTRL/LS_CFG

Tom Lendacky (2):
      x86/speculation: Add virtualized speculative store bypass disable sup=
port
      KVM: SVM: Implement VIRT_SPEC_CTRL support for SSBD

Waiman Long (1):
      signals: avoid unnecessary taking of sighand->siglock

Wenwen Wang (1):
      ALSA: control: fix a redundant-copy issue


--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsEV5MACgkQONu9yGCS
aT6cPA//ccZpCFhLuAncK2GRyp/xobkr/CAZJDc7ZB2XGOK2kmFabeY+z/CCyHuf
JXczMmL8kaH6WsuJSnv3DZuNw1sfH7LdH1DWSaJk/lmFTeherK8O0c0zVUB/Q4Sz
AHlFtytupogRpkJHQp0EF6OsWLNlvM9hIWeeJ4OSyJx2lr+7Yc7YKbmOw3JCr3r0
efzgwK2fmXVYg2G8K37gwssHMQETQmkrKdS2ToDsCTmq5KE/FsYFxkqzi0TeRPFu
PLzxbYQNicWT8JEgSmEcP3MdvBuf+Xd50l8fCCtypxFkSmCO/i58OydG1Jn32ino
2H6yEb2/Nz6kxlR7UGQ4irrz/dVbM8aaifOVDLowluVIftBRuo8H9zJ5PyfQC6JV
y1BRQKAz196lV7yYrIvSUcDcpsMJ5n9ZWa+BcHF6LSJ5H1N0hdlkvKyAvqSguAbh
mq2eHSQIwUUD3yqC9CpWL85ap9ejziLcshOdyin1zj+4jKmB20NCJIJxoC86w027
WC4kEQ8XSpwhmKzWNSZpW4bDqUnZjItqArQ7xMSW5D89z1d8IpXVV+9nJgafFeTD
gyyi9y9j4/UbhMQTxSn1xJQGVjFcOKyaskz0X46EHrHa4D3rbS63laQCt9q9zRag
YRNMQgC7mgSjZP8s32f40jcr70jetuxraVNP9MBQJeRR6gL4Y7A=
=+NvD
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
