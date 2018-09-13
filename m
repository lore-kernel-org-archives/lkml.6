Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09561C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E3920861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ueTaXWfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E3920861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeIMQlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:41:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55804 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeIMQlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cyojIyPYN8nNoD/S8SuleC910O4uqPhx2AngbXYbgyw=; b=ueTaXWfoQKmzla6/s4NquKcTs
        wSfBGpJZ1IsSX9RuOxCENpMnEYaWszg3H0ETy7eMRupsd7XchqgqR0b1cj15G4xn53L73Ch0UCdT8
        sczLSDy8pa2l/kCEwgsyVBNnvmIgqLVYJmKRslBqoBBlosFFlnUW52P087P/0+NXJdW/A=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g0Pql-0000IL-KP; Thu, 13 Sep 2018 11:31:55 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5EB9C1121CA5; Thu, 13 Sep 2018 12:31:55 +0100 (BST)
Date:   Thu, 13 Sep 2018 12:31:55 +0100
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
Message-ID: <20180913113155.GC8411@sirena.org.uk>
References: <20180910211718.200802-1-yuzhao@google.com>
 <20180911211246.31914-1-yuzhao@google.com>
 <20180912102020.GB6062@sirena.org.uk>
 <20180912193221.GA194302@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline
In-Reply-To: <20180912193221.GA194302@google.com>
X-Cookie: You will be successful in your work.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 12, 2018 at 01:32:21PM -0600, Yu Zhao wrote:
> On Wed, Sep 12, 2018 at 11:20:20AM +0100, Mark Brown wrote:

> > Please use normal subject lines and so on even for revert patches -
> > they're patches just the same as any other.

> Well, they seem pretty normal to me, and have been used by many:

Many people do them but that doesn't mean they're good practice!

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluaSqoACgkQJNaLcl1U
h9DOxAf/Sg3eVYBP2uScARjWPUawo8JKhyX7xlU/Ddg3jYqux6XSmgswNXpWDRdR
ICOjitwnTXT0/1kS5F4wgrPMJgaeWPvstMgVYeUfN6HijsgGWvGe9HOOcTxpigsF
ffbf8pDEF6tchp5AMd6GjVwU/PE7EhIlnWvxAlesis1Qs8tbw7pNWR5Rmwp3JkJq
NWc+W9bCmLS9az4VvyoiCO1p6lYdRxbW6tfkDttAiqL75FCnrW5p1unbOPgBBwo6
/pJ4Myj/iY/Ic0FvIZxJ7XQUAkmI3RMuL/MtqcckFxU5T7+5/OzRWS3jVYuqfWWf
gttVuD7vBx1lj92yChjQFyRrxZmJcQ==
=MtNH
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--
