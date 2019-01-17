Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CAEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27BE20856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WEd5c0O7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfAQOXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:23:30 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36216 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbfAQOX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:23:26 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190117142324euoutp029f3c25efa04b12c9564647a9cd5b06b8~6qMlUlAq51168611686euoutp02N
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 14:23:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190117142324euoutp029f3c25efa04b12c9564647a9cd5b06b8~6qMlUlAq51168611686euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547735004;
        bh=kqHi7etvT6LqRMHmuqujN40XjeBE2Rqkmgsa9fcxX0k=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WEd5c0O7yG7DcAmhf/Ku+ripSek1MWpC9ueajeXYDBUYBtkuIumMdNSOYeCuH2xJq
         a+IRe6VoxCaG+/bCZA44uQDzYhCtw1Odhg+N9zp0NtRbUUqZqsofUdcB7q4658vYOl
         n5HSqet01saMnAOfme9O99r9VZ0oDnwmhTRcvkgY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190117142323eucas1p253f02f8275b506798ebc76e27b0bc767~6qMklFJi-3138531385eucas1p21;
        Thu, 17 Jan 2019 14:23:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 28.6F.04441.BDF804C5; Thu, 17
        Jan 2019 14:23:23 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190117142322eucas1p207baaff114cf906ab0f4a6dbbc6e3ad7~6qMjp-fWH2131221312eucas1p2d;
        Thu, 17 Jan 2019 14:23:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190117142322eusmtrp2e9e828d7f98657c28d211f777cda030b~6qMjaCKq60873408734eusmtrp24;
        Thu, 17 Jan 2019 14:23:22 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-05-5c408fdb578c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3D.B1.04284.ADF804C5; Thu, 17
        Jan 2019 14:23:22 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190117142322eusmtip2768723f9df714b31a1875d3d37eb3683~6qMjDS4Qs2873628736eusmtip2W;
        Thu, 17 Jan 2019 14:23:22 +0000 (GMT)
Subject: Re: [PATCH v2] fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a
 cmd, line option
To:     Peter Rosin <peda@axentia.se>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <91d4948b-d68c-f9d6-1ffd-e848851595ab@samsung.com>
Date:   Thu, 17 Jan 2019 15:23:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <672688c8-1115-1cf8-cac9-82c19219ea3a@axentia.se>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87q3+x1iDLpvy1o8OdDOaHHl63s2
        i2e39jJZLGxbwmJxou8Dq8XlXXPYLPYems/owO4x7cBsdo9DhzsYPe53H2fyWNw3mdXj8ya5
        ANYoLpuU1JzMstQifbsErozLU5wKlvFVbP1/h7WB8SV3FyMnh4SAicS2q9eYuhi5OIQEVjBK
        3Np6kBXC+cIoceXIJSjnM6PEvLOT2GFajs3uhmpZzihxbsEuqKr3jBKffp9nAqkSFoiVePxz
        BRuILSKgKLFg1yxmkCJmgXNMEo9fz2QGSbAJWElMbF/F2MXIwcErYCfxuF0HJMwioCrx6FE3
        M0hYVCBCov+MOkiYV0BQ4uTMJywgNidQ9aPL08AOYhaQl9j+dg7YeAmBVewS2/cdhLrUReL4
        4WcsELawxKvjW6DiMhL/d85ngmiYzijx5tdSFghnPaPEmjPHmCCqrCUOH7/ICnIFs4CmxPpd
        +iCmhICjxO8FPhAmn8SNt4IQN/BJTNo2nRkizCvR0SYEMUNNYsOyDWwwW7t2rmSGsD0kDs66
        zTyBUXEWks9mIflmFsLaBYzMqxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQITzel/xz/t
        YPx6KekQowAHoxIPb4eZfYwQa2JZcWXuIUYJDmYlEV7fdocYId6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4rzVDA+ihQTSE0tSs1NTC1KLYLJMHJxSDYz5CfUCQqm3tPSzz1dyLfuzbza7ghhXaQ2X
        y94W/X6foLNXKiZnexfYZcamcjAmfDhptu1VTJS36jMm2RPrDjn52s/xy2fk/Wt59NVULSb7
        +4tvPBTfxZ81bWkb7/yqb1ttfjx3tu+ue8J7of+w5h6R5y8czD68m9ezhHXRhDkvtz+POPTR
        g0GJpTgj0VCLuag4EQCwenRtMAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xe7q3+h1iDD5fkbN4cqCd0eLK1/ds
        Fs9u7WWyWNi2hMXiRN8HVovLu+awWew9NJ/Rgd1j2oHZ7B6HDncwetzvPs7ksbhvMqvH501y
        AaxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehmX
        pzgVLOOr2Pr/DmsD40vuLkZODgkBE4ljs7uZuhi5OIQEljJK3D2yhLGLkQMoISNxfH0ZRI2w
        xJ9rXWwQNW8ZJTZ92sQOkhAWiJV4/HMFG4gtIqAosWDXLGaIov2sEutWdYN1MAtcYJLYcqmV
        EaSKTcBKYmL7KrANvAJ2Eo/bdUDCLAKqEo8edTOD2KICERK3HnawgNi8AoISJ2c+AbM5gcof
        XZ4GtphZQF3iz7xLzBC2vMT2t3OYJzAKzkLSMgtJ2SwkZQsYmVcxiqSWFuem5xYb6hUn5haX
        5qXrJefnbmIExtC2Yz8372C8tDH4EKMAB6MSD2+HmX2MEGtiWXFl7iFGCQ5mJRFe33aHGCHe
        lMTKqtSi/Pii0pzU4kOMpkBPTGSWEk3OB8Z3Xkm8oamhuYWlobmxubGZhZI473mDyighgfTE
        ktTs1NSC1CKYPiYOTqkGxj7vt+o7p+5MnbL+WtvMy7qfcn0uzpQT2pxu8d5W4IJY/c0/DB5/
        P1cdsFV9LMs5W/CD4JKexwZHt8i+3Lsv+c2Oqsqpf/3XxZd/aYkQ2phhl79/0eNVzIz3uH4+
        84yYdTbPfqFG44KH1+Z+ZtQwqJp5oHPyzKmalTt9fy8w/qarumqmAKfaB3MlluKMREMt5qLi
        RAAc0/ETtwIAAA==
X-CMS-MailID: 20190117142322eucas1p207baaff114cf906ab0f4a6dbbc6e3ad7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190107103630epcas3p1939481c5a659d9dd0f11d026d7f4c4e1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190107103630epcas3p1939481c5a659d9dd0f11d026d7f4c4e1
References: <20181126215725.2548-1-peda@axentia.se>
        <20181126215725.2548-3-peda@axentia.se>
        <CAMuHMdVfoRP_yNL5HcmwwV3fn9GqnsbORtG_hOhWw3qUeMKFKQ@mail.gmail.com>
        <37be75aa-7a63-a937-6de7-777a31af741b@axentia.se>
        <CAMuHMdXR2iuftV26s-EnKo74vZxcW2w_R1dD_Mk+Ug8MsNwL3Q@mail.gmail.com>
        <cb772a2f-2d33-6d0e-9ea6-ba9eb49023f9@axentia.se>
        <662db203-ae18-4a11-7b10-3d7d480f6f37@axentia.se>
        <CAMuHMdXMidVgtz-T8PZDUrKAwJmz9B4g1hNgw6FwrCpU-m5Gew@mail.gmail.com>
        <CGME20190107103630epcas3p1939481c5a659d9dd0f11d026d7f4c4e1@epcas3p1.samsung.com>
        <6a9be31e-0bb4-d477-99e6-6cac3cd5087f@axentia.se>
        <96876402-8860-5c8a-a28f-81f8df58d0ce@samsung.com>
        <672688c8-1115-1cf8-cac9-82c19219ea3a@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/17/2019 02:40 PM, Peter Rosin wrote:
> On 2019-01-16 17:45, Bartlomiej Zolnierkiewicz wrote:
>> On 01/07/2019 11:35 AM, Peter Rosin wrote:
>>> Right. So, here's an update...
>>>
>>> Again, it would probably be best if this went in before 5.0 is released.
>>>
>>> Changes since v1:
>>> - rename from fbcon=center-logo option to fbcon=logo-pos:center (and adjust
>>>   the help text accordingly).
>>>
>>> Cheers,
>>> Peter
>>>
>>> From ebfb2feb7ea4298ac9c222e6ea6f9c9a92452084 Mon Sep 17 00:00:00 2001
>>> From: Peter Rosin <peda@axentia.se>
>>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Cc: Peter Rosin <peda@axentia.se>
>>> Cc: dri-devel@lists.freedesktop.org
>>> Cc: linux-fbdev@vger.kernel.org
>>> Cc: linux-doc@vger.kernel.org
>>> To: linux-kernel@vger.kernel.org
>>> Date: Mon, 7 Jan 2019 08:35:26 +0100
>>> Subject: [PATCH v2] fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a cmd
>>>  line option
>>>
>>> A command line option is much more flexible than a config option and
>>> the supporting code is small. Gets rid of #ifdefs in the code too...
>>>
>>> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>
>> Patch queued for 5.0, thanks.
> 
> Hmm, I see the patch on the fbdev-for-next branch, but that sounds
> like stuff destined for 5.1? Maybe you simply don't have any
> fbdev-for-current or fbdev-fixes branch or something like that?

Yes. the single public fbdev branch has been sufficient for now
(there is no active fbdev development and patches for -rcX kernels
are even more rare). OTOH there is no problem with adding -fixes
branch once needed..

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
