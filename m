Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeFEJ4z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:56:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751772AbeFEJ4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:56:53 -0400
Date: Tue, 5 Jun 2018 11:56:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.16.14
Message-ID: <20180605095630.GA8877@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.16.14 kernel.

All users of the 4.16 kernel series must upgrade.

The updated 4.16.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.16.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                    |    2=20
 arch/mips/kernel/process.c                                  |    4=20
 arch/mips/kernel/ptrace.c                                   |    2=20
 arch/mips/kernel/ptrace32.c                                 |    2=20
 arch/x86/kernel/cpu/mcheck/mce_amd.c                        |   72 ++---
 drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c   |    8=20
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c |    2=20
 drivers/gpu/drm/drm_dp_helper.c                             |    1=20
 drivers/gpu/drm/i915/intel_lvds.c                           |   51 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c                         |   59 ++--
 drivers/hwtracing/intel_th/msu.c                            |    6=20
 drivers/hwtracing/stm/core.c                                |    7=20
 drivers/iio/adc/Kconfig                                     |    1=20
 drivers/iio/adc/ad7793.c                                    |   75 +----
 drivers/iio/adc/at91-sama5d2_adc.c                          |   41 ++
 drivers/iio/adc/stm32-dfsdm-adc.c                           |   17 +
 drivers/iio/buffer/industrialio-buffer-dma.c                |    2=20
 drivers/iio/buffer/kfifo_buf.c                              |   11=20
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c         |    8=20
 drivers/infiniband/core/cache.c                             |    2=20
 drivers/input/mouse/elan_i2c_smbus.c                        |   22 -
 drivers/input/mouse/synaptics.c                             |    6=20
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.c            |    7=20
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rf.c         |    3=20
 drivers/nvme/host/core.c                                    |    2=20
 drivers/pinctrl/qcom/pinctrl-msm.c                          |    2=20
 drivers/scsi/scsi_transport_srp.c                           |   22 +
 drivers/soc/lantiq/gphy.c                                   |   36 --
 fs/aio.c                                                    |    3=20
 fs/xfs/libxfs/xfs_alloc.c                                   |  125 ++++++++
 fs/xfs/libxfs/xfs_alloc.h                                   |    2=20
 fs/xfs/libxfs/xfs_format.h                                  |   13=20
 fs/xfs/scrub/agheader.c                                     |    6=20
 fs/xfs/xfs_fsops.c                                          |    2=20
 fs/xfs/xfs_mount.h                                          |    1=20
 fs/xfs/xfs_trace.h                                          |    9=20
 include/linux/iio/buffer_impl.h                             |    6=20
 include/uapi/linux/nl80211.h                                |    2=20
 kernel/trace/trace.c                                        |   12=20
 kernel/trace/trace.h                                        |   11=20
 kernel/trace/trace_events_trigger.c                         |   15 -
 mm/huge_memory.c                                            |    2=20
 mm/vmscan.c                                                 |    2=20
 security/selinux/ss/services.c                              |    2=20
 tools/objtool/check.c                                       |  167 ++++++-=
-----
 tools/objtool/elf.c                                         |   42 ++-
 tools/objtool/elf.h                                         |    2=20
 47 files changed, 571 insertions(+), 326 deletions(-)

Aaron Ma (1):
      Input: synaptics - add Intertouch support on X1 Carbon 6th and X280

Al Viro (1):
      fix io_destroy()/aio_complete() race

Alexander Shishkin (2):
      stm class: Use vmalloc for the master map
      intel_th: Use correct device when freeing buffers

Bart Van Assche (1):
      scsi: scsi_transport_srp: Fix shost to rport translation

Benjamin Tissoires (2):
      Input: synaptics - add Lenovo 80 series ids to SMBus
      Input: elan_i2c_smbus - fix corrupted stack

Borislav Petkov (1):
      x86/MCE/AMD: Cache SMCA MISC block addresses

Brian Foster (1):
      xfs: detect agfl count corruption and reset agfl

Chris Wilson (1):
      drm/i915/lvds: Move acpi lid notification registration to registratio=
n phase

Dave Chinner (1):
      xfs: convert XFS_AGFL_SIZE to a helper function

Dhinakaran Pandiyan (1):
      drm/psr: Fix missed entry in PSR setup time table.

Dmitry Torokhov (1):
      Input: synaptics - Lenovo Carbon X1 Gen5 (2017) devices should use RMI

Edvard Holst (1):
      Input: synaptics - Lenovo Thinkpad X1 Carbon G5 (2017) with Elantech =
trackpoints should use RMI

Eric Biggers (1):
      cfg80211: further limit wiphy names to 64 bytes

Eugen Hristev (2):
      iio: adc: at91-sama5d2_adc: fix channel configuration for differentia=
l channels
      iio: adc: select buffer for at91-sama5d2_adc

Fabrice Gasnier (2):
      iio: adc: stm32-dfsdm: fix successive oversampling settings
      iio: adc: stm32-dfsdm: fix sample rate for div2 spi clock

Greg Kroah-Hartman (3):
      Revert "pinctrl: msm: Use dynamic GPIO numbering"
      hwtracing: stm: fix build error on some arches
      Linux 4.16.14

Hans de Goede (1):
      iio: hid-sensor-trigger: Fix sometimes not powering up the sensor aft=
er resume

Himanshu Jha (1):
      drm/vmwgfx: Use kasprintf

Hugh Dickins (2):
      mm/huge_memory.c: __split_huge_page() use atomic ClearPageDirty()
      mm: fix the NULL mapping case in __isolate_lru_page()

Josh Poimboeuf (5):
      objtool: Support GCC 8's cold subfunctions
      objtool: Support GCC 8 switch tables
      objtool: Detect RIP-relative switch table references
      objtool: Detect RIP-relative switch table references, part 2
      objtool: Fix "noreturn" detection for recursive sibling calls

Maciej W. Rozycki (2):
      MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit FGRs
      MIPS: prctl: Disallow FRE without FR with PR_SET_FP_MODE requests

Martin Kelly (2):
      iio:buffer: make length types match kfifo types
      iio:kfifo_buf: check for uint overflow

Mathias Kresin (1):
      MIPS: lantiq: gphy: Drop reboot/remove reset asserts

Matthias Kaehlcke (2):
      drm/amd/powerplay: Fix enum mismatch
      rtlwifi: rtl8192cu: Remove variable self-assignment in rf.c

Max Gurtovoy (1):
      nvme: fix extended data LBA supported setting

Michael Nosthoff (1):
      iio: ad7793: implement IIO_CHAN_INFO_SAMP_FREQ

Ondrej Zary (1):
      drm/i915: Disable LVDS on Radiant P845

Parav Pandit (1):
      IB/core: Fix error code for invalid GID entry

Sachin Grover (1):
      selinux: KASAN: slab-out-of-bounds in xattr_getsecurity

Stanislaw Gruszka (1):
      Revert "rt2800: use TXOP_BACKOFF for probe frames"

Steven Rostedt (VMware) (2):
      tracing: Fix crash when freeing instances with event triggers
      tracing: Make the snapshot trigger work with instances

Thomas Hellstrom (1):
      drm/vmwgfx: Fix host logging / guestinfo reading error paths

Yazen Ghannam (1):
      x86/mce/AMD: Carve out SMCA get_block_address() code


--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsWXk0ACgkQONu9yGCS
aT7JOQ//WvAytf5zpkSkr8zwWoocS7PWIYbz2jvrVe3Cnt3XOYHr0BjuwrPI8Fih
Yw15857sNZGGY4GJwlcgqR0vpFFFrBSeW4P3nSR5mvKKVL8r8lnVBi+e2OXAX+yh
Kwc+IFyFSC68cM42l0f7/W3BVUfGumOk+ekhI04umzSJjrAhRgUUqdvfYVArtnSR
EXSr1ve5C/Wip7L3S7OPLFBtfZv+5KLPYXgKYGTWZs8VTs4c8eKXtIKWVBZBh1sd
XM0gVF0bHmSMjpl7C2OSnDIP57YJubcfceP5KPmYspltr9c4XC2qG9VJpYrz/X6o
fI+ypcQANnvfk3HfpW9EFLMubZGVFXLIES3EEjrRDgkcumgA2GA7Dq4aebCYZTZs
JmfSmr6MFIiu7m6LiUyrQ7PAcBFriqBqYSPMGN6nOdAkCt3Vboz97bImbD5VF1lV
aM6mutZtEop6Qv8k+rGwPGNy0PYi1c0LcYyBWC4pZRjVpZEik1abUajk9QrUnKFJ
2b/8QfC+BAFDU11NuNicJ1wAgJE5BCZzYF0/C1GnZ/Ql4BI/SjSeYYIHxv7Od8vE
PhPrGcKDCXecu9DLf0doU0T/pY0DspwIjMy5B6iE7OnRKdzXsckRo/fUy+oiI+Xn
Pstrcm6Mry5TNlIhCrNQfGWgpH0cC4Y0PYrx4kb0+CGRV1EfUns=
=Dg+v
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
