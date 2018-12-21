Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEDAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA7221720
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391613AbeLUTTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:19:01 -0500
Received: from mga12.intel.com ([192.55.52.136]:46826 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391592AbeLUTTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:19:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2018 11:18:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,382,1539673200"; 
   d="asc'?scan'208";a="103892744"
Received: from unknown (HELO jtkirshe-MOBL1.amr.corp.intel.com) ([10.252.206.126])
  by orsmga008.jf.intel.com with ESMTP; 21 Dec 2018 11:18:58 -0800
Message-ID: <7478abbc4022a29414367cacdac1b89bff18c54c.camel@intel.com>
Subject: Re: [PATCH] net: 80003es2lan: fix a missing check of read failure
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 21 Dec 2018 11:18:58 -0800
In-Reply-To: <20181220212359.564-1-kjlu@umn.edu>
References: <20181220212359.564-1-kjlu@umn.edu>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-+YbPRRiB0GEbaxIaBGso"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+YbPRRiB0GEbaxIaBGso
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-12-20 at 15:23 -0600, Kangjie Lu wrote:
> When e1000_read_kmrn_reg_80003es2lan() fails, "kum_reg_data" is
> uninitialized and may contain random value. However, it is further
> used in the following execution, which will lead to undefined
> behaviors.
> The fix checks the failure of e1000_read_kmrn_reg_80003es2lan() and
> returns with its error code if it fails.
>=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/net/ethernet/intel/e1000e/80003es2lan.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

This is a good catch, although we do not want to exit out on failure.  I
have an alternative patch to resolve both issues, which I will submit later
today.  Just need to finish holiday shopping for my wife... :-)

--=-+YbPRRiB0GEbaxIaBGso
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlwdPKIACgkQ5W/vlVpL
7c7iog/7BxLiCagwOurMC2peeHxluDO2ehrVQmtZd0DX/c9hGjriznThvo/3xxa8
xgTu4J1te9bMSr7Gl8zt2dKlEIbwoBcdndDSnjVR7t8utuqw4BDyD3sCwXXcn5EU
vS0G73d5PAAJEhpXbzFD9f4Ldbd8hk18aq9K9KCuPLO5RkTCD6S39lIQg1B/+76F
AegW24mPISmz7Qh1VV0wjJD+vpP1YQ6DxoUWs6EIiRi0Pln25Fbg3FBKwp0wGoJA
Ep+qviTtJm4RqNQekcwLpH3S9wMOxsFSrxTW5HHLy3sRTzjDn1+qQMKw7T+rCZ2R
dS4exRbS3qzq/K9ouERiXRr0dosimuIw0mEbsS8n598HjHkqxw79UDZoFK3xKpiW
qRAb8241paF4/3YibxHfDoa7Fzao19ysZH4EJbxZs2eG6cfKO/+qVvQu6vCZHT8A
h7IBD2zwJJwVxqGmCyVCxI1ODxhQnPg8Qog4WN3xmTfwqBueXGr1mPnBKYAMVCT1
QmWFxEM91TBi9s6R7j6qDo2zR1c+ctK1lIQoIoJSkL35XSS6H0txQrQKCbP/fTdX
17dLttnCQo1ErEFXVDdZzJZGGHHdXnnbf5KtcWHn9Pzo12r3NDWeCYIj9rlSV3nH
kBlRlYC195ESeTa1JMEdfdgSfPJGkxBBWJB55DBj4FcGka2/wKk=
=/GqL
-----END PGP SIGNATURE-----

--=-+YbPRRiB0GEbaxIaBGso--

