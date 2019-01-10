Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2302C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941E7214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547122084;
	bh=GHlPz/F7miCS2CBeWT25aeoKwH5qAAu0cROnDiz7ak8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bu6cep6XjfHtukB3nOS/fbfeFg5cheoMzmzyTPiz1rluJYuDBau0oanmVCCz+O16h
	 HGGYU3WdS7R+EZjxWs/PkYIN7E29a8f5ziJzJymWt9pYLpCLddku+7rkClGWUDrDK+
	 TLk/CB0+P9AusjQn9Hr5Nyzol7f8sa7pYFilkR+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfAJMID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:08:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbfAJMIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:08:01 -0500
Received: from earth.universe (host-091-097-085-127.ewe-ip-backbone.de [91.97.85.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4CBB2173B;
        Thu, 10 Jan 2019 12:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547122080;
        bh=GHlPz/F7miCS2CBeWT25aeoKwH5qAAu0cROnDiz7ak8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kfZDSk3GxBeQXp9ULU20zlEK1X04co5Ff1cq3dvTe6RYb0N1r0tCDLyDcyThL8Vh6
         HBakn/AJxjqqZ35dBiwb1bU6Wc2SxKLRpNOdwKjZ4LUU4wFciTaGNGQBfg8+NlL/X5
         MCF44cZ1LDJPzO9cR+vUli87g96QuusWt5aQT8ZY=
Received: by earth.universe (Postfix, from userid 1000)
        id 613833C08E2; Thu, 10 Jan 2019 13:07:58 +0100 (CET)
Date:   Thu, 10 Jan 2019 13:07:58 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Vignesh R <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] serial: 8250_omap: Drop check for of_node
Message-ID: <20190110120758.bz63neey5ztepw4m@earth.universe>
References: <20190109091206.25759-1-vigneshr@ti.com>
 <20190109091206.25759-2-vigneshr@ti.com>
 <20190109214403.GW5544@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u5tx4nodvh2iwfgy"
Content-Disposition: inline
In-Reply-To: <20190109214403.GW5544@atomide.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u5tx4nodvh2iwfgy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 09, 2019 at 01:44:03PM -0800, Tony Lindgren wrote:
> * Vignesh R <vigneshr@ti.com> [190109 09:11]:
> > 8250_omap is DT only driver so dev->of_node always exists. Drop check
> > for existence of valid dev->of_node to simplify omap8250_probe().
>=20
> That part seems safe to me now.
>=20
> > --- a/drivers/tty/serial/8250/8250_omap.c
> > +++ b/drivers/tty/serial/8250/8250_omap.c
> ...
> > -		const struct of_device_id *id;
> > -
> > -		ret =3D of_alias_get_id(pdev->dev.of_node, "serial");
> > -
> > -		of_property_read_u32(pdev->dev.of_node, "clock-frequency",
> > -				     &up.port.uartclk);
> > -		priv->wakeirq =3D irq_of_parse_and_map(pdev->dev.of_node, 1);
> > -
> > -		id =3D of_match_device(of_match_ptr(omap8250_dt_ids), &pdev->dev);
> > -		if (id && id->data)
> > -			priv->habit |=3D *(u8 *)id->data;
>=20
> But this part it seems we still need to keep around
> as we still have lots of clock-frequency references
> in the *.dtsi files. Or am I missing something?

It's re-added a couple of lines later. Only the indent was removed.

-- Sebastian

--u5tx4nodvh2iwfgy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlw3NZsACgkQ2O7X88g7
+pr5IBAAhmNLhHoG54gdNETgXhIRD+prbisTAvMlT5EQjZRR0o0X//uoTI8Hw+Z6
Yh46FgkTU7rj++fpvAHfSbSOsMLklT7dsU6r8OQqc/4szPAoJPa+Fp2eDi3QOQKo
f12NEqD42+i2R4Ah789ctstIek5z0YIBL4dK92ubKbEHSqMp0/u214+JHGnVM7Jx
Zw5r+ibBYPjMEU8xVKe3993mEU5MyTQhOlRSSMBwiDcxqyckle+IUZugr91lr0dG
Mluv1LK7wupwbk/a/YD7gagiZN2kuyXRzwxE6J/hRHl1wchj4ald2SRvmxYUpEW/
6BtldqSPd3HDsxRwxYhfztg9JIJZy1zDYILTRT93bKH3SHQTUcBP+JNva69zVik6
BeV6kLfXo47dSv2GGK4HcGD4Ryggh6P7UyrP3seFg7FM5LS7a9fSPPEONoWyt5ew
1WUNusbG0/VK9XMpo3lWBL3xEg0mSUO0Ov+9sKCHQcNQhZIAqJb9i4SSbe9dCoOa
rJ5pRG54NHOZQAX2JcWSur54kDNGAVcHT4tyApGmrtqAbIOe6cAFopKPJ7mzD8uj
Od5/QGcmSPg1YDaT+NPniXTc95dwK0JIOy4C5mXR7mUE0L30tvj8MwXyBYJZXj2b
4qLnkr0hJRKkOblwysOSqeCPCMcO6sF+0qPiQg9uBesI3FvPUWg=
=kRf9
-----END PGP SIGNATURE-----

--u5tx4nodvh2iwfgy--
