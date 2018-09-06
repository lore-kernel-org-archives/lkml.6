Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F03DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E4520844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZF8v17CV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E4520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbeIFWHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:07:19 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50459 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeIFWHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:07:19 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so12228513wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WrAhmSaA2hHEokKK1iM2uXAtVaCYyMztX7UfrHm2NyU=;
        b=ZF8v17CVFJdU0F0Y/PjQRhfdMeCd5eh0GV5f0lQC8rdlwfQE5rTw9NqJ4P0wpj+Zqs
         A6BEBzziyFpCA0JCYPzBtpnjfWzCwtD3LOPLiz1/ouSIvSNyUq01yeTrGlvEq7TkHDj8
         9HGnmy0PDxqoa4TS8E8bLORCxkG6bYVaTVYyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WrAhmSaA2hHEokKK1iM2uXAtVaCYyMztX7UfrHm2NyU=;
        b=E0TvshSuFstnfLLGuUP2qdMjM1nHyIckESWaa1BqBJLEi/ywpi2g97vYD4XPu/sydM
         hbe/R5f6jywOZ7dzIQ/wVfNOg3vkmzFkZsKkon1ci4CmrfeexlMDHq3GWsy4XwMAE6gl
         gesHvGf1QydVQUv4XWVKeDJIiwcNLBds5+gqd37s+4Lo8rCgL8wq0Dv2ZcxIc9Ej2tgf
         QQK+FFFIMMkbyW8ZEworIr7LPDCkMO9YKU9+AAuw42FWEosZm6zLWUNx96RHqapY7qNc
         QhOpyy+7dQ1ZeVRn6/6qnGqpZrEMztQnqEHgYcM/UeSfDp5w3RF8haigVDftd/FZhFMA
         CQhg==
X-Gm-Message-State: APzg51D5GvMxFnsJISAEFL2Q0tb4VTj6EDHach13/INCadm3nFMri734
        t/iDz58wGKqFP6DSU+ioIbjQ22UCaB8=
X-Google-Smtp-Source: ANB0VdYaeRZHhrQ18oMvkiEjfEs+c/ZeNwyLQoyfBDEPffz8HwQAxwUb7/XBZCykeguhkpQzcwJ5JA==
X-Received: by 2002:a1c:2d54:: with SMTP id t81-v6mr3005118wmt.31.1536255048073;
        Thu, 06 Sep 2018 10:30:48 -0700 (PDT)
Received: from [192.168.101.140] ([95.235.152.11])
        by smtp.gmail.com with ESMTPSA id 185-v6sm5400700wmy.38.2018.09.06.10.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 10:30:47 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: bfq: swap puts in bfqg_and_blkg_put
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <153622114435.533797.15694137158197822778.stgit@buzz>
Date:   Thu, 6 Sep 2018 19:30:47 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7EF3FD34-C48D-4612-BAEE-18E6EAEED1CE@linaro.org>
References: <153622114435.533797.15694137158197822778.stgit@buzz>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 06 set 2018, alle ore 10:05, Konstantin Khlebnikov =
<khlebnikov@yandex-team.ru> ha scritto:
>=20
> Fix trivial use-after-free. This could be last reference to bfqg.
>=20

Acked-by: Paolo Valente <paolo.valente@linaro.org>

> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Fixes: 8f9bebc33dd7 ("block, bfq: access and cache blkg data only when =
safe")
> ---
> block/bfq-cgroup.c |    4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 58c6efa9f9a9..9fe5952d117d 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -275,9 +275,9 @@ static void bfqg_and_blkg_get(struct bfq_group =
*bfqg)
>=20
> void bfqg_and_blkg_put(struct bfq_group *bfqg)
> {
> -	bfqg_put(bfqg);
> -
> 	blkg_put(bfqg_to_blkg(bfqg));
> +
> +	bfqg_put(bfqg);
> }
>=20
> /* @stats =3D 0 */
>=20

