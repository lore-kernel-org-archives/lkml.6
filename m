Date: Tue, 24 Apr 2018 11:18:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.129
Message-ID: <20180424091842.GA17554@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.129 kernel.

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

 Makefile                                            |    2=20
 arch/arm/boot/dts/at91sam9g25.dtsi                  |    2=20
 arch/arm/boot/dts/sama5d4.dtsi                      |    2=20
 arch/mips/include/asm/uaccess.h                     |   11 -
 arch/mips/lib/memset.S                              |   11 -
 arch/parisc/kernel/drivers.c                        |    4=20
 arch/powerpc/include/asm/barrier.h                  |    3=20
 arch/powerpc/include/asm/opal.h                     |    3=20
 arch/powerpc/include/asm/synch.h                    |    4=20
 arch/powerpc/kernel/eeh_pe.c                        |    3=20
 arch/powerpc/lib/feature-fixups.c                   |    2=20
 arch/powerpc/platforms/powernv/opal-nvram.c         |   11 +
 arch/s390/hypfs/inode.c                             |    2=20
 arch/s390/kernel/ipl.c                              |    1=20
 arch/um/os-Linux/signal.c                           |    2=20
 arch/x86/Kconfig                                    |    5=20
 arch/x86/include/asm/arch_hweight.h                 |   24 +-
 arch/x86/kernel/i386_ksyms_32.c                     |    2=20
 arch/x86/kernel/x8664_ksyms_64.c                    |    3=20
 arch/x86/lib/Makefile                               |    2=20
 arch/x86/lib/hweight.S                              |   79 ++++++++
 arch/x86/um/stub_segv.c                             |    2=20
 drivers/acpi/video_detect.c                         |    9=20
 drivers/base/regmap/regmap.c                        |    2=20
 drivers/block/loop.c                                |   12 -
 drivers/char/random.c                               |    2=20
 drivers/clk/bcm/clk-bcm2835.c                       |    8=20
 drivers/clk/mvebu/armada-38x.c                      |   15 -
 drivers/dma/at_xdmac.c                              |    4=20
 drivers/gpu/drm/radeon/radeon_object.c              |    3=20
 drivers/gpu/drm/radeon/si_dpm.c                     |    4=20
 drivers/hid/hid-core.c                              |   10 -
 drivers/hid/hid-input.c                             |    3=20
 drivers/hid/hid-multitouch.c                        |    5=20
 drivers/hid/hid-rmi.c                               |    4=20
 drivers/hid/hidraw.c                                |    5=20
 drivers/hid/i2c-hid/i2c-hid.c                       |   13 -
 drivers/hwmon/ina2xx.c                              |    3=20
 drivers/infiniband/core/ucma.c                      |    3=20
 drivers/infiniband/ulp/srp/ib_srp.c                 |   18 -
 drivers/iommu/intel-svm.c                           |    1=20
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c       |    4=20
 drivers/mmc/host/jz4740_mmc.c                       |    2=20
 drivers/mtd/ubi/block.c                             |    2=20
 drivers/mtd/ubi/build.c                             |   11 +
 drivers/mtd/ubi/fastmap-wl.c                        |    1=20
 drivers/net/slip/slhc.c                             |    5=20
 drivers/net/usb/cdc_ether.c                         |    6=20
 drivers/net/usb/lan78xx.c                           |    3=20
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c  |    2=20
 drivers/net/xen-netfront.c                          |    7=20
 drivers/pci/hotplug/acpiphp_glue.c                  |   23 +-
 drivers/s390/cio/qdio_main.c                        |   42 ++--
 drivers/thermal/imx_thermal.c                       |    6=20
 drivers/thunderbolt/nhi.c                           |    1=20
 drivers/tty/n_tty.c                                 |    6=20
 drivers/tty/tty_io.c                                |    9=20
 drivers/usb/core/generic.c                          |    9=20
 drivers/usb/dwc3/dwc3-pci.c                         |    2=20
 drivers/usb/musb/musb_gadget_ep0.c                  |   14 -
 drivers/vfio/pci/vfio_pci_config.c                  |  107 ++++++++++-
 drivers/watchdog/f71808e_wdt.c                      |    2=20
 fs/autofs4/root.c                                   |    2=20
 fs/ext4/balloc.c                                    |    3=20
 fs/ext4/ialloc.c                                    |   47 ----
 fs/ext4/inline.c                                    |   66 +++---
 fs/ext4/inode.c                                     |   48 ++---
 fs/ext4/super.c                                     |    6=20
 fs/ext4/xattr.c                                     |   30 +--
 fs/ext4/xattr.h                                     |   32 +++
 fs/fs-writeback.c                                   |    7=20
 fs/jbd2/journal.c                                   |    5=20
 fs/jffs2/super.c                                    |    2=20
 fs/namei.c                                          |    3=20
 fs/namespace.c                                      |    3=20
 fs/notify/fanotify/fanotify.c                       |   34 +--
 fs/reiserfs/journal.c                               |    2=20
 fs/ubifs/super.c                                    |   14 +
 include/linux/backing-dev-defs.h                    |    5=20
 include/linux/backing-dev.h                         |   31 +--
 include/linux/hid.h                                 |    6=20
 include/linux/mm.h                                  |    4=20
 include/linux/tty.h                                 |    1=20
 include/net/slhc_vj.h                               |    1=20
 include/sound/pcm_oss.h                             |    1=20
 ipc/shm.c                                           |   23 ++
 kernel/resource.c                                   |    3=20
 lib/Makefile                                        |    2=20
 lib/hweight.c                                       |    4=20
 mm/filemap.c                                        |   16 -
 mm/memory.c                                         |   17 +
 mm/page-writeback.c                                 |   18 -
 mm/slab.c                                           |    3=20
 net/sunrpc/rpc_pipe.c                               |    1=20
 sound/core/oss/pcm_oss.c                            |  189 +++++++++++++++=
-----
 sound/core/pcm.c                                    |    8=20
 sound/core/rawmidi_compat.c                         |   18 +
 sound/pci/hda/hda_intel.c                           |    3=20
 sound/soc/codecs/ssm2602.c                          |   19 +-
 sound/usb/line6/midi.c                              |    2=20
 tools/perf/tests/code-reading.c                     |   20 --
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c |   64 +++---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.h |    2=20
 tools/perf/util/intel-pt.c                          |   37 +++
 104 files changed, 924 insertions(+), 446 deletions(-)

Aaron Ma (3):
      HID: i2c-hid: fix size check and type usage
      HID: Fix hid_report_len usage
      HID: core: Fix size as type u32

Adrian Hunter (4):
      perf intel-pt: Fix overlap detection to identify consecutive buffers =
correctly
      perf intel-pt: Fix sync_switch
      perf intel-pt: Fix error recovery from missing TIP packet
      perf intel-pt: Fix timestamp following overflow

Al Viro (5):
      getname_kernel() needs to make sure that ->name !=3D ->iname in long =
case
      jffs2_kill_sb(): deal with failed allocations
      hypfs_kill_super(): deal with failed allocations
      rpc_pipefs: fix double-dput()
      Don't leak MNT_INTERNAL away from internal mounts

Alex Smith (1):
      mmc: jz4740: Fix race condition in IRQ mask update

Alex Williamson (3):
      vfio-pci: Virtualize PCIe & AF FLR
      vfio/pci: Virtualize Maximum Payload Size
      vfio/pci: Virtualize Maximum Read Request Size

Amir Goldstein (1):
      fanotify: fix logic of events on child

Andrew Morton (1):
      fs/reiserfs/journal.c: add missing resierfs_warning() arg

Arnd Bergmann (1):
      radeon: hide pointless #warning when compile testing

Bart Van Assche (2):
      IB/srp: Fix srp_abort()
      IB/srp: Fix completion vector assignment algorithm

Bassem Boubaker (1):
      cdc_ether: flag the Cinterion AHS8 modem by gemalto as WWAN

Boris Brezillon (1):
      clk: bcm2835: De-assert/assert PLL reset signal when appropriate

Borislav Petkov (1):
      x86/hweight: Get rid of the special calling convention

Dan Carpenter (1):
      regmap: Fix reversed bounds check in regmap_raw_write()

David Wang (1):
      ALSA: hda - New VIA controller suppor no-snoop path

Eric Biggers (1):
      ipc/shm: fix use-after-free of shm file via remap_file_pages()

Fabi=E1n Inostroza (1):
      ALSA: line6: Use correct endpoint type for midi output

Greg Kroah-Hartman (2):
      Revert "perf tests: Decompress kernel module before objdump"
      Linux 4.4.129

Greg Thelen (1):
      writeback: safer lock nesting

Hans de Goede (1):
      ACPI / video: Add quirk to force acpi-video backlight on Samsung 670Z=
5E

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

Jan Kara (1):
      ext4: fix crashes in dioread_nolock mode

Jason Andryuk (1):
      xen-netfront: Fix hang on device removal

Julian Wiedmann (2):
      s390/qdio: don't retry EQBS after CCQ 96
      s390/qdio: don't merge ERROR output buffers

Krzysztof Mazur (1):
      um: Use POSIX ucontext_t instead of struct ucontext

Lu Baolu (1):
      iommu/vt-d: Fix a potential memory leak

Marek Szyprowski (1):
      hwmon: (ina2xx) Fix access to uninitialized mutex

Matt Redfearn (4):
      MIPS: uaccess: Add micromips clobbers to bzero invocation
      MIPS: memset.S: EVA & fault support for small_memset
      MIPS: memset.S: Fix return of __clear_user from Lpartial_fixup
      MIPS: memset.S: Fix clobber of v1 in last_fixup

Matthew Wilcox (1):
      mm/filemap.c: fix NULL pointer in page_cache_tree_insert()

Mauro Carvalho Chehab (1):
      media: v4l2-compat-ioctl32: don't oops on overlay

Maxime Jayat (1):
      dmaengine: at_xdmac: fix rare residue corruption

Michael Ellerman (1):
      powerpc/lib: Fix off-by-one in alternate feature patching

Michael Neuling (1):
      powerpc/eeh: Fix enabling bridge MMIO windows

Michal Hocko (1):
      mm: allow GFP_{FS,IO} for page_cache_read page cache allocation

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

Phil Elwell (1):
      lan78xx: Correctly indicate invalid OTP

Ralph Sennhauser (1):
      clk: mvebu: armada-38x: add support for 1866MHz variants

Richard Genoud (1):
      clk: mvebu: armada-38x: add support for missing clocks

Richard Weinberger (3):
      ubifs: Check ubifs_wbuf_sync() return code
      ubi: fastmap: Don't flush fastmap work on detach
      ubi: Reject MLC NAND

Rodrigo Rivas Costa (1):
      HID: hidraw: Fix crash on HIDIOCGFEATURE with a destroyed device

Roland Dreier (1):
      RDMA/ucma: Don't allow setting RDMA_OPTION_IB_PATH without an RDMA de=
vice

Romain Izard (1):
      ubi: Fix error for write access

Santiago Esteban (1):
      ARM: dts: at91: sama5d4: fix pinctrl compatible string

Sudhir Sreedharan (1):
      rtl8187: Fix NULL pointer dereference in priv->conf_mutex

Takashi Iwai (8):
      resource: fix integer overflow at reallocation
      ALSA: pcm: Fix UAF at PCM release via PCM timer access
      ALSA: pcm: Use ERESTARTSYS instead of EINTR in OSS emulation
      ALSA: pcm: Avoid potential races between OSS ioctls and read/write
      ALSA: pcm: Return -EBUSY for OSS ioctls changing busy streams
      ALSA: pcm: Fix mutex unbalance in OSS emulation ioctls
      ALSA: pcm: Fix endless loop for XRUN recovery in OSS emulation
      ALSA: rawmidi: Fix missing input substream checks in compat ioctls

Tejaswi Tanikella (1):
      slip: Check if rstate is initialized before uncompressing

Tejun Heo (1):
      tty: make n_tty_read() always abort if hangup is in progress

Tetsuo Handa (1):
      block/loop: fix deadlock after loop_set_status

Theodore Ts'o (6):
      random: use a tighter cap in credit_entropy_bits_safe()
      jbd2: if the journal is aborted then don't allow update of the log ta=
il
      ext4: don't update checksum of new initialized bitmaps
      ext4: fail ext4_iget for root directory if unallocated
      ext4: don't allow r/w mounts if metadata blocks overlap the superblock
      ext4: fix deadlock between inline_data and ext4_expand_extra_isize_ea=
()

Thinh Nguyen (1):
      usb: dwc3: pci: Properly cleanup resource

Vasily Gorbik (1):
      s390/ipl: ensure loadparm valid flag is set

Ville Syrj=E4l=E4 (1):
      x86/hweight: Don't clobber %rdi

Vlastimil Babka (1):
      mm, slab: reschedule cache_reap() on the same CPU

Zhengjun Xing (1):
      USB:fix USB3 devices behind USB3 hubs not resuming at hibernate thaw

wangguang (1):
      ext4: bugfix for mmaped pages in mpage_release_unused_pages()


--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlre9m8ACgkQONu9yGCS
aT4zcQ//V4gchV685KIM5wIzEsEULB5HvNSV1KPt5tbUIo3KJTvzLOyz8B5zuysd
mhc8ku/E1l690eQYTdJZDOUWtQYZ3n28XXoS6v0/F03zA1teoEd3gsaOXKZQEjX2
tQJi0JS9C1ye1N1UGce3QudARjq++/dU8R0Muj1tj8chLSlddiM5Myo3DyK2kIL8
tKl2wZibTc+gXWh7vngRWPgQack0KVxB1DUCuaC7Wqbg+zqyeyqk971OhyNzvLGe
FdZux5iiOtDKyPUdXZ1DFPHnbu0hJV+DQBbaGmApcG/xQTjSATx9KbZmV6cYF5EE
8nDwzYBpaBRdaJjsu7+XTKDrDxQESNQFvJDGlcuDiz8JKnEIpiDjjr2ZgiWLU7t9
sm+JmneBsywF0LMEqOv6+NypuekJdOl37yY2OEjpcfAkYJ97bqc8lCTMifwzG9h2
Kk8bvgZ39WOh8wVetQxXTS+ZtTDEx3nK0i+46jJEQQxzm3dLK2JBu5RItbWtQquw
xXPBIbQgWLmhWCi6F68IWjbK+Yev/GeGBIT0JrxyZTxiT2XlCeM223T4FZ78KaJd
/Dc7dfRr6ocGO79HAHMDRF7TjhP6x+NZrux1FJhyxRAtRwBifDcKGazC2AuGKmr8
t8Fk2LyvssuHRvVrqyb8t/YOSRB41GBy2Obw5EZWIFqWk7m8Txs=
=dc8Y
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
