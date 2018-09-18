Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FD1C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F6F21471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eVroSsEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F6F21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbeIRRVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:21:04 -0400
Received: from ozlabs.org ([203.11.71.1]:35267 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbeIRRVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:21:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42F1V60T0Wz9sBZ;
        Tue, 18 Sep 2018 21:48:46 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537271327;
        bh=eyqmw98g5NepD7Yxbx3+zvsNHWjQOABo1f+jk+wK22w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eVroSsEqWbilDjM/6JCdJ1BI432OdOinR183hcg4g2RmN2reawEX4xTjfrxEMC6cs
         nMp8UZXCTqDJsBi8sLlG/6KgfiN9PHyI4AdH3UnP3IBM5LY6V4FSSE8u0AyC029lHX
         1FywualEIKN9XOSejhcopZSaVOAe7zUf4c/ueBtEahgs++cK0UBYHd7MMnc+kFUMSS
         FIWZVI+5+IL7BHmGEyA7fpO0PmWNT1NRGUPeTCOnJsZhxbZNVZT2cfbhAAsIXXks+8
         9W7/RR1FE3KCk0s5YLHpV17o+utjBnNICzDkM99wSoy9pwQUoi6twwW7uDec98xymB
         AIcxLApnARkMA==
Date:   Tue, 18 Sep 2018 21:48:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vakul Garg <vakul.garg@nxp.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "davejwatson@fb.com" <davejwatson@fb.com>,
        "doronrk@fb.com" <doronrk@fb.com>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20180918214814.4eae366d@canb.auug.org.au>
In-Reply-To: <DB7PR04MB425225AD548F3A3040250EF48B1D0@DB7PR04MB4252.eurprd04.prod.outlook.com>
References: <20180918101107.74d8689a@canb.auug.org.au>
        <93982e9d-dc78-6423-bb9b-c5773d98e244@iogearbox.net>
        <DB7PR04MB42522B223D4E04F5DA519A8B8B1D0@DB7PR04MB4252.eurprd04.prod.outlook.com>
        <236589cd-b55d-1ceb-f236-36f9135f794e@iogearbox.net>
        <DB7PR04MB4252D31B8E79B789CC507D248B1D0@DB7PR04MB4252.eurprd04.prod.outlook.com>
        <5959dad0-dd02-1c3d-2487-13a69f8c507b@iogearbox.net>
        <d5eee0d9-c270-3ce7-5fcd-5f94b713dc3b@iogearbox.net>
        <DB7PR04MB425225AD548F3A3040250EF48B1D0@DB7PR04MB4252.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1hiYHTwM5lD/8PFnMdYRUOi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1hiYHTwM5lD/8PFnMdYRUOi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 18 Sep 2018 10:17:03 +0000 Vakul Garg <vakul.garg@nxp.com> wrote:
>
> Got it.=20
> Thanks for the guidance.

So, what should I remove? ;-)

--=20
Cheers,
Stephen Rothwell

--Sig_/1hiYHTwM5lD/8PFnMdYRUOi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlug5f4ACgkQAVBC80lX
0GxgOAf/cYFghG+FAjt72DmqBt8rQu9NUKpQEV5rCwPIcJB/RSEWp+0Setu+rVV9
Tn03YKNDRikBMWSQ71SL5MV+XnhOU6RKecqYkKWgjVirNTzxQmnpqzHhOiZnd7r5
uaRXWCauki6mq3LTWlfQ3MAmLvc1aNUzMX8QcoHTsyGZ4F70aMLz6hYY+gOWac/t
9KU3LQIztmZRnlKLQJLNk0JqAd3fo3a8MXjzUqXSnCcKV5WLJi4l07ON8U8eAkuV
pPmT0C1MOSm4ZWHcs30pxHOaUFtcgjaa5Nmm0MF4RUCIN8mjnk2fy3m2tW+7mWKZ
LkTpO3WhZdFBIl1R2GsDyqJCrOcBcg==
=ZQAV
-----END PGP SIGNATURE-----

--Sig_/1hiYHTwM5lD/8PFnMdYRUOi--
