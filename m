Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4337EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA6E217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V/T4nlX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388300AbeLTR6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:58:54 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43331 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732962AbeLTR6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:58:53 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181220175851euoutp029308cc810ccaa75e550c71e2b3023d33~yHEtObnJE0863608636euoutp026
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 17:58:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181220175851euoutp029308cc810ccaa75e550c71e2b3023d33~yHEtObnJE0863608636euoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545328731;
        bh=OmsqKTefN/X3Fj5MKU2kcmAyXr69Rl0GRhWimkYIyFs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=V/T4nlX0RpG8o9dqAX6i9aORBGM2bcaktpkte8nwZhuV6iQha9kmnq8EV2D726WdY
         eVQ4z2mQCUpCyqaOJa/mKXWvnr4NtpufVKk/1Ly6gs1XheUy9KJLb6CZmIaSC0CuvZ
         7iOxRHppAx4qaN8oBNYVidM3eRATyh384L53WXCo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181220175851eucas1p16e8f6b602746a85eadfc102e34bce7a6~yHEsySM810166901669eucas1p13;
        Thu, 20 Dec 2018 17:58:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 95.3F.04441.B58DB1C5; Thu, 20
        Dec 2018 17:58:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181220175850eucas1p1ea29841e7bbde2f76f4ec42cd4db24ba~yHEr8nHg70166801668eucas1p14;
        Thu, 20 Dec 2018 17:58:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181220175850eusmtrp1323382a5178abd6e3dd1930a07900d6d~yHEruQ-AF0934709347eusmtrp10;
        Thu, 20 Dec 2018 17:58:50 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-27-5c1bd85b6222
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4C.DF.04128.A58DB1C5; Thu, 20
        Dec 2018 17:58:50 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181220175849eusmtip2b962ca447031fd8e2b7ec3f832350435~yHErYxF2u2206422064eusmtip2X;
        Thu, 20 Dec 2018 17:58:49 +0000 (GMT)
Subject: Re: [PATCH] fbdev: fsl-diu: remove redundant null check on cmap
To:     Timur Tabi <timur@kernel.org>, Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <ad9f6b25-b495-720d-8c36-b3bc76e9a173@samsung.com>
Date:   Thu, 20 Dec 2018 18:58:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <bda8bdc3-46cb-883d-1ddc-8fda0cf241be@kernel.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djPc7rRN6RjDO7fZbe48vU9m8WJvg+s
        Fpd3zQGyfqtbnHv1k81iU8dRdgc2j02rOtk87ncfZ/L4vEnOY82+HywBLFFcNimpOZllqUX6
        dglcGUfe7GMseMhcsXLZA7YGxmbmLkZODgkBE4kDl7+ydDFycQgJrGCUmLa4nw3C+cIo0bjx
        LyOE85lRYmfjezaYlmOdh9khEssZJR6d62CCcN4zShzbOYMFpEpYwEPiastdsA4RAWeJxbt/
        g8WZBaok/u5ZChZnE7CSmNi+ihHE5hWwk1iy9juYzSKgKnF19VEgm4NDVCBCov+MOkSJoMTJ
        mU/AxnAClXfMv8QOMVJeYvvbOcwgN0gI9LNLXGv/yAbSKyHgIrFziTvE0cISr45vYYewZSRO
        T+5hgaifzijx5tdSKGc9o8SaM8eYIKqsJQ4fv8gKMohZQFNi/S59iLCjxIrlj1kh5vNJ3Hgr
        CHEDn8SkbdOZIcK8Eh1tQhDVahIblm1gg1nbtXMlNNg9JH6+uco+gVFxFpLPZiH5ZhbC3gWM
        zKsYxVNLi3PTU4sN81LL9YoTc4tL89L1kvNzNzECk8rpf8c/7WD8einpEKMAB6MSD++F7dIx
        QqyJZcWVuYcYJTiYlUR41x8CCvGmJFZWpRblxxeV5qQWH2KU5mBREuetZngQLSSQnliSmp2a
        WpBaBJNl4uCUamAsufH53rQEW71I9hrTWXrTnMJiQro3vppiIrz32vfi/YGcaZeE5yTMYxFg
        MVu56jjLWo3Elyd+3Co9nrv00fvec2UxX7irPrVYpN8KmXadte/rx+S6lzySbK0BXS9nHrOe
        9pL33uv3xZedRR5x1qz4Uha9c4fGBzkWn9qKskWNlVmqrilr3z9XYinOSDTUYi4qTgQAGshl
        TiYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xe7pRN6RjDNobeC2ufH3PZnGi7wOr
        xeVdc4Cs3+oW5179ZLPY1HGU3YHNY9OqTjaP+93HmTw+b5LzWLPvB0sAS5SeTVF+aUmqQkZ+
        cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexpE3+xgLHjJXrFz2gK2B
        sZm5i5GTQ0LAROJY52H2LkYuDiGBpYwSpxY9Zeti5ABKyEgcX18GUSMs8edaFxtEzVtGiZ0n
        +1hBEsICHhJXW+6ygdgiAs4Si3f/ZoEoOsQosfXGGRaQBLNAlcStv4+YQGw2ASuJie2rGEFs
        XgE7iSVrv4PZLAKqEldXHwWzRQUiJG497GCBqBGUODnzCZjNCVTfMf8SO8RMdYk/8y4xQ9jy
        EtvfzmGewCg4C0nLLCRls5CULWBkXsUoklpanJueW2ykV5yYW1yal66XnJ+7iREYL9uO/dyy
        g7HrXfAhRgEORiUeXo1d0jFCrIllxZW5QE9xMCuJ8K4/BBTiTUmsrEotyo8vKs1JLT7EaAr0
        xERmKdHkfGAs55XEG5oamltYGpobmxubWSiJ8543qIwSEkhPLEnNTk0tSC2C6WPi4JRqYDx/
        41ZNhM60m5duTGzcJnyql12f2XgG650X+Q52O+20SnzTlvZYta84lfbZUXvtAVWv76+Vk3Yf
        yJnZurj6crCb+MI+kX0mF8Sy/y85MePsrhO/u8rEZ9fKfHvZtn3n/UPGHy25FP9s/5Wq/PDL
        u/el3nmaG7iCWJflLikz+lslsmsSv8fX+OtKLMUZiYZazEXFiQA+QhCGrQIAAA==
X-CMS-MailID: 20181220175850eucas1p1ea29841e7bbde2f76f4ec42cd4db24ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181203145425epcas5p31989c68b52994dd2e85f4372082a7ebe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203145425epcas5p31989c68b52994dd2e85f4372082a7ebe
References: <20181203064317.57054-1-wen.yang99@zte.com.cn>
        <CGME20181203145425epcas5p31989c68b52994dd2e85f4372082a7ebe@epcas5p3.samsung.com>
        <bda8bdc3-46cb-883d-1ddc-8fda0cf241be@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/03/2018 03:53 PM, Timur Tabi wrote:
> On 12/3/18 12:43 AM, Wen Yang wrote:
>> The null check on &info->cmap is redundant since cmap is a struct
>> inside fb_info and can never be null, so the check is always true.
>> we may remove it.
>>
>> Signed-off-by: Wen Yang<wen.yang99@zte.com.cn>
> 
> Acked-by: Timur Tabi <timur@kernel.org>

Patch queued for 4.21, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
