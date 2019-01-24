Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10E3C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07E3218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWD3gGH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfAXQSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:18:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35085 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfAXQSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:18:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so7143952wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 08:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sYJTsT1RU7rp0EKLZakMYovq4zo9XGQWDwMfwBAoYJ0=;
        b=aWD3gGH5jLW4lpZHPE3UJi7CepRnoc9cd7EA/Cp6wTGVldfjpA3WRMLoetfKxHggn5
         HZCrphImG2MedkTVB6iSrGFCZ9DvG0ic+X11RZchpzRJtjuhx4S5vZEG1IV8so7rPp4a
         zqVy+DFkrntbCDHBZQEEBEgacmaWJJbBQpqJOWWjWkFri8+8CXHotybFYIaI8ozhi2y1
         uwJHC+SXhX9Sz9PNm7xdWC5kJhbgWxg9z6CBPuHfa9Y0S756SClbW1/1cSWU035oqTCz
         LzXpxvv/Rm484kbzeg5rQoFR47Z763QJ6/oY4li2cI8qsY64+U2IuKbYPD34uuSYxdgu
         QWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sYJTsT1RU7rp0EKLZakMYovq4zo9XGQWDwMfwBAoYJ0=;
        b=MOOvue0ZkYXlNYSocm3IU6M5emKzeYOsSGXPa9zvsCafCx1lj05KUQ4njywu0m0irN
         N/zxQ/dGmF438g8QI7yzGj/Z22TFb0il13TFFZUb30BI78svB+Mc9KfoA7+TR+C9pIBZ
         Tc7z9mSdEJbFj28k+jN3Wrw2deu5SkuEowkWi0BVkpzBJuSgCWPkbG5tLxhMp6wd1ZWc
         ztWoqUEeJEXXTsNKniJlZDoArY6ihBcXVz9/rFv4wraKL0ArFmcwcaIPYRFXOVE2SDTv
         q2pnD05e52A/Kvn2effAdzurcBwjq3X+O9ergG4zUAveQ1+bifytdCE10rvKfNPe/HFW
         Cv8A==
X-Gm-Message-State: AJcUukfyfPpcoLSClkoNu8MCPc0RsgX1CVzmjJjeU4pHd6KozMZ1gZEG
        vR1SXMY7vUuEr+gPB1Qev5g=
X-Google-Smtp-Source: ALg8bN6A09hT1y9GIvgt9Feh1t+ed7rDbHVhBPWzGdi41zyZmOV93k9aBDmXg28ReRD1G6cBdQ6oiA==
X-Received: by 2002:a5d:5443:: with SMTP id w3mr7354699wrv.4.1548346694601;
        Thu, 24 Jan 2019 08:18:14 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id y34sm269123096wrd.68.2019.01.24.08.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 08:18:13 -0800 (PST)
Date:   Thu, 24 Jan 2019 17:18:12 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        padovan Gustavo <gustavo.padovan@collabora.com>,
        maxime.ripard@bootlin.com, seanpaul@chromium.org,
        hl@rock-chips.com, briannorris@chromium.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        nickey.yang@rock-chips.com
Subject: Re: [PATCH v4 RESEND] drm/panel: add Kingdisplay kd097d04 panel
 driver
Message-ID: <20190124161812.GA10550@ulmo>
References: <20181030091528.28211-1-heiko@sntech.de>
 <fa732d7c529c28135b2c9a1ccf902d4658a53682.camel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <fa732d7c529c28135b2c9a1ccf902d4658a53682.camel@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2019 at 12:01:55PM -0300, Ezequiel Garcia wrote:
> On Tue, 2018-10-30 at 10:15 +0100, Heiko Stuebner wrote:
> > From: Nickey Yang <nickey.yang@rock-chips.com>
> >=20
> > Support Kingdisplay kd097d04 9.7" 1536x2048 TFT LCD panel,
> > it is a MIPI dual-DSI panel.
> >=20
> > v4-resend:
> > - Thierry noted missing dt-bindings for v4 but forgot that he
> >   already had applied them one kernel release back in
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Debc950fdff6d5f9250cd5a5a348af97f7d8508df
> > v4:
> > - address Philipp's comments
> >   - real range for usleep_range and
> >   - poweroff ordering in kingdisplay_panel_prepare
> >   - return value beautification in panel_probe
> > - update author naming for full name
> > v3:
> > - address Thierry's comments
> >   - error handling for init dsi writes in init
> >   - unconditionally remove the panel
> >   - don't use drm_panel_detach
> >   - a bit of variable signednes wiggling
> > - I did talk to ChromeOS people and the delays really should be as short
> >   as possible, so dropped the 100ms from the delay comments
> > v2:
> > - update timing + cmds from chromeos kernel
> > - new backlight API including switch to devm_of_find_backlight
> > - fix most of Sean Paul's comments
> >   enable/prepare tracking seems something all panels do
> > - document origins of the init sequence
> > - lanes per dsi interface to 4 (two interfaces). Matches how tegra
> >   and pending rockchip dual-dsi handle (dual-)dsi lanes
> > - spdx header instead of license boilerplate
> >=20
> > Signed-off-by: Nickey Yang <nickey.yang@rock-chips.com>
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>=20
> Hm, this v4 patch has been stalling here for *four full months*.
>=20
> Which deity do we need to pray to get this one moving? ;-)
>=20
> Seriously, can someone please apply this?

If you care about this driver, perhaps you'd like to review and provide
a Reviewed-by?

Thierry

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxJ5UEACgkQ3SOs138+
s6EmExAAvc4oBTHIAOuiXuzeqfnnUZG1Gq+FK8pHDzW9mf6uRe5l21LRZwQMdIgQ
NKYEr33uMEmDCBZOHKpNlcifAl3Ki2qRvWWlZnVnxiwXR1Sjz3mqNfW45Gxwcfeb
sESMjjC5OCF/2xVvVkMQmEaVTWBhFi8jomAAGw5Shkvl//7MIrBzNGf4cT5kEbJF
xD3U7++XbZMX0psPTo+p5fWx7ol3/C4C1GMmeGdf4WzDacqCHAUDbExdiI+4VT41
OSQ90q/lhABL4uZKm4qc1ZC0WcUsqITwfv2Z9w9o8x6CBB3mZxgj0EjivOUN7NK+
C5GLqoQ7IZ4BLKCpA6yqDN1Rbr6c4H98b5kYkFFX1NMvgDe5QkwwxLtEMyHGxTwj
i86X0H9jXpgfT38Zyf9zVFzgrkItziqGe/uM7gNiSJG6isOFrNMdoDfJY+vkHNkF
GZQ1GyWLC4p/nQ79arFu8WNfmonzxbcOTEQFp8rQWXQ6ajzSfADmqDJiQYOSdoVZ
cXFSJXzH7ZpjnvfBBOF+FVEp919c7fZlYy5M4Z3DF5oIOJa+WM+FkyrQeXj6FQrc
UnPkpIPxsUxiLS0CU9N7zOUXTkVEUE0JZTyErvohdYEwtCKW9VzlGfFma9m9hE9F
hKCvVieZrAXkBQjRfQVwM0OA9EZEQ2DpLviq4vwdW5/74eMVjWA=
=GTB1
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
