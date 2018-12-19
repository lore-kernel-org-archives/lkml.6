Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F87CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D632218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545241921;
	bh=xUDhF8LOc74wQc4j7SBvsfVJhFKVaPn6jHwzzpxAflc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ir3NBMmX3DmVfj8Mv2OjnaKGb5xtNSuSvTzjw9zRMHuSCXbyqJ8f6jBjZpM7Nm31V
	 cMVKTM6Nva1jJoTyHUwieLkAAkq7Eeq0jTkp6CkTuymUxfNImNFsxgdHqtZHJAT+9t
	 JNLGn1k2D2K7dCvCPinSsCGvaMJNLQ5wPT09CdN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbeLSRwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:52:00 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47220 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbeLSRv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xUDhF8LOc74wQc4j7SBvsfVJhFKVaPn6jHwzzpxAflc=; b=MtQMBJgZ1BXjNVdMNNgaYCSxM
        ZeiDoI4QmWyMtOlF83QdA2LCsa8sI0GHQCjDMZuxCXGCQPwrdl5tfoVvDECqeJ/y1lhYN1z6n0KzM
        68h3J3gn99/7nsNe22bXr0DQmvjRZn7GjWfSQlT7eUZMI1yqp+Bz9OEZLNQv2mAXRgD7s=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gZg0g-000571-9r; Wed, 19 Dec 2018 17:51:54 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DF55611259E9; Wed, 19 Dec 2018 17:51:53 +0000 (GMT)
Date:   Wed, 19 Dec 2018 17:51:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regulator: palmas: fix a missing check of return value
Message-ID: <20181219175153.GK8130@sirena.org.uk>
References: <20181219050413.16374-1-kjlu@umn.edu>
 <20181219171139.39388-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iSeZnk6FyAS3EJ1y"
Content-Disposition: inline
In-Reply-To: <20181219171139.39388-1-kjlu@umn.edu>
X-Cookie: <Manoj> I *like* the chicken
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iSeZnk6FyAS3EJ1y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 19, 2018 at 11:11:39AM -0600, Kangjie Lu wrote:
> If palmas_smps_read() fails, we should not use the read data in "reg"
> which may contain random value. The fix inserts a check for the return
> value of palmas_smps_read(): If it fails, we return the error code
> upstream and stop using "reg".

Ah, thanks - I'd actually already applied the earlier version!

--iSeZnk6FyAS3EJ1y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwahTkACgkQJNaLcl1U
h9CY7Qf9HfSZtw5pzUle7APOfkNoPh3jZG5dXXk8VlXNCXMrDuuoM+9w0LTFOgWj
e+CEoLowUGckkQf+5sPlY+qZBT7z942xfiXwl094TGSN9TZKpzA8kZGrjn1gAZdN
xRb9xO4MVKN4czCGExdv5v18RxT69jMrx0nENGD2krNLQYnYq5Z77L/qiJyjIo2r
oAaN3KMb484UlPoiR2mNSnK22vrqe/zEmPv0fmqBlGDwCLIlsHcTt8MfG8ckZHqv
ULOp9O/mHhAeGhvXLYmh5tqiVyO9WERaMH+t5nfuB+9HfsXpJRHpOPTkmOL6bb/a
1Wk6gu8A66H0DRRDRRB5dD+UxwTlBg==
=HrhO
-----END PGP SIGNATURE-----

--iSeZnk6FyAS3EJ1y--
