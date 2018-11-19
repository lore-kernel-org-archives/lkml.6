Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0723C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7325B20870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7325B20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbeKSV1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:27:48 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41732 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeKSV1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:27:48 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 97A818084E; Mon, 19 Nov 2018 12:04:26 +0100 (CET)
Date:   Mon, 19 Nov 2018 12:04:28 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH] slab.h: Avoid using & for logical and of booleans
Message-ID: <20181119110428.GE28607@amd>
References: <20181105204000.129023-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="N1GIdlSm9i+YlY4t"
Content-Disposition: inline
In-Reply-To: <20181105204000.129023-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N1GIdlSm9i+YlY4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-11-05 12:40:00, Bart Van Assche wrote:
> This patch suppresses the following sparse warning:
>=20
> ./include/linux/slab.h:332:43: warning: dubious: x & !y
>=20
> Fixes: 1291523f2c1d ("mm, slab/slub: introduce kmalloc-reclaimable caches=
")
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Roman Gushchin <guro@fb.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  include/linux/slab.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 918f374e7156..97d0599ddb7b 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -329,7 +329,7 @@ static __always_inline enum kmalloc_cache_type kmallo=
c_type(gfp_t flags)
>  	 * If an allocation is both __GFP_DMA and __GFP_RECLAIMABLE, return
>  	 * KMALLOC_DMA and effectively ignore __GFP_RECLAIMABLE
>  	 */
> -	return type_dma + (is_reclaimable & !is_dma) * KMALLOC_RECLAIM;
> +	return type_dma + is_reclaimable * !is_dma * KMALLOC_RECLAIM;
>  }
> =20

What is wrong with && ? If logical and is better done by multiply,
that's compiler job, and compiler should be fixed to do it...


									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--N1GIdlSm9i+YlY4t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvymLwACgkQMOfwapXb+vILgACcCPHGg2P5wRydP+BaXyQGRzcL
OXEAn28w7pdr0BinOx/fa+Yokkt4fC4X
=Uw60
-----END PGP SIGNATURE-----

--N1GIdlSm9i+YlY4t--
