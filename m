Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC53C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 01:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E38206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 01:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoZ6xO0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbeLQBKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 20:10:40 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37226 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeLQBKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 20:10:39 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so5497785pfb.4;
        Sun, 16 Dec 2018 17:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kZfzqrdlmUEK7uy4IJXAZ/6CppMnpHEst4Rv/O6u1lw=;
        b=HoZ6xO0TmJkMuYWappGU74V8CCcEoWsxQR73deX2XER6R0cbTwrA2fk6/Q07XhH+Pp
         tI+KifVHFMIGxDGBcsxujSagFekNiZxjfh20maEhUOcd01qYRjJ9ZUKPjDKwqsQlIRf7
         +l4hb2toJ0fnWXZxXZTL+X7nUzKZ7NJNYcuFpHXjg/1FB91q0uculMurol/RFPl0vUGu
         T+j/RA3w3r9Ebjrd8hE+JTEGqpUNIKpTvYaI+pUH216obPcIK7ybzPdwqdnAvwGNOs1h
         azbwP6qeQyPpA9JYCn3JjDxM7jaKeWDj9h7VWXX0Ed7VNPV0xBMPWin9hrzrfcV4xoeX
         4Yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=kZfzqrdlmUEK7uy4IJXAZ/6CppMnpHEst4Rv/O6u1lw=;
        b=Fr3/EWNzefc0sceJgBrxWqWAblZZY6resXtdPNqIO744EGhNIiON+VnJv5qD4ANG9M
         9CW9YaVfaa8oa4gbvCNZL0qXXfhnzbntGdYj6Fb/VUZlzyTBL9DN7NhEy730kF5kmBLB
         6QUHOzAvOFY1K4OwMadLxroZ/i/R1WRyVrqfRjwl+MvpH72WOntYDwfDa8YufjuXN3UK
         06oMsA7beyhyVwR4pG+9x5h8FZ0r3gqbWdkjak2vm8J4aBzOR9kLGEde3WVrUtPfxHBy
         HZih1gi0ul1qp6WmfuAZIZohCbV5Ny83x/z327SAGvz4HrznTmk3R/k/9J5CBD++iEyB
         iqdg==
X-Gm-Message-State: AA+aEWY/TPDCaiXRMZNg8t3JoLwaoAJnpcIGUiOFTka3MRM3G3Lu/TeA
        put4HZmpooGGvgt7pXZ94idyV746
X-Google-Smtp-Source: AFSGD/WKG3Fdqj/fVit15eAdH4nBibu8XD5NUtrJMdG5qTbPqkfXm1FrsjW3+OZuuEnPFEDskReU7Q==
X-Received: by 2002:a62:4549:: with SMTP id s70mr10871062pfa.233.1545009038309;
        Sun, 16 Dec 2018 17:10:38 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id f62sm12162098pgc.67.2018.12.16.17.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 17:10:37 -0800 (PST)
Date:   Sun, 16 Dec 2018 15:10:35 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     longli@microsoft.com
Cc:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, stable@vger.kernel.org,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH] CIFS: use the correct length when pinning memory for
 direct I/O for write
Message-ID: <20181217011035.ykal46ixowdqyl7h@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        longli@microsoft.com, Steve French <sfrench@samba.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        stable@vger.kernel.org
References: <20181216231704.16761-1-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="idxsf4dcv7fappfg"
Content-Disposition: inline
In-Reply-To: <20181216231704.16761-1-longli@linuxonhyperv.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--idxsf4dcv7fappfg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 16, 2018 at 11:17:04PM +0000, Long Li wrote:
> From: Long Li <longli@microsoft.com>
>=20
> The current code attempts to pin memory using the largest possible wsize
> based on the currect SMB credits. This doesn't cause kernel oops but this=
 is
> not optimal as we may pin more pages then actually needed.
>=20
> Fix this by only pinning what are needed for doing this write I/O.
>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> Cc: stable@vger.kernel.org

Looks sane to me.

Reviewed-by: Joey Pabalinas <joeypabalinas@gmail.com>

> ---
>  fs/cifs/file.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 3467351..c23bf9d 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -2617,11 +2617,13 @@ cifs_write_from_iter(loff_t offset, size_t len, s=
truct iov_iter *from,
>  		if (rc)
>  			break;
> =20
> +		cur_len =3D min_t(const size_t, len, wsize);
> +
>  		if (ctx->direct_io) {
>  			ssize_t result;
> =20
>  			result =3D iov_iter_get_pages_alloc(
> -				from, &pagevec, wsize, &start);
> +				from, &pagevec, cur_len, &start);
>  			if (result < 0) {
>  				cifs_dbg(VFS,
>  					"direct_writev couldn't get user pages "
> --=20
> 2.7.4
>=20

--=20
Cheers,
Joey Pabalinas

--idxsf4dcv7fappfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlwW94oACgkQ2rGdfm9D
tVJDVw//YlX/0LsP6eZyP08m4OT21ajO8bNIkFqd+jLFVEcIlm/Nk0f+gxxcIwiJ
y+Xt6rSwl3tyypQKvIh2ba6XdgFM+Ti3O7jb/6oiE0guwLhh1WUA4iQhPgDjBPrJ
rzvsVaEB2LQpXOzPQd7zFcpvx5wJO8S13ZUpeaSUvA8LpbKQTf0Oh2u6WUOf2guo
gfMJixovSgbl2kpTiUSd8gqh5Bw51zsyLTFsnE8GFx30liXzZ5zxguMXKPu41rQa
uWfyK0A1LFzniBL9x0aDciYiL2qZZbyCY1BdKJTwqxFqX6VmHGGNlODguLdYAY6V
mp3wt2EyXbGwt1yYhhkXEwFgYuNsdYYvZOGLhElIrvMBH27QtX52sPW3pIv2+vS2
8BZpHyOTuCJ/zC9EsOkK3dyHrCdh9wSk6VDycSKrBfNCDSyNSq1FZJaujzOk6TP+
uFBO0PDpi222KzBf1LuGVlLOZlHGMbrrZZTpIyFZwLnLP4kh/c0qdJCrdXgyMMYd
biu/SBjt84+zvGIfLyXuq/5uJYUyesWaTpYWatpg1ohJ5QxIfCJb2B2YdniZ6fad
m5tB2+E4Hy2xM4NeNiMqYm0dP2KgR8fFzoOe86Aqe/A+ufGAEaMYCh/XWieozVXO
duE7ft8m5IQk/SgbvpCnhW1lYV3zm0K527wSaumYgxCYxcROs0Q=
=bRcp
-----END PGP SIGNATURE-----

--idxsf4dcv7fappfg--
