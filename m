Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627FAC43615
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE9D2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE9D2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390947AbeHPNNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 09:13:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43610 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390903AbeHPNNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 09:13:52 -0400
Received: from localhost (unknown [37.170.164.166])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A1FAD40B;
        Thu, 16 Aug 2018 10:16:15 +0000 (UTC)
Date:   Thu, 16 Aug 2018 12:16:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.148
Message-ID: <20180816101611.GA10969@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.148 kernel.

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

 Makefile                                    |    2=20
 arch/arm/boot/dts/imx6sx.dtsi               |    2=20
 arch/parisc/Kconfig                         |    2=20
 arch/parisc/include/asm/barrier.h           |   32 ++++++++++
 arch/parisc/kernel/entry.S                  |    2=20
 arch/parisc/kernel/pacache.S                |    1=20
 arch/parisc/kernel/syscall.S                |    4 +
 arch/x86/include/asm/cpufeatures.h          |   10 ++-
 arch/x86/include/asm/irqflags.h             |    2=20
 arch/x86/include/asm/page_32_types.h        |    9 ++-
 arch/x86/include/asm/pgtable-2level.h       |   17 +++++
 arch/x86/include/asm/pgtable-3level.h       |   37 +++++++++++-
 arch/x86/include/asm/pgtable-invert.h       |   32 ++++++++++
 arch/x86/include/asm/pgtable.h              |   84 ++++++++++++++++++++++-=
-----
 arch/x86/include/asm/pgtable_64.h           |   54 +++++++++++++++---
 arch/x86/include/asm/pgtable_types.h        |   10 +--
 arch/x86/include/asm/processor.h            |    5 +
 arch/x86/kernel/cpu/bugs.c                  |   81 ++++++++++++++++-------=
----
 arch/x86/kernel/cpu/common.c                |   20 ++++++
 arch/x86/kernel/kprobes/core.c              |    4 -
 arch/x86/kernel/paravirt.c                  |   14 +++-
 arch/x86/kernel/setup.c                     |    6 ++
 arch/x86/mm/init.c                          |   25 ++++++++
 arch/x86/mm/kmmio.c                         |   25 +++++---
 arch/x86/mm/mmap.c                          |   21 +++++++
 arch/x86/mm/pageattr.c                      |    8 +-
 drivers/acpi/acpi_lpss.c                    |    2=20
 drivers/base/cpu.c                          |    8 ++
 drivers/char/tpm/tpm-dev.c                  |   43 ++++++--------
 drivers/infiniband/core/umem.c              |   11 ---
 drivers/infiniband/hw/mlx4/mr.c             |   50 ++++++++++++++--
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c |    2=20
 drivers/net/xen-netfront.c                  |    8 +-
 drivers/scsi/sr.c                           |   29 +++++++--
 fs/dcache.c                                 |    6 +-
 fs/ext4/ialloc.c                            |    5 +
 fs/ext4/super.c                             |    8 --
 fs/namespace.c                              |   28 ++++++++-
 include/asm-generic/pgtable.h               |   12 ++++
 include/linux/cpu.h                         |    2=20
 include/linux/mm.h                          |    2=20
 include/linux/swapfile.h                    |    2=20
 include/linux/thread_info.h                 |    6 --
 include/rdma/ib_verbs.h                     |   14 ++++
 mm/memory.c                                 |   62 +++++++++++++++++---
 mm/mprotect.c                               |   49 ++++++++++++++++
 mm/swapfile.c                               |   46 ++++++++++-----
 net/ipv4/Kconfig                            |    1=20
 net/ipv6/Kconfig                            |    1=20
 49 files changed, 715 insertions(+), 191 deletions(-)

Al Viro (3):
      root dentries need RCU-delayed freeing
      fix mntput/mntput race
      fix __legitimize_mnt()/mntput() race

Andi Kleen (10):
      x86/speculation/l1tf: Increase 32bit PAE __PHYSICAL_PAGE_SHIFT
      x86/speculation/l1tf: Protect PROT_NONE PTEs against speculation
      x86/speculation/l1tf: Make sure the first page is always reserved
      x86/speculation/l1tf: Add sysfs reporting for l1tf
      x86/speculation/l1tf: Disallow non privileged high MMIO PROT_NONE map=
pings
      x86/speculation/l1tf: Limit swap file size to MAX_PA/2
      x86/speculation/l1tf: Invert all not present mappings
      x86/speculation/l1tf: Make pmd/pud_mknotpresent() invert
      x86/mm/pat: Make set_memory_np() L1TF safe
      x86/mm/kmmio: Make the tracer robust against L1TF

Andy Lutomirski (1):
      mm: Add vm_insert_pfn_prot()

Bart Van Assche (1):
      scsi: sr: Avoid that opening a CD-ROM hangs with runtime power manage=
ment enabled

Dan Williams (1):
      mm: fix cache mode tracking in vm_insert_mixed()

Dave Hansen (2):
      x86/mm: Move swap offset/type up in PTE to work around erratum
      x86/mm: Fix swap entry comment and macro

Greg Kroah-Hartman (1):
      Linux 4.4.148

Guenter Roeck (1):
      x86/speculation/l1tf: Fix up CPU feature flags

Hans de Goede (1):
      ACPI / LPSS: Add missing prv_offset setting for byt/cht PWM devices

Helge Deller (1):
      parisc: Enable CONFIG_MLONGCALLS by default

Jack Morgenstein (2):
      IB/core: Make testing MR flags for writability a static inline functi=
on
      IB/mlx4: Mark user MR as writable if actual virtual memory is writable

Jiri Kosina (2):
      x86/speculation: Protect against userspace-userspace spectreRSB
      x86/speculation/l1tf: Unbreak !__HAVE_ARCH_PFN_MODIFY_ALLOWED archite=
ctures

John David Anglin (1):
      parisc: Define mb() and add memory barriers to assembler unlock seque=
nces

Juergen Gross (1):
      xen/netfront: don't cache skb_shinfo()

Kees Cook (1):
      fork: unconditionally clear stack on fork

Konrad Rzeszutek Wilk (2):
      x86/bugs: Move the l1tf function and define pr_fmt properly
      x86/cpufeatures: Add detection of L1D cache flush support.

Linus Torvalds (2):
      x86/speculation/l1tf: Change order of offset/type in swap entry
      x86/speculation/l1tf: Protect swap entries against L1TF

Masami Hiramatsu (1):
      kprobes/x86: Fix %p uses in error messages

Michael Mera (1):
      IB/ocrdma: fix out of bounds access to local buffer

Michal Hocko (1):
      x86/speculation/l1tf: Fix up pte->pfn conversion for PAE

Naoya Horiguchi (1):
      mm: x86: move _PAGE_SWP_SOFT_DIRTY from bit 7 to bit 1

Nick Desaulniers (1):
      x86/irqflags: Provide a declaration for native_save_fl

Oleksij Rempel (1):
      ARM: dts: imx6sx: fix irq for pcie bridge

Peter Zijlstra (1):
      x86/paravirt: Fix spectre-v2 mitigations for paravirt guests

Tadeusz Struk (1):
      tpm: fix race condition in tpm_common_write()

Theodore Ts'o (1):
      ext4: fix check to prevent initializing reserved inodes

Thomas Egerer (1):
      ipv4+ipv6: Make INET*_ESP select CRYPTO_ECHAINIV

Vlastimil Babka (3):
      x86/speculation/l1tf: Extend 64bit swap file size limit
      x86/speculation/l1tf: Protect PAE swap entries against L1TF
      x86/init: fix build with CONFIG_SWAP=3Dn


--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlt1TusACgkQONu9yGCS
aT7SqxAA0rjw/p4+DHVj/VGY/x43Envm/MrauSLDYya1it2At1gU59BSE/U7LTyT
+Vwi/+jGFFmzAwd78uQuhvYTxrpe7LKdGX2OSgqaUSL0qR1JLq6ZjlS9RaZZLBT5
Ay62tp1GVE6Ephg9Gw9pj47F7gN4FL/dHcr+CrbO+wSw6BIIHfvJ1pPSaA8KkGug
SCAfWd7UvQPYUVqQVwXmpbcstp1xBN5sdQPTmPtlo/3v01DzgBukVuCiY9ZcDfsO
+encwFLAcvq9JiWpoMJ4EnUMRNIvmRNPXCBoqTlfnc+oDut/IQiFaeM2Q7xomPI/
SH76EABBrCNtZuNEUW50ZnC2s6FqtlbXh0aq6MT1Nk4Cj/hQP7mLpmVLjB/Q/LXH
1qk103oM5hsOhm2sTCYH6M+BScRVUNaooxLxe/Vf6DOjgSBXuSKuLoa0b0WgFM5W
5SlDV/ho7rF2Pj/nfp5kh453m3vZ4UQ31ctc7pu6tJKNwTJjZFBTSu2bAeBJu1fR
ewhhcAI0bQBV2ehyHSknJtarcvyr6187nYgj6KX44frs4uE6t4GRe7bVhmAhIjBT
/ICVPs1p/ccmUyzcSdHnozQS6utChiurg5FhkeeQiBtNq3ElPlHnhcR2pCUh/Rx6
aPGqOa/67JjX3nCOYJs9n4HhRrwZYmksH2CSCVxlSdcpVhIzx3Q=
=17Vk
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
