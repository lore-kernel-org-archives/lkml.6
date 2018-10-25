Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E763DECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0922083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hes2lybs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0922083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbeJYXEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:04:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40275 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeJYXED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:04:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id b203-v6so1750932wme.5;
        Thu, 25 Oct 2018 07:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lFLpehC3n+3CaT2liZ/Zga9em4kHxo5L6vj0o4AsfsQ=;
        b=hes2lybslkNVqr+IXHNkw8Ek0bfvW+hxsXeJHOp2rMIhb7L8RzWv5SYiE/xIyrXl0Y
         fmtiNtyO1hSkH+WXShOF9vZASde30+fumzID/Z6WGCpCKgdHhtKMlT6EXYnJtxMuYAN5
         EC/idy5o4lfCyvS7l1S0UZiPbcEopDSr3rfddHB9wi0gHNl8UH2+VPNf0sulza3MXVOv
         u0f87k1QzRbEXvGl6OxcndCqhhu3UaLDkdWgLm9PEBKkRsqH3gBTn/cQQnR3fMfR0xP7
         X4tJ7KGljlxIi5uUrotk5OrTjPrEwpJXUIUNCAvdZPu8aq0C/glSAA8YfKlS92+Eh7mL
         X+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lFLpehC3n+3CaT2liZ/Zga9em4kHxo5L6vj0o4AsfsQ=;
        b=MLo2kDAABelLCa7QXMvV4HTJUKvoRvMHjEA3jEI4+LqavYkf13sO6J7hHDp2iaISs2
         tkXSBtF+7sRQPeZH9z6UbM7R51mjDoQOaqSer7eh9HTRl+t6xPYCxHjBtuQELDV4ar8i
         GKB1N/K1L6kRq+4seau+npI9gfP8Trg30pyUv0CPaetqVEy82sDjovkyicsNcqwuDFp/
         b9bgWYMjEZ2wxM0uMlrqhnkLIpgVkuoTofGHnOxFxTTwvM5clsu8R+MYEmuH8TpFTipa
         jt0GGkFFeGfAgNogmsnzk0Ue6QCcRplDZEgf6cv0v8ukIho+Sb45R/+pr/dz2GlQMCk8
         wyvw==
X-Gm-Message-State: AGRZ1gKbR8UaUIq0PMUdzkWl0nQflVNLJQr4wVAdJ95lmqasCa2hnG4R
        PL2tLaxFsNhVpMR3h8JvbNM=
X-Google-Smtp-Source: AJdET5flLNEcFBCI2MgUNJfMujfFIzlFyUWtBk0DKU+1Xg6z/6T1q00tEpj9j092WbGCwzMs2wAT4Q==
X-Received: by 2002:a1c:1c0c:: with SMTP id c12-v6mr2084223wmc.18.1540477860216;
        Thu, 25 Oct 2018 07:31:00 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id m16-v6sm1904813wmd.35.2018.10.25.07.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 07:30:59 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:30:58 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/8] clk: tegra20: Turn EMC clock gate into divider
Message-ID: <20181025143058.GJ21521@ulmo>
References: <20181021183052.32023-1-digetx@gmail.com>
 <20181021183052.32023-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KjX7LgAomYr70Ka9"
Content-Disposition: inline
In-Reply-To: <20181021183052.32023-7-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KjX7LgAomYr70Ka9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 21, 2018 at 09:30:50PM +0300, Dmitry Osipenko wrote:
> Kernel should never gate the EMC clock as it causes immediate lockup, so
> removing clk-gate functionality doesn't affect anything. Turning EMC clk
> gate into divider allows to implement glitch-less EMC scaling, avoiding
> reparenting to a backup clock.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/tegra/clk-tegra20.c | 36 ++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 10 deletions(-)

Applied to for-4.21/clk, thanks.

Thierry

--KjX7LgAomYr70Ka9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvR06IACgkQ3SOs138+
s6Hduw/+KPDbRWcItPpfx2++bu7qjw3SiY5WGVhUWskHLChqi8McqinAdCJKyNnF
xmVLc4St8pDZlJ46ygQA0nhgRmhP/rYhu2hI8n364/gIfUHXKG7FnSv9dqYRb+8T
NTAnn32YvtW0A0murNKx/ajmE5ZKyEN7mCOMwDaP7o7DJ/R5x2YyldUossHh2KCV
5tAGQ1AoNMlu1J7gpiMTwxJmdRNIHTjFuqDpZt8y/J/TFLvpq5gTnbYDr0DCn8Nf
c4cKZ/FV26dcvL0Y4pxyfsda/JgOesi9spF4XYOeKRCSiJkbrPrcgVVnCFzi5LxL
XQDit677vdaJIBKp64h+Uc0IR+qsUE3Zww4LRfcPZi5AsANYZtWqF0CWHveDZrj1
A+IW6XUzzTDTROfSzTzbUN3k/TpSQIAgdQrKv4J4Bc+J1fURMKiV5uMpy2atDIoK
T1R8VQoenDFQ7mwm8wu3/AQ7cSAn11foINt51irSNu8IWT46wlJHqctNez/AMI+G
9zMQULVbVty6Pm8bQ5KE7TWrpxUrd7zzaF+1oJ/r1OtMjrZgIcmTrl4hhP9ytnzi
k7xh3hd/eehxYYjP2hWKrrdJkua+JP0swXIgd4MmnKbsDrta4KnZIscluo2xZam3
u1ee2NvDAG5kCF9nObr5Cnni2nmxC+Uz/67yDGwdo2MWdUM526Q=
=Q3jp
-----END PGP SIGNATURE-----

--KjX7LgAomYr70Ka9--
