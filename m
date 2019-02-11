Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C60C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A5121B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549891908;
	bh=OMC3RCaKGagtOhmsbUJVzAbiJ4doUr8D9Gjg6v3KVag=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=x9JHatBsTu0P5wqwl2R5GfSbo70ZnZughNX0kh2NmxrvBckfd9oQSL7FnyyYIbuQ6
	 iwbeA5MGjedXVh7oCr8WNbMQafsQ7CU/N7Wz2inVLNOuZoF4Df1K060Qj9u7byvDaE
	 d/58LJJB7tf1JnFp/umQpBbSXOaL0XyIb9xUzV7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfBKNbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:31:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:33328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727373AbfBKNbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:31:46 -0500
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41D1121B1C;
        Mon, 11 Feb 2019 13:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549891905;
        bh=OMC3RCaKGagtOhmsbUJVzAbiJ4doUr8D9Gjg6v3KVag=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YD0pBaXEsRixMcH39orwUYDIi1kxtFDReYpRW1jfv3KSOB8/YhCBiwscQw+/mSW9c
         FejLWDOjzb3PXtPn9kMw3okSyU98VbbfT/DpH5l28p8jY3xZxmaa5Dkkyu20J05Typ
         UvENNTzutwZPgKO6R2mN7BOxmtTWeS1vtADFctZ0=
Received: by mail-lj1-f173.google.com with SMTP id g11-v6so8785878ljk.3;
        Mon, 11 Feb 2019 05:31:45 -0800 (PST)
X-Gm-Message-State: AHQUAuYQtMwM99OWQ35Wnwd2/wDY5QVL3TDjnxxzS6k1clMnI33wbmT9
        IKH4ySUMjUPZySUFj/qA1nzMDiBtgzHQo4LpGeg=
X-Google-Smtp-Source: AHgI3IbMql/i92jxgbHX8DjRP7OoA/yQzuCKMr1CD7iQ+DDT+1tc+yYqMVdPOXjjm87bmv13hgS0E3cCl+z6nzKYVmw=
X-Received: by 2002:a2e:999a:: with SMTP id w26-v6mr13879011lji.169.1549891903446;
 Mon, 11 Feb 2019 05:31:43 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207170054epcas1p1e61320d308bc5be30187919f3360f501@epcas1p1.samsung.com>
 <20190207170028.720-1-s.nawrocki@samsung.com> <20190207170028.720-4-s.nawrocki@samsung.com>
In-Reply-To: <20190207170028.720-4-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 14:31:32 +0100
X-Gmail-Original-Message-ID: <CAJKOXPf2oAgLp9UrO7p2UHtenHBtmafwfS8wQD=dz-ze7jtTew@mail.gmail.com>
Message-ID: <CAJKOXPf2oAgLp9UrO7p2UHtenHBtmafwfS8wQD=dz-ze7jtTew@mail.gmail.com>
Subject: Re: [PATCH 03/22] ASoC: samsung: dmaengine: Allow to specify custom
 DMA device
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2019 at 18:00, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> The additional function argument will allow to select proper DMA device
> for requesting DMA channel for the secondary CPU DAI.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/dma.h         | 3 ++-
>  sound/soc/samsung/dmaengine.c   | 4 +++-
>  sound/soc/samsung/i2s.c         | 4 ++--
>  sound/soc/samsung/pcm.c         | 2 +-
>  sound/soc/samsung/s3c2412-i2s.c | 2 +-
>  sound/soc/samsung/s3c24xx-i2s.c | 2 +-
>  sound/soc/samsung/spdif.c       | 2 +-
>  7 files changed, 11 insertions(+), 8 deletions(-)
>

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
