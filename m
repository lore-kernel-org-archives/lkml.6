Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA9DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5B720870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="cYOjrCnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5B720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeIJTOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:14:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32772 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbeIJTOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QdogK+Ak2py2LrhN7XtqqL4CaidQnfDwiGThmP5/l/s=; b=cYOjrCnSyO8XV77hEUjSDrMbg
        kofl0a/Frz6MglJbVlpwvxSwSzTduCQeMvyi1ae5FcFirYM5GOXuNk2jGV+3hUO1TUAYwsmqfOPkx
        8xaPrl4uh/9DKLPv3/p6i8B9Q6hLTvBdMPqCveYX1WAse3FnFvNDeI06Yn8rBuoVT9A7c=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fzN2H-00023T-4X; Mon, 10 Sep 2018 14:19:29 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AAAFA1122D51; Mon, 10 Sep 2018 15:19:28 +0100 (BST)
Date:   Mon, 10 Sep 2018 15:19:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com,
        bgoswami@codeaurora.org, plai@codeaurora.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sound: q6core: Use kmemdup to replace kzalloc +
 memcpy
Message-ID: <20180910141928.GI5856@sirena.org.uk>
References: <1536395780-18725-1-git-send-email-zhongjiang@huawei.com>
 <1536395780-18725-2-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FK65GREB+Evh/hTL"
Content-Disposition: inline
In-Reply-To: <1536395780-18725-2-git-send-email-zhongjiang@huawei.com>
X-Cookie: Yow!  We're going to a new disco!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FK65GREB+Evh/hTL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 08, 2018 at 04:36:19PM +0800, zhong jiang wrote:
> kmemdup has implemented the function that kzalloc() + memcpy() will
> do. and we prefer to use the kmemdup rather than the open coded implementation.

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--FK65GREB+Evh/hTL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluWfW8ACgkQJNaLcl1U
h9CyUgf/XqtV7Eclu39YGeJCdlYnt7Hq1XT9fgf87Qtf3o+Z0bBqDZQqhRKHusUh
Jz016WEw/y/szYZFnsVofz28QnFv7tEt6lazhaKyM5d++8BliGvbHZoeXobbWI3C
Z1gMCl5TfPL4JDVwDgTn2p70azBShev3+wygQQ/etQfO7iEBEaZltIPFDwQlsDHy
TG0XHCdajCOOtbwRPPnm1IOmcZbNOMQ3D6YcQ+IJwKOda+LC29O0McDm8RhoXvVD
RjUXKMSo0G51U5PDT37gsJ/S1Uhxr28aTl0h164WKQXyTdCputwPrQ1h3nIVvsWM
nenQ5ghluDeP3aYVSmWMN93sqtPqjw==
=OELS
-----END PGP SIGNATURE-----

--FK65GREB+Evh/hTL--
