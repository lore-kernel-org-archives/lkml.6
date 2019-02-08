Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2B9C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C28320863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IC3V2nTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfBHRDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:03:22 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43125 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbfBHRDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:03:21 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190208170319euoutp01f0b7cf40905561e995e68624a835314a~Bckfkbv971530815308euoutp01f
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 17:03:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190208170319euoutp01f0b7cf40905561e995e68624a835314a~Bckfkbv971530815308euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549645399;
        bh=83WuKFVtGNEF1x9Bz+FCgq1wl6aWNatoYXReooDdif4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=IC3V2nTfhYSeMdYx58R2gBAfmkGIP/hRNlXvn5HHEiQsJfJngqdkGKUtENBZVo3lU
         +ryP0o1YQbsALWp1KCrKkC0Ojeo/f23fws9Lzjp/RGP3itIY5DOut9CJtdu5q0MMdY
         zbza9rV8v37Lrlw+Wmu+4zmV6NT/nXJhck9E965Q=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190208170319eucas1p13730153aac0a36401d59f1bc795784a9~Bcke1XLTd0696506965eucas1p12;
        Fri,  8 Feb 2019 17:03:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FF.EB.04441.656BD5C5; Fri,  8
        Feb 2019 17:03:18 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190208170318eucas1p23e146eb1d8ca6b31ae08e29ba0bad894~BckeC3Rhn2710827108eucas1p2M;
        Fri,  8 Feb 2019 17:03:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190208170318eusmtrp15c82ebc7b3b5a1ef7d62f1e0979e94a2~Bckd0kwzT0307703077eusmtrp1J;
        Fri,  8 Feb 2019 17:03:18 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-bf-5c5db6568733
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 97.E3.04284.556BD5C5; Fri,  8
        Feb 2019 17:03:17 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190208170317eusmtip2e1864072212f0ebee28250588d685aa4~BckdeNP960968009680eusmtip2I;
        Fri,  8 Feb 2019 17:03:17 +0000 (GMT)
Subject: Re: [PATCH] fbdev: Use of_node_name_eq for node name comparisons
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-omap@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <56f0b397-52b5-1963-5ee3-2df25394239a@samsung.com>
Date:   Fri, 8 Feb 2019 18:03:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181205195050.4759-29-robh@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djPc7ph22JjDC7fNrb40NTKbDH/yDlW
        iytf37NZnOj7wGpxedccNovZS/pZLP7v2cHuwO7R86aF1WPTqk42j/vdx5k8Pm+SC2CJ4rJJ
        Sc3JLEst0rdL4Mq4ueQBW0EDW8W6HXfZGxgbWLsYOTkkBEwkNny6DWRzcQgJrGCUWHv0DZTz
        hVHizrUNTBDOZ0aJ+2t3MsK0LJ/SygaRWM4oceraOWaQhJDAe0aJPZNlQGxhAU+Jny/2ge0Q
        EVCU+N02DWwss8BZRom2S1fBEmwCVhIT21eBTeUVsJO4vKGHHcRmEVCROPZiKVCcg0NUIEKi
        /4w6RImgxMmZT1hAbE4BU4nLt5rAbGYBA4kji+awQtjyEtvfzmEG2SUhMI9d4vmmpSwQV7tI
        7JtyCeppYYlXx7ewQ9gyEqcn97BANExnlHjzaymUs55RYs2ZY0wQVdYSh49fhOp2lJiy7y0r
        yHUSAnwSN94KQmzmk5i0bTozRJhXoqNNCKJaTWLDsg1sMLu6dq5khrA9JNbdX8A8gVFxFpLf
        ZiH5ZxaSfxYwMq9iFE8tLc5NTy02zEst1ytOzC0uzUvXS87P3cQITDOn/x3/tIPx66WkQ4wC
        HIxKPLwRLbExQqyJZcWVuYcYJTiYlUR40zYBhXhTEiurUovy44tKc1KLDzFKc7AoifNWMzyI
        FhJITyxJzU5NLUgtgskycXBKNTCu+RzOEph6z9SGza6Cf9dl1/Wu1T7fN/6/st/o++7HyVFx
        0zT8yzXmnTirKfavY5bS7evhFi27T0k/yb/+o8Tt3tvJvCERJz/e+OQTMet72vMjtgytvoIr
        N4g3ZP/blVqdvDCLKYbjTbSy0W47jntz9wUv/F2c5fv0Xi5Xs8/hPCuv199PTVukxFKckWio
        xVxUnAgAbF8cJC8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xe7qh22JjDP4ftLL40NTKbDH/yDlW
        iytf37NZnOj7wGpxedccNovZS/pZLP7v2cHuwO7R86aF1WPTqk42j/vdx5k8Pm+SC2CJ0rMp
        yi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mu4ueQBW0ED
        W8W6HXfZGxgbWLsYOTkkBEwklk9pZeti5OIQEljKKDHz0Q7mLkYOoISMxPH1ZRA1whJ/rnVB
        1bxllFjYvJAFJCEs4Cnx88U+sEEiAooSv9umsUIUdTBKTJ96jxnEYRY4zyixbfNTNpAqNgEr
        iYntqxhBbF4BO4nLG3rYQWwWARWJYy+WgsVFBSIkbj3sYIGoEZQ4OfMJmM0pYCpx+VYTmM0s
        oCex4/ovVghbXmL72znMExgFZyFpmYWkbBaSsgWMzKsYRVJLi3PTc4sN9YoTc4tL89L1kvNz
        NzECo2fbsZ+bdzBe2hh8iFGAg1GJh5ehKTZGiDWxrLgy9xCjBAezkghv2iagEG9KYmVValF+
        fFFpTmrxIUZToCcmMkuJJucDIzuvJN7Q1NDcwtLQ3Njc2MxCSZz3vEFllJBAemJJanZqakFq
        EUwfEwenVANjkEq94cz1qgvbeiwPHxRJS/MKX5q1VWD/Ct3up5PTTyWs4Vnn5Wz7z2M274KP
        iT2vbX4oPYr9ZRAVpBTQps/4O29SHF/rYZmd0bl3QyM9zGZ/ip1Qe5WxK1lR/98zziMP9v7f
        yVsSvk/I/+h1Icc7TDcO7DhhqnVDsjnwx5vrkQkrtodYyKYqsRRnJBpqMRcVJwIAfYg/A7QC
        AAA=
X-CMS-MailID: 20190208170318eucas1p23e146eb1d8ca6b31ae08e29ba0bad894
X-Msg-Generator: CA
X-RootMTR: 20181205195134epcas4p4b7400f8b88384b0deb71841100ed21ee
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181205195134epcas4p4b7400f8b88384b0deb71841100ed21ee
References: <CGME20181205195134epcas4p4b7400f8b88384b0deb71841100ed21ee@epcas4p4.samsung.com>
        <20181205195050.4759-29-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/05/2018 08:50 PM, Rob Herring wrote:
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
> 
> For instances using of_node_cmp, this has the side effect of now using
> case sensitive comparisons. This should not matter for any FDT based
> system which omap is.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Patch queued for v5.1, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
