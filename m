Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE07ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F12620673
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F12620673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbeGRIwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:52:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:58306 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726080AbeGRIwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:52:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 978AEAD9F;
        Wed, 18 Jul 2018 08:15:34 +0000 (UTC)
Subject: Re: [PATCH v2] console: Replace #if 1 with a bool to ignore
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
References: <20180712092938.22e33641@gandalf.local.home>
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
Message-ID: <3bc67f92-d590-b338-1953-157d9863405d@suse.de>
Date:   Wed, 18 Jul 2018 10:15:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180712092938.22e33641@gandalf.local.home>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="atdjv6TYUOVLoJhuJY4fHII1pziybYOhR"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--atdjv6TYUOVLoJhuJY4fHII1pziybYOhR
Content-Type: multipart/mixed; boundary="aU3KOqIK40UTqpqA20DZ8Q8s5VaQdV8oZ";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Petr Mladek <pmladek@suse.com>,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Hans de Goede <hdegoede@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Message-ID: <3bc67f92-d590-b338-1953-157d9863405d@suse.de>
Subject: Re: [PATCH v2] console: Replace #if 1 with a bool to ignore
References: <20180712092938.22e33641@gandalf.local.home>
In-Reply-To: <20180712092938.22e33641@gandalf.local.home>

--aU3KOqIK40UTqpqA20DZ8Q8s5VaQdV8oZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 12.07.2018 um 15:29 schrieb Steven Rostedt:
>=20
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
>=20
> There's been discussion on the fb list about the addition of
> WARN_CONSOLE_UNLOCKED() inside the fb code. The complaint is that when
> the fb module is loaded with lockless_register_fb the console lock is
> not taken for debugging reasons. With the addition of
> WARN_CONSOLE_UNLOCK() within the fb code, this causes the console to
> fill up with warnings when trying to debug the fb driver.
>=20
> There's also a #if 1 that enables the warning which was added before
> git history, and we look down on constant #if's in the kernel nowadays
> anyway.
>=20
> Remove the #if 1 and add a ignore_console_lock_warning boolean that can=

> be set by drivers to ignore the warning in order to do debugging.
>=20
> Link: http://lkml.kernel.org/r/717e6337-e7a6-7a92-1c1b-8929a25696b5@sus=
e.de
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> Changes since V1:
>  - Added comment to describe ignore_console_unlock_waring variable
>  - Abide by 80 character limit
>=20
> Index: linux-trace.git/include/linux/console.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-trace.git.orig/include/linux/console.h
> +++ linux-trace.git/include/linux/console.h
> @@ -200,11 +200,14 @@ void vcs_make_sysfs(int index);
>  void vcs_remove_sysfs(int index);
> =20
>  /* Some debug stub to catch some of the obvious races in the VT code *=
/
> -#if 1
> -#define WARN_CONSOLE_UNLOCKED()	WARN_ON(!is_console_locked() && !oops_=
in_progress)
> -#else
> -#define WARN_CONSOLE_UNLOCKED()
> -#endif
> +#define WARN_CONSOLE_UNLOCKED()						\
> +	WARN_ON(!ignore_console_lock_warning &&				\
> +		!is_console_locked() && !oops_in_progress)
> +/*
> + * Set ignore_console_lock_warning to true if you need to quiet
> + * WARN_CONSOLE_UNLOCKED() for debugging purposes.
> + */
> +extern bool ignore_console_lock_warning;
> =20
>  /* VESA Blanking Levels */
>  #define VESA_NO_BLANKING        0
> Index: linux-trace.git/kernel/printk/printk.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-trace.git.orig/kernel/printk/printk.c
> +++ linux-trace.git/kernel/printk/printk.c
> @@ -66,6 +66,9 @@ int console_printk[4] =3D {
>  	CONSOLE_LOGLEVEL_DEFAULT,	/* default_console_loglevel */
>  };
> =20
> +bool ignore_console_lock_warning __read_mostly;
> +EXPORT_SYMBOL(ignore_console_lock_warning);
> +
>  /*
>   * Low level drivers may need that to know if they can schedule in
>   * their unblank() callback or not. So let's export it.
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20

This resolves the problem for me.

Tested-by: Thomas Zimmermann <tzimmermann@suse.de>

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 N=C3=BCrnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard,
Graham Norton, HRB 21284 (AG N=C3=BCrnberg)


--aU3KOqIK40UTqpqA20DZ8Q8s5VaQdV8oZ--

--atdjv6TYUOVLoJhuJY4fHII1pziybYOhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAltO9yEACgkQaA3BHVML
eiOjggf/eGpR02dnXYx0IDH0HWbLIg/i8K6lU9XMIK5h4aAsg3ulwa3IKZ4gWIyR
VFUn1qyrGGtyBbHNRMdwEmddZ9m6phw45XDsS6CAZ16cTvimHZcsEHMy/dYpntO5
bfyoZjPVpDteP5zZOocwe6gif+tjYKcSsQHMmEM0mTCTsnGVXJlbwqB0yvamrNCr
LQ9M0gqicgfbyB1c9V1nDQ5SvbtlWvkH7OWtNHLj+4wzROwSRsblmuUa8/eiY6QQ
piNwOUaKWSYSdmql47stjdQLfmdBqiDW7umai6Fja5deGHym/vJh6rdy/kRBmGvE
RZnUJ4dk53GEHxivhmHCnxPncFMHHw==
=Nit+
-----END PGP SIGNATURE-----

--atdjv6TYUOVLoJhuJY4fHII1pziybYOhR--
