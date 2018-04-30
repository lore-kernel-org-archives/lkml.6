Date: Mon, 30 Apr 2018 05:19:39 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.130
Message-ID: <20180430121939.GA6653@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.130 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/kernel-parameters.txt           |    3=20
 Makefile                                      |    2=20
 arch/s390/Kconfig                             |   47 ++++
 arch/s390/Makefile                            |   10 +
 arch/s390/include/asm/alternative.h           |  149 +++++++++++++++
 arch/s390/include/asm/barrier.h               |   24 ++
 arch/s390/include/asm/facility.h              |   18 +
 arch/s390/include/asm/kvm_host.h              |    3=20
 arch/s390/include/asm/lowcore.h               |    7=20
 arch/s390/include/asm/nospec-branch.h         |   17 +
 arch/s390/include/asm/processor.h             |    4=20
 arch/s390/include/asm/thread_info.h           |    4=20
 arch/s390/include/uapi/asm/kvm.h              |    3=20
 arch/s390/kernel/Makefile                     |    5=20
 arch/s390/kernel/alternative.c                |  112 +++++++++++
 arch/s390/kernel/early.c                      |    5=20
 arch/s390/kernel/entry.S                      |  250 +++++++++++++++++++++=
++---
 arch/s390/kernel/ipl.c                        |    1=20
 arch/s390/kernel/module.c                     |   65 ++++++
 arch/s390/kernel/nospec-branch.c              |  169 +++++++++++++++++
 arch/s390/kernel/processor.c                  |   18 +
 arch/s390/kernel/setup.c                      |   14 +
 arch/s390/kernel/smp.c                        |    7=20
 arch/s390/kernel/uprobes.c                    |    9=20
 arch/s390/kernel/vmlinux.lds.S                |   37 +++
 arch/s390/kvm/kvm-s390.c                      |   12 +
 arch/x86/kernel/tsc.c                         |    2=20
 drivers/cdrom/cdrom.c                         |    2=20
 drivers/input/misc/drv260x.c                  |    2=20
 drivers/message/fusion/mptsas.c               |    1=20
 drivers/net/bonding/bond_main.c               |    3=20
 drivers/net/ppp/pppoe.c                       |    4=20
 drivers/net/team/team.c                       |   38 +++
 drivers/net/usb/cdc_ether.c                   |   10 +
 drivers/net/usb/r8152.c                       |    2=20
 drivers/net/wireless/ath/ath10k/mac.c         |    5=20
 drivers/net/wireless/ath/ath9k/hw.c           |    4=20
 drivers/s390/char/Makefile                    |    2=20
 drivers/s390/cio/chsc.c                       |   14 +
 drivers/staging/android/ion/ion_system_heap.c |    2=20
 fs/cifs/dir.c                                 |    9=20
 fs/jbd2/journal.c                             |    2=20
 include/linux/if_vlan.h                       |    7=20
 include/net/llc_conn.h                        |    1=20
 include/uapi/linux/kvm.h                      |    1=20
 kernel/events/core.c                          |    4=20
 net/core/dev.c                                |    2=20
 net/core/neighbour.c                          |   40 ++--
 net/dns_resolver/dns_key.c                    |   13 -
 net/ipv4/tcp.c                                |    6=20
 net/ipv4/tcp_input.c                          |    7=20
 net/ipv6/route.c                              |    2=20
 net/l2tp/l2tp_ppp.c                           |    7=20
 net/llc/af_llc.c                              |   14 +
 net/llc/llc_c_ac.c                            |    9=20
 net/llc/llc_conn.c                            |   22 ++
 net/packet/af_packet.c                        |   88 ++++++---
 net/packet/internal.h                         |   10 -
 net/sctp/ipv6.c                               |   60 +++---
 net/tipc/net.c                                |    3=20
 60 files changed, 1227 insertions(+), 166 deletions(-)

Chen Feng (1):
      staging: ion : Donnot wakeup kswapd in ion system alloc

Christian Borntraeger (2):
      KVM: s390: wire up bpb feature
      s390/entry.S: fix spurious zeroing of r0

Cong Wang (3):
      llc: delete timers synchronously in llc_sk_free()
      llc: hold llc_sap before release_sock()
      llc: fix NULL pointer deref for SOCK_ZAPPED

Dan Carpenter (1):
      cdrom: information leak in cdrom_ioctl_media_changed()

Dmitry Torokhov (1):
      Input: drv260x - fix initializing overdrive voltage

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

Greg Kroah-Hartman (1):
      Linux 4.4.130

Guillaume Nault (2):
      l2tp: check sockaddr length in pppol2tp_connect()
      pppoe: check sockaddr length in pppoe_connect()

Heiko Carstens (2):
      s390: enable CPU alternatives unconditionally
      s390/uprobes: implement arch_uretprobe_is_alive()

Jann Horn (1):
      tcp: don't read out-of-bounds opsize

Jiri Olsa (1):
      perf: Return proper values for user stack errors

Karthikeyan Periyasamy (1):
      Revert "ath10k: send (re)assoc peer command when NSS changed"

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

Paolo Abeni (1):
      team: avoid adding twice the same option to the event list

Sahitya Tummala (1):
      jbd2: fix use after free in kjournald2()

Sebastian Ott (1):
      s390/cio: update chpid descriptor after resource accessibility event

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


--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrnCdkACgkQONu9yGCS
aT5UEQ/8CRtaKouIyzXq4SH/UZz8k5OKwgHJKD67MdM213l6YoJF8MWwc2mhQD9G
IJvrFvgo+JW1uVlbb5BDlRsS+pJciAURJ5Ao27lS6Fx9K05NG2uKUrN1PjJrgF6B
QjfQWLGwUvmjcvtpaVVNROnBjhEi24brXW/jrlKakSRO0uiQODUzAns+CzyCplQO
n77k8AqTBLUhPePiKZg9ITCeWW6aK/JHwm7QneYWIsJ8c88QA3JJLpEQC62zV4rd
I0M+Nam69OODnhidh2riVdB65xkUL3+nqkMICAJuHG39Zx39Bs6O68W6WVgQYaen
D0d8isI2QB3HHjA1Dlo+qL5v8n4CKp32d+GsUQPos95mPuXHDSNm6uHwr1r9KqRm
RxclTZHl4V5Iks8eglPe+jQdWnA9ZPYgOyn3DSZqxOBLLTg0B887fzAlzr7dWbdp
zSu2aPA8/woZ+qps0bQxx+9RTjWBhNaUvLm2VglaTQF/ARuCQPwOjorg5NwpDOHS
+GC0IZbnANNN6pdmiZNHMnKnQgrXzq3lz6k2k8eG9yWk+kmQJ2qBSmuezJAJQtvf
7IpaxOgBV0kOxbln583qbjJdC51btEDlU0+xL/mawcwJG94Unk+HAkGnVz0A0b4g
57v19SegnB9DYR7c+XByKskewnjVGnbp0KoiPG5qZE55Av7qc7Y=
=eKCf
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
