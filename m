Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C2CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1567920663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLFo+uOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1567920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeKZWbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:31:20 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:47101 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbeKZWbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:31:19 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so6035927pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 03:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z8XzU9F0w4mpIyg4lw6AUlhlAzE+KAv9MaHONrxV38I=;
        b=gLFo+uOdS8Vido5xeuuE5MS4XJ1/V9KtV5MnQfrhhP/ohoVSuPvoGWRRMdeI3/fRGK
         LjBM7sLyqqGvde4Enfa9u6dN09J3887ARme6OBMrsCnIdITWt9+C0pBFpIXH4xDe/FeX
         XUQ3LbCxnrqmCw+yEcUOB1DsNjVLyQX9rYi3vB0Dh2EZBz7HObrY3eyWfc4dPBJvfrHN
         uSCq2HBZdk72vLLbyNXv5bgrH1OYXRbwZEeJdfRMsAKfYzoWtahWJnIwtlR3e9U8ZY2V
         qUgKJy8F6KynVjZECJWV7I4HwsZvU3AiV2Qjb9qWauhU9UjcMQRVLfJCJVmT+erBk9NQ
         yjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Z8XzU9F0w4mpIyg4lw6AUlhlAzE+KAv9MaHONrxV38I=;
        b=MoBmzTU0L+Mz8gm6NzyxZXQgtDvAN9Hso/d5p0m9fy46VQ+32UrZQNWwfCok/NGv79
         j9wyav3/YW8udBwpneQUOlhXlLGSP+F2nyVEkFrwnc0w3ifBEinjfudAQt6ZbASpbJQP
         QjtavIb7pMPdIHpaXGLYu48Bd77/WMVpoHnqIoTsCvIBwKYqwtO8KcLzlf9lZGer18OC
         3q/1xGvjkzVnMsG/X+mH/8s0rAj4pdFURzDWrGcsIlskxhRaZ3zAQEWJOTWQ6TpySayM
         Zi1kaV1FBDFFB6HQLYC0c1n0EkPEkvObBBFv4ahyvfhyID9N4DpSxS+OcFqc5JDYL7BH
         a5kQ==
X-Gm-Message-State: AGRZ1gLPITOzktm9SjOK6vGfBABChXfd8pgKnG739tBLP0D13BKwuc52
        QTYnIa6wd0Kmx/PXteIH/AY=
X-Google-Smtp-Source: AFSGD/XeARF3XKG7hOBlXOasMhjJR0fw7t1POK7FS15SRB9SPMW+j+9eS75nmp2dI56LF/9h5ybA+Q==
X-Received: by 2002:a63:2d46:: with SMTP id t67mr25019528pgt.140.1543232247359;
        Mon, 26 Nov 2018 03:37:27 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id x7sm101853pga.68.2018.11.26.03.37.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 03:37:26 -0800 (PST)
Date:   Mon, 26 Nov 2018 01:37:24 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     David CARLIER <devnexen@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        aryabinin@virtuozzo.com, Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH] Little memset_explicit optimisation
Message-ID: <20181126113724.svbv6np25fzxkhrm@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        David CARLIER <devnexen@gmail.com>, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, aryabinin@virtuozzo.com
References: <CA+XhMqyR1wMEnEE2cCnoGj2RatxTbFuNH2jOj1-50iYso67rAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ues3xolvxrd43lmw"
Content-Disposition: inline
In-Reply-To: <CA+XhMqyR1wMEnEE2cCnoGj2RatxTbFuNH2jOj1-50iYso67rAw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ues3xolvxrd43lmw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 24, 2018 at 12:35:43PM +0000, David CARLIER wrote:
> Using the return value of memset for save/load sake.
>=20
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  lib/string.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/string.c b/lib/string.c
> index 38e4ca08e757..92da04a0213b 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -720,7 +720,7 @@ EXPORT_SYMBOL(memset);
>   */
>  void memzero_explicit(void *s, size_t count)
>  {
> -       memset(s, 0, count);
> +       s =3D memset(s, 0, count);
>         barrier_data(s);
>  }
>  EXPORT_SYMBOL(memzero_explicit);

Could you elaborate on the optimization that this patch performs?

--=20
Cheers,
Joey Pabalinas

--ues3xolvxrd43lmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlv72vMACgkQ2rGdfm9D
tVJr9Q/+LUn12Ov3tI8izc5J2EKpfM11GDqdt0K5QW/z5bNhn8PDXqy8VcNjww7I
58XkpvXphDy+zBUjVs3HGtEJnMDfP85g7xA784HomWoMt/QrmiiIYzuphOoVLpb1
iw2/ExifO11otq7NDHWTeMYuiVQ4xadc/D47lP/ADzzcRo0EWy35xcVIp9U1oJgT
HwNyOq5vda/j01TEnHRd91Psh2kIHdNtpQ6f6U3t0eQ0Mx3O5ymCEfemFgWFPP0r
sD34T4lhfQ29LcK4lyabj2DpIE3+3wOb6UOTILRaHNrSJKhfmNVvqmzy9jT/ZDLF
oEl4XtaPWoYMkuRGC7GQRfR8cwdHdwUlnvypwKru8a+2tP6M3P83U6XB4lCvVGnv
q9nGwZqltwfOCuwHqdJ20OSA1wBtV/jy2YxVPVWf0w3L2UOqVUmBrMa7jhRzSh5j
+dCKg/MqyAxnzX4EWVapZN/FV8pd4jjOiAD0UWp9ZOkOLndxYLgzbGplzp6Yut+8
RG9EDI0Da3L5hcyhh0eNY4ReoQDzqAoxZzdNZRf79jj63m/jLpCTcCbs9IdYPy9E
A/xol1K/I8qp8hxzo1EVqGZFU5t/Wz3KSNaaWGmkt0/19XvPKoHDyv0z3UkEuwZb
2Vs6lNLl4gDQkweKLq5o10lHAgEW48s5n4TliECd3ZZjSLNRkyQ=
=zYWT
-----END PGP SIGNATURE-----

--ues3xolvxrd43lmw--
