Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36CBC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4701925447
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A148U+9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4701925447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeGBNMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:12:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34562 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeGBNMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:12:19 -0400
Received: by mail-wm0-f67.google.com with SMTP id l15-v6so7776270wmc.1;
        Mon, 02 Jul 2018 06:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ApG/wpebBQ55E6qIDJTJntJBvHihaJj0NWcCD0tV66A=;
        b=A148U+9BkGeCZkoZtjIlVn1Joa7P5rRxT16O8cRK5sQfdmJssCb6a/oik01d6psNkw
         h3MVdRo5+epufNw7BwMw7CICtcJlXmbGJMkYcR6KBjpRl9OTJzMBkinF3uk5HAVrCOxp
         u70GlyB15eEq4bXIA/s811Tn16LYo4lZIorldzda1v1Gt6nq9XcsYfTsBAB9pNu2VuxA
         wlinJ7D/RadOG38YVFFPfWEOz7gmmREO3rZtdGSlXVpYcDnuGC4EwGg/nlC4zDkcB0U5
         65bcKh1/3Wx7mtnB22fE9XsJsqDlB9seIrHenOPOf/vgDE/M9G0CksSOYezNl0DCabDE
         guiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ApG/wpebBQ55E6qIDJTJntJBvHihaJj0NWcCD0tV66A=;
        b=WKqHxAy/fC9tOQZbrxooONQA3mdIEEu3aVfvM1QIyvLQrYnRFlsTYcdmtO1nzEhYN5
         70xG+YXZVAj9gAoOaXZFkL03rLTDWWRTw/azH7sKNcNZ4MFz1E0YZAy1OSK7NpxBqZpz
         565fenTO1KWVnbeQBBsmf9AeJHmF31Ip9DY+pGPVC98SQnsI9+N9uDIlnXwPCvJXawgW
         OB+2/BecSbPRgc07Uhpvjxwat60PaocHjhBbYrBHSHpdAOyLVBSsD16BjlrRnvbkZDLy
         EVCAdUjpHTgvWnmsX05RR9JvFjOvh9WBZKN5K67dY0kW60iW9olfkbdn7K/TRcgrohu0
         YKmg==
X-Gm-Message-State: APt69E0nr1jYc8OA5KQrib1ZpHcQH9VOdk4eaNYvO2N90SUR9qRcrj3i
        DSw/qKiDZlmXCYYP8Y3hdyA=
X-Google-Smtp-Source: AAOMgpfJCskjobTKirzo3tv47KvQg3dAj06+PzoIOWArLTLyjRMlWcNvMfXSgopm+GkaO+pdW0ucPQ==
X-Received: by 2002:a1c:6354:: with SMTP id x81-v6mr4799878wmb.23.1530537137536;
        Mon, 02 Jul 2018 06:12:17 -0700 (PDT)
Received: from localhost (pD9E51838.dip0.t-ipconnect.de. [217.229.24.56])
        by smtp.gmail.com with ESMTPSA id w109-v6sm10113950wrb.70.2018.07.02.06.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 06:12:16 -0700 (PDT)
Date:   Mon, 2 Jul 2018 15:12:15 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <mperttunen@nvidia.com>
Cc:     jassisinghbrar@gmail.com, gregkh@linuxfoundation.org,
        jonathanh@nvidia.com, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] mailbox: tegra-hsp: Refactor in preparation of
 mailboxes
Message-ID: <20180702131215.GF13096@ulmo>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-5-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Content-Disposition: inline
In-Reply-To: <20180702114033.15654-5-mperttunen@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 02:40:29PM +0300, Mikko Perttunen wrote:
> The HSP driver is currently in many places written with the assumption
> of only supporting doorbells. Prepare for the addition of shared
> mailbox support by removing these assumptions and cleaning up the code.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>=20
> Notes:
>     v2:
>     - Moved fixes for some style and other issues from the next patch
>       here, where they belong.
>    =20
>     v3:
>     - Added Jon's Reviewed-by.
>=20
>  drivers/mailbox/tegra-hsp.c | 123 +++++++++++++++++++++++++++++---------=
------
>  1 file changed, 81 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
> index 0cde356c11ab..5dc21a6d01bb 100644
> --- a/drivers/mailbox/tegra-hsp.c
> +++ b/drivers/mailbox/tegra-hsp.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
> + * Copyright (c) 2016-2018, NVIDIA CORPORATION.  All rights reserved.
>   *
>   * This program is free software; you can redistribute it and/or modify =
it
>   * under the terms and conditions of the GNU General Public License,
> @@ -42,6 +42,7 @@ struct tegra_hsp_channel;
>  struct tegra_hsp;
> =20
>  struct tegra_hsp_channel {
> +	unsigned int type;

I think it would've been slightly nicer to avoid the type member and the
differentiation made by having different mailbox operations for each
type, but since the mailbox operations are not per "channel", I don't
see how it could be done otherwise, so:

Acked-by: Thierry Reding <treding@nvidia.com>

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAls6JK8ACgkQ3SOs138+
s6GA7xAAwH1TEXunF1LxnJZIbfLflof9BNMD3GWFa/EngNCLESeAohJCuOaNR55h
x7GeAxsZlVodbMqfU7tVbuDSia2Yt6kgpjPvIlULbNhn2FkO9mSV61t8wV/u4zHX
ZmhB9QHTQBzkPCxbJPgZIjF9698Ei3mmF5a567crM3DQrQfnHwfgAogF0h6a0rOu
Pcpj6qjXbXapYnACG2zcG9WkfZeLYp0a8umLFDudKvwDHhJCRWLElg899GaeS8Do
FLo6tsODH0+D2NjGbMqDZDvzr0sULReq6oqh/+10JAn6FIRE8ETyZ5ngaj0s90H5
njAFzyQEagjQAt0DBlxyv3Z2E9ZUalz/gRx4g3i1X/oNTrcJVAEXenqFFsfk/Fup
YUlfKICA21Sk5+YT3BdaOhkhu2zR8iMdZxsWu5jI2fpeM1DGw91HLjmEXZd90jVV
HQ0z8DHE14wpZbw0674uN0hClUH8FBohIoL2ILNilaHArwS+fTvfeKzlhE4OBylG
RH5Bjjr79GUxEIJDZYZP3VcsAmvEfOJy26PF1OwU7wUvT2RwFEpjzM+tV7VX6jIo
cJM7tTN0hiLNkhBe9ETICGCDPTYenk3P8G0UPyMrhq9B8mVtVlfHKIcetxrap6Cd
xsQxiirIExJS14VrFiIkDcPXREvepX0sOvAr8bi/uqotaRCyATg=
=RHlv
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--
