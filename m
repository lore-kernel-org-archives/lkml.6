Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6A8C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D0E21712
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Q4ti55WG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D0E21712
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbeI1FIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:08:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39852 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbeI1FIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wi9yvqu9ios2Pd1r/A7+TrFX27UGn77WevMLeTs5PyE=; b=Q4ti55WGxEdCyK88+o30phQ/K
        EEnQCQUvgWEUkyETsskSAQ7cVTI+5ZFSZCWyvkkMOvcGfNso9xFfubHwYQReP1c44haCnxl5VTbdP
        tKd5CRcPC8O3JYmRGLcRtGnVcRpGVgsngdPiBkswsz26yH+sr1wEqldqH9AlMgCPiwxis=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g5f48-0007V3-D5; Thu, 27 Sep 2018 22:47:24 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id CCE5C440078; Thu, 27 Sep 2018 23:47:23 +0100 (BST)
Date:   Thu, 27 Sep 2018 23:47:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?xJDhurduZyBUcuG6p24gSGnhur91?= 
        <dangtranhieu2012@gmail.com>
Cc:     robh@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: spi: fsl-lpspi: Option to allow stalling
Message-ID: <20180927224723.GF20825@sirena.org.uk>
References: <20180925203701.13605-1-dangtranhieu2012@gmail.com>
 <20180925203701.13605-2-dangtranhieu2012@gmail.com>
 <CABGGiszY6+UDwzfuS6ob0C1zcGL4DfhcZ_iYjUGSXwWcbjPYRg@mail.gmail.com>
 <CAAObPoHOEYrDj8uoFK-gW8jvy8i-vtRhTkEEm5aVNn8ucLxRMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TUvp6TiFcfhGC84w"
Content-Disposition: inline
In-Reply-To: <CAAObPoHOEYrDj8uoFK-gW8jvy8i-vtRhTkEEm5aVNn8ucLxRMg@mail.gmail.com>
X-Cookie: Disc space -- the final frontier!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TUvp6TiFcfhGC84w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 26, 2018 at 09:37:39PM +0700, =C4=90=E1=BA=B7ng Tr=E1=BA=A7n Hi=
=E1=BA=BFu wrote:

> Default value of the register is to allow stalling (NOSTALL bit not
> set) but the spi-fsl-lpspi driver defaults to setting the NOSTALL bit
> in CFGR1. To me, it's more logical to leave the NOSTALL bit off with
> fsl,nostall binding to set the bit but as I am not sure if there are
> other drivers depending on the NOSTALL bit being set and not wanting
> to break other drivers hence introduction of this binding to keep the
> current default behavior.

I can't see a situation where you'd actively want to report an error
rather than stall, stalling allows us to handle things gracefully by
restarting things.  Even if it's a timeout situation it sounds like we
can unblock by reading/writing the stalled FIFO, and normally you'd be
resetting the entire IP anyway.  I'd imagine the driver is this way
either through an oversight or because there's some bug on some silicon
which means that stalling breaks.

Probably best to just always enable stalling unless I'm misreading
things, if it is silicon bugs on some versions then either a whitelist
or blacklist of SoCs to enable on (depending on how common the bug is)
would be the way forwards - that way SoCs where it works get the benefit.

--TUvp6TiFcfhGC84w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlutXfoACgkQJNaLcl1U
h9ABMgf/czCL8Xz21qJvcfFwf1QCjMgUyRCWY9a16J/vrdk/aDgSAtCrloo/6M6e
Q2hByQEEQzinBT10Y280ZFhpfdqOCLJcXVGtEC4QIXUdY0FeNRWFvNyh2ipJ0WB+
ovlbt0puUcGIX0BQHCW/k9Yd33r5fawXq9ZYmmota43b6JjT+83LIXD8YwF+3MFH
RtRvcfN7hp09oQO1xiWsdbY8JTnvlnbV4Sriij8eMnlDBXfiAHEEcmZbeZ0kZ5M4
Y/x+x0A/RZgws5P2WKasI0DTbp3fJj72hdbStB7vfwXOcOmzAzGk6assdQNGgrKi
OFk3SNnVV8OGl7rwuNvyZ74whmIJqw==
=1ny+
-----END PGP SIGNATURE-----

--TUvp6TiFcfhGC84w--
