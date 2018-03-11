Date: Sun, 11 Mar 2018 17:45:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.87
Message-ID: <20180311164516.GA23799@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.87 kernel.

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

 Makefile                                                 |    2=20
 arch/arm/boot/dts/logicpd-som-lv.dtsi                    |    9 +
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi               |    8 +
 arch/arm/kvm/hyp/Makefile                                |    5=20
 arch/arm/kvm/hyp/banked-sr.c                             |    4=20
 arch/arm/mach-mvebu/Kconfig                              |    4=20
 arch/arm64/net/bpf_jit_comp.c                            |    5=20
 arch/parisc/include/asm/cacheflush.h                     |    1=20
 arch/parisc/kernel/cache.c                               |   57 +++----
 arch/parisc/kernel/pacache.S                             |   22 ++
 arch/powerpc/net/bpf_jit_comp64.c                        |    1=20
 arch/x86/include/asm/mmu.h                               |   15 +
 arch/x86/include/asm/mmu_context.h                       |    5=20
 arch/x86/include/asm/nospec-branch.h                     |   37 ++++
 arch/x86/include/asm/tlbflush.h                          |    2=20
 arch/x86/kernel/apic/vector.c                            |   14 -
 arch/x86/kvm/svm.c                                       |    9 -
 arch/x86/kvm/vmx.c                                       |    9 -
 arch/x86/mm/tlb.c                                        |   33 ++++
 arch/x86/net/bpf_jit_comp.c                              |    9 -
 arch/x86/platform/intel-mid/intel-mid.c                  |    2=20
 arch/x86/xen/suspend.c                                   |   16 ++
 drivers/char/tpm/st33zp24/st33zp24.c                     |    4=20
 drivers/char/tpm/tpm-dev.c                               |    6=20
 drivers/char/tpm/tpm_i2c_infineon.c                      |    5=20
 drivers/char/tpm/tpm_i2c_nuvoton.c                       |    8 -
 drivers/char/tpm/tpm_tis.c                               |    2=20
 drivers/char/tpm/tpm_tis_core.c                          |    9 -
 drivers/char/tpm/tpm_tis_core.h                          |    4=20
 drivers/char/tpm/tpm_tis_spi.c                           |   48 +++---
 drivers/cpufreq/s3c24xx-cpufreq.c                        |    8 -
 drivers/md/dm-io.c                                       |    1=20
 drivers/md/md.c                                          |    4=20
 drivers/media/dvb-frontends/m88ds3103.c                  |    7=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |   29 +++
 drivers/net/phy/phy.c                                    |    2=20
 drivers/net/ppp/ppp_generic.c                            |    9 +
 drivers/net/wan/hdlc_ppp.c                               |    5=20
 drivers/pci/pcie/aspm.c                                  |    8 -
 drivers/s390/net/qeth_core.h                             |    7=20
 drivers/s390/net/qeth_core_main.c                        |   43 +++--
 drivers/s390/net/qeth_l3.h                               |   34 ++++
 drivers/s390/net/qeth_l3_main.c                          |  119 ++++++----=
-----
 fs/btrfs/acl.c                                           |    6=20
 include/linux/fs.h                                       |    2=20
 include/linux/nospec.h                                   |    3=20
 include/net/udplite.h                                    |    1=20
 kernel/bpf/arraymap.c                                    |   35 ++--
 kernel/bpf/stackmap.c                                    |    1=20
 kernel/time/timer.c                                      |    6=20
 net/bridge/br_sysfs_if.c                                 |    3=20
 net/core/dev.c                                           |   11 +
 net/ipv4/fib_semantics.c                                 |    5=20
 net/ipv4/route.c                                         |    8 -
 net/ipv4/tcp_output.c                                    |   33 +++-
 net/ipv4/udp.c                                           |    5=20
 net/ipv6/ip6_checksum.c                                  |    5=20
 net/ipv6/sit.c                                           |    2=20
 net/mpls/af_mpls.c                                       |   36 ++--
 net/netlink/af_netlink.c                                 |    4=20
 net/netlink/genetlink.c                                  |   12 +
 net/rxrpc/output.c                                       |    2=20
 net/sctp/ipv6.c                                          |   10 -
 net/sctp/protocol.c                                      |   10 -
 net/sctp/sm_make_chunk.c                                 |    7=20
 sound/pci/hda/hda_intel.c                                |   38 ++++
 sound/pci/hda/patch_realtek.c                            |    3=20
 sound/usb/quirks-table.h                                 |   47 +++++
 virt/kvm/kvm_main.c                                      |    3=20
 69 files changed, 686 insertions(+), 243 deletions(-)

Adam Ford (2):
      ARM: dts: LogicPD SOM-LV: Fix I2C1 pinmux
      ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux

Alexander Steffen (2):
      tpm_tis_spi: Use DMA-safe memory for SPI transfers
      tpm-dev-common: Reject too short writes

Alexey Kodanev (3):
      udplite: fix partial checksum initialization
      sctp: fix dst refcnt leak in sctp_v6_get_dst()
      sctp: verify size of a new chunk in _sctp_make_chunk()

Andy Lutomirski (1):
      x86/mm: Give each mm TLB flush generation a unique ID

Ard Biesheuvel (1):
      PCI/ASPM: Deal with missing root ports in link state handling

Arnd Bergmann (3):
      tpm: constify transmit data pointers
      ARM: kvm: fix building with gcc-8
      ipv6 sit: work around bogus gcc-8 -Wrestrict warning

Dan Williams (2):
      dax: fix vma_is_fsdax() helper
      mpls, nospec: Sanitize array index in mpls_label_ok()

Daniel Borkmann (5):
      bpf: fix wrong exposure of map_flags into fdinfo for lpm
      bpf: fix mlock precharge on arraymaps
      bpf, x64: implement retpoline for tail call
      bpf, arm64: fix out of bounds access in tail call
      bpf, ppc64: fix out of bounds access in tail call

David Ahern (1):
      net: mpls: Pull common label check into helper

David Howells (1):
      rxrpc: Fix send in rxrpc_send_data_packet()

Denis Du (1):
      hdlc_ppp: carrier detect ok, don't turn off negotiation

Eric Dumazet (2):
      tcp_bbr: better deal with suboptimal GSO
      bpf: add schedule points in percpu arrays management

Erik Veijola (1):
      ALSA: usb-audio: Add a quirck for B&W PX headphones

Ernesto A. Fern=E1ndez (1):
      btrfs: preserve i_mode if __btrfs_set_acl() fails

Greg Kroah-Hartman (1):
      Linux 4.9.87

Guillaume Nault (1):
      ppp: prevent unregistered channels from connecting to PPP units

Hans de Goede (1):
      ALSA: hda: Add a power_save blacklist

Heiner Kallweit (1):
      net: phy: fix phy_start to consider PHY_IGNORE_INTERRUPT

Ilya Lesokhin (1):
      tcp: Honor the eor bit in tcp_mtu_probe

Jakub Kicinski (1):
      net: fix race on decreasing number of TX queues

Jason A. Donenfeld (1):
      netlink: put module reference if dump start fails

Jeremy Boone (4):
      tpm: st33zp24: fix potential buffer overruns caused by bit glitches o=
n the bus
      tpm_i2c_infineon: fix potential buffer overruns caused by bit glitche=
s on the bus
      tpm_i2c_nuvoton: fix potential buffer overruns caused by bit glitches=
 on the bus
      tpm_tis: fix potential buffer overruns caused by bit glitches on the =
bus

John David Anglin (1):
      parisc: Fix ordering of cache and TLB flushes

Juergen Gross (1):
      x86/xen: Zero MSR_IA32_SPEC_CTRL before suspend

Julian Wiedmann (6):
      s390/qeth: fix SETIP command handling
      s390/qeth: fix overestimated count of buffer elements
      s390/qeth: fix IP removal on offline cards
      s390/qeth: fix double-free on IP add/remove race
      s390/qeth: fix IP address lookup for L3 devices
      s390/qeth: fix IPA command submission race

Lingutla Chandrasekhar (1):
      timers: Forward timer base before migrating timers

Mauro Carvalho Chehab (1):
      media: m88ds3103: don't call a non-initalized function

Mike Snitzer (1):
      dm io: fix duplicate bio completion due to missing ref count

NeilBrown (1):
      md: only allow remove_and_add_spares when no sync_thread running.

Nicolas Dichtel (1):
      netlink: ensure to loop over all netns in genlmsg_multicast_allns()

Paolo Bonzini (2):
      KVM/x86: Remove indirect MSR op calls from SPEC_CTRL
      KVM/VMX: Optimize vmx_vcpu_run() and svm_vcpu_run() by marking the RD=
MSR path as unlikely()

Rasmus Villemoes (1):
      nospec: Allow index argument to have const-qualified type

Sabrina Dubroca (1):
      net: ipv4: don't allow setting net.ipv4.route.min_pmtu below 68

Sebastian Panceac (1):
      x86/platform/intel-mid: Handle Intel Edison reboot correctly

Shalom Toledo (1):
      mlxsw: spectrum_switchdev: Check success of FDB add operation

Stefano Brivio (1):
      fib_semantics: Don't match route with mismatching tclassid

Takashi Iwai (1):
      ALSA: hda - Fix pincfg at resume on Lenovo T470 dock

Thomas Gleixner (1):
      x86/apic/vector: Handle legacy irq data correctly

Tim Chen (1):
      x86/speculation: Use Indirect Branch Prediction Barrier in context sw=
itch

Tommi Rantala (1):
      sctp: fix dst refcnt leak in sctp_v4_get_dst

Ulf Magnusson (1):
      ARM: mvebu: Fix broken PL310_ERRATA_753970 selects

Ursula Braun (1):
      s390/qeth: fix underestimated count of buffer elements

Viresh Kumar (1):
      cpufreq: s3c24xx: Fix broken s3c_cpufreq_init()

Wanpeng Li (1):
      KVM: mmu: Fix overlap between public and private memslots

Xin Long (1):
      bridge: check brport attr show in brport_show


--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqlXRsACgkQONu9yGCS
aT4aXRAAs1B+j45AJssYSJxgGw0+yivNR90rUgMg+nzc6UO5KC17NAmEzPutsJvK
uenPx00o/ItpKj9tjXaYO+VMe5PmGIudADqD513rNaSQxgpO5TPhR/GtzDG/JJMj
T5F8zV2oiDWUN/41jx159JzFkquY6iDs+RVnTwI1AzsKfP8BMvAyKSGK1g6JjMoL
EdUSygblUDhcG+PSf/cOouKw17dL7ZLPUpajRYkZNSGc5pvDlwK7i5E84A9iJVCF
V+Zfj2jAyBnvXEfBQBxCKqs02RQatkVgksbst6Vorw72qA2g89TYiOdogu9th6w4
rg+xRiKFbRIIYwZa04DbAm4frxbaxY4Xpxeo3aNnyElXEKdIkDX8mX3HGGoEmKWe
jSiBKkX1lOlYUcXMWKQTFGATdrnzgz0E0YtQ6Mcx/YNUZKJ7piJPoOLZj8GYDcLx
8VZnActBMZWCrKnX3lkhU2hGO1vwQofen+AoI21Jd0CVWCgrshPXBnUcy0ePpu53
hXrJhm9RHXcIsHIx1ASsUEhnX1MDQCfsKTuMJ/VQRw5zaiiiHH8F1mLxkJMFCLPx
1tsOXtbmE6mdupH7h/zU9kdl5Aus//sW/nZDXUOlAorwm8Rf6djqnfm0zGO8e4Wo
0UfcAg11lie7BpzDAHF8yZ4Io1TayfDZWUp/b4FcucFB6KAm82M=
=kdSh
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
