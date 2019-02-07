Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555A0C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 02:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4512175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 02:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfBGCmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 21:42:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfBGCmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 21:42:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15A6C8AE76;
        Thu,  7 Feb 2019 02:42:09 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-17.rdu2.redhat.com [10.10.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A6FE179C9;
        Thu,  7 Feb 2019 02:42:06 +0000 (UTC)
Message-ID: <658363f418a6585a1ffc0038b86c8e95487e8130.camel@redhat.com>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
From:   Doug Ledford <dledford@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Date:   Wed, 06 Feb 2019 21:42:03 -0500
In-Reply-To: <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com>
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
         <20190206095000.GA12006@quack2.suse.cz> <20190206173114.GB12227@ziepe.ca>
         <20190206175233.GN21860@bombadil.infradead.org>
         <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
         <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
         <20190206210356.GZ6173@dastard> <20190206220828.GJ12227@ziepe.ca>
         <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
         <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-7DPuKcdbFR8/o52+ZlEI"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 07 Feb 2019 02:42:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7DPuKcdbFR8/o52+ZlEI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-02-06 at 14:44 -0800, Dan Williams wrote:
> On Wed, Feb 6, 2019 at 2:25 PM Doug Ledford <dledford@redhat.com> wrote:
> > Can someone give me a real world scenario that someone is *actually*
> > asking for with this?
>=20
> I'll point to this example. At the 6:35 mark Kodi talks about the
> Oracle use case for DAX + RDMA.
>=20
> https://youtu.be/ywKPPIE8JfQ?t=3D395

I watched this, and I see that Oracle is all sorts of excited that their
storage machines can scale out, and they can access the storage and it
has basically no CPU load on the storage server while performing
millions of queries.  What I didn't hear in there is why DAX has to be
in the picture, or why Oracle couldn't do the same thing with a simple
memory region exported directly to the RDMA subsystem, or why reflink or
any of the other features you talk about are needed.  So, while these
things may legitimately be needed, this video did not tell me about
how/why they are needed, just that RDMA is really, *really* cool for
their use case and gets them 0% CPU utilization on their storage
servers.  I didn't watch the whole thing though.  Do they get into that
later on?  Do they get to that level of technical discussion, or is this
all higher level?

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-7DPuKcdbFR8/o52+ZlEI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlxbmvsACgkQuCajMw5X
L93hMg/+MsKeTSWBe23u1LbQAPXeHxl4k8Yi91H9RYq8vp1SWYqJCsGxRS8U07tS
lYJcnjNYxdIjjUE35E7tTCVS8HzJ9Kyj6DmxGcErb6UAH0QY7QsSTxlS4kzYt4ea
FArz31ERKCxfCy7wsryKHdthZ2tpChgZNFqKvklv9GI9hbq5dQB+GdAc6XPOB1K6
reIV0BEUGGuTJbEXLTra+pzikeJZ1yzvOs74qx1PAjvE+gxExRA+CfzndwkKCfgE
wgDxfpma8S1bwc9fpke5ea/oQJXsnCBWm6BWpNWZws4/jvAveAWdGECscYiz/6Qu
d5gB5hrR689voX0oivLCZ/PpFEngnOmbdruI1ESR4e3kscl+VmSj74CSOyEFv4cN
t6A3HgESFXKg2/FR0zVTt1laJdOC3f50U7v946erbuYnLKEwTBKLPZvMRpFz8Wp/
NcVPUJXhgVI0mPDYMUATZ/DJhvPq1SQGhYkBNT524PeVLAh5Uk3NwKljZ8Ubkx3V
ISJrWMBSk1G+CHctK6gzh9slamHgjXdw98vJomyxcjdVQFk6LFXk3zWTtOS51YbN
EECT/GIgNJRGy8M+jJfO7NbIMh6DKbwBA2SaC3e0Fa2tA3p8KfQ/CgcvdURASvIJ
XB51Q2p4hb/n4rr8H1305ZJDHnzEbLVyC4dvwLQ2PjU+OGs0iPk=
=xZBH
-----END PGP SIGNATURE-----

--=-7DPuKcdbFR8/o52+ZlEI--

