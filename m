Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7gOrONMZHVv1JQAAmS7hNA
	; Sun, 10 Jun 2018 12:30:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C9C2D607E7; Sun, 10 Jun 2018 12:30:11 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhU1puW6"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 41CE6604D4;
	Sun, 10 Jun 2018 12:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 41CE6604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753937AbeFJMZL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 08:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753899AbeFJMZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 08:25:09 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 621A320858;
        Sun, 10 Jun 2018 12:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528633509;
        bh=xJq0wIlGVkcvIwc8xZOFLUreEwnzLuyg/umrNdSnZ9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nhU1puW66AHfD5TPMjuQWdkyCIltFJxuZWVHQd3tZgY0iqNkrUVPfiHlyfK0PL3AN
         g68PTqNML3r4G74+ss6DivdxrQCCfEHl+iuy8wRsLCvyhowRg6LsmD1jKocM1gOonX
         QWjqmzyi409DZ9D8hlcF1A1JWQsNhZ0YYU5Nugo0=
Date: Sun, 10 Jun 2018 15:25:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-rdma@vger.kernel.org,
        =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] IB/mad: Use IDR for agent IDs
Message-ID: <20180610122505.GM12407@mtr-leonro.mtl.com>
References: <20180608174218.32455-1-willy@infradead.org>
 <20180608174218.32455-3-willy@infradead.org>
 <20180610063028.GH12407@mtr-leonro.mtl.com>
 <20180610104305.GA9284@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="L2Brqb15TUChFOBK"
Content-Disposition: inline
In-Reply-To: <20180610104305.GA9284@bombadil.infradead.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L2Brqb15TUChFOBK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 10, 2018 at 03:43:05AM -0700, Matthew Wilcox wrote:
> On Sun, Jun 10, 2018 at 09:30:28AM +0300, Leon Romanovsky wrote:
> > 1. IBTA spec doesn't talk at all about the size of TransactionID, more
> > on that in section "13.4.6.4 TRANSACTION ID USAGE", the specification
> > says: "The contents of the TransactionID (TID) field are implementation-
> > dependent. So let's don't call it mlx4 bug.
>
> I was loosely paraphrasing the original bug report; suggested rewording
> of the comments gratefully accepted.

Just replace "mlx4 bug" with something like "to comply with mlx4
implementation".

>
> > 2. The current implementation means that in mlx5-only network we will
> > still have upto (1 << 24) TIDs. I don't know if it is really important,
> > but worth to mention.
>
> Actually, the TIDs will be up to 2^56.  We're limited to 2^24 clients,
> each of which can send up to 2^32 messages.

It sounds like more than enough.

Thanks

>

--L2Brqb15TUChFOBK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbHRihAAoJEORje4g2clinYlkP/0vfiftoDnbAo2tWAQm2FfxV
y0PPkTiSeI0o+uFp0R37d0iQnaUoiAqTnfEE48rDY7OEzIvp39+CE5KDuTKH3H0T
jIEuTKSEZoVyWkNIg+ukL1ihgQdBVFB4v9N+LWyj3ZqxP0DCtOA/QegNel99DPFR
nLFPWJNeGAVMCQTSxuhZrmY5ms3pC83N7PjdddHT2BSXDAFFRjRRa+Q9gG7QcrGV
vH+YFs3QOvipR2dCOOIcS797FxSYbtTHQTceooNjp+IoC5Vf/Uu3vYSshsQALvZT
piCo+RUBbQbBdKIqh/OQBw+bIxSiUWNbUVMFNw74aehXhLJld9BBw+Y8ldNDlUkN
scGeuT3ODU/fqcLtOurpbJ4Kt2m8C3itGRDhKFwJzLqBwpMJwGCcBwN1SPUf5Fti
eJLpWkP9e74Uypx981f41GooC9SApsEGG80t7QZ1pa7Xief5yRbAI9PcrvNV5xxz
9w1/5LiFwL0jF7mYzzqytorKun/lfxIkP2FI2AQoDkedQTaa+q3/Kll10rYvLo9m
OeSHsPtpyKhGbiHXQLHpgm0Rsl1ss77xlNKEhsSVFO62rwoeJQCobHfUfwPGkzOp
tlyrH3c1O+yQqH21U25YrZz1qWJ66gUTJYER7oAD2XpgLj/+xwj+ZNGl5STv5qgP
eNr1RB5Ci9qra1cpHlgO
=x3xM
-----END PGP SIGNATURE-----

--L2Brqb15TUChFOBK--
