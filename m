Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbeEBQ5F (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 12:57:05 -0400
Received: from anholt.net ([50.246.234.109]:56622 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751447AbeEBQ5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 12:57:02 -0400
From: Eric Anholt <eric@anholt.net>
To: Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] doc: botching-up-ioctls: Make it clearer why structs must be padded
In-Reply-To: <20180502075106.7476-1-daniel.vetter@ffwll.ch>
References: <20180502075106.7476-1-daniel.vetter@ffwll.ch>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Wed, 02 May 2018 09:56:58 -0700
Message-ID: <87muxi5739.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Daniel Vetter <daniel.vetter@ffwll.ch> writes:

> This came up in discussions when reviewing drm patches.
>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>
> --
>
> Aside: I wonder whether we shouldn't move this to some other place and
> rst-ify it? Any good suggestions?
> -Daniel
> ---
>  Documentation/ioctl/botching-up-ioctls.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ioctl/botching-up-ioctls.txt b/Documentation/ioctl/botching-up-ioctls.txt
> index d02cfb48901c..883fb034bd04 100644
> --- a/Documentation/ioctl/botching-up-ioctls.txt
> +++ b/Documentation/ioctl/botching-up-ioctls.txt
> @@ -73,7 +73,9 @@ will have a second iteration or at least an extension for any given interface.
>     future extensions is going right down the gutters since someone will submit
>     an ioctl struct with random stack garbage in the yet unused parts. Which
>     then bakes in the ABI that those fields can never be used for anything else
> -   but garbage.
> +   but garbage. This is also the reason why you must explicitly pad all
> +   structures, even if you never use them in an array - the padding the compiler
> +   might insert could contain garbage.

I hadn't realized that we had this document in git, or I probably would
have written this patch.  I think this makes it clear enough how I got
vc4 and v3d wrong.  Thanks!

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlrp7doACgkQtdYpNtH8
nujSSw//Yt2YIcLrz/sjFI9bbJ78aNyWQZJ/pWTNm1Z/kWNQys6kcQQWmwaZ6Wak
psSoKFQuXWVkDHyPPedXc582S/7DerPP5uJ4pfLMW29BknQq9BOP50fEm/eFMmNr
OgmqfdwSsj+IO/BmwOYfGuoBvavPLxhoTm1fiUvskz7dVZtYVS2Bk3bCX/Ab7hY8
HbbGqeTdIGkbZo7qgmFrT90+NhlRXWf+kum57QvtAlmLrSy8zwb7Nja/VUW4Zubd
cO6YZBqllWh7IWTatDkaQl4LREvmmhFYSGWXCkSkTfEgHm8/wejPd/cgjpRl3GW5
fqU943l14Y2Mq68LaVcPIfo6eRdK1snKPBVgrpyTF+Jil08SUvW6EP4Y06LIoKk5
zLUB6ypE+18MlRjETl+PAddBePQMHC80f4uGczVamJ9QKca5s33wSdg3Rq1ouIZs
8On0l98imqbO7klD6DaJ48EjgYyDN5HeRwIXJFtRbZB3gEUI2hydO/HhpimyyQ32
ZKEM9o9ccr+R5yP2EtVf54Iv/j9BEURueSLWm6ZHdnZcvZqmS5lEKJTUl/586Viw
T66vcI0WmKBEwWQW9dQIT/9HeQj2ZIQ+3jaGx7gpIzmQv+384R30/Iv7AURNqdjg
SNEF9mkui5ZcBk+7piDm9OF+9yOl8ilsHGHE/bTAdXr4nRlSEqM=
=YAwr
-----END PGP SIGNATURE-----
--=-=-=--
