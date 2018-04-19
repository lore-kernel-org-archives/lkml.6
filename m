Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753366AbeDSUJ1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 16:09:27 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49417 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752153AbeDSUJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 16:09:26 -0400
X-ME-Sender: <xms:dffYWgB2u117c4TSn9UWVwU3b9NW-4Y_2bkBhdZyn9FEh4XwgWG4bQ>
Subject: Re: [Xen-devel] [PATCH] xen-netfront: Fix hang on device removal
To: Jason Andryuk <jandryuk@gmail.com>
Cc: netdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        Eduardo Otubo <otubo@redhat.com>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20180228122323.3914-1-jandryuk@gmail.com>
 <1b07e839-5633-3b1e-1997-b86a891b2962@invisiblethingslab.com>
 <CAKf6xpuusCJ0DMJ_G3hG5pd9vd8rUBH=VPa4TCvaoptGto-=Zw@mail.gmail.com>
From: Simon Gaiser <simon@invisiblethingslab.com>
Message-ID: <6ad676c8-476f-1181-1acd-985671f6c837@invisiblethingslab.com>
Date: Thu, 19 Apr 2018 20:09:00 +0000
MIME-Version: 1.0
In-Reply-To: <CAKf6xpuusCJ0DMJ_G3hG5pd9vd8rUBH=VPa4TCvaoptGto-=Zw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="5u8trKVAeNy4LF1MR15s5bqCN9UIos27C"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5u8trKVAeNy4LF1MR15s5bqCN9UIos27C
Content-Type: multipart/mixed; boundary="jAv05fVE9GqNrG6iq4E36ns4Fw2mTx1hD";
 protected-headers="v1"
From: Simon Gaiser <simon@invisiblethingslab.com>
To: Jason Andryuk <jandryuk@gmail.com>
Cc: netdev@vger.kernel.org, xen-devel@lists.xenproject.org,
 Eduardo Otubo <otubo@redhat.com>, Juergen Gross <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 open list <linux-kernel@vger.kernel.org>
Message-ID: <6ad676c8-476f-1181-1acd-985671f6c837@invisiblethingslab.com>
Subject: Re: [Xen-devel] [PATCH] xen-netfront: Fix hang on device removal
References: <20180228122323.3914-1-jandryuk@gmail.com>
 <1b07e839-5633-3b1e-1997-b86a891b2962@invisiblethingslab.com>
 <CAKf6xpuusCJ0DMJ_G3hG5pd9vd8rUBH=VPa4TCvaoptGto-=Zw@mail.gmail.com>
In-Reply-To: <CAKf6xpuusCJ0DMJ_G3hG5pd9vd8rUBH=VPa4TCvaoptGto-=Zw@mail.gmail.com>

--jAv05fVE9GqNrG6iq4E36ns4Fw2mTx1hD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Jason Andryuk:
> On Thu, Apr 19, 2018 at 2:10 PM, Simon Gaiser
> <simon@invisiblethingslab.com> wrote:
>> Jason Andryuk:
>>> A toolstack may delete the vif frontend and backend xenstore entries
>>> while xen-netfront is in the removal code path.  In that case, the
>>> checks for xenbus_read_driver_state would return XenbusStateUnknown, =
and
>>> xennet_remove would hang indefinitely.  This hang prevents system
>>> shutdown.
>>>
>>> xennet_remove must be able to handle XenbusStateUnknown, and
>>> netback_changed must also wake up the wake_queue for that state as we=
ll.
>>>
>>> Fixes: 5b5971df3bc2 ("xen-netfront: remove warning when unloading mod=
ule")
>>
>> I think this should go into stable since AFAIK the hanging network
>> device can only be fixed by rebooting the guest. AFAICS this affects a=
ll
>> 4.* branches since 5b5971df3bc2 got backported to them.
>>
>> Upstream commit c2d2e6738a209f0f9dffa2dc8e7292fc45360d61.
>=20
> Simon,
>=20
> Yes, I agree.  I actually submitted the request to stable earlier
> today, so hopefully it gets added soon.

Ok, great. (I checked the stable patch queue, but didn't check the
mailing list archive).

> Have you experienced this hang?

Yes, it's affecting the kernel shipped by Qubes OS (see [1]).

Thanks, Simon.

[1]: https://github.com/QubesOS/qubes-issues/issues/3657


--jAv05fVE9GqNrG6iq4E36ns4Fw2mTx1hD--

--5u8trKVAeNy4LF1MR15s5bqCN9UIos27C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE3E8ezGzG3N1CTQ//kO9xfO/xly8FAlrY948ACgkQkO9xfO/x
ly9FHg//QOF2+kbnv9PmuOMSIPxmcg80tWRRkhsa9ZEqrFY5EB1OcTYy1bNfPAS+
frypECcQSl6M2G9eyB+aLFMWnEkndKEAQowIS2iXzqQp/O1y8CoO2Rhnr8u45Ft4
zSRiR+Y2b4tOIqpkjwuUUN9kyVcMYgdpCX4uGrIWl4o7fvaEOd2rbfwVXcfkGANR
TlwyED4FI1WgTq3rYl+WRC4lc1GvJMBl0lfwIGQFqnquj3yuOaLObDlJpEnJPRSz
yH4VCNsevrupxvy0xNJkOzIQmHH/0aHCnXarSMC5b1xGQaODHCm+N+NophaeN7h3
jgD1F6qZKT7BANQnyNDq0J2W2jRVLxD7uFFo5x/kXWuwaDUFJ1+yvIpPALYzAWzR
9UnvvNKXmr4p1FFa3yeqBi2zn7Lm8AHpT9qsMH/5Uhas9PU3hmawsEk8wflS9jtX
BZR34tmvVICAz/fFXJaN3+YK8HPrebcWz9TtAHCYNcD9vsc8B7A2fnVOxfWfrPc+
A1qZTC8HNtQB8KeNgwHMPQR/VHaq+fKFxcG9J4154KkAkmEkB5t2prjtT0Xo2tPo
8PZPVPz12K3eoeQU3ZwMkxle9k1dldN5R3d48fw5RpnLYY53arQhn+KzZR3wTEJx
iuu3aqUZy45QD1HWHNIN/lBgGZKaYQniuTVKY797+gx8b7aJl3k=
=Z+I/
-----END PGP SIGNATURE-----

--5u8trKVAeNy4LF1MR15s5bqCN9UIos27C--
