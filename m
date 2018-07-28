Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBF3C6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 18:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED48E20878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 18:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWe6pMs5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED48E20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbeG1US0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 16:18:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40634 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730356AbeG1USZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 16:18:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id j19-v6so7136105ljc.7;
        Sat, 28 Jul 2018 11:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UWXQIoKzwZ9RzuXhKo7ijE1kSckkD4dJ4gaZdtnRwTo=;
        b=lWe6pMs5o+/AG0UG4cKcYXs15yRpfGGQNAALp49ZXmz47Ozt2zAAIZG4iyFA3oZVYA
         ca8mveYIOIDrd/wvHP0PsjLxMKVrt4GxH5yBa44X5S2bI57JjpDNoK8BDCi6WXVOm9xw
         V0qfPwOuiaW1R+X9V9mwnlp0Zepe/yy1D888Az2T0RXSuDzHh3Fg7QrOef2jtq52bRL1
         SXCQpJ+x+iBjwLYMKY6TmJc6ElIKTSnoyOKb6CEjycKgPY2QcfKeVixOIkfe80qQ2Zd3
         MpTzziYBY61d+AfQ42Gc3W0pl4vyyu623MYOPBg7xxB2x0SdmdwtwHxHtKcvqpwhtECi
         x+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UWXQIoKzwZ9RzuXhKo7ijE1kSckkD4dJ4gaZdtnRwTo=;
        b=lhZ/UcunigegvM2UB2d+tRrJp735IVGGhufo77leIU34Yq4e5R4L74G2p0UfB6Ne/h
         E6BKH0LuaSHYyG5PzcFnDoXVh+7uQaOs4CqzZ2KihCYRkCaYuXEo+XvQTmbnt+UZ4Qf6
         IrX0ToGet7XbysyDZwvibKqJqXXjKGvC4IuhxvLST5X0oU7ytjOHCHkes7rXI6GjSpMV
         NMTT3XDvF/uoLKyX1o+o0Nkqr0dn/rdKeMw8ypLBkp4fCetk0I9mS3rKo60S7Yr4z8EZ
         DYUis7nQj9S8eHojYJOL9siK77yx4sjzg1LNPDHGaSOtaZ/85UvKY9tOBdN9+O+eXR2S
         9TYg==
X-Gm-Message-State: AOUpUlGG2XurW0x+yALNqg8fSefuRAWJhe6QslQbCFDzz7ahkmLnzqNR
        cc48jVJSYXMWseJYnYn5mblSSG+3GKh/xpz2SDE=
X-Google-Smtp-Source: AAOMgpducJ4ivk4Vrj5IQ7BczZU/3InCgLyhoe2BQ8o4qQdLqJrkQuwf4EUZBOprWZplGjTZCzc3GtnDnagFVxvXykM=
X-Received: by 2002:a2e:1301:: with SMTP id 1-v6mr7980228ljt.56.1532803859637;
 Sat, 28 Jul 2018 11:50:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Sat, 28 Jul 2018 11:50:58
 -0700 (PDT)
In-Reply-To: <CAK-LDbKqU4Yub5H0_6tRpED4DLN8D+XrsUaNT5SN9Oq0sEpBNg@mail.gmail.com>
References: <20180728154007.GA28426@jordon-HP-15-Notebook-PC> <CAK-LDbKqU4Yub5H0_6tRpED4DLN8D+XrsUaNT5SN9Oq0sEpBNg@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sun, 29 Jul 2018 00:20:58 +0530
Message-ID: <CAFqt6zYy4GfQn0VQ5rfoygY+8M1RQYEv_BH-Jxmv6epoLj3xmw@mail.gmail.com>
Subject: Re: [PATCH] drm/rcar-du: Convert drm_atomic_helper_suspend/resume()
To:     Vaishali Thakkar <vthakkar@vaishalithakkar.in>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        airlied@linux.ie, Ajit Linux <ajitn.linux@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 11:20 PM, Vaishali Thakkar
<vthakkar@vaishalithakkar.in> wrote:
> On Sat, Jul 28, 2018 at 9:10 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> convert drm_atomic_helper_suspend/resume() to use
>> drm_mode_config_helper_suspend/resume().
>
> Hi Souptick,
>
> Thanks for your patch.
>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
>> ---
>>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 21 ++-------------------
>>  1 file changed, 2 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>> index 02aee6c..288220f 100644
>> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>> @@ -357,32 +357,15 @@ static void rcar_du_lastclose(struct drm_device *dev)
>>  static int rcar_du_pm_suspend(struct device *dev)
>>  {
>>         struct rcar_du_device *rcdu = dev_get_drvdata(dev);
>> -       struct drm_atomic_state *state;
>>
>> -       drm_kms_helper_poll_disable(rcdu->ddev);
>> -       drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, true);
>> -
>> -       state = drm_atomic_helper_suspend(rcdu->ddev);
>> -       if (IS_ERR(state)) {
>> -               drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
>

> I don't think we can use drm_mode_config_helper_(suspend/resume)
> API here as this file uses CMA functions.

drm_fbdev_cma_set_suspend_unlocked() is wrapper function which
invokes drm_fb_helper_set_suspend_unlocked().

Where the new API drm_mode_config_helper_suspend/resume() directly invokes
drm_fb_helper_set_suspend_unlocked(). So it is safe to replace exiting
code with API drm_mode_config_helper_suspend/resume().


> And from git grep it seems that
> there are very few drivers using it at the moment, so not sure if introducing
> new API functions similar to  drm_mode_config will make sense or not.
>

https://www.kernel.org/doc/html/latest/gpu/todo.html

It was picked up from TODO list after discussing with
Daniel.


> Thanks.
>
>> -               drm_kms_helper_poll_enable(rcdu->ddev);
>> -               return PTR_ERR(state);
>> -       }
>> -
>> -       rcdu->suspend_state = state;
>> -
>> -       return 0;
>> +       return drm_mode_config_helper_suspend(rcdu->ddev);
>>  }
>>
>>  static int rcar_du_pm_resume(struct device *dev)
>>  {
>>         struct rcar_du_device *rcdu = dev_get_drvdata(dev);
>>
>> -       drm_atomic_helper_resume(rcdu->ddev, rcdu->suspend_state);
>> -       drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
>> -       drm_kms_helper_poll_enable(rcdu->ddev);
>> -
>> -       return 0;
>> +       return drm_mode_config_helper_resume(rcdu->ddev);
>>  }
>>  #endif
>>
>> --
>> 1.9.1
>>
