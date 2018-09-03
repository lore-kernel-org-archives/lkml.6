Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5ACC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE30420843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ZVrcL687"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE30420843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeICT3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:29:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54074 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeICT3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rRB2zvy+SrWvjl8bGTlrM/IezEB0Ek6Up3NE+7SHK/I=; b=ZVrcL6873G+MgbpQ2NOZazkbp
        nXXrPe/G8Wta2CATviyqKWHke+j9cHHV16s/di3ccegNK+BvMY/PwcubhEFK42pD59RYl7PfBwVKN
        FhxPJsqkVcf0i6q6PpYQ+0SK3iqRFYboL659IjDFhe8ddLEdOI+MHs7EncH9mXQOIy5GU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fwqTX-0000Qd-UH; Mon, 03 Sep 2018 15:09:11 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A5D8811227AE; Mon,  3 Sep 2018 16:09:11 +0100 (BST)
Date:   Mon, 3 Sep 2018 16:09:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: Fix useless O^2 complexity in
 suspend/resume
Message-ID: <20180903150911.GO10302@sirena.org.uk>
References: <20180903144937.16507-1-m.szyprowski@samsung.com>
 <CGME20180903144947eucas1p26391f4de6bd46d18cf51f075e6f22e2a@eucas1p2.samsung.com>
 <20180903144937.16507-2-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GPOl6LAGMgeiWDic"
Content-Disposition: inline
In-Reply-To: <20180903144937.16507-2-m.szyprowski@samsung.com>
X-Cookie: Inside, I'm already SOBBING!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GPOl6LAGMgeiWDic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 03, 2018 at 04:49:36PM +0200, Marek Szyprowski wrote:
> regulator_pm_ops with regulator_suspend and regulator_resume functions are
> assigned to every regulator device registered in the system, so there is no
> need to iterate over all again in them. Replace class_for_each_device()
> construction with direct operation on the rdev embedded in the given
> regulator device. This saves a lots of useless operations in suspend and
> resume paths.

This would've been better as the second patch since it's an optimization
and not so urgent for stable.

--GPOl6LAGMgeiWDic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluNTpYACgkQJNaLcl1U
h9BGjwgAhqUvyqpcWaCsmLIX1szG4WYuI0Ua2w6alah6E0DCv9DmKhmQIaM1183d
0zl5xuVGz+r5NJs6y0BcBNwBCeZ0hCMjyBAlEGntirc0MPhhtatDhVnbO89yESEK
jrIOTDJPDw1A4pZbBdTQ+6Wlr6HP1nABPEYS0bZXVIPC8W3BLcJPqOtM6t4XVULc
C6eNPp4h54OKLzLVSiiOVx1+NZoF7BMEipOn1KMMTlwjHQVi/foQPO8+pd0j2YSl
UcTkbxXQnCrc0K09ifDpi7b4TRBZOs6eieSZExbd53TeMSCRzcEP464TU11fcTyN
ymaU7JRgZq0GtuQ0E2frYjvkhYOJsw==
=HzOk
-----END PGP SIGNATURE-----

--GPOl6LAGMgeiWDic--
