Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936330AbeEYOvl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:51:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936186AbeEYOvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:51:39 -0400
Date: Fri, 25 May 2018 16:51:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.110
Message-ID: <20180525145121.GA4609@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.110 kernel.

All users of the 3.18 kernel series must upgrade.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-3.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                        |    2=20
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi        |    1=20
 arch/arm/include/asm/assembler.h                |   10 ++
 arch/arm/kernel/traps.c                         |    5 -
 arch/arm/lib/getuser.S                          |   10 ++
 arch/powerpc/kernel/setup-common.c              |   11 --
 arch/powerpc/platforms/powernv/opal-nvram.c     |   14 ++-
 arch/x86/boot/compressed/eboot.c                |    6 -
 arch/x86/kernel/machine_kexec_32.c              |    6 +
 arch/x86/kernel/machine_kexec_64.c              |    4=20
 arch/x86/xen/mmu.c                              |    4=20
 drivers/net/bonding/bond_alb.c                  |    2=20
 drivers/net/ethernet/broadcom/tg3.c             |    9 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c |   16 +++
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h    |    7 +
 drivers/net/ethernet/realtek/8139too.c          |    2=20
 drivers/net/ethernet/realtek/r8169.c            |    3=20
 drivers/net/ethernet/sun/niu.c                  |    5 -
 drivers/net/usb/qmi_wwan.c                      |   13 ++
 drivers/scsi/libsas/sas_scsi_host.c             |   33 ++-----
 drivers/scsi/sg.c                               |    2=20
 drivers/usb/usbip/stub.h                        |    2=20
 drivers/usb/usbip/stub_dev.c                    |   69 +++++++++------
 drivers/usb/usbip/stub_main.c                   |  105 +++++++++++++++++++=
++---
 fs/ext2/inode.c                                 |   10 --
 fs/hfsplus/super.c                              |    1=20
 fs/lockd/svc.c                                  |    2=20
 fs/pipe.c                                       |    3=20
 include/linux/efi.h                             |    8 -
 include/trace/events/xen.h                      |   16 ---
 include/uapi/linux/nl80211.h                    |    2=20
 kernel/exit.c                                   |    4=20
 kernel/time/tick-broadcast.c                    |    8 +
 net/bridge/br_if.c                              |    4=20
 net/compat.c                                    |    6 -
 net/dccp/ccids/ccid2.c                          |   14 ++-
 net/dccp/timer.c                                |    2=20
 net/ipv4/ip_output.c                            |    3=20
 net/ipv4/ping.c                                 |    7 +
 net/ipv4/tcp.c                                  |    2=20
 net/ipv4/tcp_output.c                           |    7 +
 net/ipv4/udp.c                                  |    7 +
 net/ipv6/ip6_output.c                           |    3=20
 net/l2tp/l2tp_netlink.c                         |    2=20
 net/llc/af_llc.c                                |    3=20
 net/sched/sch_fq.c                              |   37 +++++---
 net/sctp/associola.c                            |   30 ++++++
 net/sctp/inqueue.c                              |    2=20
 net/sctp/sm_statefuns.c                         |   89 +++++++++++---------
 net/wireless/core.c                             |    3=20
 sound/core/control_compat.c                     |    3=20
 sound/usb/mixer.c                               |    8 +
 52 files changed, 426 insertions(+), 201 deletions(-)

Al Viro (1):
      ext2: fix a block leak

Alexander Potapenko (1):
      scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()

Alexey Khoroshilov (1):
      usbip: fix error handling in stub_probe()

Andrey Ignatov (1):
      ipv4: fix memory leaks in udp_sendmsg, ping_v4_sendmsg

Ard Biesheuvel (1):
      efi: Avoid potential crashes, fix the 'struct efi_pci_io_protocol_32'=
 definition for mixed mode

Benjamin Herrenschmidt (1):
      powerpc: Don't preempt_disable() in show_cpuinfo()

Bj=F8rn Mork (1):
      qmi_wwan: do not steal interfaces from class drivers

Debabrata Banerjee (1):
      bonding: do not allow rlb updates to invalid mac

Dexuan Cui (1):
      tick/broadcast: Use for_each_cpu() specially on UP kernels

Eric Dumazet (4):
      dccp: fix tasklet usage
      llc: better deal with too small mtu
      net_sched: fq: take care of throttled flows before reuse
      tcp: purge write queue in tcp_connect_init()

Federico Cuello (1):
      ALSA: usb: mixer: volume quirk for CM102-A+/102S+

Greg Kroah-Hartman (2):
      Revert "ARM: dts: imx6qdl-wandboard: Fix audio channel swap"
      Linux 3.18.110

Hangbin Liu (1):
      bridge: check iface upper dev when setting master via ioctl

Heiner Kallweit (1):
      r8169: fix powering up RTL8168h

Ingo Molnar (1):
      8139too: Use disable_irq_nosync() in rtl8139_poll_controller()

James Chapman (1):
      l2tp: revert "l2tp: fix missing print session offset info"

Jason Yan (1):
      scsi: libsas: defer ata device eh commands to libata

Johannes Berg (1):
      cfg80211: limit wiphy names to 128 bytes

Lance Richardson (1):
      net: support compat 64-bit time in {s,g}etsockopt

Masami Hiramatsu (2):
      ARM: 8771/1: kprobes: Prohibit kprobes on do_undefinstr
      ARM: 8772/1: kprobes: Prohibit kprobes on get_user functions

Michael Chan (1):
      tg3: Fix vunmap() BUG_ON() triggered from tg3_free_consistent().

Michael Kerrisk (man-pages) (1):
      pipe: cap initial pipe capacity according to pipe-max-size limit

Moshe Shemesh (1):
      net/mlx4_en: Verify coalescing parameters are in range

Nicholas Piggin (1):
      powerpc/powernv: Fix NVRAM sleep in invalid context when crashing

Rob Taglang (1):
      net: ethernet: sun: niu set correct packet size in skb

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

Tetsuo Handa (2):
      hfsplus: stop workqueue when fill_super() failed
      x86/kexec: Avoid double free_page() upon do_kexec_load() failure

Vasily Averin (1):
      lockd: lost rollback of set_grace_period() in lockd_down_net()

Wenwen Wang (1):
      ALSA: control: fix a redundant-copy issue

Willem de Bruijn (1):
      net: test tailroom before appending to linear skb

Xin Long (3):
      sctp: use the old asoc when making the cookie-ack chunk in dupcook_d
      sctp: fix the issue that the cookie-ack with auth can't get processed
      sctp: delay the authentication for the duplicated cookie-echo chunk

Yuchung Cheng (1):
      tcp: ignore Fast Open on repair mode

zhongjiang (1):
      kernel/exit.c: avoid undefined behaviour when calling wait4()


--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsIIukACgkQONu9yGCS
aT79uhAAkLFC9z4nTDVo2TbtcSBuY0jEo4hDE9aagkxWR3EGRjMJADkS1Q521hP/
QMogzlmIaPzrqY5/yRIL+4wboHnL/SOfOGiB+D3aC5km7qUOlxsFAzSBh5cl/9Iw
43CZ3DN9fBFVQi9G9FcYNvJdYtIVvJc0TZBEOMVAhPI0zJXWAZpY+baFSiehOc+f
CuNXx+5cmuGsAThLznX9bIh/qtfepobj6HhKmjQeEH3Bc12JeFYQXq16IUQEKG0g
X8zX1/AZyaNAn30SMnTaCmbZQ1vCaNXYKEXElROcjyL0+/Yvl3uUiwSA3ZYbh7Pp
8uvPF7Y39bvInCif1g0daOYvkfuxchgqjv+dNfI5xTkuVFOhpWQXfzABgm0hAkDk
iL82ZK8eQBSDfReHEznw2MRNGjL08Wzn3HG1ZHp+8SA3/ywA3iYw8ghbTPOqvsqp
BhRDqX5nTXm0zUNK2a8COXLKWP6K7DT0kK7d/UulK912ysrQrCAPu3/tcWet7rOw
A9r5Dpo/2B9PNGVicM4jckPUSM2MPRI6ufFdVnh1JMwDBCSfGsrqFIYaXlOr0G8z
6z3tREbyER2p/Z4mR7fmQZYvPyEevsmMvEt3BJqPiwR4p/mctgh2E0VV3gia1N2Y
v4nZ62oCn7nQCfJbhcQ32iD2bdVcrb0sxlM8veEDGerdSPKk7EU=
=wuYQ
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
