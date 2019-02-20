Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D3AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72731206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpnDNcbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfBTL2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:28:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34047 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfBTL2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:28:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id f14so25632481wrg.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 03:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F4ICaJeOBdNFj5gCOb4Q75EVYo2uvn8OonFjbnourE8=;
        b=gpnDNcbE+7Myn9x89vCWfnM55yxcgW6jHJBLUNZd3XkKi0o0YeprkEaDdVUW9huiIZ
         7SIv8Rt8K0F88sGRewAx4ilYrlf95E46mKTdMcDTJDvOg9f7Tj6g+Bgzfsb/CqClHJBs
         REYTteHKdmXelX0tlOwqrrCRPcKMIDE5xArV8r/+nVz6ZCC5eH82bs3DP14+TC8rDXIs
         1HSNhvG215mhR9Ja8hRNY2au+ZukAGD3aB3A6KLSe/sDPho/RDZAEIn00eZFHKGOY/Ky
         8mMzfpWQyD3F6c2Ux0Dk+sRmqtpFrV36SNKLbi6t48BCtz/F3aI5fJtbWD8IFiZrc90w
         yQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F4ICaJeOBdNFj5gCOb4Q75EVYo2uvn8OonFjbnourE8=;
        b=RuQ1/9GaMHjuuWozE2XwYFKmtGA6Fa6+GlMxhwMx0JfyVEDZXckKAsetZWAke7MXSV
         /0o1Zjaw8WkiDv73lDhHkqXIqoYrIAZv4oTtS6are+it/vSJNtoRPS8615rLTYPUUV+G
         u0+1lcZfTKpM+YT2AlofhX/H9Tx1Z81eASIv1bqZY7g8EdiQ33TZBITjM4KS9QpcNgql
         qNwWzqj0fzScf2okphUAHXQ9EdecnoqjtaO8Klls8noJWDgz4sJJ6EXPjx983O9ZVqwj
         A7zD9L8Ai40PI+y/BaDXfxnA6MlTI0CNNvX94xm0sqRUpK7gObmVS0+Q2nntLlqBQfbz
         QKhg==
X-Gm-Message-State: AHQUAuaGcxpLNjYUvAaHVJwWzQsJ4vIoA874Q8q+/h8S2DbT9gJryXNV
        q/ncJ/Gsa1JVzrnAQycpNOMll1TCFGJenv2fEMI=
X-Google-Smtp-Source: AHgI3IbeQqsZU0HVcfUtqYBnJi+TjlPPxk80QR9y6r0t/HeMDxX9X6IWPvlTbAN70/TivqxFcclVC5y+1XGCEa1Tebg=
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr23787941wro.255.1550662082214;
 Wed, 20 Feb 2019 03:28:02 -0800 (PST)
MIME-Version: 1.0
References: <20190220051754.12195-1-thirtythreeforty@gmail.com> <20190220051754.12195-6-thirtythreeforty@gmail.com>
In-Reply-To: <20190220051754.12195-6-thirtythreeforty@gmail.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Wed, 20 Feb 2019 12:27:58 +0100
Message-ID: <CAOiHx==WUZ49OOdJp=S1pF8y4Mf0Hc+xAOu1n9Ofmoau0KCBTQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] staging: mt7621-mmc: Use pinctrl subsystem to
 select SDXC pin mode
To:     George Hilliard <thirtythreeforty@gmail.com>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-kernel@vger.kernel.org, Neil Brown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 at 06:18, George Hilliard
<thirtythreeforty@gmail.com> wrote:
>
> The driver previously grabbed the SD pins for itself, ignoring the pin
> controller.  Replace this direct register access with appropriate calls
> to the pinctrl subsystem.
>
> This also allows this driver to work on related devices that have a
> different pin controller mapping, such as the MT7688.  The hardcoded
> bit index was incorrect on that device.
>
> This change could break SD controller functionality on existing devices
> whose device trees do not specify a pin controller and state for the SD
> node.
>
> Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
> ---
>  drivers/staging/mt7621-mmc/sd.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
> index a7c7ec0d7bbb..97ed7510e96d 100644
> --- a/drivers/staging/mt7621-mmc/sd.c
> +++ b/drivers/staging/mt7621-mmc/sd.c
> @@ -38,6 +38,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/spinlock.h>
>  #include <linux/platform_device.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/interrupt.h>
>
>  #include <linux/mmc/host.h>
> @@ -1599,6 +1600,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         struct msdc_host *host;
>         struct msdc_hw *hw;
>         int ret;
> +       struct pinctrl *pctrl;
> +       struct pinctrl_state *pins_default;
>
>         hw = &msdc0_hw;
>
> @@ -1671,6 +1674,25 @@ static int msdc_drv_probe(struct platform_device *pdev)
>
>         host->mrq = NULL;
>
> +       /* Read pin control settings from device tree */
> +       pctrl = devm_pinctrl_get(&pdev->dev);
> +       if (IS_ERR(pctrl)) {
> +               ret = PTR_ERR(pctrl);
> +               dev_err(&pdev->dev, "Cannot find pinctrl in device tree\n");
> +               goto host_free;
> +       }
> +
> +       pins_default = pinctrl_lookup_state(pctrl, PINCTRL_STATE_DEFAULT);
> +       if (IS_ERR(pins_default)) {
> +               ret = PTR_ERR(pins_default);
> +               dev_err(&pdev->dev, "Cannot find pinctrl state default\n");
> +               goto host_free;
> +       }
> +
> +       ret = pinctrl_select_state(pctrl, pins_default);
> +       if (ret < 0)
> +               dev_warn(&pdev->dev, "Cannot select pinctrl state\n");
> +

Selecting the PINCTRL_STATE_DEFAULT is already automatically done by
the driver core on probe time[1], before calling the probe function,
so this seems redundant here. The only difference is that you enforce
the presence of a pinctrl node, while the core code is fine without
one.


Regards
Jonas

[1] https://elixir.bootlin.com/linux/latest/source/drivers/base/pinctrl.c#L21
