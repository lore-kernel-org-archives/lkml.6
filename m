Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7CFC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A79222B0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549893830;
	bh=++RS32vRM3e/10bZXaBWOi/LcMOGKgSe/Nt53+LIUfg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YaoIhQGFcQT4zAa5Ba/0HIkG8ja98XEdCS0elpBKqv1sG9KbN5Tu2cfFLSW2vC5SX
	 rohRs6exUq9VKCOpOXwQFWV+OAy9I5QuQczviwwK9ztB4mKt+4WpQ8NWwEQ/7VnWTW
	 gSzdFBIFRlwp8isN30daQcuy1WCazNMKnnvLacTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfBKODt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:03:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:48444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfBKODs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:03:48 -0500
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93C1F222B0;
        Mon, 11 Feb 2019 14:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549893827;
        bh=++RS32vRM3e/10bZXaBWOi/LcMOGKgSe/Nt53+LIUfg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LgHby4be4T5zQoY6ZWoPiAk+DMLgBD3BvcM2ioshbJ6piJtt8PPDRTumDuYD7alGt
         kHvZlWtEO/wmtaQK3czFh1aNC6i/1bnNFqI6ZAdtgzb5E52bapfRSztSMG/mlrz5jM
         V2AKrOo5WjlUibIVYV1bxyXHv2TjD0A8OBt1YxSs=
Received: by mail-lf1-f42.google.com with SMTP id t14so7819002lfk.7;
        Mon, 11 Feb 2019 06:03:47 -0800 (PST)
X-Gm-Message-State: AHQUAuY1e4hm3mfNE9aijiTd13QL8kiQpYy7F72oaYwjveyE0w2fkE5g
        4iNAkrb3eEiocbTPMsJe5YYLFgNtOZdjH5gERLY=
X-Google-Smtp-Source: AHgI3IayaOSbTQrDDazSE5aL4S0IpET9bRcAKnr5CLcrHqoXBn/ECsAMfPpUSETuggJShw8KDjz/GmSPcQts49Xvj0Q=
X-Received: by 2002:a19:9b50:: with SMTP id d77mr21282955lfe.137.1549893825777;
 Mon, 11 Feb 2019 06:03:45 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207170152epcas1p254264a82287a54dc2452f5e73daab13d@epcas1p2.samsung.com>
 <20190207170028.720-1-s.nawrocki@samsung.com> <20190207170028.720-20-s.nawrocki@samsung.com>
In-Reply-To: <20190207170028.720-20-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 15:03:34 +0100
X-Gmail-Original-Message-ID: <CAJKOXPf05pfa-9aUGPvGa8Y7dcmPAP8Szcdbs1aUfm2tnfmArw@mail.gmail.com>
Message-ID: <CAJKOXPf05pfa-9aUGPvGa8Y7dcmPAP8Szcdbs1aUfm2tnfmArw@mail.gmail.com>
Subject: Re: [PATCH 19/22] ASoC: samsung: Drop DAI DMA data chan_name assignments
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
> There is now no need to pass DMA channel names through the DAI DMA data,
> custom DMA config of the PCM is now used for this purpose.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c         | 4 ----
>  sound/soc/samsung/s3c2412-i2s.c | 2 --
>  sound/soc/samsung/s3c24xx-i2s.c | 2 --
>  3 files changed, 8 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
