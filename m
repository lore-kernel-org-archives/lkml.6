Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50702C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 04:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D0C20873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 04:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hqfj5zKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D0C20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbeG3GYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 02:24:33 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42809 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbeG3GYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 02:24:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id f1-v6so9250391ljc.9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 21:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/ZbvzK2P0nVguNL5XYjcz99qANi3IX9hpd4FD6VhN4s=;
        b=Hqfj5zKoUtobPJp5deMJA+wPl0rKJGxyPynByPHWhf+lfrh/izPFOXkEJm9QL0C3cq
         2lw62IEUMLU0lMZSAGwVwD5fSgryfGc1ghyqeG0QlIpqv392OtonrP0E8h/qFSDstrk+
         RVx0ueauhWClCAGZO0CF/Cp+75cNgzwxxYPhsCsIhF/82gnby3SY01cLfI8gmpucuZWx
         jmCplH+d2RhgZJDt5ZVop0agcbnZRS0iVoZiZexSPO/FdgVYRQ9JoER+HD6vIra2HYLQ
         YvH4BZA9b+RrTS3VEjiyy2QesSu1Vvz89zFVM3QkDrBWiF8JlHbB/Dk4CNUk8LajBnob
         4nHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/ZbvzK2P0nVguNL5XYjcz99qANi3IX9hpd4FD6VhN4s=;
        b=B4K9UY8pimCA954+mDTr9ovK37IFy4mPXkS7X1rn+quWl/U/aDD9xEH1XZ5t88e3Dk
         4auhD02b/oCTLAm64p8oZLqt38XJW3vzYMT8an/DZRsscnz8gyYqkJZGOdP+rDSNyNtp
         X4mGTdv7kc3Hz61cYNh9HBla+Bc1JTwII1uMtrYKus1q1Tc5L02I+CIOWqwoTBJINbzx
         pt7yHf5IJU+JVKzpUMqQT7kZRL24q8PyUzriepaxHHdBA7jnLrH/7CWLv0ppowtEP/Z7
         WpeGZHKTJwN50pYUwVx4K+XbWMEly+Frz0tZG4E67l5bVm3gfbDUUEy5FaF3BrCdXgrV
         p1GQ==
X-Gm-Message-State: AOUpUlFiiGtqzHCFVpLCRwJyxOhEkyU6cpJMggZkvlM1BQQ9nwakWNic
        Ba+H2PmHjcHf5G2c3xTtF7oEAnXCSQqxUrrDXIw=
X-Google-Smtp-Source: AAOMgpc/zBGeO90QkYjh/7xgWOyOCIKb3wA0Mqn1iP6H0eDAh9Tjy48FxUZ3nNQnFYre3f4c3nb844zpDNZfWtaJnWE=
X-Received: by 2002:a2e:8616:: with SMTP id a22-v6mr12266444lji.43.1532926283926;
 Sun, 29 Jul 2018 21:51:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Sun, 29 Jul 2018 21:51:23
 -0700 (PDT)
In-Reply-To: <1532922786.3723.1.camel@mtksdaap41>
References: <20180728133845.GA15261@jordon-HP-15-Notebook-PC> <1532922786.3723.1.camel@mtksdaap41>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 30 Jul 2018 10:21:23 +0530
Message-ID: <CAFqt6zbbVMagJeM53g79RoeYt7edmAZiF8r0_HpyxnS9123vQg@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Convert drm_atomic_helper_suspend/resume()
To:     CK Hu <ck.hu@mediatek.com>
Cc:     p.zabel@pengutronix.de, airlied@linux.ie,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ajit Linux <ajitn.linux@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 9:23 AM, CK Hu <ck.hu@mediatek.com> wrote:
> Hi, Souptick:
>
> On Sat, 2018-07-28 at 19:08 +0530, Souptick Joarder wrote:
>> convert drm_atomic_helper_suspend/resume() to use
>> drm_mode_config_helper_suspend/resume().
>>
>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>

Thank CK, can we get this patch in queue for 4.19 ?

>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
>> ---
>>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 21 ++++++++-------------
>>  1 file changed, 8 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> index a2ca90f..1fcda2de 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> @@ -520,29 +520,24 @@ static int mtk_drm_sys_suspend(struct device *dev)
>>  {
>>       struct mtk_drm_private *private = dev_get_drvdata(dev);
>>       struct drm_device *drm = private->drm;
>> +     int ret;
>>
>> -     drm_kms_helper_poll_disable(drm);
>> -
>> -     private->suspend_state = drm_atomic_helper_suspend(drm);
>> -     if (IS_ERR(private->suspend_state)) {
>> -             drm_kms_helper_poll_enable(drm);
>> -             return PTR_ERR(private->suspend_state);
>> -     }
>> -
>> +     ret = drm_mode_config_helper_suspend(drm);
>>       DRM_DEBUG_DRIVER("mtk_drm_sys_suspend\n");
>> -     return 0;
>> +
>> +     return ret;
>>  }
>>
>>  static int mtk_drm_sys_resume(struct device *dev)
>>  {
>>       struct mtk_drm_private *private = dev_get_drvdata(dev);
>>       struct drm_device *drm = private->drm;
>> +     int ret;
>>
>> -     drm_atomic_helper_resume(drm, private->suspend_state);
>> -     drm_kms_helper_poll_enable(drm);
>> -
>> +     ret = drm_mode_config_helper_resume(drm);
>>       DRM_DEBUG_DRIVER("mtk_drm_sys_resume\n");
>> -     return 0;
>> +
>> +     return ret;
>>  }
>>  #endif
>>
>
>
