Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0A5C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA68218E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546456940;
	bh=bk+/8JreDiVB+HEB3Wq8yg34czo43UQsW1QpfLkztBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z8S2JXUcwTiTaydWZ8wBFv6CWkClddGvBqSNPOevwblyM/uEOfR0i0XFuJ7DLhzZ6
	 ORp4mxEvW+SC7g0rePZWfnvnDWcbyDafSS+xrc1eA61XmEzcebtf4lYGeBY3GQtnwI
	 DClc/1EvR3ytdm3Zmc7T8a7GvwSwbDq0DubGN4/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbfABTWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:22:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:42280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728708AbfABTWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 14:22:17 -0500
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93CA8206C0;
        Wed,  2 Jan 2019 19:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546456936;
        bh=bk+/8JreDiVB+HEB3Wq8yg34czo43UQsW1QpfLkztBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ohKD/B7V97FnGg+/H/wkL/eKFQGSYJIQHpFKWR7hr0PkCK8fdN5QAosJFk8aDp4U9
         +8nDqd7qUzjmZX4QBJK6TJYCyHC3fTJQ+2JRj4pNamySgcA2MCJnR8i19rj9IVoTLV
         ieBr/ZxXsi7sQd6Jv6QGcCxs4TSR/qADF/1UEOgU=
Date:   Wed, 2 Jan 2019 21:22:11 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     YueHaibing <yuehaibing@huawei.com>, dennis.dalessandro@intel.com,
        mike.marciniszyn@intel.com, dledford@redhat.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next] IB/qib: Add missing err handle for
 qib_user_sdma_rb_insert
Message-ID: <20190102192211.GJ5424@mtr-leonro.mtl.com>
References: <20181221021938.13784-1-yuehaibing@huawei.com>
 <20190102171224.GA26765@ziepe.ca>
 <20190102184050.GI5424@mtr-leonro.mtl.com>
 <20190102190740.GH26211@ziepe.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rV8arf8D5Dod9UkK"
Content-Disposition: inline
In-Reply-To: <20190102190740.GH26211@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rV8arf8D5Dod9UkK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 02, 2019 at 12:07:40PM -0700, Jason Gunthorpe wrote:
> On Wed, Jan 02, 2019 at 08:40:50PM +0200, Leon Romanovsky wrote:
> > On Wed, Jan 02, 2019 at 10:12:24AM -0700, Jason Gunthorpe wrote:
> > > On Fri, Dec 21, 2018 at 10:19:38AM +0800, YueHaibing wrote:
> > > > It should goto err handle if qib_user_sdma_rb_insert fails,
> > > > other than success return.
> > > >
> > > > Fixes: 67810e8c3c01 ("RDMA/qib: Remove all occurrences of BUG_ON()")
> > > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > > >  drivers/infiniband/hw/qib/qib_user_sdma.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c b/drivers/infiniband/hw/qib/qib_user_sdma.c
> > > > index 31c523b..e87c0a7 100644
> > > > +++ b/drivers/infiniband/hw/qib/qib_user_sdma.c
> > > > @@ -237,6 +237,8 @@ qib_user_sdma_queue_create(struct device *dev, int unit, int ctxt, int sctxt)
> > > >
> > > >  		ret = qib_user_sdma_rb_insert(&qib_user_sdma_rb_root,
> > > >  					sdma_rb_node);
> > > > +		if (ret == 0)
> > > > +			goto err_rb;
> > > >  	}
> > >
> > > This doesn't look right, what about undoing the kmalloc directly
> > > above?
> >
> > Back then, I came to conclusion that qib_user_sdma_rb_insert() never
> > returns 0. Otherwise, Dennis would see that BUG_ON() for a long time
> > ago.
>
> It fails if the index is in the RB tree, which would indicate a
> programming bug.

I tried to say that this programming bug doesn't exist in the reality.

>
> The way to replace the BUG_ON is something like:
>
> if (WARN_ON(ret == 0)) {
>     kfree()
>     goto err_rb;
> }
>
> Jason

--rV8arf8D5Dod9UkK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcLQ9jAAoJEORje4g2clin/0EP/jyOpkvSoAVDoLD6Ct3VP6P0
bpSqwOhuu+qFj6bBY/hzpyhJ6Xth9oxz76ZoQyKqvbSzevUDtLR7XKD73ztFj3BJ
G4dNhMS+Zm5ctOcJCag3DA17QZ5ljPtiEwrHRtU8fnzCQXmnyc3GT+oCMSumQnUI
zmR+4A4h+Vi6DMG+WJYviLeMPF5X3K8nHICjZYeDRx1iARuhlSYTlBv5vrGplVaW
NkSmXjYP9DqngwA37PrAmsMoDtnIpAOBleZU/FA4NAx8GQHGLjPXT/zo6rJhYCVu
n+29JAM2ATpnAbUWLdxYtdg3Wpyg+3/5AkT7ewe/G1kq/Hx1UVZEMiYIVUMPD1AW
34PNJ1PwI6jL6c5ARWIKAM5mP9FP6VgMIJ2fUtIfWxed7n7F2pQDhessiT7XjOPx
QzZ2W5t/mkaB+A79ik6NBem5Y83Tj6ewBNpyY09vq3gusPWF8u1o1paZN6SW2wqC
+JNib70qwYPUU4RF5rWXdN+0tGU3qZLKxl83IWq++L+puD8/KwmhLzyuoAVVyIOW
cOz5bsfm2bqy/aAEXC19LJTpBBh73c3KMXjoCjihdI7m7arT31Z3hfIL098G5yb0
I+kix85NrviX1rhUKjKsq9CVTQg4a7ZJxhLVwyzbReewWzG5F5PXplsN5YtmvK4V
EZalHE25GOeccbvHw5Mv
=zx/n
-----END PGP SIGNATURE-----

--rV8arf8D5Dod9UkK--
