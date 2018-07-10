Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02F4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6FB208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqtPuucv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6FB208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934230AbeGJPtc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:49:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36615 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933921AbeGJPt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:49:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9-v6so15156241wro.3;
        Tue, 10 Jul 2018 08:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wpVH/sxDW07mRnifz/Uc3OxOz+bfmMD6FtdQ9kVXmHI=;
        b=aqtPuucvKHXXaQD+mAqOuir8UedGMazkUcWot+loDw8dHxSLjph3U5ETBvmoFc16TM
         xrnRf8qHlw9UoeXrdF9/aXS9wKGMrS3e5C/PZU8qU3YnbRSF/XGUPuB/zvYEAySPv7g3
         HdZuC/E8W8IaKqibLDM8QF5QeLOk8VQ2GtSMoaaphzxXUzoh8eZWV9bW9ngYLBa7Z8t7
         22BYgs7pH/vLB0/RL3oRuLALGkAT53cvon2bRAc3YzsVAhiqh/q+x21nyoOzQEjEXUrB
         XIWgVP+Wkka75V9V9Roogh32aQOiqZHpZPOYt+HGctQtp4H2PsMXdN0IV5rHs9sQ2/hY
         cQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wpVH/sxDW07mRnifz/Uc3OxOz+bfmMD6FtdQ9kVXmHI=;
        b=cuLsEEkur0MTvsNyVDnxVEJidz0fZFj9/YhXxyCSFmnoTWRVQROblm6RsVPxBS63df
         Y7mCsulWC77tLXgHcwMLXiMxK9CJgO8b8h+KyC2ZxCTHoPGCTf/wq4dQzkk6nXIfmXmy
         TJzitTO7Y8FKnnd3q4MxJ5MEjxp1tzAjscZspVrbXkQiG9s/TTmV/jwNs9JLZ1Fh0tKe
         aUZcYUC0CNotQjYHDs6SwbmVU00u/ibRLokJSjmj8uom93X50c8QfpmyLPuBPJ0jCHnX
         o4t5JyWZI5KAouQieF8zH+trxxFCYo2ndd66lFZAcj4DIzXisfkXIxKvyn7wBWC6aegc
         FS6g==
X-Gm-Message-State: APt69E0fe1WpBdeWErG/8+xBhGwLeZwZINijp5476kBH2tvKZkdrLCDL
        jfZkOPjQqbDns++T71E0iX4=
X-Google-Smtp-Source: AAOMgpcENv9dgZYt5aIKVimlnZf+9Zj0SERokMx6A6Si3XIsrrFgcRcgJOH4Na7pTKKNwOfIpd/6Cg==
X-Received: by 2002:adf:f5c3:: with SMTP id k3-v6mr17467135wrp.219.1531237768192;
        Tue, 10 Jul 2018 08:49:28 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id e12-v6sm7016918wrt.29.2018.07.10.08.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 08:49:27 -0700 (PDT)
Date:   Tue, 10 Jul 2018 17:49:26 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/8] mailbox: Add transmit done by blocking option
Message-ID: <20180710154926.GB8492@ulmo>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-4-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
In-Reply-To: <20180702114033.15654-4-mperttunen@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 02:40:28PM +0300, Mikko Perttunen wrote:
> Add a new TXDONE option, TXDONE_BY_BLOCK. With this option, the
> send_data function of the mailbox driver is expected to block until
> the message has been sent. The new option is used with the Tegra
> Combined UART driver to minimize unnecessary overhead when transmitting
> data.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/mailbox/mailbox.c | 30 +++++++++++++++++++++---------
>  drivers/mailbox/mailbox.h |  1 +
>  2 files changed, 22 insertions(+), 9 deletions(-)

Jassi,

any comments on this patch and 4/8 and 5/8? Greg's already said that
he'd be fine if I take the serial driver (patch 6/8) through the Tegra
tree to resolve the dependencies. If you're okay with the three mailbox
patches I can pick them up as well with your Acked-by.

Otherwise, if you'd prefer to take these through the mailbox tree, let
me know and I'll wait until sometime after v4.19-rc1 before I send out
pull requests for the DT changes.

Thanks,
Thierry

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltE1YIACgkQ3SOs138+
s6EsOQ/9HaN/N6V7yRKfJ3THVBcHNhpECScMRxyZdsrDA6gKQaXCkgWWE7dwV7a0
upPIqevAo4GRX8Jx4ETP1M1Z0pLEozFqsOCcwo58JnFduXXfETXbb5RmeJRwj6Ep
kVRkhyLtc50JfSgKo/4LTAWmktoFAZokiPGQahl82EyU/ZryltmALJgRUK5d3gP9
RphFtyyUfMXW0JmHOVnQKNYwm5lnr+tHxSeP4WDow6EXtzq12//hELp8J6jpxVaW
/F83+5UNROde84jNKVtiBXithQJGoUTI29SDFrzncw3VTH64A0kzAgXKsCOigSE7
eFMNT0gkxPmdg+JjfJezldTeYxmi6vl6ikPSBSOwie2OZjCEjXc787rT0PkL8Djt
5JYKl5p2W9f64eoNwMUe4hKdiUPCWZ4vjt0NTG84gw9FKPmclKhImqFs5RmiBhZt
Syod6TZL5qWwwuHYMMr2TWuKH+JeHaAnb7KMqf2MB3E1mqA3W/3mLXYTNfp9Z6Sy
rNy2shb2ZjTJKMrfYSuqajwEyvR/r0VFQcPUmGjVDJbDug9eLlH/j6cskjx+BqnS
9NZQQpjrgAkXrpLVvZ7R7p8HIipTAwbQljkEVEpulG4ZMUiVCGvP/ObZ2HI4WzZp
OhhvIifTVTmCH3wTyzkXqAsEVfuRdw5AGe4hU6QDWQN29tJHs1U=
=NUWu
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
