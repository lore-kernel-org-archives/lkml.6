Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1E0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDD2224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDD2224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeKMFap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:30:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:58968 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725790AbeKMFap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:30:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 641F2AE4F;
        Mon, 12 Nov 2018 19:36:04 +0000 (UTC)
To:     Jean Delvare <jdelvare@suse.de>, David Airlie <airlied@redhat.com>
Cc:     christian.koenig@amd.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>
References: <20181101162707.598c1718@endymion>
 <20181108130509.3b2d42ff@endymion>
 <CAMwc25oWstf8bFfWfb=FFR8GfFhx+jM77TzqE-qfi+ev2pMvFw@mail.gmail.com>
 <1542033367.2661.33.camel@suse.de>
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
Subject: Re: Performance regression in ast drm driver
Message-ID: <c25b99fc-0762-ab88-7c08-f71510383e9e@suse.de>
Date:   Mon, 12 Nov 2018 20:36:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1542033367.2661.33.camel@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qe8FfTZQBr9r2XWiH4uNUyamIlp6fkMZq"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qe8FfTZQBr9r2XWiH4uNUyamIlp6fkMZq
Content-Type: multipart/mixed; boundary="Rn4ndp8dEZpMy3RT5hxOPCcvAIMetoyR9";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Jean Delvare <jdelvare@suse.de>, David Airlie <airlied@redhat.com>
Cc: christian.koenig@amd.com, dri-devel <dri-devel@lists.freedesktop.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>
Message-ID: <c25b99fc-0762-ab88-7c08-f71510383e9e@suse.de>
Subject: Re: Performance regression in ast drm driver
References: <20181101162707.598c1718@endymion>
 <20181108130509.3b2d42ff@endymion>
 <CAMwc25oWstf8bFfWfb=FFR8GfFhx+jM77TzqE-qfi+ev2pMvFw@mail.gmail.com>
 <1542033367.2661.33.camel@suse.de>
In-Reply-To: <1542033367.2661.33.camel@suse.de>

--Rn4ndp8dEZpMy3RT5hxOPCcvAIMetoyR9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Jean

Am 12.11.18 um 15:36 schrieb Jean Delvare:
> Hi David,
>=20
> On Fri, 2018-11-09 at 10:04 +1000, David Airlie wrote:
>> On Thu, Nov 8, 2018 at 10:05 PM Jean Delvare <jdelvare@suse.de> wrote:=

>>>
>>> On Thu, 1 Nov 2018 16:27:07 +0100, Jean Delvare wrote:
>>>> Hi David,
>>>>
>>>> The following commit:
>>>>
>>>> commit 7cf321d118a825c1541b43ca45294126fd474efa
>>>> Author: Dave Airlie
>>>> Date:   Mon Oct 24 15:37:48 2016 +1000
>>>>
>>>>     drm/drivers: add support for using the arch wc mapping API.
>>>>
>>>> is causing a huge performance regression for the ast drm driver. In =
a
>>>> text console, if I call "cat" on a large text file, it takes almost
>>>> twice as much time to be displayed and scrolled completely.
>>>>
>>>> Can you please check that the ast driver portion of that commit is b=
oth
>>>> correct and complete?
>>>
>>> And in the meantime, what bad will happen if we just revert the ast
>>> portion of that commit?
>>
>> This seems likely to be a hw problem with PCI writes to the AST "GPU",=

>> since it's just some sort of RAM + ARM on the end of a PCIE bus, we've=

>> definitely seen possible issues in the past with write combining
>> around some of the mga GPUs with some CPUs.
>=20
> Takashi asked me to compare the contents of
> /sys/kernel/debug/x86/pat_memtype_list before and after the commit
> above. Before the commit, we have:
>=20
> uncached-minus @ 0xfafe0000-0xfb000000
> uncached-minus @ 0xfb000000-0xfb005000
> write-combining @ 0xfb005000-0xfb584000
>=20
> After the commit, we have:
>=20
> uncached-minus @ 0xfafe0000-0xfb000000
> uncached-minus @ 0xfb000000-0xfb005000
> uncached-minus @ 0xfb000000-0xfb800000
> uncached-minus @ 0xfb005000-0xfb584000
>=20
> The corresponding lines in /proc/iomem are:
>=20
> f0000000-fed8ffff : PCI Bus 0000:00
> =C2=A0 faf00000-fb7fffff : PCI Bus 0000:01
> =C2=A0=C2=A0=C2=A0=C2=A0fafe0000-faffffff : 0000:01:01.0
> =C2=A0=C2=A0=C2=A0=C2=A0fb000000-fb7fffff : 0000:01:01.0
>=20
> Does it help? Is the change of type expected? Is it not a problem that
> one of the ranges is overlapping with 2 other ranges?
>=20

I debugged this problem with an AST 2000. What happens is that the
vesafb driver attaches first to the graphics device. It disables
write-combining and falls back to uncached access; unless the kernel has
been booted with video=3Dvesafb:mtrr:3. Then it will set-up WC correctly.=

The respective code is at [1].

Best regards
Thomas

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/video/fbdev/vesafb.c?h=3Dv4.20-rc2#n415

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 N=C3=BCrnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard,
Graham Norton, HRB 21284 (AG N=C3=BCrnberg)


--Rn4ndp8dEZpMy3RT5hxOPCcvAIMetoyR9--

--qe8FfTZQBr9r2XWiH4uNUyamIlp6fkMZq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlvp1iAACgkQaA3BHVML
eiN49wgAk0rSqr54QvlZ0mMLaxY/ErhD8qNw7dzYD0hUUMQu7H+4VtKD70cMzGOA
Fcsm7PqTvaLWW/aIQGDjrmws1l5KUA6ObgAM8L/0am5HM8gmuwRvxLcFNsivUV+y
RkDhYbsZatBFUeIJJBOKoTOmT5cbyTM5in2I+2I/VfY3cCs0qBB/u3I/Ttw9kywR
rxEkytSvv6Y+NKOR1kAI13LymMjZ4RD/m4RVEgc5YxvroHw6L/ciUGs54AUDs9hx
rDtcJ5zagv5UefmlxxCVb3SF6BdcNU97Fx9MOIxFVszKyi6bmOvoXpjr0yl/yNCY
bNBojj0QbPyJHznqrmCImdH9NdGkxg==
=Zfru
-----END PGP SIGNATURE-----

--qe8FfTZQBr9r2XWiH4uNUyamIlp6fkMZq--
