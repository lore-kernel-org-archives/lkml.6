Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4245C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A38020645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A38020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeIDUhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:37:05 -0400
Received: from sauhun.de ([88.99.104.3]:60424 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbeIDUhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:37:05 -0400
Received: from localhost (i577B9DB6.versanet.de [87.123.157.182])
        by pokefinder.org (Postfix) with ESMTPSA id E80212C0114;
        Tue,  4 Sep 2018 18:11:15 +0200 (CEST)
Date:   Tue, 4 Sep 2018 18:11:14 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     shubhrajyoti.datta@gmail.com
Cc:     linux-i2c@vger.kernel.org, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH] i2c: xiic: Make the start and the byte count write atomic
Message-ID: <20180904161114.GC5000@kunai>
References: <1535967671-7784-1-git-send-email-shubhrajyoti.datta@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
In-Reply-To: <1535967671-7784-1-git-send-email-shubhrajyoti.datta@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2018 at 03:11:11PM +0530, shubhrajyoti.datta@gmail.com wrot=
e:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>=20
> Disable interrupts while configuring the transfer and enable them back.
>=20
> We have below as the programming sequence
> 1. start and slave address
> 2. byte count and stop
>=20
> In some customer platform there was a lot of interrupts between 1 and 2
> and after slave address (around 7 clock cyles) if 2 is not executed
> then the transaction is nacked.
>=20
> To fix this case make the 2 writes atomic.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

I assume simply changing the order of the register writes won't fix it?

I also assume this is stable material?


--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluOrqIACgkQFA3kzBSg
KbapRxAArZeq002KSZpUYsWhatVQEjnYvYcwpQBRDx5hECYdi+eA6jEfmMirD0+Z
sU0SrQGu4DZ0pTGcB7Jcz68hIiL6E6o9+BBwI/23A/K+IanWMv/5YeDafBkZJpEu
VXvcXcMB9YuOEl00Oz/kUz4IPDeL2Rs9cCeQFAIU+l8MPGvNTel1/h1r9Q04O6/k
Bsd4g279d4QueTO+n6UhQYu3ny9d9j5VAF5S1aO/RZqlt29blZ1UX5RTxW3Hii1C
kOdTVlZknnPD1//4SKC02W403AiVAaieitCZ2COvpoomwQSkluSEIdmohk146ssO
TTTR+OmNx/bAaMgDYZWasRB+uui6gw2X9ELrermwF/VLWv8ok4zUc/AqAlnpxJgC
7exqwyXN9SFvETSs77w5PgCmnvMW2inkiS+exKcnYzg/b/vW+PvyALB7M7A23Z9D
Rmo4U6zI4cdsffbe9DuuOheBYTfndPrMEWjVrxbpjGygGb5ZvXY3ym6yOUDqrYah
swFRaHVrn7U7oJE42ve6efrvjhN3yWRaqKH4si9csNWQa4msw+LvRABj7kznFraX
xMFNXzSquz7ZwJ+yZeMomzlbITIhXIlZeQAJe1vNiIGP2zOowpI1t+xTvJsKJqPS
G+wxa8LNrC99WGL3nV68ajT58GhalGNzu+gsk394zov8ywxrMMg=
=YYMd
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
