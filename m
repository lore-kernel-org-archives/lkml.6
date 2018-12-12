Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA67C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493CF2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="q9r9iMw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493CF2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeLLAz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:55:27 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:58110 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeLLAz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:55:26 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181212005519epoutp0392db34ba9cf89f4794e490ae5232571b~vb8v-WiOi3080730807epoutp03o;
        Wed, 12 Dec 2018 00:55:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181212005519epoutp0392db34ba9cf89f4794e490ae5232571b~vb8v-WiOi3080730807epoutp03o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544576119;
        bh=zzJoh7mRVCOBl1xky9pE4A7hnTX0+nGgSquXSKP7E9c=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=q9r9iMw577ONXX4jESwPltuMNYYf74E5N0012pZtRwvsvCmQOD9sictznaly1tBvl
         ohZELFPcieT7fHyUrtMx1RH8b2kTXKX+qwifuvTVXidmJE/O7hwtgBcR0UOa+r2tA6
         48L7xh2OvnxmVAuVFx2mNn8/MKRvk0nC5inW896U=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.155]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20181212005512epcas1p47121963521d90d9d8f39d3f50e8a823d~vb8prn4qH1511015110epcas1p4F;
        Wed, 12 Dec 2018 00:55:12 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.EF.04060.F6C501C5; Wed, 12 Dec 2018 09:55:11 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181212005510epcas1p336cc9aa68f2d7b8de918161fb128a2f2~vb8oE-Rcj2033620336epcas1p3G;
        Wed, 12 Dec 2018 00:55:10 +0000 (GMT)
X-AuditID: b6c32a37-411ff70000000fdc-1d-5c105c6f567c
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.ED.03601.E6C501C5; Wed, 12 Dec 2018 09:55:10 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PJL00BZ9MJX9330@mmp1.samsung.com>; Wed, 12 Dec 2018 09:55:10 +0900 (KST)
Message-id: <5C105C6D.30806@samsung.com>
Date:   Wed, 12 Dec 2018 09:55:09 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-pwm@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i2c@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, linux-rtc@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] MAINTAINERS: add maintainers for ChromeOS EC
 sub-drivers
In-reply-to: <20181211190953.13626-1-enric.balletbo@collabora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0wbZRjH8/aud8e08FJA39QZ8LKZjQhSurJ3OubQZbnEZSMzJg6J9YSz
        kJa26RV0zh8ITn4Elg2yaJAfDhlzXR0KHesKs0o7RoawwDon2SpmkqU0iBvCVgWmLbdF/nt+
        fJ7nzff75mEIZTutYopNNsFq4o0stYbs9W5MTzPnw/yMW2GIO8au0ri5y0HhqtlOGi83DNL4
        s6krJG6+/AmJ23yjcuxtDwLsuD4AcOVXXRS+FOok8G8VdhnuGa2TY/e/MwTuaGyT48mFCwBX
        L88D3OqbJfHE3F05vuJupvBf9T6AAwE7wIOn/BQ+fm1Mhv+cq5Hh6x9/TeGzPccIvOiOvHvw
        vI/Gw302/Le7ldyezDlaHYBb/KcBcK2OA9wX5WMk5wp0AM55ckLGnWsK0NztO29w3fYairvx
        cz/FDX2+SHKeFgfNdcwMyLkb4eOAu1zpA9whpx3kKvMMW4sEvlCwpgimAnNhsUmfzb78iu4l
        nTYrQ52m3oI3sykmvkTIZnfsyk3bWWyMeMamlPHG0kgplxdF9tltW63mUpuQUmQWbdmsYCk0
        WrZY0kW+RCw16dMLzCXPqTMyMrUR8E1D0R8XfyQsZ+G7S6fc8nJQF1sLYhgENyGv307UgjWM
        EroA8nb3U1JyDyD7SKXsIXVmZIaUGn0AnayfoKINBYxH4cZfIw2GIWAy8o0bomUCbkRn+rpo
        iQ8ANOS/L5P4DegnT688ypNwPRoP8tEyBVORJ/jLyso4+BS6Gv4dROMk+Bo613aXjsaJcB9q
        qLoDojsJ2MuglhPNRHRPAtyLOuf1USYGvoiC9rkVNQj6GDTsChKSgB2owv89KcUJKHTRSUdn
        EXwCjV/IlvgqgOaDlXIpOQzQ7Us9D9Rr0K1jtTJJWSyaXaiTS8MKVP2pUkI4NNJy4oHgowAt
        lU/JDoMnm1Z51PS/R02rPPoSEHbwmGARS/SCqLZoVv9eN1i5j9TNLvDt6K4BABnAPqpwheLy
        lXK+TNxfMgAQQ7CJirWZMF+pKOT3vydYzTprqVEQB4A2YvERQpVUYI5cm8mmU2szNRoN3qTO
        0qrV7OOKKVXL60qo522CQRAsgvXhnIyJUZWDnKx7T+cVxr3zVu6eHG2ZZ8M3IdAR9g8mEG+7
        agKNLs3zH9kXB99/RtHeuK166cCrnvbspKPr6uP3wf6u71TTsoOKoWsfJGbN39yes14FdJNr
        8+iq6UPO0869Bvu09f6eHya9ffW5u184fWT0/ELiIx8Ox49bKkLhhtiZseXwzaaYZJYUi3h1
        KmEV+f8AoRQeuDUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se2yLURyGnX7XNWpH3Q6TiIpsJpt7coiISCRHQkKEuDT4Zl82sVb1a2dz
        SeauHSITITXFdEJbkaxYV5fSVTGs69RlmRoZUbO5jNGZmX1ZxP578z5vznn++PGU2sKM4jfo
        TaJRL+RpWCX98E8zzNBroXayJzEWOyJPOVx62c3i/Z/Oc7i7JMTh42+f0Lg0vIfGp4O1DK4u
        iwPsbgwAvPvcZRbXtJyn8OtdTgX21B5ksK+nlcKOo6cZ3NRxF+AD3d8Btgc/0bih/QeDn/hK
        WfztUBDgWMwJcMgVZXH584gCf263KHDjzgssrvScpXCXr/ffvTeDHH543YQ7fXZ67hjitrsB
        6fpVAojdvY2cLIrQxBtzAHLlYoOCVNliHPnydQ2pcFpY8vLZDZbcP9FFE/8pN0ccrQGGvEyU
        AxLeHQTk8BUnWKxepZydLeZtyBeNk+asU+a23btDGSphwW+XjykCBwdZQRKP4HR09XErbQVK
        Xg2rAHL8tHIyUMHBKHH0VS/geQqOQcH6jXJNwVRUYi+j5KyGTQB1Hsvvm6ehR/5rjDyn4XhU
        HxfkmoXpyB9/wco5GY5FTxPNQJ4MgytQ8f1CuR4KV6KQ5wzX97qXRw01qXIeAhejU+/Cij6z
        4wC9ulRMyyAJzkNxZzt1BEBbP1Hbf1FbP9EzgHKCkaJB0uXopKmGKXpxS6Yk6CSzPidz/SZd
        Beg9kGvV6Ye9oMmxNgAgDzQDVd6WZK2aEfKlQl0AIJ7SDFWNngq1alW2ULhVNG5aazTniVIA
        pPC0ZoSqUR9aqYY5gkncKIoG0fiPKvikUUVAKPCkbV82OzV6KZp4Y9nhGlk3a29bovJs+Huy
        aVz05z5oLp01zU4t3KfrXLBKb31uK7s+PPvxgJm3s279sHMfUvaMP2H+WB3vkET1x5SMqumm
        B/OzsrOGrN+61Lt54vuMY3UT2mbsXGf42tJTvly1PLKE+ArKJy268Ptct7++2JW7WkNLucKU
        dMooCX8BKmeAMxwDAAA=
X-CMS-MailID: 20181212005510epcas1p336cc9aa68f2d7b8de918161fb128a2f2
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181211191040epcas2p2a15c57e7488f216d012efe553a007d43
References: <CGME20181211191040epcas2p2a15c57e7488f216d012efe553a007d43@epcas2p2.samsung.com>
        <20181211190953.13626-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On 2018년 12월 12일 04:09, Enric Balletbo i Serra wrote:
> There are multiple ChromeOS EC sub-drivers spread in different
> subsystems, as all of them are related to the Chrome stuff add
> Benson and myself as a maintainers for all these sub-drivers.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v2:
> - Fix typo in Benson email address.
> 
>  MAINTAINERS | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a24129b0b043..bbe7180e2851 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3625,6 +3625,30 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git
>  F:	drivers/platform/chrome/
>  
> +CHROMEOS EC SUBDRIVERS
> +M:	Benson Leung <bleung@chromium.org>
> +M:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
> +F:	Documentation/devicetree/bindings/input/cros-ec-keyb.txt
> +F:	Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
> +F:	Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt
> +F:	Documentation/devicetree/bindings/mfd/cros-ec.txt
> +F:	Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> +F:	drivers/extcon/extcon-usbc-cros-ec.c
> +F:	drivers/i2c/busses/i2c-cros-ec-tunnel.c
> +F:	drivers/iio/accel/cros_ec*
> +F:	drivers/iio/common/cros_ec_sensors/
> +F:	drivers/iio/light/cros_ec*
> +F:	drivers/iio/pressure/cros_ec*
> +F:	drivers/input/keyboard/cros_ec*
> +F:	drivers/mfd/cros_ec*
> +F:	drivers/power/supply/cros_usbpd-charger.c
> +F:	drivers/pwm/pwm-cros-ec.c
> +F:	drivers/rtc/rtc-cros-ec.c
> +F:	include/linux/iio/common/cros_ec_sensors_core.h
> +F:	include/linux/mfd/cros_ec*
> +
>  CIRRUS LOGIC AUDIO CODEC DRIVERS
>  M:	Brian Austin <brian.austin@cirrus.com>
>  M:	Paul Handrigan <Paul.Handrigan@cirrus.com>
> 

For extcon part,
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
