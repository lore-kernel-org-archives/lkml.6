Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D271CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C75213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r1QwKEFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfBZIS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:18:56 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:43051 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfBZISy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:18:54 -0500
Received: by mail-ua1-f67.google.com with SMTP id g1so189812uae.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 00:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rpQJJvJhMEcukqYqLZ4ss2G6uwgx5UKMxTfBDTBRky8=;
        b=r1QwKEFxFlB9R/xD8FQjRicovSpncKn4df5RdZeMjV8BLKrmFuhqjTnjl43eDv3bky
         +V/UyyhG6HBNcAxVR6rYfUEKHkGI+e3HrQsLCSVhhjjy16dNvbDmT+um3ZU4hKXld3Dz
         sv13Y+zUp9X/1YOnNhDuqblnoIpXQB0ieHk23eI3PM2xlhqp9RcjKe8RKGOStvbbIJfQ
         SU07Zf3NDE9f1lXajemhf0k8OnfYdLYZ95Fy53Q20XDJBAqiYwvsQgxDePOLiwmRA9/l
         F9Hk6zMvTvd5La8T6hw4aUwQ/Z8na5PFtMN+6wIMWu3BKNbiuut8vdkW9BPR6a9E/N2+
         nPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rpQJJvJhMEcukqYqLZ4ss2G6uwgx5UKMxTfBDTBRky8=;
        b=Kyx9S40ht3fhALoMWXASvjnH+B8N+jdnyz1WO7s0t5EmF3cgN2eUwVtFkpTlA05g7X
         vHOpLvolI6lpzIPP8TzJcB+bNcFfJg6OS9Sj8DxlKJyjtBj6PoOHa9rH8RvItqoRP7C4
         rBeRlDIm6D8aGs3azHz2ffonlt8bQlkn2fbQnIivpWMZjsKWJUlPfxeAcqdimzqH3fy+
         vL69yAHq4+2oKaiUqccg6IooTt6APs1hMT8U1XLTFyY9CENgMNOtUYKi3CEcXZaydiX1
         pHYyBF8/gN5TBVL7lc8YTmAyAwxNKBS0416b20QgTq7JZvE+F6REVrO+Afcf/0NuEZyX
         mJoA==
X-Gm-Message-State: AHQUAua/4I2yYyymWoBkqVP5e4j1+RPzUVMo9CkWhlxvLPJnOamLuvSe
        6fVatVImKm2XNW6I7cblDWwXuwtPlDMp6z0gH+fgYA==
X-Google-Smtp-Source: AHgI3Iav/ubVoPHwX2M1qfj2G0MCq62TAIsLFAhr+5uBYU7lkLeKs8c5PSAqS+SSu299Zvfc/HZyRAQ5BBe1Tb+fAVE=
X-Received: by 2002:ab0:3484:: with SMTP id c4mr11323250uar.39.1551169133226;
 Tue, 26 Feb 2019 00:18:53 -0800 (PST)
MIME-Version: 1.0
References: <1550210375-32270-1-git-send-email-chaotian.jing@mediatek.com> <1550210375-32270-2-git-send-email-chaotian.jing@mediatek.com>
In-Reply-To: <1550210375-32270-2-git-send-email-chaotian.jing@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Feb 2019 09:18:16 +0100
Message-ID: <CAPDyKFq8FQLhbuDYsuV3nJ9pgLYFwaE3smPgkBO3VPsrAQF7cQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: core: do not retry CMD6 in __mmc_switch()
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Avri Altman <avri.altman@wdc.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Hongjie Fang <hongjiefang@asrmicro.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 at 06:59, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> the response type of CMD6 is R1B, when the first CMD6 gets response
> CRC error, do retry may get timeout error due to card may still in
> busy state, which cause this retry make no sense.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/mmc_ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 9054329..c5208fb 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -562,7 +562,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>         if (index == EXT_CSD_SANITIZE_START)
>                 cmd.sanitize_busy = true;
>
> -       err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
> +       err = mmc_wait_for_cmd(host, &cmd, 0);
>         if (err)
>                 goto out;
>
> --
> 1.8.1.1.dirty
>
