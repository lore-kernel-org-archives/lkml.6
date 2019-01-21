Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C4DC31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4568E2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548093093;
	bh=+VYvV/cZdbCPj/WF+qlBZuF/AMHqeyM/jd1E1M2QOVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e0C9icik0Y6KbIgxzPxZZPuqmasR8OABXooEtqGm4bZSKdn78kvD1uUJWtJWxDjLp
	 /N8AFTo1oo9QXZUK18N0I+qTH+TYNQ/xyoDI2nHrNLoarMh4MpRfzIxjcdwier2f6C
	 Lft4iak/kN12Etrc/Rh/0/oEbe7l1ex+LptX3cTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfAURvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:51:31 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57030 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfAURvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RpNzPzuN/lZpdmOHSwfeWnJJzfDiUjt6dIj5Y9Kp//M=; b=t5dfJj2Va3Yn1CFrxbvclg3WX
        ZU2gJGKAx1pwCvYezDvI9FkWMsHGx0fFk7LT/7btwpHF+dBDZbZNd0wadQgNeaZukDWd+OeTQwM9L
        43pNdOqk74hYjPyEi87f+8QV4DyzfCNF2QDovo0/Wy4MP4R3msCZBnWj5pmfr9O4Rm+n0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gldjG-0004uf-7G; Mon, 21 Jan 2019 17:51:22 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AF81A1127D00; Mon, 21 Jan 2019 17:51:21 +0000 (GMT)
Date:   Mon, 21 Jan 2019 17:51:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Zhiwei Jiang <qq282012236@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dapm: Skip suspending widgets with ignore flag
Message-ID: <20190121175121.GD12679@sirena.org.uk>
References: <20190121144818.23042-1-qq282012236@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Content-Disposition: inline
In-Reply-To: <20190121144818.23042-1-qq282012236@gmail.com>
X-Cookie: Body by Nautilus, Brain by Mattel.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 21, 2019 at 10:48:18PM +0800, Zhiwei Jiang wrote:
> For endpoint wigdets which have set the suspend ignore flag, asoc
> shouldn't mark them as dirty when ASoC suspend function is called.

Why not?  It will cost us a bit of time confirming that they should be
kept enabled if they're part of a valid path but it also ensures that
we've reexamined everything which is a bit safer.

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxGBpgACgkQJNaLcl1U
h9DkLQf+OKqsK1Zua2jcDdEyreppTKhTWLVu+w9YS/unkWuW/zLRj+Z82nDuK0G+
F5Xr+9jU5VKKjNq3582PUQuG0yj1q7gkSfFCz8Ylv9PWZgXDSUAdhAUpExtIVBcB
EWONC1kQrRiCcf+gMz22SNtdiJsT6SNHEXx11Y7W96OxU6d1IFbvreMcs7RehyHE
3jvLZIVIABBHxpIfVAi3GtGnI9rEZMJZ/Jw53XnuZEOF0hgNSlbqVsxnh6mFdyuL
m7PbcbnyZKlAKX2w4XOsST2b2b7gU8jZA6sW5zaYT/4BsA/fdsYCokfJ7Ahg24x5
z0Eoqw1c+S4AS5jnErevpNM5WXc3Hg==
=MD7S
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--
