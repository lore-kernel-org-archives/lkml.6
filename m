Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ED5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E10C2082A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="psfwZ+72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E10C2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732055AbeKMUHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:07:51 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44345 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731448AbeKMUHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:07:50 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181113101027euoutp0201cf0c156730facbf74b1cc3d93e13b8~mp0Kol0Ws0094900949euoutp02R
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 10:10:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181113101027euoutp0201cf0c156730facbf74b1cc3d93e13b8~mp0Kol0Ws0094900949euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542103827;
        bh=iexbsrjHd1czc9/sC51m9w8dIqn1K2yIM6KmfEThm04=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=psfwZ+72cxxiihHumViTqlW6oJRFq+VMfKbPohNOFjgdEpI2euprEZIifsZgu2nsD
         jAUDXBMCK3w61IlFvtsBILj06flOZ/SBHFkyFJvzhGNYQoTD+82r5X/zSt/sAsUwJ3
         jr4ZOUW9PDm+d3rL8s2X4+aCqLpyC8u2BYwapea8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181113101026eucas1p2f1e106c18550d0370e8b172f8f50b70f~mp0J7vVzQ1908819088eucas1p2i;
        Tue, 13 Nov 2018 10:10:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 4B.C4.04441.113AAEB5; Tue, 13
        Nov 2018 10:10:26 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181113101025eucas1p1977bc16f7dfdce661a1f9774d646635e~mp0JIDh4I1741517415eucas1p1r;
        Tue, 13 Nov 2018 10:10:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181113101025eusmtrp10a252ab034aef14d0be6e282db289440~mp0I4-k5d2718627186eusmtrp1g;
        Tue, 13 Nov 2018 10:10:25 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-25-5beaa3116449
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2C.2A.04128.113AAEB5; Tue, 13
        Nov 2018 10:10:25 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181113101024eusmtip1393719ebb92dc200b303248574714459~mp0IQwyw00956409564eusmtip1F;
        Tue, 13 Nov 2018 10:10:24 +0000 (GMT)
Subject: Re: [PATCH v2 06/11] arm64: dts: exynos5433: add support for
 thermal trip irq-mode
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <616778d8-387f-dbc9-6523-289058b22577@partner.samsung.com>
Date:   Tue, 13 Nov 2018 11:10:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcGOiVwVuaT+2RHGs0VxA2XRjOd6efsDQaGrWWCJS7vNg@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+85tZ9bsOC1ftBIW3YQ0yeCUFhURhyLK/rBoSK12UMtbO5qp
        UWZ4LVdkpQ5T02oxNaeZl2Gl0zIRnZpoRZGyQeUlwi3DQMl5jPzv97zf+z3v+3x8NC63kl50
        ZEw8r4lRRSkoF6L+zbRls7x8VLmlPx2xNQXVJGtryURssX01W9LeQ7IlA4Mke9M6hrMWi1HC
        1lrn5IOMhwT7zlREsfbcdsQWWF5i7KOhPoxNf9EuYW0jWmr3cq6yuBJxTbrPEq68+TvG1Rqy
        Ke7TYDPFPXt4hSvX5pGcts6AOHvtmiPSEy7Baj4q8gKv8d91yiWibLyfjMuGix901VgqapXn
        ICkNTCAMN9lQDnKh5cwTBDXjzylROBBcnxohRWFH0PCmn8hB9PyVpr6jYl2PoLctAxPFxJwo
        skicvu5MGBRc+4Q52YPZBEMzv+edcKYHh4rSknknivGDRsN5Z4+M2Q+WSSvpZIJZBwMtjnmf
        FcxxyPpSQYk9btBZaCOcLGVCYHjUipyMM57w0VaCiewDDRNFuHMWMNk06J9M4GLQfVDWbUIi
        u8NoR51E5FXQlXeDEFmA7iwDJfIlyOxsXOgJgraOPtK5Mz4XptrkL5b3wIxlmhIfxRXeT7iJ
        K7jC7fp8XCzLICtj4aU3Qt2NXkzklaCvvCe5hRS6RcF0i8LoFoXR/Z9biggD8uQThOhwXgiI
        4RP9BFW0kBAT7ncmNroWzX29rtmOyUb0q/+0GTE0UiyTvc3/rpSTqgtCUrQZAY0rPGRNgaNK
        uUytSkrmNbEnNQlRvGBG3jSh8JSlLBlWyplwVTx/jufjeM2/U4yWeqUiw/bA8hfEwb0rrMGD
        DQpfn8ys8JG7VuNj9Va1cFW94VDabKPW9PjH+uCQb5iywXGZObH2/tidzYmF2J8qj7dGo/dP
        fOrpYJgHMAdeaVNaEo3b/NNCW48FmZL15tfLCjrjS8mdYyh4aOns19DD+s9nc9lD3oEzAyM7
        HONVWHHbRwUhRKgCfHGNoPoLSIX7O3YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsVy+t/xu7qCi19FG7y8z2uxccZ6VosnB9oZ
        LeZ9lrWYf+Qcq8X8K9dYLfofv2a2OH9+A7vFpsdA7sK2JSwWl3fNYbP43HuE0WLG+X1MFkuv
        X2SyaN17hN3iycM+Ngd+jzXz1jB67Jx1l91j8Z6XTB6bVnWyedy5tofNY/OSeo/FfZNZPfq2
        rGL0+LxJLoAzSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1
        SN8uQS9j0ZtLrAWdEhU3Z61namA8KNTFyMEhIWAisfNiUBcjF4eQwFJGiZdrV7N1MXICxcUk
        Ju3bzg5hC0v8udbFBlH0mlFiypcXTCAJYYFYiUeXN7CC2CICmhLX/34Hs5kFzjFLND+pgmhY
        xiRx7v4SJpBtbAJ6EjtWFYLU8Aq4SZz/9BisnkVAVeLKgS9gy0QFIiTOvlzHCFEjKHFy5hMW
        EJtTIFDiwavHjBDzzSTmbX7IDGGLS9x6Mp8JwpaX2P52DvMERqFZSNpnIWmZhaRlFpKWBYws
        qxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQLjfNuxn1t2MHa9Cz7EKMDBqMTDe2L6y2gh1sSy
        4srcQ4wSHMxKIrw7TV5FC/GmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MAXllcQbmhqaW1ga
        mhubG5tZKInznjeojBISSE8sSc1OTS1ILYLpY+LglGpgZJqUo9h8btNhgyNhEW58Qod5C9JO
        2kROTNO6vZ6RabbLPvmsNwdsCp5IV1+64bo37QEHs/DOnKL5n3oSVrsuqpkjufsMh8viA3ci
        zWX+8kcdqDr6eV/KBPPGJs8l75YKbNf1ylIqObK/K19d685TG4+0RxOnb9HUWftc8dWLJh61
        3UWreD/8V2Ipzkg01GIuKk4EAKGmB+kJAwAA
X-CMS-MailID: 20181113101025eucas1p1977bc16f7dfdce661a1f9774d646635e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181107171041eucas1p1a3cf91435b9071fd6e6f84101ebbcd9f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181107171041eucas1p1a3cf91435b9071fd6e6f84101ebbcd9f
References: <CGME20181107171041eucas1p1a3cf91435b9071fd6e6f84101ebbcd9f@eucas1p1.samsung.com>
        <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
        <1541610593-28542-7-git-send-email-l.luba@partner.samsung.com>
        <CAJKOXPcGOiVwVuaT+2RHGs0VxA2XRjOd6efsDQaGrWWCJS7vNg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 11/12/18 10:00 AM, Krzysztof Kozlowski wrote:
> Thanks Lukasz for patches. I like your work!
> 
> I have few more comments which will probably apply for all the DTS commits.
> 
> On Wed, 7 Nov 2018 at 18:10, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> This patch adds support for new flag which indicates
> 
> This patch does not add support. Support for flag was added in your
> first drivers/thermal patches in this set. This patch adds new flag.
> (and does something more, so read on)
Got it, will change the commit message.
> 
>> that trip point triggers IRQ when temperature is met.
>> Exynos5433 supports 8 trip point which will trigger IRQ.
> 
> /8 trip point/8 trip points/
> 
>> Above that number other trip points should be registered
>> without 'irq-mode' flag.
> 
> Please fix the line-wrap.
OK
> 
>>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-samsung-soc@vger.kernel.org
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi | 105 ++++++++++++++++---------
>>   1 file changed, 70 insertions(+), 35 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
>> index fe3a0b1..c4330f6 100644
>> --- a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
>> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
>> @@ -17,37 +17,44 @@ thermal-zones {
>>                          atlas0_alert_0: atlas0-alert-0 {
>>                                  temperature = <65000>;  /* millicelsius */
>>                                  hysteresis = <1000>;    /* millicelsius */
>> -                               type = "active";
>> +                               type = "passive";
> 
> This change is not explained in commit msg.
> 
> Basically you are doing here two things (related to each other). You
> clearly define which trip points are IRQ-type and you correct the type
> of trip point. Active is incorrect. This second thing is missing in
> your commit msg and I believe it is main reason behind this patch. You
> should focus then on this reason - start from it. Subject could be
> like "Use proper passive type for thermal trip points".
> 
> Without this explanation I don't see the strong reason behind that
> patch. IOW, everything was working fine before... so why adding this
> new flag? Or maybe something was not fine... and then it is real
> reason why you are sending the patch. Usually commit message should
> answer to the most important question "WHY". Now, it explains
> "WHAT"... but I can see it from the source code. However from the code
> it is not easy to guess WHY.

OK, I will add the explanation 'why' similar to description from the
cover-letter to all the patches which add this flag in DT files.

> 
> Best regards,
> Krzysztof
> 
> 

Thank you for the review.

Regards,
Lukasz
