Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7324AC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE872085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548074485;
	bh=Tk50q1UfKutfJzZ9M3BUj9Bb3fpwx49TqrQ3ftRb/GY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r/VJQUQ3PNUtbpWFWHj3wFfjYLE5+jEMdWgM353qK9T2XHp3LqojukEvqWnyZAp1q
	 H74bawzQ9Yk2FdhhDX64sBZPdkuIgsLUSCiDgP4kGvSgrIbN5fwlOb9dM0VXazlsNc
	 Ng5INHsQzrrBlAC4whlA7t8jjQPuIrYg3DCAucf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbfAUMlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:41:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44788 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbfAUMlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dwwYTmqw2qqPUfHl0tZCawPhKH6w6Z+hj1+WvXLPSgc=; b=mPR8aWMVnF/F0YgJMZSlySiAk
        RRfsQcCpbOcVm0He0ujqVSeSbWp1GuWHJL0jHSag6IhN3YGc2C0y0PIF1opvdltyvWSyOqdfgqlns
        dnGGOgIXXYD8qLrZng11D1fMNSqVmz2p058jtEkMlwcL/CLLsFhOnFCUCtOwmdt9jK8v0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1glYso-0004OK-7f; Mon, 21 Jan 2019 12:40:54 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9CB66112767C; Mon, 21 Jan 2019 12:40:53 +0000 (GMT)
Date:   Mon, 21 Jan 2019 12:40:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        arnd@arndb.de, keescook@chromium.org, bgoswami@codeaurora.org,
        sr@denx.de, gustavo@embeddedor.com, philburk@google.com,
        willy@infradead.org, mchehab+samsung@kernel.org, sboyd@kernel.org,
        vkoul@kernel.org, Baolin Wang <baolin.wang@linaro.org>,
        daniel.thompson@linaro.org, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, srinivas.kandagatla@linaro.org,
        anna-maria@linutronix.de, corbet@lwn.net, jmiller@neverware.com,
        ckeepax@opensource.wolfsonmicro.com, joe@perches.com,
        o-takashi@sakamocchi.jp, colyli@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ALSA: core: Add DMA share buffer support
Message-ID: <20190121124053.GA12679@sirena.org.uk>
References: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
 <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz>
 <20190118190805.GF6260@sirena.org.uk>
 <s5hzhrxzrez.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <s5hzhrxzrez.wl-tiwai@suse.de>
X-Cookie: Body by Nautilus, Brain by Mattel.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 18, 2019 at 08:39:32PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > > multiple tasks). I would probably go in this way and add more extended
> > > permission control for the PCM device, so permissions can be restricted
> > > for the passed descriptor to the producer or the consumer task. In this

> > One concern I have with doing some ALSA-specific custom permissions
> > thing is integration with frameworks like SELinux (they'd presumably
> > need to learn about the ALSA specific stuff to manage it).  It also

> Well, I wonder what makes it more difficult by the approach Jaroslav
> suggested.  With O_APPEND, you can just call mmap() normally, and
> that's all. What's the merit of dma-buf approach wrt the security?

It was the bit about adding more extended permission control that I was
worried about there, not the initial O_APPEND bit.  Indeed the O_APPEND
bit sounds like it might also work from the base buffer sharing point of
view, I have to confess I'd not heard of that feature before (it didn't
come up in the discussion when Eric raised this in Prague).

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxFvc0ACgkQJNaLcl1U
h9DIZgf/diES8I2aHgDHGiA47EDxQwSzkQCDjdVP1gzfiRds2qC+I8F2LGrRw7ds
5KeWEpM8zfxhM1qzxaErnzvJlq7iLHij6K/azhmDQlep2uCZZu0xT0+kVH+0Sl44
C/QbUosmDwzfDIIZo6YjubD1iKoRgTmZkmZVvGhqDQYFOTO75j7BBw445uphGTJ0
RPSYeAWob3mluUOy9Ob0zT259QRuGKr+Xa5S//M5dl1vwzTdnOb6hx+jc0hZWe8E
yLb6xoxfxq9UPWdt28dhBDmjrDvvYs2pPL9JiY3aIEYM2+OP2y/HKuwSG1bQpH+Y
azcEo7jf20gO+kf2Sa6AaYnOp+5yrA==
=SAV5
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
