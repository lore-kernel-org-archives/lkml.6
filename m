Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9C8C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4B5222A5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899301;
	bh=aaTIyMPpbtHJN2ggKbIZIuCrxOPfpe5vSfIs9xNDyyU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iehTC/KptvU83UhD+8ag4DTCDfoppDoPemaUTKg5PqJbjlTpTXVNpOXpApLW3a4bs
	 G65Uj0FyoTlk1b7R+YVfVzhjzs6mbxRtmh7SSi2o9vCHtIaEFLdn/IDvi/nd3NBIWK
	 FTuITRUnq3EBBypQ0+j/FfyE+UgTLYCEHtVz2yJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbfBKPe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:34:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbfBKPe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:34:57 -0500
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD847222A4;
        Mon, 11 Feb 2019 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549899296;
        bh=aaTIyMPpbtHJN2ggKbIZIuCrxOPfpe5vSfIs9xNDyyU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x3/n2ieqJST5b9geYwKyeE/wN7aSIzyiPDAZBkjAXLujBzI7r8txHY2+1DW+BCpVN
         NEwH762w1qDh1lyFwzM91GYiEwkVrVxbmTKajQfcKut9iCSAtaSMKWgAR5Z2G1K/4T
         4UpiA4dEoReE8AJs+sMusdezbykcTJsDspnbQBxY=
Received: by mail-lf1-f48.google.com with SMTP id q11so8097788lfd.3;
        Mon, 11 Feb 2019 07:34:55 -0800 (PST)
X-Gm-Message-State: AHQUAuZKQsf8gAEVhCiOSgMjsh616rTQpnL4XmcFmCx7E5hp5ZCdCaEl
        sI6bKOCOnG12JE3LhlHUvyHY0e+ZfmUdf/Ku5mg=
X-Google-Smtp-Source: AHgI3IYstw74rZcXJYSLyNakJKHHrdB/0wnupV7v0Gx8AyZ1pLfWT79e93ECwGLZhdr7bceidIsaLpRgkoDxlXmDP6w=
X-Received: by 2002:ac2:4291:: with SMTP id m17mr19914293lfh.20.1549899293846;
 Mon, 11 Feb 2019 07:34:53 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207170145epcas1p465da0715aa629b525c17d263c1b49a68@epcas1p4.samsung.com>
 <20190207170028.720-1-s.nawrocki@samsung.com> <20190207170028.720-18-s.nawrocki@samsung.com>
 <CAJKOXPehfWHW+Mj=xZ_N+LA7nLUnOvHAwqEmBECquzVSx1ppPQ@mail.gmail.com> <c60fb7b9-8847-7e68-2ef4-4dbbfb48e71a@samsung.com>
In-Reply-To: <c60fb7b9-8847-7e68-2ef4-4dbbfb48e71a@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 16:34:42 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcX7VgWhMbTLyoOg_1A-RK0pmJ9jPh-raSaigZDQ4J1jA@mail.gmail.com>
Message-ID: <CAJKOXPcX7VgWhMbTLyoOg_1A-RK0pmJ9jPh-raSaigZDQ4J1jA@mail.gmail.com>
Subject: Re: [PATCH 17/22] ASoC: samsung: odroid: Add support for secondary
 CPU DAI
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

On Mon, 11 Feb 2019 at 16:19, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> On 2/11/19 14:57, Krzysztof Kozlowski wrote:
> >> static struct snd_soc_dai_link odroid_card_dais[] = {
> >> +       {
> >> +               /* Primary FE <-> BE link */
> >> +               .codec_name = "snd-soc-dummy",
> >> +               .codec_dai_name = "snd-soc-dummy-dai",
> >> +               .ops = &odroid_card_fe_ops,
> >> +               .name = "Primary",
> >> +               .stream_name = "Primary",
> >> +               .platform_name = "3830000.i2s",
>
> > Why exposing address as platform_name? I think it is not used so how
> > about some friendlier name?
>
> This entry is for selecting "PCM" (DMA) component for the link.
> For proper matching we need to use names of devices for which
> the dmaengine based PCM component is registered (with a call to
> samsung_asoc_dma_platform_register()).
>
> We can't use platform_of_node because 2 PCM components ("3830000.i2s",
> "samsung-i2s-sec") are now associated with same DT node.

Thanks for explanation.
With the unneeded empty line fixup:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
