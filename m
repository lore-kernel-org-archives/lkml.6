Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD05C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B2A208E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgmgXF6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B2A208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeHWBDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 21:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbeHWBDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 21:03:37 -0400
Received: from mail.kernel.org (unknown [185.216.33.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAD80208D4;
        Wed, 22 Aug 2018 21:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534973821;
        bh=uc0ccGUfBRxxy0X9RNJsScO+mgwaSluUvUUU51ZW2KU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sgmgXF6nFM9FQrOaHVdVp1271a0+Uk/cErmBWdg7fzFeHmgBhmHIPvjbYZkXdg9T9
         l5Cqqp2ymbKEFu6drVBD0MFLEUr27yc54NZ2zGwx+gUDOMJx98sz2onD1OephPcoIu
         9XdOrqMOAr9o+NJLLt7RjYXCwVY7tIY+Z2x/7vXI=
Date:   Wed, 22 Aug 2018 23:36:58 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>, NeilBrown <neilb@suse.de>,
        Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 9/9] power: supply: twl4030-charger: fix OF sibling-node
 lookup
Message-ID: <20180822213658.uuzsalnlxbayc4ml@earth.universe>
References: <20180822105547.9634-1-johan@kernel.org>
 <20180822105547.9634-10-johan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kfx3tqsq374xuhtg"
Content-Disposition: inline
In-Reply-To: <20180822105547.9634-10-johan@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kfx3tqsq374xuhtg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 22, 2018 at 12:55:47PM +0200, Johan Hovold wrote:
> Use the new of_get_compatible_child() helper to lookup the usb sibling
> node instead of using of_find_compatible_node(), which searches the
> entire tree and thus can return an unrelated (non-sibling) node.
>=20
> This also addresses a potential use-after-free (e.g. after probe
> deferral) as the tree-wide helper drops a reference to its first
> argument (i.e. the parent device node).
>=20
> While at it, also fix the related phy-node reference leak.
>=20
> Fixes: f5e4edb8c888 ("power: twl4030_charger: find associated phy by more=
 reliable means.")
> Cc: stable <stable@vger.kernel.org>     # 4.2
> Cc: NeilBrown <neilb@suse.de>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Reviewed-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>  drivers/power/supply/twl4030_charger.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/suppl=
y/twl4030_charger.c
> index bbcaee56db9d..b6a7d9f74cf3 100644
> --- a/drivers/power/supply/twl4030_charger.c
> +++ b/drivers/power/supply/twl4030_charger.c
> @@ -996,12 +996,13 @@ static int twl4030_bci_probe(struct platform_device=
 *pdev)
>  	if (bci->dev->of_node) {
>  		struct device_node *phynode;
> =20
> -		phynode =3D of_find_compatible_node(bci->dev->of_node->parent,
> -						  NULL, "ti,twl4030-usb");
> +		phynode =3D of_get_compatible_child(bci->dev->of_node->parent,
> +						  "ti,twl4030-usb");
>  		if (phynode) {
>  			bci->usb_nb.notifier_call =3D twl4030_bci_usb_ncb;
>  			bci->transceiver =3D devm_usb_get_phy_by_node(
>  				bci->dev, phynode, &bci->usb_nb);
> +			of_node_put(phynode);
>  			if (IS_ERR(bci->transceiver)) {
>  				ret =3D PTR_ERR(bci->transceiver);
>  				if (ret =3D=3D -EPROBE_DEFER)
> --=20
> 2.18.0
>=20

--kfx3tqsq374xuhtg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlt913cACgkQ2O7X88g7
+pqSrhAAgJWkbj4ZZr0TfSV4uMcPbTetTFIezbONmXZrVGme1CcgxsR7F36fJT+M
JSSj5+MyASYbc7O9eLRThkq3t05SHu7jf9WdV8pwEgHdHLJPGalIrWpmK5i4SxOc
d4m/S075tKYqTQEo2tMNzsdQAMBMU+2QYDc/Q5aBEW73Iyqww098rMZsgPEykF9q
G4Mk3gpu/GY46W6grbQKLWPpBX3bN5lRM/5Vz9rbZGj39AUqAnAWHmZU24USTnVg
AjOcZZ3kyZqRx+Lu5dpqhzmpsD5g7ZQ3DrYzJqZvlCvPC1gn+L9FbXKwuubMHbZ2
qhC6vwWNNGry/OwnfsbGNcWweX2O3JN7aWFgTSnpRGvAQeZB1GF7GIJG966oLpwW
11lGN5G0qqf+6e5OhCPs1oCM1n9i2en6Env65bIBOp3Pe0VHr58UcLs/7EFa7Mu6
5bOFFfCqr65XtHw5lm0LLRAy8XDLhHKFF7eLj6zCiKeafdxW4Ey/H9ACW48GpybB
1cQzWtYueiqDeCtrVYPBEtZPuNSp6R6pvsDGu/AFV/tjkVRP6F2IuM2LWlYC5YKB
zwEA87iPBp6trkSoc0b495FAbKkc6/hl44wVTzPip6p9ZEraGOFpzQLWl5wAMN43
ambgNNO72a6H+QTnYcpnKt78RwzAYIBugyOG4V+9wL69YK8iOZs=
=FeKy
-----END PGP SIGNATURE-----

--kfx3tqsq374xuhtg--
