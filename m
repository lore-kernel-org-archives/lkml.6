Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CD7C476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3F221471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ZR78c0eU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3F221471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbeGLQIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:08:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50984 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeGLQIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rxWNbK8Y0p66Z9w0AVbWsVr4o2fqRHBIIdsEUhakLWY=; b=ZR78c0eUYVOoyrArBu5iKKCq9
        PGrRSuu4yy0EU3TWeDp4BW20AUhZDOdPKpfqWJOWrZSJGqApzMxw+j0BUOCLaaspQ0FWafmAHjTpG
        ianeKm1lBEvhUkyhL1sdiXSZ9GNzrgfdbpKkZ0HDCiQZ97E9cILbzf2Sn9xEbcKXdagJU=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fddz0-0003ny-Lb; Thu, 12 Jul 2018 15:58:18 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fddyz-0006vj-W9; Thu, 12 Jul 2018 16:58:18 +0100
Date:   Thu, 12 Jul 2018 16:58:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org, vkoul@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ASoC: core: add support to card
 re-bind/unbind using component framework
Message-ID: <20180712155817.GG10369@sirena.org.uk>
References: <20180711084318.11786-1-srinivas.kandagatla@linaro.org>
 <68715fbc-9447-dfaf-3fe5-4200684c2cbc@linux.intel.com>
 <s5hsh4o8nq1.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GdbWtwDHkcXqP16f"
Content-Disposition: inline
In-Reply-To: <s5hsh4o8nq1.wl-tiwai@suse.de>
X-Cookie: Kleeneness is next to Godelness.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GdbWtwDHkcXqP16f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 12, 2018 at 05:42:30PM +0200, Takashi Iwai wrote:
> Pierre-Louis Bossart wrote:
> > On 7/11/18 3:43 AM, Srinivas Kandagatla wrote:

> > > This patch aims at add achieving dynamic behaviour of audio card when
> > > the dependent components disappear and reappear.

> > Humm, no real comment on this patch proper but rather on how userspace
> > would deal with this dynamic behavior?
> > We had similar opens when we worked on the BYT/CHT HDMI stuff and
> > ended-up with quite a few issues in userspace (PulseAudio mainly)
> > related to dynamic behavior at the kernel level as a result of
> > plug/unplug. Also not sure how an Android HAL would deal with a card
> > disappearing temporarily if DSP resources become unavailable or
> > unresponsive. Any thoughts or guidance you might think of?

> Was the card-level register / unregister really problematic with PA?
> It's basically similar as the hotplug like USB, so I thought it would
> work as is.

Yeah, I'd expect normal desktop stuff to be able to cope with this due
to physically hotpluggable hardware.  The main use case for doing things
like this with module unload is in a development context where hopefully
people can also arrange to use a userspace that can cope or to do
whatever to reset it, any limitations in some userspace shouldn't prevent
people from having the facility available.

--GdbWtwDHkcXqP16f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltHepkACgkQJNaLcl1U
h9AMIwf7BhRkGokjgqRqrNGjXZa6Kwykx4hHriSACyNkX7n9KrQJnmZjM7DYZ6sl
sNQIJL5AUetE0Swwtk5pQpYsqnBO0/yPSwCDthWu9gzTLC1o95LTVaJb+g5RtrJt
i65c6oKpL+UZ0ALa3FvUwSNOvnpQOvIg5X+ATPhXN8MajRFC/SxK456Pi52pR6Eo
lJ6TowhzK8lYfft2edbh2Z4XZA3X2YvOEBvgo0VWcd8eWQ6ive9Y2D8BhVoBFaWZ
98DOLCBvNhFmN/1mPSr56nQS/lEgF736wbNzOa2t3/lvLrS5ykkB3XzZv+Y/70o3
/DyeAr2GtVEJp2TLt23wkZgDhe0LFQ==
=nrKD
-----END PGP SIGNATURE-----

--GdbWtwDHkcXqP16f--
