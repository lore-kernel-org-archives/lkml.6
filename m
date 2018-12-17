Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CF8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B68920874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545072623;
	bh=tVfjD/YFP7/GSA3T0AdtRBS/9baRBHn7uKjVqetKrzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MCef9emwaTXc+1L4Qcq1vKi6tm6YgF+V0WihEaL3NbUUZMkhn95hgyWyfgzZ8aTsy
	 VF27T3dGbL/IoS8L76/fEc8DLYiOQ1cp7olBKLy56mqbfuqqHLFgfdmQo/DkCUiisb
	 0xX88O6qdsOHNeu8Rzf+PBnhueYrRV+Txv0TPoFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389237AbeLQSuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:50:21 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53494 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbeLQSuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tVfjD/YFP7/GSA3T0AdtRBS/9baRBHn7uKjVqetKrzY=; b=jeuIqFUB3tq7CF1zzVUOkUCHK
        68v4cPoLcNW3oSd/IciUcHJffBaoCWscIACY1376vyGvzdznVw8xMoakCcjLZNwVuPy0GwNY5uDrA
        zIzRL+9ViDfG386cZkS0suEGqROUtwaeEVkslKpQlMQK6qKrKzdc9gxwEk+1Ka/OQ4zuI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gYxy2-0003Cs-Qt; Mon, 17 Dec 2018 18:50:14 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 350CB112593C; Mon, 17 Dec 2018 18:50:14 +0000 (GMT)
Date:   Mon, 17 Dec 2018 18:50:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com
Subject: Re: [RFC] regmap-irq: add "main register" and level-irq support
Message-ID: <20181217185014.GH27909@sirena.org.uk>
References: <20181130085908.GA24983@localhost.localdomain>
 <20181204172137.GE6809@sirena.org.uk>
 <20181205082251.GE31204@localhost.localdomain>
 <20181205172701.GH6205@sirena.org.uk>
 <20181207075829.GA24940@localhost.localdomain>
 <20181207131418.GB6510@sirena.org.uk>
 <20181214135819.GA2735@localhost.localdomain>
 <20181214172619.GC6467@sirena.org.uk>
 <20181217081912.GA2477@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+Z7/5fzWRHDJ0o7Q"
Content-Disposition: inline
In-Reply-To: <20181217081912.GA2477@localhost.localdomain>
X-Cookie: Cold hands, no gloves.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+Z7/5fzWRHDJ0o7Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 17, 2018 at 10:19:12AM +0200, Matti Vaittinen wrote:
> On Fri, Dec 14, 2018 at 05:26:19PM +0000, Mark Brown wrote:
> > On Fri, Dec 14, 2018 at 03:58:19PM +0200, Matti Vaittinen wrote:
> > > On Fri, Dec 07, 2018 at 01:14:18PM +0000, Mark Brown wrote:

> > > I could send an example on how the driver utilizing the original RFC
> > > interface would look like. I am starting to think it was not *that* bad
> > > after all...

> > That might help, yes.

> This is what I came up with. I think having the simple mapping arrays
> (bitX_offsets) and REGMAP_IRQ_MAIN_REG_OFFSET macro makes this
> not-so-bad :) I will also send an example on how this would look like
> with the RFC v2 interface.

I think your approach is fine - there's not much difference really.

--+Z7/5fzWRHDJ0o7Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwX7+UACgkQJNaLcl1U
h9BsbAf/QzVfLbwHJE7W0GpUJM0Na0+hSe7nclxpz2vLLdyiavi2QYS79OpbSutD
Jp17hZbetnLpnA7R/wjwN4/aReP4+kDD5GTDpLuOMMaaMu86WIRwtAOKXOuYeoAI
xmv4qhz70+lwv0rF5T4s0IqkxQIzzjT13d/b3qP3BfUTgubHU5k4rnKCEAinW+ab
D9p7MslRhYw3Fq0dppLoxnAEUBBFuqLwj37YMDyj/DgEJ7nH0RXEQ0TVjc5ZBp97
9dIeyMHv5DjdJD1wHyEbVO3O6Tqr8dVTFDZzOm+EgF1CLa+eUOIJbO84S/LmgSIb
wnTYBq7vpFHvKvv3ApiLXiUZ1Gc5WQ==
=WKSI
-----END PGP SIGNATURE-----

--+Z7/5fzWRHDJ0o7Q--
