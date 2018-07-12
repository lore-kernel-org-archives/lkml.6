Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A236C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4003520C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4003520C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeGLKZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 06:25:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:50178 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726507AbeGLKZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 06:25:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B5E2EADCD;
        Thu, 12 Jul 2018 10:16:11 +0000 (UTC)
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where
 applicable
To:     Steven Rostedt <rostedt@goodmis.org>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hans de Goede <hdegoede@redhat.com>
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-3-hdegoede@redhat.com>
 <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
 <20180711105255.32803a3c@gandalf.local.home>
 <7ec11c96-7dd5-ec12-548e-7c1fa9b883e8@suse.de>
 <d528a539-255c-f019-eb6f-63f0585e0de3@redhat.com>
 <CAKMK7uG-xiCKkxhujL=J6n9ozYfW+fsioGHEmYRxpszVX=5PDg@mail.gmail.com>
 <892782ad-4b97-8eda-f5b0-3a893b3a5f84@redhat.com>
 <CAKMK7uFyPh0sHj7enAU2En4BidODAS+Tis=-UE16xOLQWm8iQA@mail.gmail.com>
 <2f37f47c-e28e-77fa-2383-96c7d3e77433@redhat.com>
 <CAKMK7uFuZ6NJOKHG6PRNLUytE4m6ZUdMakwLx9Ns39OwvTneWQ@mail.gmail.com>
 <20180711151911.2ea40200@gandalf.local.home>
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
Message-ID: <d9030c6d-e650-0b8d-541b-76542515387e@suse.de>
Date:   Thu, 12 Jul 2018 12:16:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180711151911.2ea40200@gandalf.local.home>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6DWogFQOenWDib6gpQeYrQkrfIz01aw6Z"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6DWogFQOenWDib6gpQeYrQkrfIz01aw6Z
Content-Type: multipart/mixed; boundary="PWWLxQqOZ55MRNZx1kdjmHyUp5uLhbqD2";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>, Daniel Vetter <daniel@ffwll.ch>
Cc: Petr Mladek <pmladek@suse.com>,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Hans de Goede <hdegoede@redhat.com>
Message-ID: <d9030c6d-e650-0b8d-541b-76542515387e@suse.de>
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where
 applicable
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-3-hdegoede@redhat.com>
 <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
 <20180711105255.32803a3c@gandalf.local.home>
 <7ec11c96-7dd5-ec12-548e-7c1fa9b883e8@suse.de>
 <d528a539-255c-f019-eb6f-63f0585e0de3@redhat.com>
 <CAKMK7uG-xiCKkxhujL=J6n9ozYfW+fsioGHEmYRxpszVX=5PDg@mail.gmail.com>
 <892782ad-4b97-8eda-f5b0-3a893b3a5f84@redhat.com>
 <CAKMK7uFyPh0sHj7enAU2En4BidODAS+Tis=-UE16xOLQWm8iQA@mail.gmail.com>
 <2f37f47c-e28e-77fa-2383-96c7d3e77433@redhat.com>
 <CAKMK7uFuZ6NJOKHG6PRNLUytE4m6ZUdMakwLx9Ns39OwvTneWQ@mail.gmail.com>
 <20180711151911.2ea40200@gandalf.local.home>
In-Reply-To: <20180711151911.2ea40200@gandalf.local.home>

--PWWLxQqOZ55MRNZx1kdjmHyUp5uLhbqD2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Am 11.07.2018 um 21:19 schrieb Steven Rostedt:
> I just sent the patch. If the printk maintainers take it, then you can
> update the fb driver to set the ignore_console_lock_warning when
> lockless_fb_register is set.

Thank you.

>=20
> -- Steve
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 N=C3=BCrnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard,
Graham Norton, HRB 21284 (AG N=C3=BCrnberg)


--PWWLxQqOZ55MRNZx1kdjmHyUp5uLhbqD2--

--6DWogFQOenWDib6gpQeYrQkrfIz01aw6Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAltHKmoACgkQaA3BHVML
eiO5TQgAqm8yCMpy2qDkvDfvqNqm6ymICc04QWvrr9Cm7oKTB+9NzxHy7lhsknYi
NnGEdEtujEprj9+3ntTYpc2CEsbf5zvLlGDKcmOZiaod6SdcMUOboD3ramm6I7e/
l49HZILSc6CEkY00yWWfn9QLTIe/lIHpjHoV0Yq+KtPV19vFr5KPFnHS9/yPSpTR
g8zs75ENTn6qetEQCPO9l87zIiXxXYsjQBTB6FP/5r7OP/Eo5w0tcN+sP53L2GYO
u549hxGVPiA+JhPqIX6EZOInHDFWqGGhxxOMoRLkBUyfHPzcWRW8BuUSR5KeN9g5
7X0aCYILKL9BXcGWeKnMyIK/GGE93w==
=TPee
-----END PGP SIGNATURE-----

--6DWogFQOenWDib6gpQeYrQkrfIz01aw6Z--
