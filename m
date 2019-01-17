Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EFEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D4A20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8/PE5a2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfAQKBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:01:54 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40331 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfAQKBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:01:54 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so7845833edr.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 02:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QJwzKcdcg0IDEcPZVYyjnbN0XcJLwhzLcPcTY/x1SLA=;
        b=H8/PE5a2nOWCXMBzcrNWb4UHZxcwl5zoV7sNU7/abjfiU2l6UyLRkKnNxcA2ejsJ6G
         lukhaM14XN1a+Mln2rM4nQ/oqLpM1NUtai8GmYz+20hCP6RuHrg40jmybPnA4wtTPp3N
         QGHu5nqe29KFO6gbimM1evXMQH4OJPBWVszeuA9jqFdet+LjVDVKj8BdDvfmdZimSNze
         6cjii4VgzkhTjxhuJ6NqTfXNJblJb3KXdgg7twlUOZxxPCicrmXczrfmGcgTxui7UfAd
         aJIX/XW7oC7Ad7TTRsfXeC7FaoT3Qo6USr7FKArEx/lyVs/0Dm8lX/OEgcgolK6kh6D6
         VXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJwzKcdcg0IDEcPZVYyjnbN0XcJLwhzLcPcTY/x1SLA=;
        b=RqyiUwRPDEd/o8tkUXz28YjKxSBf/Uw4AiIL19NYWUFHRqsJNjXQ3FzDqFsW0j3iUT
         ePGNV/udVEV8o8PSDvVHc20Ye4ujsbdznLQt9ap9614Y0nYc9jWWLSRtHZu3EWYhETXs
         mJgplTjZb0N2C12yS6jz0jDcfVrPmKclgEX0ZpSZ7VOdGgmDAkU6/rw9+TEKf/smEC2v
         SJMOO4icNdKRV3CR0lehFxoVWp9BDPOW9jnjyTVJYj/GTVQDu5TZ4uTxOPvb/BY+B0l/
         66U8xlyNSaahCduj3jp627+PN4gBeHjLVyWuZrC9nuk855Up5lt2qUfclupTZQM3273g
         yL8g==
X-Gm-Message-State: AJcUukesMTrAW4vQ2yuD/Qo/5xqhZu4cbNH5/+JBK7DDEQvQT8cTH0T1
        okWOM/96LHC7rni/50Uzr9FbksAGrlk7ursVXIY=
X-Google-Smtp-Source: ALg8bN4k6moxvZ8Q6GWChGmq2SjRsAfn7LDS8kyPIOBWTDTivDJghmJ98U3Ha1KAcwKgi9xwkv1gv8/3qKScCopRF/Y=
X-Received: by 2002:a50:81e3:: with SMTP id 90mr10842999ede.67.1547719312390;
 Thu, 17 Jan 2019 02:01:52 -0800 (PST)
MIME-Version: 1.0
References: <20190117090640.12972-1-stefan@agner.ch> <20190117090640.12972-3-stefan@agner.ch>
In-Reply-To: <20190117090640.12972-3-stefan@agner.ch>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 17 Jan 2019 12:01:40 +0200
Message-ID: <CAEnQRZDX=wzxbYpq6omMYetYqnr66yBJwXx6Ncy_L68p-UJJeA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 3/5] ASoC: imx-sgtl5000: don't print
 EPROBE_DEFER as error
To:     Stefan Agner <stefan@agner.ch>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:07 AM Stefan Agner <stefan@agner.ch> wrote:
>
> Probe deferral is to be expected during normal operation, so avoid
> printing an error when it is encountered.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

> ---
>  sound/soc/fsl/imx-sgtl5000.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index c29200cf755a..e1e20499b2f1 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -156,7 +156,9 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>
>         ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
>         if (ret) {
> -               dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
> +                               ret);
>                 goto fail;
>         }
>
> --
> 2.20.1
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
