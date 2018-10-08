Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAE3C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78946204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="sonEOJUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78946204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeJHQpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:45:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48380 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeJHQpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XV0e0jeTDZ5IzjhF8ANwBm2EPc8qZMFAxqFP60F6XeM=; b=sonEOJUNOiDinvmM0tPax5q9m
        qjxkj8kv22r0d96e0VB4BQtj6GVAX8kGqWX8xpkm4g9rSranLWuCceH7gAuM8E7Onn09qvjthjnYV
        nBw4n2yABHwxFbELG+rvOK/hU7AzBZ2/oyh76q2HW2rr95c0ll43UcCKD4oIQYBS8THdw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g9RvY-0002M9-L5; Mon, 08 Oct 2018 09:34:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1AB3F1122339; Mon,  8 Oct 2018 10:34:12 +0100 (BST)
Date:   Mon, 8 Oct 2018 10:34:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>,
        Sasha Levin <alexander.levin@microsoft.com>, tiwai@suse.de
Subject: Re: [PATCH AUTOSEL 4.18 27/48] sound: enable interrupt after dma
 buffer initialization
Message-ID: <20181008093412.GA5684@sirena.org.uk>
References: <20181005161424.20521-1-sashal@kernel.org>
 <20181005161424.20521-27-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20181005161424.20521-27-sashal@kernel.org>
X-Cookie: There's no time like the pleasant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 05, 2018 at 12:14:03PM -0400, Sasha Levin wrote:
> From: Yu Zhao <yuzhao@google.com>
>=20
> [ Upstream commit b61749a89f826eb61fc59794d9e4697bd246eb61 ]
>=20
> In snd_hdac_bus_init_chip(), we enable interrupt before
> snd_hdac_bus_init_cmd_io() initializing dma buffers. If irq has
> been acquired and irq handler uses the dma buffer, kernel may crash
> when interrupt comes in.

CCing Takashi who's the maintainer here for review.

>=20
> Fix the problem by postponing enabling irq after dma buffer
> initialization. And warn once on null dma buffer pointer during the
> initialization.
>=20
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>  sound/hda/hdac_controller.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
> index 560ec0986e1a..11057d9f84ec 100644
> --- a/sound/hda/hdac_controller.c
> +++ b/sound/hda/hdac_controller.c
> @@ -40,6 +40,8 @@ static void azx_clear_corbrp(struct hdac_bus *bus)
>   */
>  void snd_hdac_bus_init_cmd_io(struct hdac_bus *bus)
>  {
> +	WARN_ON_ONCE(!bus->rb.area);
> +
>  	spin_lock_irq(&bus->reg_lock);
>  	/* CORB set up */
>  	bus->corb.addr =3D bus->rb.addr;
> @@ -479,13 +481,15 @@ bool snd_hdac_bus_init_chip(struct hdac_bus *bus, b=
ool full_reset)
>  	/* reset controller */
>  	azx_reset(bus, full_reset);
> =20
> -	/* initialize interrupts */
> +	/* clear interrupts */
>  	azx_int_clear(bus);
> -	azx_int_enable(bus);
> =20
>  	/* initialize the codec command I/O */
>  	snd_hdac_bus_init_cmd_io(bus);
> =20
> +	/* enable interrupts after CORB/RIRB buffers are initialized above */
> +	azx_int_enable(bus);
> +
>  	/* program the position buffer */
>  	if (bus->use_posbuf && bus->posbuf.addr) {
>  		snd_hdac_chip_writel(bus, DPLBASE, (u32)bus->posbuf.addr);
> --=20
> 2.17.1
>=20

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu7JJEACgkQJNaLcl1U
h9BH2wf/SsO9sS9MzMpH82DoMKFDQ1OgquP8eRx8I/p0ekol9xQfI/4tV9GzDVzs
DcRjFaa0ZIILdjK78kwzxoYaxhg65kcyyPiS9rxjZZVMu1rU9NhHZcJXQ/kmdSK+
QnXs2HuksClh8VYv10tB4toGAYUXqGbjnWE+rHRSS6I3JXfrsNp8Gnb2sJaBluA5
q5mc5jwL4b1V+zI+uo797nnAVh+6QytfCm3TrL3kug0yUmLQD+2SAfJL/PQ8M24r
UNWcY36fPfufkseNDSGOAkMi79pS7rlHBeTke+j6Lk9HdsPgcajo37R/2/0r2xC1
jMO/1mGTpmgZLnrovq5HdiPY0dClWQ==
=eF1n
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
