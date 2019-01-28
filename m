Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBF4C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7092147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoldZTcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbfA1R3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:29:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52955 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbfA1P7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:59:42 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so14555626wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 07:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Kcz9Olqc2760s7xr/OcYDhgdSxr75a3bZjSTSwJ6os=;
        b=GoldZTcE5clildHY6CoOSKa2e1wCpp83Q5hlwC4QeqXWOdGFYTOSqCj8cjaERINhXI
         oE+7eqrCeVHFSlzHZyB8TafIUSnxT51RGc+cpTjV2gV4+nOeqkBZ0iQdC1XOot/3yMzo
         +OScnNTjHvfBfTASUw2A5zxPcOq1ulthwG9gIrNnecIKVbnS8gCFVHjqHnpsfhQfZa7Q
         7W2riQykcAWiz+ps5wUYoysGanBVcAsb7jBG4PapgCK/M9hOBWZuaoSL0Cc447ilpTfY
         lRpQWSTk+RrbfTvbInppvz57V2y+dS18+fHTq8diujJRjxIQMzxHPJvz5SKRFIkS48h6
         dJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Kcz9Olqc2760s7xr/OcYDhgdSxr75a3bZjSTSwJ6os=;
        b=nzaPnOdjseRdbhMK+DWtDSNju7zAJAIzYId9liArQCKWE6Q/WylWPJb2dDTVyknifd
         D0MWAtM3TU5umQRz89r+lfSd0H0CPeyqMi7CMxoADxp9BQRnJcb/7Lje68eAfahzD+xW
         lc2rDhXYNB3EwBe3GfIlq0kdvlbga2ilP8vmJqY5Zp5A7m+CYXqkTprATa5OK2eJxVE5
         ahXE1JCAfZ8V1jX1Aq3EztHn5lkSIswFiDkCJF3rZPJpv4WDgl9aX7J7Kvc4wT2L07fg
         1s6VrbMC+YHLo7T98fcCGPDrOxLrkxwc9lIY48gS6u3Xw38XEXDwaBVnl6m5rN91Dlxf
         BzGg==
X-Gm-Message-State: AJcUukfE/rtNsMHdhzx6/p0K9j9YAy9t3xm1hUNnw3m1xXDD0F0Wc8cM
        MaiOPi/swvLT54hu+bGlzFUPywlz/6c=
X-Google-Smtp-Source: ALg8bN5/9z0yeKeDW2zK9bTz9BzXtHfvRUQutNNrZLeL8dok77ZJQuSQ/FVyU33uAsCnyKwrclt7AQ==
X-Received: by 2002:a1c:6707:: with SMTP id b7mr17555405wmc.138.1548691180179;
        Mon, 28 Jan 2019 07:59:40 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id p139sm148035722wmd.31.2019.01.28.07.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 07:59:39 -0800 (PST)
Date:   Mon, 28 Jan 2019 16:59:38 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sean Paul <sean@poorly.run>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        padovan Gustavo <gustavo.padovan@collabora.com>,
        maxime.ripard@bootlin.com, seanpaul@chromium.org,
        hl@rock-chips.com, briannorris@chromium.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        nickey.yang@rock-chips.com
Subject: Re: [PATCH v4 RESEND] drm/panel: add Kingdisplay kd097d04 panel
 driver
Message-ID: <20190128155938.GC26200@ulmo>
References: <20181030091528.28211-1-heiko@sntech.de>
 <fa732d7c529c28135b2c9a1ccf902d4658a53682.camel@collabora.com>
 <20190124161812.GA10550@ulmo>
 <20190124175136.GP114153@art_vandelay>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Content-Disposition: inline
In-Reply-To: <20190124175136.GP114153@art_vandelay>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2019 at 12:51:36PM -0500, Sean Paul wrote:
> On Thu, Jan 24, 2019 at 05:18:12PM +0100, Thierry Reding wrote:
> > On Thu, Jan 24, 2019 at 12:01:55PM -0300, Ezequiel Garcia wrote:
> > > On Tue, 2018-10-30 at 10:15 +0100, Heiko Stuebner wrote:
> > > > From: Nickey Yang <nickey.yang@rock-chips.com>
> > > >=20
> > > > Support Kingdisplay kd097d04 9.7" 1536x2048 TFT LCD panel,
> > > > it is a MIPI dual-DSI panel.
> > > >=20
> > > > v4-resend:
> > > > - Thierry noted missing dt-bindings for v4 but forgot that he
> > > >   already had applied them one kernel release back in
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3Debc950fdff6d5f9250cd5a5a348af97f7d8508df
> > > > v4:
> > > > - address Philipp's comments
> > > >   - real range for usleep_range and
> > > >   - poweroff ordering in kingdisplay_panel_prepare
> > > >   - return value beautification in panel_probe
> > > > - update author naming for full name
> > > > v3:
> > > > - address Thierry's comments
> > > >   - error handling for init dsi writes in init
> > > >   - unconditionally remove the panel
> > > >   - don't use drm_panel_detach
> > > >   - a bit of variable signednes wiggling
> > > > - I did talk to ChromeOS people and the delays really should be as =
short
> > > >   as possible, so dropped the 100ms from the delay comments
> > > > v2:
> > > > - update timing + cmds from chromeos kernel
> > > > - new backlight API including switch to devm_of_find_backlight
> > > > - fix most of Sean Paul's comments
> > > >   enable/prepare tracking seems something all panels do
> > > > - document origins of the init sequence
> > > > - lanes per dsi interface to 4 (two interfaces). Matches how tegra
> > > >   and pending rockchip dual-dsi handle (dual-)dsi lanes
> > > > - spdx header instead of license boilerplate
> > > >=20
> > > > Signed-off-by: Nickey Yang <nickey.yang@rock-chips.com>
> > > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > >=20
> > > Hm, this v4 patch has been stalling here for *four full months*.
> > >=20
> > > Which deity do we need to pray to get this one moving? ;-)
> > >=20
> > > Seriously, can someone please apply this?
> >=20
> > If you care about this driver, perhaps you'd like to review and provide
> > a Reviewed-by?
>=20
> Looks good to me,
>=20
> Reviewed-by: Sean Paul <sean@poorly.run>

I was aiming for a Reviewed-by from Ezequiel, but I'll take yours as
well, thanks very much.

Thierry

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxPJuoACgkQ3SOs138+
s6GT3xAAktaol5tKv4eewJCyY+h+SfNaQKhlpn4LOE6oJenisSHpIhpjr6Mm7txx
KUZ4MD83dStwvQbaSZFE3soipuJ2vKFIN5cZV2IRjL8Z4C5K+wUsEpckr9HY7mLk
XN8fw152VVr5Fh5tVUajOkIHseuSBNMHh2Bt3y+vUJ51KSgQ5ebWkW73U/RF1K0t
rXAfsSlF8Avf5BiiwQg7WFb/Vbx7PceF0eVmhL0cU7K1dfievfjSemqkSwRQIiBn
jyNYunjr1woqcdcPBsvOlVhoQXMpLYfGOM1xc3wS8JFL4rcvTb6aESh/cCgJvq5O
DSBY7qTZ8P4IMGy5x4TXpuGwVajXsHswi3evFmi/Uplf2By7HiKO1+mAXz2sUXgy
qsQBGin149yfbfi/huHlUf/7TtSI0FMd+DQWWZjJWpUydQ73z4VwUCaKjJAytjOd
RcHaXMEuh4+hyM1U6dNaPysYXoozA9YmvFe9rgWCsO7UWFg8HFT+gBMFq6AW0IlS
mKFHK2O0ho5PLBdMI6zzCTQQ304+Prh+ckliNKuG9i/4MfmxxRmBkVmOKkJTuagq
x9ks8/wFOIrH5neMo87Azua+zuK521sC5EaaPWO99UpTd+Rh9rad7JxOU6Mhp7+6
hEMyqvGcQG59/1e0coEHBoGd3SgXc3w+lM6vr0xMVs5yROjTSqM=
=GFFm
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
