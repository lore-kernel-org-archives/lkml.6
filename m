Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C76FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 10:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED192081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 10:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7cE1LTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED192081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbeKJToy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 14:44:54 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37243 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbeKJToy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 14:44:54 -0500
Received: by mail-qk1-f195.google.com with SMTP id 131so5943161qkd.4;
        Sat, 10 Nov 2018 02:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SoTYvTk4mjI6U7+BRCCdi+ChcEShfJMyJ6yM4Tu9F/U=;
        b=h7cE1LTOaIkq0U4fnmzGz/jCY0MQF1i0tiz5A7B52JcFO6DeL0qhm2bBItm8hLuANr
         YYiweqmv29gxVXLnFBnVgj5z+L83lGnESmk7fitodyQeuQ7FsmsiSIqVwBzugaE4vB1D
         O81WDqF3RY5bdM3J0FfEyyBTqftJPeWCQDmWs8nGZZgQbM5hwhWQ0NHcKDmZFM6HjtND
         Un2T9kIMbZy47Bm3OFV7FNpq3rrRXTMXLroLaoXCAuX3G3fnq7VNiAjD+jGsqsw1ZE0B
         w+6F8zBC+kspukYKydunSQTBb1axwhSBZ5Vcf4sIfExaomkUeVvioS3w7jvrsI7d+WET
         Fz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SoTYvTk4mjI6U7+BRCCdi+ChcEShfJMyJ6yM4Tu9F/U=;
        b=lNUO9M79OZCNjsRAhddSdzqzplgFzd1Tj+rT4kwE35cFHIV1sBz1z/dXAgYawRliui
         J8bFcTWssQ3J2Mlb0lq12cBhPi1mbSrRhwLMrNO+D8JTEtu/jlhQOCni2KYWWnkiNXFM
         HeAH+plNDJiWLH+rvr1+1HiIQDwipDRBB01KwM+2QWN66U3a6qj2JjIueKPFnmKYTUP7
         O5IqHRzQ7HOlkwD5D224m3jh7G7tTo9m7CDjKXLHY+zYyxJqM5d5x0VRi4u14bmXpZFT
         c1kMY+ItFuQpIMWcF/Xgv38rmFpKFrKdNiPsx2A1sEumOAPARpQjHOckItOhJ1DPiLKc
         2wnw==
X-Gm-Message-State: AGRZ1gImVnW9H76h87lUgK4dqKccNVt6R+rMtEPTPHLqx6VvIpGC9GXD
        yBnFDeet6y9S3INco6rrUvcfW95UAhQ3GxBLMjb8yQ==
X-Google-Smtp-Source: AJdET5eOKR660V//VjVJIv9wt/++FTHn3QgUg1aAJIF4c7KNWVm3qg3ltIl+drhl5xTRadIKmQtFskvQvlt6CBVszKo=
X-Received: by 2002:a37:cf9b:: with SMTP id v27mr11280169qkl.160.1541844029832;
 Sat, 10 Nov 2018 02:00:29 -0800 (PST)
MIME-Version: 1.0
References: <20181107204029.88466-1-briannorris@chromium.org>
In-Reply-To: <20181107204029.88466-1-briannorris@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Sat, 10 Nov 2018 11:00:18 +0100
Message-ID: <CAFqH_53aBZPXworvBchxC1Gea=QNwqBwCh5ZWvtaO70sJCfgjA@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: don't log probe deferrals; but do log other
 error codes
To:     Brian Norris <briannorris@chromium.org>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Missatge de Brian Norris <briannorris@chromium.org> del dia dc., 7 de
nov. 2018 a les 21:42:
>
> It's not very useful to repeat a bunch of probe deferral errors. And
> it's also not very useful to log "failed" without telling the error
> code.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  drivers/usb/dwc3/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 88c80fcc39f5..1ef346ba6a02 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1482,7 +1482,8 @@ static int dwc3_probe(struct platform_device *pdev)
>
>         ret = dwc3_core_init(dwc);
>         if (ret) {
> -               dev_err(dev, "failed to initialize core\n");
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(dev, "failed to initialize core: %d\n", ret);
>                 goto err4;
>         }
>
> --
> 2.19.1.930.g4563a0d9d0-goog
>

fwiw this removes an annoying boot message that appears on every boot
and also was confusing some people that thought that their usb didn't
work.

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
