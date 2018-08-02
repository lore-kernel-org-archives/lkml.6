Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46EEC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433E6208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZoV7AzFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433E6208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeHBIhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:37:02 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43801 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeHBIhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:37:01 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180802064717euoutp019f56642ce23a3585d31ba9b1c9787052~G-mYFYmya2429124291euoutp01r
        for <linux-kernel@vger.kernel.org>; Thu,  2 Aug 2018 06:47:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180802064717euoutp019f56642ce23a3585d31ba9b1c9787052~G-mYFYmya2429124291euoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533192437;
        bh=CyK0tNof0hEFROCvHxDaUFNhzfUQDFLLbCcHWjPeW3U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZoV7AzFiyVlxDcueascxoAcsGUIWmq/JA2yOwLKxreS9dseidRQj+Rs7q00K8cpXk
         hcE6v/sMQXNnKSOmkFJLY1+DeL1zftV4RVbF75fFpCiL2gs9MQKGRN1TIlJkGNQ3Qz
         IL8Umwdrtv9LfheSpkAVnRcEuNc53IB1BIfAxQGk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180802064716eucas1p2a09f8ca8f3740365a874ce5109920215~G-mXSyRgI0271602716eucas1p29;
        Thu,  2 Aug 2018 06:47:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 22.53.04627.4F8A26B5; Thu,  2
        Aug 2018 07:47:16 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180802064714eucas1p12f3c32c453a49dc4e0d2785ff7fa72ec~G-mV4kIr70116001160eucas1p1P;
        Thu,  2 Aug 2018 06:47:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180802064714eusmtrp259692f2d2335fc15afbd491a8f4fe95a~G-mVpMGjp0156901569eusmtrp2r;
        Thu,  2 Aug 2018 06:47:14 +0000 (GMT)
X-AuditID: cbfec7f2-0edff70000021213-3b-5b62a8f4a6a6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1A.0D.04178.2F8A26B5; Thu,  2
        Aug 2018 07:47:14 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180802064713eusmtip181f6a819b4d35d2d5427285806aa710c~G-mU8giCh0545005450eusmtip1b;
        Thu,  2 Aug 2018 06:47:13 +0000 (GMT)
Subject: Re: [PATCH v2] gpu/drm/exynos: Convert
 drm_atomic_helper_suspend/resume()
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Inki Dae <inki.dae@samsung.com>, jy0922.shim@samsung.com,
        sw0312.kim@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        airlied@linux.ie, kgene@kernel.org, krzk@kernel.org,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajit Linux <ajitn.linux@gmail.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Thu, 2 Aug 2018 08:47:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zY6vcqrmztcEf9QYMXoHr08oTirSTNA7X6+5YvvoHRR4A@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTmd+/d3d1o8WtOPGjP0YMVraT+uKWVRX/c6J+iIGg9nHVRSWds
        PnpYjhza1mPTHtoYKNUsLFot21R6rtioaJaZaZYGRuVjWr4iRK15tfzvO9/5vnO+A4ch5V9F
        0UyqLpPX67RpSlpKefy/g0sHridpllcM0+yZ4HOCvfnehNjWrtMkO+YpItmGwV6aLW6zUWzj
        OyPJfm99Q7HW9i6Srau7LWZfnegWs+72RhH7ttZBs6V1Dwm2/qePYEvPddAJmHswVE5xNfZP
        Ys5daaY579BnEdd2KkBwd6/mcWerKhHX7569hdkpjd/Pp6Vm8/plaxOlKU8cv8iDbtUhb9EL
        yojK5lmQhAG8Es4V3SAtSMrI8XUEz1rzCaEYQHBqtIUOq+S4H8FIUD3psJndE45rCO57RpBQ
        9CIIPL6MwqoIvB3a2i2icEOBTQQEG7rIcIPENgLO1yaHMY1jwRKyjK+g8Hzo81jFFsQwkXgX
        DNfGhWkZngHPL32hwliCt8JdYzMtjJkD3pBjYmQUfPhSNh4bsJmB7kd9hGDOhosFnUiIvRGc
        xWWUgCOgM1AlFvBMGKuZNOcjKCy1i4XiNIJ7jmpaUMXB08AbUTgdiVXgql0m0OuhqXhonAY8
        HZpCM4RA06HYU0IKtAxOFsgF9UKwB279W/vkdT1pQ0r7lDPtU06zTznN/n9vOaIqURSfZUhP
        5g2xOj5HbdCmG7J0yep9Gelu9Pf7Xo4G+qrRYH2SD2EGKafJjKNajVykzTYcTvchYEilQpbP
        JWnksv3aw0d4fcZefVYab/ChGIZSRsk+Wvdo5DhZm8kf4PmDvH6ySzCSaCM6uikv7vgKm/VH
        z7GlrpHInO++5vLclrFt1YRzSfacUG70ugZN0OzKcfq7b0YkZqySehMWXlk/1xWf2HENdpYE
        FpRUKHcrLvxkCL/pvnpz92CFK/6OxGha7Tuzzd+j8n9zO3Yo1vS78lTBWYUbCsucu0tL7LO/
        6X4oFikiCxfEKClDijZ2Mak3aP8AZsUkunkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsVy+t/xu7qfViRFG7QdUrboPXeSyWLN9RZG
        i3uve5gt/m+byGxx5et7NotJ9yewWFy72sBs8eLeRRaL/sevmS3On9/AbnG26Q27xabH11gt
        Lu+aw2Yx4/w+JotLHw8xWcyY/JLNQcBj77cFLB47Z91l99i0qpPNY/u3B6we97uPM3lsXlLv
        0bdlFaPH501yARxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZ
        ZalF+nYJehkH53xnLtikWbF94imWBsb5il2MnBwSAiYSEzo3MXcxcnEICSxllFj0/zMjREJG
        4uS0BlYIW1jiz7UuNoiit4wSHd2nwYqEBUIk7j/uYgVJiAi0MEnsvnARzGEWmMQk8erzLBaI
        lhuMEsdmdjOBtLAJGEp0vQWZxcnBK2An0TvjDlicRUBF4tO2fnYQW1QgRuLo5BaoGkGJkzOf
        sIDYnAKBEpsbboLFmQXMJOZtfsgMYctLbH87B8oWl7j1ZD7TBEahWUjaZyFpmYWkZRaSlgWM
        LKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECI37bsZ+bdzBe2hh8iFGAg1GJh/cGQ1K0EGti
        WXFl7iFGCQ5mJRHeZg+gEG9KYmVValF+fFFpTmrxIUZToOcmMkuJJucDk1FeSbyhqaG5haWh
        ubG5sZmFkjjveYPKKCGB9MSS1OzU1ILUIpg+Jg5OqQZGjvx/B2bmF3n/Xd12vmtjaMBs8Ylx
        mp5PeblP+DnfO/qta0mTn9Gk2w6P/ri/XfWOZ+5rnUcKa8v/9y9wsdG4/fL5tVPz5l77cCf4
        wQ2dD0z7G2ZmiRua+ti/LS2WCZ95rnldXOrcnGKuS5MPNblWG+v5aG1/v/Tspy+dOxJnXfu+
        bHfrnIaXekosxRmJhlrMRcWJAJSJ5m0OAwAA
Message-Id: <20180802064714eucas1p12f3c32c453a49dc4e0d2785ff7fa72ec~G-mV4kIr70116001160eucas1p1P@eucas1p1.samsung.com>
X-CMS-MailID: 20180802064714eucas1p12f3c32c453a49dc4e0d2785ff7fa72ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180802062607epcas1p339ff6aeb0cbdc3b6ece2617be4aadb41
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180802062607epcas1p339ff6aeb0cbdc3b6ece2617be4aadb41
References: <20180726155459.GA30138@jordon-HP-15-Notebook-PC>
        <CGME20180802062607epcas1p339ff6aeb0cbdc3b6ece2617be4aadb41@epcas1p3.samsung.com>
        <CAFqt6zY6vcqrmztcEf9QYMXoHr08oTirSTNA7X6+5YvvoHRR4A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Souptick,

On 2018-08-02 08:25, Souptick Joarder wrote:
> On Thu, Jul 26, 2018 at 9:24 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> convert drm_atomic_helper_suspend/resume() to use
>> drm_mode_config_helper_suspend/resume().
>>
>> exynos_drm_fbdev_suspend/resume can be removed
>> as drm_mode_config_helper_suspend/resume has
>> implement the same in generic way.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
>> ---
>> v2: Address Inki Dae's comment. Remove
>>      ret variable from both suspend/resume
>>      function.
>>
> Any further comment on this patch ?

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

However you need to rebase onto current drm-next, because there have
been some changes, which prevent this patch from applying.

pm_runtime_suspended(dev) checks were useless and have been removed,
what simplifies suspend/resume functions even more. Now it is too
late for v4.19 merge window, so this patch will have to wait for
v4.20.

>>   drivers/gpu/drm/exynos/exynos_drm_drv.c   | 26 ++++----------------------
>>   drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 17 -----------------
>>   drivers/gpu/drm/exynos/exynos_drm_fbdev.h | 10 ----------
>>   3 files changed, 4 insertions(+), 49 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
>> index a81b4a5..46d28cd 100644
>> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
>> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
>> @@ -151,39 +151,21 @@ static void exynos_drm_postclose(struct drm_device *dev, struct drm_file *file)
>>   static int exynos_drm_suspend(struct device *dev)
>>   {
>>          struct drm_device *drm_dev = dev_get_drvdata(dev);
>> -       struct exynos_drm_private *private;
>>
>> -       if (pm_runtime_suspended(dev) || !drm_dev)
>> +       if (pm_runtime_suspended(dev))
>>                  return 0;
>>
>> -       private = drm_dev->dev_private;
>> -
>> -       drm_kms_helper_poll_disable(drm_dev);
>> -       exynos_drm_fbdev_suspend(drm_dev);
>> -       private->suspend_state = drm_atomic_helper_suspend(drm_dev);
>> -       if (IS_ERR(private->suspend_state)) {
>> -               exynos_drm_fbdev_resume(drm_dev);
>> -               drm_kms_helper_poll_enable(drm_dev);
>> -               return PTR_ERR(private->suspend_state);
>> -       }
>> -
>> -       return 0;
>> +       return drm_mode_config_helper_suspend(drm_dev);
>>   }
>>
>>   static int exynos_drm_resume(struct device *dev)
>>   {
>>          struct drm_device *drm_dev = dev_get_drvdata(dev);
>> -       struct exynos_drm_private *private;
>>
>> -       if (pm_runtime_suspended(dev) || !drm_dev)
>> +       if (pm_runtime_suspended(dev))
>>                  return 0;
>>
>> -       private = drm_dev->dev_private;
>> -       drm_atomic_helper_resume(drm_dev, private->suspend_state);
>> -       exynos_drm_fbdev_resume(drm_dev);
>> -       drm_kms_helper_poll_enable(drm_dev);
>> -
>> -       return 0;
>> +       return drm_mode_config_helper_resume(drm_dev);
>>   }
>>   #endif
>>
>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>> index 132dd52..918dd2c 100644
>> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>> @@ -270,20 +270,3 @@ void exynos_drm_fbdev_fini(struct drm_device *dev)
>>          private->fb_helper = NULL;
>>   }
>>
>> -void exynos_drm_fbdev_suspend(struct drm_device *dev)
>> -{
>> -       struct exynos_drm_private *private = dev->dev_private;
>> -
>> -       console_lock();
>> -       drm_fb_helper_set_suspend(private->fb_helper, 1);
>> -       console_unlock();
>> -}
>> -
>> -void exynos_drm_fbdev_resume(struct drm_device *dev)
>> -{
>> -       struct exynos_drm_private *private = dev->dev_private;
>> -
>> -       console_lock();
>> -       drm_fb_helper_set_suspend(private->fb_helper, 0);
>> -       console_unlock();
>> -}
>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
>> index b338472..6840b6a 100644
>> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
>> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
>> @@ -19,8 +19,6 @@
>>
>>   int exynos_drm_fbdev_init(struct drm_device *dev);
>>   void exynos_drm_fbdev_fini(struct drm_device *dev);
>> -void exynos_drm_fbdev_suspend(struct drm_device *drm);
>> -void exynos_drm_fbdev_resume(struct drm_device *drm);
>>
>>   #else
>>
>> @@ -39,14 +37,6 @@ static inline void exynos_drm_fbdev_restore_mode(struct drm_device *dev)
>>
>>   #define exynos_drm_output_poll_changed (NULL)
>>
>> -static inline void exynos_drm_fbdev_suspend(struct drm_device *drm)
>> -{
>> -}
>> -
>> -static inline void exynos_drm_fbdev_resume(struct drm_device *drm)
>> -{
>> -}
>> -
>>   #endif
>>
>>   #endif
>> --
>> 1.9.1
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

