Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5F6C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45B620861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="vc7StuwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45B620861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeIMQkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:40:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54978 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeIMQkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yxNIR5mv78o9pthLYkLxV2o2XWrC2IouMTf/5REYCFY=; b=vc7StuwAR7Hs31ef/u1jk5p+r
        H5nHqA9O2UKcu76CGN590XsGqOz0zSeE8rWEnD78DmzubA5J1DrmyR7rHztMGP/ZZPggsYrpgcBkZ
        Wzu0hGJjNg3Vp2kAyyKK8la9sVTjVLFdGCZ4cJSA8gwbk10zSqYZMm0O+Sd0eT3GuvfNI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g0PqI-0000IB-Mu; Thu, 13 Sep 2018 11:31:26 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6D3041121CA5; Thu, 13 Sep 2018 12:31:26 +0100 (BST)
Date:   Thu, 13 Sep 2018 12:31:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Vinod Koul <vkoul@kernel.org>,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] ASoC: enable interrupt after dma buffer
 initialization
Message-ID: <20180913113126.GB8411@sirena.org.uk>
References: <20180912194343.200443-1-yuzhao@google.com>
 <20180912194441.200564-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
In-Reply-To: <20180912194441.200564-1-yuzhao@google.com>
X-Cookie: You will be successful in your work.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 12, 2018 at 01:44:41PM -0600, Yu Zhao wrote:
> In snd_hdac_bus_init_chip(), we enable interrupt before
> snd_hdac_bus_init_cmd_io() initializing dma buffers. If irq has
> been acquired and irq handler uses the dma buffer, kernel may crash
> when interrupt comes in.

> ---
>  sound/hda/hdac_controller.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

This is an ALSA commit, not an ASoC one.

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluaSo0ACgkQJNaLcl1U
h9DiHAf/TwY1CWZUMP1guYdB+OBLHuODaXob0bzkSWIjav3iHqj4lIkMkZvp46Wd
pTmjdhVOTrhlgFIy1u4tslv6tAwZsc1G0zviFhmT4mNF4J43rb9a6fWnI4lofqrp
fIL/eT5W1F7CBxVAQF9OQTbfutFLC7sQRhqmsKbVVRkmccrZdM91S94AtdKScMTp
4dVXuuLRqasOsRwrX6Io4zRAGeklul3itl4bOYMz3NtJ20eHvwIW35tFElHxaDI2
XgqO875C34FkRx2+fco1vteJzhnwiWaWLH4yOD93focPaXiL9GSZqoGpexq0QRop
2Q8TW8yyYXno+my+k9K2HaMXJg467Q==
=+Pxa
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
