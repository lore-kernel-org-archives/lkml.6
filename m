Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06791C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7453222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550256745;
	bh=LekRTZR9Vkie1bZGlw6V88qsGGaqqcDb/Us4TjBVcUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IzYjSURRDk3KoBEk09N2/E43c/ddTwKtJSNMdK2MLWI+myZtYDK9bhh3YUsPXJa0W
	 l+YzsU81gfRkIQMeSeEivPM46IqIHvt8KqAjlWJMZT+sxDPSZ3E31xasr0bjeL/68i
	 l4Ia5TZvvwyTXFxkvZsGB9/xHv778LXhe98b6cbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbfBOSwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:52:24 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52528 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfBOSwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8qR40ZC+e9YK0rsc5uJ5+eiqEVuDiidFJ7N+XNLUBh8=; b=VpH8YuDe0xki0RDP8di9dkwrv
        Vw+oaiytt2TRY0YsQRGRfCJB+0FY/OyBs76ZKWmHE2a0wtD2NdZkbg5d7WNEaLXHV+h2iqjieQ6p2
        HFqXVvbUXBl4QRtiAJZj8nA8rdGKUvldfzBnYmUCobAJcy4xMgpbKYleHOHxqZV12e7VQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1guiaV-0000tf-JU; Fri, 15 Feb 2019 18:51:51 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0A9ED11286B7; Fri, 15 Feb 2019 18:51:51 +0000 (GMT)
Date:   Fri, 15 Feb 2019 18:51:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "kernelci.org bot" <bot@kernelci.org>, tomeu.vizoso@collabora.com,
        guillaume.tucker@collabora.com,
        Dan Williams <dan.j.williams@intel.com>,
        matthew.hart@linaro.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        khilman@baylibre.com, enric.balletbo@collabora.com,
        Nicholas Piggin <npiggin@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Adrian Reber <adrian@lisas.de>, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Hocko <mhocko@suse.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
Message-ID: <20190215185151.GG7897@sirena.org.uk>
References: <5c6702da.1c69fb81.12a14.4ece@mx.google.com>
 <20190215104325.039dbbd9c3bfb35b95f9247b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ulDeV4rPMk/y39in"
Content-Disposition: inline
In-Reply-To: <20190215104325.039dbbd9c3bfb35b95f9247b@linux-foundation.org>
X-Cookie: Neutrinos have bad breadth.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ulDeV4rPMk/y39in
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 15, 2019 at 10:43:25AM -0800, Andrew Morton wrote:
> On Fri, 15 Feb 2019 10:20:10 -0800 (PST) "kernelci.org bot" <bot@kernelci.org> wrote:

> >   Details:    https://kernelci.org/boot/id/5c666ea959b514b017fe6017
> >   Plain log:  https://storage.kernelci.org//next/master/next-20190215/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-collabora/boot-am335x-boneblack.txt
> >   HTML log:   https://storage.kernelci.org//next/master/next-20190215/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-collabora/boot-am335x-boneblack.html

> Thanks.

> But what actually went wrong?  Kernel doesn't boot?

The linked logs show the kernel dying early in boot before the console
comes up so yeah.  There should be kernel output at the bottom of the
logs.

--ulDeV4rPMk/y39in
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxnCkYACgkQJNaLcl1U
h9C80AgAgd27KFeIsKCGWeXoSKrX1pbokLajTcvGXF+ITEiv7vS0eBekb9KG/Wvx
FuKCmuN4yRBKT+GgPSTv6oMwJjnicGFiU+k8bqwROu2SuNqnJwACl2fLIgbuIB4D
jWNGxS9rsjRn8jVSsm0/kk38szs6jjUnMtoL73XT5UBNm6rZS5iLhEI6kjCJkBvJ
1yvgLPdLzKhsdm/GCWfol8BVp4re2bLsRmrrMeEzyQsTazQK/umjNbby2DSILlAO
jB0wvg1elRjdqG/F6cSZLtQEwdJLGKhv1ETMtG9fWQXzQvmNwYOQI6+KbzJ+FZcx
L1nTT0hILYzXvjtkZKJ9fjOR7Uu4Aw==
=M5GD
-----END PGP SIGNATURE-----

--ulDeV4rPMk/y39in--
