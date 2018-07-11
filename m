Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B273EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8D420C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8D420C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388723AbeGKOvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:51:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:56250 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726689AbeGKOvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:51:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 886C1AF40;
        Wed, 11 Jul 2018 14:46:17 +0000 (UTC)
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where
 applicable
To:     Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     linux-fbdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-3-hdegoede@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNKFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmNvbT7CwJQEEwEIAD4W
 IQRyF/usjOnPY0ShaOVoDcEdUwt6IwUCWznTtgIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgID
 AQIeAQIXgAAKCRBoDcEdUwt6I7D7CACBK42XW+7mCiK8ioXMEy1NzGbXC51RzGea8N83oEJS
 1KVUtQxrkDxgrW/WLSl/TfqHFsJpdEFOv1XubWbleun3uKPy0e5vZCd5UjZPkeNjnqfCYTDy
 hVVsdOuFbtWDppJyJrThLqr9AgSFmoCNNUt1SVpYEEOLNE6C32BhlnSq21VLC+YXTgO/ZHTa
 YXkq54hHj63jwrcjkBSCkXLh37kHeqnl++GHpN+3R+o3w2OpwHAlvVjdKPT27v1tVkiydsFG
 65Vd0n3m/ft+IOrGgxQM1C20uqKvsZGB4r3OGR50ekAybO7sjEJJ1Obl4ge/6RRqcvKz4LMb
 tGs85D6tPIeFzsBNBFs50uABCADGJj+DP1fk+UWOWrf4O61HTbC4Vr9QD2K4fUUHnzg2B6zU
 R1BPXqLGG0+lzK8kfYU/F5RjmEcClsIkAaFkg4kzKP14tvY1J5+AV3yNqcdg018HNtiyrSwI
 E0Yz/qm1Ot2NMZ0DdvVBg22IMsiudQ1tx9CH9mtyTbIXgACvl3PW2o9CxiHPE/bohFhwZwh/
 kXYYAE51lhinQ3oFEeQZA3w4OTvxSEspiQR8dg8qJJb+YOAc5IKk6sJmmM7JfFMWSr22satM
 23oQ3WvJb4RV6HTRTAIEyyZS7g2DhiytgMG60t0qdABG5KXSQW+OKlZRpuWwKWaLh3if/p/u
 69dvpanbABEBAAHCwHwEGAEIACYWIQRyF/usjOnPY0ShaOVoDcEdUwt6IwUCWznS4AIbDAUJ
 A8JnAAAKCRBoDcEdUwt6I6X3CACJ8D+TpXBCqJE5xwog08+Dp8uBpx0T9n1wE0GQisZruACW
 NofYn8PTX9k4wmegDLwt7YQDdKxQ4+eTfZeLNQqWg6OCftH5Kx7sjWnJ09tOgniVdROzWJ7c
 VJ/i0okazncsJ+nq48UYvRGE1Swh3A4QRIyphWX4OADOBmTFl9ZYNPnh23eaC9WrNvFr7yP7
 iGjMlfEW8l6Lda//EC5VpXVNza0xeae0zFNst2R9pn+bLkihwDLWxOIyifGRxTqNxoS4I1aw
 VhxPSVztPMSpIA/sOr/N/p6JrBLn+gui2K6mP7bGb8hF+szfArYqz3T1rv1VzUWAJf5Wre5U
 iNx9uqqx
Message-ID: <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
Date:   Wed, 11 Jul 2018 16:46:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628090351.15581-3-hdegoede@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QBiUdYI2cLAGlVt5Ah5DucB7J6nfmFTpz"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QBiUdYI2cLAGlVt5Ah5DucB7J6nfmFTpz
Content-Type: multipart/mixed; boundary="sNmtio5EuBf8Tpax2m8x7cLI3SzjIhJHB";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Hans de Goede <hdegoede@redhat.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where
 applicable
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-3-hdegoede@redhat.com>
In-Reply-To: <20180628090351.15581-3-hdegoede@redhat.com>

--sNmtio5EuBf8Tpax2m8x7cLI3SzjIhJHB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Hi

Am 28.06.2018 um 11:03 schrieb Hans de Goede:
> Replace comments about places where the console lock should be held wit=
h
> calls to WARN_CONSOLE_UNLOCKED() to assert that it is actually held.

Debugging fbcon sometimes requires to not take the console lock. This
patch breaks the debugging workaround provided by
'fb.lockless_register_fb'. The dmesg is now filled with warnings about
the missing lock.

Best regards
Thomas

> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> -New patch in v3 of this patchset
>
> Changes in v4:
> -Keep the comments about which fbcon functions need locks in place
> ---
>  drivers/video/fbdev/core/fbcon.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/cor=
e/fbcon.c
> index c910e74d46ff..cd8d52a967aa 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -828,6 +828,8 @@ static int set_con2fb_map(int unit, int newidx, int=
 user)
>  	struct fb_info *oldinfo =3D NULL;
>   	int found, err =3D 0;
> =20
> +	WARN_CONSOLE_UNLOCKED();
> +
>  	if (oldidx =3D=3D newidx)
>  		return 0;
> =20
> @@ -3044,6 +3046,8 @@ static int fbcon_fb_unbind(int idx)
>  {
>  	int i, new_idx =3D -1, ret =3D 0;
> =20
> +	WARN_CONSOLE_UNLOCKED();
> +
>  	if (!fbcon_has_console_bind)
>  		return 0;
> =20
> @@ -3094,6 +3098,8 @@ static int fbcon_fb_unregistered(struct fb_info *=
info)
>  {
>  	int i, idx;
> =20
> +	WARN_CONSOLE_UNLOCKED();
> +
>  	idx =3D info->node;
>  	for (i =3D first_fb_vc; i <=3D last_fb_vc; i++) {
>  		if (con2fb_map[i] =3D=3D idx)
> @@ -3131,6 +3137,9 @@ static int fbcon_fb_unregistered(struct fb_info *=
info)
>  static void fbcon_remap_all(int idx)
>  {
>  	int i;
> +
> +	WARN_CONSOLE_UNLOCKED();
> +
>  	for (i =3D first_fb_vc; i <=3D last_fb_vc; i++)
>  		set_con2fb_map(i, idx, 0);
> =20
> @@ -3177,6 +3186,8 @@ static int fbcon_fb_registered(struct fb_info *in=
fo)
>  {
>  	int ret =3D 0, i, idx;
> =20
> +	WARN_CONSOLE_UNLOCKED();
> +
>  	idx =3D info->node;
>  	fbcon_select_primary(info);
> =20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 N=C3=BCrnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard,
Graham Norton, HRB 21284 (AG N=C3=BCrnberg)



--sNmtio5EuBf8Tpax2m8x7cLI3SzjIhJHB--

--QBiUdYI2cLAGlVt5Ah5DucB7J6nfmFTpz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAltGGDcACgkQaA3BHVML
eiPA0wf/UjMoShlEcO26+mipgSTdopT9blwyQ1cR05HKOc7R5ex02SGodVTYBPSm
YAaNa+vnGy0i8UFUirr1kjlYAfipVoU5MmLiT2GZp2tUOQ7RIv79QYgArB4nCGHZ
JhOh7enLjJnQHUx0mP0uHe3S3KD5hkUC5zU5aDpreJcFPJABDObVWAhJlsNk1Xvj
bzO+XqkN7T4mMCEx1Xlrv1ZVUF6KowfhtvTYYC7Z1+CDcL94fNj92u4IvtFNtyHC
oo/I2jr0+QzZC8bfPYWfMSv/2RkQ11bWns8jCnLr3pAKuCn5jxoOgeJLZpruL0H3
KJPQ4pbnSiP79Yrs8WxZwfI5kPK3Fw==
=PX+n
-----END PGP SIGNATURE-----

--QBiUdYI2cLAGlVt5Ah5DucB7J6nfmFTpz--
