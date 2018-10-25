Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D0CECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3572064A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuuu2T6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3572064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbeJYXMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:12:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36816 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbeJYXMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:12:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so9606657wrw.3;
        Thu, 25 Oct 2018 07:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CwFYLpD4ZdgGZVodmV/3QyFm5igm/tenshwbmbbjWmU=;
        b=cuuu2T6eyzLp7qiPxc5ZCTRBKgxwiZoGqh8hHxCVebhZONndlw+gLYsmZYexCJCyXY
         iVW/U+XKH+g3AtGKxYlL8VRF/KRW34MuKPbXAsmSYsyMsIu1RFGLHEYx4IQizDOsr27G
         u8bevJZbckNbunC9VqsTU/HuHCF2ayeHR64e84pxd7wlrb4fb1phPhlSIZW4CZ+uO1KU
         1XChWV60eC1ltiPA+rMwQCkot/LmGv/CIz1Jr/aF4KKVUM+D8Cht145K5sPX1NiMDWGj
         /T7pklWscNgsXaBD+pKjN+26owLQZd4UF9uHvtq+SHM1tfDDTgp8bbCBZLW1DK2pvTad
         mLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CwFYLpD4ZdgGZVodmV/3QyFm5igm/tenshwbmbbjWmU=;
        b=P/sOrXWocz6tX9t4uMwzn0klluzsSRjx7YA8Sw30DSz5s7EqKl6UkIxwqUJq3JJVj7
         vAoJINCujDBA4X42FybfJjox6jc3Z6XkBs3ClvqOxlA3q72iF3/ePXSnDdg65rHqZLTe
         Kb3OzAMe543mURs8xQ7TxKWwD3JhtTelLWPQ7ntozkkaefe1RKreZsCKTe0V4Gkm2ijZ
         3NK7WDlQ7eaaufV/4JGykqKjKjp8MupZOAEGz6M+XwtgvzoMHBBjLQQXrOoSi22FLHck
         nDANpmtWaOqOXlIBevxPK3zpKPONon3MuFNdQN6uopFoy1XpNl3bLv/nRDo+ESBqIsHV
         b77g==
X-Gm-Message-State: AGRZ1gIS7DES/r2efzHZTtJyrxp/x/Y0w4H/A5KP15mVr/SDwmTkioLE
        b1P8Xa3xHta9DWAtI+UA1dI=
X-Google-Smtp-Source: AJdET5cc3DegfFzdR5+Bw9WBXgaYxIlIj5REkNN5baW3v09wCBlQ+6m76Olfx9vG/SQC9XJnxD6phw==
X-Received: by 2002:adf:84c1:: with SMTP id 59-v6mr2380327wrg.144.1540478336317;
        Thu, 25 Oct 2018 07:38:56 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id x197-v6sm2226410wme.15.2018.10.25.07.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 07:38:55 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:38:53 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 8/8] memory: tegra: Introduce Tegra20 EMC driver
Message-ID: <20181025143853.GL21521@ulmo>
References: <20181021183052.32023-1-digetx@gmail.com>
 <20181021183052.32023-9-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GeDkoc8jIzHasOdk"
Content-Disposition: inline
In-Reply-To: <20181021183052.32023-9-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GeDkoc8jIzHasOdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 21, 2018 at 09:30:52PM +0300, Dmitry Osipenko wrote:
> Introduce driver for the External Memory Controller (EMC) found on Tegra20
> chips, which controls the external DRAM on the board. The purpose of this
> driver is to program memory timing for external memory on the EMC clock
> rate change.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  drivers/memory/tegra/Kconfig       |  10 +
>  drivers/memory/tegra/Makefile      |   1 +
>  drivers/memory/tegra/tegra20-emc.c | 591 +++++++++++++++++++++++++++++
>  3 files changed, 602 insertions(+)
>  create mode 100644 drivers/memory/tegra/tegra20-emc.c

Applied to for-4.21/memory, thanks.

Though I did notice that there's quite a bit of code that's very similar
between this and the existing Tegra124 driver, so I wonder if we can do
a pass over them and refactor some of it as a follow-up.

Thierry

--GeDkoc8jIzHasOdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvR1X0ACgkQ3SOs138+
s6HOfxAAma4aYV31RRx2/qD14Jn6MGfN3bEIReLqe6IlcvnonSeDMPjw20xowj/K
03+GR3gN4dVlJ+LzsAaS1Mjv1OGd62is5DPKDtkbHt4r7y913RntQq8bS2aAqRlT
TbI9vPggHv+Cvc+jim2Gsy0W4fK5RQcFuoqyq/4rjmRNvVIjKU4TzuRh6xryGJms
zjsUrZASxqVAvf1mfsfNAVh7hr7TNT8DvquAoki9Qy4I6oCFLTMCGJRsRzpKx3Vz
YeM73On6rRNpJEPERi5xUid+jDR8nFfJIc8Cp3N/3G2J04Kg37L64J13Fbg4n8pf
8nPLbBRDhcZ7Za0Os4c7nRdb7RrgdrvLFrr/t01dTryy1gG5Xr6UWgM0oHLbYzPx
gaBV+mXiZz8kzdA1+7sAzgU6NhGoxkpY7JEG3CRzvWYabCjAg4CaMYpF8QQ24KoU
fct464VbB4jl/Kiq+X+MgmD4G7fuj2a7u++EWEMxaBg5otNuQEnJGflxYmLLzudY
Ogsd3II2gDXt8x3FspWm3pODNXKGJdOZZhM6lOLx+nueXyYxreQBAhEAJr6k4HLy
I9I5Mq7pttlp9VcIkhYMB8w+D/ueT7qrQY/SBp+O9yT/GFLOZ5z2HUQ5PObW4Yt3
4WECZkBJr8XLcOmftZHmTTcCzmbF5MWj8ZYzfLCJAFvUotIc1lU=
=t1vV
-----END PGP SIGNATURE-----

--GeDkoc8jIzHasOdk--
