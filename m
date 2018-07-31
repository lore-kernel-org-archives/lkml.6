Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6106EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C4F208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVBF4QTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C4F208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbeGaLCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:02:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42598 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbeGaLCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:02:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id u202-v6so10208359lff.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 02:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fD/BKz0Fc2cpH3/FSpbcskQAIRDOuiEkR3yNNcZz+P4=;
        b=nVBF4QTh55TIoEdwXkIT0j1GDLMlMpTzoZAQfZdOEo4wHTFWMv3e5uR+vE0XzGvf7y
         sjlpFn2/7fs9mXGyBfmi71pVFZGuWl7wvkT2RYPmI2LnZJYTpJd9ka6aWbvOCFNGF9Dp
         mcZlqXV85ZlFneszWSN0v8wvCRp6pxwNGcDftcNMVNLWcxiOgCubQ7olVB/HYWsfQkJv
         0YCmcDl6GfMXPMhOq7oIyzb3wy3FGfnOBuZ3ahV5pZps17/ZVdP5V6u7G8NW3lqHHBYh
         7PBUs+pSzOaFZdJjx1aNy3T03wZUBcsVT6L1KsYZkb18+1Z1/7kVlvqINKfI5rMe3M1m
         Ugog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fD/BKz0Fc2cpH3/FSpbcskQAIRDOuiEkR3yNNcZz+P4=;
        b=reM94jnsOcQUFp1vJgX8Rmf5GoKmOohNWB35Rb1TpmtqFyb6p2qrcmlGZ8tymk0eb9
         R846OqFrNWaJ+Cfl2lji2xHfdZi2fvvOEa1DjYMaZVmVRz2cKQnoRaSk0A/b52bTXfCs
         JURU3HfkLLPc6xzw1gOGQN9hQzxmCaZR5bfcFKVpo3s6rx2K5gGfoD9eD6EpXWVAmKqA
         1utBRfnnt9x2QTeQyJAx2Ck5NjYM0S6IjmuWSzvZlLwqduoCjCKPwqufVBc09/UNIcYH
         Z3ireZ75mPcueP7b1L6Y/MOBHULwFAzQ+z3+EJZ1UdMEDp7igcK0YcOrVUi9L6o//Nfw
         O4Gg==
X-Gm-Message-State: AOUpUlET3i0l2La1Zsaz/THQov2JoDJOywZgmtWgfo5xi6BOWWNqj7oj
        K7asyqc0inwfvqabgUbrCwA/N71JjbDdnxxb0V4=
X-Google-Smtp-Source: AAOMgpf3+Hb3Shj10pX+AeVVgBVz/h0kj+d0Mp6gZWNK4oEGYRhacW1Z6epAK2PH9zmpKDWcb3Jt3AVB/9L2Wr8ytUQ=
X-Received: by 2002:a19:d942:: with SMTP id q63-v6mr11967558lfg.39.1533029006341;
 Tue, 31 Jul 2018 02:23:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 02:23:25
 -0700 (PDT)
In-Reply-To: <1533025785.3444.2.camel@pengutronix.de>
References: <20180728130521.GA6336@jordon-HP-15-Notebook-PC> <1533025785.3444.2.camel@pengutronix.de>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 31 Jul 2018 14:53:25 +0530
Message-ID: <CAFqt6zZOM8oy9bd=NWRJfverev5UFmHm7j9UR9Z780anEVJDyQ@mail.gmail.com>
Subject: Re: [PATCH] drm/imx: Convert drm_atomic_helper_suspend/resume()
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     airlied@linux.ie, Leonard Crestez <leonard.crestez@nxp.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ajit Linux <ajitn.linux@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 1:59 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Hi Souptick,
>
> On Sat, 2018-07-28 at 18:35 +0530, Souptick Joarder wrote:
>> convert drm_atomic_helper_suspend/resume() to use
>> drm_mode_config_helper_suspend/resume().
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
>
> Leonard pointed out earlier [1] that this makes the struct
> imx_drm_device superfluous, since imxdrm->state is the only remaining
> field and here you are removing its use. Could you remove struct
> imx_drm_device as well?

Sure, Will remove it in v2.
>
> [1] https://patchwork.kernel.org/patch/10531473/
>
> regards
> Philipp
>
>> ---
>>  drivers/gpu/drm/imx/imx-drm-core.c | 26 ++------------------------
>>  1 file changed, 2 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
>> index 1d053bb..cdd83ea 100644
>> --- a/drivers/gpu/drm/imx/imx-drm-core.c
>> +++ b/drivers/gpu/drm/imx/imx-drm-core.c
>> @@ -355,37 +355,15 @@ static int imx_drm_platform_remove(struct platform_device *pdev)
>>  static int imx_drm_suspend(struct device *dev)
>>  {
>>       struct drm_device *drm_dev = dev_get_drvdata(dev);
>> -     struct imx_drm_device *imxdrm;
>> -
>> -     /* The drm_dev is NULL before .load hook is called */
>> -     if (drm_dev == NULL)
>> -             return 0;
>> -
>> -     drm_kms_helper_poll_disable(drm_dev);
>> -
>> -     imxdrm = drm_dev->dev_private;
>> -     imxdrm->state = drm_atomic_helper_suspend(drm_dev);
>> -     if (IS_ERR(imxdrm->state)) {
>> -             drm_kms_helper_poll_enable(drm_dev);
>> -             return PTR_ERR(imxdrm->state);
>> -     }
>>
>> -     return 0;
>> +     return drm_mode_config_helper_suspend(drm_dev);
>>  }
>>
>>  static int imx_drm_resume(struct device *dev)
>>  {
>>       struct drm_device *drm_dev = dev_get_drvdata(dev);
>> -     struct imx_drm_device *imx_drm;
>> -
>> -     if (drm_dev == NULL)
>> -             return 0;
>>
>> -     imx_drm = drm_dev->dev_private;
>> -     drm_atomic_helper_resume(drm_dev, imx_drm->state);
>> -     drm_kms_helper_poll_enable(drm_dev);
>> -
>> -     return 0;
>> +     return drm_mode_config_helper_resume(drm_dev);
>>  }
>>  #endif
>>
