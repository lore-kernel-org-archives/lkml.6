Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C5EC4151A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64C020855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HUobkWCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfBHSFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:05:46 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57617 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfBHSFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:05:45 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190208180543euoutp025d2f59d93f620b064bd9fc6e91f97615~Bda_J-2S50582005820euoutp02E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 18:05:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190208180543euoutp025d2f59d93f620b064bd9fc6e91f97615~Bda_J-2S50582005820euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549649143;
        bh=h1ptqF5MNebAHhTjGGQXK8Q/3plYqSXk69ehRgdUFng=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HUobkWCTJZ9eS/Uqfb2OXpmuMmBJnDRBzMz1kRed9d+82/ttiRo7yY+g4fyVcAVfY
         mghOm7OcHcv6TolCNdToLew49omKB5HPVEGywXTHQQFbcoII+PQbmQg16dSX/xgqTL
         0lNQaS661O+d8JqcELU2jcBaU37p3QtagolxXn90=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190208180542eucas1p2a7727af046050355db33244a0e960fe8~Bda9cxNX82959029590eucas1p2K;
        Fri,  8 Feb 2019 18:05:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 84.E9.04806.6F4CD5C5; Fri,  8
        Feb 2019 18:05:42 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190208180541eucas1p1b0b93ed3146b36ad6f2902918af2d6a3~Bda8i5D0-0883108831eucas1p1v;
        Fri,  8 Feb 2019 18:05:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190208180541eusmtrp269ee6e5bbf9c8ce494e1095a6405db37~Bda8T29BJ1917519175eusmtrp2a;
        Fri,  8 Feb 2019 18:05:41 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-a2-5c5dc4f639f5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D9.66.04284.5F4CD5C5; Fri,  8
        Feb 2019 18:05:41 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190208180541eusmtip24168144ec5245b2a2b81d621785ecf67~Bda7_87Oo2725527255eusmtip2U;
        Fri,  8 Feb 2019 18:05:41 +0000 (GMT)
Subject: Re: [PATCH -next] video: fbdev: Fix potential NULL pointer
 dereference
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     keescook@chromium.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <67c9cb52-277f-66d9-21bc-2537c795ae51@samsung.com>
Date:   Fri, 8 Feb 2019 19:05:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190130101625.20048-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djPc7rfjsTGGHxdI2tx5et7Nosz3bkW
        J/o+sFpc3jWHzeL/nh3sFne+PmdxYPOY3XCRxaPlyFtWj02rOtk87ncfZ/L4vEkugDWKyyYl
        NSezLLVI3y6BK2P97F0sBReYKuYuX8nUwDiVqYuRk0NCwERi1/RuIJuLQ0hgBaPEzitbGCGc
        L4wSKzY3skM4nxklPk9fANdyZ/51qJbljBLHWxawQTjvGSWeXNjADlIlLBAo8ePfP0YQW0RA
        TaLl1BZmkCJmgQ5Giee9K8ASbAJWEhPbV4HZvAJ2EvO/72MFsVkEVCTOTngC1MDBISoQIdF/
        Rh2iRFDi5MwnLCA2p4C1xNrO22AXMQsYSBxZNIcVwpaX2P52DtguCYF57BJfn+9mhzjbReJH
        xx5WCFtY4tXxLVBxGYn/O+czQTRMZ5R482spC4SznlFizZljUE9bSxw+fhGq21Fi3boPjCDX
        SQjwSdx4KwixmU9i0rbpzBBhXomONiGIajWJDcs2sMHs6tq5khnC9pDYf24d2wRGxVlIfpuF
        5J9ZSP5ZwMi8ilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzDNnP53/OsOxn1/kg4xCnAw
        KvHwRrTExgixJpYVV+YeYpTgYFYS4bU9CBTiTUmsrEotyo8vKs1JLT7EKM3BoiTOW83wIFpI
        ID2xJDU7NbUgtQgmy8TBKdXA2Cx0ednaX/OZn6wI1lg1K3pb/9ZDKQoCPcX2J4tVns37NcXj
        FtfEiHuPXXi95hc26yzVW3d1z/wzP0zkRS1yypz8GM/fUe3WlrB3ctzlUbRPo/FFB6NYVP3l
        OS8Xqsu66qRdvfKuWno1296gL80zfJ4HqBm+1X17MPPXmuPSEUsv83JKnZbrVmIpzkg01GIu
        Kk4EAOj9ORgvAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xe7pfj8TGGEw6qWxx5et7Nosz3bkW
        J/o+sFpc3jWHzeL/nh3sFne+PmdxYPOY3XCRxaPlyFtWj02rOtk87ncfZ/L4vEkugDVKz6Yo
        v7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2P97F0sBReY
        KuYuX8nUwDiVqYuRk0NCwETizvzrQDYXh5DAUkaJ1vO3WLsYOYASMhLH15dB1AhL/LnWxQZR
        85ZRYtn9HYwgCWGBQIkf//6B2SICahItp7YwQxT1MUqcbHzEDuIwC3QwSkxv+sYCUsUmYCUx
        sX0VWAevgJ3E/O/7WEFsFgEVibMTnjCD2KICERK3HnawQNQISpyc+QTM5hSwlljbeRvsbGYB
        PYkd13+xQtjyEtvfzmGewCg4C0nLLCRls5CULWBkXsUoklpanJueW2yoV5yYW1yal66XnJ+7
        iREYO9uO/dy8g/HSxuBDjAIcjEo8vAxNsTFCrIllxZW5hxglOJiVRHhtDwKFeFMSK6tSi/Lj
        i0pzUosPMZoCPTGRWUo0OR8Y13kl8YamhuYWlobmxubGZhZK4rznDSqjhATSE0tSs1NTC1KL
        YPqYODilGhhDOQrZt8iua9N+6fz494bZ2y+WrLy1bKWO6YLCWzvnztA2qdBI+K/AtVzCrWgx
        8/qJkbpCDN3xS930Z3F6aJ10WCH/6oZj8Ox/H26v2vxyh8y9FV2bOTM33tj9/EKXtWq6rser
        /K872Q/Z/NvEEyz9VmvHndRa6aNnryopNLHebDHN0N66ZqGbEktxRqKhFnNRcSIAggLtarMC
        AAA=
X-CMS-MailID: 20190208180541eucas1p1b0b93ed3146b36ad6f2902918af2d6a3
X-Msg-Generator: CA
X-RootMTR: 20190130101714epcas4p18e107a05ba592985d2e63d69a445029a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190130101714epcas4p18e107a05ba592985d2e63d69a445029a
References: <CGME20190130101714epcas4p18e107a05ba592985d2e63d69a445029a@epcas4p1.samsung.com>
        <20190130101625.20048-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/30/2019 11:16 AM, YueHaibing wrote:
> There is a potential NULL pointer dereference in case
> fb_create_modedb() fails and returns NULL.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch queued for v5.1, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
