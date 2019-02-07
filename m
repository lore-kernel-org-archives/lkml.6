Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F5BC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E3F21902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sZ+J5qSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfBGMLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:11:24 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46823 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfBGMLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:11:22 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190207121120euoutp01372131f1dfceaf61e1af88dec7551455~BE8RGHbj-2933129331euoutp01-
        for <linux-kernel@vger.kernel.org>; Thu,  7 Feb 2019 12:11:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190207121120euoutp01372131f1dfceaf61e1af88dec7551455~BE8RGHbj-2933129331euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549541480;
        bh=2eyJDlTKR8VXSIEydfLghRocx1prP49pwrBjMb74ig0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=sZ+J5qSOMTT6GaMJCInL+Ntjh/Ktj0C846kX/wnlz7xpxr3uJLsZ9aDbvZ65VdGDJ
         GOwiCcxc9KPZ6x0dIwnKFLlI1PfEOQd0NCdtLi5PJ3do9pT9tLSUTM5RyExWhUfLO8
         aHijGMCbsDFZ+iqXMTcIi9MHMmdfWAdFff4++GM8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190207121120eucas1p1b9433cf685a97a2698dee1ecf9f4163c~BE8Qp7C811574015740eucas1p17;
        Thu,  7 Feb 2019 12:11:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E2.9A.04806.7602C5C5; Thu,  7
        Feb 2019 12:11:19 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190207121119eucas1p27c173ad3592b433a4273da31caec6e2b~BE8P9sJMH2370623706eucas1p21;
        Thu,  7 Feb 2019 12:11:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190207121119eusmtrp1185613dc15759d681eee530df052b589~BE8PveoIv1816518165eusmtrp1k;
        Thu,  7 Feb 2019 12:11:19 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-46-5c5c2067c1bf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 54.0D.04284.6602C5C5; Thu,  7
        Feb 2019 12:11:18 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190207121118eusmtip2ddd34380f62f366c3550ab213f85dc26~BE8Pad1De1853518535eusmtip2i;
        Thu,  7 Feb 2019 12:11:18 +0000 (GMT)
Subject: Re: [PATCH 1/1] ata: pata_samsung_cf: simplify getting .driver_data
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <db237310-2a6f-e390-7032-d33262916216@samsung.com>
Date:   Thu, 7 Feb 2019 13:11:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181021195949.1351-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduznOd10hZgYgztL9CxW3+1nszi24xGT
        xeVdc9gstr58x2TRd87dgdXj8tlSj2cL17N4fN4kF8AcxWWTkpqTWZZapG+XwJWxeO4T9oLp
        zBVvnsxha2C8ztTFyMEhIWAisWGrZhcjF4eQwApGiRXHrzN2MXICOV8YJWb8ZoNIfGaU+P3y
        OxtMQ88seYj4ckaJ6d09UEXvGSVmLbnHDtItLOAj0X1mDhOILSJgLLGmeTZYnFmgTuJ431uw
        OJuAlcTE9lVg23gF7CRmPH8OFmcRUJGYsHkVK8gyUYEIif4z6hAlghInZz5hAbE5BVwlmubs
        YYQYaSBxZNEcVghbXmL72znMIPdICDSzS2y9OJENJCEh4CJx/N9EdghbWOLV8S1QtozE6ck9
        LBAN0xkl3vxaCuWsZ5RYc+YYE0SVtcTh4xdZIWxHiRuPJzNDgoJP4sZbQYjNfBKTtk2HCvNK
        dLQJQVSrSWxYtoENZlfXzpXMELaHxKSf3YwTGBVnIfltFpJ/ZiH5ZwEj8ypG8dTS4tz01GLj
        vNRyveLE3OLSvHS95PzcTYzA9HH63/GvOxj3/Uk6xCjAwajEwxtwKypGiDWxrLgy9xCjBAez
        kgivmFxMjBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeaoYH0UIC6YklqdmpqQWpRTBZJg5OqQZG
        1se7ci+8fHRr47z2hfOZypg/868KNruTsfRbcbFi1extzXqbtjWqMZvKf1ofUhY2l1vCmLtc
        fu+8gvuLNeyNeCJZnLacOnHnecGa2/mRzcnnlxeYd327LXkqvi4q0dLoO99PwQqm1jlZCWeb
        i8MYNGq/ydpu9lk35fC8tK6UGzVfT+/c/vqGEktxRqKhFnNRcSIAdd5VKxsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42I5/e/4Pd00hZgYg+sPrSxW3+1nszi24xGT
        xeVdc9gstr58x2TRd87dgdXj8tlSj2cL17N4fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdo
        aaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJexeO4T9oLpzBVvnsxha2C8ztTFyMEhIWAi
        0TNLvouRi0NIYCmjxM5HC1kg4jISx9eXdTFyApnCEn+udbGB2EICbxklli6KBbGFBXwkus/M
        YQKxRQSMJdY0z2aHmHOZUWLlugdgDcwCdRIzvk4FK2ITsJKY2L6KEcTmFbCTmPH8OVicRUBF
        YsLmVawgtqhAhMSthx0sEDWCEidnPgGzOQVcJZrm7GGEmKknseP6L1YIW15i+9s5zBMYBWch
        aZmFpGwWkrIFjMyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAqNi27Gfm3cwXtoYfIhRgINR
        iYc34FZUjBBrYllxZe4hRgkOZiURXjG5mBgh3pTEyqrUovz4otKc1OJDjKZAT0xklhJNzgdG
        bF5JvKGpobmFpaG5sbmxmYWSOO95g8ooIYH0xJLU7NTUgtQimD4mDk6pBsboaKUvNz7xHZs2
        x2/X2e2RXmFcd3RSQ041Ga/cczQ88HBX0/elpoI9uxazscf5P3WrOd6m/+tB9JuaI3Idl+9Z
        V/z7U/aTL9Atb+KbkGzd6kdKQec2POXcnt+6vy9qoU7cfq0U5hjB02xZ36YdyM1J+Jjsfb36
        Wr7M4ijPWRH8sto/uC7lxCixFGckGmoxFxUnAgDwjdIvoAIAAA==
X-CMS-MailID: 20190207121119eucas1p27c173ad3592b433a4273da31caec6e2b
X-Msg-Generator: CA
X-RootMTR: 20181021200001epcas1p29d6bcf070cdacfe093b17e2c2c3b6f50
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181021200001epcas1p29d6bcf070cdacfe093b17e2c2c3b6f50
References: <20181021195949.1351-1-wsa+renesas@sang-engineering.com>
        <CGME20181021200001epcas1p29d6bcf070cdacfe093b17e2c2c3b6f50@epcas1p2.samsung.com>
        <20181021195949.1351-2-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/21/2018 09:59 PM, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
