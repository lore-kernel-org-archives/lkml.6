Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbeECMeY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:34:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750999AbeECMeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:34:23 -0400
Date: Thu, 3 May 2018 10:06:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dan.daly@intel.com,
        cunming.liang@intel.com, zhihong.wang@intel.com
Subject: Re: [RFC] virtio: support VIRTIO_F_IO_BARRIER
Message-ID: <20180503090652.GB5301@stefanha-x1.localdomain>
References: <20180503025955.28816-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <20180503025955.28816-1-tiwei.bie@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 10:59:55AM +0800, Tiwei Bie wrote:
> This patch introduces the support for VIRTIO_F_IO_BARRIER.
> When this feature is negotiated, driver will use the barriers
> suitable for hardware devices.
>=20
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>

I should have thought of this earlier, but why is a new feature bit
necessary?  If a hardware virtio device is in use, then the device
should already negotiate VIRTIO_F_IOMMU_PLATFORM (i.e. use DMA APIs and
IOMMU callbacks).

Does disabling weak_barriers when VIRTIO_F_IOMMU_PLATFORM is set solve
the problem?

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa6tEsAAoJEJykq7OBq3PId/QIALdwBH9xWwEQVvM6d304pF6L
xzcV8Swsp88sZDWASg+U4bAHqwEu7GHZV8uL5D7cL0wj/GzosiL8UXg5gRMbCewJ
+WqmRO650s3yMrYWkSODwIVA1ecJ4z7ij43NCVFDYn2INVec5PbVxW0lDgtCG0KD
+EU5IWUK4JMU25x4f+mQSYQkrsV89msupTw/qdxF634+qHitlj79JOL4ZmcvmOg6
DrSD11OXbpKDi8KEOJb+9KJ1ky69L9xUn29Me5YMK3mYbfte1kZYLSzE4JvQmKHS
Rf68rErinhJeAxDU4txxaIb2jOq3dUwqSQLuj5MjtNf4KhJbSB3A+BkZHSY4HM0=
=X31/
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
