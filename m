Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42366C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C1E206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C1E206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeIJMF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:05:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59512 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeIJMF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:05:26 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 23D4DCA8;
        Mon, 10 Sep 2018 07:12:49 +0000 (UTC)
Date:   Mon, 10 Sep 2018 09:12:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.126
Message-ID: <20180910071247.GA21489@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.126 kernel.

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

 Makefile                                        |    2=20
 arch/alpha/kernel/osf_sys.c                     |   64 +++++++---------
 arch/arm/boot/dts/tegra30-cardhu.dtsi           |    1=20
 arch/powerpc/include/asm/fadump.h               |    3=20
 arch/powerpc/kernel/fadump.c                    |   92 +++++++++++++++++++=
----
 arch/powerpc/platforms/powernv/pci-ioda.c       |   37 +++++++++
 arch/powerpc/platforms/pseries/ras.c            |    2=20
 arch/sparc/kernel/sys_sparc_32.c                |   22 +++--
 arch/sparc/kernel/sys_sparc_64.c                |   20 +++--
 arch/x86/kernel/kexec-bzimage64.c               |    2=20
 arch/x86/kvm/vmx.c                              |   26 ++++--
 arch/xtensa/include/asm/cacheasm.h              |   69 ++++++++++-------
 certs/system_keyring.c                          |    3=20
 crypto/asymmetric_keys/pkcs7_key_type.c         |    2=20
 drivers/crypto/caam/jr.c                        |    3=20
 drivers/crypto/vmx/aes_cbc.c                    |   30 +++----
 drivers/crypto/vmx/aes_xts.c                    |   21 +++--
 drivers/gpu/drm/i915/i915_gem_userptr.c         |    3=20
 drivers/iio/frequency/ad9523.c                  |    4 -
 drivers/infiniband/sw/rxe/rxe_comp.c            |    1=20
 drivers/infiniband/ulp/srpt/ib_srpt.c           |    3=20
 drivers/iommu/dmar.c                            |    6 -
 drivers/iommu/intel-iommu.c                     |   18 ++++
 drivers/mailbox/mailbox-xgene-slimpro.c         |    6 -
 drivers/md/bcache/writeback.c                   |    4 -
 drivers/md/dm-cache-metadata.c                  |    3=20
 drivers/md/dm-thin.c                            |    2=20
 drivers/mfd/hi655x-pmic.c                       |    2=20
 drivers/misc/cxl/main.c                         |    2=20
 drivers/misc/vmw_balloon.c                      |   67 ++++++++++------
 drivers/net/wireless/marvell/libertas/dev.h     |    1=20
 drivers/net/wireless/marvell/libertas/if_sdio.c |   30 ++++++-
 drivers/nvdimm/bus.c                            |    4 -
 drivers/pwm/pwm-tiehrpwm.c                      |    2=20
 drivers/rtc/rtc-omap.c                          |   14 +--
 drivers/spi/spi-davinci.c                       |    2=20
 drivers/spi/spi-fsl-dspi.c                      |   24 +++---
 drivers/tty/serial/serial_core.c                |   17 +++-
 drivers/video/fbdev/core/fbmem.c                |   38 ++++++++-
 fs/9p/xattr.c                                   |    6 +
 fs/nfs/blocklayout/dev.c                        |    2=20
 fs/nfs/nfs4proc.c                               |    9 ++
 fs/quota/quota.c                                |    2=20
 fs/ubifs/journal.c                              |   18 ++++
 fs/ubifs/lprops.c                               |    8 +-
 fs/xattr.c                                      |    2=20
 include/linux/intel-iommu.h                     |    8 +-
 include/linux/pci.h                             |   12 +++
 include/linux/sunrpc/clnt.h                     |    1=20
 include/linux/verification.h                    |    6 +
 include/video/udlfb.h                           |    2=20
 kernel/power/Kconfig                            |    1=20
 kernel/printk/nmi.c                             |    4 -
 kernel/sys.c                                    |   95 +++++++++++--------=
-----
 kernel/trace/blktrace.c                         |    4 +
 kernel/trace/trace.c                            |    4 -
 kernel/trace/trace_uprobe.c                     |    2=20
 kernel/user_namespace.c                         |   24 ++----
 kernel/utsname_sysctl.c                         |   41 ++++++----
 mm/memory.c                                     |    9 --
 net/9p/client.c                                 |    2=20
 net/9p/trans_fd.c                               |    7 +
 net/9p/trans_rdma.c                             |    3=20
 net/9p/trans_virtio.c                           |   13 +++
 net/ieee802154/6lowpan/tx.c                     |   21 ++++-
 net/mac802154/tx.c                              |   15 +++
 net/sunrpc/clnt.c                               |   28 +++++--
 tools/perf/util/auxtrace.c                      |    3=20
 68 files changed, 665 insertions(+), 339 deletions(-)

Adrian Hunter (1):
      perf auxtrace: Fix queue resize

Al Viro (1):
      osf_getdomainname(): use copy_to_user()

Alexander Aring (2):
      net: 6lowpan: fix reserved space for single frames
      net: mac802154: tx: expand tailroom if necessary

Bart Van Assche (2):
      ib_srpt: Fix a use-after-free in srpt_close_ch()
      RDMA/rxe: Set wqe->status correctly if an unexpected response is rece=
ived

Bartosz Golaszewski (1):
      spi: davinci: fix a NULL pointer dereference

Benjamin Herrenschmidt (1):
      powerpc/powernv/pci: Work around races in PCI bridge enabling

Bill Baker (1):
      NFSv4 client live hangs after live data migration recovery

Chirantan Ekbote (1):
      9p/net: Fix zero-copy path in the 9p virtio transport

Christian Brauner (1):
      getxattr: use correct xattr length

Dan Carpenter (1):
      pnfs/blocklayout: off by one in bl_map_stripe()

Daniel Mack (1):
      libertas: fix suspend and resume for SDIO connected cards

Frederick Lawler (1):
      PCI: Add wrappers for dev_printk()

Greg Kroah-Hartman (1):
      Linux 4.9.126

Gustavo A. R. Silva (1):
      mailbox: xgene-slimpro: Fix potential NULL pointer dereference

Hari Bathini (1):
      powerpc/fadump: handle crash memory ranges array index overflow

Horia Geant=C4=83 (1):
      crypto: caam/jr - fix descriptor DMA unmapping

Hou Tao (1):
      dm thin: stop no_space_timeout worker when switching to write-mode

Jacob Pan (2):
      iommu/vt-d: Add definitions for PFSID
      iommu/vt-d: Fix dev iotlb pfsid use

Jann Horn (2):
      sys: don't hold uts_sem while accessing userspace memory
      userns: move user access out of the mutex

Jeremy Cline (1):
      fs/quota: Fix spectre gadget in do_quotactl

Johan Hovold (1):
      rtc: omap: fix potential crash on power off

Jon Hunter (1):
      ARM: tegra: Fix Tegra30 Cardhu PCA954x reset

Krzysztof Kozlowski (1):
      spi: spi-fsl-dspi: Fix imprecise abort on VF500 during probe

Lars-Peter Clausen (2):
      iio: ad9523: Fix displayed phase
      iio: ad9523: Fix return value for ad952x_store()

Mahesh Salgaonkar (1):
      powerpc/pseries: Fix endianness while restoring of r3 in MCE handler.

Matthew Auld (1):
      drm/i915/userptr: reject zero user_size

Max Filippov (2):
      xtensa: limit offsets in __loop_cache_{all,page}
      xtensa: increase ranges in ___invalidate_{i,d}cache_all

Mike Snitzer (1):
      dm cache metadata: save in-core policy_hint_size to on-disk superblock

Mikulas Patocka (2):
      fb: fix lost console when the user unplugs a USB adapter
      udlfb: set optimal write delay

Nadav Amit (4):
      vmw_balloon: fix inflation of 64-bit GFNs
      vmw_balloon: do not use 2MB without batching
      vmw_balloon: VMCI_DOORBELL_SET does not check status
      vmw_balloon: fix VMCI use when balloon built into kernel

Ondrej Mosnacek (1):
      crypto: vmx - Fix sleep-in-atomic bugs

Paolo Bonzini (1):
      KVM: VMX: fixes for vmentry_l1d_flush module parameter

Peter Zijlstra (1):
      mm/tlb: Remove tlb_remove_table() non-concurrent condition

Rafael David Tinoco (1):
      mfd: hi655x: Fix regmap area declared size for hi655x

Richard Weinberger (4):
      ubifs: Fix memory leak in lprobs self-check
      Revert "UBIFS: Fix potential integer overflow in allocation"
      ubifs: Check data node size before truncate
      ubifs: Fix synced_i_size calculation for xattr inodes

Shan Hai (1):
      bcache: release dc->writeback_lock properly in bch_writeback_thread()

Steven Rostedt (VMware) (4):
      tracing: Do not call start/stop() functions when tracing_on does not =
change
      tracing/blktrace: Fix to allow setting same value
      uprobes: Use synchronize_rcu() not synchronize_sched()
      printk/tracing: Do not trace printk_nmi_enter()

Tomas Bortoli (3):
      net/9p/client.c: version pointer uninitialized
      net/9p/trans_fd.c: fix race-condition by flushing workqueue before th=
e kfree()
      9p: fix multiple NULL-pointer-dereferences

Tycho Andersen (1):
      uart: fix race between uart_put_char() and uart_shutdown()

Vaibhav Jain (1):
      cxl: Fix wrong comparison in cxl_adapter_context_get()

Vignesh R (1):
      pwm: tiehrpwm: Fix disabling of output of PWMs

Vishal Verma (1):
      libnvdimm: fix ars_status output length calculation

Yannik Sembritzki (2):
      Replace magic for trusting the secondary keyring with #define
      Fix kexec forbidding kernels signed with keys in the secondary keyrin=
g to boot

jiangyiwen (1):
      9p/virtio: fix off-by-one error in sg list bounds check

piaojun (1):
      fs/9p/xattr.c: catch the error of p9_client_clunk when setting xattr =
failed

zhangyi (F) (1):
      PM / sleep: wakeup: Fix build error caused by missing SRCU support


--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAluWGW8ACgkQONu9yGCS
aT6S5xAAgGNSC1cHjeBcTSMuStOkQ+mH8AIwvQCpsSsZJ7+qnFncfFVBt2WcUo9+
5EWI7Fo41jfBxKKZCGYIGJz6HZNDswlX++quSza394LU73MhepLNE8x+QBGG1rG/
BpiiCuYa7MiW9JyHQVvCtT7GW6KvsjGER0p2RJutnJY5/7zBrbDjK64XvV4R52ii
Ce/t/AYqPpHNNHFDwHlO1rcnQmEVIP+zDUQvj0lPI9P+fzMoBDZdNY8nLmDvyxZZ
MAg+fRz43NLZrcFhpfFJqkkCPusFR3IAlVP4/OxI8kekTzQDVs5jmwHirrQ033Yu
7+SA1qKZVSjOBb0z+I+Fnd/EX9tLJ0BBEOn6HkhWdim+CeHHM5IhhPsx5if06Lje
8TdFrQKqfuEYfRaTEtmENgiXJCgNnjyb+XnSz/PhROMjCKz7Q9nx9EF09AHOxPBz
U1DUDXoNEJhzKR7fYRowgqCEewDFtYX4qqBpasVd9WpZKl2Qa5BrJlabtAXpWVGA
xznTsjO3DOGpQ+Je0qrEMxFv8h84EGKGUfphiuaTjZix+QOnVnwcDAfWyO9tx2L3
VK3qTmtpY3IieroxzaW+uU2Tlp7GwFCM6U5/nTQW1HKP5EC9gWKvCD5Z4Ds0hdNc
pglXgB+prOA3ZhNCXxYQyTGsXqCNK5GliVwd9qtbLc60LU7l+14=
=zpFD
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
