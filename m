Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeBFAo1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 19:44:27 -0500
Received: from ozlabs.org ([103.22.144.67]:45925 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750903AbeBFAoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 19:44:23 -0500
Date: Tue, 6 Feb 2018 11:44:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: linux-next: manual merge of the tip tree with Linus' tree
Message-ID: <20180206114421.339e9e44@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/x86/Kconfig

between commit:

  ea8c64ace866 ("dma-mapping: move swiotlb arch helpers to a new header")

from Linus' tree and commit:

  10bcc80e9dbc ("membarrier/x86: Provide core serializing command")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/x86/Kconfig
index b0771ceabb4b,e095bdb9afdf..000000000000
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@@ -54,7 -54,7 +54,8 @@@ config X8
  	select ARCH_HAS_FORTIFY_SOURCE
  	select ARCH_HAS_GCOV_PROFILE_ALL
  	select ARCH_HAS_KCOV			if X86_64
+ 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 +	select ARCH_HAS_PHYS_TO_DMA
  	select ARCH_HAS_PMEM_API		if X86_64
  	select ARCH_HAS_REFCOUNT
  	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
