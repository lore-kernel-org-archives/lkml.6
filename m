Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A155160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0173320890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmJXXQut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0173320890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeG3Qsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:48:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37854 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeG3Qsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:48:41 -0400
Received: by mail-lf1-f67.google.com with SMTP id j8-v6so8406041lfb.4;
        Mon, 30 Jul 2018 08:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6XSZXyxG8AwriBM2Dvm0e/BNj58B0jvV5fL1OjEcJ/A=;
        b=VmJXXQutyDAbQ11OsV3jZW6vgzqq/cae3tr2UnNq5mN1DkQGjzqfdpLioX9zrnVJmH
         suEQSqf4xjSFWvLOSbD/CEdJnAawPuMnS1UzKbsQue0bl8YJRrYirJfrJdTFXa9SGPvp
         FXxl00ukEqRlwOjPtACVKn/pg8vh7jg/pSTaWoCyoKQOwpUd6JV8C0MvdqV3ud6KCSvS
         25TYT/40Q2QZxVuhMOXP+EWB3rRYNjBm0XztGmd3Kw0h/jPljewGzh8xjjnvLqwqptiS
         6cqE/zt5HsUW3Cu1orWF2MZdJ+Eq7ZCeAdvV90fw7iQ/S+adJEPuBbHGfobvfUSvpl8b
         EmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6XSZXyxG8AwriBM2Dvm0e/BNj58B0jvV5fL1OjEcJ/A=;
        b=GjHEME0aNz5q/26AxnfRnzFoBeU6MOd2GaXGmB1VLy1NSvZjNxsEkT3WdWBtYn8GzS
         g7hx8kdMZhKVj/IKYGceonaHQk7j4/h1LBknBPQLVO8+zzSixDEvkwV2akmvf7bVEhdy
         49o6UYidz2D4eVoZUOGjxnj8sT1WBGR/6tQJ2C2Tr3+5nZcxZnkD4Ssui8Ld8yPTplv2
         29UAAB1TW6FaJj0OLwFl458jlCRheJvKxMihloCieOaEuyn1tQdaiw4QKEVxpWhFg9m/
         mGQxytQu1jUNN22cXQbtkphb5x459lsJG5rmY/ZuG1rG8WG/SHr9HLtxxvaCfZGrxiKS
         uQ8A==
X-Gm-Message-State: AOUpUlE4XbX83DASpX22arr5AjBGgDkrNBvGkXRPzW/b0m5CvBR/tI37
        kdgiHpsK9xX6WnfQ5ekgkDv5nAht/2I9D23p+k0=
X-Google-Smtp-Source: AAOMgpfrimvxM64NrcULgb7Y64RyZ7ds/nDW0BAWUBI0Pgi3N/EdQQCZDRR/zB6BciZV76PjBa8EwhjD4kaJhtIOIqE=
X-Received: by 2002:a19:1604:: with SMTP id m4-v6mr10327986lfi.120.1532963593807;
 Mon, 30 Jul 2018 08:13:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 08:13:13
 -0700 (PDT)
In-Reply-To: <2566982.Bc5DNITNHH@avalon>
References: <20180728154007.GA28426@jordon-HP-15-Notebook-PC>
 <10502231.oSnn9dME1M@avalon> <CAFqt6zaiThFYHRGYqTFYVcYK3Z6vCV4qAU0qMMheY7wGyggVrA@mail.gmail.com>
 <2566982.Bc5DNITNHH@avalon>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 30 Jul 2018 20:43:13 +0530
Message-ID: <CAFqt6zb_8a8G1DRRVpYDEjvzhgOzOK-O4K+oFzhVE-ELyX8Djw@mail.gmail.com>
Subject: Re: [PATCH] drm/rcar-du: Convert drm_atomic_helper_suspend/resume()
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        airlied@linux.ie, Daniel Vetter <daniel@ffwll.ch>
Cc:     Vaishali Thakkar <vthakkar@vaishalithakkar.in>,
        Ajit Linux <ajitn.linux@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 7:54 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Souptick,
>
> On Monday, 30 July 2018 16:58:09 EEST Souptick Joarder wrote:
>> On Sun, Jul 29, 2018 at 1:50 AM, Laurent Pinchart wrote:
>> > On Saturday, 28 July 2018 21:50:58 EEST Souptick Joarder wrote:
>> >> On Sat, Jul 28, 2018 at 11:20 PM, Vaishali Thakkar wrote:
>> >>> On Sat, Jul 28, 2018 at 9:10 PM, Souptick Joarder wrote:
>> >>>> convert drm_atomic_helper_suspend/resume() to use
>> >>>> drm_mode_config_helper_suspend/resume().
>> >>>
>> >>> Hi Souptick,
>> >>>
>> >>> Thanks for your patch.
>> >>>
>> >>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> >>>> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
>> >>>> ---
>> >>>>
>> >>>>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 21 ++-------------------
>> >>>>  1 file changed, 2 insertions(+), 19 deletions(-)
>> >>>>
>> >>>> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>> >>>> b/drivers/gpu/drm/rcar-du/rcar_du_drv.c index 02aee6c..288220f 100644
>> >>>> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>> >>>> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>> >>>> @@ -357,32 +357,15 @@ static void rcar_du_lastclose(struct drm_device
>> >>>> *dev)
>> >>>>
>> >>>>  static int rcar_du_pm_suspend(struct device *dev)
>> >>>>  {
>> >>>>         struct rcar_du_device *rcdu = dev_get_drvdata(dev);
>> >>>> -       struct drm_atomic_state *state;
>> >>>>
>> >>>> -       drm_kms_helper_poll_disable(rcdu->ddev);
>> >>>> -       drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, true);
>> >>>> -
>> >>>> -       state = drm_atomic_helper_suspend(rcdu->ddev);
>> >>>> -       if (IS_ERR(state)) {
>> >>>> -               drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev,
>> >>>> false);
>> >>>
>> >>> I don't think we can use drm_mode_config_helper_(suspend/resume)
>> >>> API here as this file uses CMA functions.
>> >>
>> >> drm_fbdev_cma_set_suspend_unlocked() is wrapper function which
>> >> invokes drm_fb_helper_set_suspend_unlocked().
>> >>
>> >> Where the new API drm_mode_config_helper_suspend/resume() directly
>> >> invokes
>> >> drm_fb_helper_set_suspend_unlocked(). So it is safe to replace exiting
>> >> code with API drm_mode_config_helper_suspend/resume().
>> >
>> > I agree that they're functionally equivalent for now, but what if
>> > drm_fbdev_cma_set_suspend_unlocked() gets extended later ? This change
>> > risks introducing a breakage that could could unnoticed at that point.
>>
>> No, any extention of drm_fbdev_cma_set_suspend_unlocked() will not have
>> any impact on driver because with this patch we will be retaining the
>> original suspend/resume logic of the rcar-du driver and further this driver
>> is not going to use drm_fbdev_cma_set_suspend_unlocked().
>
> My point is that if the fb cma helpers gets later extended with a feature that
> need special handling and suspend/resume time, with the
> drm_fbdev_cma_set_suspend_unlocked() function properly updated to take that
> feature into account, driver using those helpers but converted to
> drm_atomic_helper_suspend/resume() will break.
>
>> > At the very
>> > least you should add a comment in drm_fbdev_cma_set_suspend_unlocked() to
>> > explain that any extension of the function should also address all drivers
>> > using drm_mode_config_helper_suspend() and
>> > drm_mode_config_helper_resume().
>>
>> The consumers of drm_fbdev_cma_set_suspend_unlocked() are -
>> drivers/gpu/drm/arm/hdlcd_drv.c
>> drivers/gpu/drm/drm_fb_cma_helper.c
>>
>> and both will be converted to use API
>> drm_mode_config_helper_suspend/resume(). As there will be no more consumer
>> of drm_fbdev_cma_set_suspend_unlocked() , we can remove this wrapper API
>> forever :)
>
> OK, if you remove the function completely then anyone wanting to extend the
> fbdev cma helpers in the way described above will notice that something will
> need to be done, so it's fine. Please thus make sure that you go all the way
> to removing that function.
>

Sure, once both the drivers are converted to use
drm_mode_config_helper_suspend/resume()
and goes into linus's tree, then we can remove it.

But will wait for some more feedback before concluding on this.

Dave/ Daniel, Would you like to add any feedback ?

>> >>> And from git grep it seems that there are very few drivers using it at
>> >>> the moment, so not sure if introducing new API functions similar to
>> >>> drm_mode_config will make sense or not.
>> >>
>> >> https://www.kernel.org/doc/html/latest/gpu/todo.html
>> >>
>> >> It was picked up from TODO list after discussing with
>> >> Daniel.
>> >>
>> >> >> -               drm_kms_helper_poll_enable(rcdu->ddev);
>> >> >> -               return PTR_ERR(state);
>> >> >> -       }
>> >> >> -
>> >> >> -       rcdu->suspend_state = state;
>> >
>> > Additionally, I think you can remove the suspend_state field from the rcdu
>> > structure.
>>
>> Sure, I will remove it in v2.
>>
>> >>>> -       return 0;
>> >>>> +       return drm_mode_config_helper_suspend(rcdu->ddev);
>> >>>>  }
>> >>>>
>> >>>>  static int rcar_du_pm_resume(struct device *dev)
>> >>>>  {
>> >>>>         struct rcar_du_device *rcdu = dev_get_drvdata(dev);
>> >>>>
>> >>>> -       drm_atomic_helper_resume(rcdu->ddev, rcdu->suspend_state);
>> >>>> -       drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
>> >>>> -       drm_kms_helper_poll_enable(rcdu->ddev);
>> >>>> -
>> >>>> -       return 0;
>> >>>> +       return drm_mode_config_helper_resume(rcdu->ddev);
>> >>>>  }
>> >>>>  #endif
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>
