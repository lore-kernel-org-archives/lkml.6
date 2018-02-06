Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeBFPA0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 10:00:26 -0500
Received: from mail-lf0-f46.google.com ([209.85.215.46]:39306 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752282AbeBFPAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 10:00:18 -0500
X-Google-Smtp-Source: AH8x227Bdb/h6aU6i13xkPSqnR3deqKCl/byzZqU7he4hWRKMsxRWhEJLWTzIEb/BtNEI3H/gieMWQ==
Date: Tue, 6 Feb 2018 17:00:13 +0200
From: Pekka Paalanen <ppaalanen@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>,
        Stefan Hajnoczi <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org, kernel@collabora.com
Subject: Re: [PATCH v3 1/2] drm/virtio: Add window server support
Message-ID: <20180206170013.7e2b08bb@eldfell>
In-Reply-To: <20180205160322.sntv5uoqp5o7flnh@sirius.home.kraxel.org>
References: <20180126135803.29781-1-tomeu.vizoso@collabora.com>
 <20180126135803.29781-2-tomeu.vizoso@collabora.com>
 <20180201163623.5cs2ysykg5wgulf4@sirius.home.kraxel.org>
 <49785e0d-936a-c3b4-62dd-aafc7083a942@collabora.com>
 <20180205122017.4vb5nlpodkq2uhxa@sirius.home.kraxel.org>
 <f07a5347-13fe-76c2-f971-3f02abebd3c9@collabora.com>
 <20180205160322.sntv5uoqp5o7flnh@sirius.home.kraxel.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YRXYvEnENKe9OWQMruDI4Eh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YRXYvEnENKe9OWQMruDI4Eh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 5 Feb 2018 17:03:22 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Mon, Feb 05, 2018 at 03:46:17PM +0100, Tomeu Vizoso wrote:
> > On 02/05/2018 01:20 PM, Gerd Hoffmann wrote: =20
> > >    Hi,
> > >  =20
>=20
> Hmm.  I allways assumed the wayland client allocates the buffers, not
> the server.  Is that wrong?

Hi Gerd,

a fly-by comment here:

The standard operation mode on Wayland indeed is that the client
allocates any pixel buffers. It is not the whole story though.

Server allocated buffers passed to a client also exist:
- core protocol uses this to pass keymaps to clients
- people are not forbidden from writing Wayland extensions that do this
  for whatever reason

The latter server-allocated case could probably be overlooked, but the
keymap case not really. Furthermore, copy&paste and drag&drop protocol
pass pipe file descriptors via Wayland to establish client-to-client
pipes.


Thanks,
pq

--Sig_/YRXYvEnENKe9OWQMruDI4Eh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAlp5wv4ACgkQI1/ltBGq
qqc8Cg//aFIZhRaCKo+sjSb+GvUO/L9rb23445t/y+iV6X1JbMw3GlmL7IBPqcB2
3jveY+iKuIIOlof7l5qtJpl3SNIWCoiz2aQbhICif++TyYQUJQkWbPYthxsdNBrS
b4oXg22xhXriFy8G7QaLfMEfBM2Tq8j+kNscgZRlPaYrMrkcF24Q2sNGk4SUIT3P
DFMV2oKFlYphNYrSlZ7n5cq8g+jvd19KG6NshtHAT5T8ECn5Z1hM31sCQZi53+6n
jhtEu6EN9cuQxaIzMLdWw4+/ZUKlFKopoXqLr1PL5K6vVlxRZlm4d6WmJSD8C975
l04vhwR2TqXrp9xjLb5Uh9ZbVAk/vBdiWaXtTFJ+8MTM+dbZhBze2jqvjm9D6CCd
/Vnd3v44JpnhPRW4A4yQ3OF/3tyfgfhvb/nmRJrzNKywn7bLiBhBXdLgW7oKqd+4
zl00Zcx0HLAiKcM2wywdzaJNJ2q5SPQb9cwz1YLnxlTrTGM8F1KGZXqQQ32J2jiQ
6Lur+aD6AsxNO3R9I7gHr47QWDHxnujxzPVFxXsEYPXCAbxrNe3G05YD321aL+jB
g0NNRNm+Tg4Zi+SaOvojqEC0p5UAWhdBSQolyJJJ5EcSewXbUdvprJjXEjLdYRRv
n186vTIF9TatR+uL0ucMbdjakymmsV/KU+Icl4iIiXfm+srNulE=
=X1pM
-----END PGP SIGNATURE-----

--Sig_/YRXYvEnENKe9OWQMruDI4Eh--
