Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C8BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F9C214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bDlqugS0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbeLRGzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 01:55:19 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44220 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRGzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 01:55:18 -0500
Received: by mail-vk1-f195.google.com with SMTP id h128so3430936vkg.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 22:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+3zlcXcLX3wHkeBoeuBfBB+LXxD6cKgLYC1CPYedmg=;
        b=bDlqugS0zKijL5fR/Nfbm9VlmFtE/Mad8fTgHqoTj3NUWXmKlJ2rUv9igF911mVsDo
         f91Law8zuYW3Qg5j7J0Wfr5vfHx+MVODGSfft48p7piEdXbG8OPRvXqBjLpxX38UQuXC
         lHH4Ff2tWbJOaFsstuGVy7HKGXcBVJ6ptw/OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+3zlcXcLX3wHkeBoeuBfBB+LXxD6cKgLYC1CPYedmg=;
        b=BqtOKw8Wyl2QN1GUaEUrZn0Jb3DwOfFXY1nQZdgxAnAdq10rMambr9M62xElTiEwqO
         +BlpFZaOZKTBhyiYSw5XlJjJA8xIo8z2uudsncG9HPDG+YWWmLPTj/cUy7lLI7aP95br
         Td1IKDZZiQqXiPa9bdYbA27kG+Wh6aagLYt2fVW7Bx7KCRxmZpr5oGkiiCzTSHUamvwk
         WOfT7dqxBaOmd2/4fRygQMn5NY57AqXjxAO5xXHe/0Bk4wLkN91Mj/SgdCcVdV7mJHGA
         GrIUDOFtRMOahwjIvUTjI5vf/o9K4VygLwIVHsmSXgbrBc/ML6Yj9lWG8jmclqjeZqBa
         Id4w==
X-Gm-Message-State: AA+aEWY1I1cRusNMYlO5orAgVDXH1GgtZ2LOo8aqqf+/02yoaAoI+4v6
        W8c8JaPpbRQuh6FBm28TJC1KrB9ul8qQ+F6Ar/ImrmNbBM+PMw==
X-Google-Smtp-Source: AFSGD/XNjC0vzZQmvwz1xbPqJXDU7p9v5m2oI/BSI6ogPC7VP6uYnK1Zy1xa+gjPK19NtmY/1KzoPHwPND8dgu3ySes=
X-Received: by 2002:a1f:7244:: with SMTP id n65mr7132506vkc.75.1545116116997;
 Mon, 17 Dec 2018 22:55:16 -0800 (PST)
MIME-Version: 1.0
References: <20181128090037.257359-1-cychiang@chromium.org> <20181128090037.257359-5-cychiang@chromium.org>
In-Reply-To: <20181128090037.257359-5-cychiang@chromium.org>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Tue, 18 Dec 2018 14:54:50 +0800
Message-ID: <CAFv8Nw+QjXdRyiRx=AOZt65PZa5FcvJaqiDq2ormRt2dpVie0A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ASoC: qcom: Kconfig: select config for codec
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org,
        Rohit kumar <rohitkr@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 5:01 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> Select SND_SOC_RT5663 and SND_SOC_MAX98927 for SND_SOC_SDM845.
>
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  sound/soc/qcom/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 2a4c912d1e484..3528c4279cbae 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -100,6 +100,8 @@ config SND_SOC_SDM845
>         depends on QCOM_APR
>         select SND_SOC_QDSP6
>         select SND_SOC_QCOM_COMMON
> +       select SND_SOC_RT5663
> +       select SND_SOC_MAX98927
This line is actually not needed.

We can drop this patch as there was another patch merged already:
https://lkml.org/lkml/2018/12/10/875.

Thanks a lot for taking a look!


>         help
>           To add support for audio on Qualcomm Technologies Inc.
>           SDM845 SoC-based systems.
> --
> 2.20.0.rc0.387.gc7a69e6b6c-goog
>
