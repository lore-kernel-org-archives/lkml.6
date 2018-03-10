Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtkVolcGm3Fyk/nnBOvpm+Itfu5YseeJwnlKJU/1E5T4FUkxWGVIyph+Qg0mnT1VcMkSOhx
ARC-Seal: i=1; a=rsa-sha256; t=1520641303; cv=none;
        d=google.com; s=arc-20160816;
        b=SAyAO7WxzhzqVzeXkEUxZOslGBvysv8rgziVxSdmC4/TpqF8yHpNJGf8asBMSz9TZh
         KywyrSAdlyFAnseeCqOggiuFBFL0yT1J+Sw8K5Xl22Z5fNotIs7xLxDcGCnCFPJWzFLJ
         1xYyOoUEReX8tl4b+lLhQC7cROKI3SJRw9t8oJlD1J7Z7aQE6VWsZ6/boZb16xahNfgl
         QgEye9umSZEoRDxoX8HdB+o+qJiA9gCny28J9KXnZ+lRLRXLsQtPMTifXtkhoB9BMMPY
         5lDZpPWlGGmIxfp6oyrTyQjxlXGv8VW/Zn7l95XpQoT8CELd86dnShQUM3v34/l+MHkO
         H5AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vnpwegeIA+ICM04Uvq/7T/FvedxruDOzqnuNrzwh0fE=;
        b=vYlMisuKLiXk9DZmzObZczBT98XRtr1s0L37zT3SxOANiofnK99u0Zrg9Up5ti3kkC
         88r2jNbLYEYnBRsBav5d5Wxo3HoAlhfFFKnAdvmYJVnf4dQmn1dNGH+YbyImkJ7gbJEA
         EmX8zuPkjrlRIlXoG+YkC6sclFw8kqDakrLHP9NzIbFSDcQORyNEyzdcLvsFeDSwJT5B
         oAga6inUYL+zTzKb5ZjHdFK4uP6RDN+7BGfK/p84khxmvTUsm49IvoBttDmndRdbhMNw
         p0a3nbHCHix6VgWTROZUxqZ9JjDCecOBsKqhfLzWiOWmPFYSGHi0XGwUaZkhy1pr/F1V
         Qp5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
Subject: [PATCH 4.9 00/65] 4.9.87-stable review
Date: Fri,  9 Mar 2018 16:18:00 -0800
Message-Id: <20180310001824.927996722@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.87-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.87-rc1
X-KernelTest-Deadline: 2018-03-12T00:18+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507975302163705?=
X-GMAIL-MSGID: =?utf-8?q?1594507975302163705?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.9.87 release.
There are 65 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon Mar 12 00:18:06 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.87-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.87-rc1

Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
    btrfs: preserve i_mode if __btrfs_set_acl() fails

Daniel Borkmann <daniel@iogearbox.net>
    bpf, ppc64: fix out of bounds access in tail call

Eric Dumazet <edumazet@google.com>
    bpf: add schedule points in percpu arrays management

Daniel Borkmann <daniel@iogearbox.net>
    bpf, arm64: fix out of bounds access in tail call

Daniel Borkmann <daniel@iogearbox.net>
    bpf, x64: implement retpoline for tail call

Daniel Borkmann <daniel@iogearbox.net>
    bpf: fix mlock precharge on arraymaps

Daniel Borkmann <daniel@iogearbox.net>
    bpf: fix wrong exposure of map_flags into fdinfo for lpm

Dan Williams <dan.j.williams@intel.com>
    mpls, nospec: Sanitize array index in mpls_label_ok()

David Ahern <dsahern@gmail.com>
    net: mpls: Pull common label check into helper

Alexey Kodanev <alexey.kodanev@oracle.com>
    sctp: verify size of a new chunk in _sctp_make_chunk()

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: fix IPA command submission race

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: fix IP address lookup for L3 devices

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: fix double-free on IP add/remove race

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: fix IP removal on offline cards

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: fix overestimated count of buffer elements

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: fix SETIP command handling

Ursula Braun <ubraun@linux.vnet.ibm.com>
    s390/qeth: fix underestimated count of buffer elements

Alexey Kodanev <alexey.kodanev@oracle.com>
    sctp: fix dst refcnt leak in sctp_v6_get_dst()

Eric Dumazet <edumazet@google.com>
    tcp_bbr: better deal with suboptimal GSO

David Howells <dhowells@redhat.com>
    rxrpc: Fix send in rxrpc_send_data_packet()

Ilya Lesokhin <ilyal@mellanox.com>
    tcp: Honor the eor bit in tcp_mtu_probe

Heiner Kallweit <hkallweit1@gmail.com>
    net: phy: fix phy_start to consider PHY_IGNORE_INTERRUPT

Shalom Toledo <shalomt@mellanox.com>
    mlxsw: spectrum_switchdev: Check success of FDB add operation

Tommi Rantala <tommi.t.rantala@nokia.com>
    sctp: fix dst refcnt leak in sctp_v4_get_dst

Alexey Kodanev <alexey.kodanev@oracle.com>
    udplite: fix partial checksum initialization

Guillaume Nault <g.nault@alphalink.fr>
    ppp: prevent unregistered channels from connecting to PPP units

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    netlink: ensure to loop over all netns in genlmsg_multicast_allns()

Sabrina Dubroca <sd@queasysnail.net>
    net: ipv4: don't allow setting net.ipv4.route.min_pmtu below 68

Jakub Kicinski <jakub.kicinski@netronome.com>
    net: fix race on decreasing number of TX queues

Arnd Bergmann <arnd@arndb.de>
    ipv6 sit: work around bogus gcc-8 -Wrestrict warning

Denis Du <dudenis2000@yahoo.ca>
    hdlc_ppp: carrier detect ok, don't turn off negotiation

Stefano Brivio <sbrivio@redhat.com>
    fib_semantics: Don't match route with mismatching tclassid

Xin Long <lucien.xin@gmail.com>
    bridge: check brport attr show in brport_show

Thomas Gleixner <tglx@linutronix.de>
    x86/apic/vector: Handle legacy irq data correctly

Jason A. Donenfeld <Jason@zx2c4.com>
    netlink: put module reference if dump start fails

NeilBrown <neilb@suse.com>
    md: only allow remove_and_add_spares when no sync_thread running.

Tim Chen <tim.c.chen@linux.intel.com>
    x86/speculation: Use Indirect Branch Prediction Barrier in context switch

Andy Lutomirski <luto@kernel.org>
    x86/mm: Give each mm TLB flush generation a unique ID

Adam Ford <aford173@gmail.com>
    ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux

Adam Ford <aford173@gmail.com>
    ARM: dts: LogicPD SOM-LV: Fix I2C1 pinmux

Mike Snitzer <snitzer@redhat.com>
    dm io: fix duplicate bio completion due to missing ref count

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    PCI/ASPM: Deal with missing root ports in link state handling

Paolo Bonzini <pbonzini@redhat.com>
    KVM/VMX: Optimize vmx_vcpu_run() and svm_vcpu_run() by marking the RDMSR path as unlikely()

Paolo Bonzini <pbonzini@redhat.com>
    KVM/x86: Remove indirect MSR op calls from SPEC_CTRL

Wanpeng Li <wanpeng.li@hotmail.com>
    KVM: mmu: Fix overlap between public and private memslots

Arnd Bergmann <arnd@arndb.de>
    ARM: kvm: fix building with gcc-8

Ulf Magnusson <ulfalizer@gmail.com>
    ARM: mvebu: Fix broken PL310_ERRATA_753970 selects

Rasmus Villemoes <linux@rasmusvillemoes.dk>
    nospec: Allow index argument to have const-qualified type

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: m88ds3103: don't call a non-initalized function

Sebastian Panceac <sebastian@resin.io>
    x86/platform/intel-mid: Handle Intel Edison reboot correctly

Juergen Gross <jgross@suse.com>
    x86/xen: Zero MSR_IA32_SPEC_CTRL before suspend

Dan Williams <dan.j.williams@intel.com>
    dax: fix vma_is_fsdax() helper

Viresh Kumar <viresh.kumar@linaro.org>
    cpufreq: s3c24xx: Fix broken s3c_cpufreq_init()

John David Anglin <dave.anglin@bell.net>
    parisc: Fix ordering of cache and TLB flushes

Lingutla Chandrasekhar <clingutla@codeaurora.org>
    timers: Forward timer base before migrating timers

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Fix pincfg at resume on Lenovo T470 dock

Hans de Goede <hdegoede@redhat.com>
    ALSA: hda: Add a power_save blacklist

Erik Veijola <erik.veijola@gmail.com>
    ALSA: usb-audio: Add a quirck for B&W PX headphones

Alexander Steffen <Alexander.Steffen@infineon.com>
    tpm-dev-common: Reject too short writes

Alexander Steffen <Alexander.Steffen@infineon.com>
    tpm_tis_spi: Use DMA-safe memory for SPI transfers

Arnd Bergmann <arnd@arndb.de>
    tpm: constify transmit data pointers

Jeremy Boone <jeremy.boone@nccgroup.trust>
    tpm_tis: fix potential buffer overruns caused by bit glitches on the bus

Jeremy Boone <jeremy.boone@nccgroup.trust>
    tpm_i2c_nuvoton: fix potential buffer overruns caused by bit glitches on the bus

Jeremy Boone <jeremy.boone@nccgroup.trust>
    tpm_i2c_infineon: fix potential buffer overruns caused by bit glitches on the bus

Jeremy Boone <jeremy.boone@nccgroup.trust>
    tpm: st33zp24: fix potential buffer overruns caused by bit glitches on the bus


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi              |   9 +-
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi         |   8 ++
 arch/arm/kvm/hyp/Makefile                          |   5 +
 arch/arm/kvm/hyp/banked-sr.c                       |   4 +
 arch/arm/mach-mvebu/Kconfig                        |   4 +-
 arch/arm64/net/bpf_jit_comp.c                      |   5 +-
 arch/parisc/include/asm/cacheflush.h               |   1 +
 arch/parisc/kernel/cache.c                         |  57 +++++-----
 arch/parisc/kernel/pacache.S                       |  22 ++++
 arch/powerpc/net/bpf_jit_comp64.c                  |   1 +
 arch/x86/include/asm/mmu.h                         |  15 ++-
 arch/x86/include/asm/mmu_context.h                 |   5 +
 arch/x86/include/asm/nospec-branch.h               |  37 +++++++
 arch/x86/include/asm/tlbflush.h                    |   2 +
 arch/x86/kernel/apic/vector.c                      |  14 +--
 arch/x86/kvm/svm.c                                 |   9 +-
 arch/x86/kvm/vmx.c                                 |   9 +-
 arch/x86/mm/tlb.c                                  |  33 ++++++
 arch/x86/net/bpf_jit_comp.c                        |   9 +-
 arch/x86/platform/intel-mid/intel-mid.c            |   2 +-
 arch/x86/xen/suspend.c                             |  16 +++
 drivers/char/tpm/st33zp24/st33zp24.c               |   4 +-
 drivers/char/tpm/tpm-dev.c                         |   6 ++
 drivers/char/tpm/tpm_i2c_infineon.c                |   5 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c                 |   8 +-
 drivers/char/tpm/tpm_tis.c                         |   2 +-
 drivers/char/tpm/tpm_tis_core.c                    |   9 +-
 drivers/char/tpm/tpm_tis_core.h                    |   4 +-
 drivers/char/tpm/tpm_tis_spi.c                     |  48 +++++----
 drivers/cpufreq/s3c24xx-cpufreq.c                  |   8 +-
 drivers/md/dm-io.c                                 |   1 +
 drivers/md/md.c                                    |   4 +
 drivers/media/dvb-frontends/m88ds3103.c            |   7 +-
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |  29 ++++-
 drivers/net/phy/phy.c                              |   2 +-
 drivers/net/ppp/ppp_generic.c                      |   9 ++
 drivers/net/wan/hdlc_ppp.c                         |   5 +-
 drivers/pci/pcie/aspm.c                            |   8 +-
 drivers/s390/net/qeth_core.h                       |   7 +-
 drivers/s390/net/qeth_core_main.c                  |  43 ++++----
 drivers/s390/net/qeth_l3.h                         |  34 +++++-
 drivers/s390/net/qeth_l3_main.c                    | 119 +++++++++------------
 fs/btrfs/acl.c                                     |   6 +-
 include/linux/fs.h                                 |   2 +-
 include/linux/nospec.h                             |   3 +-
 include/net/udplite.h                              |   1 +
 kernel/bpf/arraymap.c                              |  35 +++---
 kernel/bpf/stackmap.c                              |   1 +
 kernel/time/timer.c                                |   6 ++
 net/bridge/br_sysfs_if.c                           |   3 +
 net/core/dev.c                                     |  11 +-
 net/ipv4/fib_semantics.c                           |   5 +
 net/ipv4/route.c                                   |   8 +-
 net/ipv4/tcp_output.c                              |  33 +++++-
 net/ipv4/udp.c                                     |   5 +
 net/ipv6/ip6_checksum.c                            |   5 +
 net/ipv6/sit.c                                     |   2 +-
 net/mpls/af_mpls.c                                 |  36 ++++---
 net/netlink/af_netlink.c                           |   4 +-
 net/netlink/genetlink.c                            |  12 ++-
 net/rxrpc/output.c                                 |   2 +-
 net/sctp/ipv6.c                                    |  10 +-
 net/sctp/protocol.c                                |  10 +-
 net/sctp/sm_make_chunk.c                           |   7 +-
 sound/pci/hda/hda_intel.c                          |  38 ++++++-
 sound/pci/hda/patch_realtek.c                      |   3 +-
 sound/usb/quirks-table.h                           |  47 ++++++++
 virt/kvm/kvm_main.c                                |   3 +-
 69 files changed, 687 insertions(+), 244 deletions(-)
