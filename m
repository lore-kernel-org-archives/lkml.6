Date: Mon, 30 Apr 2018 05:21:30 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.38
Message-ID: <20180430122130.GA6932@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.38 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt    |    3=20
 Makefile                                           |    2=20
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      |   11=20
 arch/microblaze/Kconfig.platform                   |    1=20
 arch/microblaze/lib/fastcopy.S                     |    4=20
 arch/s390/Kconfig                                  |   47 +++
 arch/s390/Makefile                                 |   10=20
 arch/s390/include/asm/alternative.h                |  149 ++++++++++++
 arch/s390/include/asm/barrier.h                    |   24 ++
 arch/s390/include/asm/facility.h                   |   18 +
 arch/s390/include/asm/kvm_host.h                   |    3=20
 arch/s390/include/asm/lowcore.h                    |    7=20
 arch/s390/include/asm/nospec-branch.h              |   17 +
 arch/s390/include/asm/processor.h                  |    4=20
 arch/s390/include/asm/thread_info.h                |    4=20
 arch/s390/include/uapi/asm/kvm.h                   |    5=20
 arch/s390/kernel/Makefile                          |    6=20
 arch/s390/kernel/alternative.c                     |  112 +++++++++
 arch/s390/kernel/early.c                           |    5=20
 arch/s390/kernel/entry.S                           |  250 ++++++++++++++++=
++---
 arch/s390/kernel/ipl.c                             |    1=20
 arch/s390/kernel/module.c                          |   65 +++++
 arch/s390/kernel/nospec-branch.c                   |  169 ++++++++++++++
 arch/s390/kernel/processor.c                       |   18 +
 arch/s390/kernel/setup.c                           |   14 +
 arch/s390/kernel/smp.c                             |    7=20
 arch/s390/kernel/uprobes.c                         |    9=20
 arch/s390/kernel/vmlinux.lds.S                     |   37 +++
 arch/s390/kvm/kvm-s390.c                           |   12 +
 arch/s390/kvm/vsie.c                               |   30 ++
 drivers/acpi/acpi_video.c                          |   27 ++
 drivers/block/swim.c                               |   49 +---
 drivers/block/swim3.c                              |    6=20
 drivers/cdrom/cdrom.c                              |    2=20
 drivers/char/tpm/tpm-interface.c                   |  131 ++++++++---
 drivers/char/tpm/tpm.h                             |    1=20
 drivers/char/tpm/tpm_crb.c                         |  108 ++++++---
 drivers/char/tpm/tpm_tis_core.c                    |    4=20
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |    3=20
 drivers/message/fusion/mptsas.c                    |    1=20
 drivers/net/bonding/bond_main.c                    |    3=20
 drivers/net/ethernet/amd/xgbe/xgbe-common.h        |    8=20
 drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c       |   16 +
 drivers/net/ethernet/amd/xgbe/xgbe-main.c          |    1=20
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |   24 +-
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c           |    2=20
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c        |  196 ++++++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe.h               |    9=20
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   11=20
 drivers/net/ethernet/ti/cpsw.c                     |    2=20
 drivers/net/ppp/pppoe.c                            |    4=20
 drivers/net/team/team.c                            |   38 ++-
 drivers/net/virtio_net.c                           |   68 +++--
 drivers/net/wireless/ath/ath10k/mac.c              |    5=20
 drivers/pinctrl/intel/pinctrl-intel.c              |   23 -
 drivers/s390/block/dasd_alias.c                    |   13 -
 drivers/s390/char/Makefile                         |    2=20
 drivers/s390/cio/chsc.c                            |   14 -
 include/linux/fsnotify_backend.h                   |    4=20
 include/linux/hmm.h                                |    9=20
 include/linux/if_vlan.h                            |    7=20
 include/linux/tpm.h                                |    2=20
 include/net/ife.h                                  |    3=20
 include/net/llc_conn.h                             |    1=20
 include/net/tcp.h                                  |    1=20
 include/uapi/linux/kvm.h                           |    1=20
 kernel/trace/trace_entries.h                       |    2=20
 net/core/dev.c                                     |    2=20
 net/core/neighbour.c                               |   40 ++-
 net/dns_resolver/dns_key.c                         |   13 -
 net/ife/ife.c                                      |   38 +++
 net/ipv4/tcp.c                                     |    7=20
 net/ipv4/tcp_input.c                               |    7=20
 net/ipv6/route.c                                   |    2=20
 net/ipv6/seg6_iptunnel.c                           |    2=20
 net/l2tp/l2tp_ppp.c                                |    7=20
 net/llc/af_llc.c                                   |   14 +
 net/llc/llc_c_ac.c                                 |    9=20
 net/llc/llc_conn.c                                 |   22 +
 net/packet/af_packet.c                             |   83 ++++--
 net/packet/internal.h                              |   10=20
 net/sched/act_ife.c                                |    9=20
 net/sctp/ipv6.c                                    |   60 ++---
 net/smc/af_smc.c                                   |   10=20
 net/strparser/strparser.c                          |    9=20
 net/tipc/netlink.c                                 |    3=20
 security/commoncap.c                               |    2=20
 87 files changed, 1835 insertions(+), 359 deletions(-)

Ahmed Abdelsalam (1):
      ipv6: sr: fix NULL pointer dereference in seg6_do_srh_encap()- v4 pkts

Alexander Aring (3):
      net: sched: ife: signal not finding metaid
      net: sched: ife: handle malformed tlv length
      net: sched: ife: check on metadata length

Christian Borntraeger (3):
      KVM: s390: wire up bpb feature
      KVM: s390: force bp isolation for VSIE
      s390/entry.S: fix spurious zeroing of r0

Cong Wang (3):
      llc: delete timers synchronously in llc_sk_free()
      llc: hold llc_sap before release_sock()
      llc: fix NULL pointer deref for SOCK_ZAPPED

Dan Carpenter (1):
      cdrom: information leak in cdrom_ioctl_media_changed()

Doron Roberts-Kedes (2):
      strparser: Do not call mod_delayed_work with a timeout of LONG_MAX
      strparser: Fix incorrect strp->need_bytes value.

Eric Biggers (1):
      KEYS: DNS: limit the length of option strings

Eric Dumazet (5):
      ipv6: add RTA_TABLE and RTA_PREFSRC to rtm_ipv6_policy
      net: validate attribute sizes in neigh_dump_table()
      net: af_packet: fix race in PACKET_{R|T}X_RING
      tcp: md5: reject TCP_MD5SIG or TCP_MD5SIG_EXT on established sockets
      tipc: add policy for TIPC_NLA_NET_ADDR

Eugeniu Rosca (1):
      s390: Replace IS_ENABLED(EXPOLINE_*) with IS_ENABLED(CONFIG_EXPOLINE_=
*)

Finn Thain (8):
      m68k/mac: Don't remap SWIM MMIO region
      block/swim: Check drive type
      block/swim: Don't log an error message for an invalid ioctl
      block/swim: Remove extra put_disk() call from error path
      block/swim: Rename macros to avoid inconsistent inverted logic
      block/swim: Select appropriate drive on device open
      block/swim: Fix array bounds check
      block/swim: Fix IO error at end of medium

Greg Kroah-Hartman (3):
      Revert "pinctrl: intel: Initialize GPIO properly when used through ir=
qchip"
      Revert "mm/hmm: fix header file if/else/endif maze"
      Linux 4.14.38

Guillaume Nault (2):
      l2tp: check sockaddr length in pppol2tp_connect()
      pppoe: check sockaddr length in pppoe_connect()

Hans de Goede (1):
      ACPI / video: Only default only_lcd to true on Win8-ready _desktops_

Heiko Carstens (2):
      s390: enable CPU alternatives unconditionally
      s390/uprobes: implement arch_uretprobe_is_alive()

Ivan Khoronzhuk (1):
      net: ethernet: ti: cpsw: fix tx vlan priority mapping

James Bottomley (1):
      tpm: add retry logic

Jann Horn (1):
      tcp: don't read out-of-bounds opsize

Karthikeyan Periyasamy (1):
      Revert "ath10k: send (re)assoc peer command when NSS changed"

Klaus Goger (1):
      arm64: dts: rockchip: remove vdd_log from rk3399-puma

Martin K. Petersen (1):
      scsi: mptsas: Disable WRITE SAME

Martin Schwidefsky (13):
      s390: scrub registers on kernel entry and KVM exit
      s390: add optimized array_index_mask_nospec
      s390/alternative: use a copy of the facility bit mask
      s390: add options to change branch prediction behaviour for the kernel
      s390: run user space and KVM guests with modified branch prediction
      s390: introduce execute-trampolines for branches
      s390: do not bypass BPENTER for interrupt system calls
      s390: move nobp parameter functions to nospec-branch.c
      s390: add automatic detection of the spectre defense
      s390: report spectre mitigation via syslog
      s390: add sysfs attributes for spectre
      s390: correct nospec auto detection init order
      s390: correct module section names for expoline code revert

Michael S. Tsirkin (2):
      virtio_net: split out ctrl buffer
      virtio_net: fix adding vids on big-endian

Michal Simek (1):
      microblaze: Setup dependencies for ASM optimized lib functions

Neil Armstrong (1):
      drm: bridge: dw-hdmi: Fix overflow workaround for Amlogic Meson GX So=
Cs

Paolo Abeni (1):
      team: avoid adding twice the same option to the event list

Pawe=C5=82 Jab=C5=82o=C5=84ski (1):
      i40e: Fix attach VF to VM issue

Peter Xu (1):
      tracing: Fix missing tab for hwlat_detector print format

Robert Kolchmeyer (1):
      fsnotify: Fix fsnotify_mark_connector race

Sebastian Ott (1):
      s390/cio: update chpid descriptor after resource accessibility event

Soheil Hassas Yeganeh (1):
      tcp: clear tp->packets_out when purging write queue

Stefan Haberland (1):
      s390/dasd: fix IO error for newly defined devices

Tetsuo Handa (1):
      commoncap: Handle memory allocation failure.

Tom Lendacky (3):
      amd-xgbe: Add pre/post auto-negotiation phy hooks
      amd-xgbe: Improve KR auto-negotiation and training
      amd-xgbe: Only use the SFP supported transceiver signals

Tomas Winkler (1):
      tpm: cmd_ready command can be issued only after granting locality

Toshiaki Makita (1):
      vlan: Fix reading memory beyond skb->tail in skb_vlan_tagged_multi

Ursula Braun (1):
      net/smc: fix shutdown in state SMC_LISTEN

Vasily Gorbik (1):
      s390: introduce CPU alternatives

Willem de Bruijn (1):
      packet: fix bitfield update race

Winkler, Tomas (1):
      tpm: tpm-interface: fix tpm_transmit/_cmd kdoc

Wolfgang Bumiller (1):
      net: fix deadlock while clearing neighbor proxy table

Xin Long (3):
      bonding: do not set slave_dev npinfo before slave_enable_netpoll in b=
ond_enslave
      team: fix netconsole setup over team
      sctp: do not check port in sctp_inet6_cmp_addr


--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrnCkkACgkQONu9yGCS
aT72rxAApCNj4SwmuxW0Z04nDVPWO/I7MiQX5SE9wf9lTxj3C5lQrgeTIWQ5w175
TOW1+76WMDIgS9/sweWEHHW6e17/rx6NCc39/ZjHmOg+Tz/to4+49eav6MHMOoVs
tRopF0Q31Reazst04cfORsFzplBCIXqMN7CtCYPQu1cznWPul6RanZaJq+CYy5o+
ImVVrN+wwKrsf+S9rGFAjqUe0JZN6MmIindngvgVYjRrVOoWwx2AGe3H9UtD8LWu
CS2ixO4iX9cJBd7Yoc3kpqtgP2DYd//aRQetQ4tEXe0RnbhFlM7PgtH0qyWXHTca
N+9JnWn2Y1e0Pjj5ShavwNRDxhrPOxCuU4DnqhfcijJiR7/9ow+e+md6sWEmJsO3
3xtK2XxNbCMQaFav73PHHR4ICCa444jo3sxdODj0UOTaBTMopR9ceRae1gxQQ0mB
Da9VVn77/DcogjNL/6COOKG/0x1t65OIuyBkvzaNORM4d+IZYWUicAVTxACzvSs8
DDQRrln1DJOuuN4jTxRRHFq7j2Jn0Oa2irc+2k9+CyfAJ+qQpuXQ/iA5V01tWF9g
Byf9RhY3RwwQN83feUI/YWCvjdSBM9X4autUS73bIpXlTQaAo6PxJVXnhTYUr7x6
Lab+BYJAbZPfFb5NWGhPxQTs92rmyo93Q6j/L7oJwMdguId7ZZI=
=jPnE
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
