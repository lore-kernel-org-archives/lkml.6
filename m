Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D93C6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADDD25773
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADDD25773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932732AbeGBBcd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 21:32:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:54844 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932102AbeGBBcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 21:32:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "To"
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 80C1BAE12;
        Mon,  2 Jul 2018 01:32:30 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Linux Kernel Network Developers <netdev@vger.kernel.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>, tgraf@suug.ch,
        linux-arm-msm@vger.kernel.org
Date:   Mon, 02 Jul 2018 11:32:22 +1000
Cc:     herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: Re: [PATCH] lib: rhashtable: Correct self-assignment in rhashtable.c
In-Reply-To: <1530493906-19711-1-git-send-email-rishabhb@codeaurora.org>
References: <1530493906-19711-1-git-send-email-rishabhb@codeaurora.org>
Message-ID: <87muva2zix.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


(added netdev@vger.kernel.org)

On Sun, Jul 01 2018, Rishabh Bhatnagar wrote:

> In file lib/rhashtable.c line 777, skip variable is assigned to
> itself. The following error was observed:
>
> lib/rhashtable.c:777:41: warning: explicitly assigning value of
> variable of type 'int' to itself [-Wself-assign] error, forbidden
> warning: rhashtable.c:777
> This error was found when compiling with Clang 6.0. Change it to iter->sk=
ip.
>
> Change-Id: I5abd1ce5ba76737a73bd6eca94b07b1bd5267523
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>

Thanks for catching that!
Reviewed-by: NeilBrown <neilb@suse.com>

Thanks,
NeilBrown

> ---
>  lib/rhashtable.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index 9427b57..3109b2e 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -774,7 +774,7 @@ int rhashtable_walk_start_check(struct rhashtable_ite=
r *iter)
>  				skip++;
>  				if (list =3D=3D iter->list) {
>  					iter->p =3D p;
> -					skip =3D skip;
> +					iter->skip =3D skip;
>  					goto found;
>  				}
>  			}
> --=20
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAls5gKYACgkQOeye3VZi
gbnaaA//X6cfLjJptNvnJ/mTpbJMfKFGXjlI1apdns2tBOaRN4/BCFzFMOrP7EAZ
JzmW6Qy3eSv6ef1bDxCOhah09XaLzAIW+k51eTswAivo1TWvBL5PRFflwrExxUF8
gThb9E/mfGV519BhdxofCJYULqMynbGS3oMBKPq/obBRdMRcLImghuBadoMy6SYk
mE31qgexatD8M1JZ4VCAKkSdG+5VMGZk7ZWiDle6898pZ2/3PWWBV1K5Xz4klvpO
F2WWKoQ5VbOVQV/MIiCwoiOW+NtkhDLxtWaVY0ti8qZ/6u/KtLIVxPVIZBqETu73
sH/VDJZI/fCS69EE8M1zfxN+APEvy2RrIn3OKtZYVFGlFeH0cVzHYFFnT5nYNn31
oIpS6CkksAEqzXuSEkN6Z2/QPGx2d9DDJnjA+uj5qWFiUkoyph/Wc7InHVhxCLpV
8gAf4+WPgVPtXEqhZdazGeDV+1Mn1d/YMbEalVM4ZAjJ5GdK80WHYT8wunyta3kC
4ucBTyVEfpCYZjJVts1+8P3c3aoDSFB3gj9GsjzRiXqpM/fBDHfAtL4DwpTLY6gT
f6IsaIpb6cvlb7PrDYdMkdVE0iv7ZdVkMtxDjnMXAjogXYKiNz45XXCeupvpMgpq
t+mJPJe5Mc6XKEp9hYMlyD2f1UQ1qPiAd5WkDGtc9HNwaXNwrvg=
=M+j9
-----END PGP SIGNATURE-----
--=-=-=--
