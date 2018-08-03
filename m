Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0063FC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986A52172A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RnC0eRdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986A52172A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeHCIzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:55:05 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47524 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbeHCIzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:55:04 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180803070011euoutp018b6a673a569564bf21082af303d86e25~HTa7PYKDn0104801048euoutp01n
        for <linux-kernel@vger.kernel.org>; Fri,  3 Aug 2018 07:00:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180803070011euoutp018b6a673a569564bf21082af303d86e25~HTa7PYKDn0104801048euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533279611;
        bh=h85iLYIP0VEeHSxEM3ci8/tzV6I5P0f1FaqX1SRrYjM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RnC0eRdm8ldndhTNocwd86KOoajNvP869E1/kbBQdVGed1HGDkFOfRbuqXWk2jia5
         JNyDxt9o0cfrxNvCYKcIjKu6o/aqE0DGQUYg/Z+bWVUCidXWJW03mRFzUVTwC8ZJdR
         Sg2zrISqkYeYYsF8DeEeZWFD8s/8/ajFLBu/QSFE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180803070010eucas1p243d7e6bdc745c1476984e77582d5404d~HTa6kR8dj0933209332eucas1p2T;
        Fri,  3 Aug 2018 07:00:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BC.9B.61560.A7DF36B5; Fri,  3
        Aug 2018 08:00:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180803070009eucas1p1583f6df0ce5caf37662e7546f782513b~HTa5xqhex1670416704eucas1p1H;
        Fri,  3 Aug 2018 07:00:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180803070009eusmtrp263235cb8aecfcd498c5e174818d5470a~HTa5ieS7x1367113671eusmtrp2l;
        Fri,  3 Aug 2018 07:00:09 +0000 (GMT)
X-AuditID: cbfec7f5-207ff7000002f078-99-5b63fd7ae4f6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 32.A3.04183.97DF36B5; Fri,  3
        Aug 2018 08:00:09 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180803070008eusmtip131d21f575e289511d911ab584d1d0804~HTa4-GSuI1678016780eusmtip1W;
        Fri,  3 Aug 2018 07:00:08 +0000 (GMT)
Subject: Re: [PATCH v3] gpu/drm/exynos: Convert
 drm_atomic_helper_suspend/resume()
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Inki Dae <inki.dae@samsung.com>, jy0922.shim@samsung.com,
        sw0312.kim@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        airlied@linux.ie, kgene@kernel.org, krzk@kernel.org,
        Ajit Linux <ajitn.linux@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Fri, 3 Aug 2018 09:00:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zYUT72e7CnUF9a3kg5ZjFcPjZViMNm687-FC_9PF5Oc7A@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7djP87pVf5OjDX4+FLXoPXeSyWLN9RZG
        iytf37NZTLo/gcXi2tUGZosX9y6yWPQ/fs1scf78BnaLs01v2C02Pb7GanF51xw2ixnn9zFZ
        zJj8ks2B12PnrLvsHptWdbJ5bP/2gNXjfvdxJo/NS+o9+rasYvT4vEkugD2KyyYlNSezLLVI
        3y6BK2Pj/hfsBf8NKjrur2BtYPyh3sXIySEhYCKxtPEOUxcjF4eQwApGiZe3dzBCOF8YJd5u
        e8YK4XxmlOjpPsrSxcgB1vJhRjhEfDmjxNZzb5khnPeMEovePWUDmSssECJx58lcdhBbREBb
        Yu7hX2BFzAKvmCTO7DzACJJgEzCU6HrbxQYylUVARWJykxmIKSoQI/F7lzVIBa+AoMTJmU9Y
        QGxOgUCJbac6wGxmAXmJ7W/nMEPY4hK3nswHe0FC4CO7RP/07YwQzWUSHzZPY4L400Xi7M3l
        LBC2sMSr41vYIWwZif87YZqbGSXaZ8xih3B6gF6bs4MNospa4vDxi6wg1zELaEqs36UPEXaU
        OPl4MRskVPgkbrwVhDiIT2LStunMEGFeiY42IYhqNYlZx9fBrT144RLzBEalWUjenIXktVlI
        XpuFsHcBI8sqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwIR2+t/xrzsY9/1JOsQowMGo
        xMN7QTU5Wog1say4MvcQowQHs5II79tOoBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeO/1x0UIC
        6YklqdmpqQWpRTBZJg5OqQZG7pk3g/4uPtCw+9iaO8kBW+sO1X7ti5s32YYteU+V5WON6w6H
        7fYs9Yjc1OtycPWr0zEnKl5prwm9xmnfUFi8oyTQ0plT2z9pVzOLgZzrdz2X/bquO3clBU6r
        k22Q0naIlAmt0Jm95IEC+yztRt8fPoo3Urp2ue3eGe+WN1HePcaHTeBqXrASS3FGoqEWc1Fx
        IgBAnF7uZAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xu7qVf5OjDc62yFn0njvJZLHmeguj
        xZWv79ksJt2fwGJx7WoDs8WLexdZLPofv2a2OH9+A7vF2aY37BabHl9jtbi8aw6bxYzz+5gs
        Zkx+yebA67Fz1l12j02rOtk8tn97wOpxv/s4k8fmJfUefVtWMXp83iQXwB6lZ1OUX1qSqpCR
        X1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7Fx/wv2gv8GFR33V7A2
        MP5Q72Lk4JAQMJH4MCO8i5GLQ0hgKaPEwnk/WLoYOYHiMhInpzWwQtjCEn+udbFBFL1llNiy
        5C4zSEJYIETizpO57CC2iIC2xNzDv5hBipgFXjFJrP5/jgmi4wiTxPNzU8E62AQMJbregozi
        5OAVsJO4cGImG8gZLAIqEpObzEDCogIxEkcnt0CVCEqcnPkE7CJOgUCJbac6wGxmATOJeZsf
        MkPY8hLb386BssUlbj2ZzzSBUWgWkvZZSFpmIWmZhaRlASPLKkaR1NLi3PTcYiO94sTc4tK8
        dL3k/NxNjMAY3nbs55YdjF3vgg8xCnAwKvHwXlBNjhZiTSwrrsw9xCjBwawkwvu2EyjEm5JY
        WZValB9fVJqTWnyI0RTot4nMUqLJ+cD0klcSb2hqaG5haWhubG5sZqEkznveoDJKSCA9sSQ1
        OzW1ILUIpo+Jg1OqgVFWuaD6u3eYzA3VLVZfrxe0Pzj7rNf12IXKmF+vppyKS0z2vfn1fJNG
        soSIyVfec/eXK3r77Nh1kb9je4rnXQWJbx+/yUz88VXh/+un7usdWnxtxTclXvrKf7V+wUvb
        4GU/7zfy9O73nSv6tfNlc42hyKqeq6oL4vYl7xYV3nOpTaZZu/xRqo4SS3FGoqEWc1FxIgCt
        33RH9wIAAA==
Message-Id: <20180803070009eucas1p1583f6df0ce5caf37662e7546f782513b~HTa5xqhex1670416704eucas1p1H@eucas1p1.samsung.com>
X-CMS-MailID: 20180803070009eucas1p1583f6df0ce5caf37662e7546f782513b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180802131924epcas4p105dc354b2ee651e70a5e777850222bc5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180802131924epcas4p105dc354b2ee651e70a5e777850222bc5
References: <CGME20180802131924epcas4p105dc354b2ee651e70a5e777850222bc5@epcas4p1.samsung.com>
        <20180802132152.GA2833@jordon-HP-15-Notebook-PC>
        <20180802133852eucas1p1de66cfd2db5ed0c87665567455ea4747~HFNvAtE4-1249412494eucas1p1c@eucas1p1.samsung.com>
        <CAFqt6zYUT72e7CnUF9a3kg5ZjFcPjZViMNm687-FC_9PF5Oc7A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018-08-02 17:51, Souptick Joarder wrote:
> On Thu, Aug 2, 2018 at 7:08 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> On 2018-08-02 15:21, Souptick Joarder wrote:
>>> convert drm_atomic_helper_suspend/resume() to use
>>> drm_mode_config_helper_suspend/resume().
>>>
>>> exynos_drm_fbdev_suspend/resume can be removed
>>> as drm_mode_config_helper_suspend/resume has
>>> implement the same in generic way.
>>>
>>> Remove suspend_state from exynos_drm_private
>>> struct as it is no more useful.
>>>
>>> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> ---
>>> v2: Address Inki Dae's comment. Remove ret variable
>>>       from both suspend/resume function.
>>>
>>> v3: Tested by Marek. Updated the change log.
>>>
>>>    drivers/gpu/drm/exynos/exynos_drm_drv.c   | 26 ++------------------------
>>>    drivers/gpu/drm/exynos/exynos_drm_drv.h   |  1 -
>>>    drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 17 -----------------
>>>    drivers/gpu/drm/exynos/exynos_drm_fbdev.h | 10 ----------
>>>    4 files changed, 2 insertions(+), 52 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
>>> index b599f74..d86dd81 100644
>>> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
>>> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
>>> @@ -149,37 +149,15 @@ static void exynos_drm_postclose(struct drm_device *dev, struct drm_file *file)
>>>    static int exynos_drm_suspend(struct device *dev)
>>>    {
>>>        struct drm_device *drm_dev = dev_get_drvdata(dev);
>>> -     struct exynos_drm_private *private;
>>> -
>>> -     if (!drm_dev)
>>> -             return 0;
>>> -
>>> -     private = drm_dev->dev_private;
>>> -
>>> -     drm_kms_helper_poll_disable(drm_dev);
>>> -     exynos_drm_fbdev_suspend(drm_dev);
>>> -     private->suspend_state = drm_atomic_helper_suspend(drm_dev);
>>> -     if (IS_ERR(private->suspend_state)) {
>>> -             exynos_drm_fbdev_resume(drm_dev);
>>> -             drm_kms_helper_poll_enable(drm_dev);
>>> -             return PTR_ERR(private->suspend_state);
>>> -     }
>>>
>>> -     return 0;
>>> +     return  drm_mode_config_helper_suspend(drm_dev);
>>>    }
>>>
>>>    static void exynos_drm_resume(struct device *dev)
>>>    {
>>>        struct drm_device *drm_dev = dev_get_drvdata(dev);
>>> -     struct exynos_drm_private *private;
>>> -
>>> -     if (!drm_dev)
>>> -             return;
>>>
>>> -     private = drm_dev->dev_private;
>>> -     drm_atomic_helper_resume(drm_dev, private->suspend_state);
>>> -     exynos_drm_fbdev_resume(drm_dev);
>>> -     drm_kms_helper_poll_enable(drm_dev);
>>> +     return drm_mode_config_helper_resume(drm_dev);
>> exynos_drm_resume() now returns 'void', so to be strict with
>> c standard, the return statement should not be used here.
> But in struct dev_pm_ops, it is still defined as
>
>                  int (*resume)(struct device *dev);
>
> I think, we need to correct the return type of
> exynos_drm_resume() to int.

Nope. After commit dc684af6fc8d ("drm/exynos: Suspend/resume display
pipeline as early/late as possible") exynos_drm_resume() is assigned
to .complete callback, which use 'void' return type, so for now no
more changes are needed.

> Although I posted v4.
>
>
>>>    }
>>>
>>>    static const struct dev_pm_ops exynos_drm_pm_ops = {
>>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
>>> index c737c4b..7349e7c 100644
>>> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
>>> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
>>> @@ -195,7 +195,6 @@ struct drm_exynos_file_private {
>>>     */
>>>    struct exynos_drm_private {
>>>        struct drm_fb_helper *fb_helper;
>>> -     struct drm_atomic_state *suspend_state;
>>>
>>>        struct device *g2d_dev;
>>>        struct device *dma_dev;
>>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>>> index 132dd52..918dd2c 100644
>>> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>>> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>>> @@ -270,20 +270,3 @@ void exynos_drm_fbdev_fini(struct drm_device *dev)
>>>        private->fb_helper = NULL;
>>>    }
>>>
>>> -void exynos_drm_fbdev_suspend(struct drm_device *dev)
>>> -{
>>> -     struct exynos_drm_private *private = dev->dev_private;
>>> -
>>> -     console_lock();
>>> -     drm_fb_helper_set_suspend(private->fb_helper, 1);
>>> -     console_unlock();
>>> -}
>>> -
>>> -void exynos_drm_fbdev_resume(struct drm_device *dev)
>>> -{
>>> -     struct exynos_drm_private *private = dev->dev_private;
>>> -
>>> -     console_lock();
>>> -     drm_fb_helper_set_suspend(private->fb_helper, 0);
>>> -     console_unlock();
>>> -}
>>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
>>> index b338472..6840b6a 100644
>>> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
>>> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
>>> @@ -19,8 +19,6 @@
>>>
>>>    int exynos_drm_fbdev_init(struct drm_device *dev);
>>>    void exynos_drm_fbdev_fini(struct drm_device *dev);
>>> -void exynos_drm_fbdev_suspend(struct drm_device *drm);
>>> -void exynos_drm_fbdev_resume(struct drm_device *drm);
>>>
>>>    #else
>>>
>>> @@ -39,14 +37,6 @@ static inline void exynos_drm_fbdev_restore_mode(struct drm_device *dev)
>>>
>>>    #define exynos_drm_output_poll_changed (NULL)
>>>
>>> -static inline void exynos_drm_fbdev_suspend(struct drm_device *drm)
>>> -{
>>> -}
>>> -
>>> -static inline void exynos_drm_fbdev_resume(struct drm_device *drm)
>>> -{
>>> -}
>>> -
>>>    #endif
>>>
>>>    #endif
>> Best regards
>> --
>> Marek Szyprowski, PhD
>> Samsung R&D Institute Poland
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

