Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D27CC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEF920834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Rf1sVKIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDEF920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbeLCJxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:53:53 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54413 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeLCJxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:53:52 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181203095331euoutp0237ccd26580dfc2c49a367ce9e246ce5b~syfGblzgo1374913749euoutp02N
        for <linux-kernel@vger.kernel.org>; Mon,  3 Dec 2018 09:53:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181203095331euoutp0237ccd26580dfc2c49a367ce9e246ce5b~syfGblzgo1374913749euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543830811;
        bh=r/a/ohCux/7YMu39A2WgPKzqb0opowrMWjEgTFSx8EM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Rf1sVKIbEE3rIvhfspF+lqWMN02lOqB/LOydEauiEORmwiczCXk5ZIh+TBjQon+uJ
         +VvsmKYQh163g/VKXvdEtVJDUJrkJ9auWfaS8D/Qd7cRy36rVLh81lJFipsl6VjqFm
         w46ld14TW5E2IAcMjjzSpS4MvpN+L1yYr12mD0W4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181203095331eucas1p289182b1c89e37f3c51bf6857c10de813~syfFxNP5q3217432174eucas1p2O;
        Mon,  3 Dec 2018 09:53:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2C.F7.04294.A1DF40C5; Mon,  3
        Dec 2018 09:53:30 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181203095330eucas1p1bb43c679342c06db08132480a3dd9fab~syfEzM4q50189901899eucas1p1m;
        Mon,  3 Dec 2018 09:53:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181203095330eusmtrp19713605e0681c65e0ec5fec8c06f2899~syfEyFnVO2714327143eusmtrp1j;
        Mon,  3 Dec 2018 09:53:30 +0000 (GMT)
X-AuditID: cbfec7f4-c77a99c0000010c6-61-5c04fd1a26aa
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 05.BE.04128.91DF40C5; Mon,  3
        Dec 2018 09:53:30 +0000 (GMT)
Received: from [192.168.137.240] (unknown [106.210.237.40]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181203095329eusmtip1452f996cea46032f3e57ba66a4222b2d~syfEUTkl22819228192eusmtip19;
        Mon,  3 Dec 2018 09:53:29 +0000 (GMT)
Subject: Re: [PATCH v1 11/12] usb: gadget: Add configfs attribuite for
 controling match_existing_only
To:     Yu Chen <chenyu56@huawei.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     suzhuangluan@hisilicon.com, kongfei@hisilicon.com,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Binghui Wang <wangbinghui@hisilicon.com>
From:   Krzysztof Opasiak <k.opasiak@samsung.com>
Message-ID: <1eafffa7-9183-d9c9-2d22-410cc6e0982a@samsung.com>
Date:   Mon, 3 Dec 2018 10:53:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181203034515.91412-12-chenyu56@huawei.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7djPc7pSf1liDA6s1bM41vaE3eL6M0mL
        +UfOsVo0L17PZnHmt67Fxu//mC0u75rDZrFoWSuzRfdPO4vzrTOYHbg8Hs/dyO7RcuQtq8em
        VZ1sHneu7WHz2D93DbvH501yAWxRXDYpqTmZZalF+nYJXBkrT01hLFjHWbH+3QG2Bsb97F2M
        nBwSAiYSx+b8Yeti5OIQEljBKLH5yGMmCOcLo8TytmvMEM5nRok3Xx+wwrTMmjmXGcQWEljO
        KLFntTVE0QdGiRnrFoElhAXSJZ6t/wS2Q0SgQuLHgW9gNrPAbUaJ3Sskuhg5ONgE9CXm7RIF
        CfMK2Emcn7GcEcRmEVCR+PhxERuILSoQIdFxfzUbRI2gxMmZT1hAbE4BK4npN94wQ4wUl7j1
        ZD4ThC0vsf3tHLCjJQROsUtc61wA9aeLROuXHkYIW1ji1fEtUHEZidOTe1gg7GqJ3wuOMEI0
        dzBK7PjfC9VgLfFn1UQ2kKOZBTQl1u/Shwg7Skxev4gVJCwhwCdx460gxA18EpO2TWeGCPNK
        dLQJQVQrS9xvhwWhpMT31bvZJzAqzULy2Swk38xC8s0shL0LGFlWMYqnlhbnpqcWG+WllusV
        J+YWl+al6yXn525iBKao0/+Of9nBuOtP0iFGAQ5GJR5eh3iWGCHWxLLiytxDjBIczEoivAWF
        QCHelMTKqtSi/Pii0pzU4kOM0hwsSuK81QwPooUE0hNLUrNTUwtSi2CyTBycUg2MGW3Lr8Zc
        +L77cT7nq491Z4635jgvV1A5wKkSrWqsnaR+scF6S5O80YxUocvyN+6r/pPn4N+UWfZLS/Hr
        vx1qczL7VKaoW180aKg15atO9zq6yN4wm2uD0bX0lGkzJntVcnxX52NrTHp9d7f/kkBhM5aV
        SZJ16Sv+7bqzR2Zh4ySDlNToKVeUWIozEg21mIuKEwHRRslDTQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xu7pSf1liDP7eYbQ41vaE3eL6M0mL
        +UfOsVo0L17PZnHmt67Fxu//mC0u75rDZrFoWSuzRfdPO4vzrTOYHbg8Hs/dyO7RcuQtq8em
        VZ1sHneu7WHz2D93DbvH501yAWxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZG
        pkr6djYpqTmZZalF+nYJehkrT01hLFjHWbH+3QG2Bsb97F2MnBwSAiYSs2bOZe5i5OIQEljK
        KPFy8mSohKTE9BcnmCFsYYk/17rYIIreMUocO7CYESQhLJAu8Wz9J7AGEYEKiTv/34JNYha4
        zyhx49FCqLF7GCVuPfgN1MHBwSagLzFvlyhIA6+AncT5GcvBBrEIqEh8/LiIDcQWFYiQOPty
        HSNEjaDEyZlPWEBsTgEriek33oBdxCxgJjFv80MoW1zi1pP5TBC2vMT2t3OYJzAKzULSPgtJ
        yywkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGJnbjv3csoOx613wIUYBDkYl
        Hl6HeJYYIdbEsuLK3EOMEhzMSiK8BYVAId6UxMqq1KL8+KLSnNTiQ4ymQM9NZJYSTc4HJo28
        knhDU0NzC0tDc2NzYzMLJXHe8waVUUIC6YklqdmpqQWpRTB9TBycUg2M6152tYaqXX8TeCX0
        68tHlwKusRtP3ZJ9zLfYK/aM8JlGw6fHxUpUw++fPX7ugnit7MF193/43Du2Z6e/YcSUbbNb
        /e20P29RFdv9ciNz6IRLu9i1+Ltki16HKK/QTtU0eqdtv15//t3HCl9luNfwfJjSUrSGd4ft
        gb7jUj7rqg4d1vqweO+DPCWW4oxEQy3mouJEAFS8r5fiAgAA
X-CMS-MailID: 20181203095330eucas1p1bb43c679342c06db08132480a3dd9fab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181203034629epcas3p12958dc0d45a7de56c65d24390b4d0dd7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203034629epcas3p12958dc0d45a7de56c65d24390b4d0dd7
References: <20181203034515.91412-1-chenyu56@huawei.com>
        <CGME20181203034629epcas3p12958dc0d45a7de56c65d24390b4d0dd7@epcas3p1.samsung.com>
        <20181203034515.91412-12-chenyu56@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03.12.2018 04:45, Yu Chen wrote:
> Currently the "match_existing_only" of usb_gadget_driver in configfs is
> set to one which is not flexible.
> Dwc3 udc will be removed when usb core switch to host mode. This causes
> failure of writing name of dwc3 udc to configfs's UDC attribuite.
> To fix this we need to add a way to change the config of
> "match_existing_only".
> This patch adds a configfs attribuite for controling match_existing_only
> which allow user to config "match_existing_only".
> 

To be honest I strongly disagree with that patch.
This attribute was intended for build-in gadgets to allow user to decide 
whether probe should fail or gadget should wait for UDC (used when 
gadget is built-in). For ConfigFS we expect the UDC to always exist 
prior to binding a gadget to it. If UDC goes away from what ever reason 
gadget should be unbound.

So what this patch does in my opinion is abusing the attribute and 
hacking the kernel instead of creating a simple udev rule that whenever 
dwc3 appears and it gadget should be enabled write its name to UDC 
attribute.

Best regards,
-- 
Krzysztof Opasiak
Samsung R&D Institute Poland
Samsung Electronics
