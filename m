Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE258C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBB7218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546454456;
	bh=XCKTaD/N08elRbdFsz/b28ia1MZCDh+bRNzp0MFnGtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RNXeefRjtMHCO8CmyszvaNfXrLL/huWXohJ2Fxdt4hzwAcI5T3gcS6ZofDbt8Eg2c
	 zX5aRq5yt4FEayPEniCJ/Qwwnv/3fvPIncCUfiSMwGRQ3UOiUPkrCCxsXPNBOBpGXE
	 BBU6V7xiMv/4wr+vPG2tyIZjExkQTr5pzkyYZFWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfABSkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:40:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:38700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfABSkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 13:40:55 -0500
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 670B0218CD;
        Wed,  2 Jan 2019 18:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546454454;
        bh=XCKTaD/N08elRbdFsz/b28ia1MZCDh+bRNzp0MFnGtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zwj/x4ox5xVBXbZIz4vj4JmBI7iSWbBKawuy1aN42kBe2qx/7DlFYsFomSig18fnn
         s+hla7rWembrDXmos94UuFeAOuuxzhvsSmOooW2K4m+Uk0NefwNb2ojKsj4STfLC09
         OsicDrKhoF4xkHZCzVnDS7+YL9NxkEC2m2g7riTY=
Date:   Wed, 2 Jan 2019 20:40:50 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     YueHaibing <yuehaibing@huawei.com>, dennis.dalessandro@intel.com,
        mike.marciniszyn@intel.com, dledford@redhat.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next] IB/qib: Add missing err handle for
 qib_user_sdma_rb_insert
Message-ID: <20190102184050.GI5424@mtr-leonro.mtl.com>
References: <20181221021938.13784-1-yuehaibing@huawei.com>
 <20190102171224.GA26765@ziepe.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rMWmSaSbD7nr+du9"
Content-Disposition: inline
In-Reply-To: <20190102171224.GA26765@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rMWmSaSbD7nr+du9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 02, 2019 at 10:12:24AM -0700, Jason Gunthorpe wrote:
> On Fri, Dec 21, 2018 at 10:19:38AM +0800, YueHaibing wrote:
> > It should goto err handle if qib_user_sdma_rb_insert fails,
> > other than success return.
> >
> > Fixes: 67810e8c3c01 ("RDMA/qib: Remove all occurrences of BUG_ON()")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/infiniband/hw/qib/qib_user_sdma.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c b/drivers/infiniband/hw/qib/qib_user_sdma.c
> > index 31c523b..e87c0a7 100644
> > --- a/drivers/infiniband/hw/qib/qib_user_sdma.c
> > +++ b/drivers/infiniband/hw/qib/qib_user_sdma.c
> > @@ -237,6 +237,8 @@ qib_user_sdma_queue_create(struct device *dev, int unit, int ctxt, int sctxt)
> >
> >  		ret = qib_user_sdma_rb_insert(&qib_user_sdma_rb_root,
> >  					sdma_rb_node);
> > +		if (ret == 0)
> > +			goto err_rb;
> >  	}
>
> This doesn't look right, what about undoing the kmalloc directly
> above?

Back then, I came to conclusion that qib_user_sdma_rb_insert() never
returns 0. Otherwise, Dennis would see that BUG_ON() for a long time
ago.

Thanks

>
> Jason

--rMWmSaSbD7nr+du9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcLQWyAAoJEORje4g2clinTXQP/3g26wJfvgrpjNoC1NKzLBli
H99XIUi7CD2/1moHI+f/oinbOiVPPAK7oOZPcQ0RZ4V0R8iTC8+1gcskxdvU9ypc
08CD5mxuzPOfjg8G5/PVmKMx26cPgswxgFc1BbSfuC8LPFa7xqn/DrwXJMEs8CO5
YJG8ClyaRdED1oEkyh8tpDCiiwRDuzSGzyaF4V9OGzy2h122RTliubmxeT9RkZYt
GKH1V2cJuxaCd3bnNUFAFMGOXv+DxRBWROBz7y+ECw2TTn23yKojL0bW2nIIZRFM
IX13iW0+ehUGwAzhzBjOZ3ILw2DfTig36vax1bixYnXmS2sh58CTxrDiZdD/XLee
GDbLjH4G1lHutpi2qf8T6e4l4s9AuLKaQ2pnKNpR3JEq5GN9plLl3sZX0hrmd8UW
LgNBu6/iy8F/bDi8YlVqmsjzYpsgA5aPZzxcT0z7JJTjXpu9+A90jBQ9oKkvZRYT
ZbcqtS1SRS2p+A5N3KocaueLiMyySs5anb5yxKfuycoOjjtlQVpCxUheLlOKJqR8
XkQD+YBsNQSEF3qpj6Ym4wKWDe+mUFcDllgQD/ExfAYedheY1DU2uvWQC0bdAhdj
pJ5FMMPGtO5F6wC5bs3NDqcWMYdqq+B/d/boXgMVJ1SDiCBBxqshhYZimvhluvmo
LQb9xXP4IFBHneNkHtJQ
=3aEi
-----END PGP SIGNATURE-----

--rMWmSaSbD7nr+du9--
