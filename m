Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753114AbeDSSKh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 14:10:37 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39447 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751184AbeDSSKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 14:10:35 -0400
X-ME-Sender: <xms:m9vYWm5yUGQSnnzx22qAXHsGYYFOoRdrP9VLMWDWV7OCqChyhQbtGw>
Subject: Re: [Xen-devel] [PATCH] xen-netfront: Fix hang on device removal
To: netdev@vger.kernel.org
Cc: Jason Andryuk <jandryuk@gmail.com>, xen-devel@lists.xenproject.org,
        Eduardo Otubo <otubo@redhat.com>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20180228122323.3914-1-jandryuk@gmail.com>
From: Simon Gaiser <simon@invisiblethingslab.com>
Message-ID: <1b07e839-5633-3b1e-1997-b86a891b2962@invisiblethingslab.com>
Date: Thu, 19 Apr 2018 18:10:00 +0000
MIME-Version: 1.0
In-Reply-To: <20180228122323.3914-1-jandryuk@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="myGTiVextl6vFeRqaSm5HcOSlnXDVaIsW"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--myGTiVextl6vFeRqaSm5HcOSlnXDVaIsW
Content-Type: multipart/mixed; boundary="gwO90y9nkFM5w1gygVmy6KSInYvYfczEg";
 protected-headers="v1"
From: Simon Gaiser <simon@invisiblethingslab.com>
To: netdev@vger.kernel.org
Cc: Jason Andryuk <jandryuk@gmail.com>, xen-devel@lists.xenproject.org,
 Eduardo Otubo <otubo@redhat.com>, Juergen Gross <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 open list <linux-kernel@vger.kernel.org>
Message-ID: <1b07e839-5633-3b1e-1997-b86a891b2962@invisiblethingslab.com>
Subject: Re: [Xen-devel] [PATCH] xen-netfront: Fix hang on device removal
References: <20180228122323.3914-1-jandryuk@gmail.com>
In-Reply-To: <20180228122323.3914-1-jandryuk@gmail.com>

--gwO90y9nkFM5w1gygVmy6KSInYvYfczEg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Jason Andryuk:
> A toolstack may delete the vif frontend and backend xenstore entries
> while xen-netfront is in the removal code path.  In that case, the
> checks for xenbus_read_driver_state would return XenbusStateUnknown, an=
d
> xennet_remove would hang indefinitely.  This hang prevents system
> shutdown.
>=20
> xennet_remove must be able to handle XenbusStateUnknown, and
> netback_changed must also wake up the wake_queue for that state as well=
=2E
>=20
> Fixes: 5b5971df3bc2 ("xen-netfront: remove warning when unloading modul=
e")

I think this should go into stable since AFAIK the hanging network
device can only be fixed by rebooting the guest. AFAICS this affects all
4.* branches since 5b5971df3bc2 got backported to them.

Upstream commit c2d2e6738a209f0f9dffa2dc8e7292fc45360d61.

Simon


--gwO90y9nkFM5w1gygVmy6KSInYvYfczEg--

--myGTiVextl6vFeRqaSm5HcOSlnXDVaIsW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE3E8ezGzG3N1CTQ//kO9xfO/xly8FAlrY27MACgkQkO9xfO/x
ly+uSxAAyh4Burc07vRFEo20sKnzrVL5x7BqgQAznYOWKsB5D6Yb1VaG11GTZfBp
G5FiaorTVm9zdqmIddxBgBZINtn2/SWvr5LwJfeYBjebBtccu+91CyeDT0P0T56l
FVut4ON195ZLYfH8eXE8y9Nvqh8M50n9dmeINrrelYzLbrkP6h9TSJ1h1tz4Jing
o+kBnjQJ9wGAuAQyWv2053ta/3oCYOI4DZsFcFhDZcCuEz6Kll4a/WeSA8QcLp9y
m3iTqIAxtbom+DHfWaZnRD9GO4nxflDJb9Xt34TxJn3RKn34XZ+NSVUPkz2l44oS
k6OowweN7/faH1SuVl2UTfcMflBNjISzQddXfHUpdfk9nNMSe9k3jnrRkWGfBmvA
FbiBhmUXcEAVYRDdiOgKMtnKboY1lWKaNE1CdoVdMBo32FgJc1eKWOwV6LiQ1Xpo
gNfjfZqmvJ8ok9Px4sg12wlSXkchtocRup48FTPHvdqdUAQXDwPM7iS1KGLKQ+QA
8OayJEV19dyLQDRPy2kqynxJzt/0qX0hp/bNWG4MPawWJmSi2h5Mt2UrFsKqXEXa
1DzGw0pmN2NaN8mdhcW1NEe098qh9qipIiEGHqN9qkYkt2wtYZF6+p/Vf6zX7lb7
7vVbIvctoeGDpN9Q8eZYTUTwuDHAZcVZed2Dikrj+nk37pDxYqo=
=a9YR
-----END PGP SIGNATURE-----

--myGTiVextl6vFeRqaSm5HcOSlnXDVaIsW--
