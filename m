Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9F0C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FA82082D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05FA82082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeJ2HQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 03:16:44 -0400
Received: from sauhun.de ([88.99.104.3]:58166 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbeJ2HQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 03:16:44 -0400
Received: from localhost (unknown [87.113.172.131])
        by pokefinder.org (Postfix) with ESMTPSA id 29AA44A1CA7;
        Sun, 28 Oct 2018 23:30:42 +0100 (CET)
Date:   Sun, 28 Oct 2018 22:30:41 +0000
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 1/2] i2c: Remove unnecessary call to irq_find_mapping
Message-ID: <20181028223041.GI1882@kunai>
References: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N8NGGaQn1mzfvaPg"
Content-Disposition: inline
In-Reply-To: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N8NGGaQn1mzfvaPg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 19, 2018 at 09:59:57AM +0100, Charles Keepax wrote:
> irq_create_mapping calls irq_find_mapping internally and will use the
> found mapping if one exists, so there is no need to manually call this
> from i2c_smbus_host_notify_to_irq.
>=20
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Adding Benjamin to recipients. He wrote that code.

> ---
>  drivers/i2c/i2c-core-base.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index dc78aa7369def..656f0a6fe3adf 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -306,10 +306,7 @@ static int i2c_smbus_host_notify_to_irq(const struct=
 i2c_client *client)
>  	if (client->flags & I2C_CLIENT_TEN)
>  		return -EINVAL;
> =20
> -	irq =3D irq_find_mapping(adap->host_notify_domain, client->addr);
> -	if (!irq)
> -		irq =3D irq_create_mapping(adap->host_notify_domain,
> -					 client->addr);
> +	irq =3D irq_create_mapping(adap->host_notify_domain, client->addr);
> =20
>  	return irq > 0 ? irq : -ENXIO;
>  }
> --=20
> 2.11.0
>=20

--N8NGGaQn1mzfvaPg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvWOJEACgkQFA3kzBSg
KbagOhAAsm8E83F7oPrDcOxo+n00svnBOyKabHf018H1ul/LfQZy1auyduSu5Y3H
aC1cPdkvU8uzCPwhWVz7iZ0MHvsGZMR5lZ6NRHnWA5fAmV1kezMqSJBNzw71mmhh
3+6qoCLMZHsKn64GeYsujiXpf6GtcgAhBtBgAsHh2iAgdZ8rr52C6jccy8KqQOVC
osPOsFHnq0RHobiVKjb2vfMpIy80JxHJGz/nx5RnOxvGNLP7fVw3jsY2YKE2JFnH
/xSa4MWxVb6K1fDoCe8fvsauCKZk5YVPNtxMbnjA+kbKhWYAgAu7tEBC+4KDOwbP
gVh4O858N6LyP3Mq0G0ZkUC66OfCIIQ1X6ceItu2SV/kSJyDaWi2aqOeBr6dF/nl
4zsqTo3EZ6JO0Ub09KViU9WYtbFbLiR/rfSpfF62d6j4LqjAVYan3epXB38QRwUk
NzVNssUBWaOMgZtJFVWIkxLy5ci3rGbx3s5VyamY/T3W4XhNW5l/Nud3vs8+OFav
HLfwdc5NXk1uaBic7KL54rJXT0eqXFTFCAvZw2orhmB12GRaN42NvCSfEhtwr6p8
tkcSWSgVOO2EuVDckPWuT8pGD3cbzVkG5x2IOOVWp+rgzb8EgDEvVz+pqSVr73M9
pf0F+6/f8pmMdIFpppmV+RwoRr3Ao56QhK6p198FKX4Wf5qnJbQ=
=d8BD
-----END PGP SIGNATURE-----

--N8NGGaQn1mzfvaPg--
