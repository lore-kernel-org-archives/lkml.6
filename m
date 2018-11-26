Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7685C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7625020862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="MJyLJ57s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7625020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbeKZXon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 18:44:43 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46010 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeKZXon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 18:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I8Qi4fFViBcr8gsxZtXKnvhzoI4LbfFbCuss1zudhpU=; b=MJyLJ57s94UqQPf7a3aJdtT4N
        WQQ5ysNvsAIO0neW+ao3fdtjIapFfroW1UcJI8ofJ9Fqp5uGnC3GcPXVF3Kt60W9nejXDNCiGIAPt
        32XS1YKzdjCOZu3feH3cjjODeyXbfO3GPzQqi/PZxJhlmHl9ahPRWAENOUnmYjAZFk6Ls=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gRGLW-0003sL-LC; Mon, 26 Nov 2018 12:50:38 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 20DD6112519F; Mon, 26 Nov 2018 12:50:38 +0000 (GMT)
Date:   Mon, 26 Nov 2018 12:50:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Question about "regulator: core: Only count load for enabled
 consumers" in -next
Message-ID: <20181126125038.GA9715@sirena.org.uk>
References: <20181125093750.GA28055@basecamp>
 <CAD=FV=VuPerEgPPiUKk7-Ck9aVz=oR1CAAzg+0wag1WTrTGKxg@mail.gmail.com>
 <20181125232450.GA3774@basecamp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <20181125232450.GA3774@basecamp>
X-Cookie: Gloffing is a state of mine.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 25, 2018 at 06:24:50PM -0500, Brian Masney wrote:
> On Sun, Nov 25, 2018 at 09:20:02AM -0800, Doug Anderson wrote:

> > I guess this is a workaround for drivers that don't set the load
> > properly themselves?

> I'm honestly not sure when the load should be set in the driver or in
> device tree. None of the drivers in drivers/mmc/ call
> regulator_set_load. The dt bindings describes the regulator-system-load
> property in Documentation/devicetree/bindings/regulator/regulator.txt.

Very few vendors disclose power numbers, ideally the drivers would be
providing power information especially if the load caused by the device
varies substantially at runtime (as is normal if things can go idle).

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv77B0ACgkQJNaLcl1U
h9D6Pgf9HZRAErtZorK24y8ngyRuLd3tyfJGLCdF2hExbTzFfdFKXGY4Bs05fyWG
BP50AObm5hjFsEee6hxuugyjI8FN8JphJUGXvxMB8LYoYoS0jO8Wj8Vvwku+lZiN
8W2NfPmDgW6z6PC/xHcZAQ8Q7KVE5xMy82bu5kPB+cMOCkE3ndD1ctYHw6G4brmJ
xoXEPDl46HfpMF3XxbX0srdC56YipwOWoEbLm6sR2NGXx2yrXdsRIyVwr/iwF3P9
3v4rIYARcRR61N/kPWIpZ9ROWA9WRSVWV2sFGvsDWDwJHBjwp5qEGjjnfDhTfkRI
8J1kJ2GXNvR2NHs0ChS+zGIY9OXDdw==
=20Uh
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
