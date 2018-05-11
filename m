Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752549AbeEKGsq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 02:48:46 -0400
Received: from ozlabs.org ([203.11.71.1]:36173 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752306AbeEKGsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 02:48:43 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH  00/17] Implement use of HW assistance on TLB table walk on 8xx
In-Reply-To: <cover.1525435203.git.christophe.leroy@c-s.fr>
References: <cover.1525435203.git.christophe.leroy@c-s.fr>
Date: Fri, 11 May 2018 16:48:41 +1000
Message-ID: <87sh6yr8l2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> The purpose of this serie is to implement hardware assistance for TLB table walk
> on the 8xx.
>
> First part is to make L1 entries and L2 entries independant.
> For that, we need to alter ioremap functions in order to handle GUARD attribute
> at the PGD/PMD level.
>
> Last part is to try and reuse PTE fragment implemented on PPC64 in order to
> not waste 16k Pages for page tables as only 4k are used. For the time being,
> it doesn't work, but I include it in the serie anyway in order to get feedback.
>
> Tested successfully on 8xx up to the one before the last.
>
> Didn't have time to do compilation test on other configs, I send it anyway
> before leaving for one week vacation in order to get feedback.

I replied to a few patches, here's some other build errors:


arch/powerpc/mm/ioremap.c:135:15: error: '_PAGE_GUARDED' undeclared (first use in this function):
  pseries_defconfig/powerpc

arch/powerpc/include/asm/book3s/32/pgtable.h:53:19: error: 'PKMAP_BASE' undeclared (first use in this function):
  pmac32_defconfig/powerpc-5.3

include/linux/mm.h:533:41: error: 'PKMAP_BASE' undeclared (first use in this function):
  pmac32_defconfig/powerpc

ERROR: "ioremap_bot" [net/netfilter/nf_conntrack.ko] undefined!:
  linkstation_defconfig/powerpc

ERROR: "ioremap_bot" [fs/xfs/xfs.ko] undefined!:
  linkstation_defconfig/powerpc

arch/powerpc/include/asm/nohash/32/pgtable.h:80:20: error: 'PKMAP_BASE' undeclared (first use in this function):
  corenet32_smp_defconfig/powerpc-5.3

arch/powerpc/include/asm/nohash/32/pgalloc.h:64:43: error: '_PMD_GUARDED' undeclared (first use in this function):
  ppc40x_defconfig/powerpc-5.3

ERROR: "ioremap_bot" [net/packet/af_packet.ko] undefined!:
  storcenter_defconfig/powerpc

ERROR: "ioremap_bot" [drivers/usb/core/usbcore.ko] undefined!:
  ppc44x_defconfig/powerpc

cheers
