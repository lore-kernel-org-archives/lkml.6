Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEFCC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06086214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfA1Kis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:38:48 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50025 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfA1Kis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 05:38:48 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 985722078F; Mon, 28 Jan 2019 11:38:44 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 61011206A6;
        Mon, 28 Jan 2019 11:38:34 +0100 (CET)
Date:   Mon, 28 Jan 2019 11:38:35 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] backlight: pwm_bl: Use gpiod_get_value_cansleep() to get
 initial state
Message-ID: <20190128103835.ibgze6vbkk642dkv@flea>
References: <20190127145054.3770-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7z7natm2nbelfsf6"
Content-Disposition: inline
In-Reply-To: <20190127145054.3770-1-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7z7natm2nbelfsf6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 27, 2019 at 10:50:54PM +0800, Chen-Yu Tsai wrote:
> gpiod_get_value() gives out a warning if access to the underlying gpiochip
> requires sleeping, which is common for I2C based chips:
>=20
>     WARNING: CPU: 0 PID: 77 at drivers/gpio/gpiolib.c:2500 gpiod_get_valu=
e+0xd0/0x100
>     Modules linked in:
>     CPU: 0 PID: 77 Comm: kworker/0:2 Not tainted 4.14.0-rc3-00589-gf32897=
915d48-dirty #90
>     Hardware name: Allwinner sun4i/sun5i Families
>     Workqueue: events deferred_probe_work_func
>     [<c010ec50>] (unwind_backtrace) from [<c010b784>] (show_stack+0x10/0x=
14)
>     [<c010b784>] (show_stack) from [<c0797224>] (dump_stack+0x88/0x9c)
>     [<c0797224>] (dump_stack) from [<c0125b08>] (__warn+0xe8/0x100)
>     [<c0125b08>] (__warn) from [<c0125bd0>] (warn_slowpath_null+0x20/0x28)
>     [<c0125bd0>] (warn_slowpath_null) from [<c037069c>] (gpiod_get_value+=
0xd0/0x100)
>     [<c037069c>] (gpiod_get_value) from [<c03778d0>] (pwm_backlight_probe=
+0x238/0x508)
>     [<c03778d0>] (pwm_backlight_probe) from [<c0411a2c>] (platform_drv_pr=
obe+0x50/0xac)
>     [<c0411a2c>] (platform_drv_probe) from [<c0410224>] (driver_probe_dev=
ice+0x238/0x2e8)
>     [<c0410224>] (driver_probe_device) from [<c040e820>] (bus_for_each_dr=
v+0x44/0x94)
>     [<c040e820>] (bus_for_each_drv) from [<c040ff0c>] (__device_attach+0x=
b0/0x114)
>     [<c040ff0c>] (__device_attach) from [<c040f4f8>] (bus_probe_device+0x=
84/0x8c)
>     [<c040f4f8>] (bus_probe_device) from [<c040f944>] (deferred_probe_wor=
k_func+0x50/0x14c)
>     [<c040f944>] (deferred_probe_work_func) from [<c013be84>] (process_on=
e_work+0x1ec/0x414)
>     [<c013be84>] (process_one_work) from [<c013ce5c>] (worker_thread+0x2b=
0/0x5a0)
>     [<c013ce5c>] (worker_thread) from [<c0141908>] (kthread+0x14c/0x154)
>     [<c0141908>] (kthread) from [<c0107ab0>] (ret_from_fork+0x14/0x24)
>=20
> This was missed in commit 0c9501f823a4 ("backlight: pwm_bl: Handle gpio
> that can sleep"). The code was then moved to a separate function in
> commit 7613c922315e ("backlight: pwm_bl: Move the checks for initial power
> state to a separate function").
>=20
> The only usage of gpiod_get_value() is during the probe stage, which is
> safe to sleep in. Switch to gpiod_get_value_cansleep().
>=20
> Fixes: 0c9501f823a4 ("backlight: pwm_bl: Handle gpio that can sleep")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime
=20
--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--7z7natm2nbelfsf6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXE7bqgAKCRDj7w1vZxhR
xfndAP9l8ziOquk7/+im/vyCRkkkx8BUdtaHT/UNrJzybBggygD+KZOftP3cZ5As
vpNwIM8ohyvw0yMrbuWWkz0rJvxKDA8=
=tEBo
-----END PGP SIGNATURE-----

--7z7natm2nbelfsf6--
