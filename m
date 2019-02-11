Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC524C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81FD20855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549891887;
	bh=AubNKqkR3NsU69Mh/b1UeTCxxDLIzfLAUv33tRMJkKU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NP3L+9m7laePHYzrq3dkfQOPYIPTf+qSAqp/Y3Ug9eqrwfEmY9qx8EtaM2xIEBaE6
	 bpqx9pDcmhJ8l5t5MHuLFM/SemgRecpOsyjh2ynOEiQwEDNgKHC0Lia6kJdvpt7uIZ
	 jLf5bfw1rz4YN4F0XSTUjVLZiuPUq3LtGpS3RXn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfBKNb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:31:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:33130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727373AbfBKNbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:31:25 -0500
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B3D921B1C;
        Mon, 11 Feb 2019 13:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549891884;
        bh=AubNKqkR3NsU69Mh/b1UeTCxxDLIzfLAUv33tRMJkKU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xJNGGnwc3YBF0eWWZmQMh5uV12RwiI/CkgV+kLlIYfS5suvbAMw+i6x8Vxf5Q0f+P
         W0pmGDvbi8H7STZnJk7ZoMXyetTrnLpxA4YreMe0nbJ1xJOmPaHQsajAKhSjtu2i1/
         T7E4JUNh2DNmt5VjmlSZTDR28jTuCq88U3GWMHHk=
Received: by mail-lf1-f51.google.com with SMTP id g2so2449407lfh.11;
        Mon, 11 Feb 2019 05:31:24 -0800 (PST)
X-Gm-Message-State: AHQUAuaXDP8o+iirlLE8yoTP3uN1CXNO+InTk2t6TbyxrZQrJO5+JThA
        WQyIEWd3OztCxa55uraiXR427LY82F60hM3lhQM=
X-Google-Smtp-Source: AHgI3IbjtHqDoemHGDBOBiByOjAJJOYXcfZDd6E4RbAWHnKlgLrESwWkk7AMjIYlJNYf3JdzJectSEEsVzP1QHd3iRw=
X-Received: by 2002:ac2:4194:: with SMTP id z20mr10799901lfh.74.1549891882726;
 Mon, 11 Feb 2019 05:31:22 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207170051epcas1p37a1acaef52cffb01af00c8d34dd9b1dd@epcas1p3.samsung.com>
 <20190207170028.720-1-s.nawrocki@samsung.com> <20190207170028.720-3-s.nawrocki@samsung.com>
In-Reply-To: <20190207170028.720-3-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 14:31:11 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfG8=n932bg99iQ2BqvA6rCOPpv1YD+Jajx=NxyN_+Mkw@mail.gmail.com>
Message-ID: <CAJKOXPfG8=n932bg99iQ2BqvA6rCOPpv1YD+Jajx=NxyN_+Mkw@mail.gmail.com>
Subject: Re: [PATCH 02/22] ASoC: dmaengine: Extend use of chan_names provided
 in custom DMA config
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
> There are currently two ways to specify custom DMA channel names:
>  - through the SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag and
>    snd_dmaengine_dai_dma_data data structure,
>  - through chan_names field of struct snd_dmaengine_pcm_config.
>
> In order to replace the DAI DMA data method with the custom DMA config
> one on non-DT platforms the dmaengine_pcm_new() function is extended
> to also consider channel names specified in the custom DMA config.
> If both config->chan_names and dma_data->chan_name are provided
> the former will be used.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/soc-generic-dmaengine-pcm.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
