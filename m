Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeDIHZ4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 03:25:56 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46065 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbeDIHZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 03:25:54 -0400
X-Originating-IP: 158.255.198.50
Date: Mon, 9 Apr 2018 09:25:47 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, ysato@users.sourceforge.jp,
        dalias@libc.org, laurent.pinchart@ideasonboard.com,
        geert@linux-m68k.org, linux-renesas-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org
Subject: Re: [RFC v2 2/2] base: dma-mapping: Postpone page_to_pfn() on mmap()
Message-ID: <20180409072547.GU20945@w540>
References: <1510679286-6988-1-git-send-email-jacopo+renesas@jmondi.org>
 <1510679286-6988-3-git-send-email-jacopo+renesas@jmondi.org>
 <ea4f2d82-6a27-a7c1-091f-6230cfd988a3@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8a48p4KKsB+A/3VY"
Content-Disposition: inline
In-Reply-To: <ea4f2d82-6a27-a7c1-091f-6230cfd988a3@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8a48p4KKsB+A/3VY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Robin, Laurent,
    a long time passed, sorry about this.

On Wed, Nov 15, 2017 at 01:38:23PM +0000, Robin Murphy wrote:
> On 14/11/17 17:08, Jacopo Mondi wrote:
> >On SH4 architecture, with SPARSEMEM memory model, translating page to
> >pfn hangs the CPU. Post-pone translation to pfn after
> >dma_mmap_from_dev_coherent() function call as it succeeds and make page
> >translation not necessary.
> >
> >This patch was suggested by Laurent Pinchart and he's working to submit
> >a proper fix mainline. Not sending for inclusion at the moment.
>
> Y'know, I think this patch does have some merit by itself - until we know
> that cpu_addr *doesn't* represent some device-private memory which is not
> guaranteed to be backed by a struct page, calling virt_to_page() on it is
> arguably semantically incorrect, even if it might happen to be benign in
> most cases.

I still need to carry this patch in my trees to have a working dma memory mapping
on SH4 platforms. My understanding from your comment is that there may
be a way forward for this patch, do you still think the same? Have you
got any suggestion on how to improve this eventually for inclusion?

Thanks
   j

>
> Robin.
>
> >Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >---
> >  drivers/base/dma-mapping.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
> >index e584edd..73d64d3 100644
> >--- a/drivers/base/dma-mapping.c
> >+++ b/drivers/base/dma-mapping.c
> >@@ -227,8 +227,8 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
> >  #ifndef CONFIG_ARCH_NO_COHERENT_DMA_MMAP
> >  	unsigned long user_count = vma_pages(vma);
> >  	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> >-	unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
> >  	unsigned long off = vma->vm_pgoff;
> >+	unsigned long pfn;
> >
> >  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> >
> >@@ -236,6 +236,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
> >  		return ret;
> >
> >  	if (off < count && user_count <= (count - off)) {
> >+		pfn = page_to_pfn(virt_to_page(cpu_addr));
> >  		ret = remap_pfn_range(vma, vma->vm_start,
> >  				      pfn + off,
> >  				      user_count << PAGE_SHIFT,
> >--
> >2.7.4
> >
> >_______________________________________________
> >iommu mailing list
> >iommu@lists.linux-foundation.org
> >https://lists.linuxfoundation.org/mailman/listinfo/iommu
> >

--8a48p4KKsB+A/3VY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJayxV7AAoJEHI0Bo8WoVY8poQP/RLuihAmfxnsaF8Y5vpyWWQT
GS7+W9OGNVGOn8IeMsp0Lq+GSpzqHVd8o18/06m1Cp+4KIzhgbGrOPpSHBZ4qMON
oi98PJHrMWxIqzgSt/ejjXQ70USkEAOfv4tMZ8R8QnzFcOZ4Ka/ppoH2JuSzb0E5
XCKfgkqFu7VyT5cQCERb0+orAVmj5w4vpglIr6igE0UTh0XjubXqtIxFitH3qmdw
cnboVo3SH7eTLTDzSWdOPUi0aPRditdbHOpencmWpwtKQRAwFx7xwtefWkrML+dT
n8Ygl0VOk+B5zYlb1JMCmX1/btaxOl9P7wDI0IkUwuEY3S7ZWmpzoWnlw/Fzbnlb
wWoEmTLuM514Qd9UTB98hDqpsZhe5D/Zo7kExHAU+peucxUyfZ6g2q1mwrDYwUY+
BP78VWaQc4lHQZ9xBGkHgaXzmVHjmEjXFWe+L/3z1iGmngYdR4/b5Dhfw1GXT6mt
PHcliy3AbgHT/wr55WBCEB2+xdl7tChdv/Hl2x89kDqkRXFnS+uWsIJ4qd4U0DIy
oDb/6g4TAbGV7j/k3gEQT4MkclRYrv/rlDVyYZrGIWn6oX8iDieVLoJSa2mNa59K
sAWLR3Ca+vLaGI+WOn+8mvg0ZxW4Wywi5xwiru98RVPHI1CxGQGL1Hm3ayyK/K+F
H2NKjX9Nm20Zg0HDf/oh
=MB4Z
-----END PGP SIGNATURE-----

--8a48p4KKsB+A/3VY--
