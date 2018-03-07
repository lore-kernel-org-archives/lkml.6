Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-32406-1520455675-2-2313260500439826442
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
    t=1520455673; b=pVfxpDxTahyHBtX/P9O/q/NH9/PF8GUEekmd4fOoSk6b+et
    wbN00erGy6X7/NMp+UyzViJqKHgmbLv3FtYyrJsCWhEn2cD8sViZfs1rHE5JE7pi
    lMdSaiiQnykLvBWEhixyt5/DTVnz4gxaYQSFp+zh3257ZERZtgpvfeJHPPuE4Wz0
    IlzWxwLoEh94dnNKx38A4t1zxdoUbD8FkpePdaNr46k5S3r6YcyLMHD9EGtd7rUZ
    aKF430VxS+wCGaUAbjIQuUrTU7yD3+/sv2WnDjrSWsHFPlXnqzYhKtCxCj77/Cil
    OlXIJZt4GnxEoD56kiK+soKNU8wN0ANXD6VgZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1520455673; bh=DzrpZKa0g74NrSQ0TtlrbswGp3
    aIXqQnvZCddWZjeQg=; b=FRjyEtVpW663UX70Wq0ZGSm6vnYHQmSxdqi+Ps9hXd
    2wY/ph3o8EGrh5ZGrwwJ86I7urMeeKE2Uzbv4fWIWSKOR5y4xTYkLrvlh8bxyaQI
    HXvo43KFi2Wfhfd7x4dq4wML8rEODn2zPaZ1fuXQGtcAw+QfH2HiurWpBh6k4R3f
    8QlHEJndyQXF2HwrF7Jqj56umrn3GcMmkiPacgA6ty4pBaz5Ex19/cjOiOjs2GnI
    OWlH3gFla1j0gkQR33rqzWwzfzy8G8wqw3jc5e2AhCkvb5fOj4vg8udz0qGaIZrP
    U0oZQfL+unotmbGG7MwiTvjzEo/I+QuAt+YYAhdHq8mA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934564AbeCGUrh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 15:47:37 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40774 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934492AbeCGTkw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:40:52 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.15 000/122] 4.15.8-stable review
Date: Wed,  7 Mar 2018 11:36:52 -0800
Message-Id: <20180307191729.190879024@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.8-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.15.8-rc1
X-KernelTest-Deadline: 2018-03-09T19:17+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.15.8 release.
There are 122 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Mar  9 19:16:43 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.8-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.15.8-rc1

NeilBrown <neilb@suse.com>
    md: only allow remove_and_add_spares when no sync_thread running.

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s/radix: Boot-time NULL pointer protection using a guard-PID

Adam Ford <aford173@gmail.com>
    ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux

Adam Ford <aford173@gmail.com>
    ARM: dts: LogicPD SOM-LV: Fix I2C1 pinmux

Kai Heng Feng <kai.heng.feng@canonical.com>
    ACPI / bus: Parse tables as term_list for Dell XPS 9570 and Precision M5530

Eric Biggers <ebiggers@google.com>
    KVM/x86: remove WARN_ON() for when vm_munmap() fails

Radim Krčmář <rkrcmar@redhat.com>
    KVM: x86: fix vcpu initialization with userspace lapic

Paolo Bonzini <pbonzini@redhat.com>
    KVM/VMX: Optimize vmx_vcpu_run() and svm_vcpu_run() by marking the RDMSR path as unlikely()

Paolo Bonzini <pbonzini@redhat.com>
    KVM: x86: move LAPIC initialization after VMCS creation

Paolo Bonzini <pbonzini@redhat.com>
    KVM/x86: Remove indirect MSR op calls from SPEC_CTRL

Wanpeng Li <wanpeng.li@hotmail.com>
    KVM: mmu: Fix overlap between public and private memslots

Wanpeng Li <wanpengli@tencent.com>
    KVM: X86: Fix SMRAM accessing even if VM is shutdown

Arnd Bergmann <arnd@arndb.de>
    ARM: kvm: fix building with gcc-8

Ulf Magnusson <ulfalizer@gmail.com>
    ARM: mvebu: Fix broken PL310_ERRATA_753970 selects

Daniel Schultz <d.schultz@phytec.de>
    ARM: dts: rockchip: Remove 1.8 GHz operation point from phycore som

Arnd Bergmann <arnd@arndb.de>
    ARM: orion: fix orion_ge00_switch_board_info initialization

Jan Beulich <JBeulich@suse.com>
    x86/mm: Fix {pmd,pud}_{set,clear}_flags()

Rasmus Villemoes <linux@rasmusvillemoes.dk>
    nospec: Allow index argument to have const-qualified type

David Hildenbrand <david@redhat.com>
    KVM: s390: consider epoch index on TOD clock syncs

David Hildenbrand <david@redhat.com>
    KVM: s390: consider epoch index on hotplugged CPUs

David Hildenbrand <david@redhat.com>
    KVM: s390: provide only a single function for setting the tod (fix SCK)

David Hildenbrand <david@redhat.com>
    KVM: s390: take care of clock-comparator sign control

Anna Karbownik <anna.karbownik@intel.com>
    EDAC, sb_edac: Fix out of bound writes during DIMM configuration on KNL

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: m88ds3103: don't call a non-initalized function

Ming Lei <ming.lei@redhat.com>
    blk-mq: don't call io sched's .requeue_request when requeueing rq to ->dispatch

Yuchung Cheng <ycheng@google.com>
    tcp: revert F-RTO extension to detect more spurious timeouts

Yuchung Cheng <ycheng@google.com>
    tcp: revert F-RTO middle-box workaround

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: fix IPA command submission race

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: fix IP address lookup for L3 devices

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    Revert "s390/qeth: fix using of ref counter for rxip addresses"

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

James Chapman <jchapman@katalix.com>
    l2tp: fix tunnel lookup use-after-free race

James Chapman <jchapman@katalix.com>
    l2tp: fix race in pppol2tp_release with session object destroy

James Chapman <jchapman@katalix.com>
    l2tp: fix races with tunnel socket close

James Chapman <jchapman@katalix.com>
    l2tp: don't use inet_shutdown on ppp session destroy

James Chapman <jchapman@katalix.com>
    l2tp: don't use inet_shutdown on tunnel destroy

Song Liu <songliubraving@fb.com>
    tcp: tracepoint: only call trace_tcp_send_reset with full socket

Andrew Lunn <andrew@lunn.ch>
    net: phy: Restore phy_resume() locking assumption

Vlad Buslov <vladbu@mellanox.com>
    net/mlx5: Fix error handling when adding flow rules

Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
    cxgb4: fix trailing zero in CIM LA dump

Jason Wang <jasowang@redhat.com>
    virtio-net: disable NAPI only when enabled during XDP set

Jason Wang <jasowang@redhat.com>
    tuntap: disable preemption during XDP processing

Jason Wang <jasowang@redhat.com>
    tuntap: correctly add the missing XDP flush

Soheil Hassas Yeganeh <soheil@google.com>
    tcp: purge write queue upon RST

Jason A. Donenfeld <Jason@zx2c4.com>
    netlink: put module reference if dump start fails

Ido Schimmel <idosch@mellanox.com>
    mlxsw: spectrum_router: Do not unconditionally clear route offload indication

Paolo Abeni <pabeni@redhat.com>
    cls_u32: fix use after free in u32_destroy_key()

Tom Lendacky <thomas.lendacky@amd.com>
    amd-xgbe: Restore PCI interrupt enablement setting on resume

Boris Pismenny <borisp@mellanox.com>
    tls: Use correct sk->sk_prot for IPV6

Eran Ben Elisha <eranbe@mellanox.com>
    net/mlx5e: Verify inline header size do not exceed SKB linear size

Ido Schimmel <idosch@mellanox.com>
    bridge: Fix VLAN reference count problem

Alexey Kodanev <alexey.kodanev@oracle.com>
    sctp: fix dst refcnt leak in sctp_v6_get_dst()

David Ahern <dsahern@gmail.com>
    net: ipv4: Set addr_type in hash_keys for forwarded case

Jiri Pirko <jiri@mellanox.com>
    mlxsw: spectrum_router: Fix error path in mlxsw_sp_vr_create

Xin Long <lucien.xin@gmail.com>
    sctp: do not pr_err for the duplicated node in transport rhlist

Ivan Vecera <ivecera@redhat.com>
    net/sched: cls_u32: fix cls_u32 on filter replace

Eric Dumazet <edumazet@google.com>
    net_sched: gen_estimator: fix broken estimators based on percpu stats

Inbar Karmy <inbark@mellanox.com>
    net/mlx5e: Fix loopback self test when GRO is off

Tonghao Zhang <xiangxia.m.yue@gmail.com>
    doc: Change the min default value of tcp_wmem/tcp_rmem.

Eric Dumazet <edumazet@google.com>
    tcp_bbr: better deal with suboptimal GSO

David Howells <dhowells@redhat.com>
    rxrpc: Fix send in rxrpc_send_data_packet()

Ilya Lesokhin <ilyal@mellanox.com>
    tcp: Honor the eor bit in tcp_mtu_probe

Heiner Kallweit <hkallweit1@gmail.com>
    net: phy: fix phy_start to consider PHY_IGNORE_INTERRUPT

Gal Pressman <galp@mellanox.com>
    net/mlx5e: Specify numa node when allocating drop rq

Shalom Toledo <shalomt@mellanox.com>
    mlxsw: spectrum_switchdev: Check success of FDB add operation

Tommi Rantala <tommi.t.rantala@nokia.com>
    sctp: fix dst refcnt leak in sctp_v4_get_dst

Gal Pressman <galp@mellanox.com>
    net/mlx5e: Fix TCP checksum in LRO buffers

Alexey Kodanev <alexey.kodanev@oracle.com>
    udplite: fix partial checksum initialization

Alexey Kodanev <alexey.kodanev@oracle.com>
    sctp: verify size of a new chunk in _sctp_make_chunk()

Guillaume Nault <g.nault@alphalink.fr>
    ppp: prevent unregistered channels from connecting to PPP units

Roman Kapl <code@rkapl.cz>
    net: sched: report if filter is too large to dump

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    netlink: ensure to loop over all netns in genlmsg_multicast_allns()

Sabrina Dubroca <sd@queasysnail.net>
    net: ipv4: don't allow setting net.ipv4.route.min_pmtu below 68

Jakub Kicinski <jakub.kicinski@netronome.com>
    net: fix race on decreasing number of TX queues

Grygorii Strashko <grygorii.strashko@ti.com>
    net: ethernet: ti: cpsw: fix net watchdog timeout

Wolfram Sang <wsa+renesas@sang-engineering.com>
    net: amd-xgbe: fix comparison to bitshift when dealing with a mask

Arnd Bergmann <arnd@arndb.de>
    ipv6 sit: work around bogus gcc-8 -Wrestrict warning

Denis Du <dudenis2000@yahoo.ca>
    hdlc_ppp: carrier detect ok, don't turn off negotiation

Stefano Brivio <sbrivio@redhat.com>
    fib_semantics: Don't match route with mismatching tclassid

Xin Long <lucien.xin@gmail.com>
    bridge: check brport attr show in brport_show

Thomas Gleixner <tglx@linutronix.de>
    x86/cpu_entry_area: Sync cpu_entry_area to initial_page_table

Sebastian Panceac <sebastian@resin.io>
    x86/platform/intel-mid: Handle Intel Edison reboot correctly

Juergen Gross <jgross@suse.com>
    x86/xen: Zero MSR_IA32_SPEC_CTRL before suspend

Jan Kara <jack@suse.cz>
    direct-io: Fix sleep in atomic due to sync AIO

Dan Williams <dan.j.williams@intel.com>
    dax: fix vma_is_fsdax() helper

Viresh Kumar <viresh.kumar@linaro.org>
    cpufreq: s3c24xx: Fix broken s3c_cpufreq_init()

Dan Williams <dan.j.williams@intel.com>
    vfio: disable filesystem-dax page pinning

Ming Lei <ming.lei@redhat.com>
    block: pass inclusive 'lend' parameter to truncate_inode_pages_range

Ming Lei <ming.lei@redhat.com>
    block: kyber: fix domain token leak during requeue

Jiufei Xue <jiufei.xue@linux.alibaba.com>
    block: fix the count of PGPGOUT for WRITE_SAME

Anand Jain <anand.jain@oracle.com>
    btrfs: use proper endianness accessors for super_copy

Helge Deller <deller@gmx.de>
    parisc: Hide virtual kernel memory layout

John David Anglin <dave.anglin@bell.net>
    parisc: Fix ordering of cache and TLB flushes

Helge Deller <deller@gmx.de>
    parisc: Reduce irq overhead when run in qemu

Helge Deller <deller@gmx.de>
    parisc: Use cr16 interval timers unconditionally on qemu

Lingutla Chandrasekhar <clingutla@codeaurora.org>
    timers: Forward timer base before migrating timers

Shawn Lin <shawn.lin@rock-chips.com>
    mmc: dw_mmc: Fix out-of-bounds access for slot's caps

Shawn Lin <shawn.lin@rock-chips.com>
    mmc: dw_mmc: Factor out dw_mci_init_slot_caps

Shawn Lin <shawn.lin@rock-chips.com>
    mmc: dw_mmc: Avoid accessing registers in runtime suspended state

Geert Uytterhoeven <geert+renesas@glider.be>
    mmc: dw_mmc-k3: Fix out-of-bounds access through DT alias

Adrian Hunter <adrian.hunter@intel.com>
    mmc: sdhci-pci: Fix S0i3 for Intel BYT-based controllers

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Fix pincfg at resume on Lenovo T470 dock

Hans de Goede <hdegoede@redhat.com>
    ALSA: hda: Add a power_save blacklist

Takashi Iwai <tiwai@suse.de>
    ALSA: x86: Fix missing spinlock and mutex initializations

Richard Fitzgerald <rf@opensource.cirrus.com>
    ALSA: control: Fix memory corruption risk in snd_ctl_elem_read

Erik Veijola <erik.veijola@gmail.com>
    ALSA: usb-audio: Add a quirck for B&W PX headphones

Jeremy Boone <jeremy.boone@nccgroup.trust>
    tpm_tis: fix potential buffer overruns caused by bit glitches on the bus

Jeremy Boone <jeremy.boone@nccgroup.trust>
    tpm_i2c_nuvoton: fix potential buffer overruns caused by bit glitches on the bus

Jeremy Boone <jeremy.boone@nccgroup.trust>
    tpm_i2c_infineon: fix potential buffer overruns caused by bit glitches on the bus

Jeremy Boone <jeremy.boone@nccgroup.trust>
    tpm: fix potential buffer overruns caused by bit glitches on the bus

Jeremy Boone <jeremy.boone@nccgroup.trust>
    tpm: st33zp24: fix potential buffer overruns caused by bit glitches on the bus

Emil Tantilov <emil.s.tantilov@intel.com>
    ixgbe: fix crash in build_skb Rx code path

Hans de Goede <hdegoede@redhat.com>
    Bluetooth: btusb: Use DMI matching for QCA reset_resume quirking

Sam Bobroff <sam.bobroff@au1.ibm.com>
    powerpc/pseries: Enable RAS hotplug events later

Mario Limonciello <mario.limonciello@dell.com>
    platform/x86: dell-laptop: Allocate buffer on heap rather than globally

Corey Minyard <cminyard@mvista.com>
    ipmi_si: Fix error handling of platform device

Anna-Maria Gleixner <anna-maria@linutronix.de>
    hrtimer: Ensure POSIX compliance (relative CLOCK_REALTIME hrtimers)

Adam Borowski <kilobyte@angband.pl>
    vsprintf: avoid misleading "(null)" for %px


-------------

Diffstat:

 Documentation/networking/ip-sysctl.txt             |   4 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi              |   9 +-
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi         |   8 +
 arch/arm/boot/dts/rk3288-phycore-som.dtsi          |  20 ---
 arch/arm/kvm/hyp/Makefile                          |   5 +
 arch/arm/kvm/hyp/banked-sr.c                       |   4 +
 arch/arm/mach-mvebu/Kconfig                        |   4 +-
 arch/arm/plat-orion/common.c                       |  23 ++-
 arch/parisc/include/asm/cacheflush.h               |   1 +
 arch/parisc/include/asm/processor.h                |   2 +
 arch/parisc/kernel/cache.c                         |  57 ++++---
 arch/parisc/kernel/pacache.S                       |  22 +++
 arch/parisc/kernel/time.c                          |  11 +-
 arch/parisc/mm/init.c                              |   7 +-
 arch/powerpc/mm/pgtable-radix.c                    |  20 +++
 arch/powerpc/platforms/pseries/ras.c               |  31 +++-
 arch/s390/kvm/interrupt.c                          |  25 ++-
 arch/s390/kvm/kvm-s390.c                           |  79 +++++----
 arch/s390/kvm/kvm-s390.h                           |   5 +-
 arch/s390/kvm/priv.c                               |   9 +-
 arch/x86/include/asm/pgtable.h                     |   8 +-
 arch/x86/include/asm/pgtable_32.h                  |   1 +
 arch/x86/include/asm/pgtable_64.h                  |   1 +
 arch/x86/include/asm/pgtable_types.h               |  10 ++
 arch/x86/kernel/setup.c                            |  17 +-
 arch/x86/kernel/setup_percpu.c                     |  17 +-
 arch/x86/kvm/lapic.c                               |  11 +-
 arch/x86/kvm/mmu.c                                 |   2 +-
 arch/x86/kvm/svm.c                                 |   9 +-
 arch/x86/kvm/vmx.c                                 |   9 +-
 arch/x86/kvm/x86.c                                 |   8 +-
 arch/x86/mm/cpu_entry_area.c                       |   6 +
 arch/x86/mm/init_32.c                              |  15 ++
 arch/x86/platform/intel-mid/intel-mid.c            |   2 +-
 arch/x86/xen/suspend.c                             |  16 ++
 block/blk-core.c                                   |   2 +-
 block/blk-mq.c                                     |   4 +-
 block/ioctl.c                                      |   2 +-
 block/kyber-iosched.c                              |   1 +
 drivers/acpi/bus.c                                 |  38 ++++-
 drivers/bluetooth/btusb.c                          |  25 ++-
 drivers/char/ipmi/ipmi_si_intf.c                   |   9 +-
 drivers/char/tpm/st33zp24/st33zp24.c               |   4 +-
 drivers/char/tpm/tpm-interface.c                   |   4 +
 drivers/char/tpm/tpm2-cmd.c                        |   4 +
 drivers/char/tpm/tpm_i2c_infineon.c                |   5 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c                 |   8 +-
 drivers/char/tpm/tpm_tis_core.c                    |   5 +-
 drivers/cpufreq/s3c24xx-cpufreq.c                  |   8 +-
 drivers/edac/sb_edac.c                             |   2 +-
 drivers/md/md.c                                    |   4 +
 drivers/media/dvb-frontends/m88ds3103.c            |   7 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |   1 +
 drivers/mmc/host/dw_mmc-k3.c                       |   4 +
 drivers/mmc/host/dw_mmc-rockchip.c                 |   1 +
 drivers/mmc/host/dw_mmc-zx.c                       |   1 +
 drivers/mmc/host/dw_mmc.c                          |  84 +++++----
 drivers/mmc/host/dw_mmc.h                          |   2 +
 drivers/mmc/host/sdhci-pci-core.c                  |  35 +++-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c           |   2 +
 drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c     |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c   |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   8 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  10 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  49 ++++--
 .../net/ethernet/mellanox/mlx5/core/en_selftest.c  |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |  10 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |  35 ++--
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |  29 +++-
 drivers/net/ethernet/ti/cpsw.c                     |  16 +-
 drivers/net/phy/phy.c                              |   4 +-
 drivers/net/phy/phy_device.c                       |  18 +-
 drivers/net/ppp/ppp_generic.c                      |   9 +
 drivers/net/tun.c                                  |   7 +
 drivers/net/virtio_net.c                           |   8 +-
 drivers/net/wan/hdlc_ppp.c                         |   5 +-
 drivers/platform/x86/dell-laptop.c                 | 188 +++++++++++----------
 drivers/s390/net/qeth_core.h                       |   7 +-
 drivers/s390/net/qeth_core_main.c                  |  43 ++---
 drivers/s390/net/qeth_l3.h                         |  34 +++-
 drivers/s390/net/qeth_l3_main.c                    | 123 ++++++--------
 drivers/vfio/vfio_iommu_type1.c                    |  18 +-
 fs/btrfs/sysfs.c                                   |   8 +-
 fs/btrfs/transaction.c                             |  20 ++-
 fs/direct-io.c                                     |   3 +-
 include/linux/fs.h                                 |   2 +-
 include/linux/nospec.h                             |   3 +-
 include/linux/phy.h                                |   1 +
 include/net/udplite.h                              |   1 +
 kernel/time/hrtimer.c                              |   7 +-
 kernel/time/timer.c                                |   6 +
 lib/vsprintf.c                                     |   2 +-
 net/bridge/br_sysfs_if.c                           |   3 +
 net/bridge/br_vlan.c                               |   2 +
 net/core/dev.c                                     |  11 +-
 net/core/gen_estimator.c                           |   1 +
 net/ipv4/fib_semantics.c                           |   5 +
 net/ipv4/route.c                                   |  10 +-
 net/ipv4/tcp_input.c                               |  24 +--
 net/ipv4/tcp_ipv4.c                                |   3 +-
 net/ipv4/tcp_output.c                              |  34 +++-
 net/ipv4/udp.c                                     |   5 +
 net/ipv6/ip6_checksum.c                            |   5 +
 net/ipv6/sit.c                                     |   2 +-
 net/ipv6/tcp_ipv6.c                                |   3 +-
 net/l2tp/l2tp_core.c                               | 142 +++++-----------
 net/l2tp/l2tp_core.h                               |  23 +--
 net/l2tp/l2tp_ip.c                                 |  10 +-
 net/l2tp/l2tp_ip6.c                                |   8 +-
 net/l2tp/l2tp_ppp.c                                |  60 +++----
 net/netlink/af_netlink.c                           |   4 +-
 net/netlink/genetlink.c                            |  12 +-
 net/rxrpc/output.c                                 |   2 +-
 net/sched/cls_api.c                                |   7 +-
 net/sched/cls_u32.c                                |  24 +--
 net/sctp/input.c                                   |   5 +-
 net/sctp/ipv6.c                                    |  10 +-
 net/sctp/protocol.c                                |  10 +-
 net/sctp/sm_make_chunk.c                           |   7 +-
 net/tls/tls_main.c                                 |  52 ++++--
 sound/core/control.c                               |   2 +-
 sound/pci/hda/hda_intel.c                          |  38 ++++-
 sound/pci/hda/patch_realtek.c                      |   3 +-
 sound/usb/quirks-table.h                           |  47 ++++++
 sound/x86/intel_hdmi_audio.c                       |   2 +
 virt/kvm/kvm_main.c                                |   3 +-
 129 files changed, 1271 insertions(+), 737 deletions(-)
