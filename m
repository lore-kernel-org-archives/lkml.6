Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5319FC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAD72082C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ju6Y8+u0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BAD72082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbeI1W7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:59:34 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55348 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeI1W7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:59:34 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180928163459euoutp01c5556f0f149e8da6bb5cb086086b715d~YnYyY6L2E2358423584euoutp01h
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 16:34:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180928163459euoutp01c5556f0f149e8da6bb5cb086086b715d~YnYyY6L2E2358423584euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538152499;
        bh=2KUGrxQYysnULRy7UJzubxrOd/9DZpwSn/2KdMc5YDw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ju6Y8+u0eaU5tyj5ETkc85/YxVeHdIhP9yKogmz5ib5rAGFPAOm1RYENF4NlQt9ci
         bTzxH/lSW75R1PzsuTCAXxab0oKvmmt7eHZUanFpxTAuf4LDFKpSXPhHwaemDrda0Z
         Tlt9WziH4Kv/YSXRd3xFBKraWgkyyKIgNlz0ocxM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180928163458eucas1p2308ee539686621070f17033e78143e49~YnYxPB-aX0470304703eucas1p2g;
        Fri, 28 Sep 2018 16:34:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 51.BB.04441.2385EAB5; Fri, 28
        Sep 2018 17:34:58 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180928163457eucas1p10a18e67b832104c32e6148dcb1a67c52~YnYwPaOho0754307543eucas1p1L;
        Fri, 28 Sep 2018 16:34:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180928163457eusmtrp23d67b7752ef6f396ff3d77e85984939c~YnYv_yBFu1354613546eusmtrp2g;
        Fri, 28 Sep 2018 16:34:57 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-93-5bae58324400
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1D.CB.04128.1385EAB5; Fri, 28
        Sep 2018 17:34:57 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180928163457eusmtip2af55f15c4f991ce671d24e56f74e9018~YnYvstzyc0763707637eusmtip2V;
        Fri, 28 Sep 2018 16:34:57 +0000 (GMT)
Subject: Re: [PATCH] ARM: SAMSUNG: limit SAMSUNG_PM_DEBUG config option to
 non-Exynos platforms
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kgene@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Fri, 28 Sep 2018 18:34:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcfvpiO8NpRzDwNgEyJf21+jFt8r9E=OOs_6f7wSjC+Zw@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djP87pGEeuiDeZ/Fbfof/ya2eL8+Q3s
        FpseX2O1uLxrDpvFjPP7mCwOTd3L6MDmcfnaRWaPTas62Tw2L6n3+LxJLoAlissmJTUnsyy1
        SN8ugStj2+E2toJt7BX7b91ka2DsYeti5OSQEDCRuPbrIXMXIxeHkMAKRonmozcYIZwvjBLr
        25qgMp8ZJZ4fu8wC07LqdRc7RGI5o8Thu5+gnPeMEt+/TGcGqRIWSJRonvuBHcQWEdCUuP73
        OytIEbPAHkaJG28OgBWxCVhJTGxfxQhiswioSjTNugdUxMEhKhAh0X9GHSTMKyAocXLmE7DN
        nAKBEj933gJrZRaQl9j+dg7YeRIC09kldnVtZoNoKJNYvOIKI8SpLhLrV32DsoUlXh3fwg5h
        y0j83zmfCaqZUeLNr6UsEM56Rok1Z44xQVRZSxw+fhHsImagF9bv0ocIO0q0bd7CDBKWEOCT
        uPFWEOIgPolJ26ZDhXklOtqEIKrVJDYs28AGs7Zr50pmCNtDYsKO46wTGBVnIXlzFpLXZiHs
        XcDIvIpRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMwsZz+d/zTDsavl5IOMQpwMCrx8L6w
        WhctxJpYVlyZe4hRgoNZSYR3X/XaaCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8fFpp0UIC6Ykl
        qdmpqQWpRTBZJg5OqQbGtOQ4yYWxUx4uDdj3+Qiz6ZevrlpBuVzft3x2nGGw+IeugNwTj52Z
        a+5OVbDR+ZlSMufKTvMCWf3Yqp32d2v2PbqyVWv2s6l32O5dVIvubr18Jl3frvi9pu4eX/3H
        Rn55Jr7yB2qqGJoFl6+KqNhopcW/lWGKSP7G1nf8h7Z5WixwKdofrjhJiaU4I9FQi7moOBEA
        W+wOuCgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7qGEeuiDfbdFbbof/ya2eL8+Q3s
        FpseX2O1uLxrDpvFjPP7mCwOTd3L6MDmcfnaRWaPTas62Tw2L6n3+LxJLoAlSs+mKL+0JFUh
        I7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j2+E2toJt7BX7b91k
        a2DsYeti5OSQEDCRWPW6i72LkYtDSGApo8TUVzdYuhg5gBIyEsfXl0HUCEv8udbFBlHzllGi
        79RFZpCEsECiRPPcD+wgtoiApsT1v99ZIYomMkls2/2LEcRhFtjHKHHizSoWkCo2ASuJie2r
        GEFsXgE7iaWv9oCdwSKgKtE06x4riC0qECFx62EHC0SNoMTJmU/AbE6BQImfO2+BbWYWUJf4
        M+8SlC0vsf3tHOYJjIKzkLTMQlI2C0nZAkbmVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIER
        s+3Yzy07GLveBR9iFOBgVOLhdbBdFy3EmlhWXJl7iFGCg1lJhHdf9dpoId6UxMqq1KL8+KLS
        nNTiQ4ymQE9MZJYSTc4HRnNeSbyhqaG5haWhubG5sZmFkjjveYPKKCGB9MSS1OzU1ILUIpg+
        Jg5OqQbGsFvibdWezzcGnjLur9v9vmNd0rvbXHsK+5i8773/XFXw/k2zRq3932z/5FMF7Kb/
        4yf7y+zfVL3ikkVsbNwpew1d87netxreectZPJs+6WN8hxbv2dbE+SocRasnTWJzfTW35rz8
        rLtPU+/PFdTe/HDh37DcK9EG/U1HhVcHHt39Yc6fBQUPlFiKMxINtZiLihMB6k1PEK4CAAA=
Message-Id: <20180928163457eucas1p10a18e67b832104c32e6148dcb1a67c52~YnYwPaOho0754307543eucas1p1L@eucas1p1.samsung.com>
X-CMS-MailID: 20180928163457eucas1p10a18e67b832104c32e6148dcb1a67c52
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180928133713eucas1p16a15a68b61de9aa3310737f7fd77d20d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180928133713eucas1p16a15a68b61de9aa3310737f7fd77d20d
References: <CGME20180928133713eucas1p16a15a68b61de9aa3310737f7fd77d20d@eucas1p1.samsung.com>
        <20180928133713eucas1p16a15a68b61de9aa3310737f7fd77d20d~Yk9kqY_Ga2124121241eucas1p1b@eucas1p1.samsung.com>
        <CAJKOXPcfvpiO8NpRzDwNgEyJf21+jFt8r9E=OOs_6f7wSjC+Zw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/28/2018 03:54 PM, Krzysztof Kozlowski wrote:
> On Fri, 28 Sep 2018 at 15:37, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
>>
>> "Samsung PM Suspend debug" feature (controlled by SAMSUNG_PM_DEBUG
>> config option) is not working properly (debug messages are not
>> displayed after resume) on Exynos platforms because GPIOs restore
>> code is not implemented.
> 
> AFAIR, it worked properly for the suspend part showing more logs.
> Unless it changed, the feature looks still useful.

Yes, it shows few additional messages from mach/plat specific suspend
code but it breaks the assumption that features (even debug ones)
work correctly and make you invest time in debugging known broken
code.

In case it is needed/useful (which should be rather rare situation)
one can always easily revert the commit locally.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
