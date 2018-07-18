Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23730ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C212220871
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="glT18quv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C212220871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbeGRRZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:25:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58096 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731293AbeGRRZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WNy4uxF+gpWjNJGHndaUSr7pFLb3V6jPVZoK7hr/nbI=; b=glT18quvoYBGXJ8p1+dijiQn9
        8WOD8nmIsQlb4sGl91dyMuRnZdJkrcYLrj/3EE1df4eVzTdEr18h36EK0+AN9ZYzJnILppLEb6TWF
        MBZeEn9EqjjC4cP/3ZSQ97YxbCQlEJ9Yq2WsJ1X8nihqGngD6QCtt5OAyHNZiNBc5BoAU=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffpas-0003n3-A6; Wed, 18 Jul 2018 16:46:26 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffpar-0007TC-G8; Wed, 18 Jul 2018 17:46:25 +0100
Date:   Wed, 18 Jul 2018 17:46:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, agk@redhat.com,
        snitzer@redhat.com, herbert@gondor.apana.org.au,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        jonathan.cameron@huawei.com
Subject: Re: [PATCH 4/5] crypto: Add IV generation templates
Message-ID: <20180718164625.GA20360@sirena.org.uk>
References: <1531899055-29362-1-git-send-email-wangxiongfeng2@huawei.com>
 <1531899055-29362-5-git-send-email-wangxiongfeng2@huawei.com>
 <b6eaf471-7279-ca4f-bb7c-d25df8db2419@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <b6eaf471-7279-ca4f-bb7c-d25df8db2419@gmail.com>
X-Cookie: Marriage, n.:
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 18, 2018 at 10:16:05AM +0200, Milan Broz wrote:

> So we are here again and moving INTERNAL dm-crypt functionality into
> cryptoapi.

> The TCW,LMK  IVs generator make sense only for dm-crypt=20
> for compatible old disk encryption mappings.

> I strongly disagree to move this outside of dm-crypt.

> Sorry, the last discussion was that it remains inside dm-crypt
> and it will be only registered through crypto API.

Sorry, I'm partly to blame for this in that I asked Xiongfeng to pick up
Binoy Jayan's old patch set.  I seem to have missed that particular part
of the discussion and so haven't forwarded it on to him - do you have a
link, I can't seem to see it in my local archives of the prior
discussions but they might not be complete?

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltPbuAACgkQJNaLcl1U
h9BELQf/ZVNZaHHO4wZB1eQXBBRGH3LDh1M1jHFuxM9lbL5fZmO6i9Pm0ANrcKSF
rH0flmXeHkqCM5PNKkN4DH3PCPihEw/ZSt6zW09RhwqS65R12vQnCQbVMNz2lW0u
WNhJmJcxUoZSwRMzC4mt17417CufbYXm9/rfXwDgfSDQlp71/L6yjEoHzLsVTaw4
kJMvNzmM0uHqFU+r4ssPY68hvsd40mqcXcFRtf+TdDOf35EUvh2hZ8vF2NujlXxP
xGpRYbyKEWzQREpgRkf0mdj2eTbUjkTPHvNYOOZM7J0mfQdxGBVn63ZmJlhVuPUK
9CA5VXOfVnVs9Cs1DypKjj+mJFECMQ==
=GqVU
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
