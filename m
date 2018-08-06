Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76061C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 05:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C37219D2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 05:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K4aUYzvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C37219D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeHFHhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 03:37:17 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50740 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbeHFHhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 03:37:16 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180806052951euoutp027f9863766cb148f7ec33c2aff5a603a3~INH6tNakQ2410224102euoutp02g
        for <linux-kernel@vger.kernel.org>; Mon,  6 Aug 2018 05:29:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180806052951euoutp027f9863766cb148f7ec33c2aff5a603a3~INH6tNakQ2410224102euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533533391;
        bh=ckZX4RL09L1dAbEdzgulligr2UYwyjmQ65+FpjhEoRU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=K4aUYzvlkbpkne6F6A8tvbSZVfyD5Y6nhM00SI00GSPQotIwSZqK/8ZpwkaN5xeUl
         UjhYLdnAnaXs+BhmsAwwRkBOMqXbjvYsSZOT+EDsIXT5/7tuDAoWaSkBxnNLKL4Pi4
         g5VV8NmQB96Z/hMmgzKphVles4WeX/dsLAJtEAes=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180806052951eucas1p26b5f9e9e4f6f7c66d905ad3cd0add54d~INH6CxCQx2112521125eucas1p2x;
        Mon,  6 Aug 2018 05:29:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D7.E5.04806.ECCD76B5; Mon,  6
        Aug 2018 06:29:50 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180806052949eucas1p2483800c02730febd03d4a661a25fa405~INH40XvCx2719627196eucas1p2X;
        Mon,  6 Aug 2018 05:29:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180806052949eusmtrp2c9811cf380e84c222300d3e043875047~INH4kGg6s2043220432eusmtrp2T;
        Mon,  6 Aug 2018 05:29:49 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-c0-5b67dcce22b7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D9.42.04128.DCCD76B5; Mon,  6
        Aug 2018 06:29:49 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180806052949eusmtip1e038b2b1d19c8fce591501aa811423b3~INH4NQQBq2031320313eusmtip1V;
        Mon,  6 Aug 2018 05:29:49 +0000 (GMT)
Subject: Re: [PATCH] Input: cros_ec_keyb: Remove check before calling
 pm_wakeup_event.
To:     Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Ravi Chandra Sadineni <ravisadineni@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Todd Broch <tbroch@google.com>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Mon, 6 Aug 2018 07:29:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAEZbON4O0X8Fo6eAbmPOSiB1_Tw7x+Ox3ROoGfZQn72uQGQLkg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djPc7rn7qRHG2zerGtxeNELRov5LzvZ
        LW5++sZqcXnXHDaLGef3MVmsa/nGaHH+7W9Wi0XfH7I6cHjMbrjI4rFz1l12jwWbSj0+b5IL
        YInisklJzcksSy3St0vgyriysoO14BxvxdyHj9gaGI9wdTFyckgImEhM+HCfrYuRi0NIYAWj
        xPTzl9lAEkICXxglXs4QgUh8ZpS4t20rG0zH9OOboDqWM0o8utfOAuG8Z5Q41HgdrEpYIELi
        fc8K9i5GDg4RgRSJC4fNQGqYBW4xSsyedwOshk3AUKLrbReYzSKgIvHt6T1mkHpRgRiJ37us
        QcK8AoISJ2c+YQGxOQUCJU782MMOYjMLyEs0b53NDGGLS9x6Mp8JZL6EwDp2iVe/9rBBNJdJ
        PHlzkQniaheJv8s7WCBsYYlXx7ewQ9gyEv93wjQ3M0q0z5jFDuH0MEpsnbMD6mdricPHL7KC
        XMcsoCmxfpc+iCkh4Cjxd5IEhMknceOtIMQ9fBKTtk1nhgjzSnS0CUHMUJOYdXwd3NaDFy4x
        T2BUmoXky1lIPpuF5LNZCGsXMLKsYhRPLS3OTU8tNs5LLdcrTswtLs1L10vOz93ECEw/p/8d
        /7qDcd+fpEOMAhyMSjy8K9LTo4VYE8uKK3MPMUpwMCuJ8K6YDRTiTUmsrEotyo8vKs1JLT7E
        KM3BoiTOy6eVFi0kkJ5YkpqdmlqQWgSTZeLglGpgXJ4+Xae1KXtmgEbAQ8dZX2ZJt0vkLRet
        WqJTc/fnimleq96siZjxSNPrkDbfjot7G72UtoaePlkVF9q67YfyBIOrITNf/bD5e69Adqrp
        52kbzALYXrlOYzPhXCMezdNkrmzieT0ma3XO4zMMUjmR7Kse/jXydzVJrE5+0uZ4WOeJJ9+K
        qOZHSizFGYmGWsxFxYkAyDevyTsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xu7pn76RHGyxsl7E4vOgFo8X8l53s
        Fjc/fWO1uLxrDpvFjPP7mCzWtXxjtDj/9jerxaLvD1kdODxmN1xk8dg56y67x4JNpR6fN8kF
        sETp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZVxZ
        2cFacI63Yu7DR2wNjEe4uhg5OSQETCSmH9/E1sXIxSEksJRRouX+MlaIhIzEyWkNULawxJ9r
        XVBFbxkl3r/vZAZJCAtESLzvWcEOYosIpEhs3HeaCaSIWeAWo8SiJXOYITquMEtMfbcDbBSb
        gKFE11uQUZwcvAJ2El/WvQGzWQRUJL49vQc2VVQgRuLo5BaoGkGJkzOfsIDYnAKBEid+7AHb
        xixgJjFv80NmCFteonnrbChbXOLWk/lMExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy02
        0itOzC0uzUvXS87P3cQIjLttx35u2cHY9S74EKMAB6MSD++K9PRoIdbEsuLK3EOMEhzMSiK8
        K2YDhXhTEiurUovy44tKc1KLDzGaAj03kVlKNDkfmBLySuINTQ3NLSwNzY3Njc0slMR5zxtU
        RgkJpCeWpGanphakFsH0MXFwSjUwLiny+yDKpc+wTe5O7twdeu9/Kp06/Ib/m8TptY7LVlTL
        b9rDW1q44/He8wXszj+PGNu1pC/3klpdPmuTpG3RWnalkHrNgw07U5Pi/U7fzOq7w3z/qtlN
        /d3i80wV/s7NmHLS0G/x/t4Nzq3XJ6cdfrX/2Nk3SZ82lbz+mCXavMekJvDnNP1VN5VYijMS
        DbWYi4oTAaQwqhHRAgAA
Message-Id: <20180806052949eucas1p2483800c02730febd03d4a661a25fa405~INH40XvCx2719627196eucas1p2X@eucas1p2.samsung.com>
X-CMS-MailID: 20180806052949eucas1p2483800c02730febd03d4a661a25fa405
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180803072628eucas1p26abe0cb121b974401759502f8807bb96
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180803072628eucas1p26abe0cb121b974401759502f8807bb96
References: <CGME20180803072628eucas1p26abe0cb121b974401759502f8807bb96@eucas1p2.samsung.com>
        <20180605224458.62692-1-ravisadineni@chromium.org>
        <20180803072628eucas1p26abe0cb121b974401759502f8807bb96~HTx4BGQjl1119311193eucas1p2U@eucas1p2.samsung.com>
        <CAEZbON7qLheHFuU6zwArCz=CG03JvnFjcehBGjE4RqROYrMLhQ@mail.gmail.com>
        <CAKdAkRQG08d_duPiKFi_=xUNO93c0Rcw9kpaYFFJahjJM-NdGw@mail.gmail.com>
        <CAEZbON4O0X8Fo6eAbmPOSiB1_Tw7x+Ox3ROoGfZQn72uQGQLkg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

On 2018-08-03 18:53, Ravi Chandra Sadineni wrote:
> Understood. I am trying to reproduce this issue locally. Wanted to 
> know the version of the kernel so I can give a try. Marek, can you 
> please confirm the kernel version.
>

Yes, sorry for the missing context, I was in hurry writing the report and
I wanted to send it before leaving the office. I'm testing mainline on Snow
with exynos_defconfig.

Suspend/resume is partially broken already with mainline, but if you disable
CPUfreq support, it works fine on Linux v4.17.

I've posted CPUfreq related fixes here if you are interested:
https://patchwork.kernel.org/patch/10554607/
https://patchwork.kernel.org/patch/10554603/

The issue with cros_ec_keyb patch appears first on Linux v4.18-rc1, which is
the first release with that patch. Linux -next from 20180803, which has 
a few
more patches for cros_ec_keyb suffers from the same issue.


>
> On Fri, Aug 3, 2018 at 9:08 AM Dmitry Torokhov 
> <dmitry.torokhov@gmail.com <mailto:dmitry.torokhov@gmail.com>> wrote:
>
>     On Fri, Aug 3, 2018 at 8:51 AM Ravi Chandra Sadineni
>     <ravisadineni@chromium.org <mailto:ravisadineni@chromium.org>> wrote:
>     >
>     > Hi Marek,
>     >
>     > Can you please give me little more context ? Snow is still on
>     3.8.11. This patch is not backported to 3.8.11. Are you trying to
>     flash a different kernel  on snow?
>     >
>
>     Ravi, from upstream perspective what kernel Google uses when shipping
>     Snow is completely immaterial. Mainline is supposed to work equally
>     well on all devices.
>
>     Thanks.
>
>     -- 
>     Dmitry
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

