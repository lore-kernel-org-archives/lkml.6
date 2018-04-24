Date: Tue, 24 Apr 2018 10:52:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.106
Message-ID: <20180424085206.GA2937@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.106 kernel.

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

 Makefile                                      |    2=20
 arch/arm/boot/dts/at91sam9g25.dtsi            |    2=20
 arch/mips/lib/memset.S                        |   11 +
 arch/parisc/kernel/drivers.c                  |    4=20
 arch/powerpc/include/asm/barrier.h            |    3=20
 arch/powerpc/include/asm/opal.h               |    3=20
 arch/powerpc/include/asm/synch.h              |    4=20
 arch/powerpc/lib/feature-fixups.c             |    2=20
 arch/powerpc/platforms/powernv/opal-nvram.c   |   11 +
 arch/s390/hypfs/inode.c                       |    2=20
 arch/s390/kernel/ipl.c                        |    1=20
 drivers/char/random.c                         |    2=20
 drivers/clk/mvebu/armada-38x.c                |   15 +-
 drivers/gpu/drm/radeon/si_dpm.c               |    4=20
 drivers/hid/hidraw.c                          |    5=20
 drivers/hid/i2c-hid/i2c-hid.c                 |   13 -
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    4=20
 drivers/mmc/host/jz4740_mmc.c                 |    2=20
 drivers/mtd/ubi/block.c                       |    2=20
 drivers/mtd/ubi/build.c                       |   11 +
 drivers/net/slip/slhc.c                       |    5=20
 drivers/net/xen-netfront.c                    |    7=20
 drivers/pci/hotplug/acpiphp_glue.c            |   23 ++-
 drivers/s390/cio/qdio_main.c                  |   42 +++--
 drivers/thermal/imx_thermal.c                 |    6=20
 drivers/thunderbolt/nhi.c                     |    1=20
 drivers/usb/core/generic.c                    |    9 -
 drivers/usb/dwc3/dwc3-pci.c                   |    2=20
 drivers/usb/musb/musb_gadget_ep0.c            |   14 +
 drivers/watchdog/f71808e_wdt.c                |    2=20
 fs/autofs4/root.c                             |    2=20
 fs/ext4/inode.c                               |    6=20
 fs/ext4/super.c                               |    6=20
 fs/jbd2/journal.c                             |    5=20
 fs/jffs2/super.c                              |    2=20
 fs/namespace.c                                |    3=20
 fs/notify/fanotify/fanotify.c                 |   34 ++--
 fs/reiserfs/journal.c                         |    2=20
 fs/ubifs/super.c                              |   14 +
 include/net/slhc_vj.h                         |    1=20
 include/sound/pcm_oss.h                       |    1=20
 kernel/resource.c                             |    3=20
 net/sunrpc/rpc_pipe.c                         |    1=20
 sound/core/oss/pcm_oss.c                      |  189 ++++++++++++++++++++-=
-----
 sound/core/rawmidi_compat.c                   |   18 +-
 sound/soc/codecs/ssm2602.c                    |   19 +-
 46 files changed, 369 insertions(+), 151 deletions(-)

Aaron Ma (1):
      HID: i2c-hid: fix size check and type usage

Al Viro (4):
      jffs2_kill_sb(): deal with failed allocations
      hypfs_kill_super(): deal with failed allocations
      rpc_pipefs: fix double-dput()
      Don't leak MNT_INTERNAL away from internal mounts

Alex Smith (1):
      mmc: jz4740: Fix race condition in IRQ mask update

Amir Goldstein (1):
      fanotify: fix logic of events on child

Andrew Morton (1):
      fs/reiserfs/journal.c: add missing resierfs_warning() arg

Greg Kroah-Hartman (1):
      Linux 3.18.106

Heinrich Schuchardt (1):
      usb: musb: gadget: misplaced out of bounds check

Helge Deller (1):
      parisc: Fix out of array access in match_pci_device()

Ian Kent (1):
      autofs: mount point create should honour passed in mode

Igor Pylypiv (1):
      watchdog: f71808e_wdt: Fix WD_EN register read

James Kelly (1):
      ASoC: ssm2602: Replace reg_default_raw with reg_default

Jason Andryuk (1):
      xen-netfront: Fix hang on device removal

Julian Wiedmann (2):
      s390/qdio: don't retry EQBS after CCQ 96
      s390/qdio: don't merge ERROR output buffers

Matt Redfearn (3):
      MIPS: memset.S: EVA & fault support for small_memset
      MIPS: memset.S: Fix return of __clear_user from Lpartial_fixup
      MIPS: memset.S: Fix clobber of v1 in last_fixup

Mauro Carvalho Chehab (1):
      media: v4l2-compat-ioctl32: don't oops on overlay

Michael Ellerman (1):
      powerpc/lib: Fix off-by-one in alternate feature patching

Mika Westerberg (2):
      ACPI / hotplug / PCI: Check presence of slot itself in get_slot_statu=
s()
      thunderbolt: Resume control channel after hibernation image is created

Mikhail Lappo (1):
      thermal: imx: Fix race condition in imx_thermal_probe()

Nicholas Mc Guire (1):
      ALSA: oss: consolidate kmalloc/memset 0 call to kzalloc

Nicholas Piggin (4):
      powerpc/powernv: Handle unknown OPAL errors in opal_nvram_write()
      powerpc/64: Fix smp_wmb barrier definition use use lwsync consistently
      powerpc/powernv: define a standard delay for OPAL_BUSY type retry loo=
ps
      powerpc/powernv: Fix OPAL NVRAM driver OPAL_BUSY loops

Nicolas Ferre (1):
      ARM: dts: at91: at91sam9g25: fix mux-mask pinctrl property

Paul Parsons (1):
      drm/radeon: Fix PCIe lane width calculation

Ralph Sennhauser (1):
      clk: mvebu: armada-38x: add support for 1866MHz variants

Richard Genoud (1):
      clk: mvebu: armada-38x: add support for missing clocks

Richard Weinberger (2):
      ubifs: Check ubifs_wbuf_sync() return code
      ubi: Reject MLC NAND

Rodrigo Rivas Costa (1):
      HID: hidraw: Fix crash on HIDIOCGFEATURE with a destroyed device

Romain Izard (1):
      ubi: Fix error for write access

Takashi Iwai (7):
      resource: fix integer overflow at reallocation
      ALSA: pcm: Use ERESTARTSYS instead of EINTR in OSS emulation
      ALSA: pcm: Avoid potential races between OSS ioctls and read/write
      ALSA: pcm: Return -EBUSY for OSS ioctls changing busy streams
      ALSA: pcm: Fix mutex unbalance in OSS emulation ioctls
      ALSA: pcm: Fix endless loop for XRUN recovery in OSS emulation
      ALSA: rawmidi: Fix missing input substream checks in compat ioctls

Tejaswi Tanikella (1):
      slip: Check if rstate is initialized before uncompressing

Theodore Ts'o (4):
      random: use a tighter cap in credit_entropy_bits_safe()
      jbd2: if the journal is aborted then don't allow update of the log ta=
il
      ext4: fail ext4_iget for root directory if unallocated
      ext4: don't allow r/w mounts if metadata blocks overlap the superblock

Thinh Nguyen (1):
      usb: dwc3: pci: Properly cleanup resource

Vasily Gorbik (1):
      s390/ipl: ensure loadparm valid flag is set

Zhengjun Xing (1):
      USB:fix USB3 devices behind USB3 hubs not resuming at hibernate thaw


--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlre8DIACgkQONu9yGCS
aT7SFw//bQNWqEhaKPkaH5Cr72FKzLaWXBAdtIzVZz2pf5SmczGl1AniBb0UoZYZ
ilpB59sa+gRskgCMjj4xPosjPB2DsAX+c7rG28Xnc3OQPLDZmt0EoCUEu4sh2bPK
YJSCoE+3NiJt7uOYK2zldW2YrmLIjEOjDa5y4+JZmxgh85E8D8N6X6F6P/pBLcs/
8Gth4xwBmW8ZGqrGNJ+LWLFCvpX4eFa6JUzptH+QmtBKYnhK6pSSjeJuErsdxegH
sz6nQonXsEuxeL/qblQ42l6HLeVocxE3xnm73CnzFuCmd501SaWa5ytm/zI8S30h
/5KbaoQEidp7oETsfagdZkdMYQNN45N2ICxRkvOn+gK3W9eSdiB3SEKy47Boffgc
e3YTSRpmgO3hI4doI9lkFIspxNuhrGsDt0+7fyg+jdUPaFZNoWHuno32VjBFJz7a
wmtJ1++JOBXlcoAUow+BDYygP9AOQsIRtgQCBZLiWryIEVW1n4eaMClFxqv+UbGa
2JZeI2+zcHlcgpW+AXWzRfIx0hJIwUlYR3Zd3shgsY4WJSwkZB3JfwUDZg9oHPwo
5fO6rsFEvrbwJmWzVW70qgwHrY3iVnxWlFfLNnp+h3clvIr9CQZJB1dBzbw7GB8D
ldFjRH6/7NiIukwtDdf9ol2wXKRpDdmicBFOs8eZz3cA19TOk+4=
=0g+V
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
