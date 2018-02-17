Date: Sat, 17 Feb 2018 14:24:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.95
Message-ID: <20180217132437.GA15213@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.95 kernel.

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

 Makefile                                            |    2=20
 arch/alpha/kernel/pci_impl.h                        |    3=20
 arch/alpha/kernel/process.c                         |    3=20
 arch/arm/configs/exynos_defconfig                   |    7 +
 arch/mn10300/mm/misalignment.c                      |    2=20
 arch/openrisc/kernel/traps.c                        |   10 -
 arch/sh/kernel/traps_32.c                           |    3=20
 arch/xtensa/include/asm/futex.h                     |   23 +---
 crypto/ahash.c                                      |   11 ++
 crypto/cryptd.c                                     |    3=20
 drivers/acpi/sbshc.c                                |    4=20
 drivers/block/pktcdvd.c                             |    4=20
 drivers/crypto/caam/ctrl.c                          |    8 +
 drivers/edac/octeon_edac-lmc.c                      |    1=20
 drivers/media/usb/dvb-usb-v2/lmedm04.c              |   39 ++++---
 drivers/media/usb/dvb-usb/cxusb.c                   |    2=20
 drivers/media/usb/dvb-usb/dib0700_devices.c         |    1=20
 drivers/mtd/nand/nand_base.c                        |    5=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c |   18 +--
 drivers/net/ethernet/realtek/r8169.c                |    4=20
 drivers/usb/usbip/stub_dev.c                        |    3=20
 drivers/usb/usbip/stub_main.c                       |    5=20
 drivers/usb/usbip/stub_rx.c                         |   53 +++++++---
 drivers/usb/usbip/stub_tx.c                         |    4=20
 drivers/usb/usbip/usbip_common.c                    |   15 --
 drivers/usb/usbip/usbip_common.h                    |    1=20
 drivers/usb/usbip/usbip_event.c                     |    5=20
 drivers/usb/usbip/vhci_hcd.c                        |  102 ++++++++++-----=
-----
 drivers/usb/usbip/vhci_rx.c                         |   53 +++++-----
 drivers/usb/usbip/vhci_sysfs.c                      |   45 +++++---
 drivers/usb/usbip/vhci_tx.c                         |   17 +--
 drivers/vhost/net.c                                 |    1=20
 fs/cifs/cifsencrypt.c                               |    3=20
 fs/cifs/connect.c                                   |    6 -
 fs/cifs/file.c                                      |   26 ++---
 fs/cifs/misc.c                                      |   14 --
 fs/cifs/smb2pdu.c                                   |    3=20
 fs/kernfs/file.c                                    |    2=20
 fs/nfs/direct.c                                     |    4=20
 fs/nfs/write.c                                      |    2=20
 include/crypto/internal/hash.h                      |    2=20
 include/net/arp.h                                   |    6 -
 kernel/async.c                                      |   20 ++-
 kernel/time/posix-timers.c                          |   34 +++---
 net/dccp/proto.c                                    |    5=20
 net/ipv4/igmp.c                                     |    4=20
 net/ipv4/tcp.c                                      |    6 +
 net/ipv6/ip6mr.c                                    |    1=20
 security/keys/encrypted-keys/encrypted.c            |   31 ++----
 tools/usb/usbip/libsrc/usbip_common.c               |    9 +
 tools/usb/usbip/libsrc/usbip_host_driver.c          |   27 ++++-
 tools/usb/usbip/libsrc/vhci_driver.c                |    8 -
 52 files changed, 393 insertions(+), 277 deletions(-)

Andrew Goodbody (1):
      usb: usbip: Fix possible deadlocks reported by lockdep

Aurelien Aptel (1):
      CIFS: zero sensitive data when freeing

Bart Van Assche (1):
      pktcdvd: Fix pkt_setup_dev() error path

Chunhao Lin (1):
      r8169: fix RTL8168EP take too long to complete driver initialization.

Daniel N Pettersson (1):
      cifs: Fix autonegotiate security settings mismatch

Eric Biggers (3):
      KEYS: encrypted: fix buffer overread in valid_master_desc()
      crypto: hash - introduce crypto_hash_alg_has_setkey()
      crypto: cryptd - pass through absence of ->setkey()

Eric Dumazet (1):
      net: igmp: add a missing rcu locking section

Eric W. Biederman (3):
      signal/openrisc: Fix do_unaligned_access to send the proper signal
      signal/sh: Ensure si_signo is initialized in do_divide_error
      mn10300/misalignment: Use SIGSEGV SEGV_MAPERR to report a failed user=
 copy

Greg Kroah-Hartman (2):
      ACPI: sbshc: remove raw pointer from printk() message
      Linux 3.18.95

Horia Geant=C4=83 (1):
      crypto: caam - fix endless loop when DECO acquire fails

Ivan Vecera (1):
      kernfs: fix regression in kernfs_fop_write caused by wrong type

J. Bruce Fields (1):
      NFS: commit direct writes even if they fail partially

James Hogan (1):
      EDAC, octeon: Fix an uninitialized variable warning

Jason Wang (1):
      vhost_net: stop device during reset owner

Javier Martinez Canillas (1):
      ARM: exynos_defconfig: Enable options to mount a rootfs via NFS

Jonathan Dieter (1):
      usbip: Fix potential format overflow in userspace tools

Junxiao Bi (1):
      qlcnic: fix deadlock bug

Krzysztof Kozlowski (1):
      ARM: exynos_defconfig: Enable NFSv4 client

Li RongQing (1):
      tcp: release sk_frag.page in tcp_disconnect

Malcolm Priestley (2):
      media: dvb-usb-v2: lmedm04: Improve logic checking of warm start
      media: dvb-usb-v2: lmedm04: move ts2020 attach to dm04_lme2510_tuner

Matthew Wilcox (1):
      cifs: Fix missing put_xid in cifs_file_strict_mmap

Mauro Carvalho Chehab (1):
      media: cxusb, dib0700: ignore XC2028_I2C_FLUSH

Max Filippov (1):
      xtensa: fix futex_atomic_cmpxchg_inatomic

Mikulas Patocka (2):
      alpha: fix crash if pthread_create races with signal delivery
      alpha: fix reboot on Avanti platform

Miquel Raynal (1):
      mtd: nand: Fix nand_do_read_oob() return value

Mohamed Ghannam (1):
      dccp: CVE-2017-8824: use-after-free in DCCP code

Nikolay Aleksandrov (1):
      ip6mr: fix stale iterator

Rasmus Villemoes (1):
      kernel/async.c: revert "async: simplify lowest_in_progress()"

Shuah Khan (6):
      usbip: fix stub_rx: get_pipe() to validate endpoint number
      usbip: fix stub_rx: harden CMD_SUBMIT path to handle malicious input
      usbip: prevent vhci_hcd driver from leaking a socket pointer address
      usbip: prevent leaking socket pointer address in messages
      usbip: stub: stop printing kernel pointer addresses in messages
      usbip: vhci: stop printing kernel pointer addresses in messages

Thomas Gleixner (1):
      posix-timer: Properly check sigevent->sigev_notify

Trond Myklebust (1):
      NFS: Add a cond_resched() to nfs_commit_release_pages()

Wang Han (1):
      ipv4: Map neigh lookup keys in __ipv4_neigh_lookup_noref()

Yuyang Du (1):
      usbip: vhci-hcd: Add USB3 SuperSpeed support


--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqILREACgkQONu9yGCS
aT4TtA/+JEQcQOgI62VNl6hiUFhgR0kF4k0tp4+/ACDpiJ4GV9dqUZ84r9mRB1QQ
f2gni12bCvgdwbjIruDqFJlLllP+CgZKpJd/4UfHcBV43nKLhABYfLcqfMdwtj8c
fFppfPA6l1AhUz4pDWpYjIQcMysPiy09sc96iZbN+DFEMdP+f5XfrKjnwO+phb17
yACHVDElv3jb6ChF/dutFk8h9nAiwHFWRUcEhT9ZZdtGo7j3H8cgXrL0w2NENWLS
fagbk1HplvW1Xe40nTyMz5f3GZFzvkQg4TfYGMeNs1oHrqhlpeVNl0B2R+q38QBR
3zaNzjiT+Z62iI7p4dGGWEvuQWrc8z7vmw/4Om0zdqqDHjvnmkxqbSEISror4Jno
F+4YMiOY29dKMUShC2XwOUmth71PR0xO8wm852USlXaREFBgjuspe/J4LPnkZMi/
nMgDN3Qb7jFumCrlLEh5IU+EeRbg3w/MuQnlC01VjPeeZ4SPh4KMzLwXF4PGx9Et
5B6bD+7rZl+LRfhHaL+lCQ2SdRbD31CiociqqEPneOqn16pD/mGfLNkeuEZ+SYd+
08tTT+mtbqjJG3TtXBLQjHvwRtbKplQIiPajVSBqzVdBdOS0V2vV+rJVB39inF5Y
zaiUYMR9E3Isr1P4rkpuiQskzAlkzXK/diWsEp9ACsc7B1oE7Ew=
=3tZm
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
