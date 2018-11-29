Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27040C04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7E2213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="O0SG9DMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7E2213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388815AbeK3BgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:36:04 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54605 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388794AbeK3BgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:36:03 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so2931469ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 06:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xk1badHB3Pszc/2Ox5HABkhqz2zqm/wifQJVGrgvRpo=;
        b=O0SG9DMkSPtIy0zynzHlzK6BMkPbTZojrCEAHz0Ylj7Tx65Tsb1hctHTqP0qzwc8Xz
         gS7UzgbV1rng80gss0sfMwXl3JiuLBjREjwumylgofUdHK3hWZ7BWI9cByfM1/APHvEb
         DaDJd/o0M+Cx0Sr7VnZMuVtUiAdsMMHJkC+L77Lw3Ik3vobp/meJhTgt7k4opJVVXU85
         6KKrovk0FIJ/DrltnrFeVptBqxftw+YT8K/XIpUOV13Z/nDt20KdZvLvJOaWigh8VNSM
         EMJxZSWCooyA1IsriqXwAeTgaAQPIBXVVuC4zmX9s63qR6MWMlz0blAI75xi5q4gDqyj
         UfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xk1badHB3Pszc/2Ox5HABkhqz2zqm/wifQJVGrgvRpo=;
        b=nNPcsoDTlRi1gFmvarng5R8dZpG0/j7ktG0g28pbGJqfOlHWmlKSNHVPF4LuBx6HKu
         2Klo2fJhAOnmqGQl+B20rAjLGwc/4hVKo/aNAnB+nmHgoZulw7Z5d/Zj9FARr+Rl81qB
         7Dlr6teDcpqEON4KWwGcRqF6vT2F8rIV5jOUj0F/XEYvGf9xWqm9EyeadC3QVcqzsjvV
         3zCwUX3+DXpS/fgqa8DJr+PBvxbv8iTGskBZaSxpph1Z+8OyWIQ87nBvatobIXYRZDfB
         PstlHDqlRVxMCJCIzZ09g00CX3zZSR7uLiyGzDPazYRexOwmg59EAhivj00P7H0z1IlR
         o5WQ==
X-Gm-Message-State: AA+aEWbI9tc4PBx0yVyG90HXvYCg9DI4ldQAONCdFTg35ZxOdsLVKSpm
        fbFF6mDMjf2Z3KXmi6H3AfHp318rYOox/wcJQqcp0g==
X-Google-Smtp-Source: AFSGD/VUpxgInhXynMpn41v3GxzxitNT2hP/9OFdvz1GVurfHnJp8h6iqVPje1/B328Ks76eeeF9ru1VSNfs3RrRy5s=
X-Received: by 2002:a24:7284:: with SMTP id x126mr1787531itc.96.1543501830394;
 Thu, 29 Nov 2018 06:30:30 -0800 (PST)
MIME-Version: 1.0
References: <20181113140133.17385-1-brgl@bgdev.pl> <20181113140133.17385-2-brgl@bgdev.pl>
In-Reply-To: <20181113140133.17385-2-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 29 Nov 2018 15:30:19 +0100
Message-ID: <CAMRc=MeRJ60gcYz00C828PBqnEdC-9onOKOadfackdzHiC1WOA@mail.gmail.com>
Subject: Re: [PATCH v2 01/25] nvmem: add new config option
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 13 lis 2018 o 15:01 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a=
):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We want to add nvmem support for MTD. TI DaVinci is the first platform
> that will be using it, but only in non-DT mode. In order not to
> introduce any new interface to supporting of which we would have to
> commit - add a new config option that tells nvmem not to use the DT
> node of the parent device.
>
> This way we won't be creating nvmem devices corresponding with MTD
> partitions defined in device tree. By default MTD will set this new
> field to true.
>
> Once a set of bindings for MTD nvmem cells is agreed upon, we'll be
> able to remove this option.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/nvmem/core.c           | 3 ++-
>  include/linux/nvmem-provider.h | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 9b18ce90f907..ac7971e8154e 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -604,7 +604,8 @@ struct nvmem_device *nvmem_register(const struct nvme=
m_config *config)
>         nvmem->priv =3D config->priv;
>         nvmem->reg_read =3D config->reg_read;
>         nvmem->reg_write =3D config->reg_write;
> -       nvmem->dev.of_node =3D config->dev->of_node;
> +       if (!config->no_of_node)
> +               nvmem->dev.of_node =3D config->dev->of_node;
>
>         if (config->id =3D=3D -1 && config->name) {
>                 dev_set_name(&nvmem->dev, "%s", config->name);
> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provide=
r.h
> index 1e3283c2af77..e53545e9852b 100644
> --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -30,6 +30,7 @@ typedef int (*nvmem_reg_write_t)(void *priv, unsigned i=
nt offset,
>   * @ncells:    Number of elements in cells.
>   * @read_only: Device is read-only.
>   * @root_only: Device is accessibly to root only.
> + * @no_of_node:        Device should not use the parent's of_node even i=
f it's !NULL.
>   * @reg_read:  Callback to read data.
>   * @reg_write: Callback to write data.
>   * @size:      Device size.
> @@ -53,6 +54,7 @@ struct nvmem_config {
>         int                     ncells;
>         bool                    read_only;
>         bool                    root_only;
> +       bool                    no_of_node;
>         nvmem_reg_read_t        reg_read;
>         nvmem_reg_write_t       reg_write;
>         int     size;
> --
> 2.19.1
>

Hi Srinivas,

if there are no objections - can you Ack this patch for Greg to pick
up into char-misc?

Bart
