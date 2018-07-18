Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB167ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644462075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9cVeLc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644462075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbeGRVgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:36:49 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46758 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730732AbeGRVgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:36:49 -0400
Received: by mail-oi0-f68.google.com with SMTP id y207-v6so11401761oie.13;
        Wed, 18 Jul 2018 13:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qHCkywC1w0UFWaWtjLYMVZHQMDRshIYNZ74PWrZJuGE=;
        b=A9cVeLc9UlIYBUnTZsqZDBaH+7eVZ3QgsydNFrAo8SZ/gIyExSr5kZrF4PGg2J41Yu
         MzsU0PhU2zTFhfwfqRtPTwCB6DMs6aPIN2P5C0L18dnvwzlDx3H+sTc+WtnUGl6Dmzsl
         //aRWxlkiO5ebQOKqhyyPDLgKwtnlQ2WUbX/l1c6/a+IYsKoqIt2krQ+tL/FNualNdOB
         42G8KHJ4fO3MYx0VpXuEXWvjsxKpEmhbJiZL3LHez6HTeu1I9MbyeyC3MBgNxcxdhiTg
         62r1UaFhxSBYTafTdKcj/qKNJwYtHvxLVyY1qr41PZUE5gLpJD/BQzI+nmQWvnfegNI+
         MV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qHCkywC1w0UFWaWtjLYMVZHQMDRshIYNZ74PWrZJuGE=;
        b=mXIHoZwYlIjnIoVJFPiBNfNgEzkCz7Lmf/ripbM9XE81emsiHvn07lXtRXRh0LYNTt
         Bf02Ew2Mrym433sEq2CXogiM95iqD8qw6n6GHAUWk4oqqzzWVz5ttq8+Fv+xn03IiTSZ
         BJ/ozJRNPxuC74JJ/rswUrZB0YgeIcY/gF5Go5owY6f7MTsTBV6uOynVfJqpLRU2bBmj
         CF82WLul5bzTcdj0i3467ruOyTYnOtTv1Yp4/YZGQqFA99WrADPE7JVc2ollOTsTXYmE
         0HuNz0Hx9+bXhk5ZRKipe3y0jpdRQlRJsYN0yJ2a0vhigxH5Qzv/APvuows9ZalpldX0
         hSoA==
X-Gm-Message-State: AOUpUlE3yCaNzU+BUTj+m30MvPt/tLQLuxoaVwQd0bph8oSpy2ja/jYi
        EjzS/DHdVElFrWu8Z/x2V+WtRBgSMQFLPnz4HNrahQ==
X-Google-Smtp-Source: AAOMgpdPyxLwVFQP0EDKF0Rb7ynZgNjikggODLpo+GSqR0DmxgDSJwMv9dXH8iGqdSqTONUavh33GBzRi5l59yFFHec=
X-Received: by 2002:aca:5f56:: with SMTP id t83-v6mr8459953oib.115.1531947429073;
 Wed, 18 Jul 2018 13:57:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:42c1:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 13:57:08
 -0700 (PDT)
In-Reply-To: <20180718192426.18853-1-chenbo@pdx.edu>
References: <20180718192426.18853-1-chenbo@pdx.edu>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 18 Jul 2018 13:57:08 -0700
Message-ID: <CAKgT0UdHocaTZzuudmx+CZgovWnv+RiDwqrVYpaxOmRTCT4LZQ@mail.gmail.com>
Subject: Re: [PATCH] e1000: ethtool: ensure to free old tx/rx rings in set_ringparam()
To:     Bo Chen <chenbo@pdx.edu>
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 12:24 PM, Bo Chen <chenbo@pdx.edu> wrote:
> In 'e1000_set_ringparam()', the tx_ring and rx_ring are updated with new value
> and the old tx/rx rings are freed only when the device is up. There are resource
> leaks on old tx/rx rings when the device is not up. This bug is reported by COD,
> a tool for testing kernel module binaries I am building.
>
> This patch fixes the bug by always calling 'kfree()' on old tx/rx rings in
> 'e1000_set_ringparam()'.
>
> Signed-off-by: Bo Chen <chenbo@pdx.edu>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> index bdb3f8e65ed4..27b006b60f8b 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> @@ -624,14 +624,14 @@ static int e1000_set_ringparam(struct net_device *netdev,
>                 adapter->tx_ring = tx_old;
>                 e1000_free_all_rx_resources(adapter);
>                 e1000_free_all_tx_resources(adapter);
> -               kfree(tx_old);
> -               kfree(rx_old);
>                 adapter->rx_ring = rxdr;
>                 adapter->tx_ring = txdr;
>                 err = e1000_up(adapter);
>                 if (err)
>                         goto err_setup;
>         }
> +       kfree(tx_old);
> +       kfree(rx_old);
>
>         clear_bit(__E1000_RESETTING, &adapter->flags);
>         return 0;

So this is technically correct, however I am not a fan of fixing it
this way. I'm not sure why we are even bothering to allocate new rings
in the first place if the interface is down. We should be able to just
update the ring count values if the interface is not up and not need
to completely redo the allocation.

With all that said I will throw my reviewed-by on here as this doesn't
actually hurt anything and it does resolve the memory leak issue, my
only complaint is that this is still wasting memory allocating new
rings before we free them later.

Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
