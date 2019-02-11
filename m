Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EEBC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3815321B69
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549892520;
	bh=rAPERFKmoLN3QF0cnAPRk4JfXHaAIiWPT6FwuAmMk4g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cqnj2rAm77XuXOAcHV1FiIYjriqu4XjOGG6tyMeaeA/+R5syz63zUVd31CR1UWCw7
	 Pz8oL5zA1P9T4eMBuW8qZdLGpVEUqHhk3mkmNrHi/DtjDuBLtsjeIWFdyrnGoRa3d3
	 epTAJDADAUb/NrQ0a4LUv/zZ12mCA8AzQtpu6I4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfBKNl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:41:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbfBKNl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:41:58 -0500
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35219222A2;
        Mon, 11 Feb 2019 13:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549892517;
        bh=rAPERFKmoLN3QF0cnAPRk4JfXHaAIiWPT6FwuAmMk4g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eUMbsRbSQuRWix2hyw21Pr0BqjD6I3/gO2Gd3tSwAbCB+2ChJVrZeRoBiNgUnyaDC
         tyKcD1g7tAE8AKK6gB4odWBsqTmFxupNxe1PmBa+PKaPSaI9S8LYTKIqZGOieBmD3c
         TpzKCrV3b16QAUJs3/hyKkUuPf49EUi+3jt0JG5o=
Received: by mail-lj1-f169.google.com with SMTP id o1-v6so2932182ljc.10;
        Mon, 11 Feb 2019 05:41:57 -0800 (PST)
X-Gm-Message-State: AHQUAubuol9z+sNI8wmhRcrUPGsMdJJ2z5UrOWQaYwjeIIbmkJidlAyX
        U18uJj+Xmoe2EHMu/hklf2DMJmwAVHp48ot5F/4=
X-Google-Smtp-Source: AHgI3IbPtoEx8Uo0UE42dOUPanqOipLR81/jh8k8faOGkT7MCwtzJgWT0pDjoz8D169tG6IuWysMEGlMKUGmMGrGHng=
X-Received: by 2002:a2e:7615:: with SMTP id r21-v6mr17581357ljc.131.1549892515403;
 Mon, 11 Feb 2019 05:41:55 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207170109epcas1p20929934c01ae67a05cd6a56f13ed8486@epcas1p2.samsung.com>
 <20190207170028.720-1-s.nawrocki@samsung.com> <20190207170028.720-8-s.nawrocki@samsung.com>
In-Reply-To: <20190207170028.720-8-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 14:41:44 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcutYaBEvRE8JwnnjG7_UB81y8dgSBiKmwCazERWkmBYA@mail.gmail.com>
Message-ID: <CAJKOXPcutYaBEvRE8JwnnjG7_UB81y8dgSBiKmwCazERWkmBYA@mail.gmail.com>
Subject: Re: [PATCH 07/22] ASoC: samsung: i2s: Move clk supplier data to
 common driver data structure
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
> Having the clocks provider data in struct samsung_i2s_priv, i.e. per the I2S
> controller instance, rather than per CPU DAI better models the hardware and
> simplifies the code a little. The clock provider is common for both DAIs.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c | 68 ++++++++++++++++++++---------------------
>  1 file changed, 33 insertions(+), 35 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
