Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2B9C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF279222B7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549893909;
	bh=80p+goafnvDLcXu8FFLGv0Po+75YCDVy4W3Cb1Opcuw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LChfCsiX2nCl0Eu0/D0dTkkp3UKeiJmLDXCBOgX4wvMw9YxHNTtDykpny4Zy6SNNc
	 k9tic5O7K3gcxOPZkppGKbUhWeyhYaXN1DvXrxUsv2YJZuCg4oxvkPxejzhFY2NNlC
	 TiyQWFpgHRcHsUch5uOdIg4Y2VIqL/pTAYSYkj3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfBKOFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfBKOFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:05:08 -0500
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3AB8222B8;
        Mon, 11 Feb 2019 14:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549893907;
        bh=80p+goafnvDLcXu8FFLGv0Po+75YCDVy4W3Cb1Opcuw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cOi1GBLTsGGBNeNMNswap0SaE9L66ZKRDNXMq7dkUa7zL9THw6eTIrA2lToAgsM4Z
         SZmtXftfWLyGXMH8Nte/t7FZnZ3Fqk9m15OjHn2UQIXSIAocVpifgUTiLoEfDqZEjl
         rah7m1vYfpAK/iLQz4g+1RsNnbIoCnXM8niQ65v0=
Received: by mail-lj1-f178.google.com with SMTP id z25-v6so8831549ljk.7;
        Mon, 11 Feb 2019 06:05:06 -0800 (PST)
X-Gm-Message-State: AHQUAuaA4tl5ajvI/QIf9zt3x5x3DMNN3exQwLy3W+L+wWpld7foAu6o
        nThbhX67RLgEdCsda7TI9Rc4g3BshVcvgxNp/HY=
X-Google-Smtp-Source: AHgI3IYGwjMVZpCBYk4XmU9EWCEE6p6hM+jwoSro/4W4Bfi2qNIc85yPtkR+zHZoiVJyPI2bNzChpd/uVBCRu3HsABI=
X-Received: by 2002:a2e:3a10:: with SMTP id h16-v6mr21962837lja.184.1549893905198;
 Mon, 11 Feb 2019 06:05:05 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207170155epcas1p42ba30c540d35290c010b5bfa4645e3b1@epcas1p4.samsung.com>
 <20190207170028.720-1-s.nawrocki@samsung.com> <20190207170028.720-21-s.nawrocki@samsung.com>
In-Reply-To: <20190207170028.720-21-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 15:04:53 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdznFWovWAsnc2YK+AyGRE7+GhaGCbkre7yEcA3s3R52A@mail.gmail.com>
Message-ID: <CAJKOXPdznFWovWAsnc2YK+AyGRE7+GhaGCbkre7yEcA3s3R52A@mail.gmail.com>
Subject: Re: [PATCH 20/22] ASoC: dmaengine: Remove unused SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME
 flag
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

On Thu, 7 Feb 2019 at 18:01, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> There is now no users of this flag so remove it together with related
> data structure field.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  include/sound/dmaengine_pcm.h         |  6 ------
>  sound/soc/soc-generic-dmaengine-pcm.c | 21 ++++-----------------
>  2 files changed, 4 insertions(+), 23 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
