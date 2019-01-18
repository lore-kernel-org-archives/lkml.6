Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50879C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDF82087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547838522;
	bh=Okqjz9IVubD00dlCD92N8n5Dm6t1TKzUdEG4ujBpYZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vwmyok4Ui5TuOVmiWdgmEDPOzTERc6uNABnIoRAMcSuzPObERiNIcl+l9bYMRLOGK
	 ujKD8AGaVNJSPRahrC+2irzp0A6UjO8ia5kZJOJ4Z6tDUP0a7lU8mHOzD4x0EFvkRJ
	 UZt/+OXhT8f8VIRWamOAWAzK2ClBU+LgZ9kgHUmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbfARTIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:08:40 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51394 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbfARTIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NurNqkAO0hBvxkpZVUeGXsWRIkDOBLMVrYGUTknXxzE=; b=MVBTAk9pMpM/USMlR37pfIOPN
        9eq2P+2N/ldFcLIVOpBCjWNgNrEAxGekzyHBrv5gBDmiIsWXxey9fwzRg88ltVDvFd1qndBUvsNfW
        i/4X9SNqX95Nu5MZSPYPypwmxsJcLoEIfJTIS62XzM9BIkQTdgXQ9tgGJ8SqysHw1WDgY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gkZUs-0005WI-6J; Fri, 18 Jan 2019 19:08:06 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9122D11276E7; Fri, 18 Jan 2019 19:08:05 +0000 (GMT)
Date:   Fri, 18 Jan 2019 19:08:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Baolin Wang <baolin.wang@linaro.org>, tiwai@suse.com,
        leo.yan@linaro.org, sboyd@kernel.org, colyli@suse.de,
        corbet@lwn.net, mathieu.poirier@linaro.org,
        ckeepax@opensource.wolfsonmicro.com, mchehab+samsung@kernel.org,
        gustavo@embeddedor.com, joe@perches.com, vkoul@kernel.org,
        o-takashi@sakamocchi.jp, keescook@chromium.org,
        jmiller@neverware.com, anna-maria@linutronix.de,
        willy@infradead.org, sr@denx.de, bgoswami@codeaurora.org,
        philburk@google.com, srinivas.kandagatla@linaro.org, arnd@arndb.de,
        daniel.thompson@linaro.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [RFC PATCH] ALSA: core: Add DMA share buffer support
Message-ID: <20190118190805.GF6260@sirena.org.uk>
References: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
 <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3yNHWXBV/QO9xKNm"
Content-Disposition: inline
In-Reply-To: <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz>
X-Cookie: You can't get there from here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3yNHWXBV/QO9xKNm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 10:35:44AM +0100, Jaroslav Kysela wrote:

>   the tinyalsa implementation does not show much - it's equal to the
> standard mmap access for the PCM devices. Even considering the Mark's
> text, there must be an arbiter (sound server) which communicates with
> the producer or consumer to control the data flow. I really would like
> to see a real usage for this.

Right, the driving force behind implementing this is Android which had
been using an out of tree version of this approach based on ION but
that's run into trouble due to other outside changes.

>   It seems to me that the only point to implement this is the
> permissions. We already have O_APPEND mode for the PCM file descriptor
> which can reuse the PCM device multiple times (mmap the buffer to
> multiple tasks). I would probably go in this way and add more extended
> permission control for the PCM device, so permissions can be restricted
> for the passed descriptor to the producer or the consumer task. In this
> way, the restricted task might reuse other control mechanism offered buy
> the PCM file descriptor without requesting the arbiter to do so (like
> read the actual position in the DMA buffer, get the audio delay or so -
> reduce context switches).

One concern I have with doing some ALSA-specific custom permissions
thing is integration with frameworks like SELinux (they'd presumably
need to learn about the ALSA specific stuff to manage it).  It also
seems like it's adding a lot more security sensitive interfaces and=20
code which which will require audit and review, one of the things I=20
really like about this approach is that it's incredibly simple from
the security point of view.

--3yNHWXBV/QO9xKNm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxCJBQACgkQJNaLcl1U
h9C1nwf6Ajg+8dtn4R9gXvvYxYKD3C8tBRZVKey3ANemRTEaLMVqPnepM0fFdfkq
aF3R/XWSTimr4VSDwiAjWILSgLFWyrDtrApIWCLic7hIAi3coe8ZwCQTgi+ADtxZ
1l/bwAX1j54kCEA3veyUf79yV7OHZ4pYzhJ5nDA/HDeyVbLsZ9IanqtsRo8nHpbS
GFBES7IFSPS9CbvzDIhfKS7F4OVrDecZR0F0SO62DSiExKjj+xfbt8Vnf1QyM41v
69E7CZKoU93F/HfDuqTg+zsFrCsNtE8j7rhrbir0Ub1goKXXdh/7g6voRGgu0mse
hdbw6qz6rJIU475liQwQG6zo041XPA==
=p664
-----END PGP SIGNATURE-----

--3yNHWXBV/QO9xKNm--
