Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94A3C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62862082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="S6yeTMiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62862082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeLEQd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:33:59 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38245 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbeLEQd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:33:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so13612754wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 08:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=mPUod0ysDmL+3PPQmnHsuw/tJ9C3I5rasuW6rAmWHzU=;
        b=S6yeTMiHNV3NVlYAui9o4Mta6qEU5DUICLq1Em0IeQW6HlngwpBT3ePfFsGbmKEaDy
         kg+mn3Dlgww+2fdJU8xd481JDIPQgdwufTA2vjbIyFb5A+rZfVIqaAJX+GwyzOQVpMcv
         VGlsGLe00wgtAZ23T/ZolUhPidiBS9mP3y9J1RvBBnQOrsF/i4yUOhWSdXHFbAfanclw
         GpveZeSFIEzIL2ikoInOC0/yn3G+qA9FIKljxrxBD0YLDlG7g/fUxsPV2AzwGOxnZEga
         lZbmxYNPV1i2kj2ojVgrtXgSj2SYPajXIYKIYcpsuCFnePh8cyVSTfA2DT75+YQ70Brb
         9Tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=mPUod0ysDmL+3PPQmnHsuw/tJ9C3I5rasuW6rAmWHzU=;
        b=N4j7Anqk0Iki+m+M4WkK/DJEFNpB540fb/5a3YEOAbxxtBeUY77sg5XbJn8PN5fyD9
         CfgxYC2dkXaJjUmE0+EaXxMQPVKlQRVtouINhm65pVSD5vsTJOHCM7spsegtBJFDnxrs
         yanmiQxv4eVXn/VfVtmBZZYoWgRjsLYwHrSdM+SPD89b26+mJksd5wVPzQLz/0rjMnM7
         S2NGyj2aN65i8lvRMKR44kjlPI6AL4SjMLKSJhRggb5RVOH2qXBeadmbmN0Yx70jD7mD
         PI2Cg2YvuUSQMBYesXCvqp+yKIrVTHRJx+7tCDAq9wxcuLIeHXqIM6OqrUszMrEJD2AS
         CZBw==
X-Gm-Message-State: AA+aEWYFErLSUFcevfLv52S6rsU+PFFLoUx/eWAmC2kJAu6lVpQYkIMl
        3bHw+n+2XHpn/acFKxnTKfmahsQkoJJtYQ==
X-Google-Smtp-Source: AFSGD/XEd4OKsisEaDk/ocTjGFJD5FLNwK/d6xrnJNLG9Y4wKcPsFC+8CeLAqnR1AtPjhRoxL+rpLg==
X-Received: by 2002:a1c:20cb:: with SMTP id g194mr15900053wmg.77.1544027635949;
        Wed, 05 Dec 2018 08:33:55 -0800 (PST)
Received: from [74.125.133.108] ([149.199.62.131])
        by smtp.gmail.com with ESMTPSA id h2sm13512092wrv.87.2018.12.05.08.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 08:33:55 -0800 (PST)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH 7/7] microblaze: remove the unneeded code just in case
 file copy fails
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
 <1543823457-32478-8-git-send-email-yamada.masahiro@socionext.com>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <ed259512-5c34-45cd-22ec-38d64ce5e493@monstr.eu>
Date:   Wed, 5 Dec 2018 17:33:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543823457-32478-8-git-send-email-yamada.masahiro@socionext.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VC9lh3RBMYJ2PxrENLn0X9aXZwr1h8zaG"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VC9lh3RBMYJ2PxrENLn0X9aXZwr1h8zaG
Content-Type: multipart/mixed; boundary="N41fux6WkqnwveAuf85T0cgflK5D3IJYe";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, devicetree@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org
Message-ID: <ed259512-5c34-45cd-22ec-38d64ce5e493@monstr.eu>
Subject: Re: [PATCH 7/7] microblaze: remove the unneeded code just in case
 file copy fails
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
 <1543823457-32478-8-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1543823457-32478-8-git-send-email-yamada.masahiro@socionext.com>

--N41fux6WkqnwveAuf85T0cgflK5D3IJYe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03. 12. 18 8:50, Masahiro Yamada wrote:
> I guess
>=20
>     || (rm -f $@ && echo false)
>=20
> ... should be
>=20
>     || (rm -f $@ && false)
>=20
> since printing the string "false" on the console has no point.
>=20
> Moreover, no Makefile needs to delete a target on error explicitly
> since commit 9c2af1c7377a ("kbuild: add .DELETE_ON_ERROR special
> target").
>=20
> Reuse equivalent cmd_shipped from scripts/Makefile.lib.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>=20
>  arch/microblaze/boot/dts/Makefile | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/arch/microblaze/boot/dts/Makefile b/arch/microblaze/boot/d=
ts/Makefile
> index c7324e7..ef00dd3 100644
> --- a/arch/microblaze/boot/dts/Makefile
> +++ b/arch/microblaze/boot/dts/Makefile
> @@ -12,12 +12,9 @@ $(obj)/linked_dtb.o: $(obj)/system.dtb
>  # Generate system.dtb from $(DTB).dtb
>  ifneq ($(DTB),system)
>  $(obj)/system.dtb: $(obj)/$(DTB).dtb
> -	$(call if_changed,cp)
> +	$(call if_changed,shipped)
>  endif
>  endif
> =20
> -quiet_cmd_cp =3D CP      $< $@$2
> -	cmd_cp =3D cat $< >$@$2 || (rm -f $@ && echo false)
> -
>  # Rule to build device tree blobs
>  DTC_FLAGS :=3D -p 1024
>=20

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--N41fux6WkqnwveAuf85T0cgflK5D3IJYe--

--VC9lh3RBMYJ2PxrENLn0X9aXZwr1h8zaG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlwH/e0ACgkQykllyylKDCFEFgCglgigA6xbCkCzVbb4ca3lXf3x
VGwAn3G9GGsi35LX72UIF44MX2rTBoCi
=zclB
-----END PGP SIGNATURE-----

--VC9lh3RBMYJ2PxrENLn0X9aXZwr1h8zaG--
