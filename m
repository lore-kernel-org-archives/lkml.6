Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67029C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0885A20869
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="reSXMF0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0885A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbeKQNdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 08:33:46 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41140 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeKQNdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 08:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7b9MGET51iroyCUkf9QXf52WvZML83T018e8qTM7i60=; b=reSXMF0OiKzYLcnmsQAJ1mKOO
        DFoTe83uIXLzdArxrGt6mJIX9/lpTDhkWlc0LIk7pBQ7ga0y5i9hDIILxVc2v0TZlmbX18qVkVAB+
        gG1+afgmm+bvMzLhCcI1Rv+6OtwD/WFmVQK19T+Qpl+V47aMcifM6+thK9PQ6m8JpI7CU=;
Received: from [204.239.253.216] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gNr80-0008LT-G2; Sat, 17 Nov 2018 03:18:36 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 0B81E440078; Sat, 17 Nov 2018 03:18:29 +0000 (GMT)
Date:   Fri, 16 Nov 2018 19:18:28 -0800
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org, oder_chiou@realtek.com,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        tzungbi@chromium.org
Subject: Re: [PATCH] ASoC: rt5663: Fix error handling of regulator_set_load
Message-ID: <20181117031828.GZ2089@sirena.org.uk>
References: <20181116092856.47815-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gsAOdWNCzgDntp8s"
Content-Disposition: inline
In-Reply-To: <20181116092856.47815-1-cychiang@chromium.org>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gsAOdWNCzgDntp8s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 16, 2018 at 05:28:56PM +0800, Cheng-Yi Chiang wrote:
> The default implementation of regulator_set_load returns
> REGULATOR_MODE_NORMAL, which is positive.

The stub does indeed do that however that just looks like a bug - the
actual implementation returns 0 on success and the other users don't
seem to expect to get a mode value back.

> rt5663_i2c_probe should only do error handling when return value of
> regulator_set_load is negative.
> In this case, rt5663_i2c_probe should return error.

However that's also true so the patch is valid.

--gsAOdWNCzgDntp8s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvviIQACgkQJNaLcl1U
h9BF8Qf/QHncvy21Ygh5WxTV59yvLFIGXBCAio35pWeeQzTdoC7vGJrrst3lA+Ja
23I/AGM8vLl8So9HH1k94IZdq3LuSg9j1u1+AavXwB14Ifyx6oLHrFDuc01+3DhN
v1Jg3v8MDc6LVdTpxEOBO3Jq+75d4PC5zmkmKLcJLQRy1LU3zPhkY2ItT63/KMhi
cSzp0qlg9nF45HiheKbzekFZRw5gq1+9CwJBjanRIsKvokgC+59kssDdyGLVzbWQ
R7aBOEaTEvr1quTET1zZuNtLtq6iRGL3eBXEKsyxzc8nIZmTWdkSX1kBcxW6Xsv+
lFX4RXiLPb/lelT5fFJjGryzep6DsQ==
=O3dQ
-----END PGP SIGNATURE-----

--gsAOdWNCzgDntp8s--
