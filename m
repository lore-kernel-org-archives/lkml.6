Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34346C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066BE20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551115536;
	bh=m8CpWKVmkqJNiOr5qJzpt19O1RMo29EQUf0kwbTk/yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RtDUQXCAdogCt1DohTF/eIhEMAre7FK0b8ixo6U9Cakvw2mDyWR1305mdN5Sue090
	 EiExhMolg1JHnYjHnmtBOyz5nv8T599LgVUhx9rKepN5g9gm3vgFQVPoUyPpBuP6Kz
	 BimgUvR2xE4hIjzGMhYIL+2cMdz7aD3Jh/d/LDuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfBYRZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:25:34 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39164 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbfBYRZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Rw8YuSzJmpZJGSbRKxxlSyiTaQyTin6mpnDbYmE1LKc=; b=eN+Ue5A/tHNdYLTC+mW3qVLb+
        mS80SXG/mHYwxWUgCrfKLPI8F2m1H75d90PypnKOW10798f024V8HAhpZcEaWgA7h1Itho5DMWQrL
        lHGjmdlI8mhzk9NguKyFPZqCj7JU63F6jgDLXhqTaHDnIkWz9Arbu1AAqshAJezRnlhaU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gyK0G-0003UO-VR; Mon, 25 Feb 2019 17:25:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E80631128354; Mon, 25 Feb 2019 17:25:19 +0000 (GMT)
Date:   Mon, 25 Feb 2019 17:25:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Olliver Schinagl <oliver@schinagl.nl>
Cc:     Axel Lin <axel.lin@ingics.com>, Chen-Yu Tsai <wens@csie.org>,
        Priit Laes <plaes@plaes.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: axp20x: Get rid of AXP20X_xxx_START/END/STEPS
 defines
Message-ID: <20190225172519.GD13898@sirena.org.uk>
References: <20190220165013.12774-1-axel.lin@ingics.com>
 <24E35288-677D-4223-B94A-52A4F37792A8@schinagl.nl>
 <CAFRkauAPGEBxj7k2GvmFwhyc7ZuofhXou17b75F3G-mUWVaf9A@mail.gmail.com>
 <20190221094237.GA5970@sirena.org.uk>
 <d52c2711-71f3-9e72-f01b-e761f4a92a07@schinagl.nl>
 <CAFRkauDdx00VmqhmzohdCyWbPkctCU2D03JqkpSw2x7n-bDzHA@mail.gmail.com>
 <15e97e28-0008-cda4-176d-a3feb9ad4e8a@schinagl.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Content-Disposition: inline
In-Reply-To: <15e97e28-0008-cda4-176d-a3feb9ad4e8a@schinagl.nl>
X-Cookie: Neil Armstrong tripped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 23, 2019 at 09:37:01PM +0100, Olliver Schinagl wrote:

> In any case, you seem like a smart person that reads and writes hex and
> bits often enough. This is not true for everyone. I can just as easily
> reverse your arguments of course, for example, 'each field has a well
> known meaning' ... to whom? People that use these things daily, sure.
> People who just need to double check something or modify something, not
> so much. They have to look up the MACRO, the struct its in, compare it
> to others, so as you can see, what is natural for you, is not true for
> everyone. :)

> Also, the general consensus is still to avoid magic values, and to stay
> consistent with the rest and not make expceptions, it makes sense to
> have defines instead of magic values.

If you find you need to describe what the fields are it would be much
more constructive to add a comment at the top of the table saying what
they are.  As things are this isn't helping anyone - as a big pile of
defines it's hard to read the values without context for how they're
used and if you're looking at the table you can't tell what the
regulator actually supports without going and decoding the defines.

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx0JP8ACgkQJNaLcl1U
h9AV4gf/ThB7jH0R+Q95S8ZXGxbTkKjKwhtv6xxAM2CWrMsTdguT5B6Ai3C9YMtR
6h+5kpFnnhNmU26bcKWl4W+29B19riYdIxjAul6o15DtM7ayjmIwgXfjVMHUAzUf
rpoGadNsr02auq0YYZ5gXI6PkswYuI72tM6Sv5WBWCNLk9kuurjqypWFFpfgKUF5
3F+Zl5LIIFq2jHvayyiB0RZ9Br7HISWRc35hOD2obNyaSvzKaFfFUCLplndVwlW6
euOeKgNo8NTDWZ1arES7E9ZkN4rV06doSKkCGGQ1gIEDz+etbt+NCeUIrHIvKaBE
Ved7YAw5pjjrEL2jPsLTBeeSok2TkA==
=m7RT
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--
