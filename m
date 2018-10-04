Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635A8C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E092082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Z7gM5t2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E092082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeJDWUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:20:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37108 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeJDWUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MrK/bIqfBV6rYP2aIfQK3ZuEfuuXPFSNeAj6fhXTN7w=; b=Z7gM5t2nO0fPwiI4mNkHCcRVD
        DDka5TpW35S27UjXFesLGfKejDneGYtOg0yesc/JVZ8SM7edxnDxNBw2x5oF4seGvE0HiEpWw4xQL
        JkOGUHpGF7KzqckuMfzNPATfUJrDtglhk6onZ0izR1W+5TzfvvJ3dJcsotXZOlLakugq0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g85WL-000065-7I; Thu, 04 Oct 2018 15:26:33 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id CB52E1121C82; Thu,  4 Oct 2018 16:26:32 +0100 (BST)
Date:   Thu, 4 Oct 2018 16:26:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, oleksandr@natalenko.name,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jan Kara <jack@suse.cz>, aherrmann@suse.com, mgorman@suse.com,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bfq-iosched@googlegroups.com
Subject: Re: [PATCH] block: BFQ default for single queue devices
Message-ID: <20181004152632.GG6412@sirena.org.uk>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
 <CACRpkdYG2Y=rspbZ_o=H3REXTEfOcaiqEyQD4kzO=G=d63V3yA@mail.gmail.com>
 <20181004101305.GA6412@sirena.org.uk>
 <1538665857.230807.1.camel@acm.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MiFvc8Vo6wRSORdP"
Content-Disposition: inline
In-Reply-To: <1538665857.230807.1.camel@acm.org>
X-Cookie: Safety Third.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MiFvc8Vo6wRSORdP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 04, 2018 at 08:10:57AM -0700, Bart Van Assche wrote:
> On Thu, 2018-10-04 at 11:13 +0100, Mark Brown wrote:

> > Further, even those embedded systems that do use udev (some of them do
> > lean heavily on modern init stuff like that and systemd, especially when
> > boot time is a priority) they'll still need to get the relevant udev
> > rule installed somehow.

> Are you aware that the systemd source tree includes a set of udev rules?
> See also https://github.com/systemd/systemd/tree/master/rules.

Yeah, but then you're back to the situation where someone needs to go
pick up a new version of systemd to get the new rules along with the new
kernel.  It's not insurmountable but it's an obstacle.

--MiFvc8Vo6wRSORdP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu2MSgACgkQJNaLcl1U
h9CDyQf+JMqi89C2uTWtYWW5I71q2dGmqnV0LsNCexXB7CbHPfnJCJqbERS0s8lz
oNC2wGensy/PhfnJkASWnlWYBd6XVJD5dn1TFqrOWEYCQwt55g/VwSwWYVQ3yGdX
wTEr9SRvjPbTx0qwVA+eEpGTpKI0TcR6SXsiVkGta5TG/+SEaMOeE6IQQCc/WgFf
I8Qg0RTvU2/QPIHggb2aLd5o/psU0kXQ3AP2ZBq+mJZWmBG+5meULIlR/ljyEiHM
6kKh2f5PeNNPE8ApaAdLP03IpjFd0CcjsobTWh3uAFpLkKtSpSjU+eYP30wAqZ/K
ywRiIyh4OO7P/XjgiN7jsEDAtDXSNA==
=Ux67
-----END PGP SIGNATURE-----

--MiFvc8Vo6wRSORdP--
