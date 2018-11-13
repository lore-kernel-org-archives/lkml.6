Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F74C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F7520835
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DWRkuxSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F7520835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbeKNJxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 04:53:21 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:56620 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeKNJxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 04:53:21 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20181113235239epoutp02fc978d988012323e4ed471ced7b8408f~m1CDExEFF2113321133epoutp02p;
        Tue, 13 Nov 2018 23:52:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20181113235239epoutp02fc978d988012323e4ed471ced7b8408f~m1CDExEFF2113321133epoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542153159;
        bh=ss3PkeJVWYMnzhwrTSSk6d73ovm522wYiYAc+HVckfo=;
        h=Date:From:To:Subject:In-reply-to:References:From;
        b=DWRkuxSvV/7TKySFy5mU0iiEQRg0vrc9myttUYkSWE6tV3tVq4MMqOFQLGY3cdXf1
         dBFWYCmQQPyJBFwDdCth9zJkJ+0rMeWeB5LhLEbJLqpBfVE3kn6dfIX28uwNu+Zcgj
         ihfueAVe8VQ7fnqh4BuwY8S+aMV9pD1sRCCLQkbc=
Received: from epsmges2p2.samsung.com (unknown [182.195.40.158]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181113235236epcas1p11c84c4d9dbae669406fd9bdd9192360c~m1CAVLugr1287712877epcas1p1Q;
        Tue, 13 Nov 2018 23:52:36 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.12.04407.4C36BEB5; Wed, 14 Nov 2018 08:52:36 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20181113235235epcas2p191c155fc4f89d47125946b71273e263a~m1B-rRAGG0286702867epcas2p1p;
        Tue, 13 Nov 2018 23:52:35 +0000 (GMT)
X-AuditID: b6c32a46-7a1ff70000001137-ab-5beb63c4dd31
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 16.B2.03702.3C36BEB5; Wed, 14 Nov
        2018 08:52:35 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PI5006HDOZN9Z60@mmp2.samsung.com>; Wed, 14 Nov 2018 08:52:35 +0900 (KST)
Message-id: <5BEB63C3.1020504@samsung.com>
Date:   Wed, 14 Nov 2018 08:52:35 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 2/5] extcon: Return -EPROBE_DEFER when extcon device
 is not found
In-reply-to: <5BE8C821.5080002@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmqe6R5NfRBgt3qlj0Nk1nsjjW9oTd
        omuhgUXz4vVsFm+OA4W6Vu9ksbi8aw6bxewl/SwWn3uPMFosWtbKbPFk4Rkmi9uNK9gsVu95
        wWwx98tUZoueR1oWp3eXWPw8dJ7JQdBjw6PVrB6bV2h5bFrVyeYx72Sgx/65a9g93u+7yuax
        83sDu0ffllWMHsdvbGfy+LxJLoArKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLC
        XEkhLzE31VbJxSdA1y0zB+gZJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFe
        cWJucWleul5yfq6VoYGBkSlQYUJ2Rv9T04K1whUTFu1lbGC8wd/FyMkhIWAicXjhK9YuRi4O
        IYEdjBLzu95DOd8ZJc4tesEMU7XyVCMTRGIDo8SKjW/ZQRK8AoISPybfY+li5OBgFpCXOHIp
        GyTMLKAp8eLLJBaI+ruMEms6PjJC1GtJ/DiygAXEZhFQldi/dSXYAjag+P4XN9hAbH4BRYmr
        Px6D1YsKREjsnP+NHWSQiEADq8TH622sIAlhgSiJcxf3gBVxCmhL7L76GaxIQmAZu8TZuxNZ
        IM52kWiZcZsVwhaWeHV8CzuELS3xbNVGRoiGdkaJLy+aWSGcCYwSH05tZoKoMpZ4trCLCeIh
        PomOw3/ZQf6UEOCV6GgTgijxkHh5v48R4s8fjBJzF65lnMAoMwspaGYhgmYWUtAsYGRexSiW
        WlCcm55abFRghBxnmxjByVXLbQfjknM+hxgFOBiVeHgtbr+KFmJNLCuuzD3EKMHBrCTC6x/9
        OlqINyWxsiq1KD++qDQntfgQoykwZCcyS4km5wMTf15JvKGpkbGxsYWpuaWxgaWSOO9D6bnR
        QgLpiSWp2ampBalFMH1MHJxSDYzysXIaR5hEy3JTFNpW5IaKCaRE7kx+ZH7B8zirYsyZ3ed6
        5jtaMqRMm3+n+nVQmv2e9EPuO69euL4vzuhJpdGXfYeD30j0/u/P/HP80S7XUw5zhHlKe4Q2
        bdi99MXWXtbbXv++TJ8S2m3Nor1CIUOkelXmZ9UIn6a6lYpzjNoPiP696PDvTagSS3FGoqEW
        c1FxIgAe4TVAxAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t9jQd3Dya+jDVbcNbPobZrOZHGs7Qm7
        RddCA4vmxevZLN4cBwp1rd7JYnF51xw2i9lL+lksPvceYbRYtKyV2eLJwjNMFrcbV7BZrN7z
        gtli7pepzBY9j7QsTu8usfh56DyTg6DHhkerWT02r9Dy2LSqk81j3slAj/1z17B7vN93lc1j
        5/cGdo++LasYPY7f2M7k8XmTXABXFJdNSmpOZllqkb5dAldG/1PTgrXCFRMW7WVsYLzB38XI
        ySEhYCKx8lQjUxcjF4eQwDpGid+LtrGBJHgFBCV+TL7H0sXIwcEsIC9x5FI2hKkuMWVKLkT5
        fUaJFTsuMkKUa0n8OLKABcRmEVCV2L91JTOIzQYU3//iBthIfgFFias/HjOCzBEViJDoPlEJ
        MkdEoIlV4uSrt2BzhAWiJH5NmQp1zw9GiY8/f4MN4hTQlth99TP7BEb+WUjOm4Vw3iyE8xYw
        Mq9ilEwtKM5Nzy02KjDKSy3XK07MLS7NS9dLzs/dxAiMrW2Htfp3MD5eEn+IUYCDUYmH1+L2
        q2gh1sSy4srcQ4wSHMxKIrz+0a+jhXhTEiurUovy44tKc1KLDzFKc7AoifPy5x+LFBJITyxJ
        zU5NLUgtgskycXBKNTDO5OdoN/boE5Zh3P/7iIrAOaO9XyewvVkkm7Q5Oitr4sRvrz4Ilc2R
        jnyz3qfu9Tam7ni2t8urfqrlLWG23Xpuffwj/x9fymY9YAw5syZq+rs2sYazEQ375uy2fnxu
        Ds+b4DiZvE8awav2T9z7j7HXzfYHZ7Dk9qxFvpVrKk+Gnb2mFud6ae9EJZbijERDLeai4kQA
        OetCFakCAAA=
X-CMS-MailID: 20181113235235epcas2p191c155fc4f89d47125946b71273e263a
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181110181155epcas2p1ac9bffb2dc7dd6337db5c37f8a87bd5e
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
        <CGME20181110181155epcas2p1ac9bffb2dc7dd6337db5c37f8a87bd5e@epcas2p1.samsung.com>
        <20181110181101.24557-2-andriy.shevchenko@linux.intel.com>
        <5BE8C821.5080002@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I was thinking about again to change from NULL to EPROBE_DEFER.

extcon_get_extcon_dev() function was almost called in the probe function.
But, this function might be called on other position instead of probe.

ENODEV is more correct error instead of EPROBE_DEFER.

Sorry. I'll withdraw my opinion related acked-by tag until we are clarifying it.

On 2018년 11월 12일 09:24, Chanwoo Choi wrote:
> Hi Andy,
> 
> On 2018년 11월 11일 03:10, Andy Shevchenko wrote:
>> All current users of extcon_get_extcon_dev() API considers
>> an extcon device a mandatory to appear. Thus, they all convert
>> NULL pointer to -EPROBE_DEFER error code.
>>
>> There is one more caller anticipated with the same requirements.
>>
>> To decrease a code duplication and a burden to the callers,
>> return -EPROBE_DEFER directly from extcon_get_extcon_dev().
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  drivers/extcon/extcon-axp288.c        | 4 ++--
>>  drivers/extcon/extcon.c               | 2 +-
>>  drivers/power/supply/axp288_charger.c | 8 ++++----
>>  drivers/usb/phy/phy-omap-otg.c        | 6 +++---
>>  drivers/usb/typec/tcpm/fusb302.c      | 4 ++--
>>  5 files changed, 12 insertions(+), 12 deletions(-)
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> Best Regards,
> Chanwoo Choi
> 
>>
>> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
>> index a983708b77a6..3472d3b756ed 100644
>> --- a/drivers/extcon/extcon-axp288.c
>> +++ b/drivers/extcon/extcon-axp288.c
>> @@ -360,8 +360,8 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>>  		name = acpi_dev_get_first_match_name("INT3496", NULL, -1);
>>  		if (name) {
>>  			info->id_extcon = extcon_get_extcon_dev(name);
>> -			if (!info->id_extcon)
>> -				return -EPROBE_DEFER;
>> +			if (IS_ERR(info->id_extcon))
>> +				return PTR_ERR(info->id_extcon);
>>  
>>  			dev_info(dev, "controlling USB role\n");
>>  		} else {
>> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
>> index 5ab0498be652..2bd0f2f33f05 100644
>> --- a/drivers/extcon/extcon.c
>> +++ b/drivers/extcon/extcon.c
>> @@ -884,7 +884,7 @@ struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
>>  		if (!strcmp(sd->name, extcon_name))
>>  			goto out;
>>  	}
>> -	sd = NULL;
>> +	sd = ERR_PTR(-EPROBE_DEFER);


(snip)

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
