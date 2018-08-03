Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43F5C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1389E2175E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1389E2175E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeHCN2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:28:42 -0400
Received: from ozlabs.org ([203.11.71.1]:51851 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbeHCN2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:28:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41hlJs3ZkWz9ryt;
        Fri,  3 Aug 2018 21:32:45 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     fbarrat@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.18-5 tag
Date:   Fri, 03 Aug 2018 21:32:44 +1000
Message-ID: <877el7hehv.fsf@concordia.ellerman.id.au>
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

The following changes since commit b03897cf318dfc47de33a7ecbc7655584266f034:

  powerpc/powernv: Fix save/restore of SPRG3 on entry/exit from stop (idle) (2018-07-18 20:40:17 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.18-5

for you to fetch changes up to cca19f0b684f4ed6aabf6ad07ae3e15e77bfd78a:

  powerpc/64s/radix: Fix missing global invalidations when removing copro (2018-08-01 23:23:41 +1000)

- ------------------------------------------------------------------
powerpc fixes for 4.18 #5

One fix for a regression in a recent TLB flush optimisation, which caused us to
incorrectly not send TLB invalidations to coprocessors.

Thanks to:
  Frederic Barrat, Nicholas Piggin, Vaibhav Jain.

- ------------------------------------------------------------------
Frederic Barrat (1):
      powerpc/64s/radix: Fix missing global invalidations when removing copro


 arch/powerpc/include/asm/mmu_context.h | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJbZD0oAAoJEFHr6jzI4aWAcXgP/2H1bZ7IW+1iRkeBxLWerg+W
jjo6sMXYFE/yIWiDquE0hqTDF2yeUPORrTJHDFAarDQN4kNzfbiyW1x5rR45hUED
evbruA694+vzTIGH6bN/jiiuaazeKzX9SlweQN+eMZcO0R5m+BGPdz5mLlY/xvM+
9iRY89+ZmMzIK5yWFeXwFYhnqupOhQAKmCh3cGi9DDI3hfSfBOawAeYyx8H6y8WI
wd3bhl+PY6Yrx4Y6ZWnvWtNIY2QXSB9+rn0cOABPaQWasHhIYEFVpnT2DxRIM6ST
V9BNOj1PhvDcClnwaNE8Gus06CTqf2crOWVhOvYYwB0tMlvFnhFjexxwkhXQSmeT
kQKINYZ5eCyJhm1CmZ2CVv9KxPJESFilDr+CEHKXBq8mD7X1KUIvGyKmqZAOCgCQ
2ZBhgPoSs/lBoj7uBMgriMrnDI0VonUGNYSgT0XPiKIB0/vi5uYJBumwkvTuyDYk
2iIS29OnVv57xmF6QIvSp8jzmaDNxD+QP9Hrbqa7rInGiaGyYHAlfTqlm80ja7Jx
HBvYTW9PPKywYyTAxBpFc9TytuX4CvPMZsA1vo7Ow8nfVTNjtqGRl0VeXZ3fkW3E
QP8hfpgmkzIZeASpd1p7mSY0ki/5wad7Lb1wcqFJYE2/pT3Kd4oCjTbT7BFW70N6
hegdM5woDuk8lKFqao3V
=klUx
-----END PGP SIGNATURE-----
