Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976B3C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDF220855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549891805;
	bh=z6ywmHAXjBOZWMNP/yx50SJOHG3IAoQfBgBqs41nlKo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QxdFWkNb0nQ6+0IQniQtq+29DSRGOlOBuhH/HDcT2CPy3BWv2WpWSeiXuuq0Q8va9
	 ga+7I6UdvkrUKIsH2YCBuEFSUOKULmnB5vq4oANGwX8yl3SgqFPEdg04upBvMm11SK
	 MKf4Hs+DuUY0/U+Qbw8OYBw0L8CXZUqPa3kgSm84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfBKNaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:30:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:60466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbfBKNaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:30:03 -0500
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 491F421B1C;
        Mon, 11 Feb 2019 13:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549891802;
        bh=z6ywmHAXjBOZWMNP/yx50SJOHG3IAoQfBgBqs41nlKo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pNQN9DHmk1S8nTChmfGWvHVjBz6gBgYTpKBDStyVduxiA/V29sc2eoQ7W1P+jIbK/
         5FlcHhyC/LnYtd8JaVujyFItewyJVY1SDzC0UI8RIhZkxe5l2kkfNL+Gn2VsoMWlLQ
         IHk1kSZb3z5jlgXfU5L0GS0LuIgqBCdRsvhAsWC4=
Received: by mail-lj1-f173.google.com with SMTP id z25-v6so8727949ljk.7;
        Mon, 11 Feb 2019 05:30:02 -0800 (PST)
X-Gm-Message-State: AHQUAuaY4DgDwcNXsNzf18RZOaxOWsK5fvUwP616LkMcqKiXCadS/uPt
        BmCMk61gNM8uLvzZgmSe1HGEgSvqN4l3kX1Bhlo=
X-Google-Smtp-Source: AHgI3IbCgOgibb/koP16+oDrpuCQ469iLh3tkMAZO04amyW+dfxItDgk4qHX2Q5JoLX3BbpKkUQiWVydQY65zxP1ZNA=
X-Received: by 2002:a2e:999a:: with SMTP id w26-v6mr13874077lji.169.1549891800399;
 Mon, 11 Feb 2019 05:30:00 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207170047epcas1p42d7ec4acfd976871c676efa5aecb33bc@epcas1p4.samsung.com>
 <20190207170028.720-1-s.nawrocki@samsung.com> <20190207170028.720-2-s.nawrocki@samsung.com>
In-Reply-To: <20190207170028.720-2-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 14:29:49 +0100
X-Gmail-Original-Message-ID: <CAJKOXPe5wbmKQ6bKSWL9Mxjfk_PBzQ34J-TtBGKgJe-dJ6dwEg@mail.gmail.com>
Message-ID: <CAJKOXPe5wbmKQ6bKSWL9Mxjfk_PBzQ34J-TtBGKgJe-dJ6dwEg@mail.gmail.com>
Subject: Re: [PATCH 01/22] ASoC: dmaengine: Improve of_node test in dmaengine_pcm_request_chan_of()
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
> Currently when of_node of the "PCM" device is null
> dmaengine_pcm_request_chan_of() function will bail out, including cases
> when custom DMA device is intended to be used.  To have the channels
> properly requested when custom DMA device is provided extend the of_node
> test to also consider dma_dev->of_node.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/soc-generic-dmaengine-pcm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
