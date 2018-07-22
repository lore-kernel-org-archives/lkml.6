Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C254C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 13:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D7320875
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 13:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D7320875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbeGVOsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 10:48:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51434 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbeGVOsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 10:48:10 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6D204AE0;
        Sun, 22 Jul 2018 13:51:24 +0000 (UTC)
Date:   Sun, 22 Jul 2018 15:51:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.114
Message-ID: <20180722135122.GA18131@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.114 kernel.

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

 Documentation/kernel-parameters.txt             |   17 ++
 Makefile                                        |    2=20
 arch/arm/include/asm/kvm_host.h                 |   12 +
 arch/arm/include/asm/kvm_mmu.h                  |   12 +
 arch/arm/kvm/arm.c                              |   24 +--
 arch/arm/kvm/psci.c                             |   18 ++
 arch/arm64/Kconfig                              |    9 +
 arch/arm64/include/asm/alternative.h            |   43 +++++
 arch/arm64/include/asm/assembler.h              |   27 +++
 arch/arm64/include/asm/cpucaps.h                |    3=20
 arch/arm64/include/asm/cpufeature.h             |   22 ++
 arch/arm64/include/asm/kvm_asm.h                |   41 +++++
 arch/arm64/include/asm/kvm_host.h               |   43 +++++
 arch/arm64/include/asm/kvm_mmu.h                |   44 +++++
 arch/arm64/include/asm/percpu.h                 |   12 +
 arch/arm64/include/asm/thread_info.h            |    1=20
 arch/arm64/kernel/Makefile                      |    1=20
 arch/arm64/kernel/alternative.c                 |   54 +++++--
 arch/arm64/kernel/asm-offsets.c                 |    2=20
 arch/arm64/kernel/cpu_errata.c                  |  180 +++++++++++++++++++=
+++++
 arch/arm64/kernel/cpufeature.c                  |   17 ++
 arch/arm64/kernel/entry.S                       |   32 ++++
 arch/arm64/kernel/hibernate.c                   |   11 +
 arch/arm64/kernel/ssbd.c                        |  108 ++++++++++++++
 arch/arm64/kernel/suspend.c                     |    8 +
 arch/arm64/kvm/hyp-init.S                       |    4=20
 arch/arm64/kvm/hyp/entry.S                      |   12 -
 arch/arm64/kvm/hyp/hyp-entry.S                  |   62 ++++++--
 arch/arm64/kvm/hyp/switch.c                     |   64 ++++++--
 arch/arm64/kvm/hyp/sysreg-sr.c                  |   21 +-
 arch/arm64/kvm/reset.c                          |    4=20
 arch/mips/kernel/process.c                      |   45 ++++--
 arch/x86/include/asm/asm.h                      |   59 +++++++
 arch/x86/include/asm/irqflags.h                 |    2=20
 arch/x86/kernel/Makefile                        |    1=20
 arch/x86/kernel/irqflags.S                      |   26 +++
 drivers/atm/zatm.c                              |    2=20
 drivers/crypto/amcc/crypto4xx_core.c            |   23 +--
 drivers/mtd/devices/m25p80.c                    |    3=20
 drivers/net/ethernet/broadcom/bcm63xx_enet.c    |   34 +++-
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c |    2=20
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c   |    8 -
 drivers/net/ethernet/mellanox/mlx5/core/port.c  |    4=20
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c      |    8 -
 drivers/net/ethernet/qlogic/qed/qed_main.c      |    9 +
 drivers/net/ethernet/sun/sungem.c               |   22 +-
 drivers/net/ipvlan/ipvlan_main.c                |    3=20
 drivers/net/usb/lan78xx.c                       |    5=20
 drivers/net/usb/qmi_wwan.c                      |    1=20
 drivers/net/usb/r8152.c                         |    3=20
 drivers/net/wireless/realtek/rtlwifi/core.c     |    1=20
 drivers/vhost/net.c                             |    3=20
 fs/ocfs2/aops.c                                 |   26 ++-
 fs/ocfs2/cluster/nodemanager.c                  |   63 +++++++-
 fs/reiserfs/prints.c                            |  141 ++++++++++--------
 include/linux/arm-smccc.h                       |   10 +
 include/linux/compiler-gcc.h                    |   35 +++-
 include/linux/string.h                          |    2=20
 net/bridge/netfilter/ebtables.c                 |   13 +
 net/dccp/ccids/ccid3.c                          |   16 +-
 net/dns_resolver/dns_key.c                      |   28 ++-
 net/ipv4/sysctl_net_ipv4.c                      |   18 +-
 net/ipv4/tcp_input.c                            |    9 +
 net/ipv6/netfilter/nf_conntrack_reasm.c         |    2=20
 net/nfc/llcp_commands.c                         |    9 -
 net/packet/af_packet.c                          |   14 -
 net/rds/loop.c                                  |    1=20
 net/rds/rds.h                                   |    5=20
 net/rds/recv.c                                  |    5=20
 net/sched/sch_blackhole.c                       |    2=20
 virt/kvm/arm/hyp/vgic-v2-sr.c                   |    2=20
 71 files changed, 1305 insertions(+), 270 deletions(-)

Aleksander Morgado (1):
      qmi_wwan: add support for the Dell Wireless 5821e module

Alex Vesker (2):
      net/mlx5: Fix incorrect raw command length parsing
      net/mlx5: Fix command interface race in polling mode

Christian Lamparter (2):
      crypto: crypto4xx - remove bad list_del
      crypto: crypto4xx - fix crypto4xx_build_pdr, crypto4xx_build_sdr leak

Christoffer Dall (1):
      KVM: arm64: Avoid storing the vcpu pointer on the stack

David Rientjes (2):
      compiler, clang: suppress warning for unused static inline functions
      compiler, clang: always inline when CONFIG_OPTIMIZE_INLINING is disab=
led

Eric Biggers (2):
      reiserfs: fix buffer overflow with long warning messages
      KEYS: DNS: fix parsing multiple options

Eric Dumazet (4):
      net: dccp: avoid crash in ccid3_hc_rx_send_feedback()
      net: dccp: switch rx_tstamp_last_feedback to monotonic clock
      net: sungem: fix rx checksum support
      net/packet: fix use-after-free

Florian Westphal (2):
      netfilter: ebtables: reject non-bridge targets
      netfilter: ipv6: nf_defrag: drop skb dst before queueing

Greg Kroah-Hartman (1):
      Linux 4.9.114

Gustavo A. R. Silva (2):
      atm: zatm: Fix potential Spectre v1
      net: cxgb3_main: fix potential Spectre v1

H. Peter Anvin (1):
      x86/asm: Add _ASM_ARG* constants for argument registers to <asm/asm.h>

Heiner Kallweit (1):
      mtd: m25p80: consider max message size in m25p80_read

Ilpo J=E4rvinen (1):
      tcp: prevent bogus FRTO undos with non-SACK flows

James Morse (5):
      KVM: arm64: Store vcpu on the stack during __guest_enter()
      KVM: arm/arm64: Convert kvm_host_cpu_state to a static per-cpu alloca=
tion
      KVM: arm64: Change hyp_panic()s dependency on tpidr_el2
      arm64: alternatives: use tpidr_el2 on VHE hosts
      KVM: arm64: Stop save/restoring host tpidr_el1 on VHE

Jason Wang (1):
      vhost_net: validate sock before trying to put its fd

Jiri Slaby (1):
      r8152: napi hangup fix after disconnect

Jonas Gorski (2):
      bcm63xx_enet: correct clock usage
      bcm63xx_enet: do not write to random DMA channel on BCM6345

Konstantin Khlebnikov (1):
      net_sched: blackhole: tell upper qdisc about dropped packets

Linus Torvalds (1):
      compiler, clang: properly override 'inline' for clang

Marc Zyngier (16):
      arm64: alternatives: Add dynamic patching feature
      KVM: arm/arm64: Do not use kern_hyp_va() with kvm_vgic_global_state
      arm/arm64: smccc: Add SMCCC-specific return codes
      arm64: Call ARCH_WORKAROUND_2 on transitions between EL0 and EL1
      arm64: Add per-cpu infrastructure to call ARCH_WORKAROUND_2
      arm64: Add ARCH_WORKAROUND_2 probing
      arm64: Add 'ssbd' command-line option
      arm64: ssbd: Add global mitigation state accessor
      arm64: ssbd: Skip apply_ssbd if not using dynamic mitigation
      arm64: ssbd: Restore mitigation status on CPU resume
      arm64: ssbd: Introduce thread flag to control userspace mitigation
      arm64: ssbd: Add prctl interface for per-thread mitigation
      arm64: KVM: Add HYP per-cpu accessors
      arm64: KVM: Add ARCH_WORKAROUND_2 support for guests
      arm64: KVM: Handle guest's ARCH_WORKAROUND_2 requests
      arm64: KVM: Add ARCH_WORKAROUND_2 discovery through ARCH_FEATURES_FUN=
C_ID

Mark Rutland (1):
      arm64: assembler: introduce ldr_this_cpu

Nick Desaulniers (2):
      compiler-gcc.h: Add __attribute__((gnu_inline)) to all inline declara=
tions
      x86/paravirt: Make native_save_fl() extern inline

Paul Burton (1):
      MIPS: Use async IPIs for arch_trigger_cpumask_backtrace()

Ping-Ke Shih (1):
      rtlwifi: rtl8821ae: fix firmware is not ready to run

Santosh Shilimkar (1):
      rds: avoid unenecessary cong_update in loop transport

Shay Agroskin (1):
      net/mlx5: Fix wrong size allocation for QoS ETC TC regitster

Stefan Wahren (1):
      net: lan78xx: Fix race in tx pending skb size calculation

Sudarsana Reddy Kalluru (2):
      qed: Fix use of incorrect size in memcpy call.
      qed: Limit msix vectors in kdump kernel to the minimum required count.

Tejun Heo (1):
      string: drop __must_check from strscpy() and restore strscpy() usages=
 in cgroup

Tetsuo Handa (1):
      net/nfc: Avoid stalls when nfc_alloc_send_skb() returned NULL.

Xin Long (1):
      ipvlan: fix IFLA_MTU ignored on NEWLINK

Yuchung Cheng (1):
      tcp: fix Fast Open key endianness

alex chen (2):
      ocfs2: subsystem.su_mutex is required while accessing the item->ci_pa=
rent
      ocfs2: ip_alloc_sem should be taken in ocfs2_get_block()


--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltUi9oACgkQONu9yGCS
aT6teBAAhfaGYIGMYEBg38xhXuihMW0U2GCjpWYPPT+PBmns5osWuHuMrabUvqOr
3A1r0MqdZ7kidCVmHUkSkaEgkkZzwCKY/MxeEHmR16ktrmrVIVDMBeV3JAvaz+qz
zfVzVA+1KMusIaTwNsvvc8gtvZUslb5mJq86rqecn+Mg5uzlKCsGEB0cuJzXMvW6
MoZJPgxyQOGK8ayi/PfD/8Rbp6NT/i0GU5UuLMf9dnIqKauvQFeuqi5zv42OLKuC
vU+ibhoXYWt/JucSnkX5QSyA/IM7JK3JEmZISax+3XhnZBh8QPB6vD7T2/wRp/4W
G+JAVWAuVQhiud5GnC7CW6b3ALIX80z1JJVsW2TO0njLhRrRcAFC0Z1nmqzzmoyD
4NDGBcCSOz3KLcpArdErxjKlY1FiD5kN85H3MsBXgyvX3AGbQVsoImfY1pyqoL0f
bWrUkaL+DqeYhyyGWpMCxkxbYcpx0nsoADd555BIqZXPquLtcahu/JDDofMtzDhD
vIraaISiB6ITwBc9p9R6cyjdVYk4u02a5LFpo5jhuth5KePaLSb2kdRR0adduVEA
w9jtBeYKSFBwoHM0Jn6NU/cSzQ71h9AxHGexff0WJkmtWXDWNOhuprQu9A2STCvA
eTk3Te/wttji6GrIiI1mPlMmz69Lr+Y4enm4ZEmFpz7iFLMs6a8=
=jrqZ
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
