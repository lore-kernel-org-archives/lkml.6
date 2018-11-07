Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6877CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DA720827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="z0DPdIVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DA720827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbeKGXpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:45:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54079 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbeKGXpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:45:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id f10-v6so2047230wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 06:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=rcGW0Ysn9e5V0G4NiqHphZuYgEZdHTzt5Ngk6ikjAiU=;
        b=z0DPdIVp+2cKLJ5IG/i2EY5ihbTUuhi/TlP6fpTUXdvMU1nDpTUYYozIHuggSUa41K
         +68J7W4Z3HdrqUJ998DjwLdm0rTl4xGNV2VOlX2DobQfnZwkDdGqw5wXsRxxSYe6ATw5
         RNz+1N1hTe26HLbvDzxtxhLzGyGTuuE4emFcgPlTj1Qpbm4+2bmfvUPH5HbBpoCJrIqw
         GgN05bb/wfMFAKvkzNF8FiAqeCmWyAaPWdhMJPfoXrCPORpagIZSx7z8x0nNiZDi0Aah
         PzCozEA4pFsmQ/TvGrccKsTDP5xT6iQUYeSY8NQMUsDCxHGl/Q+ZxEA57JT4xS3NRhaY
         MMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=rcGW0Ysn9e5V0G4NiqHphZuYgEZdHTzt5Ngk6ikjAiU=;
        b=IrdRRP//ZbMKG9sFDeZ+onbLHSFOowDPX/4Q/81jNeWiWD7fVOgfojfGB8tOyfQ8Cl
         ElgLCm8zk6l+O01/KWS1I+CQ2q5qqD9PEg5Acw1WXjpUO5LTKx/eFqVBcpv0+OIZJEJ8
         wgrVz0tcf4EYkF2iug+No1iX2ug7DmB7pO5OK0CnG25bGJyKLTW8l5gxCJ9NhI8ONkSy
         fXWQA7ImG+xXvMtG9LC2eX/b3npgJSBj65Pw8UKRnPMgHz9cf4/U0qmFb0jcs6oEQH4J
         UU2u+DTJ27/A7yu2NYnWzG4MmosLY5uV2f1BVU610GF7lzjLlsK64iCHmgspjtjZPf53
         RoTA==
X-Gm-Message-State: AGRZ1gLnUPSIJu6o91CJGYtJIDXB2lR9UDMWctDUHGFkzcluuk8zPLiB
        WbdWHzGel94q8eoV6CVgtd+WEVmWW94RcA==
X-Google-Smtp-Source: AJdET5dib0MyFepkPiXtnp8vs56dogDSqv/kteT9SZa/toddwowV4PXvuSA8gYT462BZ2gRofgCqsA==
X-Received: by 2002:a1c:f514:: with SMTP id t20-v6mr317814wmh.129.1541600102226;
        Wed, 07 Nov 2018 06:15:02 -0800 (PST)
Received: from [74.125.133.108] ([149.199.62.130])
        by smtp.gmail.com with ESMTPSA id z7-v6sm1128719wrv.21.2018.11.07.06.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 06:15:01 -0800 (PST)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH trivial] microblaze: Typo s/use use/use/
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20181107134753.14327-1-geert+renesas@glider.be>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <f06f8c7b-9f32-43d7-4493-50fe940ecf75@monstr.eu>
Date:   Wed, 7 Nov 2018 15:14:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181107134753.14327-1-geert+renesas@glider.be>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GqnFRloksOZPccFYbl9Ny0bbsZ9NWMk3h"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GqnFRloksOZPccFYbl9Ny0bbsZ9NWMk3h
Content-Type: multipart/mixed; boundary="GJ2Ug7Vj10rtm6NqgcFXnHPRHspxEvGne";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Jiri Kosina <trivial@kernel.org>
Cc: linux-kernel@vger.kernel.org
Message-ID: <f06f8c7b-9f32-43d7-4493-50fe940ecf75@monstr.eu>
Subject: Re: [PATCH trivial] microblaze: Typo s/use use/use/
References: <20181107134753.14327-1-geert+renesas@glider.be>
In-Reply-To: <20181107134753.14327-1-geert+renesas@glider.be>

--GJ2Ug7Vj10rtm6NqgcFXnHPRHspxEvGne
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07. 11. 18 14:47, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/microblaze/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/in=
clude/asm/pgtable.h
> index f64ebb9c9a413535..bdfb2b3182b04c3b 100644
> --- a/arch/microblaze/include/asm/pgtable.h
> +++ b/arch/microblaze/include/asm/pgtable.h
> @@ -200,7 +200,7 @@ static inline pte_t pte_mkspecial(pte_t pte)	{ retu=
rn pte; }
>   * is cleared in the TLB miss handler before the TLB entry is loaded.
>   * - All other bits of the PTE are loaded into TLBLO without
>   *  * modification, leaving us only the bits 20, 21, 24, 25, 26, 30 fo=
r
> - * software PTE bits.  We actually use use bits 21, 24, 25, and
> + * software PTE bits.  We actually use bits 21, 24, 25, and
>   * 30 respectively for the software bits: ACCESSED, DIRTY, RW, and
>   * PRESENT.
>   */
>=20

Applied.
Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--GJ2Ug7Vj10rtm6NqgcFXnHPRHspxEvGne--

--GqnFRloksOZPccFYbl9Ny0bbsZ9NWMk3h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlvi82AACgkQykllyylKDCFWowCgjIj4F25Vglo1DXUi41Je7sYh
FmsAniC9E+erqDIV5ZA+xSxKj8GcPJDs
=FU9n
-----END PGP SIGNATURE-----

--GqnFRloksOZPccFYbl9Ny0bbsZ9NWMk3h--
