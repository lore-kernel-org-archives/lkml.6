Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6A5C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76456208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKDvSdoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76456208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933307AbeGJK4r (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:56:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932172AbeGJK4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:56:45 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80F3420883;
        Tue, 10 Jul 2018 10:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531220205;
        bh=TiUQiqq6FfdjSgnrXYp4PJ7JbO6ubukINmXbq7ITako=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKDvSdoFgfBmGW+zYBj+wbrVF5g7omftL50o/psBO2D3pxFj7zTZjJhK/D1kSTWUz
         zrPANV2t+X1mhcUjeuf3Us1yDtGY16ZOikDlrLxgP6E04icP56CmM2FIDtTy+kkFQZ
         AJNMNjUaMvU561MEt05W37P0etLOhtxbVk5OAsqM=
Date:   Tue, 10 Jul 2018 13:56:42 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Denis Lunev <den@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH] ib/mlx4: adjust gfp flags for DMA allocations
Message-ID: <20180710105642.GD3014@mtr-leonro.mtl.com>
References: <1531144273-25959-1-git-send-email-jan.dakinevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UXdImcDs+Jp8Skh3"
Content-Disposition: inline
In-Reply-To: <1531144273-25959-1-git-send-email-jan.dakinevich@virtuozzo.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UXdImcDs+Jp8Skh3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 09, 2018 at 04:51:13PM +0300, Jan Dakinevich wrote:
> For most cases it is enough to use common GFP_KERNEL flag. However,
> there is one place with defined fallback path on unsuccessful allocation.
> In this case it would be preferred to append on first allocation attempt
> __GFP_NOWARN and __GFP_NORETRY flags to suppress possible warnings and
> to shorten the path to the fallback in a case of memory pressure.
>
> Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
> ---
>  drivers/infiniband/hw/mlx4/cq.c            |  2 +-
>  drivers/infiniband/hw/mlx4/qp.c            |  6 ++++--
>  drivers/infiniband/hw/mlx4/srq.c           |  2 +-
>  drivers/net/ethernet/mellanox/mlx4/alloc.c | 12 ++++++------
>  include/linux/mlx4/device.h                |  2 +-
>  5 files changed, 13 insertions(+), 11 deletions(-)
>

Thanks for the patch, however we are working on the patch to avoid
second call to mlx4_buf_alloc() and it will eliminate the annoying
WARN splat.

Because it is in latest stages of internal review, NAK.

Thanks

--UXdImcDs+Jp8Skh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbRJDqAAoJEORje4g2clinKCwP/isUFdWDQl5E6247HvyTeC3a
/vG4hTqCcNZ+a2e0FWCtIgPdZ9wfj5b/NBf9a/MMva2X/drKHjaXs6sszBwbLvOu
c1Fev75rSnzoiKgcBQZHnG7IiRlqZGgk396o3qz4HyBklKf4EaZuLPWV4z8J6IBG
K+rxZCd8bHvzOJBtzMvi9GeOHh/e1XNmlNQsvTpRf+yK/Fg2KdYWqP0BLgryWLuP
XQwKx5TuhiuLx2bkV/DaqHZ+wgltxmc1dwYpPwgFkZdUhd2TrByfkMeJp40JPbHo
lLU57U0QBUEV/8WZaWgua4lmw6U5k5jJ10ZsylW/yH+6BYyuxDObdByssqLU5gDp
eWULOq41M96rJXbc+idxhABKHMl7kWcvZtQ6WC/w5QVbIMz8dlqJ1QauaynvojN2
G0ToKMg9Q/+KYcuZf4W1R0lZ7uA4DiGiP08bCh6VSedeE1dyuwoySVs3FnWJEroQ
tFY2+A72waUm8JpkbpnQkHHkB90XMR0r25srz2qKm19HSlND8u2oSO401JAk0Hau
cjbG0IAQlko7akGX+ubn+R6MNOJ0UiJ4bsVV9gr+G9Za9mWjG4lE9SzXnBAaQLSS
yxRrTLmPA7Zf68Ig+S8mcsSP1i5wYYkHx8omYA8eS/F6MyPs8fP0y484tyKTgtcQ
dr/wJZO7y9sa+8/abuLM
=A3Y2
-----END PGP SIGNATURE-----

--UXdImcDs+Jp8Skh3--
