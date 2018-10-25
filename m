Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC79ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C235C2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lxyio/OJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C235C2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbeJYXBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:01:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36264 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730826AbeJYXBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:01:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id a8-v6so1737467wmf.1;
        Thu, 25 Oct 2018 07:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sFwuYlr8uRAAsWKMWIB1xj5fsvWmnRuJ2L6fYYWSBN4=;
        b=Lxyio/OJ7J9ukasJ14g3TNfYri/ifXBWOV+75/GntIq8FR2rhuqI/3i9/QbxS3r1yu
         WYySgVo5H9xr6FSpg0oZScrFXbkmoRmaGnyTiKVDus0CMVxQ/yUuH+Q3eofnyhUhOTmD
         WXOfQTM8DtXoqB2gUP7sIPgLAQDtBNlb/GtiZHYDJKgCXHxxQr8Je6Z5q/Igre0dCMEW
         OE5mnkTSCFYW/hRXZt8oHLL1hMb6DdfvGRiGslWKXYijeKm51bWzqxcfI9CYSejm0ayn
         5U9li7AM7UgdoSF7pTbIoxu0sf+wM0w6c6GD8+CQk9ebOcHmEFJTcl1Qa0EkUZc6DVxO
         5BkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sFwuYlr8uRAAsWKMWIB1xj5fsvWmnRuJ2L6fYYWSBN4=;
        b=baK1amKOvVd/RUdKX84vetTi0jC7EmzMquJqoXm8M+53j4I67aZlgYs6zD58dqLhNj
         yaWn0gwUmBsG38ZyR1yHJpUlgCEF/APYL83Pib9jkGzdTxmzWUVsW18VQHPENPcki6f3
         5X115YBX/Nbklv5zKwPxmu2+sKDNfz42CuppAxRlZIaNIV1Q52eZLF8zlDoEgwTDKiWy
         dXKoIf61Zq42XTartoKfoe1jbuwiSpNyZazTeQ+EmMF5s6ad7+9S+3FgB7ao7GAheBVM
         JDTGjPjE0i4p063btZLyIqkFAVzQ0RXqKZ/dEmTjXlccW+ByglvRjpWArItBTY6fXoaW
         l2fw==
X-Gm-Message-State: AGRZ1gIDtP9pFBcZ90scZr75b4HrTEzJfndzAJHWcuyMft8F3RSAEqhm
        Asf/a+QTJQ/+7BK43MvCVRA=
X-Google-Smtp-Source: AJdET5cBD4zSdDv2+O843mTglLPMgi8129m9ud3vdeG/Q+7z1FnOuSw6qRug8k4jgCS1EJXtaKAnsg==
X-Received: by 2002:a1c:a4c1:: with SMTP id n184-v6mr2302354wme.106.1540477718133;
        Thu, 25 Oct 2018 07:28:38 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id 18-v6sm1996312wmw.26.2018.10.25.07.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 07:28:37 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:28:36 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/8] ARM: dts: tegra20: Add interrupt entry to
 External Memory Controller
Message-ID: <20181025142836.GH21521@ulmo>
References: <20181021183052.32023-1-digetx@gmail.com>
 <20181021183052.32023-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FUaywKC54iCcLzqT"
Content-Disposition: inline
In-Reply-To: <20181021183052.32023-5-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FUaywKC54iCcLzqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 21, 2018 at 09:30:48PM +0300, Dmitry Osipenko wrote:
> Add interrupt entry into the EMC DT node.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra20.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-4.21/arm/dt, thanks.

Thierry

--FUaywKC54iCcLzqT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvR0xQACgkQ3SOs138+
s6G5Dg//WJUGcgr+aeof7gWRdVQbHQw+IgKIvo5H+HZO49NfF+OyWV6XmSa2eRHr
zmtZO69EUpCOL4tpmeFRzNqx/EDdwxCjMEdxj0iWmUkIwDU+8gSQqgioUyQNNfI2
z7SskBFTu4/DHUcHj3stqu9J/ewRhV96wQauwE+5DW16OD007GEc5LC+3JBN8Tmk
2pcXSRru6lmWudAyXoD/NHlHKjnUCJ7MssrVnt1cHkmoXjIg0t5ng+O7vr0EZ1lT
R75CWQQz5kQ4k90uiDmdmSyKywLSfhIXLM7lUhZuZC+qK0Wve1UtAJ0V8REb9/ML
iMUkpGHnsEQ3MLuEzEtPZMrnUrblQnxVFR//1NO3gNJlZuALM59Xr5taAQZI8n+3
GPXIBMS/Pw4g+Lyfydpa9AGfCk9cdwNUWEiqOJ4x7MRVyOOoUUfmwW63xWS9jVbJ
rxwQvxdaS/8b98GUeF0iOOuhLA5aQYjjFycCi0+G2IQPyTkgtLJ2Ym7SodtIKvL+
/4LIyBb/colwxALgpfY/jywjETF+P2/FoaDt1v4D1O6oJIX2QwhJ+CsypJok1kAM
qdbrSOrBGBRjGa7Dbki5zZnNPJqdmGxX3Js0TsYZ8G4cWVclxCaLLIF67VCjkwot
Q+UgREFTS94ONyIDfNY/NHEJYb3OJXPMss6zXjuvLVE5OoLshUg=
=kIfE
-----END PGP SIGNATURE-----

--FUaywKC54iCcLzqT--
