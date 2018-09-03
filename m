Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A389C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36B620779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="JwKrHMFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36B620779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeICPuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 11:50:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54272 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeICPuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 11:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PzdSRxJvlTduKAgUjNdVijp19p2tc2RgN33sqdEm6U8=; b=JwKrHMFUOqwCI7Gf2NQMDt3Oh
        XwiT2jQ3NoH5r2MnhfsbhSPrkgP80azq02c+7VAufElAyqJkplfgv0oQ3b4d9zAX+99krIpjyP7Sn
        JExXbU+xjjSoXkjOLdgW5xBkfAoZRAdT29rtkAzLYZR97j+4yq+DHjyGKq2jMjUDppnSQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fwn42-0000C9-Mw; Mon, 03 Sep 2018 11:30:38 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 47B0E11227AE; Mon,  3 Sep 2018 12:30:38 +0100 (BST)
Date:   Mon, 3 Sep 2018 12:30:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Remove regulator notification
 handling
Message-ID: <20180903113038.GG10302@sirena.org.uk>
References: <20180831181737.29516-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UKNXkkdQCYZ6W5l3"
Content-Disposition: inline
In-Reply-To: <20180831181737.29516-1-afd@ti.com>
X-Cookie: Inside, I'm already SOBBING!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UKNXkkdQCYZ6W5l3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 31, 2018 at 01:17:37PM -0500, Andrew F. Davis wrote:
> The notification handler sets the reset line but never re-enables it
> as no one is listening for an enable event, this is certainly broken
> and was most likely just copied from other CODECs, remove this code.

Why not fix it?  The usual pattern would be to take the CODEC out of
reset when bringing the bias back to standby.

--UKNXkkdQCYZ6W5l3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluNG10ACgkQJNaLcl1U
h9CxQAf/eZmq7ergT3Yp4xEktCTGm+7YASMCJsBlRbOdZSU1p3GJZnc4Okd5l5uI
KQHpzPS5HxdRYSwgHyA40fsMKw52xn7hDfIdzDU5cAw1VNabtMvb7y0eNcYlRRlI
MAY8trQ99JS5Ztho+D3sV3I+ciu+DNP0nZIQligedUDYVmHrSh/2flGHQRGZOAZL
NLr3Vwa5eIsmqBA6YzuZhlhiBrSIHDWpYyoovON6b4OYBgEW3+KeJP9HUwHOXbqt
BKxxD/5+k5oLi2yW9nSocxMQt105P70GTqYDC2ZayRckVTB/85erZi5xfSY6OlBJ
pnzgTxZU3OV2qf/hEUdOm2g37A+zMg==
=fMUk
-----END PGP SIGNATURE-----

--UKNXkkdQCYZ6W5l3--
