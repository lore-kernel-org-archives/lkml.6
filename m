Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D24DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022772152F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JPO4idKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022772152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbeIZXGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:06:52 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34547 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbeIZXGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:06:51 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180926165300euoutp02ddec4b414036f51b552316f3e1a1169b~YAV7z9Fy03172431724euoutp02C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 16:53:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180926165300euoutp02ddec4b414036f51b552316f3e1a1169b~YAV7z9Fy03172431724euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537980780;
        bh=z8ZjyoeeMBcFva1hVsS9zEEIVxIl4V4bnVwQZiRQVKk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=JPO4idKF7u9ROYf8j/BRc7VEO212VHsYUTtvGk601m/yTSbDZgqMc+GkfWAjqEoe5
         p8qafFo7YD30knzWuAg1gQzlfj8N7x47X+NmLiaGRw96stFJsuMnCmLgtTKzTjWdNI
         8oExuhDZV0/gOATlfQRatd0+d81zrVjyuMxI5PUw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180926165259eucas1p2a84c710a6ea613dff25cd7d714768c5f~YAV7ICQi70898708987eucas1p2q;
        Wed, 26 Sep 2018 16:52:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 72.B5.04441.A69BBAB5; Wed, 26
        Sep 2018 17:52:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180926165258eucas1p21fc564f4f9d3d33e551937f2ad44272a~YAV6Efwju0462904629eucas1p2M;
        Wed, 26 Sep 2018 16:52:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180926165257eusmtrp1df5a8facc57c85126bd83eb2826cbce4~YAV5zw37y0496304963eusmtrp1b;
        Wed, 26 Sep 2018 16:52:57 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-d6-5babb96a201d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6C.EF.04284.969BBAB5; Wed, 26
        Sep 2018 17:52:57 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180926165257eusmtip2702c28963af226276c66e5ba1252d6a2~YAV5cQGfp2250922509eusmtip29;
        Wed, 26 Sep 2018 16:52:57 +0000 (GMT)
Subject: Re: [PATCH] video/fbdev/stifb: Fix spelling mistake in fall-through
 annotation
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Wed, 26 Sep 2018 18:52:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180903200728.GA22414@embeddedor.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djPc7rZO1dHG7RvYbK4/+k2o8WVr+/Z
        LLbuUbW4v24Vq8WJvg+sFpd3zWGzeHTqApMDu8e6g6oeHz7GedzvPs7kcWHRb1aPz5vkAlij
        uGxSUnMyy1KL9O0SuDIOnrzBUnCBueLSl4+sDYx/mLoYOTkkBEwkzhxYy9zFyMUhJLCCUWL3
        z/XMIAkhgS+MEtP28kMkPjNK7Dvexw7TsebjY0aIxHJGidsPGqGc94wSR+cfAprLwSEsECnx
        Yr0nSIOIgJHE7BndrCA1zAIXGCXObdjJCpJgE7CSmNi+ihHEZhFQldi09zgLSK+oQIRE/xl1
        kDCvgKDEyZlPWEBsTqDFMz88BbOZBQwkjiyawwphy0tsfzsH7AUJgUXsEm1NJ1kgmssk5h48
        zQpxtYvEz41r2SBsYYlXx7dAfSMjcXpyDwtE83RGiTe/lkI56xkl1pw5Bg0la4nDxy9CTXKU
        WDf3GCvIpRICfBI33gpCXMEnMWnbdGaIMK9ER5sQRLWaxIZlG9hgdnXtXMkMYXtILD0zlXkC
        o+IsJH/OQvLbLCS/LWBkXsUonlpanJueWmyYl1quV5yYW1yal66XnJ+7iRGYaE7/O/5pB+PX
        S0mHGAU4GJV4eDdsXB0txJpYVlyZe4hRgoNZSYR33XagEG9KYmVValF+fFFpTmrxIUZpDhYl
        cV4+rbRoIYH0xJLU7NTUgtQimCwTB6dUA6Ps3+1+tzzLL99WsHrrXq7m1GsiGFetP+/y5b6Y
        TYc5Zn0MPbfopM3Vqa9mBqTzFu3e9zsw4Lx9pJC+sMid1ctdfPUSureqL5tTfrJR6/pmPqnf
        Nv+mf5Rx2Hr3e72e3/Hb/3yFp9Quq2HT1XsZqj/faX/Q0+BlTxvvvpdNzXtScaUg7qWrsIwS
        S3FGoqEWc1FxIgAyZ86bMAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7qZO1dHG/TeNra4/+k2o8WVr+/Z
        LLbuUbW4v24Vq8WJvg+sFpd3zWGzeHTqApMDu8e6g6oeHz7GedzvPs7kcWHRb1aPz5vkAlij
        9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DIOnrzB
        UnCBueLSl4+sDYx/mLoYOTkkBEwk1nx8zNjFyMUhJLCUUeJSzz+WLkYOoISMxPH1ZRA1whJ/
        rnWxQdS8ZZQ4P/kqI0iNsECkxIv1niA1IgJGErNndLNC1LQzSuz/e5wZxGEWuMAocWfCBrBt
        bAJWEhPbVzGC2LwCdhLNn3exgtgsAqoSm/YeZwGxRQUiJG497GCBqBGUODnzCZjNCXTpzA9P
        wWxmAT2JHdd/sULY8hLb385hnsAoOAtJyywkZbOQlC1gZF7FKJJaWpybnltsqFecmFtcmpeu
        l5yfu4kRGD/bjv3cvIPx0sbgQ4wCHIxKPLwcW1ZHC7EmlhVX5h5ilOBgVhLhXbcdKMSbklhZ
        lVqUH19UmpNafIjRFOiJicxSosn5wNjOK4k3NDU0t7A0NDc2NzazUBLnPW9QGSUkkJ5Ykpqd
        mlqQWgTTx8TBKdXA2P30+mbu6akyPGcCshvef2lKeN3zX/6xNNtP3W/7y3zP7o1N2cfBcqgh
        5JtWlIWQgR7H8aWNx5MvsPdWrX/Smb4gVnvRm8krL3ROXKfXJeb+iPNW/BKLirDgkMJ/P+cf
        O964bI7m41uh3mGTn1r87zvHo6BlIfsk9OzZlo6ma9uNev/WPsl/p8RSnJFoqMVcVJwIAKXa
        f3i1AgAA
Message-Id: <20180926165258eucas1p21fc564f4f9d3d33e551937f2ad44272a~YAV6Efwju0462904629eucas1p2M@eucas1p2.samsung.com>
X-CMS-MailID: 20180926165258eucas1p21fc564f4f9d3d33e551937f2ad44272a
X-Msg-Generator: CA
X-RootMTR: 20180903200806epcas2p1171387c9a1699140856911ce283f470c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180903200806epcas2p1171387c9a1699140856911ce283f470c
References: <CGME20180903200806epcas2p1171387c9a1699140856911ce283f470c@epcas2p1.samsung.com>
        <20180903200728.GA22414@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/03/2018 10:07 PM, Gustavo A. R. Silva wrote:
> Replace "fall though" with a proper "fall through" annotation.
> 
> This fix is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough
> 
> Addresses-Coverity-ID: 402013 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
