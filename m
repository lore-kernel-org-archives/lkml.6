Date: Thu, 29 Mar 2018 09:26:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.91
Message-ID: <20180329072630.GA2832@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.91 kernel.

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

 Documentation/ABI/testing/sysfs-bus-iio                |    2=20
 Makefile                                               |   11 +
 arch/arm64/mm/mmu.c                                    |   10 +
 arch/mips/ralink/reset.c                               |    7 -
 arch/x86/Makefile                                      |    9 +
 arch/x86/boot/compressed/misc.c                        |    4=20
 arch/x86/entry/entry_64.S                              |    2=20
 arch/x86/events/intel/core.c                           |    2=20
 arch/x86/events/intel/uncore_snbep.c                   |   33 +++--
 arch/x86/include/asm/vmx.h                             |    1=20
 arch/x86/kernel/traps.c                                |   24 +---
 arch/x86/kvm/vmx.c                                     |    9 +
 arch/x86/mm/pgtable.c                                  |   48 ++++++++
 arch/x86/net/bpf_jit_comp.c                            |    3=20
 drivers/acpi/acpi_watchdog.c                           |    4=20
 drivers/acpi/numa.c                                    |   10 +
 drivers/ata/ahci.c                                     |    4=20
 drivers/ata/libata-core.c                              |   26 +++-
 drivers/ata/libata-scsi.c                              |   10 +
 drivers/bluetooth/btusb.c                              |    2=20
 drivers/clk/bcm/clk-bcm2835.c                          |   12 +-
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c                   |    6 -
 drivers/gpu/drm/radeon/radeon_connectors.c             |   31 ++---
 drivers/gpu/drm/udl/udl_fb.c                           |    9 +
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                    |   28 +++-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                    |   12 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c                   |    5=20
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c                   |    5=20
 drivers/iio/accel/st_accel_core.c                      |    2=20
 drivers/iio/pressure/st_pressure_core.c                |    2=20
 drivers/mmc/host/dw_mmc.c                              |    6 -
 drivers/mtd/mtdchar.c                                  |    4=20
 drivers/mtd/nand/fsl_ifc_nand.c                        |   32 ++---
 drivers/net/can/cc770/cc770.c                          |  100 ++++++++++--=
-----
 drivers/net/can/cc770/cc770.h                          |    2=20
 drivers/net/can/ifi_canfd/ifi_canfd.c                  |   75 +++++++-----
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c |   24 +---
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c    |    3=20
 drivers/nvdimm/blk.c                                   |    3=20
 drivers/nvdimm/btt.c                                   |    3=20
 drivers/pci/quirks.c                                   |    2=20
 drivers/staging/lustre/lustre/ptlrpc/sec.c             |    2=20
 drivers/tty/vt/vt.c                                    |    8 -
 drivers/watchdog/wdat_wdt.c                            |    2=20
 fs/ncpfs/ncplib_kernel.c                               |    4=20
 fs/nfsd/nfs4state.c                                    |   62 +++++++---
 include/asm-generic/pgtable.h                          |   10 +
 include/linux/fsl_ifc.h                                |    6 -
 include/uapi/linux/usb/audio.h                         |    4=20
 kernel/bpf/syscall.c                                   |    2=20
 kernel/trace/trace_kprobe.c                            |    4=20
 kernel/trace/trace_probe.c                             |    8 -
 kernel/trace/trace_probe.h                             |    2=20
 lib/ioremap.c                                          |    6 -
 mm/huge_memory.c                                       |    4=20
 mm/khugepaged.c                                        |    7 +
 mm/shmem.c                                             |   31 +++--
 sound/drivers/aloop.c                                  |   17 ++
 sound/pci/hda/patch_realtek.c                          |    6 -
 tools/perf/builtin-stat.c                              |    2=20
 tools/testing/selftests/x86/Makefile                   |    2=20
 tools/testing/selftests/x86/mpx-mini-test.c            |    3=20
 tools/testing/selftests/x86/protection_keys.c          |   49 +++++---
 tools/testing/selftests/x86/ptrace_syscall.c           |    8 +
 64 files changed, 545 insertions(+), 291 deletions(-)

Andri Yngvason (3):
      can: cc770: Fix stalls on rt-linux, remove redundant IRQ ack
      can: cc770: Fix queue stall & dropped RTR reply
      can: cc770: Fix use after free in cc770_tx_interrupt()

Andy Lutomirski (3):
      selftests/x86/ptrace_syscall: Fix for yet more glibc interference
      x86/entry/64: Don't use IST entry for #BP stack
      selftests/x86/protection_keys: Fix syscall NR redefinition warnings

Arend Van Spriel (1):
      brcmfmac: fix P2P_DEVICE ethernet address generation

Boris Brezillon (2):
      clk: bcm2835: Fix ana->maskX definitions
      clk: bcm2835: Protect sections updating shared registers

Chen-Yu Tsai (1):
      clk: sunxi-ng: a31: Fix CLK_OUT_* clock ops

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

Dave Hansen (2):
      selftests, x86, protection_keys: fix wrong offset in siginfo
      x86/pkeys/selftests: Rename 'si_pkey' to 'siginfo_pkey'

Eric Biggers (3):
      libata: fix length validation of ATAPI-relayed SCSI commands
      libata: remove WARN() for DMA or PIO command without data
      libata: don't try to pass through NCQ commands to non-NCQ devices

Eric W. Biederman (1):
      signal/testing: Don't look for __SI_FAULT in userspace

Evgeniy Didin (1):
      mmc: dw_mmc: fix falling from idmac to PIO mode when dw_mci_reset occ=
urs

Greg Kroah-Hartman (2):
      drm: udl: Properly check framebuffer mmap offsets
      Linux 4.9.91

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

Ilya Pronin (1):
      perf stat: Fix CVS output format for non-supported counters

Jagdish Gediya (3):
      mtd: nand: fsl_ifc: Fix nand waitfunc return value
      mtd: nand: fsl_ifc: Fix eccstat array overflow for IFC ver >=3D 2.0.0
      mtd: nand: fsl_ifc: Read ECCSTAT0 and ECCSTAT1 registers for IFC 2.0

Jeff Layton (1):
      nfsd: remove blocked locks on client teardown

Ju Hyung Park (1):
      libata: Enable queued TRIM for Samsung SSD 860

Kai-Heng Feng (1):
      libata: disable LPM for Crucial BX100 SSD 500GB drive

Kan Liang (2):
      perf/x86/intel/uncore: Fix Skylake UPI event format
      perf/x86/intel/uncore: Fix multi-domain PCI CHA enumeration bug on Sk=
ylake servers

Kirill A. Shutemov (3):
      mm/khugepaged.c: convert VM_BUG_ON() to collapse fail
      mm/thp: do not wait for lock_page() in deferred_split_scan()
      mm/shmem: do not wait for lock_page() in shmem_unused_huge_shrink()

Kirill Marinushkin (1):
      ALSA: usb-audio: Fix parsing descriptor of UAC2 processing unit

Larry Finger (1):
      rtlwifi: rtl8723be: Fix loss of signal

Linus Torvalds (2):
      tty: vt: fix up tabstops properly
      kvm/x86: fix icebp instruction handling

Linus Walleij (1):
      iio: ABI: Fix name of timestamp sysfs file

Marek Vasut (2):
      can: ifi: Repair the error handling
      can: ifi: Check core revision upon probe

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

OuYang ZhiZhong (1):
      mtdchar: fix usage of mtd_ooblayout_ecc()

Shuah Khan (1):
      selftests: x86: sysret_ss_attrs doesn't build on a PIE build

Takashi Iwai (5):
      ALSA: aloop: Sync stale timer before release
      ALSA: aloop: Fix access to not-yet-ready substream via cable
      ALSA: hda/realtek - Always immediately update mute LED with pin VREF
      Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174
      ACPI / watchdog: Fix off-by-one error at resource assignment

Thomas Hellstrom (1):
      drm/vmwgfx: Fix a destoy-while-held mutex problem.

Toshi Kani (2):
      mm/vmalloc: add interfaces to free unmapped page table
      x86/mm: implement free pmd/pte page interfaces

Vishal Verma (1):
      libnvdimm, {btt, blk}: do integrity setup before add_disk()


--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlq8lSUACgkQONu9yGCS
aT6lXA//dlXSKnIdJM71nFHOjKwrNY5wFHumOI62px2UVmpUc8w6xLBwEuekT7kE
nS4jI/WVTshd7KIbC8rUgYNbnZWFDLIUSlJwdkGkCOssBX/GY3u4oKzdN81FfKu7
8fdAaxv7rWzydiO7G2OAU4+JZ5rwTiIi6UinIOx6nITbMgNBZGZ8Nchklz2cmajf
8fEREgQ6LXSDeuLTSob8qvL30c/wempVnsI1T86ZUnvGrxMNW039jAdA7GuOoP2F
6VZgVVSgjtIolBw2kTiHR97Y/mAPoXq2kADi1KaQCcryQVYZD6+OGMFBJ6/8D0TS
eKxKr5Ha/MIK3XWix+N6e7cE+YDH79Fhp8Ci/doN08MJaznzW/4C810E/fejdyZh
Ys11xhfeQ7IregY8Onc08McCU3f8GtTcIkh+rA36wKGXWeMnfrXdOth3ZTqkine8
b66zbM57XIJk/i3sT+zUNx+yh/bj9VmpiDNsmq1sjqegaUNyRTtofuCaZoh/DhYO
jcUVo3Zy0CQNNWnc00cw3Jm3IHrE+YChzpjobxK29XM7zQRU3Me+z/m+r+7m3BY3
/PTf+YD+CTehlbuGesujRebfqV3FzuX2QO9gNbikdLnPTHnogqpn4A9ZYZAEia2+
Fu9/eNZGRnLK3Umg6SDuwux5H6RXH57A4EnQDt2+Hgd+0N+We0A=
=ay4z
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
