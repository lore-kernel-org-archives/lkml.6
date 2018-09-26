Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C83C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701FA2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VckMDrct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701FA2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeIZVi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:38:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39819 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbeIZVi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:38:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id s14-v6so27447136wrw.6;
        Wed, 26 Sep 2018 08:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bs/nbqKKIsVDD/9x/2LAPeGw0Rv17Fwq+dXedK2z83M=;
        b=VckMDrcthwZlbfBrnFNLkb/36ym/6pNcbpK74t/0F69H6dgvfzMu3qDTC6sHvwK0+/
         vcI1uzRF1pW+aaEOlJLeuyU5aCf96Bx5TNTwkIi/7/d20kvidjvGaEToU0kpgUIQtzy8
         vYnbd8zRJfp91DhC5RJtv4VA4/dwjcxEYq3ICaIfw8auJLQta897UT2Nji+kLX21oLoq
         xcQG2tUb04mskYjjQiJbBYyXys3boprHvNbgPgRb8Z+UlxEIpc/jRWBAQNyO2FVecixI
         dPibDAav0LNP/MVF2g2LBHYX9NA00o9p5GKKpgJudRr7ZAMW8srScT2yb8hPblDkAsnf
         P2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bs/nbqKKIsVDD/9x/2LAPeGw0Rv17Fwq+dXedK2z83M=;
        b=DKkVCWxLL7rn5zhUuuCvoKpOxmwS479kvqXabDQBfcFSaD0Xpdltl8L97vomKiB7C1
         lSo9X5SocSydBn1VPinoAoP4fxnRHybQ+6ST+VOSGyBnmf3ZxDX1l+gWqtUYRbhW7KGt
         wH6k3eauaVB1ivxGApO+bUD5LoAgwkfCrz1aTFSgiVgA6lCe506dXydp/sM2+b//hrE/
         CLWi8qj2e7kSlBg46m3y6jbqcme09rFDRFApksytOgUbzYPBO3ZIx66mW+P5skj9v8vm
         SO2395ya2wU2+pV5lrmq/4KClMGD03uXKW4DSvUYNb1x89zXLv2zmVHH0obEwCrX7Ckc
         FfKw==
X-Gm-Message-State: ABuFfohxcGJH38JmEg9oW4IaH+dxtw7gaJpaBrvOOXPqgPRhN48qbHpP
        9u06JRr1p2neLDohGamlzGs=
X-Google-Smtp-Source: ACcGV60n7o6pGVIe5KzRJj3ALreNolOAJyPDhQcsp+yaEAyAT7oZZhOI2uXSLKa1xKrrmH2zwPPsqQ==
X-Received: by 2002:adf:f94e:: with SMTP id q14-v6mr5701615wrr.151.1537975501278;
        Wed, 26 Sep 2018 08:25:01 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id l40-v6sm5745396wre.38.2018.09.26.08.25.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 08:25:00 -0700 (PDT)
Date:   Wed, 26 Sep 2018 17:24:59 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     daniel.lezcano@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        ezequiel@collabora.com
Subject: Re: [PATCH v2] drivers/thermal/tegra: Fix a double free on the
 device node
Message-ID: <20180926152459.GL12980@ulmo>
References: <1535376738-14035-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1X+6QtwRodzgDPAC"
Content-Disposition: inline
In-Reply-To: <1535376738-14035-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1X+6QtwRodzgDPAC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 27, 2018 at 09:32:18PM +0800, zhong jiang wrote:
> The function 'for_each_child_of_node' iterates over the node list by
> dropping the of_node reference of the previous node.
>=20
> Calling of_node_put() on the iterator is pointless and leads to an
> inconsistent refcounting in addition to a double free. Remove it.
>=20
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
> v1->v2: According to Daniel's suggestion. I modify the subject and commit=
 log.
>=20
>  drivers/thermal/tegra/soctherm.c | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--1X+6QtwRodzgDPAC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlurpMsACgkQ3SOs138+
s6EP/A//QHaNYw7hhfwyhf5lt/U1Hy/GyDBw1Si537ox+QLGv14Dk2AiXSIR4tsp
z+pQ+mQHeJQoN5VYdQQ4DDLUUV9S+HC4Aavhh688ImwtD/EXw30oDta0GuxUAqJg
sPr+t8cdgqTXOt4ufTh3JsYtSGu3XpP8g0hoVHKSSiAnJTh3j1p9AHRyuAsBQrMX
LJXlveFToO49N+F3c7f88sfRyzZg0PjNDMXef2dQeVKbVatylu71WdH3P66M+2eD
K5RXj7oNqZQv2oPSGHJ00svPFZ18kaIu8Y3EErm6R1gDt877mUvxLKgFT36wv2JX
awP3a5FEw7ELkDKwADd80fZbejApU3Jja9H/fzwftiiYP9Edd4YBajn/hB7VPOSm
RxIIHgRL99IdjtTubQ2E5RKZ5xSdspfqvq6VXz7c+3K//pJ946bsBTKoj5LurSO2
dGNwaw0sLjI+9bl03i5Yt+V3oqeO2bAtH5ffN6JekPxjNsEB29gtUVMVsC4f2pXr
Kk8+wJ8pz92/3Wj3y6eaysDbve3NPZdwH/4fom/Hu8G8WDBWGV/gu2NvGldjB9z7
/XWI6Jhe7aXiTN6iwQS5Zrs2eRm73kG75Qk6yd9/cXqfU3q/ARbdLB42RW9NGr6K
jN+uXqGKfuvy2arGjamoM8YqK8EV+z2Ptk7GiS7Rz09oZgSLm6Y=
=dyqt
-----END PGP SIGNATURE-----

--1X+6QtwRodzgDPAC--
