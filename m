Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932439AbeCMRY2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751769AbeCMRY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:24:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B03204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Tue, 13 Mar 2018 17:24:02 +0000
From: James Hogan <jhogan@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org, david.daney@cavium.com,
        paul.burton@mips.com, Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Doug Ledford <dledford@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] MIPS: Allow including mach-generic/dma-coherence.h
Message-ID: <20180313172401.GI21642@saruman>
References: <1516758010-7641-1-git-send-email-f.fainelli@gmail.com>
 <1516758010-7641-2-git-send-email-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SdaPbLtAangIkrMZ"
Content-Disposition: inline
In-Reply-To: <1516758010-7641-2-git-send-email-f.fainelli@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SdaPbLtAangIkrMZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2018 at 05:40:09PM -0800, Florian Fainelli wrote:
> @@ -71,15 +83,19 @@ static inline void plat_post_dma_flush(struct device =
*dev)
>  #endif
> =20
>  #ifdef CONFIG_SWIOTLB
> +#ifndef phys_to_dma
>  static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t pad=
dr)
>  {
>  	return paddr;
>  }
> +#endif
> =20
> +#ifndef dma_to_phys
>  static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dad=
dr)
>  {
>  	return daddr;
>  }
>  #endif
> +#endif /* CONFIG_SWIOTLB */

FYI these were removed in commit ea8c64ace866 ("dma-mapping: move
swiotlb arch helpers to a new header"), and are only implemented by
platforms which select ARCH_HAS_PHYS_TO_DMA.

Cheers
James

--SdaPbLtAangIkrMZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqoCTEACgkQbAtpk944
dnr4XQ/+P/hlLOz1TJoV4zY10qxuWZQskRFZREwiQ7TvPMdAlNnf546QZ0IRZebd
rFjjiJW3cKPTy/Fdr6lCXxvZRS/KBuIqWec4D0UbPoKTJQQO+lxxzqzuLEET4MAi
jdiSqIbRLrCpD1owEU6pcqjbP8dblKwwRowxlORATh8VB0Pxolj7dM6m6NUFQfA2
zAsJLFxVHScqaiPYbM+UzLXPgYTs2TrllDqZZn+68hiq68KEhOaxTTJ6Pn9GkKZy
rE2oPPS2gVNczM/snhZ6SCcB3YAngVCzjeHd0EbFSB0a744d2sByQ4bxu/0CWcrX
w/Pvnar9FW4zqIdhitc5sXBKajhk4F6jhHscpLedSyXbttHHBflMQVXZOxx2WXzt
Zl8cQC5WPioNv1d0GT5bR+MLCpEu4z+hJD3SvJp3jC80K9wtSzDYsv0jN/kMkr9G
Eo1nTjUfaaA6MDPkIh5BnY26Gt3UgMDSHmOPqy+Uwuhi45k5y+/k2zairKrNobcv
5uC4dOMcmgN4CMl5hBwfNXgRYfjkLtUD7+9rqYV2LW8vNOI/69v+HtyOSDMQmlS9
qiOZFXNhzp7CodhARzy8nE3mBDgSGFaXIAcBILKkCZXKGpjv1oFzFs0YxTXM4NKU
qwHASZP6hpxqMLRmQBNQ3QxnpZumA822ibJeGjuTD7EUUv1MYDg=
=l0CC
-----END PGP SIGNATURE-----

--SdaPbLtAangIkrMZ--
