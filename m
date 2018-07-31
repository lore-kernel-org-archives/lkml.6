Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F8BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD70208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="c4SZsr9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD70208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbeGaQVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:21:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36870 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732260AbeGaQVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9hwHdfiAxmN7Tg5nNt7esKchF7QWf5V9P+UE4ilwHgs=; b=c4SZsr9GpuW6oclL1gbZHhuuQ
        Zc2a14OS6fRA0v1wVKVe8Y7Hj1hsNg+ff07urCtg6M/mtr9QBiwIvudHsK0MNIg5kcmNw4aeO7cxV
        e/yWhQO4LF+ON7MuOOrsflQbHJfrAg5jbSZyCZ0bJdLNYDFpdxVNELrNcnj8kVwIqOTII=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fkVpU-0007D5-Qu; Tue, 31 Jul 2018 14:40:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 844A111242BD; Tue, 31 Jul 2018 15:40:52 +0100 (BST)
Date:   Tue, 31 Jul 2018 15:40:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "Agrawal, Akshu" <Akshu.Agrawal@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Alexander.Deucher@amd.com,
        djkurtz@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-pcm: Use delay set in pointer
 function
Message-ID: <20180731144052.GF5719@sirena.org.uk>
References: <7a88c7b4-d31d-b044-bb8e-a866d49d1256@amd.com>
 <s5hwotc0y6v.wl-tiwai@suse.de>
 <5b3249cb-6212-6a14-b644-7548cf0ad00c@amd.com>
 <s5ha7q721vs.wl-tiwai@suse.de>
 <20180731101943.GB5719@sirena.org.uk>
 <s5heffjr8ys.wl-tiwai@suse.de>
 <20180731131246.GC5719@sirena.org.uk>
 <s5hin4vpm80.wl-tiwai@suse.de>
 <20180731135115.GD5719@sirena.org.uk>
 <s5hd0v3pkyj.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eDB11BtaWSyaBkpc"
Content-Disposition: inline
In-Reply-To: <s5hd0v3pkyj.wl-tiwai@suse.de>
X-Cookie: Save the bales!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eDB11BtaWSyaBkpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 31, 2018 at 03:56:52PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Yes.  I'm saying that if the CPU DAI thinks it can figure out the base
> > delay something is confused.

> Then basically Akshu's patch does the correct thing, I suppose.

I think so.  Could perhaps do with a little clarification though.

--eDB11BtaWSyaBkpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltgdPMACgkQJNaLcl1U
h9C+jwf/bx01Tp500sjkgbIdsaxeTZg926yRoXNkQsXYnb2f/Tl7JW3vKpEBrYUl
tYubOD9m/3XZ7tJOrfn37h03VL4R/Y7Ykx2s3cCDutdiGzaDLMktAxd1c9I9/m/Y
Sp0BS0HJM5rgLk14PObW3E4xxsuxURg6WMP1HRX6Xps1A4yDP6hakNv9fpEHQ6fb
YJuj+zMk3f8feeVIWkMl3HlCTaIRz2dMEfJEZnxfdhW82BMv7HQAlIVWg/axGlWI
gSWxMqARvCOTWGrIvJjRiD1wtI8+MnDGHAe758TC9jcoeXQ0JoxkFIyDbPH6SRZ9
RkdpuibywAcb3hmc7DSIDGJGH4dXmg==
=bkPk
-----END PGP SIGNATURE-----

--eDB11BtaWSyaBkpc--
