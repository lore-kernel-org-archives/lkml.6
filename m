Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F55C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D055218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548440747;
	bh=k6efufJYidSxGV6GqU87Tm0wMi+pFWgOrBG3Tz8MbwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NHOXhSj5SvrqMSynqmuzgeD2QFgldNdMu2y3THZiEl3Uejbe0s4PBVzJjiOr/jmDR
	 NeNakV7Ul2PJYQTqakR4+N9AtdcM6G9NWX6GXuACm3kS0CugGLLoPuDXPP92fBokXo
	 8H80grUzIdq2cuykhA45DPZKDyE5jN5iPfKTrwQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfAYSZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:25:45 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42386 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfAYSZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:25:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gWt25jjc4owaAgPpqVBWO7L531zlgKHZ+khU60QnLIk=; b=b90sXEN+4HAfxPirgo7ijJdgm
        nnhjPQ52Irv053vDkunkZWGa+HxzpN+bl6OgeByuYPNzTwoze8tKYX1azay46W+RxpwpuHQMOqm/h
        Wb3fl+OzR2uYwkRYE8fP7uKkJqT5p7+Y3vq5xVTdkl4WePbaRNilbSHXwMeS4GecEC/wE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gn6AF-0004Zn-Uj; Fri, 25 Jan 2019 18:25:15 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 339B01126FC0; Fri, 25 Jan 2019 18:25:15 +0000 (GMT)
Date:   Fri, 25 Jan 2019 18:25:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Leo Yan <leo.yan@linaro.org>, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, gustavo@embeddedor.com,
        srinivas.kandagatla@linaro.org, mchehab+samsung@kernel.org,
        sr@denx.de, daniel.thompson@linaro.org, corbet@lwn.net,
        philburk@google.com, willy@infradead.org, jmiller@neverware.com,
        keescook@chromium.org, arnd@arndb.de, colyli@suse.de,
        ckeepax@opensource.wolfsonmicro.com, anna-maria@linutronix.de,
        mathieu.poirier@linaro.org, Baolin Wang <baolin.wang@linaro.org>,
        sboyd@kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org,
        joe@perches.com
Subject: Re: [alsa-devel] [RFC PATCH] ALSA: core: Add DMA share buffer  support
Message-ID: <20190125182515.GD6939@sirena.org.uk>
References: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
 <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz>
 <20190118190805.GF6260@sirena.org.uk>
 <s5hzhrxzrez.wl-tiwai@suse.de>
 <20190121124053.GA12679@sirena.org.uk>
 <f278bb69-7df0-4d14-5e4f-9bcb57d7f2b6@perex.cz>
 <20190122202535.GK7579@sirena.org.uk>
 <s5h4l9z4mbo.wl-tiwai@suse.de>
 <20190123124658.GE15906@leoy-ThinkPad-X240s>
 <s5himyczxgl.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
Content-Disposition: inline
In-Reply-To: <s5himyczxgl.wl-tiwai@suse.de>
X-Cookie: diplomacy, n:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 25, 2019 at 02:19:22PM +0100, Takashi Iwai wrote:
> Leo Yan wrote:

> > If we directly use the device node /dev/snd/ as file descriptor, even
> > though we specify flag O_EXCL when open it, but it still is not an
> > anon inode file descriptor.  Thus this is not safe enough and will be
> > blocked by SELinux.  On the other hand, this patch wants to use
> > dma-buf framework to provide file descriptor for the audio buffer, and
> > this audio buffer can be one of mutiple audio buffers in the system
> > and it can be shared to any audio client program.

> Hrm, it sounds like a workaround just to bypass SELinux check...

> The sound server can open another PCM stream with O_APPEND, and pass
> that fd to the client, too?

So long as we can teach SELinux that they're safe to export, yeah.

--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxLVIoACgkQJNaLcl1U
h9BIlQf/c0GPSYvy1six7hAwKWMAQ1I97qAN/voUXyYjH2Ba9LCGY0NXVaMZBumu
e0hboaVbcfiE4TDKeCn2D6XyFw0RMmCUeS/xZp5lS0fPjOC/cjQhGEX9krOUxBV+
sWn6dJPzdTVF+pIsv7t3UsCJ09uwh3mQXx2lzvdG8mN9TY0dVYCg626qKaxnQwZR
DsPpDqxP8RSDZDlpozDZGz7OOgo6tw1J3MKVfTkx/nxCpe7cPMyTEjrBVFagRhQ0
0ATPOBtc/rH3wh4500vs1/p32NufvUwUhSBnQhk8AzqbSPGeGNW18SYUyg940KbP
ImR0G3QvM7VmN3WB7uyoiv0YSicgpw==
=Zsq2
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--
