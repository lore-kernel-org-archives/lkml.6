Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBD8C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E56C2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OW+zXJN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E56C2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeJPXjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:39:40 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53714 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeJPXjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:39:39 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181016154835euoutp0276b650b0a8c9357abb6a17057f68a260~eIXaHwTub2916129161euoutp02G
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 15:48:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181016154835euoutp0276b650b0a8c9357abb6a17057f68a260~eIXaHwTub2916129161euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539704915;
        bh=QBNbWzk2yvu2bqkGhmiwcvfsSOUzgIdkB3SeIUCvErA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OW+zXJN3pL/wluvkBT7Y+4HtZ6swjq1ACKaVg8u+JDTuFmqJqe/fcHYO8W6kQ+FwU
         7nwc/wU7OSi5c5vD7IA3JLZeJtK0W5w+86/GDdK7GrcPQA88Bl4qs0nSLN5LPwo3EG
         1N0TjypTm4Nubd//LTF2G8fpRoGYMADd+sYuGSD0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181016154834eucas1p1b7151948a186c54f5c64e52c64834224~eIXZOPb0l2897528975eucas1p1q;
        Tue, 16 Oct 2018 15:48:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A9.18.04441.25806CB5; Tue, 16
        Oct 2018 16:48:34 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181016154833eucas1p2b2e7cbb90df83737e655bb8a343c4eab~eIXYh7z9r2960029600eucas1p2p;
        Tue, 16 Oct 2018 15:48:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181016154833eusmtrp1bc5fa5d8e6a51bfaf5c40e1cd530f9c5~eIXYS_3VS2676326763eusmtrp1O;
        Tue, 16 Oct 2018 15:48:33 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-83-5bc608526888
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B0.FF.04128.15806CB5; Tue, 16
        Oct 2018 16:48:33 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181016154832eusmtip1072f621f70b26e3705e4c8b9e3b292de~eIXXsWDOp0971009710eusmtip1j;
        Tue, 16 Oct 2018 15:48:32 +0000 (GMT)
Subject: Re: [PATCH 06/11] DT: arm64: exynos: add support for thermal trip
 irq-mode
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org
From:   Lukasz Luba <l.luba@partner.samsung.com>
Date:   Tue, 16 Oct 2018 17:48:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPe4Jf3QVbQ6BFPFptkgvmmpNu+QCmDoD3JqhyYOidJ7vA@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTURzGObuvkybXa7V/mhmjIgNnksWlIor6cCEKk4JoH2rlxZd02q6u
        7AUta+ooLYWsKZqoWTfzPVthEDoViVpqaoWZ4j6kOXqZmUJKXm+S337/5zznf54HDo2xg0QA
        HWdKEcwmY4KO9MGbO2ZcoVF0h2Gz9QfL1d+pJTj3yyzElXiDuFLnG4IrfddPcHmjXzHO5aqj
        uIbR+bHMWoFzvc+LSc57w4m4yoFuFXfthZPi3CO55G5fvrqkGvHP7J8ovrxlTMU3SDkkP9jf
        QvKNFel8eW4Bwec2SYj3NqyJVB/z2RktJMRZBHPYrhM+sYXdNWTyYNA5r20Ky0BlWhtS08BE
        gMNTorIhH5plHiAYsI5jyjCJoN3qImUXy3gRZLatW7zRNX4XV0xVCN5c+0MpgwdBVZ2Dkl3+
        zBF49uUBIfNyJgQGZn8vMMZkYlAzEWZDNE0yenBIZ2QZZ9aDZ9SNy7yCOQrO4TIks4bxg667
        iq5mDsGTR6NIWaOFj+5SlcLB8NRTvJAamFkKLudPIXm/hrFA751gJfQ+6P09qVLYH8Y7myiF
        V8Orguu4wiK8zpZIhS9CVpfjn2cHtHV2E/JKbL5K7fMwRd4DY7dGKFkGxhfee/yUNL6Q31yI
        KbIGsq2s4t4ITdff/guwEqqqb1M3kc6+pKN9SS/7kl72/+/eQ7iEtEKqmBgjiOEm4axeNCaK
        qaYY/amkxAY0/+dezXX+dKBfPSdbEUMj3TLN9IDTwBJGi5iW2IqAxnTLNTE97QZWE21MOy+Y
        k46bUxMEsRUF0rhOq7lfUm9gmRhjinBaEJIF8+KpilYHZKCaIv/HVy4ZdEX6/cOBhacjQx0b
        tkcOd+TmOB5+/1zrp369+mLA9JShYKtUcXTuQLxESY6sdIuJ0M7M7Nm2Nqhx0+Eo4474j3n9
        ya6IlsqkUDLianDTwZV730b25bl/rOobshZ8udDDctlF0ofMQPONoCG9feKTpd0+Q4bYvm05
        p8PFWGP4JswsGv8CKcJ19W8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsVy+t/xu7qBHMeiDc5ul7fYOGM9q8WTA+2M
        FvM+y1rMP3KO1WL+lWusFv2PXzNbnD+/gd1i02Mgd2HbEhaLy7vmsFl87j3CaLH0+kUmi9a9
        R9gtnjzsY3Pg81gzbw2jx85Zd9k9Fu95yeSxaVUnm8eda3vYPDYvqfdY3DeZ1aNvyypGj8+b
        5AI4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy
        pl9cx1ZwR7bic9c35gbGheJdjJwcEgImEidfzWTpYuTiEBJYyigx98N7doiEmMSkfduhbGGJ
        P9e62CCKXjNK/Fv/hgkkISwQKrHzxQpWEFtEQFPi+t/vYDazQDOzxOO1hhANl5gkpq47BNTA
        wcEmoCexY1UhiMkr4Caxen0tSDmLgKrE28dPWEBsUYEIidXLX4CN4RUQlDg5EyLOKRAosXX1
        Y0aI8WYS8zY/ZIawxSVuPZnPBGHLS2x/O4d5AqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnp
        ucVGesWJucWleel6yfm5mxiB0b3t2M8tOxi73gUfYhTgYFTi4f1x/Ui0EGtiWXFl7iFGCQ5m
        JRHe9EtHo4V4UxIrq1KL8uOLSnNSiw8xmgI9N5FZSjQ5H5h48kriDU0NzS0sDc2NzY3NLJTE
        ec8bVEYJCaQnlqRmp6YWpBbB9DFxcEo1MO5Irq6u+SfW/9uupDmAYd6yrQu/+xUli6rFshev
        Zkwq375pjuepzPQ3Z7QivP74TuDt+TalI+gO1+eSBRW7bd0jQ97dWB9fOuG2t53z22rvW1zP
        +PbXte7h/l5V4zjXL/VWy3/Vd/aTDh3+uq1LWeFB3Wfz+48qajZsmLtW+v9J9gsJKaxT65VY
        ijMSDbWYi4oTAQxhHsgEAwAA
Message-Id: <20181016154833eucas1p2b2e7cbb90df83737e655bb8a343c4eab~eIXYh7z9r2960029600eucas1p2p@eucas1p2.samsung.com>
X-CMS-MailID: 20181016154833eucas1p2b2e7cbb90df83737e655bb8a343c4eab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016145647eucas1p206c068806214535da339588d77cbdfa5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016145647eucas1p206c068806214535da339588d77cbdfa5
References: <CGME20181016145647eucas1p206c068806214535da339588d77cbdfa5@eucas1p2.samsung.com>
        <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
        <20181016145647eucas1p206c068806214535da339588d77cbdfa5~eHqLYh2dR2135021350eucas1p2K@eucas1p2.samsung.com>
        <CAJKOXPe4Jf3QVbQ6BFPFptkgvmmpNu+QCmDoD3JqhyYOidJ7vA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 10/16/2018 05:09 PM, Krzysztof Kozlowski wrote:
> On Tue, 16 Oct 2018 at 16:56, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
> 
> Hi Lukasz,
> 
> Thanks for patches.
> 
> I did not receive the first patches in the series. It is okay (depends
> on the context) but in such case sending cover letter to all people is
> quite useful. It helps to understand the entire patchset. Since I did
> not get them, I really do not know:
> 1. Whether DTS patches are independent?
> 2. How this fits in the big picture of Exynos thermal?
I have lost your email for my 'cc' command line, my apologies.
I will add you in v2.
Here you can find the cover letter:
https://marc.info/?l=linux-pm&m=153970180314648&w=2
regarding
1. they are independent
2. It will be less confusing and more coherent with documentation
when we use 'passive' for DVFS cooling. Unfortunately, when 'passive'
is set, it registers our trip points for polling and thermal schedules
the work. I had conversation with Daniel regarding this setup,
please check these email:
https://marc.info/?l=linux-kernel&m=153924620318766&w=2
and my response:
https://marc.info/?l=linux-kernel&m=153933708316168&w=2

> 
> 
>> This patch adds support for new flash which indicates
> 
> What is "flash"?
Should be 'flag', thanks for that.
> 
> Please wrap your lines accordingly (75 characters like in
> submitting-patches.rst). Current wrapping makes it more difficult to
> read.
OK
> 
>> that trip point triggers irq when temperature is met.
>> Exynos5433 supports 8 trip point which will trigger irq.
> 
> "Exynos5433 supports 8 trip points which trigger interrupt."
> (or IRQ but not irq)
ACK
> 
>> Above that number other trip points should be registered
>> without 'irq-mode' flag.
> 
> Why they should be registered without irq-mode?
For this HW, only 4 temperatures can be monitored for which IRQ
will fire, AFAIK.
> 
>> That will force the thermal framework to start polling
>> the temperature sensor under configured conditions and
>> handle the trip point.
> 
> How does it fit into existing polling mode?
The existing polling mode is default for 'passive' which does
not have this flag, so nothing changes. The benefit for 'passive'
which are supported by HW IRQ and has this flag is lack of polling
every Xms.
In current situation we are trying to establish this behavior by a
workaround with 'active'. the 'active' in default
does not register polling and waits for IRQs, so the framework is quiet.
This naming tricks are a bit confusing for people, though.

Thank you for comments.

Regards,
Lukasz

> 
>>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
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
> Change of active->passive looks irrelevant to this topic. Here and
> everywhere else.
> 
> Best regards,
> Krzysztof
> 
> 
