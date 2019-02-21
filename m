Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB147C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8078E2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fe1FzOC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfBUWL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:11:58 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:37321 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfBUWL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:11:58 -0500
Received: by mail-vk1-f194.google.com with SMTP id 17so51979vkf.4;
        Thu, 21 Feb 2019 14:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wh9U7l2j1lF38xxfqEcbjWAI0IpOW2YbfcsENlJfd0g=;
        b=Fe1FzOC+/S+BB2b3eh4mAJQwaarfwrVsOjI3D8WBa9mnbivNI4GIHRGyQ571mlCDci
         Ea2/mBvu2GjS09IsOcl9xG5bbJi1pqvYB7Hu7Abmyhz+/gfBAIH1YnJ+u54Gxv8rWhup
         Pns3toG+Z95EyKYlGKSA05TfrR3A01sMONBnKZLYEEsjt5h/DwRBPTwRhmliC7nGUpeU
         bNtyx40w9oeV7x1h1g+nVV8c4dEuymyMfE/Dd8ZH8+rnotqsSdriZKgQ+N2BRTiAtv2C
         eCRZW4Kt5qvx28Ns47v+Hw+1aclHmXNVcMlnP60J75rgwVkPQXbBBHHFw4BSFVGARU72
         mRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wh9U7l2j1lF38xxfqEcbjWAI0IpOW2YbfcsENlJfd0g=;
        b=UAj83//uAZQb2F0znPqD+OPF6J9oajPNOcvA0+scHv17JjHs6FJmjN3GL1QTD+dLYu
         26j8o69xDDxdI41V4ycEUdMafOzz1qDK4ny3pAHoNHl0t6IfzzcbOuBlBwP1Nc2GQxsj
         VDQSknxMZC4Tbi5XxAPOQ5zZIp6c5Q3RPAGKTdGU0Jmv3M+LZOJgnfBLW+FAdl0H3O2M
         e1dH7NgUGx5Yc5OrvtUAgsbcBY4P3CFc9Mr9bBTGwBrYom6rF72Ll9Z4kc0VoIvUxDhe
         gKBIz0l+Z4gglazhGWwb7PobNO+IEjqezWMObLv9XNOK+/ma/DomLSCtAFvGtgFwzjMM
         0apw==
X-Gm-Message-State: AHQUAub7ogr7E4k0KwNTGOb+4OqKncvnu21VuIjl8mr0ru5DiLYw89sG
        n68C3ayRGKBU+HC5VoPrf3Avf0HfAQV709qbvC8=
X-Google-Smtp-Source: AHgI3IbG/6xU+POecLDpsL+u8zJXLiySZFAq/5jRIehhFfkVqP0pAqeGNmCfJxe9E7KSlmNJtRtgwF8Lx2CmWppUGcE=
X-Received: by 2002:a1f:ccc4:: with SMTP id c187mr512979vkg.90.1550787117160;
 Thu, 21 Feb 2019 14:11:57 -0800 (PST)
MIME-Version: 1.0
References: <20190221033851.70331-1-yuehaibing@huawei.com>
In-Reply-To: <20190221033851.70331-1-yuehaibing@huawei.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Fri, 22 Feb 2019 08:11:02 +1000
Message-ID: <CACAvsv7C2pbruAOGM_8f3yyzxhvCgQoKARRRkTzJenEwYc0zTg@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH -next] drm/nouveau/dmem: remove set but not used
 variable 'drm'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, nouveau@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 at 13:41, YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/nouveau/nouveau_dmem.c: In function 'nouveau_dmem_free':
> drivers/gpu/drm/nouveau/nouveau_dmem.c:103:22: warning:
>  variable 'drm' set but not used [-Wunused-but-set-variable]
>   struct nouveau_drm *drm;
>                       ^
Thanks!  Merged.

>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_dmem.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index aa9fec80492d..900a302b7ce9 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -100,12 +100,10 @@ static void
>  nouveau_dmem_free(struct hmm_devmem *devmem, struct page *page)
>  {
>         struct nouveau_dmem_chunk *chunk;
> -       struct nouveau_drm *drm;
>         unsigned long idx;
>
>         chunk = (void *)hmm_devmem_page_get_drvdata(page);
>         idx = page_to_pfn(page) - chunk->pfn_first;
> -       drm = chunk->drm;
>
>         /*
>          * FIXME:
>
>
>
>
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
