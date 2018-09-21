Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C6BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39F62146E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LSZHSxoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39F62146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389037AbeIUJBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 05:01:14 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:42635 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeIUJBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 05:01:14 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180921031425epoutp028ed08f2fc764b82cd2f0ac0f64024865~WS8zVCz-O2108021080epoutp02Z
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 03:14:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180921031425epoutp028ed08f2fc764b82cd2f0ac0f64024865~WS8zVCz-O2108021080epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537499665;
        bh=GFHYnU+sGpx/f+kk+6kkgujBoaeOr8kwlt6l5bvVPFQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LSZHSxocSrqCd6ep+y/2mfGTyAX9sDa0C73Z62oC2C/okDjmWIKj8LZZmN8D+3nNs
         LfLk1TxnMsi2emhpRQITHtOzwgjAWGxoeg6j4kK9jDtMpXzcOLekUAgcOJ6BJ0Le0g
         5RraSOLq8DDJVvYgpSTO89mkRjzmkGweOtbzEXjQ=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20180921031423epcas1p3a8bfce5493bda2461082f88ece9dcd94~WS8woCWP01678116781epcas1p35;
        Fri, 21 Sep 2018 03:14:23 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.7C.04073.E0264AB5; Fri, 21 Sep 2018 12:14:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20180921031422epcas1p440984367cd375f84efd72b1eb8c8b9d7~WS8wTX1AN1223212232epcas1p4L;
        Fri, 21 Sep 2018 03:14:22 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180921031422epsmtrp2263e204cfe033fb083557a9ba0f1132f~WS8wR2_qs1634016340epsmtrp2J;
        Fri, 21 Sep 2018 03:14:22 +0000 (GMT)
X-AuditID: b6c32a35-69fff70000000fe9-7a-5ba4620e2ddf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.02.03697.E0264AB5; Fri, 21 Sep 2018 12:14:22 +0900 (KST)
Received: from [10.113.62.206] (unknown [10.113.62.206]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180921031422epsmtip262427ebe8a7fee5e38995694eb84e99b~WS8v6cGTP2010620106epsmtip2j;
        Fri, 21 Sep 2018 03:14:22 +0000 (GMT)
Subject: Re: [PATCH v4] gpu/drm/exynos: Convert
 drm_atomic_helper_suspend/resume()
To:     Souptick Joarder <jrdr.linux@gmail.com>, jy0922.shim@samsung.com,
        sw0312.kim@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        airlied@linux.ie, kgene@kernel.org, krzk@kernel.org,
        Ajit Linux <ajitn.linux@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Inki Dae <inki.dae@samsung.com>
Date:   Fri, 21 Sep 2018 12:14:22 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zbp+yFq-59o-J5dtB8Gfc3Ggd6Ff6tCy5vt0OTTSr41vQ@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprELsWRmVeSWpSXmKPExsWy7bCmri5f0pJog+6N5ha9504yWay53sJo
        ceXrezaLa1cbmC1e3LvIYtH/+DWzxfnzG9gtzja9YbfY9Pgaq8XlXXPYLGac38dksfbIXXaL
        GZNfsjnweuycdZfdY9OqTjaP7d8esHrc7z7O5LF5Sb1H35ZVjB6fN8kFsEc1MNokFiVnZJal
        KqTmJeenZOal2yqFhrjpWigpZOQXl9gqRRsaGukZGpjrGRkZ6RlbxloZmSop5CXmptoqVehC
        9SopFCUXANXmVhYDDchJ1YOK6xWn5qU4ZOWXgryoV5yYW1yal66XnJ+rpFCWmFMKNEJJP+Eb
        Y8bs8+oFx3QrWu//Z2pgbFPtYuTkkBAwkVjwbw1LFyMXh5DADkaJUyffMEE4nxglrt36zgzh
        fGOUaFm/iA2m5dSZT1CJvYwSu5afYIVw3jJKLJ+wlhmkSlggRGLzzCVgg0UEJjNJLPvYCOYw
        C/QwSpz/sIQdpIpNQFVi4or7YHNZgOyOt3PAukUFIiSOPFjICGLzCghKnJz5hAXE5hQIlFj3
        +hSYzSwgLnHryXwmCFteonnrbLCbJASms0u0bzwMdBMHUHOZxKkbahB3u0gsWH+JCcIWlnh1
        fAs7hC0l8fndXjaI3nZGiZ9/NjFCJIAuXb4nA8I2lni2sIsJZCazgKbE+l36EGFBidPXupkh
        buCTePe1B2ythACvREebEESJksSxizegJkpIXFgyERqMHhJrPqxkmsCoOAvJl7OQfDYLyWez
        EBYvYGRZxSiWWlCcm55abFhgiBzjmxjBKVzLdAfjlHM+hxgFOBiVeHgNFi+OFmJNLCuuzD3E
        KMHBrCTC6820JFqINyWxsiq1KD++qDQntfgQYzIwEiYyS4km5wPzS15JvKGpkbGxsYWJoZmp
        oSGSsImxgYERMLGaW5ob4xBWEud9IjU3WkggPbEkNTs1tSC1CGYLEwenVANjb8mnrF2L8/7a
        nHUJ28i05EKuSdz2jvQzk1adX2jQ42wS+SFg9VKtE1K7+fj2u/td/TXTNq+/21X5Qe9SRh/J
        jM51pkk/EmPXLS3+0Pdjg/aGG4rtU+feX1VYxy03w8no/Wzhmo+6Od8ePdxipXVq0pl9PvEG
        LSd87p2WC3uokRrfq+Wh06GsxFKckWioxVxUnAgA3DxupiUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCSvC5f0pJog1Nt8ha9504yWay53sJo
        ceXrezaLa1cbmC1e3LvIYtH/+DWzxfnzG9gtzja9YbfY9Pgaq8XlXXPYLGac38dksfbIXXaL
        GZNfsjnweuycdZfdY9OqTjaP7d8esHrc7z7O5LF5Sb1H35ZVjB6fN8kFsEdx2aSk5mSWpRbp
        2yVwZcw+r15wTLei9f5/pgbGNtUuRk4OCQETiVNnPjF3MXJxCAnsZpT4dW4VYxcjB1BCQmLL
        Vg4IU1ji8OFiiJLXQCVTnzKD9AoLhEhsnrmEBSQhIjCVSeLnvGZ2EIdZoIdRYsfZmewQLfOZ
        JCY1/QJrYRNQlZi44j4biM0rYCex5eUnsDgLULzj7RwwW1QgQmL18hesEDWCEidnPmEBsTkF
        AiXWvT4FZjMLqEv8mXeJGcIWl7j1ZD4ThC0v0bx1NvMERqFZSNpnIWmZhaRlFpKWBYwsqxgl
        UwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgqNQS2sH44kT8YcYBTgYlXh4DRYvjhZiTSwr
        rsw9xCjBwawkwuvNtCRaiDclsbIqtSg/vqg0J7X4EKM0B4uSOK98/rFIIYH0xJLU7NTUgtQi
        mCwTB6dUA2P5pHmiLkFun6r0+vR9ptRdZpb+He9/xo9Bea7+pT+H7e6wLXxY053aEp749ZZ/
        g3bjzINnbS8z3m37Z/bOYIZ9RuzSnZyc9XtKSn45d5ySf/Iu8Lmk9RGNGYkv/P6Z165XuXnk
        APs2oapzjB8WWJr3sWZ4/kqXLXXk0Ojf5irwt51jrvjxS0osxRmJhlrMRcWJAL3tjOW+AgAA
Message-Id: <20180921031422epcas1p440984367cd375f84efd72b1eb8c8b9d7~WS8wTX1AN1223212232epcas1p4L@epcas1p4.samsung.com>
X-CMS-MailID: 20180921031422epcas1p440984367cd375f84efd72b1eb8c8b9d7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180918060240epcas1p1aff628245281e98554044ef3db5c684a
References: <20180802154517.GA10593@jordon-HP-15-Notebook-PC>
        <CAFqt6zZDRaVp53RnEri+P4b8+GByE-UQwerJmuLBe6E=GK0kDQ@mail.gmail.com>
        <CGME20180918060240epcas1p1aff628245281e98554044ef3db5c684a@epcas1p1.samsung.com>
        <CAFqt6zbp+yFq-59o-J5dtB8Gfc3Ggd6Ff6tCy5vt0OTTSr41vQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joarder,

On 2018년 09월 18일 15:02, Souptick Joarder wrote:
> Hi Inki,
> On Tue, Sep 11, 2018 at 2:06 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>
>> On Thu, Aug 2, 2018 at 9:12 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>>
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
>>
>> Can we get this patch in queue for 4.20 ? Not yet available in linux-next.
> 
> Is this patch queued for 4.20 ?

Queued already to exynos-drm-next below so please wait. I will have pull-request soon.
https://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos.git/log/?h=exynos-drm-next

Thanks,
Inki Dae

> 
>>> ---
>>> v2: Address Inki Dae's comment. Remove ret variable
>>>     from both suspend/resume function.
>>>
>>> v3: Tested by Marek. Updated the change log.
>>>
>>> v4: removing the return as exynos_drm_resume()
>>>     now returns void.
>>>
>>>  drivers/gpu/drm/exynos/exynos_drm_drv.c   | 26 ++------------------------
>>>  drivers/gpu/drm/exynos/exynos_drm_drv.h   |  1 -
>>>  drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 17 -----------------
>>>  drivers/gpu/drm/exynos/exynos_drm_fbdev.h | 10 ----------
>>>  4 files changed, 2 insertions(+), 52 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
>>> index b599f74..6f76baf 100644
>>> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
>>> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
>>> @@ -149,37 +149,15 @@ static void exynos_drm_postclose(struct drm_device *dev, struct drm_file *file)
>>>  static int exynos_drm_suspend(struct device *dev)
>>>  {
>>>         struct drm_device *drm_dev = dev_get_drvdata(dev);
>>> -       struct exynos_drm_private *private;
>>> -
>>> -       if (!drm_dev)
>>> -               return 0;
>>> -
>>> -       private = drm_dev->dev_private;
>>> -
>>> -       drm_kms_helper_poll_disable(drm_dev);
>>> -       exynos_drm_fbdev_suspend(drm_dev);
>>> -       private->suspend_state = drm_atomic_helper_suspend(drm_dev);
>>> -       if (IS_ERR(private->suspend_state)) {
>>> -               exynos_drm_fbdev_resume(drm_dev);
>>> -               drm_kms_helper_poll_enable(drm_dev);
>>> -               return PTR_ERR(private->suspend_state);
>>> -       }
>>>
>>> -       return 0;
>>> +       return  drm_mode_config_helper_suspend(drm_dev);
>>>  }
>>>
>>>  static void exynos_drm_resume(struct device *dev)
>>>  {
>>>         struct drm_device *drm_dev = dev_get_drvdata(dev);
>>> -       struct exynos_drm_private *private;
>>> -
>>> -       if (!drm_dev)
>>> -               return;
>>>
>>> -       private = drm_dev->dev_private;
>>> -       drm_atomic_helper_resume(drm_dev, private->suspend_state);
>>> -       exynos_drm_fbdev_resume(drm_dev);
>>> -       drm_kms_helper_poll_enable(drm_dev);
>>> +       drm_mode_config_helper_resume(drm_dev);
>>>  }
>>>
>>>  static const struct dev_pm_ops exynos_drm_pm_ops = {
>>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
>>> index c737c4b..7349e7c 100644
>>> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
>>> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
>>> @@ -195,7 +195,6 @@ struct drm_exynos_file_private {
>>>   */
>>>  struct exynos_drm_private {
>>>         struct drm_fb_helper *fb_helper;
>>> -       struct drm_atomic_state *suspend_state;
>>>
>>>         struct device *g2d_dev;
>>>         struct device *dma_dev;
>>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>>> index 132dd52..918dd2c 100644
>>> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>>> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>>> @@ -270,20 +270,3 @@ void exynos_drm_fbdev_fini(struct drm_device *dev)
>>>         private->fb_helper = NULL;
>>>  }
>>>
>>> -void exynos_drm_fbdev_suspend(struct drm_device *dev)
>>> -{
>>> -       struct exynos_drm_private *private = dev->dev_private;
>>> -
>>> -       console_lock();
>>> -       drm_fb_helper_set_suspend(private->fb_helper, 1);
>>> -       console_unlock();
>>> -}
>>> -
>>> -void exynos_drm_fbdev_resume(struct drm_device *dev)
>>> -{
>>> -       struct exynos_drm_private *private = dev->dev_private;
>>> -
>>> -       console_lock();
>>> -       drm_fb_helper_set_suspend(private->fb_helper, 0);
>>> -       console_unlock();
>>> -}
>>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
>>> index b338472..6840b6a 100644
>>> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
>>> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
>>> @@ -19,8 +19,6 @@
>>>
>>>  int exynos_drm_fbdev_init(struct drm_device *dev);
>>>  void exynos_drm_fbdev_fini(struct drm_device *dev);
>>> -void exynos_drm_fbdev_suspend(struct drm_device *drm);
>>> -void exynos_drm_fbdev_resume(struct drm_device *drm);
>>>
>>>  #else
>>>
>>> @@ -39,14 +37,6 @@ static inline void exynos_drm_fbdev_restore_mode(struct drm_device *dev)
>>>
>>>  #define exynos_drm_output_poll_changed (NULL)
>>>
>>> -static inline void exynos_drm_fbdev_suspend(struct drm_device *drm)
>>> -{
>>> -}
>>> -
>>> -static inline void exynos_drm_fbdev_resume(struct drm_device *drm)
>>> -{
>>> -}
>>> -
>>>  #endif
>>>
>>>  #endif
>>> --
>>> 1.9.1
>>>
> 
> 
