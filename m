Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEDCC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAD220863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E8RiOzgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfBHRGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:06:47 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49470 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfBHRGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:06:47 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190208170645euoutp02cad79a810b33e8acb5f9cab3e97acaf4~BcnfgDuFi1029910299euoutp02P
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 17:06:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190208170645euoutp02cad79a810b33e8acb5f9cab3e97acaf4~BcnfgDuFi1029910299euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549645606;
        bh=2eHA4zSAVPfea6GKzFVzVNGMtDWt3hrIq//p8f5vEXI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=E8RiOzgKfvOxOuj71k2+3dsynHJOypxLLz7rvIjTJOEiFjrxe3+h+pBKDwL9K5+c7
         /6wa5Op42rDcTa0+VcWWSVRd71ESs2h+yDYxyP2dolKM8VixubOAsw27wwUQV2CwVT
         lUHvkjfYxUgLJ2v+mQD/Ob0f+gYSENViYcg7TYGA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190208170645eucas1p139e61a5e2ed5c0e9f85584fd745cc270~Bcne1opcU0807608076eucas1p1A;
        Fri,  8 Feb 2019 17:06:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B7.97.04806.427BD5C5; Fri,  8
        Feb 2019 17:06:44 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190208170644eucas1p25b4f8b4f11a85890814bbf871aa5976d~BcneEO4zj2265422654eucas1p2E;
        Fri,  8 Feb 2019 17:06:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190208170644eusmtrp1f3e2ece6211438bf72c32d5b92e33c03~Bcnd2EEur0369103691eusmtrp1q;
        Fri,  8 Feb 2019 17:06:44 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-8f-5c5db7247dc5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 27.14.04284.427BD5C5; Fri,  8
        Feb 2019 17:06:44 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190208170643eusmtip145c18ba271794f6ea76c1b4a81759fd5~BcndhK69M1097810978eusmtip1G;
        Fri,  8 Feb 2019 17:06:43 +0000 (GMT)
Subject: Re: [PATCH] video: offb: annotate implicit fall throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mathieu Malaterre <malat@debian.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <efc378bc-a779-7fa3-209c-a331b1055ae6@samsung.com>
Date:   Fri, 8 Feb 2019 18:06:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <15854ad8-7bd5-ede7-6ce4-00122d6ba279@embeddedor.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduzneV2V7bExBvM/Wllc+fqezWLrHlWL
        E30fWC0u75rDZnF201sWB1aPX21zmT3WHVT1uN99nMnj8ya5AJYoLpuU1JzMstQifbsEroyX
        MyYyF7SyVTxp3c3ewPifpYuRg0NCwESiY6prFyMXh5DACkaJbW+72SGcL4wSB7bshXI+M0rc
        3PyetYuRE6zj/aFLYLaQwHJGiQsneCGK3jNKLHlxjgUkISzgKNE6eRkjiC0iECXRs+8/G4jN
        LJAgcXrRPbAaNgEriYntq8BqeAXsJKbu/Q5mswioSHSfnssMcp6oQIRE/xl1iBJBiZMzn4C1
        cgo4SVy72MYKMVJeYvvbOcwgN0gItLNL3P55iBHiUBeJWQu3MkHYwhKvjm9hh7BlJE5P7mGB
        aJjOKPHm11IoZz2jxJozx6A6rCUOH7/ICnIFs4CmxPpd+l2M7EBhR4m1ypCQ45O48VYQ4gQ+
        iUnbpjNDhHklOtqEIEaoSWxYtoENZmnXzpXMELaHxIFTL1gmMCrOQvLYLCTPzELYuoCReRWj
        eGppcW56arFxXmq5XnFibnFpXrpecn7uJkZgCjn97/jXHYz7/iQdYhTgYFTi4Y1oiY0RYk0s
        K67MPcQowcGsJMKbtgkoxJuSWFmVWpQfX1Sak1p8iFGag0VJnLea4UG0kEB6YklqdmpqQWoR
        TJaJg1OqgVF6fsGvSz23Hs4LlDwas+d+rOKko6oTfzuWM4iwXN6346enve5SnTWGXPIdeZls
        Hw4s31ceeEH12OKg6C23I9+pLPjz7vRfHilvFY486z/5exqX166vmv34uEfNr8lvTkXxT2pK
        0L1dOXW15dfbPF2WtbsXNCdu09yz5NUuv5MLNs99MXfz+ZBCJZbijERDLeai4kQAUC7FeB0D
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsVy+t/xu7oq22NjDP73sFlc+fqezWLrHlWL
        E30fWC0u75rDZnF201sWB1aPX21zmT3WHVT1uN99nMnj8ya5AJYoPZui/NKSVIWM/OISW6Vo
        QwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYyXMyYyF7SyVTxp3c3ewPifpYuR
        k0NCwETi/aFLrF2MXBxCAksZJb7s+MLWxcgBlJCROL6+DKJGWOLPtS42EFtI4C2jxNzXYLaw
        gKNE6+RljCC2iECURPvxU4wQcw4ySrS/u80EModZIEHi2bwUkBo2ASuJie2rwOp5Bewkpu79
        DmazCKhIdJ+eywxiiwpESNx62MECUSMocXLmEzCbU8BJ4trFNlYQm1lAXeLPvEvMELa8xPa3
        c5gnMArOQtIyC0nZLCRlCxiZVzGKpJYW56bnFhvqFSfmFpfmpesl5+duYgTGx7ZjPzfvYLy0
        MfgQowAHoxIPL0NTbIwQa2JZcWXuIUYJDmYlEd60TUAh3pTEyqrUovz4otKc1OJDjKZAT0xk
        lhJNzgfGbl5JvKGpobmFpaG5sbmxmYWSOO95g8ooIYH0xJLU7NTUgtQimD4mDk6pBsZ5u5Qe
        RUexR2rF7wpNV2NfayvzxvnZKdtndmrH6kWr4jWm3OeuTDoq9PEgZ7xa39W2DZ4OAglWN588
        ld+6WLyulqHVT8PA/Zhu8vrVt1MWfo869nnjR91XUff+KD105iln2hc160NrYUdZytNb1lvZ
        9Xg/Slv4i2TcETg+iV1nqyuH2+xrkUosxRmJhlrMRcWJAGKja8GlAgAA
X-CMS-MailID: 20190208170644eucas1p25b4f8b4f11a85890814bbf871aa5976d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190114215109epcas3p2eb2c3b3f91cc036b9604b88520410056
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190114215109epcas3p2eb2c3b3f91cc036b9604b88520410056
References: <20190114204044.20528-1-malat@debian.org>
        <CGME20190114215109epcas3p2eb2c3b3f91cc036b9604b88520410056@epcas3p2.samsung.com>
        <15854ad8-7bd5-ede7-6ce4-00122d6ba279@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/14/2019 10:50 PM, Gustavo A. R. Silva wrote:
> 
> 
> On 1/14/19 2:40 PM, Mathieu Malaterre wrote:
>> There is a plan to build the kernel with -Wimplicit-fallthrough and
>> these places in the code produced warnings (W=1). Fix them up.
>>
>> This commit remove the following warnings:
>>
>>    drivers/video/fbdev/offb.c:211:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>    drivers/video/fbdev/offb.c:142:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> 
> Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch queued for v5.1, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
