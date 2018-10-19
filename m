Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA577ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 22:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58ED620658
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 22:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58ED620658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeJTGHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 02:07:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:48516 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726604AbeJTGHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 02:07:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67C7CAFDA;
        Fri, 19 Oct 2018 21:59:57 +0000 (UTC)
Subject: Re: [PATCH] reiserfs: remove workaround code for GCC 3.x
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        reiserfs-devel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1535337230-13222-1-git-send-email-yamada.masahiro@socionext.com>
From:   Jeff Mahoney <jeffm@suse.com>
Message-ID: <c5b98062-9646-a1ba-12df-2b1e3dbebe5b@suse.com>
Date:   Fri, 19 Oct 2018 17:59:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:63.0)
 Gecko/20100101 Thunderbird/63.0a1
MIME-Version: 1.0
In-Reply-To: <1535337230-13222-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lb7navskWOuaBitd5eWXyL2iYCNBMedzw"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lb7navskWOuaBitd5eWXyL2iYCNBMedzw
Content-Type: multipart/mixed; boundary="kKRYqH4TJvOSvFJMguNRLdlj2tthsOgXq";
 protected-headers="v1"
From: Jeff Mahoney <jeffm@suse.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 reiserfs-devel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <c5b98062-9646-a1ba-12df-2b1e3dbebe5b@suse.com>
Subject: Re: [PATCH] reiserfs: remove workaround code for GCC 3.x
References: <1535337230-13222-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1535337230-13222-1-git-send-email-yamada.masahiro@socionext.com>

--kKRYqH4TJvOSvFJMguNRLdlj2tthsOgXq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/26/18 10:33 PM, Masahiro Yamada wrote:
> Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
> bumped the minimum GCC version to 4.6 for all architectures.
>=20
> The workaround code in fs/reiserfs/Makefile is obsolete now.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Jeff Mahoney <jeffm@suse.com>

Thanks,

-Jeff

> ---
>=20
>  fs/reiserfs/Makefile | 9 ---------
>  1 file changed, 9 deletions(-)
>=20
> diff --git a/fs/reiserfs/Makefile b/fs/reiserfs/Makefile
> index a39a562..bd29c58 100644
> --- a/fs/reiserfs/Makefile
> +++ b/fs/reiserfs/Makefile
> @@ -26,14 +26,5 @@ ifeq ($(CONFIG_REISERFS_FS_POSIX_ACL),y)
>  reiserfs-objs +=3D xattr_acl.o
>  endif
> =20
> -# gcc -O2 (the kernel default)  is overaggressive on ppc32 when many i=
nline
> -# functions are used.  This causes the compiler to advance the stack
> -# pointer out of the available stack space, corrupting kernel space,
> -# and causing a panic. Since this behavior only affects ppc32, this if=
eq
> -# will work around it. If any other architecture displays this behavio=
r,
> -# add it here.
> -ccflags-$(CONFIG_PPC32) :=3D $(call cc-ifversion, -lt, 0400, -O1)
> -
>  TAGS:
>  	etags *.c
> -
>=20

--=20
Jeff Mahoney
SUSE Labs



--kKRYqH4TJvOSvFJMguNRLdlj2tthsOgXq--

--lb7navskWOuaBitd5eWXyL2iYCNBMedzw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE8wzgbmZ74SnKPwtDHntLYyF55bIFAlvKU9kACgkQHntLYyF5
5bJ6Og/8DeqevT05j6HyWeux/L1Cje0Smqxt9JOitTBvsivl0KwHvfem2WEyXQct
RJgAMC0Ei7w+zbKPhcSJL3K0tu+dILlPESUSkhbzcOuEAkZtxG8jV3ruhAj8psKn
uQOk0n7qoFpeVrroWrhs2OE6NtL6VSFAlk0mTNiUT5y58MzHMGdXr/HS6+OJTv0s
xzuj28Sgkxvju5lkMS7gZ/v07vdJAiYnPA/PcCT2hGhVQG0pHGd88hS04tGVzaUd
+n17pxbofTq/0J1nBFK+LvFefCdg5/shFFXMVDMPNpjixSNE2bv+MgtkW9P24/HP
lE6tX3KJMxoWYm06k41NPWOx458JaaLhtdUkCXG6ojreKsMOG11i+pLP2WmvQLLb
xgqxRF9jV09frVNLVd+jzEWi2yzaZewEgtPRrnPPh+Q9bMzbQgF2YyQw8tGmSE0y
QrCxZaMPNttJDGdllE46s6pE+b7IBi4HQV58pZQyvqFoda1UcDJ3zzre2xs37JGH
k/QY26TP4X8JJP/cqTHYqb970azVD/b+dsmpKLsNo7bnyr2VxTD07xM9ipG5yYqY
BZxP36i9LTebM0H15QpVvsjAMI74HH2FHfKZ/0K72CjkPcfSdOK7xncfM4oTDCMK
gX/Iqqu7SiUeS461fwhEqWswfJXMSsCeh1DwEU0Ojrwr7SKpH5o=
=TEuL
-----END PGP SIGNATURE-----

--lb7navskWOuaBitd5eWXyL2iYCNBMedzw--
