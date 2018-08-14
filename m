Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D278BC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AC521736
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tv2fauzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84AC521736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389638AbeHNUkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:40:15 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46824 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389105AbeHNUkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:40:15 -0400
Received: by mail-qk0-f194.google.com with SMTP id 191-v6so13958163qki.13;
        Tue, 14 Aug 2018 10:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ngbhZBfRkPNe4/rud4/QN9vbFnnUBPIFn9+vOqA0G7s=;
        b=Tv2fauzpNgTDq7o616J5lIBgJZFPcgw3skMueblIUj1/hLRf/mZo925lRQ0h5swiL8
         yZ0fpK0TEiX2Tiec7s8Eb8GBnAOHaZo9OYj/h6xBaaXs9hdtsWmVjcVwdKRmLMNhZPfz
         nROex1O+mjc8sl8f9/Y5zDohM6UYvbalC6LV0EVe9kWNzxPiI6f0ZJmZ2SPNzjFXMsjo
         nW1qgInHwIt916lBH+1JvSvV2Mu6qTLAG+urWz1b2PIWiPV8Dl3iultWX0zxCe9eA4fo
         FNTGDITX8EmjKnO5cUaSbsDwVc64KZqME3TUwekCtMG4NbyeCfXLJgajI13u3wt3eNmG
         RkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ngbhZBfRkPNe4/rud4/QN9vbFnnUBPIFn9+vOqA0G7s=;
        b=DHmd1PrussE3cenbVei8Lk0cWMaIlMZ7l1CLR8N6oxsCuEN3j6pnhbDTBx+wWRBF8g
         WBFFWCTWK5gfQCpfxQcHKeVDP647FQcmi1vSCmwluI7kypnjWuYVQqPCZBVYl5RzKs+H
         oqoLjxlTLimC4Tce1nwN0rpCrghq0K+Rg0EYGa1BVGgx7DvNz0/bikECiuL0nqQz2Fw4
         aSvnQ5/xuJHJFXYM6VfybrEf97nXChYRfiIqMywDzIg18oPwah+2bZevXEvRQ9VvhWyP
         bD1NhwP3T3+WdVG4ZcTSQpgS4ttwAhe8mtHaWbyIjr0fSkyp8xATe58S50F3uDeIrbc1
         46qQ==
X-Gm-Message-State: AOUpUlFpIbi00dCxJrnk0biveBf6g7Cs0nAYqH6l343eKPlvndAx7Nii
        A2E/qtOvZcXs5gwtkvkPcTzWBMlRJE9LkuC68YcbPe16
X-Google-Smtp-Source: AA+uWPzF/t+2r0DBgkFc284NuuHXnPGFiw41VjG7+xrwLl286QxdyArTz6Hx7guKikdfZ1A1F0lcUqPVqEDjAC8zQJI=
X-Received: by 2002:a37:5c44:: with SMTP id q65-v6mr20121779qkb.97.1534269121371;
 Tue, 14 Aug 2018 10:52:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9c4a:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 10:52:00
 -0700 (PDT)
In-Reply-To: <20180726225508.74612-1-dbasehore@chromium.org>
References: <20180726225508.74612-1-dbasehore@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Aug 2018 20:52:00 +0300
Message-ID: <CAHp75VctrKtj8oa4OuhsAKcwsBXUnb_Qyfu3DiHB7ghcyfY9GQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: enable async suspend/resume on i2c devices
To:     Derek Basehore <dbasehore@chromium.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        venkateswarlu.v.vinjamuri@intel.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Jarkko

On Fri, Jul 27, 2018 at 1:55 AM, Derek Basehore <dbasehore@chromium.org> wrote:
> This enables the async suspend property for i2c devices. This reduces
> the suspend/resume time considerably on platforms with multiple i2c
> devices (such as a trackpad or touchscreen).
>
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  drivers/i2c/i2c-core-base.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 1ba40bb2b966..3382bb7e1dcc 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -749,6 +749,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
>         client->dev.of_node = info->of_node;
>         client->dev.fwnode = info->fwnode;
>
> +       device_enable_async_suspend(&client->dev);
>         i2c_dev_set_name(adap, client, info);
>
>         if (info->properties) {
> --
> 2.18.0.345.g5c9ce644c3-goog
>



-- 
With Best Regards,
Andy Shevchenko
