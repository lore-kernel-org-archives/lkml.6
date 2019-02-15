Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE76C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B40221A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NiTNqy09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394781AbfBONHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:07:43 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50070 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfBONHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:07:43 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190215130741euoutp01a808f9b331c7abe7e7daa1ab53a9a37a~Di3v8DcQd1706717067euoutp01C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 13:07:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190215130741euoutp01a808f9b331c7abe7e7daa1ab53a9a37a~Di3v8DcQd1706717067euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550236061;
        bh=gXvuzcMK+so3jXAK/6IBDlrNkzZ2EDw5X537KLkHBnQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NiTNqy09jVQDTAjRotCjmdP2auhQPS9LQlF3UcRpzESkKZ1PsULwuSpMuGhmXS6HD
         NogYuMh/9NXCOkX4Fcyw2mW5/XOSI3EdTvnpe33+DWjhMDAUorrE93KkCaxZRB1inS
         /TwkMPePedNkghaQuo8KP9L5QV/fFo161JKn8cT0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190215130740eucas1p14d7aa7c9f36e42aafad1aa8048a01eac~Di3vZ9_OO2066920669eucas1p13;
        Fri, 15 Feb 2019 13:07:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6D.0E.04294.C99B66C5; Fri, 15
        Feb 2019 13:07:40 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190215130740eucas1p200ab33508db2fde1dced7d1bd810f598~Di3utVqP13257632576eucas1p22;
        Fri, 15 Feb 2019 13:07:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190215130739eusmtrp2388bf2e2cd311b4c0a30dd9f2a1a62e3~Di3uey2o11914219142eusmtrp2Q;
        Fri, 15 Feb 2019 13:07:39 +0000 (GMT)
X-AuditID: cbfec7f4-c77a99c0000010c6-e5-5c66b99c0b10
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C4.E9.04128.B99B66C5; Fri, 15
        Feb 2019 13:07:39 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190215130739eusmtip1f5a517333d339be9da16431f9c81365a~Di3uDqr-J2062320623eusmtip1l;
        Fri, 15 Feb 2019 13:07:39 +0000 (GMT)
Subject: Re: [PATCH 4/4] PM / devfreq: Handle monitor start/stop in the
 devfreq core
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <194a0fba-3e39-d577-810d-de300e8b4edd@partner.samsung.com>
Date:   Fri, 15 Feb 2019 14:07:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214190741.GC117604@google.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djPc7pzdqbFGOzarmBx/ctzVouWWYtY
        LM42vWG3uLxrDpvF594jjBadX2YBWRseM1rcblzBZvFz1zwWB06P2Q0XWTx2zrrL7tHb/I7N
        o2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDKadu1mKfjLV9G6fwJTA2MvdxcjJ4eEgInE+e8b
        2UBsIYEVjBJT1vh1MXIB2V8YJWafes4E4XxmlNi0o5+1i5EDrGNGZzZEfDmjxJ7jjewQzltG
        icX7rrGCjBIWCJN4/3EL2FgRAQ2JJ7/PM4IUMQusYZI4u3ULC8gkNgE9iR2rCkFqeAXcJH5d
        WMYMYrMIqEo8uDIdrFdUIELicO87RogaQYmTM5+wgNicAoYS5+5uBdvFLCAucevJfCYIW15i
        +9s5zCC7JAQOsUss+tHCBvGni8SGZQ+YIWxhiVfHt7BD2DIS/3dCNEsIFEuc7VgFVV8j0X5y
        B1SNtcTh4xfBvmcW0JRYv0sfIuwoMeXyPRZIoPBJ3HgrCHECn8SkbdOZIcK8Eh1tQhDVGhJb
        ei5ALRKTWL5mGvsERqVZSB6bheSZWUiemYWwdwEjyypG8dTS4tz01GKjvNRyveLE3OLSvHS9
        5PzcTYzAlHT63/EvOxh3/Uk6xCjAwajEw7siIzVGiDWxrLgy9xCjBAezkggv55q0GCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK81QwPooUE0hNLUrNTUwtSi2CyTBycUg2MyoWvU3PVr1Uw/Slf
        L6y57UKuotcaudo7ux7fZuAwc13LYZi3vKHSqNr0jre//k33RTGN827+WJJ0MOCvycXKzN/2
        D0Q/VOQUmv2x2zqR4dnChispuduvTzOzPdi6bvLO/X13JU+0vLwcmqJowH/gr8/TrYUNV5Zd
        kGhZFRzyukd/1Um1h9b6SizFGYmGWsxFxYkAqabQU0UDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7qzd6bFGHz/r2tx/ctzVouWWYtY
        LM42vWG3uLxrDpvF594jjBadX2YBWRseM1rcblzBZvFz1zwWB06P2Q0XWTx2zrrL7tHb/I7N
        o2/LKkaPz5vkAlij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMy
        y1KL9O0S9DKadu1mKfjLV9G6fwJTA2MvdxcjB4eEgInEjM7sLkYuDiGBpYwS7U2v2LsYOYHi
        YhKT9m2HsoUl/lzrYgOxhQReM0psWS8HYgsLhEm8/7gFLC4ioCHx5Pd5RpBBzALrmCR+Xn0N
        1TCbSWL3BgOQZWwCehI7VhWChHkF3CR+XVjGDGKzCKhKPLgyHaxcVCBC4uPTfUwQNYISJ2c+
        YQGxOQUMJc7d3coKYjMLmEnM2/yQGcIWl7j1ZD4ThC0vsf3tHOYJjEKzkLTPQtIyC0nLLCQt
        CxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgRG4bZjP7fsYOx6F3yIUYCDUYmHd0VGaowQ
        a2JZcWXuIUYJDmYlEV7ONWkxQrwpiZVVqUX58UWlOanFhxhNgZ6byCwlmpwPTBB5JfGGpobm
        FpaG5sbmxmYWSuK85w0qo4QE0hNLUrNTUwtSi2D6mDg4pRoY5Z5+v5Fi+Znl0BnLt1/nqbxd
        n2ChN4vtamBDTuARN05v0Z2ZQbYnf3DWMPjs3ynE3jn9TpbAMrnDIq6u9QleC03zU7replXH
        5M35dTUngXG5wfTJi82LxbfmfKq88v4G6yd77u5T6fNOOp5cnvmA6ctXRbbbbw02Pdt6d461
        DAfTeucP9usOKbEUZyQaajEXFScCAKSUys/YAgAA
X-CMS-MailID: 20190215130740eucas1p200ab33508db2fde1dced7d1bd810f598
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190214013154epcas1p31326fdc127b3a75d566426e4f785121b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190214013154epcas1p31326fdc127b3a75d566426e4f785121b
References: <20190214013042.254790-1-mka@chromium.org>
        <CGME20190214013154epcas1p31326fdc127b3a75d566426e4f785121b@epcas1p3.samsung.com>
        <20190214013042.254790-5-mka@chromium.org>
        <1771fe9e-c107-f133-7b39-f4d7dbb004c5@partner.samsung.com>
        <20190214190741.GC117604@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2/14/19 8:07 PM, Matthias Kaehlcke wrote:
> Hi Lukasz,
> 
> On Thu, Feb 14, 2019 at 07:01:36PM +0100, Lukasz Luba wrote:
>> Hi Matthias,
>>
>> I have compiled and run your changes on Odroid xu3 and v5.0-rc6.
>> There are kernel warnings because of mutex not held in function
>> devfreq_monitor_[start|stop]() in use cases:
>>    1) a few times during registration of new devices devfreq_add_device()
>>    2) poking the device from sysfs
> 
> Thanks testing!
> 
> I messed up carrying over changes from my v4.19 device kernel
> to the tree used for upstreaming :(
> 
> Do you still see warnings with the below patch?
No, the warnings are no longer present in the log. The patch solves it.

Regards,
Lukasz
> 
> Thanks
> 
> Matthias
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index a42c37543c190..866fe711b43ca 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -440,7 +440,6 @@ static void devfreq_monitor_stop(struct devfreq *devfreq)
> 
>          mutex_lock(&devfreq->lock);
>          devfreq->monitor_state = DEVFREQ_MONITOR_STOPPED;
> -       mutex_unlock(&devfreq->lock);
>   }
> 
>   /**
> @@ -596,7 +595,9 @@ static int governor_start(struct devfreq *devfreq)
>                  return err;
>          }
> 
> +       mutex_lock(&devfreq->lock);
>          devfreq_monitor_start(devfreq);
> +       mutex_unlock(&devfreq->lock);
> 
>          return 0;
>   }
> @@ -614,7 +615,9 @@ static int governor_stop(struct devfreq *devfreq)
>                   "mutex must *not* be held by the caller\n"))
>                  return -EINVAL;
> 
> +       mutex_lock(&devfreq->lock);
>          devfreq_monitor_stop(devfreq);
> +       mutex_unlock(&devfreq->lock);
> 
>          err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_STOP, NULL);
>          if (err) {
> 
> 
