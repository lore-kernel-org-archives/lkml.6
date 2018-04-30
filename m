Date: Mon, 30 Apr 2018 05:21:08 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.97
Message-ID: <20180430122108.GA6858@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.97 kernel.

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

 Documentation/kernel-parameters.txt        |    3=20
 Makefile                                   |    2=20
 arch/mips/Kconfig                          |    1=20
 arch/s390/Kconfig                          |   47 +++++
 arch/s390/Makefile                         |   10 +
 arch/s390/include/asm/alternative.h        |  149 +++++++++++++++++
 arch/s390/include/asm/barrier.h            |   24 ++
 arch/s390/include/asm/facility.h           |   18 ++
 arch/s390/include/asm/kvm_host.h           |    3=20
 arch/s390/include/asm/lowcore.h            |    7=20
 arch/s390/include/asm/nospec-branch.h      |   17 +
 arch/s390/include/asm/processor.h          |    4=20
 arch/s390/include/asm/thread_info.h        |    4=20
 arch/s390/include/uapi/asm/kvm.h           |    5=20
 arch/s390/kernel/Makefile                  |    6=20
 arch/s390/kernel/alternative.c             |  112 ++++++++++++
 arch/s390/kernel/early.c                   |    5=20
 arch/s390/kernel/entry.S                   |  250 ++++++++++++++++++++++++=
++---
 arch/s390/kernel/ipl.c                     |    1=20
 arch/s390/kernel/module.c                  |   65 +++++++
 arch/s390/kernel/nospec-branch.c           |  169 +++++++++++++++++++
 arch/s390/kernel/processor.c               |   18 ++
 arch/s390/kernel/setup.c                   |   14 +
 arch/s390/kernel/smp.c                     |    7=20
 arch/s390/kernel/uprobes.c                 |    9 +
 arch/s390/kernel/vmlinux.lds.S             |   37 ++++
 arch/s390/kvm/kvm-s390.c                   |   13 +
 arch/s390/kvm/vsie.c                       |   30 +++
 arch/x86/kernel/tsc.c                      |    2=20
 drivers/acpi/acpi_video.c                  |   27 ++-
 drivers/cdrom/cdrom.c                      |    2=20
 drivers/gpu/drm/drm_dp_dual_mode_helper.c  |   39 +++-
 drivers/gpu/drm/i915/i915_drv.h            |    6=20
 drivers/gpu/drm/i915/intel_display.c       |    9 -
 drivers/gpu/drm/i915/intel_pm.c            |    6=20
 drivers/gpu/drm/vc4/vc4_bo.c               |    2=20
 drivers/gpu/drm/vc4/vc4_validate_shaders.c |    1=20
 drivers/i2c/busses/i2c-i801.c              |   29 +++
 drivers/infiniband/hw/mlx5/qp.c            |    3=20
 drivers/input/misc/drv260x.c               |    2=20
 drivers/media/usb/stkwebcam/stk-sensor.c   |    6=20
 drivers/media/usb/stkwebcam/stk-webcam.c   |   11 -
 drivers/media/usb/stkwebcam/stk-webcam.h   |    2=20
 drivers/message/fusion/mptsas.c            |    1=20
 drivers/net/bonding/bond_main.c            |    3=20
 drivers/net/ethernet/ti/cpsw.c             |    2=20
 drivers/net/ppp/pppoe.c                    |    4=20
 drivers/net/team/team.c                    |   38 +++-
 drivers/net/usb/cdc_ether.c                |   10 +
 drivers/net/usb/r8152.c                    |    2=20
 drivers/net/wireless/ath/ath10k/mac.c      |    5=20
 drivers/net/wireless/ath/ath9k/hw.c        |    4=20
 drivers/net/wireless/mac80211_hwsim.c      |    7=20
 drivers/of/base.c                          |    2=20
 drivers/pci/pci.c                          |   52 ++++--
 drivers/pinctrl/intel/pinctrl-intel.c      |   23 --
 drivers/power/supply/bq2415x_charger.c     |    5=20
 drivers/s390/block/dasd_alias.c            |   13 +
 drivers/s390/char/Makefile                 |    2=20
 drivers/s390/cio/chsc.c                    |   14 +
 drivers/usb/musb/musb_core.c               |    8=20
 fs/cifs/dir.c                              |    9 -
 fs/jbd2/journal.c                          |    2=20
 include/linux/if_vlan.h                    |    7=20
 include/net/llc_conn.h                     |    1=20
 include/uapi/linux/kvm.h                   |    1=20
 kernel/events/callchain.c                  |   21 +-
 kernel/events/core.c                       |    4=20
 net/core/dev.c                             |    2=20
 net/core/neighbour.c                       |   40 +++-
 net/dns_resolver/dns_key.c                 |   13 -
 net/ipv4/tcp.c                             |    6=20
 net/ipv4/tcp_input.c                       |    7=20
 net/ipv6/route.c                           |    2=20
 net/l2tp/l2tp_ppp.c                        |    7=20
 net/llc/af_llc.c                           |   14 +
 net/llc/llc_c_ac.c                         |    9 -
 net/llc/llc_conn.c                         |   22 ++
 net/packet/af_packet.c                     |   82 ++++++---
 net/packet/internal.h                      |   10 -
 net/sched/act_ife.c                        |    2=20
 net/sctp/ipv6.c                            |   60 +++---
 net/strparser/strparser.c                  |    7=20
 net/tipc/netlink.c                         |    3=20
 tools/perf/util/dso.c                      |   16 -
 85 files changed, 1458 insertions(+), 261 deletions(-)

Alexander Aring (1):
      net: sched: ife: signal not finding metaid

Andreas Kemnade (1):
      usb: musb: fix enumeration after resume

Benjamin Beichler (1):
      mac80211_hwsim: fix use-after-free bug in hwsim_exit_net

Benjamin Tissoires (1):
      i2c: i801: store and restore the SLVCMD register at load and unload

Christian Borntraeger (3):
      KVM: s390: wire up bpb feature
      KVM: s390: force bp isolation for VSIE
      s390/entry.S: fix spurious zeroing of r0

Colin Ian King (1):
      power: supply: bq2415x: check for NULL acpi_id to avoid null pointer =
dereference

Cong Wang (3):
      llc: delete timers synchronously in llc_sk_free()
      llc: hold llc_sap before release_sock()
      llc: fix NULL pointer deref for SOCK_ZAPPED

Dan Carpenter (2):
      stk-webcam: fix an endian bug in stk_camera_read_reg()
      cdrom: information leak in cdrom_ioctl_media_changed()

Daniel J Blueman (1):
      drm/vc4: Fix memory leak during BO teardown

Dmitry Torokhov (1):
      Input: drv260x - fix initializing overdrive voltage

Doron Roberts-Kedes (1):
      strparser: Fix incorrect strp->need_bytes value.

Eric Biggers (1):
      KEYS: DNS: limit the length of option strings

Eric Dumazet (5):
      net: validate attribute sizes in neigh_dump_table()
      tipc: add policy for TIPC_NLA_NET_ADDR
      tcp: md5: reject TCP_MD5SIG or TCP_MD5SIG_EXT on established sockets
      net: af_packet: fix race in PACKET_{R|T}X_RING
      ipv6: add RTA_TABLE and RTA_PREFSRC to rtm_ipv6_policy

Eugeniu Rosca (1):
      s390: Replace IS_ENABLED(EXPOLINE_*) with IS_ENABLED(CONFIG_EXPOLINE_=
*)

Felix Fietkau (1):
      ath9k_hw: check if the chip failed to wake up

Grant Grundler (1):
      r8152: add Linksys USB3GIGV1 id

Greg Kroah-Hartman (3):
      Revert "perf tools: Decompress kernel module when reading DSO data"
      Revert "pinctrl: intel: Initialize GPIO properly when used through ir=
qchip"
      Linux 4.9.97

Guillaume Nault (2):
      l2tp: check sockaddr length in pppol2tp_connect()
      pppoe: check sockaddr length in pppoe_connect()

Hans de Goede (1):
      ACPI / video: Only default only_lcd to true on Win8-ready _desktops_

Heiko Carstens (2):
      s390: enable CPU alternatives unconditionally
      s390/uprobes: implement arch_uretprobe_is_alive()

Imre Deak (2):
      drm/i915: Fix LSPCON TMDS output buffer enabling from low-power state
      drm/i915/bxt, glk: Increase PCODE timeouts during CDCLK freq changing

Ivan Khoronzhuk (1):
      net: ethernet: ti: cpsw: fix tx vlan priority mapping

Jann Horn (1):
      tcp: don't read out-of-bounds opsize

Jean Delvare (2):
      i2c: i801: Save register SMBSLVCMD value only once
      i2c: i801: Restore configuration at shutdown

Jiri Olsa (2):
      perf: Fix sample_max_stack maximum check
      perf: Return proper values for user stack errors

Karthikeyan Periyasamy (1):
      Revert "ath10k: send (re)assoc peer command when NSS changed"

Leon Romanovsky (1):
      RDMA/mlx5: Fix NULL dereference while accessing XRC_TGT QPs

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

Matt Redfearn (1):
      MIPS: Generic: Fix big endian CPUs on generic machine

Merlijn Wajer (2):
      usb: musb: call pm_runtime_{get,put}_sync before reading vbus registe=
rs
      usb: musb: Fix external abort in musb_remove on omap2430

Paolo Abeni (1):
      team: avoid adding twice the same option to the event list

Paul Burton (1):
      OF: Prevent unaligned access in of_alias_scan()

Sahitya Tummala (1):
      jbd2: fix use after free in kjournald2()

Sebastian Ott (1):
      s390/cio: update chpid descriptor after resource accessibility event

Sinan Kaya (1):
      PCI: Wait up to 60 seconds for device to become ready after FLR

Stefan Haberland (1):
      s390/dasd: fix IO error for newly defined devices

Steve French (1):
      cifs: do not allow creating sockets except with SMB1 posix exensions

Toshiaki Makita (1):
      vlan: Fix reading memory beyond skb->tail in skb_vlan_tagged_multi

Vasily Gorbik (1):
      s390: introduce CPU alternatives

Willem de Bruijn (1):
      packet: fix bitfield update race

Wolfgang Bumiller (1):
      net: fix deadlock while clearing neighbor proxy table

Xiaoming Gao (1):
      x86/tsc: Prevent 32bit truncation in calc_hpet_ref()

Xin Long (3):
      bonding: do not set slave_dev npinfo before slave_enable_netpoll in b=
ond_enslave
      team: fix netconsole setup over team
      sctp: do not check port in sctp_inet6_cmp_addr


--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrnCjQACgkQONu9yGCS
aT6jmw/+KX7V/FSFcFjRv8dwTQwOVKrJ+Yjsp2nH8BF/rn2WTGQeHrd6ubduhfet
oTgauO18RtxPlG2bvXUaFiKkw8Q7qkd0AfMLehMLjGuPUkJIBmH/9Y9NSGoTOPFc
RmJLZYBLqkyrGKJpH5kb8gv2WuO9LPfVZpNZKAi5+2ScyxbJfxniE7Z057fb2eZY
AdIT/ft3fL38TfjIaDxrOTsfm/h/FaKH/YFHY2r9NPqwNgJmxWKJvSaLhAddXYPQ
aC0wQeDQLZVumcEudPNHIUHpEvke26hb6tr6E77ig8kW7dZ8OZYJGz2RbniCFi1v
/Cmtr4gAPa3Wqiw1sEMyq0JiDwYClWpKOO/BfgnEaax7YvS06k2DnVVHTacJrpti
4+Nakar0himxe9f5SIH2LvtA4SQDq5V+R0wKZxHF1WISiio88iyArnpkJB1wTSaB
5CeuOfvRoYNsIC55UHt44plkgczMQP/SXM6vOVRmeoCRiWQw0gBR1kDcD2HMfA4+
WK0Xyu2X5KfD9TtIG8Bdvgypf2bBBe0uSKzsMh+hecdYBH9F1/XrOjumeuYh8he8
8PEDaaRwENmbyS5iBxgCdnh4O88geAjU7W/XcsbdN4I3bA6zPR90eK7cI6fC3cLG
/zSyO4yw3wOz/DMSyt204Oo9fmni9iZjdGSyC48dJgAHDACY9YI=
=0/qX
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
