Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026FA13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F69D20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHqh/zL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F69D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeG3PdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:33:20 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40356 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbeG3PdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:33:20 -0400
Received: by mail-lf1-f68.google.com with SMTP id y200-v6so8205258lfd.7;
        Mon, 30 Jul 2018 06:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HoKK75wSNcJSOZf0rpf0V7USYG4exr8UT0M+vlolyPk=;
        b=iHqh/zL1zUN71WRHddrBV0vf4wXf2pWToFDoM819QDgWl31EaWMOqqK5k3ZMuQK8lQ
         XxefCpp7zU2RyXfrPtVAaZza+zVUzT3Izk2uzNdzvhFSowTiUvXnV+p0yK7aemRFnWdZ
         H0yBgqzmAG3OkjB58w9DLHew8udbOmoO/pVKsG8kfMc2ybSFEfUus1INuCtD8c+aJ9+2
         dcdGj1oLkEPBhumbA+BmqaXcCYSQcbT1DXyrO/zyLdmOxBk+qHU20e7AW9uYfREqd+Uz
         w8p0CtWrdRKAMWQWBIbPShyVe3CmaGfdih2fx1r8nwuKCnKg7RJMGSJEshhmZ9U9xyy9
         JY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HoKK75wSNcJSOZf0rpf0V7USYG4exr8UT0M+vlolyPk=;
        b=D5rLNhQaCNsmBlF9pWOhp4emk2ywGNcTpH6RbvNazO2+OT5OKvOk4c5QnI1AsRFevO
         65rzO8fODD1g0nFEBV12OGqsZz//7017Vwx73YUOinMM5mlgX+H5wrEE/ylBI7zrNIcW
         9HuHMy2ntUSzeC/gUb2nFoLyRWWiwVsWuXqLBDzySECaPqZ1CXa+pyLxxVA81JYbJlxc
         EeCuqKBnvq42FKb8/f+sHvzyX4kZ/dJVD6wfVmxWuSuJnskLElFnj92hxoMRfgyyCQ0c
         hcs70qf9p5wM0G5vII5FguvfcbFH7NlbbeCUxS3TZjHJSyyF8ehBQVddW3tGUiLG7kfd
         +nBA==
X-Gm-Message-State: AOUpUlFvkOHmRseBzSILjKx6pDZU7M8k91bw2VA0YN4QtAskOoGzvPWC
        dnzQGNnxJA/F3A+vnYLJ92mWhy/s9WkIVbON9qvB4g==
X-Google-Smtp-Source: AAOMgpfb6qwQmoZQ74yGhXs8VDNjqM3sZciRaT60VN4RVgRrvRelgUeEcQXe/8PhbX379/GjkfPFq9J0CuC2NeldDP8=
X-Received: by 2002:a19:5f11:: with SMTP id t17-v6mr10627527lfb.64.1532959090015;
 Mon, 30 Jul 2018 06:58:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 06:58:09
 -0700 (PDT)
In-Reply-To: <10502231.oSnn9dME1M@avalon>
References: <20180728154007.GA28426@jordon-HP-15-Notebook-PC>
 <CAK-LDbKqU4Yub5H0_6tRpED4DLN8D+XrsUaNT5SN9Oq0sEpBNg@mail.gmail.com>
 <CAFqt6zYy4GfQn0VQ5rfoygY+8M1RQYEv_BH-Jxmv6epoLj3xmw@mail.gmail.com> <10502231.oSnn9dME1M@avalon>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 30 Jul 2018 19:28:09 +0530
Message-ID: <CAFqt6zaiThFYHRGYqTFYVcYK3Z6vCV4qAU0qMMheY7wGyggVrA@mail.gmail.com>
Subject: Re: [PATCH] drm/rcar-du: Convert drm_atomic_helper_suspend/resume()
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Vaishali Thakkar <vthakkar@vaishalithakkar.in>, airlied@linux.ie,
        Ajit Linux <ajitn.linux@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 1:50 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Souptick,
>
> Thank you for the patch.
>
> On Saturday, 28 July 2018 21:50:58 EEST Souptick Joarder wrote:
>> On Sat, Jul 28, 2018 at 11:20 PM, Vaishali Thakkar wrote:
>> > On Sat, Jul 28, 2018 at 9:10 PM, Souptick Joarder wrote:
>> >> convert drm_atomic_helper_suspend/resume() to use
>> >> drm_mode_config_helper_suspend/resume().
>> >
>> > Hi Souptick,
>> >
>> > Thanks for your patch.
>> >
>> >> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> >> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
>> >> ---
>> >>
>> >>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 21 ++-------------------
>> >>  1 file changed, 2 insertions(+), 19 deletions(-)
>> >>
>> >> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>> >> b/drivers/gpu/drm/rcar-du/rcar_du_drv.c index 02aee6c..288220f 100644
>> >> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>> >> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>> >> @@ -357,32 +357,15 @@ static void rcar_du_lastclose(struct drm_device
>> >> *dev)
>> >>
>> >>  static int rcar_du_pm_suspend(struct device *dev)
>> >>  {
>> >>         struct rcar_du_device *rcdu = dev_get_drvdata(dev);
>> >> -       struct drm_atomic_state *state;
>> >>
>> >> -       drm_kms_helper_poll_disable(rcdu->ddev);
>> >> -       drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, true);
>> >> -
>> >> -       state = drm_atomic_helper_suspend(rcdu->ddev);
>> >> -       if (IS_ERR(state)) {
>> >> -               drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
>> >
>> > I don't think we can use drm_mode_config_helper_(suspend/resume)
>> > API here as this file uses CMA functions.
>>
>> drm_fbdev_cma_set_suspend_unlocked() is wrapper function which
>> invokes drm_fb_helper_set_suspend_unlocked().
>>
>> Where the new API drm_mode_config_helper_suspend/resume() directly invokes
>> drm_fb_helper_set_suspend_unlocked(). So it is safe to replace exiting
>> code with API drm_mode_config_helper_suspend/resume().
>

> I agree that they're functionally equivalent for now, but what if
> drm_fbdev_cma_set_suspend_unlocked() gets extended later ? This change risks
> introducing a breakage that could could unnoticed at that point.

No, any extention of drm_fbdev_cma_set_suspend_unlocked() will not have
any impact on driver because with this patch we will be retaining the original
suspend/resume logic of the rcar-du driver and further this driver is not going
to use drm_fbdev_cma_set_suspend_unlocked().


> At the very
> least you should add a comment in drm_fbdev_cma_set_suspend_unlocked() to
> explain that any extension of the function should also address all drivers
> using drm_mode_config_helper_suspend() and drm_mode_config_helper_resume().

The consumers of drm_fbdev_cma_set_suspend_unlocked() are -
drivers/gpu/drm/arm/hdlcd_drv.c
drivers/gpu/drm/drm_fb_cma_helper.c

and both will be converted to use API drm_mode_config_helper_suspend/resume().
As there will be no more consumer of drm_fbdev_cma_set_suspend_unlocked() , we
can remove this wrapper API forever :)

>
>> > And from git grep it seems that there are very few drivers using it at the
>> > moment, so not sure if introducing new API functions similar to
>> > drm_mode_config will make sense or not.
>>
>> https://www.kernel.org/doc/html/latest/gpu/todo.html
>>
>> It was picked up from TODO list after discussing with
>> Daniel.
>>
>> > Thanks.
>> >
>> >> -               drm_kms_helper_poll_enable(rcdu->ddev);
>> >> -               return PTR_ERR(state);
>> >> -       }
>> >> -
>> >> -       rcdu->suspend_state = state;
>
> Additionally, I think you can remove the suspend_state field from the rcdu
> structure.

Sure, I will remove it in v2.

>
>> >> -       return 0;
>> >> +       return drm_mode_config_helper_suspend(rcdu->ddev);
>> >>  }
>> >>
>> >>  static int rcar_du_pm_resume(struct device *dev)
>> >>  {
>> >>         struct rcar_du_device *rcdu = dev_get_drvdata(dev);
>> >>
>> >> -       drm_atomic_helper_resume(rcdu->ddev, rcdu->suspend_state);
>> >> -       drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
>> >> -       drm_kms_helper_poll_enable(rcdu->ddev);
>> >> -
>> >> -       return 0;
>> >> +       return drm_mode_config_helper_resume(rcdu->ddev);
>> >>  }
>> >>  #endif
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>
