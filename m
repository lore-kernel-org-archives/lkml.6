Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22907C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D99216C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YBhODgbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D99216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeHUKrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:47:23 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57883 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbeHUKrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:47:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180821072820euoutp021a3285959406977b2acb0195f609168e~M1aposiqm2872228722euoutp028
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 07:28:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180821072820euoutp021a3285959406977b2acb0195f609168e~M1aposiqm2872228722euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1534836500;
        bh=1+X9SFv2VrVSPywh992dpQKWn86u+dVR44LvXbqOF9s=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=YBhODgbgatkM9U2qipJ7I0DvEMGab+KvV+CrtX9Cm/kIGr9O5jfr7HhEMckNI0N+d
         cLIF7L88JDssOy/ypuAugfKndQyRzNJQf7GZcFrmLXSGuD67Xs5FixetQh5DtcQzpN
         mBaXsPTnNn9PgbTbBcbrGebRiVflG1lQ+R7mkpRc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180821072820eucas1p1850acdfc10fa899eaa0c39b0a63574a8~M1ao9NP952065020650eucas1p1f;
        Tue, 21 Aug 2018 07:28:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5F.33.04806.31FBB7B5; Tue, 21
        Aug 2018 08:28:19 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180821072819eucas1p24b9038a7a2a1b1eae0d7c91bc31fe1b2~M1an4a6Av2511925119eucas1p2u;
        Tue, 21 Aug 2018 07:28:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180821072818eusmtrp1d33794eec690ae8c95231b8a7b0cb3f6~M1anpkAQL1101811018eusmtrp1X;
        Tue, 21 Aug 2018 07:28:18 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-75-5b7bbf1339e1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 98.7D.04284.21FBB7B5; Tue, 21
        Aug 2018 08:28:18 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180821072818eusmtip14c7a59b3584c457a2fb1e56e5c1839d7~M1anIHqu72908829088eusmtip1S;
        Tue, 21 Aug 2018 07:28:18 +0000 (GMT)
Subject: Re: mfd: cros_ec: Check for mkbp events on resume only if
 supported.
To:     RaviChandra Sadineni <ravisadineni@chromium.org>,
        lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        ravisadineni@google.com, dtor@google.com,
        linux-samsung-soc@vger.kernel.org, tbroch@google.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        tfiga@chromium.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Tue, 21 Aug 2018 09:28:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180820153419.32098-1-ravisadineni@google.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+93HdrecXKflwcJwUJDli14XNDFSGGEUWVFN0KU3tZzK5lsC
        yZU15tIS0jlQJDIfaQ41lZim5iwDnZI9yGQm9GJomcrQNK83y/8+53u+5/y+B34ULm0lvaik
        lHRWnaJMlgnERFu/c8jPvStPEWgbP8D0Vn9BTOXXW0JmYu45Yt79nCeZ0U6TgCkbsmBMo3Ye
        MUOORZKpXrCTzOz1ZUGYWF6RbyPkHcZxobzKnCH/MPZUIJ81e58kL4hD4tnkpExWHRAaK04s
        /OjE0wpcsstLh7F8ZBfpkIgCej8U9xQTHEvphwiMS3t1SLzKvxDcn2wg+WIWQZ1DK1yf+GQ3
        CPlGDYKq8RGML6YRzHQ/wDiXO30CGsca1yY8aBMGRS/jORbQQaBz6AQ6RFEEvRM6hlUcbqGj
        YbEzmHNIaDd4UT61lkhEH4aZadPaFpzeAU8cJpxnT3g/VYnxeSxC0LYquTUSOhMMj+N4ORxe
        O0ZJnt3hm7Xlb/ztMHhXT3CJgS5AUFhmFPKFHkGrqV3Au4Kh12ojuaU4vRuaOgN4+QiYpq4h
        TgbaFd463Pg4rnCn7R7OyxK4eUPKu3eB0dr479lnwyM4z3JYmWwgipGPccPBxg1HGjccafyf
        oQoRdciTzdCoEljNvhQ2y1+jVGkyUhL841JVZrT6mQaXrXPtyLJ0sQfRFJK5SLpHchVSUpmp
        yVH1IKBwmYckNDNPIZXEK3NyWXVqjDojmdX0oG0UIfOUuPpeUkjpBGU6e4Vl01j1ehejRF75
        aKDFcGjlTel5q+jMUdfisoNbfR4tdl/u07rZNqfrK1UefTFRUT90lpJAl+WZCj8PPC0wu+G4
        p7cihqk1MRNN0bftm7SRr2oHsvrn6kusqOv3VZ+AinN657GasPDvzogFN7xsT2x0RH1I/MrZ
        E7pTkYyt6LNf7WlncyRmbjbYI2WEJlEZ5IurNco/30BwOUgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xu7pC+6ujDf7/ULc4vOgFo8X8l53s
        Fve/HmW0uPnpG6vF5V1z2CxmnN/HZLGu5Rujxfm3v1ktFn1/yGrxufUfmwOXx+yGiyweO2fd
        ZfdYsKnU4861PWwenzfJBbBG6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp
        29mkpOZklqUW6dsl6GW03/vJXNDMUzFzygWmBsaHnF2MnBwSAiYSjx/2sXcxcnEICSxllJh6
        dyEbREJG4uS0BlYIW1jiz7UuNoiit4wSk5d0M4EkhAV8JU5/WcUEkhARmMUksfr3GahRExgl
        WmesAqtiEzCU6HrbBTaWV8BOYvGJVcxdjBwcLAKqEjsv5IKERQViJI5OboEqEZQ4OfMJC4jN
        KWAr8eH9HHYQm1nATGLe5ofMELa8xPa3c6BscYlbT+YzTWAUnIWkfRaSlllIWmYhaVnAyLKK
        USS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMPa2Hfu5eQfjpY3BhxgFOBiVeHgPXKqKFmJNLCuu
        zD3EKMHBrCTCa1dWHS3Em5JYWZValB9fVJqTWnyI0RTot4nMUqLJ+cC0kFcSb2hqaG5haWhu
        bG5sZqEkznveoDJKSCA9sSQ1OzW1ILUIpo+Jg1OqgVFnjvix2gdJ1mXsc/iUdsYx2yWfu/xQ
        PPjdNIV/517acm03OPpi5kb51Rcs63SkZTK4ltUsfOD2cIle7tO9965a7jZoWflxUe6W3L/f
        DreXRbunCOwWcXub/v/UVT5D9ueaye8qD1rt4ty5MGRx2H3nJVMeH5rt81Sozj0mVexH5Msp
        9tO43sxUYinOSDTUYi4qTgQAFa77rtMCAAA=
Message-Id: <20180821072819eucas1p24b9038a7a2a1b1eae0d7c91bc31fe1b2~M1an4a6Av2511925119eucas1p2u@eucas1p2.samsung.com>
X-CMS-MailID: 20180821072819eucas1p24b9038a7a2a1b1eae0d7c91bc31fe1b2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180820153427epcas3p366f998ada5f2f37f1198a1321e9e10be
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180820153427epcas3p366f998ada5f2f37f1198a1321e9e10be
References: <CGME20180820153427epcas3p366f998ada5f2f37f1198a1321e9e10be@epcas3p3.samsung.com>
        <20180820153419.32098-1-ravisadineni@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

On 2018-08-20 17:34, RaviChandra Sadineni wrote:
> Currently on every resume we check for mkbp events and notify the
> clients. This helps in identifying the wakeup sources. But on devices
> that do not support mkbp protocol, we might end up querying key state of
> the keyboard in a loop which blocks the resume. Instead check for events
> only if mkbp is supported.
>
> Signed-off-by: RaviChandra Sadineni <ravisadineni@chromium.org>

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>
>   Note: This patch fixes the suspend/resume issue on Snow and Peach-Pit
>   Chromebooks, both on vanilla v4.18 as well as linux-next from 20 August
>   2018. Further info at: https://lkml.org/lkml/2018/6/5/1076
>   
>   drivers/mfd/cros_ec.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index 65a9757a6d21..fe6f83766144 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -218,7 +218,8 @@ EXPORT_SYMBOL(cros_ec_suspend);
>   
>   static void cros_ec_report_events_during_suspend(struct cros_ec_device *ec_dev)
>   {
> -	while (cros_ec_get_next_event(ec_dev, NULL) > 0)
> +	while (ec_dev->mkbp_event_supported &&
> +	       cros_ec_get_next_event(ec_dev, NULL) > 0)
>   		blocking_notifier_call_chain(&ec_dev->event_notifier,
>   					     1, ec_dev);
>   }

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

