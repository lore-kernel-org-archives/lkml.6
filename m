Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754390AbeDID0M (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 23:26:12 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36904 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753904AbeDID0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 23:26:07 -0400
X-Google-Smtp-Source: AIpwx4/Px0LhIZ9urI2oL2emyqG8G/ScDKrozlPYSvG0c9BjqR+CrZlst5aCEokj5wX2M31TpAgR4A==
Date: Mon, 9 Apr 2018 11:26:01 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, kwolf@redhat.com,
        haozhong zhang <haozhong.zhang@intel.com>, jack@suse.cz,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, kvm@vger.kernel.org,
        riel@surriel.com, linux-nvdimm@ml01.01.org, mst@redhat.com,
        ross zwisler <ross.zwisler@intel.com>, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, hch@infradead.org, pbonzini@redhat.com,
        stefanha@redhat.com, niteshnarayanlal@hotmail.com, marcel@redhat.com,
        imammedo@redhat.com, dan j williams <dan.j.williams@intel.com>,
        nilal@redhat.com
Subject: Re: [Qemu-devel] [RFC] qemu: Add virtio pmem device
Message-ID: <20180409032601.GA1648@stefanha-x1.localdomain>
References: <20180405104834.10457-1-pagupta@redhat.com>
 <20180405104834.10457-4-pagupta@redhat.com>
 <ad08ca09-71ee-08d5-3479-8b3d06380a03@redhat.com>
 <416823501.16310251.1522930166070.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <416823501.16310251.1522930166070.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2018 at 08:09:26AM -0400, Pankaj Gupta wrote:
> > Will this raw file already have the "disk information header" (no idea
> > how that stuff is called) encoded? Are there any plans/possible ways to
> >=20
> > a) automatically create the headers? (if that's even possible)
>=20
> Its raw. Right now we are just supporting raw format. =20
>=20
> As this is direct mapping of memory into guest address space, I don't
> think we can have an abstraction of headers for block specific features.
> Or may be we can get opinion of others(Qemu block people) it is at all po=
ssible?

memdev and the block layer are completely separate.  The block layer
isn't designed for memory-mapped access.

I think it makes sense to use memdev here.  If the user wants a block
device, they should use an emulated block device, not virtio-pmem,
because buffering is necessary anyway when an image file format is used.

Stefan

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJayt1JAAoJEJykq7OBq3PI+GkH/1E+ci/o0GU4EORh4j1KOyFX
JtWmDNcdJfKLdUonRX6ZCns34at7dTNf0U6nFlqzDB5bkMdh3H8Tid/8u57Q9MdI
Y2e1Xr/IxugahIok4g5c9bN43zNWnKzGF+G/OMuCDe76oLpAm9GccKl/M2EaiXo3
rLACtHLAv+t8FNmFHw4BTz2Nt5zW6D3YiAj/M/wdk9N/z/QnbN4glWWbI8ukmNMc
+e7n/yZH4TmJikN6BAvRvCrT4EemU9LpXloM5z5qXGJkJaNn+9ZQQCjwaJXdyOKt
OTKLvVMdOt3x+0JxnSnisMkPtmIJtuHJY0bmjYfnrn9fh1blM9SQ8Q3nXVHQv9E=
=9Dfp
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
