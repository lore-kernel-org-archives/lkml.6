Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbeEBHlp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:41:45 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:44913 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbeEBHlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:41:42 -0400
X-Originating-IP: 2.224.242.101
Date: Wed, 2 May 2018 09:41:33 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: hch@infradead.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sh: mm: Fix unprotected access to struct device
Message-ID: <20180502074133.GD17527@w540>
References: <1523972123-5700-1-git-send-email-jacopo+renesas@jmondi.org>
 <20180418104703.GA12462@infradead.org>
 <20180418131314.GC3999@w540>
 <20180420083147.GC31275@infradead.org>
 <CAMuHMdWwJrUgOjaAX1oUHd+KFUMuUzcH6g29zC2mJX377oAHiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sXc4Kmr5FA7axrvy"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWwJrUgOjaAX1oUHd+KFUMuUzcH6g29zC2mJX377oAHiA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sXc4Kmr5FA7axrvy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Christoph,

On Fri, Apr 20, 2018 at 11:59:13AM +0200, Geert Uytterhoeven wrote:
> Hi Christoph,
>
> On Fri, Apr 20, 2018 at 10:31 AM, Christoph Hellwig <hch@infradead.org> wrote:
> > On Wed, Apr 18, 2018 at 03:13:14PM +0200, jacopo mondi wrote:
> >> As long as it goes for arch/sh, the only user of dma_alloc_coherent()
> >> is platform_resource_setup_memory(), and it has been fixed by this
> >> patch.
> >
> > Great!
> >
> >> Unfortunately, as Thomas pointed out, there are drivers which calls
> >> into this with the wrong 'struct device' as the sh_eth one he had fixed.
> >
> > Yes, we'll need fixes there.  Other DMA ops implementations also look
> > at struct device, so they generally are buggy.
> >
> >> I would then say that as long as it goes for the NULL case, we should be
> >> fine now.
> >
> > Then I'd say skil that part, please.
>
> The major reason for keeping the NULL WARN_ON() checks is to make it
> obvious to the developer what is wrong, and fall back to the old behavior.
>
> Without the checks, the kernel will just crash during early startup,
> without a clue in the (missing) kernel output, usually leading to a
> frustrating bisection experience (if the developer is sufficiently motivated,
> at all).
>
> Hence my vote for keeping the checks.

Gentle ping as I don't see this patch being collected in v4.17-rc3

Thanks
   j

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

--sXc4Kmr5FA7axrvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJa6WutAAoJEHI0Bo8WoVY8CYYP/2N/7yrUnb3i7cWeEF1OFoLZ
nXYQlHzmWBkA011mxrHC4dtoJHv+i1N85amPAMHMs6teawOkIR2VCEwMPWr6vmY4
HegIHIdbf2Qlc14AzIMZ8P0t3BB9zLQoXkzT16saV+PMh019wXN8oD0q1vJBAmN/
I8eTCptil6FnhJrkGiuJuxzoSX1EdcFOyYC0AB6l1pMG+hc98V4JBphpA8WLTpc7
+S997xBY5Y/WF9K4IGCSdaSFCFcv3S3uTE2GjOIHnDwIKxAJhmsOWDs4xbmBXCWz
BMTi2llfa10o96WqBQi39CuKT7HcLbc6Oj0fEKm9U9YtF/CCs/vCLUkk6ZCDK2Nv
Sw3ZnQVZpv6V5Nltuk2mtqn+LqM9JzgjfN7slEnkC4JA8PgK+N/aW8wsnq/2e7QY
vJSeW3+FXiIrvRdgQbif4EgXLzAiYzyozbq6KG8KInuFvMo82u0BjTiz93e0F6XD
7udl060h3DfoXVmBVuKPVYpOhJgO+PTEVLm53lQzCucpOePgAflUs9XaTP9AxJ3O
PSdHIt3RF/Il8NqsDargaIQlq9L15rHYBfK2++zLuHbmrf36DPcRJBCEg0PGwCsY
RSkP+Tinfi3tV30oPtt3T9WeVlzumlqzCI4SiGKosouAdlU6A2LwpMCM1ZZBjUI/
mkHWCqa16xsN6SS7A9Es
=HPqX
-----END PGP SIGNATURE-----

--sXc4Kmr5FA7axrvy--
