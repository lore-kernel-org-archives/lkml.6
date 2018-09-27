Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D357C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E154321580
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P0KeiI0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E154321580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeI0PAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:00:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35594 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeI0PAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:00:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id o18-v6so5086620wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 01:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3/mKZec/uTKFd8D6AurEq3vsssQNu1EQFXqYwyL9Glo=;
        b=P0KeiI0ZmFm+HuTbgveeHAibYgsLKPvHVRlNulK1oLtE5oPCF5Go+QjIGTt5MpNxKp
         /kuLOdoxxMK5QrqptxyR8ypB8fzMuUqxKvLULLM859fJ+eBUAFZD3osc9hBPftJ0Lhnh
         02svikepH+TJkojgv2n2msYWJnXtVXlcJq46U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3/mKZec/uTKFd8D6AurEq3vsssQNu1EQFXqYwyL9Glo=;
        b=jeyfMnFcHxlsZmOOjaVq4e2BwQJucsoL1avvXC4WQzmb8TvkAgE4if166FR8yPbtdp
         ScKzOzRsJZSNyi4Eve90rOnN/SzauYzdqH+iT2d6xM5SIa5vrAOIB3v9JPfqXExkYmxT
         JNqcAp5vjzndt2u9O4U4D1rxaQHFf8ezCzsZhcaFNC4HzdYtECiCOVartRyX74vy4FQj
         fIfdp6LcRoyfT9OWFjd/lvB+MRD9jVbCDqdNPTdx41VhEGS/S4VDnipWBgvAkaJ2eJHi
         V+IoDVFwOdWvtiSCZM/cmMvr0RcHEbkpFTljhP0swLzecslWxVHbAQkVeYK1FaTLXRS+
         9fEw==
X-Gm-Message-State: ABuFfogS3SpEHxRla2U+fDUpmwubI3P7QN0qHPsyQnaRjqSG0HI1LJyQ
        YT/w2Fd/A5f6dqwOjyaNCNOn0+DZx9yxSC83zE8G+Q==
X-Google-Smtp-Source: ACcGV62765/askO/RAaT/7yTtcID8WV8evw4ThTNFqxAGJW/7G1m0r2ognHSPWaJ9CQJVbjh5KNj6F4OOxREfULwNXA=
X-Received: by 2002:a1c:1745:: with SMTP id 66-v6mr7038381wmx.38.1538037779020;
 Thu, 27 Sep 2018 01:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <1537550727-21257-1-git-send-email-john.garry@huawei.com>
 <CAGd==05wySTNy9rOrv7Hb3V1ihD9wQZjN+v5RrfmG=0DAwsUsA@mail.gmail.com>
 <cb029b9e-3a2c-a26c-56af-038a566715c6@huawei.com> <CAGd==04qFCv2eC1=a9yVAzi3Hwj4NiOR+oxu_sUq9dX0EycphQ@mail.gmail.com>
 <77674be9-734f-12e3-5327-dee89f1f0299@huawei.com>
In-Reply-To: <77674be9-734f-12e3-5327-dee89f1f0299@huawei.com>
From:   Xinliang Liu <xinliang.liu@linaro.org>
Date:   Thu, 27 Sep 2018 16:42:47 +0800
Message-ID: <CAGd==054hT=KUhMRn3-jj1nC6OsSEV9R0G15mHNtX_mpbW6WRQ@mail.gmail.com>
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

On Wed, 26 Sep 2018 at 17:54, John Garry <john.garry@huawei.com> wrote:
>
> On 26/09/2018 10:41, Xinliang Liu wrote:
> > On Wed, 26 Sep 2018 at 16:46, John Garry <john.garry@huawei.com> wrote:
> >>
> >> On 26/09/2018 04:00, Xinliang Liu wrote:
> >>> Thanks John, good addressing!
> >>> The root cause as you said, our hibmc previous frame buffer format
> >>> depth setting is wrong which does not pass the new format sanity
> >>> checking drm_mode_legacy_fb_format.
> >>> For this series,  Reviewed-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
> >>> Applied to hisilicon-drm-next.
> >>
> >> I can't see this branch in the git associated with this driver from its
> >> MAINTAINERS entry (git://github.com/xin3liang/linux.git), but please
> > Not a branch, it is a tag: drm-hisilicon-next-2018-09-26
> >
> >> ensure these fixes are included in 4.19
> >
> > As it doesn't affect 4.19-rcx, I send a PULL for 4.20.
> > See mail "[GIT PULL] drm-hisilicon-next-2018-09-26"
>
> When Chris' change goes into 4.20 - which I suspect will be before yours
> - boot-time bisect will be broken.

Yeah, that's might be a problem.

>
> John
>
> >
> >>
> >> Thanks,
> >> John
> >>
> >>>
> >>> Thanks,
> >>> Xinliang
> >>>
> >>> On Sun, 23 Sep 2018 at 20:32, John Garry <john.garry@huawei.com> wrote:
> >>>>
> >>>> This patchset fixes a couple of issues in probing the HiBMC driver, as
> >>>> follows:
> >>>> - fix the probe error path to not carry an error code in the pointer
> >>>> - don't use invalid legacy fb bpp/depth combination
> >>>>
> >>>> Another more trivial patch is for using the standard Huawei PCI vendor ID
> >>>> instead of hard-coding it.
> >>>>
> >>>> Tested on Huawei D05 board. I can see tux on BMC VGA console.
> >>>>
> >>>> John Garry (3):
> >>>>   drm/hisilicon: hibmc: Do not carry error code in HiBMC framebuffer
> >>>>     pointer
> >>>>   drm/hisilicon: hibmc: Don't overwrite fb helper surface depth
> >>>>   drm/hisilicon: hibmc: Use HUAWEI PCI vendor ID macro
> >>>>
> >>>>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 2 +-
> >>>>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c | 2 +-
> >>>>  2 files changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> --
> >>>> 1.9.1
> >>>>
> >>>> _______________________________________________
> >>>> dri-devel mailing list
> >>>> dri-devel@lists.freedesktop.org
> >>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >>>
> >>> .
> >>>
> >>
> >>
> >
> > .
> >
>
>
