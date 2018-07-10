Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FB6C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD320208F7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeuIa0rU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD320208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934518AbeGJQL1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:11:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934326AbeGJQL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:11:26 -0400
Received: from mail.kernel.org (host-091-097-077-058.ewe-ip-backbone.de [91.97.77.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFB3D208EB;
        Tue, 10 Jul 2018 16:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531239086;
        bh=dYV7IxwgWZrzHnh51CLlnN0eprKWCMENF4c8YRjOh3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MeuIa0rU19F3C2jq+Gsgohy+iXm+/MiMZINhCMGGUG0912HEyyAzOkQkusDrxR/ZK
         S+h6YplyYnt/YIJ69t8eqsPQ4SCIk+6ReAZf4U/Kzr9ihViscjS9+TpuwX2vtwCjff
         zHdyDlVFXki2m2YAkkoMbIZPczzyev/Um0HnvuWY=
Date:   Tue, 10 Jul 2018 18:11:23 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: Vibrations on Droid 4?
Message-ID: <20180710161123.azym6sbboriuj4yc@earth.universe>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pjjdrvyvlornavbl"
Content-Disposition: inline
In-Reply-To: <20180710133040.GA4391@amd>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pjjdrvyvlornavbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 10, 2018 at 03:30:40PM +0200, Pavel Machek wrote:
> On Tue 2018-07-10 12:11:47, Sebastian Reichel wrote:
> > On Tue, Jul 10, 2018 at 12:02:11AM +0200, Pavel Machek wrote:
> > > > > Do you have vibrations on d4 working?
> > > > > I believe I have required drivers enabled, but no luck:
> > > > >=20
> > > > > user@devuan:/sys/bus/platform/drivers$ ls pwm-vibrator/
> > > > > bind  uevent  unbind
> > > > > user@devuan:/sys/bus/platform/drivers$ ls omap-dmtimer-pwm/
> > > > > bind  uevent  unbind
> > > >=20
> > > > Have you checked probe deferrals?
> > >=20
> > > Not really. Is there easier way to do that than adding printks in the
> > > probe function? (I can go through dmesg tommorow).
> >=20
> > Option 1: https://lkml.org/lkml/2018/7/8/63
>=20
> I tried this methodq, and no luck.
>=20
> static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
>=20
> does not seem to be called.
>=20
> Its parent is gpio@4805d000 , and that one seems to be present.
>=20
> user@devuan:/sys/bus/platform/devices$ ls 4805d000.gpio
> driver				       driver_override  gpio
> gpiochip5  modalias  of_node  power  subsystem  uevent

Sorry, something went wrong with merging this. The parent
of ti,omap-dmtimer-pwm and pwm-vibrator should be / and
not gpio6.

-- Sebastian

--pjjdrvyvlornavbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAltE2qcACgkQ2O7X88g7
+prmDQ//fYdOhiJKqNKfdACiTKu/H8MJNIAbY3eT9V8YGglfH22NMK3SE2MScY++
qROZl4+VxGSjgci0juNFOnQYf7hoEyzCgeI6Uftmbbd4XI0ZtdzvHY5ldyaw/jqN
SJMarTieF9nZgiNyxOrtxxeMb3KCqdU9BipGuwq+0vvT0+hGDMLYMTFl4DT6+pQA
m6BhYFIiqyU43mKYW2WQ/CpOvMlJ+e6TAhODX8vhfC789H+LB2CHdHEF+sJLcz1i
ZueD1LNByGinubSworcsppqCmYN/sKj4x8SI8UYTaD+pmQ4uXmTC4n5DT5cGkwwY
4zPhd+lASWAxB0NRlNQHbSAiw8KC0w09jYhnJn9wRVXSww3/4Gcx+5HLigflh+KE
/6iYD9f/wcAj2+f9y+7GmLud95aYnAGbma0jLhAniZQ55adP3IUJjMlmKvQvpie3
l1y3qFE8YnlVIEsNo9AbDQKZWj+f1TzS9nj4sIht8AmJrOwfIiJUF4/u8reGlBca
r7EVdW6cU4wDi/XNsqASJbghapON4maesfNDYZZbj4egbbDL7OXQ6mp9vLz4Kr3F
+wF5oK/JguVGjKSNCDB2+lmcH4RReDC6pPFwD94HyLLdv3VseucPQ6BoOwA6zNzK
l+0PuBjzD4FY1Yadb+Ktv8c+i3683wX3t27B2A/da7sEt0NgUP4=
=+Uy2
-----END PGP SIGNATURE-----

--pjjdrvyvlornavbl--
