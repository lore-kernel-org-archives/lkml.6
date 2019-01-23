Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE61C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9FA21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548266178;
	bh=L+jSxpsRKVFTQSBTm58FgxKg9xBb41vnDraPIuL95QY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0+qyus9nuJ1k/zcaF3oLOgAbxQm318RCkbYEaYF8HjBzWpE0lt8M8YrJfHodZ6+uh
	 iDCoi4fPJMwMsI7lducT6/8s3x5IxxzbysF+dR68+hTMUDcD+n4/5WrdG0gJn8rhZj
	 KHES54E6TqOvRbITMaQ89saZ3NzolALqVEAwEpu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfAWR4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:56:16 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43074 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfAWR4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=L+jSxpsRKVFTQSBTm58FgxKg9xBb41vnDraPIuL95QY=; b=NT5prtVziUBY3SF6H8AB6fjZz
        DytlUdgUBaqJYNumUI0bD/zCAEn190X4hfnsEEbmpbEWZhozD2ojQgwPbU6+MDtpH5U4UbIGe2dp7
        Ff04RCEWu6vv1m6/G6wOgmBfq6P+wz0MdYlvRWbSraMJ+kCX1QbuEFYrD9UhSb7vfPdOc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmMl1-0006pN-1d; Wed, 23 Jan 2019 17:56:11 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 874FE1127ABA; Wed, 23 Jan 2019 17:56:09 +0000 (GMT)
Date:   Wed, 23 Jan 2019 17:56:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     kernel@martin.sperl.org
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
Message-ID: <20190123175609.GG7503@sirena.org.uk>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
 <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org>
 <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
 <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org>
 <20190115192619.GG5522@sirena.org.uk>
 <5D3256B1-5DAE-4E3F-9099-5425F4BCA304@martin.sperl.org>
 <20190115212539.GK5522@sirena.org.uk>
 <EA757B47-A264-4B4D-9E5F-16611ABA0278@martin.sperl.org>
 <20190118191202.GG6260@sirena.org.uk>
 <EE52ED32-CBB4-40D4-8615-CA814158C826@martin.sperl.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="reI/iBAAp9kzkmX4"
Content-Disposition: inline
In-Reply-To: <EE52ED32-CBB4-40D4-8615-CA814158C826@martin.sperl.org>
X-Cookie: A couch is as good as a chair.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--reI/iBAAp9kzkmX4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 20, 2019 at 12:24:23PM +0100, kernel@martin.sperl.org wrote:

> These kind of changes it requires are consuming a bit more time than
> I was hoping for.

Thanks for trying.

> So maybe at this very moment the best is reverting the patch.

Yes, I'm just going to do that for now.

> As for the root cause of the regression: my guess is that spi-mem is
> just not triggering a shutdown any more because of how message_pump works.

I'm fairly sure that's what's going on but not been able to get my head
around things enough to figure out what's going wrong yet.

--reI/iBAAp9kzkmX4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxIqrgACgkQJNaLcl1U
h9Bo+Qf/R2oUsHmOVhx2IGtp1A69vFPJrwFZJXXjknp2y8JDfLjNHRs47+iFmpfJ
82jx8AMcTpYf4r4p3oAixX+huXXWP9sVD3jIx9jg4Wh7Nzjg/hqUhZlv0kPl2C0/
gdFt6vn5gW02ebILvzT8aHQAovButhjV5KObxCKfVJjLC7MSjrrZ66Nu1rIh7HEP
943ED4O4MSfCrkvbICr8QFEe+dNmlqnh/g1sfo8VMMuVQvizAi7axq7nm2keOMH5
owQCS7DkgQGa3q9ra8eYwVGwUCDSAt/gA9ccZ31zXmyX1U4FGkqzndh7t1aC0Ij+
qSH6CmkqaFC5X/Vl2ft/5RTPYJnOVA==
=qwRN
-----END PGP SIGNATURE-----

--reI/iBAAp9kzkmX4--
