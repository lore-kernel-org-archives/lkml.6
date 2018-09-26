Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1F5C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E79120779
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RI3oTyTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E79120779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeIZPyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:54:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40250 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbeIZPyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:54:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id o2-v6so1538620wmh.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 02:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DCX7SQRUbXAT+ztlLzDrwMN6Bo72Q7arOYkO58WDl8g=;
        b=RI3oTyTPknZpIozqMNbVJn8WmPkzsuPh2LrRQbEkY4gVptZS/w1lDIqChLuzstR0hP
         VBzUVkAXYE6sgE5UgOzh0RQOPL1CD8UVVSgqWeXmbuGxg95YZ7JkPlK5jEGzctdI6gLv
         FB/wLMfjC7KS1ih9wL7aoPqEzFuR8yf71s5Ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DCX7SQRUbXAT+ztlLzDrwMN6Bo72Q7arOYkO58WDl8g=;
        b=aJXeae9CZK8El8QlOtA56Q7zUj66PFr/d7V9OyEUhGzR14+gq99KHxRpNBmw09hzW8
         HEgmyQw+Ln9X5gCVlc+FdOfIUldSLX4qH80RK1qRnUh0iNVZ9Xv1OH+Ds/LDUQjVj8pq
         5edkbL5YIuOKZYQ09biv8U3Vt9UKuvcRLmfkfyw/ioYPq0gWvw7dxojrMEeV/kA9bfda
         JsNq9oswLBpHXtctHItjHaFLjnHmNGft1Wtg8VXHbWOs/yOskTCzMu1GlNTJbXEMXSOQ
         WZ9KOTQhwq46S/F5eEzYDRJj8S/JRe2J4nXXLtttMKvOJP7xP51NCjBamrlCn4jyUf5U
         gDPg==
X-Gm-Message-State: ABuFfog3Fe6yT9R17SKf0BUnQs673NUZBRUQ/NOu8RH99R0vi18wO3oA
        TFL+rXbJbz6DzR11xPV8F1xX4xOlWgJ57uWVELQqkPCIZc8nfOsc
X-Google-Smtp-Source: ACcGV62/QxH30Xb9plwyojEUxdDq93VXYnEWQ/wj/QneUUJ6Jqpm6+QCcEy+7/KhT9Q1LxCv66Va9TY4kN5xwmgP9gQ=
X-Received: by 2002:a1c:1745:: with SMTP id 66-v6mr3704786wmx.38.1537954961942;
 Wed, 26 Sep 2018 02:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <1537550727-21257-1-git-send-email-john.garry@huawei.com>
 <CAGd==05wySTNy9rOrv7Hb3V1ihD9wQZjN+v5RrfmG=0DAwsUsA@mail.gmail.com> <cb029b9e-3a2c-a26c-56af-038a566715c6@huawei.com>
In-Reply-To: <cb029b9e-3a2c-a26c-56af-038a566715c6@huawei.com>
From:   Xinliang Liu <xinliang.liu@linaro.org>
Date:   Wed, 26 Sep 2018 17:41:20 +0800
Message-ID: <CAGd==04qFCv2eC1=a9yVAzi3Hwj4NiOR+oxu_sUq9dX0EycphQ@mail.gmail.com>
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

On Wed, 26 Sep 2018 at 16:46, John Garry <john.garry@huawei.com> wrote:
>
> On 26/09/2018 04:00, Xinliang Liu wrote:
> > Thanks John, good addressing!
> > The root cause as you said, our hibmc previous frame buffer format
> > depth setting is wrong which does not pass the new format sanity
> > checking drm_mode_legacy_fb_format.
> > For this series,  Reviewed-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
> > Applied to hisilicon-drm-next.
>
> I can't see this branch in the git associated with this driver from its
> MAINTAINERS entry (git://github.com/xin3liang/linux.git), but please
Not a branch, it is a tag: drm-hisilicon-next-2018-09-26

> ensure these fixes are included in 4.19

As it doesn't affect 4.19-rcx, I send a PULL for 4.20.
See mail "[GIT PULL] drm-hisilicon-next-2018-09-26"

>
> Thanks,
> John
>
> >
> > Thanks,
> > Xinliang
> >
> > On Sun, 23 Sep 2018 at 20:32, John Garry <john.garry@huawei.com> wrote:
> >>
> >> This patchset fixes a couple of issues in probing the HiBMC driver, as
> >> follows:
> >> - fix the probe error path to not carry an error code in the pointer
> >> - don't use invalid legacy fb bpp/depth combination
> >>
> >> Another more trivial patch is for using the standard Huawei PCI vendor ID
> >> instead of hard-coding it.
> >>
> >> Tested on Huawei D05 board. I can see tux on BMC VGA console.
> >>
> >> John Garry (3):
> >>   drm/hisilicon: hibmc: Do not carry error code in HiBMC framebuffer
> >>     pointer
> >>   drm/hisilicon: hibmc: Don't overwrite fb helper surface depth
> >>   drm/hisilicon: hibmc: Use HUAWEI PCI vendor ID macro
> >>
> >>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 2 +-
> >>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c | 2 +-
> >>  2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> --
> >> 1.9.1
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
> > .
> >
>
>
