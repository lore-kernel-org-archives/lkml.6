Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67FFC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920272098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHhLWAJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920272098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbeJEAXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:23:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43782 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeJEAXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:23:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id n1-v6so10799042wrt.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 10:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mzZNxrKQYUQeQrKRjlQ57+3fie8JMNr/wBQY0xR6vyY=;
        b=YHhLWAJc8y+xRFaiLcIzB70o62JM0US5Kw5ek9j365+rG+fMclBxKHottEFyIIC7Sy
         coxMPrCfEsGG+HNvrNL2r5VbtzQGjZUF+z/b6hY7PrxcFMv6WRgOeQAi/4/F6F/t9Oot
         ty7kGl17KTI4gqiPUBVge2LbJD8iuTn7QupLOLxWWHTa0BpVr8M2ZR/y5FE/k7vDStzm
         wGMc/gG8Xmq4mMZ4sgGZp7b7p+AfiI5E9c/6qDkTzzJq++hxbStLlmDl2WEIKqbXEnkD
         9873/dm5B2eaeJVrn7b2k0DxXKtWFPeGVk89AF66l0fo87AZur5mbqitbA+5CqyFarXy
         N/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mzZNxrKQYUQeQrKRjlQ57+3fie8JMNr/wBQY0xR6vyY=;
        b=MFMAlvL01GZqku5eFsAIHQnjxcUG9HL5aktc1w3z1XOKufzrmmpqO1NDs7ihzo682y
         xgzXHtN0QnFRuXBtG2XScCpQhaGPOkvUdjykHTxoIQ3gMPJum80BEYFY3uMkLrtKm7kp
         OhGR3rVI+eiSQ1TTN7T6bR3uYegopZVHFJvRa9UHFhREM7/9wsoclgMpFcf1djw6qk3l
         ObbOB9G6qCqN3TZKixfrz2WPUZd0tt5eoB6McdbWrtFq4AxACXO/yfKBv4M/A5zDvPxj
         S/3hhMbTgHqJqTubBVTzKX5H3Mri5Ipvmje2ATgZcRQSR3a5LaV9bTvUXNTYODu9U4PH
         KbyQ==
X-Gm-Message-State: ABuFfojev6DJDEzlSWQABbg5phB1F2iATGq4v5FTnTGuYWerGO5K/2WB
        wzrda2L5/lRu/wIhZlcc7sk=
X-Google-Smtp-Source: ACcGV60ma4LFCqUhrTM8yAGfl24FnSzPFaiJBi2z3lNMZ13Rzj+ARKSvEVHcZM90g9FVEhafRcgidw==
X-Received: by 2002:adf:f5c6:: with SMTP id k6-v6mr5655962wrp.59.1538674156896;
        Thu, 04 Oct 2018 10:29:16 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id t24-v6sm8953038wra.5.2018.10.04.10.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 10:29:16 -0700 (PDT)
Date:   Thu, 4 Oct 2018 19:29:15 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     chenchacha <chen.chenchacha@foxmail.com>
Cc:     hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH 2/2] Add a new function to get root directory with
 ATTR_VOLUME
Message-ID: <20181004172915.z7zm5jqcb4vtq6py@pali>
References: <20181004172101.15525-1-chen.chenchacha@foxmail.com>
 <20181004172101.15525-3-chen.chenchacha@foxmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="huzgpv5ftqvu367l"
Content-Disposition: inline
In-Reply-To: <20181004172101.15525-3-chen.chenchacha@foxmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huzgpv5ftqvu367l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 05 October 2018 01:21:01 chenchacha wrote:
> Signed-off-by: chenchacha <chen.chenchacha@foxmail.com>
> ---
>  fs/fat/dir.c | 13 +++++++++++++
>  fs/fat/fat.h |  2 ++
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index 7f5f3699fc6c..4fdcc1200f2b 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -881,6 +881,19 @@ static int fat_get_short_entry(struct inode *dir, lo=
ff_t *pos,
>  	return -ENOENT;
>  }
> =20
> +int fat_get_root_entry(struct inode *dir, struct buffer_head **bh,
> +		       struct msdos_dir_entry **de)

fat_get_root_volume_entry would be better name. It does not return root
entry, but volume label entry.

> +{
> +	loff_t offset =3D 0;
> +
> +	*de =3D NULL;
> +	while (fat_get_entry(dir, &offset, bh, de) >=3D 0) {
> +		if (!IS_FREE((*de)->name) && (*de)->attr & ATTR_VOLUME)

You should check that cluster number is zero. As e.g. first entry with
ATTR_VOLUME can be also LFN entry and not real volume label. So you
should properly check mask and filter out also LFN entries which have
ATTR_VOLUME flag set too.

> +			return 0;
> +	}
> +	return -ENOENT;
> +}
> +
>  /*
>   * The ".." entry can not provide the "struct fat_slot_info" information
>   * for inode, nor a usable i_pos. So, this function provides some inform=
ation
> diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> index be012de96f65..4195cb1e891a 100644
> --- a/fs/fat/fat.h
> +++ b/fs/fat/fat.h
> @@ -302,6 +302,8 @@ extern int fat_scan(struct inode *dir, const unsigned=
 char *name,
>  		    struct fat_slot_info *sinfo);
>  extern int fat_scan_logstart(struct inode *dir, int i_logstart,
>  			     struct fat_slot_info *sinfo);
> +extern int fat_get_root_entry(struct inode *dir, struct buffer_head **bh,
> +			      struct msdos_dir_entry **de);
>  extern int fat_get_dotdot_entry(struct inode *dir, struct buffer_head **=
bh,
>  				struct msdos_dir_entry **de);
>  extern int fat_alloc_new_dir(struct inode *dir, struct timespec64 *ts);
> --=20
> 2.19.0
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--huzgpv5ftqvu367l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCW7ZN5wAKCRCL8Mk9A+RD
UhJ+AJ4lQLZRDdSLvQNSmtGDWfVsFaZpewCgjS285DTLhMAI6vNVm0i8LdcN3Q0=
=Ns14
-----END PGP SIGNATURE-----

--huzgpv5ftqvu367l--
