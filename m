Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CCEC67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2042421477
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="UO3un6/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2042421477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeJSJwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 05:52:46 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34695 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeJSJwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 05:52:46 -0400
Received: by mail-it1-f194.google.com with SMTP id l127-v6so3237883ith.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 18:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=04yYcczJGWOxUeqkqZMGXaTzqPH3hUuIyTEa+k4afiI=;
        b=UO3un6/OYgxC8jksgVrQ8xveDS7xYAjj23OShBJw3ngYEDQ8V2MNL3EkryhsS2LD2c
         U5gjVhzr8cl+pCkdn2d7gQfBG4rOzjarzOb/afr5rnaqRqFjQy8QIRI3Xoqxg9ATgZhE
         aeuUG7DGdV1IhG2/zH3RMBgoWf6KO6+v8tIWvtYG4iZWRgrjKitgNs9pseHRhrAJX8HN
         mHpdUdRJqQtu6+fIQLhT/mc3mUJmifDvWBNhOJ75hE4i1UkdgQ1NGSfMZZojAHA6ZoRE
         gym4iKZA2VufgcPabItaEuAabhv7Lqb1vjvEBce9dmX71JubrBhTo/kLX6zKwwy1qb6k
         ZQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=04yYcczJGWOxUeqkqZMGXaTzqPH3hUuIyTEa+k4afiI=;
        b=AWRvaAJLm8hQA93HADAxVfbD/uDJ59kCEtwnfwyM0NdahvrZHggH6/td/15ciAkJLO
         Ktny73UdlRVtYR43zlQGn7PBgN03Emqu4rwpwXwnAlZ7FNmQpyyFNY7e1/+0OJQ/ZRKs
         D+af+dTCWikaaOj2Q+fa7Equ1N0fQmtwPTo+BweDczbN0XsmpYn490ILHpL0PCI17a8+
         Ri/ncLcBDxXgCMnOVyjQTkV3bMcWE+xZ1UMV/Gb784DpeGxZ3jb8xfdbYmwNKrm/KECP
         QZaWRz1jNiFdMCqk8FwHaNIn7JIDwOZVtEWNVjmbSCyxBFdR4r0JK7dSH9sJVQVt+l6O
         lRcQ==
X-Gm-Message-State: ABuFfohiuQ920vOJK9Pro/shvV4dHEj470Ikf3rq9lu/lRPT3bt4UvAy
        9dHSNGI1KN1ZtDDyd4PNy7hD9g==
X-Google-Smtp-Source: ACcGV62VTCADifv1qDEyzZFSrz8QdVKsYB98MDatR0uy/qL9dalFGis5B45I+hxTd3sdtLlOpK7fig==
X-Received: by 2002:a24:b250:: with SMTP id h16-v6mr2027346iti.6.1539913734673;
        Thu, 18 Oct 2018 18:48:54 -0700 (PDT)
Received: from cabot.adilger.ext (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id z19-v6sm6241722ioi.4.2018.10.18.18.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 18:48:54 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <73E53F58-4A7C-4561-9914-2927B40AC42D@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_04301E5E-5050-44E0-9024-0BAD36DEC7C5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 3/3] statx: add STATX_ATTRIBUTES flag
Date:   Thu, 18 Oct 2018 19:48:51 -0600
In-Reply-To: <20181018131125.6303-3-mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
References: <20181018131125.6303-1-mszeredi@redhat.com>
 <20181018131125.6303-3-mszeredi@redhat.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_04301E5E-5050-44E0-9024-0BAD36DEC7C5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Oct 18, 2018, at 7:11 AM, Miklos Szeredi <mszeredi@redhat.com> wrote:
>=20
> FUSE will want to know if stx_attributes is interesting or not, =
because
> there's a non-zero cost of retreiving it.
>=20
> This is more of a "want" flag, since stx_attributes_mask already =
indicates
> whether we "got" stx_attributes or not.  So for now we can just deal =
with
> this flag in the generic code.
>=20
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/stat.c                       | 3 +++
> include/uapi/linux/stat.h       | 1 +
> samples/statx/test-statx.c      | 2 +-
> tools/include/uapi/linux/stat.h | 1 +
> 4 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/stat.c b/fs/stat.c
> index 8d297a279991..6bf86d57e2e3 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -535,6 +535,9 @@ cp_statx(const struct kstat *stat, struct statx =
__user *buffer)
> 	tmp.stx_size =3D stat->size;
> 	tmp.stx_blocks =3D stat->blocks;
> 	tmp.stx_attributes_mask =3D stat->attributes_mask;
> +	/* Having anything in attributes_mask means attributes are =
valid. */
> +	if (tmp.stx_attributes_mask)
> +		tmp.stx_mask |=3D STATX_ATTRIBUTES;
> 	tmp.stx_atime.tv_sec =3D stat->atime.tv_sec;
> 	tmp.stx_atime.tv_nsec =3D stat->atime.tv_nsec;
> 	tmp.stx_btime.tv_sec =3D stat->btime.tv_sec;
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 370f09d92fa6..aef0aba5dfe7 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -148,6 +148,7 @@ struct statx {
> #define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks =
*/
> #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the =
normal stat struct */
> #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
> +#define STATX_ATTRIBUTES	0x00001000U	/* Want/got =
stx_attributes */
>=20
> #define STATX__RESERVED		0x80000000U	/* Reserved for =
future struct statx expansion */
>=20
> diff --git a/samples/statx/test-statx.c b/samples/statx/test-statx.c
> index e354048dea3c..deef9a68ff68 100644
> --- a/samples/statx/test-statx.c
> +++ b/samples/statx/test-statx.c
> @@ -211,7 +211,7 @@ int main(int argc, char **argv)
> 	struct statx stx;
> 	int ret, raw =3D 0, atflag =3D AT_SYMLINK_NOFOLLOW;
>=20
> -	unsigned int mask =3D STATX_BASIC_STATS | STATX_BTIME;
> +	unsigned int mask =3D STATX_BASIC_STATS | STATX_BTIME | =
STATX_ATTRIBUTES;
>=20
> 	for (argv++; *argv; argv++) {
> 		if (strcmp(*argv, "-F") =3D=3D 0) {
> diff --git a/tools/include/uapi/linux/stat.h =
b/tools/include/uapi/linux/stat.h
> index 370f09d92fa6..aef0aba5dfe7 100644
> --- a/tools/include/uapi/linux/stat.h
> +++ b/tools/include/uapi/linux/stat.h
> @@ -148,6 +148,7 @@ struct statx {
> #define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks =
*/
> #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the =
normal stat struct */
> #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
> +#define STATX_ATTRIBUTES	0x00001000U	/* Want/got =
stx_attributes */
>=20
> #define STATX__RESERVED		0x80000000U	/* Reserved for =
future struct statx expansion */
>=20
> --
> 2.14.3
>=20


Cheers, Andreas






--Apple-Mail=_04301E5E-5050-44E0-9024-0BAD36DEC7C5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlvJOAMACgkQcqXauRfM
H+CGEA//dRmcs6WP6YXW/fyi8nTtTvN6SjwvM86nYXjJP3botYXUp2WsWHOuBLhd
NyBuP/kPIc4F24A8ld2M3GyZ/qUpxrBldkRyDEpCeWMRlQiUhNTfKRGVG4Eqe2Vt
mrHCFnDbPjpfnaSz73HJlYDyVOkMWHFJo8fxeB6jbsz2tUCtWn3v0qquqckKn4EY
PjQZXorihHxkpqcdXQS9NxosOXBA01g9uIdJJ1FYtnooJQqZEa1dS40KB3o8gx6c
Z0Y4MRpkUfospRRqChUd080/emmQ284KQAHyOGm0LItXF8hi9CIXaPprtImFsZid
buaaBx447dB59izkj11FVfqk8PJx+ww939kY51TtHjx2gVSIcz9O+5gCGyxlssXI
cR7rEjqCjsc85aJ00v9vFRxXbSZg3rNyPeersnm02Sp+FQLHOw7gIv33TCTCUMqS
y1AR2IBAYmSxX/mgj5P+a86KyA8tmy7FkjTL6StlciXLgEqtADKmWes8ySb+PUFo
UtKiQDgqoFBrynWsSWNKHgX7R7pdqLtxyDf7itM7XIUrKXuQb6R0zuKI2TifXSbT
sUsMUTpPLHYDbi7+H5UfwPu4zHUquS9+bRX8EFzU2TqWbVloQIEsm+FNzTpbzX6j
cmX7RwO8gBM1RVVmkgfhewwdUH6z1THpE/kpg6D4yPpVOjfNs34=
=Scy1
-----END PGP SIGNATURE-----

--Apple-Mail=_04301E5E-5050-44E0-9024-0BAD36DEC7C5--
