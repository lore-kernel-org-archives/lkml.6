Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996B2C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCF620834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPCZFEK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CCF620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbeLBHds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 02:33:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46929 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbeLBHds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 02:33:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so4805141pfe.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 23:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LmXHUN9fTtBcUxwdX+gog+owKJKDBH5tHSOfvHYmGN0=;
        b=HPCZFEK5qh6Tfdc7vaWIsZY/2Jyl86eWbZ5cFdN7NhoGsKhPNH/7GwjZBe0+849iE5
         FT9AZzWNwIOH1+h9wOpqKVhx6y2n+T5ESsRaVH3hEOXqsU1VAxFV8seYVqZilpUdc1rZ
         9vYKz7gogmZzQqkJBkqmfsssvoCx7xlfajuL+2VXWOevP50NRofZGTK3KgAmOE7EcMcR
         NgjDcW59jWrDEuhMKA+GO4bAWKFh/y/08NqGWXSO54reDDoxM0MSW5BN9+ZXsrbPcXyS
         yybf+S6WMx7hHmF3nYzEsJWL3ugtQUr87M3DqVayFXE7Yzh6li0nBAxj5m/7+xaaAN/1
         AeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=LmXHUN9fTtBcUxwdX+gog+owKJKDBH5tHSOfvHYmGN0=;
        b=SrbgSey96qNSCfHSvD/XF71fnLwLt0JZZV/qKi8kpsUJiYqhEX3J6jhsmyUDIhxbgJ
         A68foCaN5UUTuSTXf0ogBXVTGEgrChRupIo9jfmR935FmjD6SUPADNfR9q2TP2mcyGWN
         z2BojkPHq8CYMW/TFlFbd/zNfSrtUYAtOFxsA6BW4G2FluIECnNshUKcX7OPiIUKZo7a
         zDVZGVL/neFqKOFUInn43IBpn2C8pDI7cH2oNj2izw0i8rAkETonNnHT8pqCxA/PjYsO
         EF5e6FiOBFY3RMxfmI7AaOnWJQBE1s1OCpqjFXmU5+4IkisdV7VCtSYzks9loPZ3LekN
         LLhw==
X-Gm-Message-State: AA+aEWaur8S8bkGHOgy/vpquOKETZW/g1tcaWjKsZ1NY+AZds8+LOHoG
        qH9tdq485nmQh4ltSU8ZTCo=
X-Google-Smtp-Source: AFSGD/U7l9rIZ38Ln5ZMTyGT8pK+4RT7RSPY9G8TvPb9/syI62JkkzFzJj3jmS5Ob8WodPIHeS8MsA==
X-Received: by 2002:a63:6dc8:: with SMTP id i191mr9369375pgc.215.1543736021275;
        Sat, 01 Dec 2018 23:33:41 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id y1-v6sm13221325pfb.81.2018.12.01.23.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 23:33:40 -0800 (PST)
Date:   Sat, 1 Dec 2018 21:33:38 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH] drop silly "static inline asmlinkage" from dump_stack()
Message-ID: <20181202073338.aqkrezckv3mbqfj4@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20181124093530.GE10969@avx2>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ng2csp2vkutxwbxb"
Content-Disposition: inline
In-Reply-To: <20181124093530.GE10969@avx2>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ng2csp2vkutxwbxb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 24, 2018 at 12:35:30PM +0300, Alexey Dobriyan wrote:
> -static inline asmlinkage void dump_stack(void)
> +static inline void dump_stack(void)

Why is it "silly"? An explanation in the commit message would be useful.

> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>=20
>  include/linux/printk.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -269,7 +269,7 @@ static inline void show_regs_print_info(const char *l=
og_lvl)
>  {
>  }
> =20
> -static inline asmlinkage void dump_stack(void)
> +static inline void dump_stack(void)
>  {
>  }
> =20

--=20
Cheers,
Joey Pabalinas

--ng2csp2vkutxwbxb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlwDitEACgkQ2rGdfm9D
tVLYEhAAqYIGJrc0WtVrgcSfh4NVtFXrzBNmVLqdwZSgdu1oCBuoexibTl3SBrls
d7xWynvA/IERBG+q2s8yaRURpii9bxixZUCc2cQUe9GXRxfjXAwR77gU1DXCuRdZ
fWzCT1XKxDulemrqhSK6GFz1doT84V/D7xP4qTZCsDYdxCWNlwMcQIST37I5AHBY
9n37sCjrNhvEcZC+bO0MtX7qcVNrFNsY/Y/VJWeb5Dc347evmUuXuCjR4VS+syY8
6KyKXfGLJW7k06Bg3stI+kq2hNzPl8fbnKNKbU5rev6UCqN++2FX5GFifQqxRpKq
+wk/sGvzKhgwc3ulrQTDL7/A56P9rU7FG2dpOlbc98GKbqWO0cIBEoRC9L5D3YuI
Nqf/AfYgeis+QH3Mw+jyLA4118Ms2z5nIKHrgsL3TTKaaVQRurPp9clL2j1LsvFl
T0NGVWniwfOUkvlndP/9G4/wqJhanmhy0R1ZI5AIAHyzwG+0BfLPHfOAkLaLkz25
1DhAZ/wj2Vvh80N1ToB9I5d8Jz+0v5xglQHy+Sen+5ynMu6ah3DM7iSXxIFH603o
DdcJx/EnGF84HFz5oAM6Afl7KyVxv6ZgHXqu9HXyRISQ/xCmi4iLfcs3ZBtJ4Dwn
wNEHJNu2dC4umrd5c+pGKNc9N3j6C0/ZsrCGDW+Lb9ZPfsSXcOQ=
=rzch
-----END PGP SIGNATURE-----

--ng2csp2vkutxwbxb--
