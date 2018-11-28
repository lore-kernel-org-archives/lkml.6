Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC9DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B1220660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbfM6qvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B1220660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeK1Uk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:40:56 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33614 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeK1Ukz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:40:55 -0500
Received: by mail-ed1-f67.google.com with SMTP id r27so21527050eda.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 01:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+2s8r1ezYgGkQnjq6e2bTnI4AMMcUFPjninxlc1y4o0=;
        b=XbfM6qvoB/86crySBjOPijQNdibbNu246oywgoY5ZSXJ6UEnQNdNPM2Q0Uny+Ddl8k
         Q8iYIc8oZXFPV0hgSpHLb0Ut8qO1pyf4wyPrFEgyBJTTAWsL+HLFlQL6WL3UnOgl5QwR
         +kqdGHs4x9tMm6UZrmRcazCvUMd3/+RjsWuzFa8/fIZgmuMq4CH4mXnqvORPNPcUh1lo
         6ZzkvgaooCldNLjus3P+D6JqCvHeNwiUQY8OxWH9XdvnY1ZGOkPLTMvBPhUdU7xVzQvT
         lCWoSowq60980XT37XopFVLaTDtictrVAfsfLhuCD72vn+ioNUNiIkktphl9ESyx5GDv
         cswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+2s8r1ezYgGkQnjq6e2bTnI4AMMcUFPjninxlc1y4o0=;
        b=EiM6WxdXKzyMfsllgTcr14lnrnkTCy6Y6Bq96wywJcWAPMuly3UJwfR48jgKhJGM16
         vojZPsVZR628CjBazFzWn9TxRTdOawsuDZOTZ2mwYn//eRbaqRP4YeN0NQIpRcQMp+a3
         zjKZoINOxScreydZ7Y7iCOqou4ICE+lsP/uAHf3B2je3RR0brFMLxs9NCIObIdJzjz7X
         +wd2+MOlf6r+i80BQVeTyQl5kXm5kTTAAdRh8Ru3i0GEDfx+dWkXPdK/DZzqD1oP75J5
         PTGcIwgip6yxw/I9vpv2dJRFtTsDn6u/42O9xqU+o8ClPwu57QYSP3PQXbb+cHhSNClq
         bxLw==
X-Gm-Message-State: AA+aEWZNiho0xlTf0eeOftyzbjoHtJ2gVZP5+51bBnq1tOZjiOM3Losm
        3aoc1wFZWmvtglMGpxVOekLXmPiC
X-Google-Smtp-Source: AFSGD/UEInHY7tEQoOaPLQrFhAxO7qaUMOISHZfPqEz36pyN3Q7Jw3jEqGKISSIN0nMGqR5TmcH0iA==
X-Received: by 2002:a50:f014:: with SMTP id r20mr29838888edl.144.1543397992461;
        Wed, 28 Nov 2018 01:39:52 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id 49sm1715483edz.59.2018.11.28.01.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 01:39:51 -0800 (PST)
Date:   Wed, 28 Nov 2018 10:39:50 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] mailbox: Device-managed registration
Message-ID: <20181128093950.GG17419@ulmo>
References: <20181121145429.7582-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9/eUdp+dLtKXvemk"
Content-Disposition: inline
In-Reply-To: <20181121145429.7582-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9/eUdp+dLtKXvemk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2018 at 03:54:10PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Hi,
>=20
> This series of patches adds device-managed registration functions for
> mailbox controllers. A number of drivers can be simplified by making use
> of this new API both in the error cleanup paths in their probe functions
> and in the driver remove implementation.
>=20
> In addition to adding the new API this series converts all drivers to
> use it. There is also an additional cleanup patch for the mtk-cmdq
> driver that removes some calls to devm_kfree() that are not needed.
>=20
> Thierry
>=20
> Thierry Reding (19):
>   mailbox: Add device-managed registration functions
>   mailbox: arm-mhu: Use device-managed registration API
>   mailbox: bcm2835: Use device-managed registration API
>   mailbox: bcm-flexrm: Use device-managed registration API
>   mailbox: bcm-pdc: Use device-managed registration API
>   mailbox: hi3660: Use device-managed registration API
>   mailbox: hi6220: Use device-managed registration API
>   mailbox: imx: Use device-managed registration API
>   mailbox: altera: Use device-managed registration API
>   mailbox: sti: Use device-managed registration API
>   mailbox: xgene-slimpro: Use device-managed registration API
>   mailbox: mtk-cmdq: Use device-managed registration API
>   mailbox: mtk-cmdq: Remove needless devm_kfree() calls
>   mailbox: omap: Use device-managed registration API
>   mailbox: platform-mhu: Use device-managed registration API
>   mailbox: qcom-apcs: Use device-managed registration API
>   mailbox: rockchip: Use device-managed registration API
>   mailbox: stm32-ipcc: Use device-managed registration API
>   mailbox: ti-msgmgr: Use device-managed registration API
>=20
>  drivers/mailbox/arm_mhu.c               | 12 +----
>  drivers/mailbox/bcm-flexrm-mailbox.c    |  4 +-
>  drivers/mailbox/bcm-pdc-mailbox.c       |  4 +-
>  drivers/mailbox/bcm2835-mailbox.c       | 10 +---
>  drivers/mailbox/hi3660-mailbox.c        | 11 +---
>  drivers/mailbox/hi6220-mailbox.c        | 11 +---
>  drivers/mailbox/imx-mailbox.c           |  3 +-
>  drivers/mailbox/mailbox-altera.c        | 15 +-----
>  drivers/mailbox/mailbox-sti.c           | 13 +----
>  drivers/mailbox/mailbox-xgene-slimpro.c | 11 +---
>  drivers/mailbox/mailbox.c               | 70 +++++++++++++++++++++++++
>  drivers/mailbox/mtk-cmdq-mailbox.c      | 11 +---
>  drivers/mailbox/omap-mailbox.c          |  4 +-
>  drivers/mailbox/platform_mhu.c          | 12 +----
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c |  3 +-
>  drivers/mailbox/rockchip-mailbox.c      | 15 +-----
>  drivers/mailbox/stm32-ipcc.c            |  4 +-
>  drivers/mailbox/ti-msgmgr.c             | 13 +----
>  include/linux/mailbox_controller.h      |  5 ++
>  19 files changed, 92 insertions(+), 139 deletions(-)

Hi Jassi,

any comments on this?

Thierry

--9/eUdp+dLtKXvemk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv+YmMACgkQ3SOs138+
s6Hz4RAAmoP+WY6al1KgoAzNo7HLuaNa5ADvRASqeeaR0bzEINEjeDNmRLz4krwp
tEa1oAhqbFerSke7AbqnU/C6XvHuGFTCn/V1LaifPq9aAf1Gwp7YoppLk7EAy6e+
QXfPd9giIVFUMgAZA/JfgWJ+P0rS+XHn4CrF8uALDuIhJOKESYw//5s6OAE5BgCC
8TGb+4wml300P8Xunp/tA/28A76X3qzW/CsQSdoUzATsfLnxiQ4J33nfK8PtJrRg
Qv7IkRVmasUSiRkb+x7Xohb+8bD4ieboS8Kt05guqqVtKAFgaY6cEu284mHbjQLZ
4tkmQnaUSsCiHF1sfHGhxRB/MaRLlePIROXio7mQaOkb5394yb3PcyZ8BBxig9U4
RoubsIxKanzbNLiINUpSL5Kb4Rvip29TJy0zJkSUzIRnQaRJky9X4suQi2hCmmvv
lP8yYYDwAgmcsnEh30CGVhoL593tcuk0JU+hvDOQwFP0Cz6feBkv+34stSdwgyoI
OwVkRjE63JP6ZX/6EI4XhtoHE3NsBhQStuv/zisQwaTtFzeh4ZykEf/pCvLj3hQS
PzfhgMPDL1T6R+I7e2HxTEg+wAicisiBqpP7cCaXS6lVxK9aGhp2YLuGXYb9VxJX
0ymyldloPCBZj4AkDJYZl79drJnWE8COkRq/hcVZ1ldm1bNtZBM=
=A9Wk
-----END PGP SIGNATURE-----

--9/eUdp+dLtKXvemk--
