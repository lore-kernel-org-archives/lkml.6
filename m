Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F3FC6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319512802E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319512802E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936479AbeF3BvU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 21:51:20 -0400
Received: from ozlabs.org ([203.11.71.1]:46053 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936028AbeF3BvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 21:51:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Hc1d5J5hz9rvt;
        Sat, 30 Jun 2018 11:51:16 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     aneesh.kumar@linux.ibm.com, arnd@arndb.de, hch@lst.de,
        leitao@debian.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.18-3 tag
Date:   Sat, 30 Jun 2018 11:51:16 +1000
Message-ID: <87lgaxm48b.fsf@concordia.ellerman.id.au>
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

The following changes since commit fadd03c615922d8521a2e76d4ba2335891cb2790:

  powerpc/mm/hash/4k: Free hugetlb page table caches correctly. (2018-06-20 09:13:25 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.18-3

for you to fetch changes up to 22db552b50fa11d8c1d171de908a1f9ef62172b7:

  powerpc/powermac: Fix rtc read/write functions (2018-06-27 13:48:49 +1000)

- ------------------------------------------------------------------
powerpc fixes for 4.18 #3

Two regression fixes, and a new syscall wire-up.

A fix for the recent conversion to time64_t in the powermac RTC routines, which
caused time to go backward.

Another fix for fallout from the split PMD PTL conversion.

Wire up the new io_pgetevents() syscall.

Thanks to:
  Aneesh Kumar K.V, Arnd Bergmann, Breno Leitao, Mathieu Malaterre.

- ------------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc/mm/32: Fix pgtable_page_dtor call

Arnd Bergmann (1):
      powerpc/powermac: Fix rtc read/write functions

Breno Leitao (1):
      powerpc: Wire up io_pgetevents


 arch/powerpc/include/asm/book3s/32/pgalloc.h |  1 -
 arch/powerpc/include/asm/nohash/32/pgalloc.h |  1 -
 arch/powerpc/include/asm/systbl.h            |  1 +
 arch/powerpc/include/asm/unistd.h            |  2 +-
 arch/powerpc/include/uapi/asm/unistd.h       |  1 +
 arch/powerpc/platforms/powermac/time.c       | 29 +++++++++++++++++++---------
 6 files changed, 23 insertions(+), 12 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJbNuG+AAoJEFHr6jzI4aWA1EAP/RdhBfhErOfaR6CN9hB7JT0f
4ibdfYQzfGLhml40w70BnSR1rJZtQLk3TZUeT4bhjWb9GRLmakXf1iwp0yGle6gX
Y+r54Jy3lqD8dHEn1cONQYAOdADBAv1OFZ54cCnch1yvjOxnFTDn4jR0jjLnM8Jk
fD1VBRgCTJT5lkNpfIP2UtbEcy2Y9E4QCCUDCRaAYTPwJQqjIBcuNmxahObvawhe
U1k9FhPcqwUPD0jjEbEBvwnaPEZzvHOnqU4G2elBmHjBSPCFXVWQ+4AdDlAHK67J
qEx3q6Xycw8ATmonwPxxv8eu7Lq0XgSYXB/zUmjp1pvcOCMdYZ0Lei0yyPJfcFWA
PX9RtlENuMbhz6Pm1INhtcm+yxV9v+nzHAI40kVHh+yZLQTK2zt8jZiqFs3ZHOm5
NY55XIWW1ATnKB9T0Teu/efEDTBHtDtTQ5hmJW88UB3Fd9OVjTspz6aWVlTB4VRr
jxT0VedPt3B/zTwEpIeA6W3/WgveIhK8VZ49ntMqAINw4tsc4gc7a6A98riZ9Oxw
YQ9pPqejx9Jw/2AeYhZ1RA/hV9REICIicX6fxR98fkx2ViqNF8OC3YzvQXNJWe3L
EyRx1TLj/8lb0o5A92rOeeL/5QQK+H5PGoIY9gY6NhsDDSAadtHu1oAhftscVopZ
k94DXR9yFZg+aoU2lWDp
=NS+i
-----END PGP SIGNATURE-----
