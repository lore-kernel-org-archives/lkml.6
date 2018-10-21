Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96031ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF5C20658
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="psOjuuoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF5C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbeJVDm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 23:42:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728088AbeJVDm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 23:42:28 -0400
Received: from earth.universe (unknown [62.214.5.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98BC92083E;
        Sun, 21 Oct 2018 19:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540150027;
        bh=ye1UdEZn3AUISRD9R869LkGTca/aciSUVnPUccbr68E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=psOjuuoWo7JFNgPS1wkNXUHJ8xKF5oeCqGjrO3hD9dfLUDsU5qd11z+HIpXwthFsa
         0o9aHKhB9ehHGexEpMIUccRxP8b9P+7vATcyMbHR0TF5xayMbl1H82QNsv3BrAbaqq
         QqvYHuKZLng2oKMTGCJM3qO12T/J9NtYwT99vshU=
Received: by earth.universe (Postfix, from userid 1000)
        id 954223C098C; Sun, 21 Oct 2018 18:21:39 +0200 (CEST)
Date:   Sun, 21 Oct 2018 18:21:39 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: Re: [PATCH v5 1/6] dt-bindings: power: Introduce one property to
 present the battery internal resistance
Message-ID: <20181021162139.4nr5j6vztbcpt6ak@earth.universe>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="buyipfsg5mgqpdut"
Content-Disposition: inline
In-Reply-To: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--buyipfsg5mgqpdut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 19, 2018 at 06:53:10PM +0800, Baolin Wang wrote:
> The internal resistance of a battery is not a constant in its life cycle,
> this varies over the age of the battery or temperature and so on. But we
> just want use one constant battery internal resistance to estimate the
> battery capacity. Thus this patch introduces one property to present
> the battery factory internal resistance for battery information.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Looks good to me.

-- Sebastian

> Changes from v4:
>  - None.
>=20
> Changes from v3:
>  - Split binding into one separate patch.
>  - Add LinusW reviewed tag.
>=20
> Changes from v2:
>  - Rename the property.
>  - Improve the commit message.
>=20
> Changes from v1:
>  - New patch in v2.
> ---
>  .../devicetree/bindings/power/supply/battery.txt   |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b=
/Documentation/devicetree/bindings/power/supply/battery.txt
> index f4d3b4a..938d027 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -22,6 +22,7 @@ Optional Properties:
>   - charge-term-current-microamp: current for charge termination phase
>   - constant-charge-current-max-microamp: maximum constant input current
>   - constant-charge-voltage-max-microvolt: maximum constant input voltage
> + - factory-internal-resistance-micro-ohms: battery factory internal resi=
stance
> =20
>  Battery properties are named, where possible, for the corresponding
>  elements in enum power_supply_property, defined in
> @@ -42,6 +43,7 @@ Example:
>  		charge-term-current-microamp =3D <128000>;
>  		constant-charge-current-max-microamp =3D <900000>;
>  		constant-charge-voltage-max-microvolt =3D <4200000>;
> +		factory-internal-resistance-micro-ohms =3D <250000>;
>  	};
> =20
>  	charger: charger@11 {
> --=20
> 1.7.9.5
>=20

--buyipfsg5mgqpdut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvMp4sACgkQ2O7X88g7
+prRKQ/+I4JhijYPh+yUYarxP0GvbDOiCWU15l1dKSkBHcAOxBIEqx2LavMKzp6I
X8nEeSovUB1l/8GJrClT5PTy218OCn5LfwQPl0Aphyi0DXIiWLlxk2COVKdXRgE6
hZAg6mUoU4eQfSHRa2Tfbuw1y3XjScjCSBNbau5yQpc3uH2sQf2nAJIZs/zgrssa
UUz5Ode2oSB93GNzWRrHfSO5LyaT8CiYYdUCzGjmLMk3AMxUTT7aMb2MM1Urn6Oe
4YCCyg+BQL2svFGTPYG9mHOR+TNP9K3eSkex2MTYfhqAdFv/HI3/hDsixkG/lR1c
1hFsOoWP2q0ZdDSIo4FC/H73PSDkuwFhJVj4GrW+e2b+GfqMvu8yviVuLdtR2K0V
am5cgWjdDPNq3xfuoNap5xN8eLcfF4QvxzgxbTeS6mE7uVr1Uq7JZnVgYgt+XP+K
7L4bs+pnVhBJxLPetqOVjgczNI7Fx+ADIHheARfp6a/mZEZRmDBZr80JoTidOwjA
T9tDYv+bzOF9Y9kBOe/az68C6Z84/m2ADfw4H8E0EDb+V6yNrMtkZ3a9blIiN5xu
EqsXqutVxf7qSd4Ao2d5ICGIDek4RqG1ZXRoajOggUUacgydCP5YEEd0BBRfEZnY
qq6XF0s4JvdC2Iy0Q1kziaMSdMg7KcdNsPperzfU3UNOLAd3xFg=
=DLLA
-----END PGP SIGNATURE-----

--buyipfsg5mgqpdut--
