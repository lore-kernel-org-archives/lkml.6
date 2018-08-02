Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849EAC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3731C21501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mi6RVeym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3731C21501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbeHBLr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:47:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38847 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeHBLr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:47:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id p6-v6so1390926ljc.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 02:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XvSrbllBcu7C+XMtDr7X6oUf/YaE4ZA3STMPuyOz7ac=;
        b=Mi6RVeymOtT4H5QVc2LCCNO3hkOy9mkhqmpe8HMDWlG+xhn26q3tBWEIQpZO1V+7Pn
         tx9y/Q6+EQYORYhryre/S0zqgaI3xD8bx0pqmD6VFmiJYpb4KXlYJB2rdRuQsKNA8rcS
         3gV/UjFUA8ck6V9gFal/G3cVpHNGPUH1ZPvC/WyL9QLlZoQ4TBr+YXU4j0oP6cXMq8V6
         /4roycNUSiETZh7PKUwWhzmnZW6UwIQBD6sIdTTENiFEvqvcIumSFUyXVGeftQbcPDJs
         sv1uG3Eq7YFduKOPAn1BnD81Wl5FiiRa0OZF59tFYiSM251jvcKmJUouKWfeAGos4iqd
         e/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XvSrbllBcu7C+XMtDr7X6oUf/YaE4ZA3STMPuyOz7ac=;
        b=IGmTxKk2jXSzJXuTLLBgQc1pNLXayKS+YUOEN92QZIcT4QzElb/bgn6F6s3bq0s+Ps
         PVhprD5y41nLqxs6sTgA98mW2xQttY9Al3lGyEzDVqoqjy9I7rCfK7qumjly6Ylw6mky
         LeIKA8iEIsLYhskCGZEDmKMFPuq3N+o+JeFgKBNGKJikzzuJvD9IjSc12AkS7i9kWf4o
         9FBBo8U21H2ru8TGsCqAnKTyE59xaN25idB4CMMMGRjCyUsfApSoRYYflFQY0UE/j1Z5
         gdnM+eUd27SMRVXQBEpsPi3s9L6YzJoFbGZXsuh88ReWDxnMslJDQnFKO6BmXjqnngk4
         3AFw==
X-Gm-Message-State: AOUpUlEltWUe4kBJlVhbtlgDIUp23SHVmK2+Odx08MssW0wJwRVVPb3H
        wGyUR1P8znHOkIZ4iKKJl9z2LpUJq5cGi+hFudAP7g==
X-Google-Smtp-Source: AAOMgpcdBQooRF2zjpGMcCBEMyEZu136fPBVI6Npz9cmjdHFWkJs2tw99jV9iUiikk0AxW8RTH0Uat0FaIr4xWsP0k4=
X-Received: by 2002:a2e:85d5:: with SMTP id h21-v6mr1606932ljj.103.1533203850243;
 Thu, 02 Aug 2018 02:57:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 02:57:29 -0700 (PDT)
In-Reply-To: <CAFqt6zY_KUx0RgRiuTt6x6xmtfwD=iR8xR6665eZYmKmXKgDNA@mail.gmail.com>
References: <20180719160426.GA21958@jordon-HP-15-Notebook-PC> <CAFqt6zY_KUx0RgRiuTt6x6xmtfwD=iR8xR6665eZYmKmXKgDNA@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 2 Aug 2018 15:27:29 +0530
Message-ID: <CAFqt6zZdOJe1VmCC3=cEANEU_X05whezkFZsG+FtoS64FXnpeg@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm/hisilicon: Convert drm_atomic_helper_suspend/resume()
To:     z.liuxinliang@hisilicon.com, Zou Rongrong <zourongrong@gmail.com>,
        kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com,
        airlied@linux.ie, noralf@tronnes.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Sean Paul <seanpaul@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ajit Linux <ajitn.linux@gmail.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 1:37 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Thu, Jul 19, 2018 at 9:34 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> convert drm_atomic_helper_suspend/resume() to use
>> drm_mode_config_helper_suspend/resume().
>>
>> Fixed one sparse warning by making hibmc_drm_interrupt
>> static.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
>> ---
>
> Any comment on this patch ?

Any review comment for this patch ?

>
>>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 24 ++++++++----------------
>>  1 file changed, 8 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> index d4f6f1f..2261676 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> @@ -37,7 +37,7 @@
>>         .llseek         = no_llseek,
>>  };
>>
>> -irqreturn_t hibmc_drm_interrupt(int irq, void *arg)
>> +static irqreturn_t hibmc_drm_interrupt(int irq, void *arg)
>>  {
>>         struct drm_device *dev = (struct drm_device *)arg;
>>         struct hibmc_drm_private *priv =
>> @@ -74,30 +74,22 @@ static int __maybe_unused hibmc_pm_suspend(struct device *dev)
>>  {
>>         struct pci_dev *pdev = to_pci_dev(dev);
>>         struct drm_device *drm_dev = pci_get_drvdata(pdev);
>> -       struct hibmc_drm_private *priv = drm_dev->dev_private;
>> -
>> -       drm_kms_helper_poll_disable(drm_dev);
>> -       priv->suspend_state = drm_atomic_helper_suspend(drm_dev);
>> -       if (IS_ERR(priv->suspend_state)) {
>> -               DRM_ERROR("drm_atomic_helper_suspend failed: %ld\n",
>> -                         PTR_ERR(priv->suspend_state));
>> -               drm_kms_helper_poll_enable(drm_dev);
>> -               return PTR_ERR(priv->suspend_state);
>> -       }
>> +       int ret = 0;
>>
>> -       return 0;
>> +       ret = drm_mode_config_helper_suspend(drm_dev);
>> +
>> +       return ret;
>>  }
>>
>>  static int  __maybe_unused hibmc_pm_resume(struct device *dev)
>>  {
>>         struct pci_dev *pdev = to_pci_dev(dev);
>>         struct drm_device *drm_dev = pci_get_drvdata(pdev);
>> -       struct hibmc_drm_private *priv = drm_dev->dev_private;
>> +       int ret = 0;
>>
>> -       drm_atomic_helper_resume(drm_dev, priv->suspend_state);
>> -       drm_kms_helper_poll_enable(drm_dev);
>> +       ret = drm_mode_config_helper_resume(drm_dev);
>>
>> -       return 0;
>> +       return ret;
>>  }
>>
>>  static const struct dev_pm_ops hibmc_pm_ops = {
>> --
>> 1.9.1
>>
