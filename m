Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F03EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45A920855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H6f91ByW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfBHRCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:02:22 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48731 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfBHRCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:02:21 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190208170220euoutp0258768ae433b0d86d23143cc64bded04c~Bcjn0QBnP0990309903euoutp02X
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 17:02:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190208170220euoutp0258768ae433b0d86d23143cc64bded04c~Bcjn0QBnP0990309903euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549645340;
        bh=v71pZnVPDWrGKDu/TlRu3LlfZ4qgxlQhPZCeS1BthZo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=H6f91ByWaqVFx1xAwiSg4xd31Tx7wIuxSnhYjzqdZBiEl5fHzgv+j+oWH0AOmcIQO
         NJWrbZnZrP4oYXEJ2cevfVj9i2auDUc/5Aqwy1LZWd21TweLupJNe8E2oB0ZQAo8TY
         XepWThKsgAbzIhLnpEOuU5tlat7j8Rn5eEe6k+nM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190208170219eucas1p28d0c8bad0a4bdb0b10725bc2b972ad40~Bcjncj0f32524125241eucas1p24;
        Fri,  8 Feb 2019 17:02:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 82.EB.04441.B16BD5C5; Fri,  8
        Feb 2019 17:02:19 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190208170218eucas1p228ec2bb11ff97f28ec70c301e50f6b13~Bcjm0J3Yj1622516225eucas1p2d;
        Fri,  8 Feb 2019 17:02:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190208170218eusmtrp1256086c9b9fee22f91207fbffc874751~Bcjmk-2Bh0221702217eusmtrp1W;
        Fri,  8 Feb 2019 17:02:18 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-56-5c5db61b5a00
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1B.D3.04284.A16BD5C5; Fri,  8
        Feb 2019 17:02:18 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190208170218eusmtip2c356bba6a8e60f085454a26feff75cdd~BcjmP8SYT0940909409eusmtip21;
        Fri,  8 Feb 2019 17:02:18 +0000 (GMT)
Subject: Re: [PATCH] fbcon: use kvmalloc() for scrollback buffer
To:     Konstantin Khorenko <khorenko@virtuozzo.com>
Cc:     "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <ed53d034-9592-76e2-3122-dc2480890527@samsung.com>
Date:   Fri, 8 Feb 2019 18:02:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <4eba60c6-4eb8-5a82-f394-307f835f41e1@virtuozzo.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduznOV3pbbExBk2nxC2ufH3PZvF450tW
        ixN9H1gtLu+aw+bA4nG/+ziTx+dNch6v9x9iDGCO4rJJSc3JLEst0rdL4MrYtXsRS8FSzorj
        W1YzNTCuZ+9i5OSQEDCRODV1D1sXIxeHkMAKRomNy/awQDhfGCXmf7jGBlIlJPCZUWLTCw6Y
        jkWrOpkhipYzSvz/fBGq/T2jRP+DC4wgVcICDhL/by4Es0UEDCQe7O9jBSliFjjOKLFk61lW
        kASbgJXExPZVYEW8AnYSn5f2MoPYLAIqEpN6QFZzcIgKREj0n1GHKBGUODnzCQuIzSngKHFn
        VxuYzSwgL7H97RywiyQE/rNJrDnTA/Wci8TCnzNZIGxhiVfHt0DFZSROT+5hgWiYzijx5tdS
        KGc9I1D3MSaIKmuJw8cvsoJcwSygKbF+lz5E2FHi9oxdYGEJAT6JG28FIY7gk5i0bTozRJhX
        oqNNCKJaTWLDsg1sMGu7dq6EKvGQ2NcbMIFRcRaSz2Yh+WYWwtoFjMyrGMVTS4tz01OLDfNS
        y/WKE3OLS/PS9ZLzczcxAhPH6X/HP+1g/Hop6RCjAAejEg9vREtsjBBrYllxZe4hRgkOZiUR
        3rRNQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK81QwPooUE0hNLUrNTUwtSi2CyTBycUg2Meon8
        B7Mm5k3l+vhi1ibNvvb6AJ0IdoFtmeeWrT8Ua+gX0bWid6Mbj/CrgxLnJxsJv2ULs7tuXm22
        Runq7UXXs6QljFb4+vBfieB60bFvQ9yC5MrkibHqzROdi5ZxfS7zN14kU1e577v72t/Vony5
        fnH3GEPuHX4tefOPt1h/nY07q/7XmmglluKMREMt5qLiRAACXPL2GAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42I5/e/4PV2pbbExBhd/K1tc+fqezeLxzpes
        Fif6PrBaXN41h82BxeN+93Emj8+b5Dxe7z/EGMAcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJexa/ciloKlnBXHt6xmamBcz97FyMkhIWAisWhV
        J3MXIxeHkMBSRonmq7eBHA6ghIzE8fVlEDXCEn+udbFB1LxllJjQdZwJJCEs4CDx/+ZCRhBb
        RMBA4sH+PlaIol+MEidfzWQHcZgFjjNK/PrwC6yKTcBKYmL7KjCbV8BO4vPSXmYQm0VARWJS
        zzU2EFtUIELi1sMOFogaQYmTM5+A2ZwCjhJ3drWB2cwC6hJ/5l1ihrDlJba/ncM8gVFwFpKW
        WUjKZiEpW8DIvIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwKrYd+7l5B+OljcGHGAU4GJV4
        eBmaYmOEWBPLiitzDzFKcDArifCmbQIK8aYkVlalFuXHF5XmpBYfYjQFemIis5Rocj4wYvNK
        4g1NDc0tLA3Njc2NzSyUxHnPG1RGCQmkJ5akZqemFqQWwfQxcXBKNTBOU0r48Czi/28N0ZnG
        OjwNFvnXPtf92puqPu8ts+OOpm2fehgfCH3S77PLObsv0i0hh2HbJuPq757mQve3aKZP5V3R
        lm+in153ec4Nnoy8jV6BS52f7TytErVt1SfxMxK7Vu1de+/6rhciQe/fRL5d8aD7Xoe+a5yY
        m4F92TRxbdvbBgwRLYlKLMUZiYZazEXFiQBu583poAIAAA==
X-CMS-MailID: 20190208170218eucas1p228ec2bb11ff97f28ec70c301e50f6b13
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181126100342epcas3p12a1e6505ff4b73375ac3fcf5d0355d3f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181126100342epcas3p12a1e6505ff4b73375ac3fcf5d0355d3f
References: <CGME20181126100342epcas3p12a1e6505ff4b73375ac3fcf5d0355d3f@epcas3p1.samsung.com>
        <20181126100253.3299-1-khorenko@virtuozzo.com>
        <a7f6bf30-5094-b669-126d-e4751c17dcbb@samsung.com>
        <4eba60c6-4eb8-5a82-f394-307f835f41e1@virtuozzo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/21/2018 11:58 AM, Konstantin Khorenko wrote:
> Hi Bartlomiej,
> 
> On 12/20/2018 07:21 PM, Bartlomiej Zolnierkiewicz wrote:
>> On 11/26/2018 11:02 AM, Konstantin Khorenko wrote:
>>> Scrollback frame buffer is rather big - 32K,
>>> so it requires 3rd order page, so let's use kvmalloc() instead of
>>> ordinary kmalloc() for it.
>>
>> Is it actually safe to use non-contiguous memory for softback_buf?
> 
> Well, that's why we need a review. :)

:)

> i've asked myself same question while fixing this,
> i've dig sources a bit and did not find places when softback_buf is provided for DMA,
> all other places seems to work with virtual addresses, so there should be no problem.
> 
> Even more i saw a function which mentions that softback might be non-contigious:
> 
> /* As we might be inside of softback, we may work with non-contiguous buffer,
>     that's why we have to use a separate routine. */
> static void fbcon_invert_region(struct vc_data *vc, u16 * p, int cnt)
> 
> So i think it's safe to use kvmalloc() here.

Patch queued for v5.1, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
