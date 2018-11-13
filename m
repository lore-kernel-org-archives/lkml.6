Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622F7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3852243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3852243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733006AbeKMWOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 17:14:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:48416 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732950AbeKMWOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 17:14:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6E7BDB035;
        Tue, 13 Nov 2018 12:16:16 +0000 (UTC)
Subject: Re: Performance regression in ast drm driver
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Takashi Iwai <tiwai@suse.de>, David Airlie <airlied@redhat.com>,
        christian.koenig@amd.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20181101162707.598c1718@endymion>
 <20181108130509.3b2d42ff@endymion>
 <CAMwc25oWstf8bFfWfb=FFR8GfFhx+jM77TzqE-qfi+ev2pMvFw@mail.gmail.com>
 <1542033367.2661.33.camel@suse.de> <s5hh8gmfj7a.wl-tiwai@suse.de>
 <1542040904.2661.35.camel@suse.de>
 <89ae9adf-27e7-ae80-639c-c67202a0d0b7@suse.de>
 <20181113130821.2a7694a6@endymion>
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
Message-ID: <2de96ad6-11a4-860a-da86-b9e38529bc99@suse.de>
Date:   Tue, 13 Nov 2018 13:16:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181113130821.2a7694a6@endymion>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cn9Niv9yGLxblSA5mGptzvn90G7SnDlxp"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cn9Niv9yGLxblSA5mGptzvn90G7SnDlxp
Content-Type: multipart/mixed; boundary="4q57kKWQoHDKhXrBoch6sj6wuY6nnvoPM";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Jean Delvare <jdelvare@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>, David Airlie <airlied@redhat.com>,
 christian.koenig@amd.com, dri-devel <dri-devel@lists.freedesktop.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2de96ad6-11a4-860a-da86-b9e38529bc99@suse.de>
Subject: Re: Performance regression in ast drm driver
References: <20181101162707.598c1718@endymion>
 <20181108130509.3b2d42ff@endymion>
 <CAMwc25oWstf8bFfWfb=FFR8GfFhx+jM77TzqE-qfi+ev2pMvFw@mail.gmail.com>
 <1542033367.2661.33.camel@suse.de> <s5hh8gmfj7a.wl-tiwai@suse.de>
 <1542040904.2661.35.camel@suse.de>
 <89ae9adf-27e7-ae80-639c-c67202a0d0b7@suse.de>
 <20181113130821.2a7694a6@endymion>
In-Reply-To: <20181113130821.2a7694a6@endymion>

--4q57kKWQoHDKhXrBoch6sj6wuY6nnvoPM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 13.11.18 um 13:08 schrieb Jean Delvare:
> Hi Thomas,
>=20
> On Tue, 13 Nov 2018 10:23:45 +0100, Thomas Zimmermann wrote:
>> ast doesn't remove the vesafb's framebuffer before attaching to the
>> device. I have a patch at [1]. If you have a way of testing it, I'd
>> appreciate.
>>
>> [1] https://bugzilla.suse.com/show_bug.cgi?id=3D1112963
>=20
> Thank you very much for looking into this bug. I tested the patch above=

> and yes, it solves my console performance problem. The performance with=

> your patch applied is roughly the same as with commit "drm/drivers: add=

> support for using the arch wc mapping API" reverted.
>=20

Great. I'll add it to SLE and also send it upstream soonish. Let's see
what Edward reports. Thanks for building a kernel for him.

Best regards
Thomas

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 N=C3=BCrnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard,
Graham Norton, HRB 21284 (AG N=C3=BCrnberg)


--4q57kKWQoHDKhXrBoch6sj6wuY6nnvoPM--

--cn9Niv9yGLxblSA5mGptzvn90G7SnDlxp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlvqwIsACgkQaA3BHVML
eiOX7QgAlVjK8nDvXQ4H8J8iasnNp9XP4Otoqi+/ptRXKVF4V1t3nm4mQqyY/5cI
P1WfS9dh5mgpExmQM6SuwEXzp1tDCwlRValf/rMRmXKJHuYkynU8COxkkKjcMzAK
oMX7jHKoCy/VagNS+ZL1ZuZb52uVomsnYFhlab3N4HaoJ58MtroB41W5NCsFPBHH
wkqsjYimIJwT0N7g0qDFpov8sutmf/QIC0fqqj90VZ/w2M26gHjP2mYSOT+OXTiv
+34aDZSzxAOfTqS9/h4qv0xnAHeZa6bcOEmBdEdcG+ZXkKxxCZbir7BEIzHUYqj9
elT+o5GHoIxHoOt35r9rEgasvK7YbA==
=lmfi
-----END PGP SIGNATURE-----

--cn9Niv9yGLxblSA5mGptzvn90G7SnDlxp--
