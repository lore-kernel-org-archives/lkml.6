Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B69FC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A59218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfBFUuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:50:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbfBFUuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:50:46 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 152B6144040;
        Wed,  6 Feb 2019 20:50:45 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-17.rdu2.redhat.com [10.10.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A5AC1C94A;
        Wed,  6 Feb 2019 20:50:42 +0000 (UTC)
Message-ID: <f84dfa9d5e34ce76b5f599086f5fbaa12f7903bf.camel@redhat.com>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
From:   Doug Ledford <dledford@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christopher Lameter <cl@linux.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jan Kara <jack@suse.cz>, Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@kernel.org>
Date:   Wed, 06 Feb 2019 15:50:39 -0500
In-Reply-To: <20190206204954.GS21860@bombadil.infradead.org>
References: <20190206173114.GB12227@ziepe.ca>
         <20190206175233.GN21860@bombadil.infradead.org>
         <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
         <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
         <20190206194055.GP21860@bombadil.infradead.org>
         <a9df9be75966f34f55f843a3cd7e1ee7d497c7fa.camel@redhat.com>
         <20190206202021.GQ21860@bombadil.infradead.org>
         <a8dc27e81182060b3480127332c77ac624abcb22.camel@redhat.com>
         <20190206204128.GR21860@bombadil.infradead.org>
         <fbdeccb01f7d0ba2f6ebb69660b7aa3d99690042.camel@redhat.com>
         <20190206204954.GS21860@bombadil.infradead.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-npO7kZeSLN7JvETiEniW"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 06 Feb 2019 20:50:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-npO7kZeSLN7JvETiEniW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-02-06 at 12:49 -0800, Matthew Wilcox wrote:
> On Wed, Feb 06, 2019 at 03:47:53PM -0500, Doug Ledford wrote:
> > On Wed, 2019-02-06 at 12:41 -0800, Matthew Wilcox wrote:
> > > On Wed, Feb 06, 2019 at 03:28:35PM -0500, Doug Ledford wrote:
> > > > On Wed, 2019-02-06 at 12:20 -0800, Matthew Wilcox wrote:
> > > > > Not hot-unplugging the RDMA device but hot-unplugging an NV-DIMM.
>=20
> ^^^ I think you missed this line ^^^

Indeed, I did ;-)

>=20
> > You said "now that I think about it, there was a desire to support hot-
> > unplug which also needed revoke".  For us, hot unplug is done at the
> > device level and means all connections must be torn down.  So in the
> > context of this argument, if people want revoke so DAX can migrate from
> > one NV-DIMM to another, ok.  But revoke does not help RDMA migrate.
> >=20
> > If, instead, you mean that you want to support hot unplug of an NV-DIMM
> > that is currently the target of RDMA transfers, then I believe
> > Christoph's answer on this is correct.  It all boils down to which
> > device you are talking about doing the hot unplug on.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-npO7kZeSLN7JvETiEniW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlxbSJ8ACgkQuCajMw5X
L91Y+hAAusyH3LPRH/wvWQK4kvGUWublDXN9K/Udjlf1z1agPHTyDxMEP4lqYbkz
+dlHYgggahnY4m/J8N1ctQ/wVqdxnT/aO/iKuAmZszWwPDNl6D6cksEXnW4Gsdh/
AGp+06hK1ZtigzRLXajHbcLZqgWTfCE8Y00PhiUe26M8BTx2dNM3pHvH0aQtkcnK
I6k4ZBMu4t0zojN3flit89NuRnfE+1b0dnH+9XqzLlCKRmfN9ZnJtvBLu3vKyd1d
wK2nms1N8Zsn7hrI0d7L8hDFZudfd7tcsdGLEKr48I6JcOnfppzr7fNl8hCT62xn
xkE/HXyz1K8TQrKn8plAzGFFVANCy7VqQPD+xN49G7dg7+go9srl7OO0o5JxPdY2
xQlRSa03pP4/Qt2NS7+Ar0FUi9UAISSmcAc+A5hZAdEIICj9sjSavSotCx2jTFcB
zHml+SejW2r5CEfPrDNzoeBe1m4H4nS113bSujtgjrVkW2uN3GrXLFwAaD0dKJSN
YNXmbNxGUCcXPfWnL/AK27DXnmLhC48wRpk1YhHjuNpJ/kgwPVtO37QDqPK7wjpY
1tJigUxaFXfvfryOtTnvoPcZM5Icyo60ocREqJP4Y62xTbL2rLQvL7Qm1oZlO5jN
ZIxjvEVS25lqOehKH6ldv0KP0Zqrv1CwQ7Q6FDDeSaeEcRrVyzg=
=EurJ
-----END PGP SIGNATURE-----

--=-npO7kZeSLN7JvETiEniW--

