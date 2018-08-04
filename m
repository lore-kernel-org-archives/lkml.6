Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4484CC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C5B217CE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYwb33BF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C5B217CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeHDQd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 12:33:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36727 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbeHDQd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 12:33:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id u7-v6so7194066lji.3;
        Sat, 04 Aug 2018 07:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DgcZreRMYLOdfYFa+Q7tX6d6TLhfI9AZ5iLLQXABGps=;
        b=PYwb33BF9Hdu+DlwDQt29GBRq/K14oQx/OxbfgqSPeVwSyyeiBhLy827bypUCjDQd9
         u83UBcyZeo3kT89nSLajgpo7br1m21+ISnCtgiJvTmv5cmmopMYF5O4dWzVzntpZpdXS
         ompR+eayq28anVv4lfiKwBC1rHohToi5L421AaMYEtuWi9whUWB6Z2NW+gSomu8Paja9
         1I0zg1Q0NFv08iUC54OmV7/hq25s3EUIFsNcL8KUKTZU/qDgCMmU25oCZKivSAM8nEau
         omPCzB3XZxF6Awif1YNiT7paOKvHMFkZY90/tP2/jqpX/CfhUjfkafloP0hB5LciMzfB
         hV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DgcZreRMYLOdfYFa+Q7tX6d6TLhfI9AZ5iLLQXABGps=;
        b=YVBSYr29rWEE5dnhqzcnuGJirhKNRoSagCqxKfd2UDAa35nrqr88ZMXakuRFwM3Acz
         orm0V+3YLUa4+Fzld7KS47gufYUpJ9rIT0e4ieJWzBSihXHUqs/PgJTZvg+O8yCrwv8L
         yLhN3L2yYoeuRm9pf5OYOM6zrEuhnMcCd+n1nfQ2TLHUNzs3rL7kSywVhCFl9q3ohbCn
         xQUqmllCmyifnjK7aG7pyq1plgsYbf5Rztf1fdIz0gCUjsiinhzLdV4oL7FaD7sDKCVq
         p2DGONg/Bxgb2pycIwPGOsZjOtLFqJLFBd7LP0OPEqz4Z4rlV6Rqrn1eFG0AGsVMz4xz
         dY6w==
X-Gm-Message-State: AOUpUlFQRJVU89JSkvIHHxVeL4uwsrsEFqMr/G5KF+iV4W6jDgR9CU41
        elDKJYzuWQ55bvHLfD3sGVX4t7u95KB9cxP5T5A=
X-Google-Smtp-Source: AAOMgpdCrlqWSf+5N4jcBSPPeUTKHNIvFSvAKVAIlY5PwAJQjmpra9L/KMtFLcinui0NQQVhdQRCNmXfcF/gVvuQOzQ=
X-Received: by 2002:a2e:5617:: with SMTP id k23-v6mr8092218ljb.86.1533393151191;
 Sat, 04 Aug 2018 07:32:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Sat, 4 Aug 2018 07:32:30 -0700 (PDT)
In-Reply-To: <20180803070009eucas1p1583f6df0ce5caf37662e7546f782513b~HTa5xqhex1670416704eucas1p1H@eucas1p1.samsung.com>
References: <CGME20180802131924epcas4p105dc354b2ee651e70a5e777850222bc5@epcas4p1.samsung.com>
 <20180802132152.GA2833@jordon-HP-15-Notebook-PC> <20180802133852eucas1p1de66cfd2db5ed0c87665567455ea4747~HFNvAtE4-1249412494eucas1p1c@eucas1p1.samsung.com>
 <CAFqt6zYUT72e7CnUF9a3kg5ZjFcPjZViMNm687-FC_9PF5Oc7A@mail.gmail.com> <20180803070009eucas1p1583f6df0ce5caf37662e7546f782513b~HTa5xqhex1670416704eucas1p1H@eucas1p1.samsung.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 4 Aug 2018 20:02:30 +0530
Message-ID: <CAFqt6zYxV6K4oZUXVaYLifx3xqPxPs9v5-BmAOfm6hG04g6hvA@mail.gmail.com>
Subject: Re: [PATCH v3] gpu/drm/exynos: Convert drm_atomic_helper_suspend/resume()
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Inki Dae <inki.dae@samsung.com>, jy0922.shim@samsung.com,
        sw0312.kim@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        airlied@linux.ie, kgene@kernel.org, krzk@kernel.org,
        Ajit Linux <ajitn.linux@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 12:30 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hi,
>
> On 2018-08-02 17:51, Souptick Joarder wrote:
>> On Thu, Aug 2, 2018 at 7:08 PM, Marek Szyprowski
>> <m.szyprowski@samsung.com> wrote:
>>> On 2018-08-02 15:21, Souptick Joarder wrote:
>>>> convert drm_atomic_helper_suspend/resume() to use
>>>> drm_mode_config_helper_suspend/resume().
>>>>
>>>> exynos_drm_fbdev_suspend/resume can be removed
>>>> as drm_mode_config_helper_suspend/resume has
>>>> implement the same in generic way.
>>>>
>>>> Remove suspend_state from exynos_drm_private
>>>> struct as it is no more useful.
>>>>
>>>> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
>>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> ---
>>>> v2: Address Inki Dae's comment. Remove ret variable
>>>>       from both suspend/resume function.
>>>>
>>>> v3: Tested by Marek. Updated the change log.
>>>>
>>>>    drivers/gpu/drm/exynos/exynos_drm_drv.c   | 26 ++------------------------
>>>>    drivers/gpu/drm/exynos/exynos_drm_drv.h   |  1 -
>>>>    drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 17 -----------------
>>>>    drivers/gpu/drm/exynos/exynos_drm_fbdev.h | 10 ----------
>>>>    4 files changed, 2 insertions(+), 52 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
>>>> index b599f74..d86dd81 100644
>>>> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
>>>> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
>>>> @@ -149,37 +149,15 @@ static void exynos_drm_postclose(struct drm_device *dev, struct drm_file *file)
>>>>    static int exynos_drm_suspend(struct device *dev)
>>>>    {
>>>>        struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>> -     struct exynos_drm_private *private;
>>>> -
>>>> -     if (!drm_dev)
>>>> -             return 0;
>>>> -
>>>> -     private = drm_dev->dev_private;
>>>> -
>>>> -     drm_kms_helper_poll_disable(drm_dev);
>>>> -     exynos_drm_fbdev_suspend(drm_dev);
>>>> -     private->suspend_state = drm_atomic_helper_suspend(drm_dev);
>>>> -     if (IS_ERR(private->suspend_state)) {
>>>> -             exynos_drm_fbdev_resume(drm_dev);
>>>> -             drm_kms_helper_poll_enable(drm_dev);
>>>> -             return PTR_ERR(private->suspend_state);
>>>> -     }
>>>>
>>>> -     return 0;
>>>> +     return  drm_mode_config_helper_suspend(drm_dev);
>>>>    }
>>>>
>>>>    static void exynos_drm_resume(struct device *dev)
>>>>    {
>>>>        struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>> -     struct exynos_drm_private *private;
>>>> -
>>>> -     if (!drm_dev)
>>>> -             return;
>>>>
>>>> -     private = drm_dev->dev_private;
>>>> -     drm_atomic_helper_resume(drm_dev, private->suspend_state);
>>>> -     exynos_drm_fbdev_resume(drm_dev);
>>>> -     drm_kms_helper_poll_enable(drm_dev);
>>>> +     return drm_mode_config_helper_resume(drm_dev);
>>> exynos_drm_resume() now returns 'void', so to be strict with
>>> c standard, the return statement should not be used here.
>> But in struct dev_pm_ops, it is still defined as
>>
>>                  int (*resume)(struct device *dev);
>>
>> I think, we need to correct the return type of
>> exynos_drm_resume() to int.
>
> Nope. After commit dc684af6fc8d ("drm/exynos: Suspend/resume display
> pipeline as early/late as possible") exynos_drm_resume() is assigned
> to .complete callback, which use 'void' return type, so for now no
> more changes are needed.

Ok, then v4 is the right candidate to go.

>
>> Although I posted v4.
>>
>>
>>>>    }
>>>>
>>>>    static const struct dev_pm_ops exynos_drm_pm_ops = {
>>>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
>>>> index c737c4b..7349e7c 100644
>>>> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
>>>> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
>>>> @@ -195,7 +195,6 @@ struct drm_exynos_file_private {
>>>>     */
>>>>    struct exynos_drm_private {
>>>>        struct drm_fb_helper *fb_helper;
>>>> -     struct drm_atomic_state *suspend_state;
>>>>
>>>>        struct device *g2d_dev;
>>>>        struct device *dma_dev;
>>>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>>>> index 132dd52..918dd2c 100644
>>>> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>>>> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>>>> @@ -270,20 +270,3 @@ void exynos_drm_fbdev_fini(struct drm_device *dev)
>>>>        private->fb_helper = NULL;
>>>>    }
>>>>
>>>> -void exynos_drm_fbdev_suspend(struct drm_device *dev)
>>>> -{
>>>> -     struct exynos_drm_private *private = dev->dev_private;
>>>> -
>>>> -     console_lock();
>>>> -     drm_fb_helper_set_suspend(private->fb_helper, 1);
>>>> -     console_unlock();
>>>> -}
>>>> -
>>>> -void exynos_drm_fbdev_resume(struct drm_device *dev)
>>>> -{
>>>> -     struct exynos_drm_private *private = dev->dev_private;
>>>> -
>>>> -     console_lock();
>>>> -     drm_fb_helper_set_suspend(private->fb_helper, 0);
>>>> -     console_unlock();
>>>> -}
>>>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
>>>> index b338472..6840b6a 100644
>>>> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
>>>> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
>>>> @@ -19,8 +19,6 @@
>>>>
>>>>    int exynos_drm_fbdev_init(struct drm_device *dev);
>>>>    void exynos_drm_fbdev_fini(struct drm_device *dev);
>>>> -void exynos_drm_fbdev_suspend(struct drm_device *drm);
>>>> -void exynos_drm_fbdev_resume(struct drm_device *drm);
>>>>
>>>>    #else
>>>>
>>>> @@ -39,14 +37,6 @@ static inline void exynos_drm_fbdev_restore_mode(struct drm_device *dev)
>>>>
>>>>    #define exynos_drm_output_poll_changed (NULL)
>>>>
>>>> -static inline void exynos_drm_fbdev_suspend(struct drm_device *drm)
>>>> -{
>>>> -}
>>>> -
>>>> -static inline void exynos_drm_fbdev_resume(struct drm_device *drm)
>>>> -{
>>>> -}
>>>> -
>>>>    #endif
>>>>
>>>>    #endif
>>> Best regards
>>> --
>>> Marek Szyprowski, PhD
>>> Samsung R&D Institute Poland
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
