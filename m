Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5215AC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109542081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544538376;
	bh=x9iNxP9PHIsohyecxutJaQhQR1ITKvuAOB9FJbZLmFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iYZ4VgnMQaZI1tJBlZGQSH2x9ucQvgwXqLqwnXnUuoXDHtyP+1gDb+0VDKRgmw11w
	 boDWkfhNptyHmT07VjtpTVNddssheL4jsNd7KjZFH2d/PJ6lGHrkF+FRSrv3CFpbT0
	 o0vzU2t4vmvbDFX+nOZDUWstUfMvwO/o7uoQ3tFI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109542081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeLKO0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:26:14 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49722 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbeLKO0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WwVSuC6/bdgUqMBah0m0VUcguMtcEeZiuMn/J+br+UA=; b=aglXg4vUsXoFX4uFbcLDNrxQU
        28aTN22tqLr5I6XkqtZu3e0H9FLXCtdn1lC/KX9E92T3bapvov9srLsNjv0jXXBwSc66Ip8EYWh06
        x6O6wxu8Bafgm1Oxa6VlE/6iQspxDLCIfi3HUQgA6V+2P5c2TLhuX5NX0lshO1MZv66cA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWizE-000174-3e; Tue, 11 Dec 2018 14:26:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9E8F6112540E; Tue, 11 Dec 2018 14:26:11 +0000 (GMT)
Date:   Tue, 11 Dec 2018 14:26:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: lpspi: Add cs-gpio support
Message-ID: <20181211142611.GF6686@sirena.org.uk>
References: <20181204062313.28942-1-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rWhLK7VZz0iBluhq"
Content-Disposition: inline
In-Reply-To: <20181204062313.28942-1-xiaoning.wang@nxp.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rWhLK7VZz0iBluhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 04, 2018 at 06:24:59AM +0000, Clark Wang wrote:

> Add cs-gpio feature for LPSPI. Use fsl_lpspi_prepare_message() and
> fsl_lpspi_unprepare_message() to enable and control cs line.
> These two functions will be only called at the beginning and the ending
> of a message transfer.

> Still support using the mode without cs-gpio. It depends on if attribute
> cs-gpio has been configured in dts file.

Why is this not using the core support for GPIO chip selects?  Note that
you can't just implement chip select in the prepare and unprepare,
drivers can toggle chip select within a message so the code should be
looking at the individual transfers to see if cs_change is set and
acting accordingly.

--rWhLK7VZz0iBluhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwPyQIACgkQJNaLcl1U
h9B2swf/VYU6sQbbpmrPoL0HsQRH99qUTf1tXQ6eoxj1gQV3T8Cir05pDhfjwOMX
uzNvGECzeszzYfcKi/fvlJIbpIjHqFwE//pZHcvFaFROM2ir/VacYzz5V/+LCU2E
CvU8rcxkNFsxPetafRX5c3O3kc6zixC7sfndIF/jzvtdUCjp+JWS18kA3RBif81Y
5IZ5Q75SFckDPN+yHx2lx0Unf5PckD6fEygU8kYc+CgTHGj+C2wwkRVUbiTt0MTS
lK30/mQ2u+i21wS1i1TKVLsCjJZDqF7nHKSCnYw5PEG16Z7tKOPSWVIuN9402rX4
6AT+9x3/YQVyfchjU8s9yMUkRMXoFQ==
=B20T
-----END PGP SIGNATURE-----

--rWhLK7VZz0iBluhq--
