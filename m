Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeFEJ4a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:56:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751488AbeFEJ42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:56:28 -0400
Date: Tue, 5 Jun 2018 11:56:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.48
Message-ID: <20180605095605.GA8802@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.48 kernel.

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

 Makefile                                                    |   10=20
 arch/mips/kernel/process.c                                  |    4=20
 arch/mips/kernel/ptrace.c                                   |    2=20
 arch/mips/kernel/ptrace32.c                                 |    2=20
 arch/powerpc/include/asm/book3s/64/slice.h                  |   27 +
 arch/powerpc/include/asm/mmu-8xx.h                          |    6=20
 arch/powerpc/include/asm/nohash/32/slice.h                  |   18 +
 arch/powerpc/include/asm/nohash/64/slice.h                  |   12=20
 arch/powerpc/include/asm/page.h                             |    1=20
 arch/powerpc/include/asm/page_64.h                          |   59 ----
 arch/powerpc/include/asm/slice.h                            |   42 +++
 arch/powerpc/kernel/setup-common.c                          |    2=20
 arch/powerpc/mm/8xx_mmu.c                                   |    2=20
 arch/powerpc/mm/hugetlbpage.c                               |    2=20
 arch/powerpc/mm/mmu_context_nohash.c                        |   18 +
 arch/powerpc/mm/slice.c                                     |   49 ++-
 arch/powerpc/platforms/Kconfig.cputype                      |    1=20
 arch/x86/kernel/cpu/mcheck/mce_amd.c                        |   72 ++---
 drivers/dma-buf/dma-buf.c                                   |    2=20
 drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c   |    8=20
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c |    2=20
 drivers/gpu/drm/drm_dp_helper.c                             |    1=20
 drivers/gpu/drm/i915/i915_gem.c                             |   27 -
 drivers/gpu/drm/i915/intel_lvds.c                           |   51 ++-
 drivers/hwtracing/intel_th/msu.c                            |    6=20
 drivers/hwtracing/stm/core.c                                |    7=20
 drivers/iio/adc/Kconfig                                     |    1=20
 drivers/iio/adc/ad7793.c                                    |   75 +----
 drivers/iio/buffer/industrialio-buffer-dma.c                |    2=20
 drivers/iio/buffer/kfifo_buf.c                              |   11=20
 drivers/infiniband/core/cache.c                             |    2=20
 drivers/input/mouse/elan_i2c_smbus.c                        |   22 -
 drivers/input/mouse/synaptics.c                             |    6=20
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.c            |    7=20
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rf.c         |    3=20
 drivers/pci/host/pci-hyperv.c                               |   58 ++++
 drivers/pinctrl/qcom/pinctrl-msm.c                          |    2=20
 drivers/platform/chrome/cros_ec_lpc.c                       |    3=20
 drivers/scsi/scsi_transport_srp.c                           |   22 +
 drivers/soc/lantiq/gphy.c                                   |   36 --
 fs/aio.c                                                    |    3=20
 fs/xfs/libxfs/xfs_alloc.c                                   |  125 ++++++++
 fs/xfs/libxfs/xfs_alloc.h                                   |    2=20
 fs/xfs/libxfs/xfs_format.h                                  |   13=20
 fs/xfs/xfs_fsops.c                                          |    2=20
 fs/xfs/xfs_mount.h                                          |    1=20
 fs/xfs/xfs_trace.h                                          |    9=20
 include/linux/iio/buffer_impl.h                             |    6=20
 include/linux/tcp.h                                         |    2=20
 include/uapi/linux/nl80211.h                                |    2=20
 kernel/trace/trace.c                                        |   12=20
 kernel/trace/trace.h                                        |   11=20
 kernel/trace/trace_events_trigger.c                         |   15 -
 mm/huge_memory.c                                            |    2=20
 mm/vmscan.c                                                 |    2=20
 net/ipv4/tcp_input.c                                        |   10=20
 security/selinux/ss/services.c                              |    2=20
 sound/soc/intel/common/sst-firmware.c                       |    2=20
 tools/objtool/check.c                                       |  167 ++++++-=
-----
 tools/objtool/elf.c                                         |   42 ++-
 tools/objtool/elf.h                                         |    2=20
 61 files changed, 714 insertions(+), 401 deletions(-)

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

Chris Wilson (2):
      drm/i915: Always sanity check engine state upon idling
      drm/i915/lvds: Move acpi lid notification registration to registratio=
n phase

Christophe Leroy (4):
      powerpc/mm/slice: Remove intermediate bitmap copy
      powerpc/mm/slice: create header files dedicated to slices
      powerpc/mm/slice: Enhance for supporting PPC32
      powerpc/mm/slice: Fix hugepage allocation at hint address on 8xx

Colin Ian King (3):
      dma-buf: remove redundant initialization of sg_table
      ASoC: Intel: sst: remove redundant variable dma_dev_name
      platform/chrome: cros_ec_lpc: remove redundant pointer request

Dave Chinner (1):
      xfs: convert XFS_AGFL_SIZE to a helper function

Dexuan Cui (1):
      PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()

Dhinakaran Pandiyan (1):
      drm/psr: Fix missed entry in PSR setup time table.

Dmitry Torokhov (1):
      Input: synaptics - Lenovo Carbon X1 Gen5 (2017) devices should use RMI

Edvard Holst (1):
      Input: synaptics - Lenovo Thinkpad X1 Carbon G5 (2017) with Elantech =
trackpoints should use RMI

Eric Biggers (1):
      cfg80211: further limit wiphy names to 64 bytes

Eric Dumazet (1):
      tcp: avoid integer overflows in tcp_rcv_space_adjust()

Eugen Hristev (1):
      iio: adc: select buffer for at91-sama5d2_adc

Greg Kroah-Hartman (3):
      Revert "pinctrl: msm: Use dynamic GPIO numbering"
      hwtracing: stm: fix build error on some arches
      Linux 4.14.48

Hugh Dickins (2):
      mm: fix the NULL mapping case in __isolate_lru_page()
      mm/huge_memory.c: __split_huge_page() use atomic ClearPageDirty()

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

Michael Nosthoff (1):
      iio: ad7793: implement IIO_CHAN_INFO_SAMP_FREQ

Nick Desaulniers (1):
      kbuild: clang: remove crufty HOSTCFLAGS

Ondrej Zary (1):
      drm/i915: Disable LVDS on Radiant P845

Parav Pandit (1):
      IB/core: Fix error code for invalid GID entry

Sachin Grover (1):
      selinux: KASAN: slab-out-of-bounds in xattr_getsecurity

Sodagudi Prasad (1):
      kbuild: clang: disable unused variable warnings only when constant

Stanislaw Gruszka (1):
      Revert "rt2800: use TXOP_BACKOFF for probe frames"

Steven Rostedt (VMware) (2):
      tracing: Fix crash when freeing instances with event triggers
      tracing: Make the snapshot trigger work with instances

Yazen Ghannam (1):
      x86/mce/AMD: Carve out SMCA get_block_address() code


--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsWXjQACgkQONu9yGCS
aT55Kw/9GUMGh4qcY9P7mbfNmDbGnyKJjffm6W3okQ36VyQB7STilctViG8qrkk8
ZdCFvqypC9EhtEgxAi41vp3h8M8etcS4otRV6l+5DH8N/WMYekQLk33SapWQR2XI
56XWTVlizGbHB8k8lmB7D3JPJ9oxzTomJAbxxBeYBaxnRPILZCs3Dag4ZXa2H6Yz
OLsIbFxQD/FHFjzLJFne2+TY+tm2KD6En6pBagxuMAq5JJIecnkEDI4i9ijG/oWm
TGq6xjew14O4LqNm5ye0hH4y9kTr36hIvQQKqWRSlZmJtRG9JgkLX/GAsY9UcHzJ
25T8LApfX/kOPFqnAelvJeUR1qwNZlUpwNG2yD7cc4vN2R9z8zf8EJ6P1bhYW5yH
1ro8I7yzB6xlqnvs4H/QalpMcSH1Dfhpm5vMdgEPAYnKbcPTcct7AsUPHK0Ew0xw
kpmrKnNSgWhad2iV9ttifjjZimrFe3S+oX5zCcHPD6ujvmZQJIHzf3WSAqM9EQ4c
Xp/fvOlphEV6qBQZbnldXbLjLcWJLb2JTrR6JhjSI3tz8ESQrbm1e9ot7R8WZbX9
/21Zjs6jPRwi8kOmNbQatEEJnB90RYGZKb0VEt5ukhbjQcWqqvbFEtk7173UeUnG
fDYj1/BRwYWC7uQkXs3/5m1WCWCStXZYw21VpAh5YAIsCceQZY4=
=88bX
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
