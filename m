Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFF5C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD4720866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="V6o5smqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD4720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeILPY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:24:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33272 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbeILPY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GAnE4sRvEBkW5TyvPTEdSCotL2YJTzz3l+XtHjI63S8=; b=V6o5smqdli6XLH5xE7NJN+b9o
        bgY5RHFg0dnHgSjMlWC3ZturJQfnvsNtTaIi9fygD+vcXtnV0eaLsb7qr1R6wlECLNiIVJ+1whhNc
        NACV3Za29v9b5M+xqcyX1fBJ97Tgm/0C+Oy1hokgEY4veRKGddHaqDfg5Rjk++dSXMZBM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g02Fx-0006XV-2e; Wed, 12 Sep 2018 10:20:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A45541121C6A; Wed, 12 Sep 2018 11:20:20 +0100 (BST)
Date:   Wed, 12 Sep 2018 11:20:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Sriram Periyasamy <sriramx.periyasamy@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Revert "ASoC: Intel: Skylake: Acquire irq after
 RIRB allocation"
Message-ID: <20180912102020.GB6062@sirena.org.uk>
References: <20180910211718.200802-1-yuzhao@google.com>
 <20180911211246.31914-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <20180911211246.31914-1-yuzhao@google.com>
X-Cookie: Place stamp here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 11, 2018 at 03:12:46PM -0600, Yu Zhao wrote:
> This reverts commit 12eeeb4f4733bbc4481d01df35933fc15beb8b19.
>=20
> The patch doesn't fix accessing memory with null pointer in
> skl_interrupt().

Please use normal subject lines and so on even for revert patches -
they're patches just the same as any other.

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluY6GMACgkQJNaLcl1U
h9DGywf8DYNfd/WiS0dCivsUNwaEIUEC+QB9mCA4l5HmfQii3lFaSziKcBqJzbs0
cQXS+ezZAqOErrH/ZszCv3uwu/FIx8Q9UsTYwrsyBkPydK//hcnpNOtns2y3ZpXO
5k+8lovzua3TXBtFpyfoLM9eiQaludSHffvI551/I91+2qJhmKCMMhcdNWFuIN+A
+D5RbPPfGlEibsIJKMV7Vyspw8X9tDGWDapndp2VBjw4/RjO9kqLKvcQkxdwS2Ce
L78kK4mWKfEu6ZWm0RbbHKTLDIV89VLUeyEQO9iEDCudqW2rU3hAVZcHwIpCNiLc
FTTl0DSLcnhPCMSRJwQ9xq11nJ8tQg==
=uAdh
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
