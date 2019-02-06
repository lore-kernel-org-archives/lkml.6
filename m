Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4DFC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC5C2190B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfBFVMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:12:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbfBFVML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:12:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 618988AE72;
        Wed,  6 Feb 2019 21:12:11 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-17.rdu2.redhat.com [10.10.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 03F9B84F3;
        Wed,  6 Feb 2019 21:12:08 +0000 (UTC)
Message-ID: <b3a0702baa3477748c3c243fa9d1c94f7b1954d6.camel@redhat.com>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
From:   Doug Ledford <dledford@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@kernel.org>
Date:   Wed, 06 Feb 2019 16:12:06 -0500
In-Reply-To: <CAPcyv4id2rzJVUZw98PfJ-k05BvD-opwj0XhOWPKZQicmhXJ=g@mail.gmail.com>
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
         <20190206095000.GA12006@quack2.suse.cz> <20190206173114.GB12227@ziepe.ca>
         <20190206175233.GN21860@bombadil.infradead.org>
         <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
         <20190206183503.GO21860@bombadil.infradead.org>
         <20190206185233.GE12227@ziepe.ca>
         <CAPcyv4j4gDNHu836N4RfgQsE+eZU9Wt0N9Y09KQ43zV+4mK-eg@mail.gmail.com>
         <671e7ebc8e125d1ebd71de9943868183e27f052b.camel@redhat.com>
         <CAPcyv4id2rzJVUZw98PfJ-k05BvD-opwj0XhOWPKZQicmhXJ=g@mail.gmail.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Wt2EcFKp3kDyEr43gL+b"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 06 Feb 2019 21:12:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Wt2EcFKp3kDyEr43gL+b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-02-06 at 13:04 -0800, Dan Williams wrote:
> On Wed, Feb 6, 2019 at 12:14 PM Doug Ledford <dledford@redhat.com> wrote:
> > On Wed, 2019-02-06 at 11:45 -0800, Dan Williams wrote:
> > > On Wed, Feb 6, 2019 at 10:52 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > On Wed, Feb 06, 2019 at 10:35:04AM -0800, Matthew Wilcox wrote:
> > > >=20
> > > > > > Admittedly, I'm coming in late to this conversation, but did I =
miss the
> > > > > > portion where that alternative was ruled out?
> > > > >=20
> > > > > That's my preferred option too, but the preponderance of opinion =
leans
> > > > > towards "We can't give people a way to make files un-truncatable"=
.
> > > >=20
> > > > I haven't heard an explanation why blocking ftruncate is worse than
> > > > giving people a way to break RDMA using process by calling ftruncat=
e??
> > > >=20
> > > > Isn't it exactly the same argument the other way?
> > >=20
> > > If the
> > > RDMA application doesn't want it to happen, arrange for it by
> > > permissions or other coordination to prevent truncation,
> >=20
> > I just argued the *exact* same thing, except from the other side: if yo=
u
> > want a guaranteed ability to truncate, then arrange the perms so the
> > RDMA or DAX capable things can't use the file.
>=20
> That doesn't make sense. All we have to work with is rwx bits. It's
> possible to prevents writes / truncates. There's no permission bit for
> mmap, O_DIRECT and RDMA mappings, hence leases.

There's ownership.  What you can't open, you can't mmap or O_DIRECT or
whatever...

Regardless though, this is mostly moot as Dave's email makes it clear
the underlying issue that is the problem is not ftruncate, but other
things.
> >=20

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-Wt2EcFKp3kDyEr43gL+b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlxbTaYACgkQuCajMw5X
L91UVRAAxQypVAaB7i52h2wDJpx5+mYhH6IiQWrtqd8xa0l2UZ2VHrRkdsn4wzGt
BQFhIJZKPh3b7yzsYKzhe9HicMCXRIXPKw/KmgJLDcDmi1hU1QCMHKohniWUbJ6G
g0IfJrLoPmMhNKn0Cm7J4s5jsP2QW6/CUn6/CGOQhWG1GtcuyFL6fCl5Bn0FFn9s
cfKDGgJ9Wy4wiguackEO+W6XUN9YFz9P4K9HMqVwXfHXXiZR2Z9H6xHQOZkafylA
KhjP2h8o0Jip4HDKOMJoP9AbmFFXK3ualefeiDoginb6D7tVs0/sbyImBTfTLzbt
7GBSNa/9Ue8qi7ZU6/ppjQILfn0mbnxV0JRV/nBOXfLeZeO1mbD2EDuPSOL+kXX4
Z4uvFWA7UxIkBTh4lwQY8g9uan3578jtdF4SNe//GBAA+pPTV9oXzzbTX+UXYE/U
MmmQjk2S+ax7PINhTZhBbkGWqVLG95Pb3UtmxPSG1uFlxdkv/DSJqkm9qeNuHZu5
Tf1Zxl648P1g7Jk6c+1hlqpe/Rt7vsjU/1gQKYMyR4ViBrvlyiwkEokrqHdN2wnK
YaJ8HcFQazJK8BwNFYmbMgWpvBN107gSh3yd3jnRm0PyxcWXNW+OfQ4X6xrgaLTQ
m6lMl9vg0O/rHaf7P53MHmweNKEOLTcH7jp1/BQ1AM5zHMN5QOA=
=Ct0f
-----END PGP SIGNATURE-----

--=-Wt2EcFKp3kDyEr43gL+b--

