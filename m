Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933576AbeBMHld (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 02:41:33 -0500
Received: from mail-lf0-f45.google.com ([209.85.215.45]:46234 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933463AbeBMHlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 02:41:32 -0500
X-Google-Smtp-Source: AH8x224QaHjqC1nw9PnkhEaCRi08J6GBZC0dV+pJEIKDB3WseAVvGskvmLsRDrCAQvNFv5STk+JGZg==
Date: Tue, 13 Feb 2018 09:41:22 +0200
From: Pekka Paalanen <ppaalanen@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>,
        Stefan Hajnoczi <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org, kernel@collabora.com
Subject: Re: [PATCH v3 1/2] drm/virtio: Add window server support
Message-ID: <20180213094122.5675d5f9@eldfell>
In-Reply-To: <20180212114540.iygbha554busy4ip@sirius.home.kraxel.org>
References: <20180126135803.29781-1-tomeu.vizoso@collabora.com>
        <20180126135803.29781-2-tomeu.vizoso@collabora.com>
        <20180201163623.5cs2ysykg5wgulf4@sirius.home.kraxel.org>
        <49785e0d-936a-c3b4-62dd-aafc7083a942@collabora.com>
        <20180205122017.4vb5nlpodkq2uhxa@sirius.home.kraxel.org>
        <f07a5347-13fe-76c2-f971-3f02abebd3c9@collabora.com>
        <20180205160322.sntv5uoqp5o7flnh@sirius.home.kraxel.org>
        <fd557eb7-f539-2ecf-142c-8313b9f7ddb3@collabora.com>
        <20180206142302.vdjyqmnoypydci4t@sirius.home.kraxel.org>
        <04687943-847b-25a7-42ef-a21b4c7ef0cf@collabora.com>
        <20180212114540.iygbha554busy4ip@sirius.home.kraxel.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/S6BabFRhENcv38d7GI_W2Bn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/S6BabFRhENcv38d7GI_W2Bn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Feb 2018 12:45:40 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>=20
> > >    (a) software rendering: client allocates shared memory buffer, ren=
ders
> > >        into it, then passes a file handle for that shmem block togeth=
er
> > >        with some meta data (size, format, ...) to the wayland server.
> > >=20
> > >    (b) gpu rendering: client opens a render node, allocates a buffer,
> > >        asks the cpu to renders into it, exports the buffer as dma-buf
> > >        (DRM_IOCTL_PRIME_HANDLE_TO_FD), passes this to the wayland ser=
ver
> > >        (again including meta data of course).
> > >=20
> > > Is that correct? =20
> >=20
> > Both are correct descriptions of typical behaviors. But it isn't spec'ed
> > anywhere who has to do the buffer allocation. =20
>=20
> Well, according to Pekka's reply it is spec'ed that way, for the
> existing buffer types.  So for server allocated buffers you need
> (a) a wayland protocol extension and (b) support for the extension
> in the clients.

Correct. Or simply a libEGL that uses such Wayland extension behind
everyone's back. I believe such things did at least exist, but are
probably not relevant for this discussion.

(If there is a standard library, like libEGL, loaded and used by both a
server and a client, that library can advertise custom private Wayland
protocol extensions and the client side can take advantage of them,
both without needing any code changes on either the server or the
client.)

> We also need a solution for the keymap shmem block.  I guess the keymap
> doesn't change all that often, so maybe it is easiest to just copy it
> over (host proxy -> guest proxy) instead of trying to map the host shmem
> into the guest?

Yes, I believe that would be a perfectly valid solution for that
particular case.


Thanks,
pq

--Sig_/S6BabFRhENcv38d7GI_W2Bn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAlqClqIACgkQI1/ltBGq
qqcPag/+KR7kWEABD7egQVQqfbX0wcPINa9SBMPaCP+L/yorn0Uv/CuctYa+zAMb
MirWq1cz1Ssm1Yewy2Jotmlwmlxr79U7diwkpBQ8Aj/a2Da4y9O4EVg+wNfRz61x
hH2Vs6Ygtzrq+xaJXRRBHUvQrqmeIAqd3dLT/3q8XiFLPsEj4p8mBpZUZJ5f/Fs+
l06ne5wo2VJUKJxtlRQEDLiPNi0/nq9B3+6fF+/d5VqUvrv8lR/2cVFGQ1saeRnT
mJxU+xilloGqyPTu9CEZjYZjAYw37HXxuotZEedvbn0YsUMl50JkNX/o4SiKDzVU
UQ3OJaTkzUgsfYKTtCTEeWAkhFH45D9vper1LrrWQmwEXEJ1Z57Z7+p2WuOSnv0A
ruQo1OsKmS1mEqXsPCQcH7PVEzRIU1gF89My2CAM2KL8C+i/pV8n2zpkshka1QGL
bOn7qSfY9KZZ8NjEdOIA1829vBtx1FLQbw+nGMpeyxUh/L0G4Oja4ik1BYdePfzS
eXF5IrPgdIjy5ZjKeOOE3WBtPS/Jp+FbU6jlrnvnjEOJijBdlnoWnYaxkZ1OkMPB
KfjwBwjNRxwi8R8CYT0+yvAwMhpHHhrUlL1ucj6TIPGfDw1Mrwd4bFmvOInAkC5G
wXdbld2Nxa9GWmD6F3H3wlWCCV/VxeZKnAzev8lFAiy+Wmsx/lI=
=JNFH
-----END PGP SIGNATURE-----

--Sig_/S6BabFRhENcv38d7GI_W2Bn--
