Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48358C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A1B2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A1B2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733121AbeGKPLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:11:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:33872 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbeGKPLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:11:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CCF2FACC2;
        Wed, 11 Jul 2018 15:07:04 +0000 (UTC)
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where
 applicable
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-3-hdegoede@redhat.com>
 <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
 <20180711105255.32803a3c@gandalf.local.home>
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
Message-ID: <7ec11c96-7dd5-ec12-548e-7c1fa9b883e8@suse.de>
Date:   Wed, 11 Jul 2018 17:07:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180711105255.32803a3c@gandalf.local.home>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8jO8uhRH2wuGaDZE6PEmEAoivhuFSjoHp"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8jO8uhRH2wuGaDZE6PEmEAoivhuFSjoHp
Content-Type: multipart/mixed; boundary="ajt8tghe2MGlzHmLLB0KjTT2nIIjCXGmg";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Message-ID: <7ec11c96-7dd5-ec12-548e-7c1fa9b883e8@suse.de>
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where
 applicable
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-3-hdegoede@redhat.com>
 <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
 <20180711105255.32803a3c@gandalf.local.home>
In-Reply-To: <20180711105255.32803a3c@gandalf.local.home>

--ajt8tghe2MGlzHmLLB0KjTT2nIIjCXGmg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 11.07.2018 um 16:52 schrieb Steven Rostedt:
>=20
> What if you make lockless_register_fb visible to fbcon, and then we can=

> have a macro:

There are more of these macro invocations under drivers/tty/vt, which
also mess up the log during debugging.

WARN_CONSOLE_UNLOCKED is already protected by an '#ifdef 1 ... #else
=2E..' construct [1]. I thought about turning this into a config option.

Best regards
Thomas

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclude/linux/console.h#n203

>=20
> #define WARN_FB_CONSOLE_UNLOCKED() 			\
> 	do {						\
> 		if (unlikely(!lockless_register_fb))	\
> 			WARN_CONSOLE_UNLOCKED();	\
> 	} while (0)
>=20
> And use that instead?
>=20
> -- Steve
>=20
>=20
>> Best regards
>> Thomas
>>
>>> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> Changes in v3:
>>> -New patch in v3 of this patchset
>>>
>>> Changes in v4:
>>> -Keep the comments about which fbcon functions need locks in place
>>> ---
>>>  drivers/video/fbdev/core/fbcon.c | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/c=
ore/fbcon.c
>>> index c910e74d46ff..cd8d52a967aa 100644
>>> --- a/drivers/video/fbdev/core/fbcon.c
>>> +++ b/drivers/video/fbdev/core/fbcon.c
>>> @@ -828,6 +828,8 @@ static int set_con2fb_map(int unit, int newidx, i=
nt user)
>>>  	struct fb_info *oldinfo =3D NULL;
>>>   	int found, err =3D 0;
>>> =20
>>> +	WARN_CONSOLE_UNLOCKED();
>>> +
>>>  	if (oldidx =3D=3D newidx)
>>>  		return 0;
>>> =20
>>> @@ -3044,6 +3046,8 @@ static int fbcon_fb_unbind(int idx)
>>>  {
>>>  	int i, new_idx =3D -1, ret =3D 0;
>>> =20
>>> +	WARN_CONSOLE_UNLOCKED();
>>> +
>>>  	if (!fbcon_has_console_bind)
>>>  		return 0;
>>> =20
>>> @@ -3094,6 +3098,8 @@ static int fbcon_fb_unregistered(struct fb_info=
 *info)
>>>  {
>>>  	int i, idx;
>>> =20
>>> +	WARN_CONSOLE_UNLOCKED();
>>> +
>>>  	idx =3D info->node;
>>>  	for (i =3D first_fb_vc; i <=3D last_fb_vc; i++) {
>>>  		if (con2fb_map[i] =3D=3D idx)
>>> @@ -3131,6 +3137,9 @@ static int fbcon_fb_unregistered(struct fb_info=
 *info)
>>>  static void fbcon_remap_all(int idx)
>>>  {
>>>  	int i;
>>> +
>>> +	WARN_CONSOLE_UNLOCKED();
>>> +
>>>  	for (i =3D first_fb_vc; i <=3D last_fb_vc; i++)
>>>  		set_con2fb_map(i, idx, 0);
>>> =20
>>> @@ -3177,6 +3186,8 @@ static int fbcon_fb_registered(struct fb_info *=
info)
>>>  {
>>>  	int ret =3D 0, i, idx;
>>> =20
>>> +	WARN_CONSOLE_UNLOCKED();
>>> +
>>>  	idx =3D info->node;
>>>  	fbcon_select_primary(info);
>>>   =20
>>
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 N=C3=BCrnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard,
Graham Norton, HRB 21284 (AG N=C3=BCrnberg)


--ajt8tghe2MGlzHmLLB0KjTT2nIIjCXGmg--

--8jO8uhRH2wuGaDZE6PEmEAoivhuFSjoHp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAltGHRQACgkQaA3BHVML
eiMqUQf+OhrkPRUI5OUM3E8z1+kzEOaiT/4kBAPSVPhwGbPCKQ5QalK9AqAFXEmT
bUKHn5XOMDBRWRzkauR7iTmgyJ7AQgs06dmQDFSJRKA1H8DXRHuv225+LOx5h26L
Bn1JhedgI7sxPm/X5wxJLjzyNNpxfBYPy18ddS4ebsTAU1nkB/xEmFtrJj7xRkFo
0PBskiwJerAifcqH6KkFtfUmfamIIe4HnNcyJtVUCiKCrKaDYmn6dwSLO1ZZ+6+M
wRPjOszWr0Xhgfzp328d+kihEvwo1gAspl6AG4ZjT8XK1tCZY60gAGWKarv1MyzI
qY64aBmjnaizTwL4XgUULY+l4W6J2Q==
=scnP
-----END PGP SIGNATURE-----

--8jO8uhRH2wuGaDZE6PEmEAoivhuFSjoHp--
