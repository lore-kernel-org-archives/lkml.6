Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3491BC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9C32064E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9C32064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbeJVSYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:24:15 -0400
Received: from mout.gmx.net ([212.227.15.19]:57473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbeJVSYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:24:15 -0400
Received: from [10.95.173.99] ([155.56.40.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MX1hk-1g95bd2fvI-00VwEG; Mon, 22
 Oct 2018 12:06:21 +0200
Received: from [10.95.173.99] ([155.56.40.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MX1hk-1g95bd2fvI-00VwEG; Mon, 22
 Oct 2018 12:06:21 +0200
Subject: Re: [PATCH] parisc: remove the dead ccio-rm-dma driver
To:     Christoph Hellwig <hch@lst.de>, jejb@parisc-linux.org
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181022095251.5699-1-hch@lst.de>
From:   Helge Deller <deller@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=deller@gmx.de; prefer-encrypt=mutual; keydata=
 xsBNBFDPIPYBCAC6PdtagIE06GASPWQJtfXiIzvpBaaNbAGgmd3Iv7x+3g039EV7/zJ1do/a
 y9jNEDn29j0/jyd0A9zMzWEmNO4JRwkMd5Z0h6APvlm2D8XhI94r/8stwroXOQ8yBpBcP0yX
 +sqRm2UXgoYWL0KEGbL4XwzpDCCapt+kmarND12oFj30M1xhTjuFe0hkhyNHkLe8g6MC0xNg
 KW3x7B74Rk829TTAtj03KP7oA+dqsp5hPlt/hZO0Lr0kSAxf3kxtaNA7+Z0LLiBqZ1nUerBh
 OdiCasCF82vQ4/y8rUaKotXqdhGwD76YZry9AQ9p6ccqKaYEzWis078Wsj7p0UtHoYDbABEB
 AAHNHEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT7CwJIEEwECADwCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEE9M/0wAvkPPtRU6Boh8nBUbUeOGQFAlrHzIICGQEACgkQh8nB
 UbUeOGT1GAgAt+EeoHB4DbAx+pZoGbBYp6ZY8L6211n8fSi7wiwgM5VppucJ+C+wILoPkqiU
 +ZHKlcWRbttER2oBUvKOt0+yDfAGcoZwHS0P+iO3HtxR81h3bosOCwek+TofDXl+TH/WSQJa
 iaitof6iiPZLygzUmmW+aLSSeIAHBunpBetRpFiep1e5zujCglKagsW78Pq0DnzbWugGe26A
 288JcK2W939bT1lZc22D9NhXXRHfX2QdDdrCQY7UsI6g/dAm1d2ldeFlGleqPMdaaQMcv5+E
 vDOur20qjTlenjnR/TFm9tA1zV+K7ePh+JfwKc6BSbELK4EHv8J8WQJjfTphakYLVM7ATQRQ
 zyD2AQgA2SJJapaLvCKdz83MHiTMbyk8yj2AHsuuXdmB30LzEQXjT3JEqj1mpvcEjXrX1B3h
 +0nLUHPI2Q4XWRazrzsseNMGYqfVIhLsK6zT3URPkEAp7R1JxoSiLoh4qOBdJH6AJHex4CWu
 UaSXX5HLqxKl1sq1tO8rq2+hFxY63zbWINvgT0FUEME27Uik9A5t8l9/dmF0CdxKdmrOvGMw
 T770cTt76xUryzM3fAyjtOEVEglkFtVQNM/BN/dnq4jDE5fikLLs8eaJwsWG9k9wQUMtmLpL
 gRXeFPRRK+IT48xuG8rK0g2NOD8aW5ThTkF4apznZe74M7OWr/VbuZbYW443QQARAQABwsBf
 BBgBAgAJBQJQzyD2AhsMAAoJEIfJwVG1HjhkNTgH/idWz2WjLE8DvTi7LvfybzvnXyx6rWUs
 91tXUdCzLuOtjqWVsqBtSaZynfhAjlbqRlrFZQ8i8jRyJY1IwqgvHP6PO9s+rIxKlfFQtqhl
 kR1KUdhNGtiI90sTpi4aeXVsOyG3572KV3dKeFe47ALU6xE5ZL5U2LGhgQkbjr44I3EhPWc/
 lJ/MgLOPkfIUgjRXt0ZcZEN6pAMPU95+u1N52hmqAOQZvyoyUOJFH1siBMAFRbhgWyv+YE2Y
 ZkAyVDL2WxAedQgD/YCCJ+16yXlGYGNAKlvp07SimS6vBEIXk/3h5Vq4Hwgg0Z8+FRGtYZyD
 KrhlU0uMP9QTB5WAUvxvGy8=
Message-ID: <e46876bd-569e-a4ac-9fac-3a845b1960e1@gmx.de>
Date:   Mon, 22 Oct 2018 12:06:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181022095251.5699-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:pFD+DDj3+okMAgjghRWTs6ATzPYINT7tgwx51TDrDngguEGMaD9
 p+e4G7hZzYELBn+HHu1AhYdaRVzr6jRahK2cnvrxl+tNyoi5fLvi6n3vAHGDWzHOugviOSz
 8AmpZrHO84D1mAeuIQqKHCiX9H9zs1CNUXDQu0h0HcIh+ZaLA/vk4gmxu3uINIh94JOmBHZ
 pr8zvmHbOJhxEpQQ8MkbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q2anAus386A=:zXMZ31sEXSr8ANqXlTqTlv
 3jzq+kSgGN1BMCA8YQ33KnQN1dCfzhKfqO46K2NjPM2Ni9tQoGdEy+KmGtq/UuYbRniCi4oCO
 2db3C4mQ1l17fAYlEtf0Zbu5T9Z9db1uaBVDHQXyuku2HKx/5u5MAcSFMVGNiPQJlXUZVz/7q
 DaVuJO7WBDtdJtc7KEmdb9PU0gTZGsmDkr3jCD+Tvy4zRsIzSSup3RMMgSKOerMuIFljUNEuS
 f+R4E2XEhxxYGoX8O6bIjVucJrwDyGalciLTEVMRoVHq9nq/4B6cDeqWvT5jioQRGabRoCIji
 laRjl184BzNlw/LwSo9ez0goUWPeEDqp2SavUcbhgYQGA4wvh262rhQrQz8JVXMouxQw42uoC
 v47iLd0eUSpxG3BOn+wTMKtdHQEhaODcAdaVtFQN2xG86uiqHMdoeEomufVRi3VJ3n8YjyJGS
 4QsjlYb5aHbsWLj47WTOUyMlR8yTEAf51oqe/LdaTgDvky4+9VCwlueKVZWF1QtHsNcfOVJqo
 5Pdo5VsqwPtGYLQXZ4xbRd91GfxMoX4zbOHVECOwRfwEqNH9Ad5+4UelMKq4PHiMkJZDKPAjZ
 xsQqvVJ6io4wCbdrw9xdi33glrxprRId3SzQYQeJR3R6UT5xo8BGZJqx/tXmVMlK24Z+UmlJA
 5GN+i/w4kfEC4t7dJD525hxwhHqDsMFWV/klo2Fq0NAfaFFHxLdZv2FCUD1y/edP/5mn4igx2
 sst1h54oSBoM/Niy5dwunF5oi1GLU+PuuIkTumMKBoQzStOF+zlvKryUcHM8tcUG4QuwFOJ5i
 xsSrPSVSTAg0hpDi/uB1feR+F1MraiH1lcwenEaqjE4oRwdKKk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.2018 11:52, Christoph Hellwig wrote:
> This driver has never been wired up due to the life of the Linux
> git tree, and has severely bitrotted.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks Christoph!

I've already queued it up in the parisc for-next git tree:
https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/log/?h=for-next

Helge

> ---
>  drivers/parisc/Makefile      |   3 -
>  drivers/parisc/ccio-rm-dma.c | 202 -----------------------------------
>  2 files changed, 205 deletions(-)
>  delete mode 100644 drivers/parisc/ccio-rm-dma.c
> 
> diff --git a/drivers/parisc/Makefile b/drivers/parisc/Makefile
> index 3cd5e6cb8478..99fa6a89e0b9 100644
> --- a/drivers/parisc/Makefile
> +++ b/drivers/parisc/Makefile
> @@ -8,9 +8,6 @@
>  obj-$(CONFIG_IOSAPIC)		+= iosapic.o
>  obj-$(CONFIG_IOMMU_SBA)		+= sba_iommu.o
>  obj-$(CONFIG_PCI_LBA)		+= lba_pci.o
> -
> -# Only use one of them: ccio-rm-dma is for PCX-W systems *only*
> -# obj-$(CONFIG_IOMMU_CCIO)	+= ccio-rm-dma.o
>  obj-$(CONFIG_IOMMU_CCIO)	+= ccio-dma.o
>  
>  obj-$(CONFIG_GSC)		+= gsc.o
> diff --git a/drivers/parisc/ccio-rm-dma.c b/drivers/parisc/ccio-rm-dma.c
> deleted file mode 100644
> index df7932af48b7..000000000000
> --- a/drivers/parisc/ccio-rm-dma.c
> +++ /dev/null
> @@ -1,202 +0,0 @@
> -/*
> - * ccio-rm-dma.c:
> - *	DMA management routines for first generation cache-coherent machines.
> - *	"Real Mode" operation refers to U2/Uturn chip operation. The chip
> - *      can perform coherency checks w/o using the I/O MMU. That's all we
> - *      need until support for more than 4GB phys mem is needed.
> - * 
> - *	This is the trivial case - basically what x86 does.
> - *
> - *	Drawbacks of using Real Mode are:
> - *	o outbound DMA is slower since one isn't using the prefetching
> - *	  U2 can do for outbound DMA.
> - *	o Ability to do scatter/gather in HW is also lost.
> - *      o only known to work with PCX-W processor. (eg C360)
> - *        (PCX-U/U+ are not coherent with U2 in real mode.)
> - *
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - *
> - * Original version/author:
> - *      CVSROOT=:pserver:anonymous@198.186.203.37:/cvsroot/linux-parisc
> - *      cvs -z3 co linux/arch/parisc/kernel/dma-rm.c
> - *
> - *	(C) Copyright 2000 Philipp Rumpf <prumpf@tux.org>
> - *
> - *
> - * Adopted for The Puffin Group's parisc-linux port by Grant Grundler.
> - *	(C) Copyright 2000 Grant Grundler <grundler@puffin.external.hp.com>
> - *	
> - */
> -
> -#include <linux/types.h>
> -#include <linux/init.h>
> -#include <linux/mm.h>
> -#include <linux/string.h>
> -#include <linux/pci.h>
> -#include <linux/gfp.h>
> -
> -#include <linux/uaccess.h>
> -
> -#include <asm/io.h>
> -#include <asm/hardware.h>
> -#include <asm/page.h>
> -
> -/* Only chose "ccio" since that's what HP-UX calls it....
> -** Make it easier for folks to migrate from one to the other :^)
> -*/
> -#define MODULE_NAME "ccio"
> -
> -#define U2_IOA_RUNWAY 0x580
> -#define U2_BC_GSC     0x501
> -#define UTURN_IOA_RUNWAY 0x581
> -#define UTURN_BC_GSC     0x502
> -
> -#define IS_U2(id) ( \
> -    (((id)->hw_type == HPHW_IOA) && ((id)->hversion == U2_IOA_RUNWAY)) || \
> -    (((id)->hw_type == HPHW_BCPORT) && ((id)->hversion == U2_BC_GSC))  \
> -)
> -
> -#define IS_UTURN(id) ( \
> -    (((id)->hw_type == HPHW_IOA) && ((id)->hversion == UTURN_IOA_RUNWAY)) || \
> -    (((id)->hw_type == HPHW_BCPORT) && ((id)->hversion == UTURN_BC_GSC))  \
> -)
> -
> -static int ccio_dma_supported( struct pci_dev *dev, u64 mask)
> -{
> -	if (dev == NULL) {
> -		printk(KERN_ERR MODULE_NAME ": EISA/ISA/et al not supported\n");
> -		BUG();
> -		return(0);
> -	}
> -
> -	/* only support 32-bit devices (ie PCI/GSC) */
> -	return((int) (mask >= 0xffffffffUL));
> -}
> -
> -
> -static void *ccio_alloc_consistent(struct pci_dev *dev, size_t size,
> -				 dma_addr_t *handle)
> -{
> -	void *ret;
> -	
> -	ret = (void *)__get_free_pages(GFP_ATOMIC, get_order(size));
> -
> -	if (ret != NULL) {
> -		memset(ret, 0, size);
> -		*handle = virt_to_phys(ret);
> -	}
> -	return ret;
> -}
> -	
> -static void ccio_free_consistent(struct pci_dev *dev, size_t size,
> -			       void *vaddr, dma_addr_t handle)
> -{
> -	free_pages((unsigned long)vaddr, get_order(size));
> -}
> -
> -static dma_addr_t ccio_map_single(struct pci_dev *dev, void *ptr, size_t size,
> -			  int direction)
> -{
> -	return virt_to_phys(ptr);
> -}
> -
> -static void ccio_unmap_single(struct pci_dev *dev, dma_addr_t dma_addr,
> -			    size_t size, int direction)
> -{
> -	/* Nothing to do */
> -}
> -
> -
> -static int ccio_map_sg(struct pci_dev *dev, struct scatterlist *sglist, int nents, int direction)
> -{
> -	int tmp = nents;
> -
> -        /* KISS: map each buffer separately. */
> -	while (nents) {
> -		sg_dma_address(sglist) = ccio_map_single(dev, sglist->address, sglist->length, direction);
> -		sg_dma_len(sglist) = sglist->length;
> -		nents--;
> -		sglist++;
> -	}
> -
> -	return tmp;
> -}
> -
> -
> -static void ccio_unmap_sg(struct pci_dev *dev, struct scatterlist *sglist, int nents, int direction)
> -{
> -#if 0
> -	while (nents) {
> -		ccio_unmap_single(dev, sg_dma_address(sglist), sg_dma_len(sglist), direction);
> -		nents--;
> -		sglist++;
> -	}
> -	return;
> -#else
> -	/* Do nothing (copied from current ccio_unmap_single()  :^) */
> -#endif
> -}
> -
> -
> -static struct pci_dma_ops ccio_ops = {
> -	ccio_dma_supported,
> -	ccio_alloc_consistent,
> -	ccio_free_consistent,
> -	ccio_map_single,
> -	ccio_unmap_single,
> -	ccio_map_sg,
> -	ccio_unmap_sg,
> -	NULL,                   /* dma_sync_single_for_cpu : NOP for U2 */
> -	NULL,                   /* dma_sync_single_for_device : NOP for U2 */
> -	NULL,                   /* dma_sync_sg_for_cpu     : ditto */
> -	NULL,                   /* dma_sync_sg_for_device     : ditto */
> -};
> -
> -
> -/*
> -** Determine if u2 should claim this chip (return 0) or not (return 1).
> -** If so, initialize the chip and tell other partners in crime they
> -** have work to do.
> -*/
> -static int __init
> -ccio_probe(struct parisc_device *dev)
> -{
> -	printk(KERN_INFO "%s found %s at 0x%lx\n", MODULE_NAME,
> -			dev->id.hversion == U2_BC_GSC ? "U2" : "UTurn",
> -			dev->hpa.start);
> -
> -/*
> -** FIXME - should check U2 registers to verify it's really running
> -** in "Real Mode".
> -*/
> -
> -#if 0
> -/* will need this for "Virtual Mode" operation */
> -	ccio_hw_init(ccio_dev);
> -	ccio_common_init(ccio_dev);
> -#endif
> -	hppa_dma_ops = &ccio_ops;
> -	return 0;
> -}
> -
> -static const struct parisc_device_id ccio_tbl[] __initconst = {
> -	{ HPHW_BCPORT, HVERSION_REV_ANY_ID, U2_BC_GSC, 0xc },
> -	{ HPHW_BCPORT, HVERSION_REV_ANY_ID, UTURN_BC_GSC, 0xc },
> -	{ 0, }
> -};
> -
> -static struct parisc_driver ccio_driver __refdata = {
> -	.name =		"U2/Uturn",
> -	.id_table =	ccio_tbl,
> -	.probe =	ccio_probe,
> -};
> -
> -void __init ccio_init(void)
> -{
> -	register_parisc_driver(&ccio_driver);
> -}
> 

