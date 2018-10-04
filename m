Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66342C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1705E21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="tfSUVPyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1705E21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeJDRGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:06:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47378 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbeJDRGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b5R1YZ4WvzqAMFQ4o4ee+cvhk8glspoGLFm+o9aXkkI=; b=tfSUVPyHWVauoLKcdVz1s/m8s
        zgObCAZlM9KeVcEUQT7UjiO5LMgZPem1SZurwkFo/M/FAalbLuDn0OLzrskKQH8yrLe+kNHcZLl2Z
        onc+6+QO217ZXeOSE1HHt8VnxjxEGOREiyp3SMfYXTk/i8MiNTlhp4FqzBUXEBwJd/2vw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g80d0-0008GZ-55; Thu, 04 Oct 2018 10:13:06 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C40A91122286; Thu,  4 Oct 2018 11:13:05 +0100 (BST)
Date:   Thu, 4 Oct 2018 11:13:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>,
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
Message-ID: <20181004101305.GA6412@sirena.org.uk>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
 <CACRpkdYG2Y=rspbZ_o=H3REXTEfOcaiqEyQD4kzO=G=d63V3yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <CACRpkdYG2Y=rspbZ_o=H3REXTEfOcaiqEyQD4kzO=G=d63V3yA@mail.gmail.com>
X-Cookie: Safety Third.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 04, 2018 at 10:14:38AM +0200, Linus Walleij wrote:

> And these are millions and millions of deployed
> systems not using udev+systemd we are talking about,
> they are not fringe hobby projects. It's not that I
> personally dislike udev or anything, I kind of like
> it, but these tailored distros simply don't use it
> and they are huge in numbers. They need help to do
> the right thing. Fixing a udev rule doesn't solve
> even half the world's problems I'm afraid.

Further, even those embedded systems that do use udev (some of them do
lean heavily on modern init stuff like that and systemd, especially when
boot time is a priority) they'll still need to get the relevant udev
rule installed somehow.

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu157EACgkQJNaLcl1U
h9BBkwf/Q9GIidNJDuHpmm+LavB0wocpu32qHC5GsxYNyo2v5lRvYq6YBUzZmG1J
U3aytRnyQh/4/0ttPCUxh/9weXA3P5uyOaQdYz7LMQ2RcsXV0hgqxqvrQAzzUaEA
ZjpzjCa9WxCvwf6RSiDkqzgPfPIXDFRKu9WMBX2hHt9VGMWszD5lJI9FjRUROr/s
QtV4jjf0vvxPDefhe3YuOhYmCAPsgVlSunFAC8LjYilLOxoOIruGD6AfJinr7f6v
6ANVMSrdRGb89J0BgU+FCXO2KJMYx9T0ETsSN0Tbr1FUNPdfFDelyY78qnokMzGj
wV16/LdECx8c5qQ4KSf3CdpNMDOS+w==
=TeIs
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
