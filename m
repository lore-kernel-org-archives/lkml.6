Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3FCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A4721720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OBRGtc5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbeLTQzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:55:24 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:32823 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732431AbeLTQzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:55:24 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181220165521euoutp02a5ba86174321d67fd608882527e252a1~yGNQ8DPJj1155911559euoutp02H
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 16:55:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181220165521euoutp02a5ba86174321d67fd608882527e252a1~yGNQ8DPJj1155911559euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545324922;
        bh=yhCtv3EL3A0jGB3sHGBVh9EMS4w56zCzUj4eRYeFKzI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OBRGtc5SFlKaIZZY+Omef66rvKymKHYkQPIXgxQijwqU8lB9vBQ3U+4/CH7eVymAY
         He5gGLfj+VBfnKAuDmm3/YPweHxO1sxRZzXoQvSxgFinK4sPHnb0kEW3yNi+NrzhIk
         CVsPPythzXHfOUosrOQRLMeMllUQzaQR9CN0FhW4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181220165521eucas1p17092756a2d509f5de9599f4cea63f06a~yGNQl_5Pt0170801708eucas1p1u;
        Thu, 20 Dec 2018 16:55:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 4A.1C.04441.979CB1C5; Thu, 20
        Dec 2018 16:55:21 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181220165520eucas1p28446c42d5fe48e0362e337f2067d687e~yGNP6j0kH2397123971eucas1p2m;
        Thu, 20 Dec 2018 16:55:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181220165520eusmtrp1e97941ee82b26af2c95e96750ea93c75~yGNPsOrxB2247622476eusmtrp1s;
        Thu, 20 Dec 2018 16:55:20 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-73-5c1bc979678b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E9.F7.04284.879CB1C5; Thu, 20
        Dec 2018 16:55:20 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181220165520eusmtip29fba7d87adfa6d6bffc1dfd918feae9e~yGNPX-KSd0613106131eusmtip2O;
        Thu, 20 Dec 2018 16:55:20 +0000 (GMT)
Subject: Re: [PATCH -next] video: fbdev: pxafb: Fix
 "WARNING: invalid free of devm_ allocated data"
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     daniel@zonque.org, robert.jarzmik@free.fr,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <a24ef622-d811-dd6e-450f-a75bf4392215@samsung.com>
Date:   Thu, 20 Dec 2018 17:55:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181116110255.19736-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djPc7qVJ6VjDK7eErFo+vuKxeLK1/ds
        Fif6PrBaXN41h81i1hthiztfn7M4sHn0r/vM6tFy5C2rx/3u40wenzfJeWzfvZwlgDWKyyYl
        NSezLLVI3y6BK+P7zneMBVuYK2YdvM3awPiGqYuRk0NCwETi4OmVQDYXh5DACkaJlt0drCAJ
        IYEvjBLPZmdBJD4zSixuO83WxcgB1tF5QgcivpxR4v38o1Dd7xklZrxrZATpFhZIlXi4fjOY
        LSKgJtFyagszSBGzQDejxIvVj9lBEmwCVhIT21eBFfEK2El8fLOGDcRmEVCVmHf9JyPINlGB
        CIn+M+oQJYISJ2c+YQGxOQWsJXrXHAcrZxYwkDiyaA4rhC0vsf3tHLBdEgLz2CU6ZzczQ1zt
        ItG4LgjiZWGJV8e3sEPYMhKnJ/ewQNRPZ5R482splLOeUWLNmWPQQLKWOHz8IiuE7Shx8nI/
        C8RQPokbbwUhFvNJTNo2HWoXr0RHmxBEtZrEhmUb2GB2de1cyQxhe0hce3eBdQKj4iwkr81C
        8s4sJO8sYGRexSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZhgTv87/mkH49dLSYcYBTgY
        lXh4L2yXjhFiTSwrrsw9xCjBwawkwrv+EFCINyWxsiq1KD++qDQntfgQozQHi5I4bzXDg2gh
        gfTEktTs1NSC1CKYLBMHp1QDY5ypsOmjkORk3bTZa4QP/1j/NPrW9m9T19T8+bpvWvxDOa73
        p/TdBftdPr49s/TaBMX2rVUZoS/niEx/an+wScRkY5OQgLxqW/T8yC9TuksZX1pemNV3QHUj
        f/Y21llhbUJy73fwqZuxTVtVsfT4xBJXxZICU5eAlLDKabMLL7/j6M3Iaj7Hp8RSnJFoqMVc
        VJwIANGpzRYsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7oVJ6VjDKYcVrJo+vuKxeLK1/ds
        Fif6PrBaXN41h81i1hthiztfn7M4sHn0r/vM6tFy5C2rx/3u40wenzfJeWzfvZwlgDVKz6Yo
        v7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+P7zneMBVuY
        K2YdvM3awPiGqYuRg0NCwESi84ROFyMXh5DAUkaJqfvWsEDEZSSOry/rYuQEMoUl/lzrYoOo
        ecsocW/FemaQhLBAqsS7UzvYQWwRATWJllNbmCGK+hglvky/zATiMAt0M0o03l3ICFLFJmAl
        MbF9FZjNK2An8fHNGjYQm0VAVWLe9Z9gcVGBCIlbDztYIGoEJU7OfAJmcwpYS/SuOQ5Wzyyg
        J7Hj+i9WCFteYvvbOcwTGAVnIWmZhaRsFpKyBYzMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3
        MQIjZ9uxn5t3MF7aGHyIUYCDUYmHV2OXdIwQa2JZcWXuIUYJDmYlEd71h4BCvCmJlVWpRfnx
        RaU5qcWHGE2BnpjILCWanA+M6rySeENTQ3MLS0NzY3NjMwslcd7zBpVRQgLpiSWp2ampBalF
        MH1MHJxSDYxtpRobnA8pNP1h/iJwVL5TXvT0Go6mTecyW73N12mw9idaqx/4cfceE1vqkXKP
        GNFv3ovy7ERNT8VeWtkvdixg0bUX3JmT63U5ZIKWOW46MXfdDYl5tV8ZN16YHbJSv+rU4TVz
        F7/8y3glz7hhRaujkRWvV4l2p6Vs0o8Ji3v+MlyO/9RZt1KJpTgj0VCLuag4EQDwwH8msgIA
        AA==
X-CMS-MailID: 20181220165520eucas1p28446c42d5fe48e0362e337f2067d687e
X-Msg-Generator: CA
X-RootMTR: 20181116110325epcas4p1a18c4e9d98ede25027bc198065d988dd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181116110325epcas4p1a18c4e9d98ede25027bc198065d988dd
References: <CGME20181116110325epcas4p1a18c4e9d98ede25027bc198065d988dd@epcas4p1.samsung.com>
        <20181116110255.19736-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/16/2018 12:02 PM, YueHaibing wrote:
> 'info->modes' got allocated with devm_kcalloc in of_get_pxafb_display.
> 
> This gives this error message:
>   ./drivers/video/fbdev/pxafb.c:2238:2-7: WARNING: invalid free of devm_ allocated data
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch queued for 4.21, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
