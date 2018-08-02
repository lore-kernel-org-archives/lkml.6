Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9B8C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3549321501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XWqK7RV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3549321501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387530AbeHBPaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:30:11 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40465 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387438AbeHBPaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:30:11 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180802133854euoutp02ef2bcd2dbd05fe33f5f6658abc7ad179~HFNws3OXe0633906339euoutp02O
        for <linux-kernel@vger.kernel.org>; Thu,  2 Aug 2018 13:38:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180802133854euoutp02ef2bcd2dbd05fe33f5f6658abc7ad179~HFNws3OXe0633906339euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533217134;
        bh=gHU90kTKgqalnVZuKx+qD8YLeEt/FU2bhnT7IeXYL/E=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=XWqK7RV//moq6HeQtnmII1gHcSg/CvqcoMTeYint/hvLHhMInJ65Z5Oifv2HLFG7l
         W15fX3HIhKS+d3hd4O33ZEtqL//mguu50gERleOTWStGkvoeDoOEHk9UROM+GDob3u
         nqzdHFyGF14JCFuGr6nTMKnUOM3z0+whcRN+/SG0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180802133853eucas1p27f94b27d9cc7c927620e0958050c4585~HFNv63ixa1650216502eucas1p2L;
        Thu,  2 Aug 2018 13:38:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3F.0A.61560.C69036B5; Thu,  2
        Aug 2018 14:38:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180802133852eucas1p1de66cfd2db5ed0c87665567455ea4747~HFNvAtE4-1249412494eucas1p1c;
        Thu,  2 Aug 2018 13:38:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180802133852eusmtrp15c301d2e045a64928ee8461486830965~HFNu-M-6z1163411634eusmtrp1R;
        Thu,  2 Aug 2018 13:38:52 +0000 (GMT)
X-AuditID: cbfec7f5-1edff7000002f078-b9-5b63096cced8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 54.13.04183.C69036B5; Thu,  2
        Aug 2018 14:38:52 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180802133851eusmtip1ef8b60319ee91d6f6823d9d3f6c36ba4~HFNubatBS1464914649eusmtip1F;
        Thu,  2 Aug 2018 13:38:51 +0000 (GMT)
Subject: Re: [PATCH v3] gpu/drm/exynos: Convert
 drm_atomic_helper_suspend/resume()
To:     Souptick Joarder <jrdr.linux@gmail.com>, inki.dae@samsung.com,
        jy0922.shim@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, airlied@linux.ie, kgene@kernel.org,
        krzk@kernel.org, ajitn.linux@gmail.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Thu, 2 Aug 2018 15:38:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802132152.GA2833@jordon-HP-15-Notebook-PC>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRj1t3t3dzVnP6fhh4WP4aOHaVLQBTM0DPZHkH9EUEY19aLWnLK5
        pVL4tvKNUumwkpIsi7T5tjJUcAzJOS0THyn5yMplPlGTaPP28L/zne8cvnPgowmRke9Mx8gT
        WIVcKhNTNmRj11rPfpl1RNiBsU6Gye/R85hnHzIR8255jmKKx4pIZuB9KsHMfDSSTOHEN4Ix
        GGoFzNv0WQGjnRjgM/2t5RRTamjjMaUlX6ggoaRFMyqQaKtvUpKmlXG+ZCxXx5PUVaZICuqr
        kWRR6xIqOGtzJJKVxahZhd/RizbRlcZVKv61V2LzlG0quu2Wg6xpwIdgtbaUl4NsaBF+jGC8
        fZnkhiUENUXThEUlwosI1jLP/HU8XUijOFEVgpdN2j+OOQQVBTV8i8oBn4KRybsCC3bEowj6
        ZzwtIgLnITD8qNxcUNgfckw5lAWT2AMW+obMmKZ34HPwszXAQguxPejLJkkLtsaBsDE9vykn
        sCs0mcoJDjvB0OT9zQ6ATQIYMOaTnFkNpmE9wcUOgdmyRR6HHeCrrl7A4V3QXZJHcuYMBNdL
        NQJuMCdtKG+mOFUAdOqMfEs6Au+BmlY/jg4G/cTDzdCA7WDQZM8FsoPixjsERwvhRraIU3uB
        Rvf839n23j6iCIk1W2pqtlTTbKmm+X+3ApHVyIlVKWOjWOVBOXvFVymNVarkUb4RcbFaZH60
        7l+65WbUthHegTCNxLbCQavwMBFfqlYmxXYgoAmxozBDYqaEkdKkZFYRd0GhkrHKDrSTJsVO
        wpHC82EiHCVNYC+zbDyr+Lvl0dbOqahgKXDA+Gr2RGZDvSnjZFbopbDp5FSV7e7DPp8fBeWm
        17lmBqa1CbOvFutnsvrjm9gVptZTf6/hOP+Be4pbuX3L94j5BlWVeuHTut+2td43k+w1fShT
        XUS/CDZ6l1jdks97FIeEK047rPi42AUlendV8DY2kvNl2/cdW3dXTz0ZFpPKaKn/XkKhlP4G
        FZLej2QDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsVy+t/xu7o5nMnRBtdusFv0njvJZLHmeguj
        xZWv79ksJt2fwGJx7WoDs8WLexdZLPofv2a2OH9+A7vF2aY37BabHl9jtbi8aw6bxYzz+5gs
        Zkx+yebA67Fz1l12j02rOtk8tn97wOpxv/s4k8fmJfUefVtWMXp83iQXwB6lZ1OUX1qSqpCR
        X1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7Hk4g+2gr1qFTue8jQw
        TlPoYuTkkBAwkVj9qZGti5GLQ0hgKaPE/JnnWCASMhInpzWwQtjCEn+udUEVvWWUuPb+ATNI
        QlggROLOk7nsIAkRgbuMEmc2bWcEcZgFehgldpydyQ7RMoFRYveapUwgLWwChhJdb0FmcXLw
        CthJLPhwih3EZhFQkfh06RZYXFQgRuLo5BaoGkGJkzOfgN3EKWAr8efZR7A4s4CZxLzND5kh
        bHmJ7W/nQNniEreezGeawCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGRXnFibnFpXrpe
        cn7uJkZgHG879nPLDsaud8GHGAU4GJV4eG8wJEULsSaWFVfmHmKU4GBWEuFt9gAK8aYkVlal
        FuXHF5XmpBYfYjQFem4is5Rocj4wxeSVxBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5N
        LUgtgulj4uCUamA017vav1nb/U53R+mzt3+fzK0SO3JNaYvYtB4hnYtJO1P3dDRuWBSabNJ8
        bNoytZdyn7xZ482z8uvWnbO+UxfUuffpBMNFTye2Nr76Kenz1MFNdNvCmbN19LXK7nE4iz5d
        8kE/zd1qg+i+RboqP5676CSeCrulcGmr5ba0186hNhW7WK7O71muxFKckWioxVxUnAgAojr3
        lvkCAAA=
Message-Id: <20180802133852eucas1p1de66cfd2db5ed0c87665567455ea4747~HFNvAtE4-1249412494eucas1p1c@eucas1p1.samsung.com>
X-CMS-MailID: 20180802133852eucas1p1de66cfd2db5ed0c87665567455ea4747
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180802131924epcas4p105dc354b2ee651e70a5e777850222bc5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180802131924epcas4p105dc354b2ee651e70a5e777850222bc5
References: <CGME20180802131924epcas4p105dc354b2ee651e70a5e777850222bc5@epcas4p1.samsung.com>
        <20180802132152.GA2833@jordon-HP-15-Notebook-PC>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018-08-02 15:21, Souptick Joarder wrote:
> convert drm_atomic_helper_suspend/resume() to use
> drm_mode_config_helper_suspend/resume().
>
> exynos_drm_fbdev_suspend/resume can be removed
> as drm_mode_config_helper_suspend/resume has
> implement the same in generic way.
>
> Remove suspend_state from exynos_drm_private
> struct as it is no more useful.
>
> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v2: Address Inki Dae's comment. Remove ret variable
>      from both suspend/resume function.
>
> v3: Tested by Marek. Updated the change log.
>
>   drivers/gpu/drm/exynos/exynos_drm_drv.c   | 26 ++------------------------
>   drivers/gpu/drm/exynos/exynos_drm_drv.h   |  1 -
>   drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 17 -----------------
>   drivers/gpu/drm/exynos/exynos_drm_fbdev.h | 10 ----------
>   4 files changed, 2 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> index b599f74..d86dd81 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> @@ -149,37 +149,15 @@ static void exynos_drm_postclose(struct drm_device *dev, struct drm_file *file)
>   static int exynos_drm_suspend(struct device *dev)
>   {
>   	struct drm_device *drm_dev = dev_get_drvdata(dev);
> -	struct exynos_drm_private *private;
> -
> -	if (!drm_dev)
> -		return 0;
> -
> -	private = drm_dev->dev_private;
> -
> -	drm_kms_helper_poll_disable(drm_dev);
> -	exynos_drm_fbdev_suspend(drm_dev);
> -	private->suspend_state = drm_atomic_helper_suspend(drm_dev);
> -	if (IS_ERR(private->suspend_state)) {
> -		exynos_drm_fbdev_resume(drm_dev);
> -		drm_kms_helper_poll_enable(drm_dev);
> -		return PTR_ERR(private->suspend_state);
> -	}
>   
> -	return 0;
> +	return  drm_mode_config_helper_suspend(drm_dev);
>   }
>   
>   static void exynos_drm_resume(struct device *dev)
>   {
>   	struct drm_device *drm_dev = dev_get_drvdata(dev);
> -	struct exynos_drm_private *private;
> -
> -	if (!drm_dev)
> -		return;
>   
> -	private = drm_dev->dev_private;
> -	drm_atomic_helper_resume(drm_dev, private->suspend_state);
> -	exynos_drm_fbdev_resume(drm_dev);
> -	drm_kms_helper_poll_enable(drm_dev);
> +	return drm_mode_config_helper_resume(drm_dev);

exynos_drm_resume() now returns 'void', so to be strict with
c standard, the return statement should not be used here.

>   }
>   
>   static const struct dev_pm_ops exynos_drm_pm_ops = {
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
> index c737c4b..7349e7c 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
> @@ -195,7 +195,6 @@ struct drm_exynos_file_private {
>    */
>   struct exynos_drm_private {
>   	struct drm_fb_helper *fb_helper;
> -	struct drm_atomic_state *suspend_state;
>   
>   	struct device *g2d_dev;
>   	struct device *dma_dev;
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> index 132dd52..918dd2c 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> @@ -270,20 +270,3 @@ void exynos_drm_fbdev_fini(struct drm_device *dev)
>   	private->fb_helper = NULL;
>   }
>   
> -void exynos_drm_fbdev_suspend(struct drm_device *dev)
> -{
> -	struct exynos_drm_private *private = dev->dev_private;
> -
> -	console_lock();
> -	drm_fb_helper_set_suspend(private->fb_helper, 1);
> -	console_unlock();
> -}
> -
> -void exynos_drm_fbdev_resume(struct drm_device *dev)
> -{
> -	struct exynos_drm_private *private = dev->dev_private;
> -
> -	console_lock();
> -	drm_fb_helper_set_suspend(private->fb_helper, 0);
> -	console_unlock();
> -}
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
> index b338472..6840b6a 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
> @@ -19,8 +19,6 @@
>   
>   int exynos_drm_fbdev_init(struct drm_device *dev);
>   void exynos_drm_fbdev_fini(struct drm_device *dev);
> -void exynos_drm_fbdev_suspend(struct drm_device *drm);
> -void exynos_drm_fbdev_resume(struct drm_device *drm);
>   
>   #else
>   
> @@ -39,14 +37,6 @@ static inline void exynos_drm_fbdev_restore_mode(struct drm_device *dev)
>   
>   #define exynos_drm_output_poll_changed (NULL)
>   
> -static inline void exynos_drm_fbdev_suspend(struct drm_device *drm)
> -{
> -}
> -
> -static inline void exynos_drm_fbdev_resume(struct drm_device *drm)
> -{
> -}
> -
>   #endif
>   
>   #endif

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

