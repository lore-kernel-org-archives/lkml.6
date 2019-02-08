Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2EBC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD4E2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UKcD1P4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfBHMgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:36:46 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56790 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfBHMgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:36:45 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190208123644euoutp02d3e57b7085d09720419de16c37df57ba~BY7uVPeBH0194801948euoutp02S
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 12:36:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190208123644euoutp02d3e57b7085d09720419de16c37df57ba~BY7uVPeBH0194801948euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549629404;
        bh=6KZFWnRyX18XnxLYJNRuBcadu4N+tR9bz7UgH2K5uvs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=UKcD1P4GhKXGy03AsU7hSVWG9pPimicdpdgqKmDaJUaZDU2uZnBVW4JkLQ8/SrLw+
         9fTgDmWI1i0FpOp6ObvyvaDEq/CZvIfFDwb5Mq1OKzcAc3kgiEwQ/ONvYo6T07Jlg3
         LZOQ1NBiutee34sfLPxIuy5srmvkmVJfx0H9VTjE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190208123643eucas1p17617816d79aaa0940a11d9382c459950~BY7triYJx2954129541eucas1p1I;
        Fri,  8 Feb 2019 12:36:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6D.9D.04441.BD77D5C5; Fri,  8
        Feb 2019 12:36:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190208123641eucas1p1410682d411a4b2aa18de07919d12f437~BY7sRgVGJ0788807888eucas1p1n;
        Fri,  8 Feb 2019 12:36:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190208123641eusmtrp24cc933a0e01ff0a386c0c6c8c9424868~BY7sDQWbK2768227682eusmtrp2a;
        Fri,  8 Feb 2019 12:36:41 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-dc-5c5d77db482d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 16.17.04284.9D77D5C5; Fri,  8
        Feb 2019 12:36:41 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190208123641eusmtip159fd90141c3a22e0fad498499a839399~BY7rjykBV0272702727eusmtip1U;
        Fri,  8 Feb 2019 12:36:41 +0000 (GMT)
Subject: Re: [PATCH] usb: dwc3: Enable GBit Ethernet on Odroid XU4
To:     Roger Quadros <rogerq@ti.com>,
        Jochen Sprickerhof <jochen@sprickerhof.de>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <bdbce410-7f48-17a5-b58b-3ebd65ca6913@samsung.com>
Date:   Fri, 8 Feb 2019 13:36:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <5C5AB41C.9080402@ti.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djPc7q3y2NjDKYtZLc41vaE3aJ58Xo2
        i6V/7zFaXHjaw2ZxedccNotFy1qZLXoeaTmwe2xa1cnmsX/uGnaPDVv+sXgcv7GdyePzJrkA
        1igum5TUnMyy1CJ9uwSujEfPd7AWfOSoODdpFlMD4yT2LkZODgkBE4nHvdOZQWwhgRWMErPv
        RHYxcgHZXxgl9n9fxQjhfGaUeHxnK1zH9YlL2CE6ljNKbJ/jBlH0nlHi+avpYAlhASeJw08W
        s3QxcnCICPhLXN5YDBJmFtjJKPHvTgWIzSZgKNH1tosNxOYVsJPYPfcDC4jNIqAisWfXGkYQ
        W1QgRmLKuSPsEDWCEidnPgGr4RRQk3j+cT4jxEx5ie1v5zBD2OISt57MZwK5R0JgE7vEovZ/
        zBBHu0j873rJCmELS7w6vgXqGRmJ/zthGpoZJdpnzGKHcHoYJbbO2cEGUWUtcfj4RVaQb5gF
        NCXW79KHCDtKTLh6lhEkLCHAJ3HjrSDEEXwSk7aBghQkzCvR0SYEUa0mMev4Ori1By9cYp7A
        qDQLyWuzkLwzC8k7sxD2LmBkWcUonlpanJueWmyYl1quV5yYW1yal66XnJ+7iRGYfk7/O/5p
        B+PXS0mHGAU4GJV4eC9ox8QIsSaWFVfmHmKU4GBWEuFNKo2NEeJNSaysSi3Kjy8qzUktPsQo
        zcGiJM5bzfAgWkggPbEkNTs1tSC1CCbLxMEp1cCYfnnJ5lU/Vp91d5j3xGS1XcoOtn9T3Hc3
        Gy1Nsr8g6c0RrfJ031KLp/sbTZa0HgjIc7jud/aD+FwTR9UbLWXuMr8WhOQqF+hvqzT5a26Y
        uq67I1RjYZjpWqHOz8/1/ad2XYpKPnX07hOWhd2uDzaHvjj4qX+m++XQ0G23zvxw/cD+9q5I
        9txIJZbijERDLeai4kQA32uT9zsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xu7o3y2NjDK49VbQ41vaE3aJ58Xo2
        i6V/7zFaXHjaw2ZxedccNotFy1qZLXoeaTmwe2xa1cnmsX/uGnaPDVv+sXgcv7GdyePzJrkA
        1ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jEfP
        d7AWfOSoODdpFlMD4yT2LkZODgkBE4nrE5cA2VwcQgJLGSWuTjsPlZCRODmtgRXCFpb4c62L
        DcQWEnjLKNG8wRvEFhZwkjj8ZDELiC0i4Ctx6eV+ZpBBzAI7GSWeTdzFBDH1AqPE0d/PGUGq
        2AQMJbreQkziFbCT2D33A1g3i4CKxJ5da4BqODhEBWIkrp5jhCgRlDg58wlYCaeAmsTzj/PB
        4swC6hJ/5l1ihrDlJba/nQNli0vcejKfaQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnF
        hnrFibnFpXnpesn5uZsYgTG37djPzTsYL20MPsQowMGoxMOroRcTI8SaWFZcmXuIUYKDWUmE
        N6k0NkaINyWxsiq1KD++qDQntfgQoynQbxOZpUST84HpIK8k3tDU0NzC0tDc2NzYzEJJnPe8
        QWWUkEB6YklqdmpqQWoRTB8TB6dUA6NraIT/k2C11Job2jJz0yuZJwj7Hmfym58uedGM4WTN
        tk9P9H7pMl9+yZGh++dZev1D26QOt9SIm0cXmu0uXKN5OpUtUlXVg9EyfYXd05T/jHsX3lj0
        0/1zmA9fd8zF+z/KVq5ye7+7P3L1X0ONy1+KRflfnbHRbZl6vW96aaCcxg65hu/rviqxFGck
        GmoxFxUnAgDpdjVUzwIAAA==
X-CMS-MailID: 20190208123641eucas1p1410682d411a4b2aa18de07919d12f437
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190206101740epcas2p131674b4b9733047711855ffb2e7a99a7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190206101740epcas2p131674b4b9733047711855ffb2e7a99a7
References: <20190121140204.GA2360@vis> <5C5A9DCB.8040507@ti.com>
        <20190206093830.GS26157@vis>
        <CGME20190206101740epcas2p131674b4b9733047711855ffb2e7a99a7@epcas2p1.samsung.com>
        <5C5AB41C.9080402@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

On 2019-02-06 11:17, Roger Quadros wrote:
> +Marek
>
> As Vivek's and Andrzej's Samsung IDs bounced back.
>
> On 06/02/19 11:38, Jochen Sprickerhof wrote:
>> * Roger Quadros <rogerq@ti.com> [2019-02-06 10:41]:
>>> Hi,
>>>
>>> On 21/01/19 16:02, Jochen Sprickerhof wrote:
>> [..]
>>>> I'm not sure why this it only works with the driver compiled into the
>>>> kernel nor why it needs a hard reset or why it was the line was dropped
>>>> when the patch was accepted. Would be great to get some feedback of the
>>>> authors.
>>> When XHCI driver is compiled into the kernel are the relevant PHY drivers
>>> compiled in as well?
>> Only CONFIG_USB_PHY=y (I took the config from the linux-image-4.19.0-1-armmp_4.19.13-1_armhf.deb Debian package as a basis where this is the default).

I confirm that on Odroid XU4 USB 3.0 works only when all related drivers
(dwc3, xhci and exynos5 drd phy) are compiled into the kernel. If they
are compiled as modules, USB 3.0 calibration doesn't work. The mentioned
patch doesn't fix anything.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

