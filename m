Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A9FECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 04:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCF820854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 04:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CCF820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeGUFH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 01:07:58 -0400
Received: from ozlabs.org ([203.11.71.1]:49227 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbeGUFH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 01:07:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41XZFg4lBbz9s4c;
        Sat, 21 Jul 2018 14:16:39 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     aik@ozlabs.ru, alex.williamson@redhat.com, ego@linux.vnet.ibm.com,
        jrtc27@jrtc27.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.18-4 tag
Date:   Sat, 21 Jul 2018 14:16:38 +1000
Message-ID: <87r2jxi5p5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 4.18:

The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.18-4

for you to fetch changes up to b03897cf318dfc47de33a7ecbc7655584266f034:

  powerpc/powernv: Fix save/restore of SPRG3 on entry/exit from stop (idle) (2018-07-18 20:40:17 +1000)

- ------------------------------------------------------------------
powerpc fixes for 4.18 #4

Two regression fixes, one for xmon disassembly formatting and the other to fix
the E500 build.

Two commits to fix a potential security issue in the VFIO code under obscure
circumstances.

And finally a fix to the Power9 idle code to restore SPRG3, which is user
visible and used for sched_getcpu().

Thanks to:
  Alexey Kardashevskiy, David Gibson. Gautham R. Shenoy, James Clarke.

- ------------------------------------------------------------------
Alexey Kardashevskiy (2):
      vfio/spapr: Use IOMMU pageshift rather than pagesize
      KVM: PPC: Check if IOMMU page is contained in the pinned physical page

Gautham R. Shenoy (1):
      powerpc/powernv: Fix save/restore of SPRG3 on entry/exit from stop (idle)

James Clarke (1):
      powerpc/Makefile: Assemble with -me500 when building for E500

Michael Ellerman (1):
      powerpc/xmon: Fix disassembly since printf changes


 arch/powerpc/Makefile                  |  1 +
 arch/powerpc/include/asm/mmu_context.h |  4 ++--
 arch/powerpc/kernel/idle_book3s.S      |  2 ++
 arch/powerpc/kvm/book3s_64_vio.c       |  2 +-
 arch/powerpc/kvm/book3s_64_vio_hv.c    |  6 ++++--
 arch/powerpc/mm/mmu_context_iommu.c    | 37 ++++++++++++++++++++++++++++++++--
 arch/powerpc/xmon/xmon.c               |  4 ++--
 drivers/vfio/vfio_iommu_spapr_tce.c    | 10 ++++-----
 8 files changed, 52 insertions(+), 14 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJbUrNFAAoJEFHr6jzI4aWAYmsP/2ZyuFemX2WlWocU0KUKF3ig
2og9uIrwrt4Loi44FCZxeSCWqvoJJq0VvhtPY5OOoYlEMwtTJe3ZK490i2ZLz1ev
Bv//6RBkc1KIpIHS/sgx5h3/uCYiSmSikchdWNnDq9pjBpESRIZLacb/62Ahi2ZP
qKOr2msCto1frncisRB8fYnRG3r/cyBOb6ZIjkoKigf2LaYc507xPh0GjF/ZMZZi
x5Nri0RTplYk74rGMGBmUuEUCtJPL6NjSg7IwplWXGnncdddLerXlkUxyKq+2ukm
n3wukncvzuAw3BMVP1I7+MR44x4/u37QXypNtV9Mj7kskJ4LBZDnAQPjYbMWWyM5
h3I4j8mc1JOqFY2eMnGn5oH+IXwNacVB+9joWkbb1sYA1Z4ejW4YPnUl7LsXUkdV
2iiw+VKFMHvQyu+VShlqMYuNvN5cLv+uKK5EOrYQaheCqomidLcnxHS6o1RkAcrn
UIgfkKnigAV99cstWIq9NWaCUmvLZFs8nZcSRncGC2vspsR6RuchHurpsxDwecOr
YqQUvjPuLzrDpMUjx6khX+YaYYRMXP3Hk0A0FCwULrqjBjJ2kvglrstRH2Cn/67+
a2Qis42ZQnKPDSCuIEVfBkAR1wkoRR6+LeQ/DYSoMLAiHOTKvPNfYSSyBWj1FiUS
dOrYHAh/DlYwk2l+RM/O
=Fz3Z
-----END PGP SIGNATURE-----
