Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69834C07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206EA20989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039278;
	bh=nyRPbvgf23muYIpW6rxhZT3gml2qBFn4Q31eXk4WNVo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=PVQjbVEAw2gxQLn8TJAVi+uuSqnEmE48xlUO8IcrKSus7d6Yecy+sItjTk+AfJLxB
	 YKyuxPiLd8GtbDeUCcqfmF2flye8aR3AGK+NyUJvhHBxnR2YNrTuDoBNpC8KeRDVQd
	 F5EmBtQe+FqJziz05kj37qXaHKX23u3HYpy0TQWI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206EA20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeLETrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:47:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:56450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728664AbeLETrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:47:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFB5B20989;
        Wed,  5 Dec 2018 19:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544039271;
        bh=nyRPbvgf23muYIpW6rxhZT3gml2qBFn4Q31eXk4WNVo=;
        h=Date:From:To:Cc:Subject:From;
        b=KSfNHP8dt4wVYSToGmpn5V12y3bEQsPxd1d+pNRl0JnW+T7oIZPU/PUu79sDmUCQv
         NqnMozUbltZDftkSoAYwsa5PUkPeTEKZLXjH3b9+XO85dg2L3Ri42zRSnEHo8nb9r+
         ZF/McVxtIJw4lQNNieCTaVyiHivl/aGGX3GNSTUg=
Date:   Wed, 5 Dec 2018 20:47:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.143
Message-ID: <20181205194748.GA20738@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.143 kernel.

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

 Makefile                                       |   67 ++++++------
 arch/arm/Makefile                              |    2=20
 arch/arm/boot/compressed/Makefile              |    2=20
 arch/arm/firmware/trusted_foundations.c        |   14 +-
 arch/x86/events/core.c                         |   20 ---
 arch/x86/events/intel/core.c                   |   52 +++++++---
 arch/x86/events/perf_event.h                   |   13 +-
 arch/x86/kvm/mmu.c                             |   27 +----
 arch/x86/kvm/svm.c                             |   20 ++-
 arch/x86/kvm/x86.c                             |    3=20
 arch/xtensa/kernel/asm-offsets.c               |   16 +--
 arch/xtensa/kernel/process.c                   |    5=20
 drivers/bus/arm-cci.c                          |    2=20
 drivers/dma/at_hdmac.c                         |   10 +
 drivers/firmware/efi/libstub/Makefile          |    3=20
 drivers/firmware/efi/libstub/efi-stub-helper.c |   11 +-
 drivers/hv/channel.c                           |    8 +
 drivers/iio/magnetometer/st_magn_buffer.c      |   12 --
 drivers/media/usb/em28xx/em28xx-dvb.c          |    3=20
 drivers/misc/mic/scif/scif_rma.c               |    2=20
 drivers/net/rionet.c                           |    2=20
 drivers/net/usb/ipheth.c                       |   10 -
 drivers/net/wireless/ti/wlcore/cmd.c           |    6 -
 drivers/s390/net/qeth_core_main.c              |   27 ++---
 drivers/usb/core/quirks.c                      |    3=20
 drivers/usb/dwc3/gadget.c                      |    5=20
 drivers/usb/storage/unusual_realtek.h          |   10 +
 fs/btrfs/super.c                               |    1=20
 fs/btrfs/transaction.c                         |    6 -
 fs/direct-io.c                                 |    4=20
 fs/ext2/xattr.c                                |    2=20
 include/linux/workqueue.h                      |    4=20
 mm/huge_memory.c                               |   79 +++++++--------
 mm/khugepaged.c                                |  129 ++++++++++++++------=
-----
 mm/shmem.c                                     |   97 ++++++++++--------
 net/core/skbuff.c                              |    4=20
 sound/core/control.c                           |   80 ++++++++-------
 sound/isa/wss/wss_lib.c                        |    2=20
 sound/pci/ac97/ac97_codec.c                    |    2=20
 sound/sparc/cs4231.c                           |    8 -
 40 files changed, 423 insertions(+), 350 deletions(-)

Alistair Strachan (1):
      efi/libstub: arm: support building with clang

Ard Biesheuvel (1):
      efi/libstub: Make file I/O chunking x86-specific

Arnd Bergmann (1):
      workqueue: avoid clang warning

Bernd Eckstein (1):
      usbnet: ipheth: fix potential recvmsg bug and recvmsg bug 2

Chris Fries (1):
      kbuild: Set KBUILD_CFLAGS before incl. arch Makefile

Dexuan Cui (1):
      Drivers: hv: vmbus: check the creation_status in vmbus_establish_gpad=
l()

Felipe Balbi (1):
      Revert "usb: dwc3: gadget: skip Set/Clear Halt when invalid"

Filipe Manana (1):
      Btrfs: ensure path name is null terminated at btrfs_control_ioctl

Greg Kroah-Hartman (1):
      Linux 4.9.143

Hugh Dickins (9):
      mm/huge_memory: rename freeze_page() to unmap_page()
      mm/huge_memory: splitting set mapping+index before unfreeze
      mm/huge_memory: fix lockdep complaint on 32-bit i_size_read()
      mm/khugepaged: collapse_shmem() stop if punched or truncated
      mm/khugepaged: fix crashes due to misaccounted holes
      mm/khugepaged: collapse_shmem() remember to clear holes
      mm/khugepaged: minor reorderings in collapse_shmem()
      mm/khugepaged: collapse_shmem() without freezing new_page
      mm/khugepaged: collapse_shmem() do not crash on Compound

Jim Mattson (1):
      kvm: svm: Ensure an IBPB on all affected CPUs when freeing a vmcb

Jiri Olsa (2):
      perf/x86/intel: Move branch tracing setup to the Intel-specific sourc=
e file
      perf/x86/intel: Add generic branch tracing check to intel_pmu_has_bts=
()

Josef Bacik (1):
      btrfs: release metadata before running delayed refs

Julian Wiedmann (1):
      s390/qeth: fix length check in SNMP processing

Junaid Shahid (1):
      kvm: mmu: Fix race in emulated page table writes

Kai-Heng Feng (1):
      USB: usb-storage: Add new IDs to ums-realtek

Konstantin Khlebnikov (1):
      mm/huge_memory.c: reorder operations in __split_huge_page_tail()

Martin Kelly (1):
      iio:st_magn: Fix enable device after trigger

Matthias Schwarzott (1):
      media: em28xx: Fix use-after-free when disconnecting

Max Filippov (2):
      xtensa: enable coprocessors that are being flushed
      xtensa: fix coprocessor context offset definitions

Maximilian Heyne (1):
      fs: fix lost error code in dio_complete

Michael Niew=F6hner (1):
      usb: core: quirks: add RESET_RESUME quirk for Cherry G230 Stream seri=
es

Mike Rapoport (2):
      shmem: shmem_charge: verify max_block is not exceeded before inode up=
date
      shmem: introduce shmem_inode_acct_block

Pan Bian (2):
      rapidio/rionet: do not free skb before reading its length
      ext2: fix potential use after free

Petr Machata (1):
      net: skb_scrub_packet(): Scrub offload_fwd_mark

Richard Genoud (2):
      dmaengine: at_hdmac: fix memory leak in at_dma_xlate()
      dmaengine: at_hdmac: fix module unloading

Sasha Levin (1):
      Revert "wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_=
timeout()"

Stefan Agner (4):
      ARM: 8766/1: drop no-thumb-interwork in EABI mode
      ARM: 8767/1: add support for building ARM kernel with clang
      bus: arm-cci: remove unnecessary unreachable()
      ARM: trusted_foundations: do not use naked function

Takashi Iwai (4):
      ALSA: wss: Fix invalid snd_free_pages() at error path
      ALSA: ac97: Fix incorrect bit shift at AC97-SPSA control write
      ALSA: control: Fix race between adding and removing a user element
      ALSA: sparc: Fix invalid snd_free_pages() at error path

Wanpeng Li (1):
      KVM: X86: Fix scan ioapic use-before-initialization

Yu Zhao (1):
      mm: use swp_offset as key in shmem_replace_page()

YueHaibing (1):
      misc: mic/scif: fix copy-paste error in scif_create_remote_lookup


--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwIK2QACgkQONu9yGCS
aT77GRAAkzfjeoqEhlqT2zvR9nbSY9BypgGiCe1udWk92heG1d/RKQFch9M2K35N
hotzwo4pJRYjB+4HZXMLZZXxwcMetHOgla61mWrGO7eKfJMmVHvEdCs78LEuU1VM
mZp5MhF8ECvNzRGsi87oYyniA8su7Pay7cW5zBNTPkvF6/yFqASWt/2k+TDqExvE
qo0jfhvtf7l6hL/azPkhRdQwKY/9p/1xuLoDrG7Krd76fiXKnVb4Xr8m58IWkVRo
rhZ7Q25kFqkgRvTzXJ/WeBqnmTeB7g+9TOJv/KWXfxe2Ba+D1DGtY1saWjQ6ll2I
bND0UbNO9ytBEW+dgEirR+Q4rY/JTZFWQRZCy7BUZ9LaANeiZdSBxVsyuVkzxCL8
eczmROr+F/DvLEKnXfkBTD9GuxhD+6UQdlYL72/T46kXWIlmIm2HNnulmwBL+P1E
YwaWyflEf+nhSwn6aLhjmt18nTn7fN+Wdq8ko8fwsSkgxcSW3BwkZp58JZpIgimF
smpAujDxxW/XNeoqFRdQ3Ir6aCl1k2zbEbbWIBYlyhSBg8KQcuPRZIRhWXlGIpBI
RpAwVVk/fX1bRlnz1RKXrynL89B3/lNZsk9S0biaAWkDkVgPXSqx0Wnkx/WsJFWH
Zs51HPhhMYg3XpLTdrSne8hp3m0rHUZyzlsKY7I3js6z4yGYvdE=
=JGb7
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
