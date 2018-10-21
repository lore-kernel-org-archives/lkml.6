Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FC8ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B200C2083A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aU+ZYMhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B200C2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbeJVDti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 23:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbeJVDth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 23:49:37 -0400
Received: from earth.universe (unknown [62.214.5.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6716B2082C;
        Sun, 21 Oct 2018 19:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540150455;
        bh=fohdCAR35YFwNPSVEMNzRGl6jbUtEc2hJ7YGypZ5zxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aU+ZYMhH57lQLKjUTnQD/InW037xnvUHHk7Dv7cQTbQNKRJ79glKkhDQrgn83v6CZ
         mgEwLaf7soGqUIxT1HzO2OFagN2ELOXBS6eVn4n7Oak5OyTkWhvNaGOkNIkldUIKwU
         t/8dKK12GG0jVcO2BFbvJomnwBV0/QG4G/CNFFGs=
Received: by earth.universe (Postfix, from userid 1000)
        id C4D7D3C098C; Sun, 21 Oct 2018 21:34:13 +0200 (CEST)
Date:   Sun, 21 Oct 2018 21:34:13 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: max8925: mark expected switch fall-through
Message-ID: <20181021193413.6w7x4rvx4xkyeyaw@earth.universe>
References: <20181004135636.GA15157@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5why2j2ejhabe252"
Content-Disposition: inline
In-Reply-To: <20181004135636.GA15157@embeddedor.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5why2j2ejhabe252
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 04, 2018 at 03:56:36PM +0200, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>=20
> Addresses-Coverity-ID: 201510 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/max8925_power.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/supply/max8925_power.c b/drivers/power/supply/=
max8925_power.c
> index 3b94620..39b4d5b 100644
> --- a/drivers/power/supply/max8925_power.c
> +++ b/drivers/power/supply/max8925_power.c
> @@ -124,6 +124,7 @@ static irqreturn_t max8925_charger_handler(int irq, v=
oid *data)
>  	case MAX8925_IRQ_VCHG_THM_OK_F:
>  		/* Battery is not ready yet */
>  		dev_dbg(chip->dev, "Battery temperature is out of range\n");
> +		/* Fall through */
>  	case MAX8925_IRQ_VCHG_DC_OVP:
>  		dev_dbg(chip->dev, "Error detection\n");
>  		__set_charger(info, 0);
> --=20
> 2.7.4
>=20

--5why2j2ejhabe252
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvM1LUACgkQ2O7X88g7
+pqg5Q//ecxAFxAcMfEjXPAUNEyfetJvuk22LHz3gu9SsPbweu7k3/bF/eErlEAe
458haowS+dg7GNiymqIVH+Qe7n5sAV+x/GxCN8w6J8q35lR+Z8Q0iVc3nssfnIqG
3AEyUHgWmgZpZacrGIjoluGceu3mfaSC+eGYNnvIO0biWmukWEvde9AnuZBC2N3j
/0YSpdDOclVYk9+3eeAxQC/D2RE6rczbEaYGyyncixohlcFcGKv72/SRNRFj3NOY
v5rFjmt1ABilVQyf8o2xv4LOMHcq/+9Rk7O8HE3CNa2XP6zdlcVPmc6B4l3aO0Dv
6CrDbiO9k8l6jUbN9wPLQYAtaImoGL/bhVW84URU4CCWLfIBvzlAofIqzOpv4ICP
YQrgwgvAzPo7xK/NXL17gYq59es0bT2n/UYtmitA6Q/Yv69ZaZhKHvRIvg7gOAtF
kmt1PMiA7neU3gqIBfXMZ2+Fe9LrdkulxeJIqPtAYDD9D651/6hcfD/Ml4u/eQ8i
50ehgX2ASHfTKZkaDcCFLrztUuAsTkQSpb5vIFVm3A787Fa0NtqgbSqxovt0gYBx
1tQdkTQC2vhPKKkGv9aoqMnU/VuwqBIcRuVUzpegp00tAHEAviEIYPO3iFf+DuUp
VT95IPWnTs5uqgMrjaZ4UQ5OXkDpd/wCi7pPHx9zugqiUs53c0M=
=oRPN
-----END PGP SIGNATURE-----

--5why2j2ejhabe252--
