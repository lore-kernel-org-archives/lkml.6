Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761B8C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D32208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4p4DlJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D32208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeGaHdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:33:49 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37323 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbeGaHdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:33:49 -0400
Received: by mail-lf1-f68.google.com with SMTP id j8-v6so9837683lfb.4;
        Mon, 30 Jul 2018 22:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5L/PZqHR2rM54YMjzoS37ogLPQNQDgzeJERVsA0zIeQ=;
        b=S4p4DlJ65JWjLnFPIzkwxHTCLneADkqkDDch8MQy2PzyCjF7l3FZjKx0Q3ZxYyXSkp
         OiZeeSliFfILrLnAIwr3NogtWNK/DJHGSBXWL1AYUpaAQHjYLDcAcXr17s4CYsxgTGGN
         S+Es2ueJ4MA6nQDWYmWAGAHr3QwyUuSHGIgg3iDQl3YSO295t4TwTxW+h58S63ddTqsG
         jwl48umxYBtgGgdpRu1Ws8UbMup+hyphMEVsTzZ3ecX3fArtUhhxhMu/CUFD2j5liVHT
         3f1RxmDif5FdIKwAKBr6tgyk5y513XAoKJa+JP1bYXvjUdHWQcVFuEPCPqOU00ENXJol
         042A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5L/PZqHR2rM54YMjzoS37ogLPQNQDgzeJERVsA0zIeQ=;
        b=aoFu4VmhsN3rroUQSNog2/djK1KOBDbotquYijyuu1EKVFejNYxtsR94bgG80X3jGQ
         CPvJPLhYqyZVQU8P9KpGh7n1KAQaazPSjU+sYLDSTf1DNkofgpiJNKM6GNtSA14omjAk
         rKPoVAXd/2IMU4jZBM907kB9sxho+U6qhXUXUKPjRFbYRGZV9orBol2ukpqYl/Ge6gYK
         EpCZxbEM90QYAz6Roq3UIbDlcD9z3mGK+W6rrhntQE5XlFTIxwOrn6lTPIIRY+y0k6If
         ggp7+hz+KU/4aT1r4cZj+irRIAM2swxOYAEqZZMV8oY7gVOmPXNQ6DjSCTfwvBovT4u9
         5I4w==
X-Gm-Message-State: AOUpUlGdjsZdr5845KW7isGb0AoX5dD0MfRlcKlWQ7ZUDhvY/skhmFZs
        YbY6mvCT1CriKL9nWGnusLaAxw1JCJ5WL0hVVPM=
X-Google-Smtp-Source: AAOMgpfyYFwdEgxbyfaOjee/rLmXkgrO0RwkZKKSeTboj7xpwnwyI+RWpQTLZdTaJASMyhDfY7EGsGGA33mb7NwB0HU=
X-Received: by 2002:a19:e119:: with SMTP id y25-v6mr12881443lfg.3.1533016514270;
 Mon, 30 Jul 2018 22:55:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 22:55:13
 -0700 (PDT)
In-Reply-To: <3328858.Mu96AcVENO@avalon>
References: <20180730190137.GA25420@jordon-HP-15-Notebook-PC> <3328858.Mu96AcVENO@avalon>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 31 Jul 2018 11:25:13 +0530
Message-ID: <CAFqt6zaJJcfWr2SXkJZXviVsO7K+_=UCF8MUfR2_036Y-ocFsA@mail.gmail.com>
Subject: Re: [PATCH] drm: Convert drm_atomic_helper_suspend/resume()
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     liviu.dudau@arm.com, Brian Starkey <brian.starkey@arm.com>,
        malidp@foss.arm.com, airlied@linux.ie,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Ajit Linux <ajitn.linux@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If you further remove the suspend_state field from the rcar_du_device
> structure, you'll get my
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>

Sorry, missed it.

>> -
>> -     return 0;
>> +     return drm_mode_config_helper_suspend(rcdu->ddev);
>>  }
>>
>>  static int rcar_du_pm_resume(struct device *dev)
>>  {
>>       struct rcar_du_device *rcdu = dev_get_drvdata(dev);
>>
>> -     drm_atomic_helper_resume(rcdu->ddev, rcdu->suspend_state);
>> -     drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
>> -     drm_kms_helper_poll_enable(rcdu->ddev);
>> -
>> -     return 0;
>> +     return drm_mode_config_helper_resume(rcdu->ddev);
>>  }
>>  #endif
>>
>> diff --git a/include/drm/drm_fb_cma_helper.h
>> b/include/drm/drm_fb_cma_helper.h index d532f88a..15c4569 100644
>> --- a/include/drm/drm_fb_cma_helper.h
>> +++ b/include/drm/drm_fb_cma_helper.h
>> @@ -33,8 +33,6 @@ struct drm_fbdev_cma *drm_fbdev_cma_init(struct drm_device
>> *dev, void drm_fbdev_cma_restore_mode(struct drm_fbdev_cma *fbdev_cma);
>> void drm_fbdev_cma_hotplug_event(struct drm_fbdev_cma *fbdev_cma); void
>> drm_fbdev_cma_set_suspend(struct drm_fbdev_cma *fbdev_cma, bool state);
>> -void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma *fbdev_cma,
>> -                                     bool state);
>>
>>  struct drm_gem_cma_object *drm_fb_cma_get_gem_obj(struct drm_framebuffer
>> *fb, unsigned int plane);
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>
