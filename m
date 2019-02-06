Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30209C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EF6218D2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfBFUQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:16:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfBFUQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:16:09 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6A933DBFE;
        Wed,  6 Feb 2019 20:16:08 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-17.rdu2.redhat.com [10.10.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D26D6247B;
        Wed,  6 Feb 2019 20:16:05 +0000 (UTC)
Message-ID: <a9df9be75966f34f55f843a3cd7e1ee7d497c7fa.camel@redhat.com>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
From:   Doug Ledford <dledford@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Christopher Lameter <cl@linux.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@kernel.org>
Date:   Wed, 06 Feb 2019 15:16:02 -0500
In-Reply-To: <20190206194055.GP21860@bombadil.infradead.org>
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
         <20190206095000.GA12006@quack2.suse.cz> <20190206173114.GB12227@ziepe.ca>
         <20190206175233.GN21860@bombadil.infradead.org>
         <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
         <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
         <20190206194055.GP21860@bombadil.infradead.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-1dGH+hKU+Z7r3DIuLEHD"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 06 Feb 2019 20:16:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1dGH+hKU+Z7r3DIuLEHD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-02-06 at 11:40 -0800, Matthew Wilcox wrote:
> On Wed, Feb 06, 2019 at 07:16:21PM +0000, Christopher Lameter wrote:
> >=20
> > though? If we only allow this use case then we may not have to worry ab=
out
> > long term GUP because DAX mapped files will stay in the physical locati=
on
> > regardless.
>=20
> ... except for truncate.  And now that I think about it, there was a
> desire to support hot-unplug which also needed revoke.

We already support hot unplug of RDMA devices.  But it is extreme.  How
does hot unplug deal with a program running from the device (something
that would have returned ETXTBSY)?

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-1dGH+hKU+Z7r3DIuLEHD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlxbQIIACgkQuCajMw5X
L90bChAAgL7lcxfXKSmYLGA1OFdVg5chnIDS93XRvqgpb+yb4Tpb+DhVqhoT3bHY
gUpE9yFtWmLsUVrtn0xquWw8VG5Ciqm3T+EA1l2yfD0deu7WchyEG6Ezg90IefFl
BSl6rXHScee62dUztlmRPuj9Tu9x8zQlWzeYQ+HXWbXKbY1L47bYLaFgaHdYnDUX
NdI+Dw84LQTpBxPjiQV+mBWPFaGSX1dxC6RKKxPHNMFLpEq9qt1Z2Z3NkceEc39v
jCUmCkvDdYhLgk2Mb7rHIl8IrTrt3q2ASte9Qane1B/AQoKDvf+icpqggzrljbA4
gFnNLeIphEsj4RdxS8Jj4oAf80I57Od236KprxjfHNxWv6tpmuMpVuO8+2Wve9YF
rskQFW76KIViYuvQpb8FHhmVQDZ+4fAsAoKlucf0lMbUaIyIbsR13qlyrsHViOfv
fx7RPeVPNC+uct0qWeHkAJuivBZym/dqTHVuNVXkNOFAoiOXRpfIXA26XJlnT1aX
CpRspY8yFawWEZonppyKyjbt3fMs3rZIFmxSh6vTEV8oXSlFYsIRG2Cu9bInZC1N
B7ZuDVLvjCyizywq0VobCgEf3mlpG056WLSu9vXqO1BPT6ASI/GcI+JEG+NcitIX
nz9Q1Dewt67LDUWm61KTkkiMEON8ljYxRgSkREIm6ksW3G35M48=
=WK6h
-----END PGP SIGNATURE-----

--=-1dGH+hKU+Z7r3DIuLEHD--

