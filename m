Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6A8C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F525208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQUkuR3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F525208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751715AbeGJKLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:11:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751194AbeGJKLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:11:49 -0400
Received: from mail.kernel.org (host-091-097-077-058.ewe-ip-backbone.de [91.97.77.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2B25208E3;
        Tue, 10 Jul 2018 10:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531217509;
        bh=aP52NrIGRlvkrgHu/8rzzJvqWUS1U+7AtGQp3Uu76ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YQUkuR3BexCGij3VwuenUmtyK0JtRpYth/IKtnvtFhl1d+1/MZ+1XSTmMAD4K0JHz
         Yvq5CYs4iHOedhdMSfIWkZI+E2RB58o1mHd827zusWyBDvG51iheegwg1DXeAjRPoU
         ydANg65w6yjCgxuWGox3wMQbr27NmhbVMUs9Q/9o=
Date:   Tue, 10 Jul 2018 12:11:47 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: Vibrations on Droid 4?
Message-ID: <20180710101147.lyu65ro4czvrs2da@earth.universe>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="juvchcpv4cmkcawe"
Content-Disposition: inline
In-Reply-To: <20180709220211.GA7760@amd>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--juvchcpv4cmkcawe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 10, 2018 at 12:02:11AM +0200, Pavel Machek wrote:
> Hi!
>=20
> > > Do you have vibrations on d4 working?
> > > I believe I have required drivers enabled, but no luck:
> > >=20
> > > user@devuan:/sys/bus/platform/drivers$ ls pwm-vibrator/
> > > bind  uevent  unbind
> > > user@devuan:/sys/bus/platform/drivers$ ls omap-dmtimer-pwm/
> > > bind  uevent  unbind
> >=20
> > Have you checked probe deferrals?
>=20
> Not really. Is there easier way to do that than adding printks in the
> probe function? (I can go through dmesg tommorow).

Option 1: https://lkml.org/lkml/2018/7/8/63

Option 2: dynamic debug via kernel commandline (needs CONFIG_DYNAMIC_DEBUG)

dyndbg=3D"func deferred_probe_work_func +p; func driver_deferred_probe_add =
+p"

Option 3: use "initcall_debug" kernel commandline

-- Sebastian

--juvchcpv4cmkcawe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAltEhmIACgkQ2O7X88g7
+prj7g//V3Ho7P3qPttPGD6pDS8+fT3L7m/pAdUDJgD6NlS+qYpo0K2T53ulbEQR
Gz8yXGO2Jc4dJde0TSecJ3x6RvsVh6pHIkuOjiKnFGY058gJAgvhB4Mdu5xIEUNQ
DQRGxEF/Z3DgGYT1cHvqhyB1f2cstKgnQYYj6C7IJON+zmhz/K8IZIAN2jc3oh+r
KRQkcz+VJAmE/rTvuLmpzRPJVkM3j1qha7k7YyKa3wQqhphGDqw+COFaKnvYtHrr
xxU6QwlfwHjsuP0+6BJnJxkTE3VB/aCY5JtKEA2WpZT0ilUHe5OQYT7t+nC5NsF9
J4rD3wrMP7kVyLiIZZ1HWxOTIz2vwFNd1M4P4VJojct0cxPp0/koAqxP7kAr+XcZ
9Z39Ga/xY88bdGEgKyIAf851qum7c14ZTuTgfT+R1K+pxXtZ/bgf8+zHJeH8ih3v
/qUScG/RUYASFYGolbZTQvH5wBokcZWaYSzJFn91Jyp4BgVnJuX2kcQGZuRdUVrz
LxXu1r3ZCHTjVCEtYb92a88P0gkEtymb+W8FXmCBGbyZ3M86Z3m8Ka820ESPLO8P
vVRMZkpRK+cZNKX+ctLH3ZYJz4owq6W3Xi5WKg71/svnuJwxeRfc3EWo4a5gXTTb
CknG2gypxgvMEqDiMe0eFuB1i4P8hFGNV9g2bIjR2iJZpu1GtVU=
=rcYl
-----END PGP SIGNATURE-----

--juvchcpv4cmkcawe--
