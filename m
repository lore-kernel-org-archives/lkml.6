Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2C2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADBE20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFBZjcuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfAQKES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:04:18 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42448 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfAQKES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:04:18 -0500
Received: by mail-ed1-f66.google.com with SMTP id y20so7840773edw.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 02:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TERpxjh2yJAbosjLOgxFJErb2g+VCA0i7onwsxlISzA=;
        b=LFBZjcuJldeJ+0gZPMT7rNCCZMNZPPkikeQQLcCDodpNnP0edNwMhFY6cnoe1Kwiyc
         k/+Tc2g7YoWrVlpPfuONkYQkVGmnNVgzmzLo0kr9QtXUQXTqZ8t7OdTpvfPEYv9ueDaK
         oU9/hnANaBn5MCKnnS2hFxE6FGgnFOl2su1wHpGGoCi30bKaFFyqdsrJ5+2V2b6Ibbh1
         6jh6oVd7tgWJqQ+GMyi7HhVd8eJHUfCVLxlMUwFZ0GpgZeCSRmPrsOap7UkNhGV21FYs
         Dg9cCxgzEEu1X5ZyyUJr3JVNzf5Dl2VYTertZSowcvQUH/d4R2Um9bIdhdK7nKPqffc0
         yuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TERpxjh2yJAbosjLOgxFJErb2g+VCA0i7onwsxlISzA=;
        b=PTz43F8xom4szunuAV+uTVGnYDB2OVWXct9KhGhqlHwishMEhrOBBErl5bySpEFkCl
         PE9lVCfeMNJiTDQSpFlCj137P4qUchpE4ybCC4H7Ey31hC43xgW0dDLVeVO6+jGcNJyJ
         N7odXAXj36ADPaZuMtDybpgQNPaP5JES1wB3mx3jhuoFILTre1SZ5EKayLJGYqu5KdM2
         9ra38PHg0o1c7wLCgsKbk2hXqCevIlAxZ884GEgF4D9pk4GhmShzBSQ9OFkf3jB+jciE
         STmSjbuctqyTIYLKPW8W5jJ80TX0gE6CApFyYQe6V6HPqc5XlunGAVY5pxICBgJGn8rH
         TxgA==
X-Gm-Message-State: AJcUukdU7I/RlmclZfHZTc9KHRBybTesN6uMZuiOYGs7D20ApmjtRuYr
        tTmz/ctZDCGJ0DH0XVi1rf0ychFw+0lZEelqOfE=
X-Google-Smtp-Source: ALg8bN5J14XHnl7ylxEO2IGpT5uPzfxr/+RRpF5eo9ZxDt3fg5d3kn99nIApeIDLZ5wCif+fB6bFo1C5+PoyIrzvCwc=
X-Received: by 2002:a17:906:a4cf:: with SMTP id cc15-v6mr10145908ejb.157.1547719456482;
 Thu, 17 Jan 2019 02:04:16 -0800 (PST)
MIME-Version: 1.0
References: <20190117090640.12972-1-stefan@agner.ch> <20190117090640.12972-4-stefan@agner.ch>
In-Reply-To: <20190117090640.12972-4-stefan@agner.ch>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 17 Jan 2019 12:04:05 +0200
Message-ID: <CAEnQRZDUYGnU5+G0jd_o0yH4qYjrWtdPEB7O4TfMvtpYzJPO1Q@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 4/5] ASoC: imx-sgtl5000: put of nodes if
 finding codec fails
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
> Make sure to properly put the of node in case finding the codec
> fails.
>
> Fixes: 81e8e4926167 ("ASoC: fsl: add sgtl5000 clock support for imx-sgtl5000")
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

> ---
>  sound/soc/fsl/imx-sgtl5000.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index e1e20499b2f1..45969e6dfad7 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -111,7 +111,8 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>         codec_dev = of_find_i2c_device_by_node(codec_np);
>         if (!codec_dev) {
>                 dev_err(&pdev->dev, "failed to find codec platform device\n");
> -               return -EPROBE_DEFER;
> +               ret = -EPROBE_DEFER;
> +               goto fail;
>         }
>
>         data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> --
> 2.20.1
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
