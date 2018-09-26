Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430F5C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B4721480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hQSQPkNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B4721480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbeIZJLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 05:11:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35737 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeIZJLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 05:11:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id o18-v6so580709wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 20:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eC45jCgd7XrZJSmA1UInpQYv0RV1Mzmm6hFnAUVbmP0=;
        b=hQSQPkNZZ7NRJ5ggIckmiVEifGZCT/LfSiOqo5Jdg2B0LJty2rF6fIgjaSVxronQ7k
         9I2pjG2ebYqDiJPJzxLslmmpmwy+oVa/LvLUvI2qDJ0ITt/o4068DsIi80Ha9E96kF7F
         rjdtvVRXOCU5gI/11z1/Lq+q97tcyvJ/uvSA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eC45jCgd7XrZJSmA1UInpQYv0RV1Mzmm6hFnAUVbmP0=;
        b=QPuKHoTGzmyv8Lh/Cas8Y5i2XLLtLsVFYePtb8R3LIU+sl4Z/psIt26jFR2QinFJbx
         5ngjghso1AtxFlXZCOUy0E1nh/JBms5TbiLvtfIpuki6Vs65iaCUGvtSKfFwwFl4HSld
         jeaswAivoV+Vb8DV5D6iOkqPD/cFsC4lvQXX4WBw1569gPWSeEtQ8UQIOrFzSxwylqAh
         RusJJMum0Xe3SjKt62v8yWF0aKb1jGlgr3fnPfrVlPvAQR6oi9jpN/sVjO90yodCdQc1
         aZx4czKoUAok9L3gHYS4ZZmkzL0VNFrhRFwfh3xKZ5qmMSp0dH144H8mukZm5ee+94LT
         gb2A==
X-Gm-Message-State: ABuFfoj7y/lHmanhvc2JukEq1EUIpIW4AkFm88b8/GWAWxtr/3oTB04Z
        xjlj0nxhmVaSjuPqZcch+HSIdOepprKSfO+MYoPkZg==
X-Google-Smtp-Source: ACcGV63seTVo8X7FC+LIb2zK9cRr52ebd7lpACsV0agWRC7R1RqxXEqXZ/53KivvgUiOZM9U2jcZYOmFJjMjbsgnkos=
X-Received: by 2002:a1c:1805:: with SMTP id 5-v6mr2785342wmy.25.1537930822945;
 Tue, 25 Sep 2018 20:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <1537550727-21257-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1537550727-21257-1-git-send-email-john.garry@huawei.com>
From:   Xinliang Liu <xinliang.liu@linaro.org>
Date:   Wed, 26 Sep 2018 11:00:12 +0800
Message-ID: <CAGd==05wySTNy9rOrv7Hb3V1ihD9wQZjN+v5RrfmG=0DAwsUsA@mail.gmail.com>
Subject: Re: [PATCH 0/3] HiBMC driver fixes
To:     John Garry <john.garry@huawei.com>
Cc:     "Liuxinliang (Matthew Liu)" <z.liuxinliang@hisilicon.com>,
        XinWei Kong <kong.kongxinwei@hisilicon.com>,
        Feng Chen <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>, baowenyi@huawei.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linuxarm <linuxarm@huawei.com>,
        Rongrong Zou <zourongrong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks John, good addressing!
The root cause as you said, our hibmc previous frame buffer format
depth setting is wrong which does not pass the new format sanity
checking drm_mode_legacy_fb_format.
For this series,  Reviewed-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Applied to hisilicon-drm-next.

Thanks,
Xinliang

On Sun, 23 Sep 2018 at 20:32, John Garry <john.garry@huawei.com> wrote:
>
> This patchset fixes a couple of issues in probing the HiBMC driver, as
> follows:
> - fix the probe error path to not carry an error code in the pointer
> - don't use invalid legacy fb bpp/depth combination
>
> Another more trivial patch is for using the standard Huawei PCI vendor ID
> instead of hard-coding it.
>
> Tested on Huawei D05 board. I can see tux on BMC VGA console.
>
> John Garry (3):
>   drm/hisilicon: hibmc: Do not carry error code in HiBMC framebuffer
>     pointer
>   drm/hisilicon: hibmc: Don't overwrite fb helper surface depth
>   drm/hisilicon: hibmc: Use HUAWEI PCI vendor ID macro
>
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 2 +-
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> --
> 1.9.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
