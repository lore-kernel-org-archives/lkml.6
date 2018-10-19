Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41473ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 22:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA31921476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 22:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOg9dTW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA31921476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbeJTHGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 03:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbeJTHGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 03:06:35 -0400
Received: from earth.universe (unknown [185.216.33.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 494FE21470;
        Fri, 19 Oct 2018 22:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539989910;
        bh=avgKQu+j/8fQUQFYnVNVjRkkSbC8RkVfUZixIyi/3bg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VOg9dTW6TrYVlo3eJiW70aIwvz9qMBJQmRcvHNiJLvxuUo5LvXfF95PNUoBZV8PHg
         PQAhYG1gSy7XWkqz5WmdSCDDP2PoCK2KmyJEqgYQbmfjWkneZHP7JIZ0ipO1A/45Xc
         1deKvoQwWADePU053K12HHJCWHGytw0uE3w2A1Ms=
Received: by earth.universe (Postfix, from userid 1000)
        id 7897A3C0870; Sat, 20 Oct 2018 00:58:27 +0200 (CEST)
Date:   Sat, 20 Oct 2018 00:58:27 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net,
        merlijn@wizzup.org
Subject: Re: omap4: support for manually updated display
Message-ID: <20181019225827.s76wapp3cxrmp5af@earth.universe>
References: <20180830090456.GA17277@amd>
 <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com>
 <3205865.8O8aibZXye@avalon>
 <20180910174453.GV5662@atomide.com>
 <20181018221549.GB6364@amd>
 <20181019164450.GD43338@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ods5vlhnrkscav5l"
Content-Disposition: inline
In-Reply-To: <20181019164450.GD43338@atomide.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ods5vlhnrkscav5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 19, 2018 at 09:44:50AM -0700, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [181018 22:15]:
> > Hi!
> >=20
> > > > I want to make it clear that I don't want to claim any privilege in=
 getting=20
> > > > patches merged first. I am however worried that, without an easy wa=
y to test=20
> > > > DSI support, and without enough time to focus on it, I would break =
whatever=20
> > > > would be merged now in future reworks. I would thus like to find ou=
t how to=20
> > > > collaborate on this task, hopefully to move towards usage of drm_br=
idge and=20
> > > > drm_panel for DSI-based pipelines.
> > >=20
> > > Real users with mainline kernel with a real product should
> > > always have priority over any ongoing clean-up.
> > >=20
> > > And for testing, a bunch of real users is something you can't
> > > beat for proper testing of code on ongoing basis!
> > >=20
> > > Naturally the burden of getting the patches ready is on the people
> > > using them for rebase and fixing comments. And Sebastian has
> > > already agreed help with maintaining it.
> > >=20
> > > I've been actually using DSI command mode support and testing
> > > Linux next several times a week to prevent regressions from
> > > sneaking into -rc1 in general. So now I can't test omapdrm with
> > > next until Sebastian is done with rebasing.. Back to headless
> > > testing then.
> > >=20
> > > Anyways, I'd say let's add the DSI command mode support ASAP after
> > > rebasing, there are at least Sebastian, Pavel and I then testing
> > > and helping with further ongoing panel conversion work.
> >=20
> > Are there any news here? Does someone have a patch set that actually
> > works?
>=20
> I was wondering about that too.. I only have the v4.19-rc1 based
> patches and can no longer test with Linux next. Sebastian, any
> update?
>=20
> > Are there any in-progress patches I could help with?
>=20
> I can put in some effort too if needed.

I have some in-progress patches, that are not yet working. The
reversal of display pipeline initialization introduced some
issues with DSI (since the panel cannot be fully initialized
without DSI controller). I got this resolved by registering
the DSI display before the DSI controller is fully intialized.
This is obviously racy and breaks for device with DSI backlight
(since display probe function tries to do DSI queries). I think
properly solving this mess requires full migration to
the common mipi_dsi_host/mipi_dsi_device infrastructure. This
should obviously be done anyways, but for now the hack should
be good enough. There is still some other issue, though. I do
not yet understand the origin of that one.

I uploaded my current status here. It's not based on the newest
-next, but contains the interesting patches from Laurent. Also
the last few patches are not yet cleaned up, sorry for the mess.

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-n900.git/log/?h=
=3Ddroid4-display-omapdrm-4.20-next

-- Sebastian

--ods5vlhnrkscav5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvKYZAACgkQ2O7X88g7
+pq8ohAAhEEFx2TYo5+ggG/iV2L9x6LLEYojJyhtQ2xNi9lNxiDGRaYlgyboG7I6
E0TxGaV6znnhH0SWNLsG1aqHG1xA7fhDuLNshPTRZlQk/PBpS6waI7/X0ZBfCans
PEEWAandOfScvN/JHeLkxTP0Ak6CrXKUK1UeHR+vq4t3TGTwDKOgT8N6ob3Y3nHY
L+3mk1ZljQny7tXkUMgiiy+GGS81WIJy8DLYQ/Xa9zfL9aR156hc4aGnnnwrANIJ
X7+z4tvsEcZAZLHpYG6W7SWirXIghGXwptMrDXWazRNNutlS/9R0GNOSYku9z61b
a4DsUe6afmYx4MDLSubfYP+fquObv81gSOQEWEd35liG30CPDFWMtepUHWaLU1Om
GsqGINXx2CEAcmUv67DJ8ORfqUZiEhF6ECHfzsvTYNad1SA/oEGCydTFW9cyG9tp
WAq5kLJqINlW2nxLwmfeybKreSx2nym6B2ivx8KClniZp0LkzD6GvSzY4+4SGlz0
gWXJhU/CGPD/Qc6Csd2SQf+8qW1kLMS5lGLF9SNPbWWR3MZoRNjr1SXgWhPar7qa
bDJNDgHYEq1PVGtMXLz8HgTQOzpG2WW+Re6m+Ivus7n8ixlS+B6JZhpj+YEOfzy2
pEF4e+MisA9WJRhiKWeLXs9vG1l8kKOhw5Rsb6UoqWtg52Nlv5s=
=5BXb
-----END PGP SIGNATURE-----

--ods5vlhnrkscav5l--
