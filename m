Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756E9C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433DB2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433DB2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeJCDrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:47:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:52583 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbeJCDrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:47:39 -0400
Received: from ls3530.fritz.box ([92.116.181.135]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LdHqj-1fP4a81EMT-00iTwF; Tue, 02
 Oct 2018 23:02:17 +0200
Received: from ls3530.fritz.box ([92.116.181.135]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LdHqj-1fP4a81EMT-00iTwF; Tue, 02
 Oct 2018 23:02:17 +0200
Date:   Tue, 2 Oct 2018 23:02:13 +0200
From:   Helge Deller <deller@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc fixes for kernel v4.19
Message-ID: <20181002210213.GA17826@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Provags-ID: V03:K1:358Mr3mlUDOIlOPeZTSLMPoR1uxCKyOKYo6999627PypkghL0t8
 96RUkrTKy4LuxrqYfYDggvbpMn24PSlluTyo+1bReringcJ3TKuPHWTDaDdNfyUbrUZAq1Z
 6brQK4bxbFbDXvUk+aAIQZPtZaYvcNushIeW8A4+rSGBRjcXmCUBFkfDQO5pnlC8c6/9keu
 Ebb9GUXpRsIQzlvYO6i/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+qaORvzqpk0=:LKtOXCnSYEw8/Fcam14tBU
 DJpKk8TpruYrX5Z9g71AyG4WWCFuaPa6/XkqJYKPHwoGqfENLCSg1xINf/eAmfAL+uwfwvUeS
 k76FvR5UIb7fTUg2nTwm/96oKw1U1SI0KpxUhT+cEPSeM7Xihj5tWRjzHbtoEukbOkla5Yscp
 zHbbdsplG3kkRNGPaDL5A5ta5Woh3tV3m25uIyF144d80Wcc7DpgPDG2diWg51A468yPE+EbL
 6YJU1iaHgkwiGw2NgmYaSqMY46srdXQ3w5+nVbM+CoDdQ0So1vFGHeMV7eU1GHwNq7HLgPbbQ
 /SedIAmAzhCjkIlFyzjkatfJx7tcOqxTlW83hvw4/4Vyg4t1pcFIdc+NIdhEvsJUXztyzodjl
 ZfsnwHMto9RW+KbFE0fD1qgT0GQOe2CcUgEBnbavXKSykA71BIkXRF/r5NuErEoSykgujdsfI
 D1LWWkoXQ8WW2jU/REIXuSWX84WFVlRnKe+99NmHJ7c/iiyckq4LLs3ZAxQ+PF+dwNT6Lf5xU
 dWwERHNI4hyjz9vWFgNtC4tXgoAHm4f7FniHbaN1Sdn3Nho2/pMhNOcL7DBSwWFiJP3VS4NRp
 J3qSRkaH60OiPC34yygpN6MgA40brH6LmUrXSPzJd22F18tqPPp3ctjKp+Iyduj445XZA+UwY
 Ow+/O8RZ9rpn0FaTOtuuDo/dtkSOPaFd8gRkDJh6bePc1XJRx6tOgoL1tl6hw7YBY2l95k+wX
 iTaJDGKPp5PkNukX6pnQzt0fE781M433s8iFokBXQJwgKuw9RfrlkPimAisscFmHMBq6A813v
 GtbBTn0d3+MuHzHrRvdSQGLLVPz4A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

please pull a last set of fixes for the parisc architecture for kernel 4.19 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.19-3

The major change is for parisc64 to use a 64-bit suseconds_t type to
match what glibc expects for 64-bit userspace. It's an ABI change, but
since we don't have a 64-bit userspace on parisc yet, it won't introduce
a breakage.

Other than that we simply drop unused code and outdated gcc version
checks.

Thanks,
Helge

----------------------------------------------------------------
Arnd Bergmann (1):
      parisc64: change __kernel_suseconds_t to match glibc

Christoph Hellwig (1):
      parisc: remove the dead ccio-rm-dma driver

Helge Deller (1):
      parisc: Use PARISC_ITLB_TRAP constant in entry.S

Masahiro Yamada (1):
      parisc: remove check for minimum required GCC version

 arch/parisc/Makefile                       |   9 --
 arch/parisc/include/uapi/asm/posix_types.h |   3 -
 arch/parisc/kernel/entry.S                 |   2 +-
 drivers/parisc/Makefile                    |   3 -
 drivers/parisc/ccio-rm-dma.c               | 202 -----------------------------
 5 files changed, 1 insertion(+), 218 deletions(-)
 delete mode 100644 drivers/parisc/ccio-rm-dma.c
