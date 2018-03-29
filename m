Date: Thu, 29 Mar 2018 09:26:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.125
Message-ID: <20180329072652.GA2935@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.125 kernel.

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

 Makefile                                            |   11 ++
 arch/arm64/mm/mmu.c                                 |   12 ++
 arch/mips/ralink/reset.c                            |    7 -
 arch/x86/Makefile                                   |    9 +
 arch/x86/boot/compressed/misc.c                     |    4=20
 arch/x86/entry/entry_64.S                           |    2=20
 arch/x86/include/asm/vmx.h                          |    1=20
 arch/x86/kernel/cpu/perf_event_intel.c              |    2=20
 arch/x86/kernel/traps.c                             |   24 ++--
 arch/x86/kvm/vmx.c                                  |    9 +
 arch/x86/mm/pgtable.c                               |   48 +++++++++
 arch/x86/net/bpf_jit_comp.c                         |    3=20
 drivers/acpi/numa.c                                 |   10 +-
 drivers/ata/ahci.c                                  |    4=20
 drivers/ata/libata-core.c                           |   26 ++++-
 drivers/ata/libata-scsi.c                           |    4=20
 drivers/bluetooth/btusb.c                           |    2=20
 drivers/clk/bcm/clk-bcm2835.c                       |    4=20
 drivers/gpu/drm/radeon/radeon_connectors.c          |   31 ++----
 drivers/gpu/drm/udl/udl_fb.c                        |    9 +
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                 |   28 +++--
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                 |   12 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c                |    5 -
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c                |    5 -
 drivers/iio/accel/st_accel_core.c                   |    2=20
 drivers/iio/pressure/st_pressure_core.c             |    2=20
 drivers/mmc/host/dw_mmc.c                           |    6 -
 drivers/mtd/nand/fsl_ifc_nand.c                     |    5 -
 drivers/net/can/cc770/cc770.c                       |  100 ++++++++++++---=
-----
 drivers/net/can/cc770/cc770.h                       |    2=20
 drivers/net/wireless/brcm80211/brcmfmac/p2p.c       |   24 ++--
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c |    3=20
 drivers/pci/quirks.c                                |    2=20
 drivers/staging/lustre/lustre/ptlrpc/sec.c          |    2=20
 drivers/tty/vt/vt.c                                 |    8 -
 fs/ncpfs/ncplib_kernel.c                            |    4=20
 include/asm-generic/pgtable.h                       |   10 ++
 include/uapi/linux/usb/audio.h                      |    4=20
 kernel/bpf/syscall.c                                |    2=20
 kernel/trace/trace_kprobe.c                         |    4=20
 kernel/trace/trace_probe.c                          |    8 -
 kernel/trace/trace_probe.h                          |    2=20
 lib/ioremap.c                                       |    6 -
 sound/drivers/aloop.c                               |   17 +++
 sound/pci/hda/patch_realtek.c                       |    6 +
 45 files changed, 339 insertions(+), 152 deletions(-)

Andri Yngvason (3):
      can: cc770: Fix stalls on rt-linux, remove redundant IRQ ack
      can: cc770: Fix queue stall & dropped RTR reply
      can: cc770: Fix use after free in cc770_tx_interrupt()

Andy Lutomirski (1):
      x86/entry/64: Don't use IST entry for #BP stack

Arend Van Spriel (1):
      brcmfmac: fix P2P_DEVICE ethernet address generation

Boris Brezillon (1):
      clk: bcm2835: Protect sections updating shared registers

Chenbo Feng (1):
      bpf: skip unnecessary capability check

Dan Carpenter (2):
      staging: ncpfs: memory corruption in ncp_read_kernel()
      perf/x86/intel: Don't accidentally clear high bits in bdw_limit_perio=
d()

Dan Williams (1):
      acpi, numa: fix pxm to online numa node associations

Daniel Borkmann (2):
      kbuild: disable clang's default use of -fmerge-all-constants
      bpf, x64: increase number of passes

Eric Biggers (2):
      libata: fix length validation of ATAPI-relayed SCSI commands
      libata: remove WARN() for DMA or PIO command without data

Evgeniy Didin (1):
      mmc: dw_mmc: fix falling from idmac to PIO mode when dw_mci_reset occ=
urs

Greg Kroah-Hartman (2):
      drm: udl: Properly check framebuffer mmap offsets
      Linux 4.4.125

H.J. Lu (2):
      x86/build/64: Force the linker to use 2MB page size
      x86/boot/64: Verify alignment of the LOAD segment

Hans de Goede (6):
      PCI: Add function 1 DMA alias quirk for Highpoint RocketRAID 644L
      ahci: Add PCI-id for the Highpoint Rocketraid 644L card
      libata: Apply NOLPM quirk to Crucial MX100 512GB SSDs
      libata: Apply NOLPM quirk to Crucial M500 480 and 960GB SSDs
      libata: Make Crucial BX100 500GB LPM quirk apply to all firmware vers=
ions
      libata: Modify quirks for MX100 to limit NCQ_TRIM quirk to MU01 versi=
on

Jagdish Gediya (1):
      mtd: nand: fsl_ifc: Fix nand waitfunc return value

Ju Hyung Park (1):
      libata: Enable queued TRIM for Samsung SSD 860

Kai-Heng Feng (1):
      libata: disable LPM for Crucial BX100 SSD 500GB drive

Kirill Marinushkin (1):
      ALSA: usb-audio: Fix parsing descriptor of UAC2 processing unit

Larry Finger (1):
      rtlwifi: rtl8723be: Fix loss of signal

Linus Torvalds (2):
      tty: vt: fix up tabstops properly
      kvm/x86: fix icebp instruction handling

Masami Hiramatsu (1):
      tracing: probeevent: Fix to support minus offset from symbol

Michael Nosthoff (1):
      iio: st_pressure: st_accel: pass correct platform data to init

Michel D=E4nzer (1):
      drm/radeon: Don't turn off DP sink when disconnected

Nadav Amit (1):
      staging: lustre: ptlrpc: kfree used instead of kvfree

NeilBrown (1):
      MIPS: ralink: Remove ralink_halt()

Takashi Iwai (4):
      ALSA: aloop: Sync stale timer before release
      ALSA: aloop: Fix access to not-yet-ready substream via cable
      ALSA: hda/realtek - Always immediately update mute LED with pin VREF
      Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174

Thomas Hellstrom (1):
      drm/vmwgfx: Fix a destoy-while-held mutex problem.

Toshi Kani (2):
      mm/vmalloc: add interfaces to free unmapped page table
      x86/mm: implement free pmd/pte page interfaces


--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlq8lTsACgkQONu9yGCS
aT5g9Q//Ro/d6s8F2yNGkPVwXY0bmI3RWGiNouafGXOgcd0pTUFo268/neB683NX
ggTNX5bv1xrCztm7z7qWVAwLniUMN0gPjK4Nw6kIGbqSOnc0zIlBul7IVfc4qHes
hBBmJ+N3TdXIXrT86lp5kmjPxHqgm73xoego12punOcXjcMI3s/33Ke+LchYgHmQ
IfjP2kZljB1YHAOHjGwqikWC1dlpszJmTJyyj3zaOkS/YRzrbLopJTZTBSB0ObHG
BkvaT8XsrCRBGTALXyXp8gN2EJniNpG/tMp1SPvsdaD6Z1gbyS0JBkhUS9Pyezhx
1ALJnbq+vR2k3QnyRlp9szCtzaX5lG+rrcgG9VNyedWmbGBRG4sRpjDZ8vpj+PaH
UtA4Z9TV2em2INJqykIMhFhFela9xu+Oj+Fg9f1//jqO0u3a4TKH5qMKkDluePU7
IM8dHKJZY+O80ZDN5LkGRMcXSayFcZG6ig3UCmg+G/rJ9axVdRoeZL+g1yTUMmmX
WrfZvKvh6w1b2j0qC5F1wcaEQp9OXvMvhVg0OBKzYfcVNei1go8Av/tGyNL8adZz
cMrScFghfAQNfLRSt6ixDxTubap9GqlgMK0EKkDnX945wRb2Vh6d5P9S1cHHzogD
5I3m+6kwQXk7+j7q85nm4ryUqLsxky7YjHWuhw6z6hlELnZxpUE=
=0eRM
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
