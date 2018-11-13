Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B648C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DAD2082A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="S7ImW5TX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DAD2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbeKMULB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:11:01 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60870 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731878AbeKMULB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:11:01 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181113101335euoutp01a62feeeced4eecb299d647dfcf323f56~mp25x81342798627986euoutp01e
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 10:13:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181113101335euoutp01a62feeeced4eecb299d647dfcf323f56~mp25x81342798627986euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542104015;
        bh=dSDIG4wQseCLfEwdDAI/5VHKFelM0FiyxEo1TShPxFw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=S7ImW5TXnvTz3XlmRqCOjhfR3eUUibLE//o2g9egxxaHWJgngtxW1KWTty8tMX/2p
         QdYfvVSkzqrkH8muoOZmOV+8kZZfdjnnfcPwTvYV343BzXPdKE9bpy3a6+G39FCvww
         +GUdmb0LP+0ZmQOdj7BoCHx2F84jf/72QXo8jXYc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181113101334eucas1p1d3fa17e82b20991d93164de5561bc398~mp243qwHA2918429184eucas1p18;
        Tue, 13 Nov 2018 10:13:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B1.55.04441.DC3AAEB5; Tue, 13
        Nov 2018 10:13:33 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181113101333eucas1p1a692b4910a12253bceae0f2d007b3c0d~mp24JFXh62886628866eucas1p1v;
        Tue, 13 Nov 2018 10:13:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181113101333eusmtrp2564d82b1c5301445aa468c47f9a6be37~mp236WWvz2899828998eusmtrp2s;
        Tue, 13 Nov 2018 10:13:33 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-b6-5beaa3cd7493
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B3.B5.04284.DC3AAEB5; Tue, 13
        Nov 2018 10:13:33 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181113101332eusmtip2f4c3af09f99c0f45221ac08d4ff11dcc~mp23XJzxM0908509085eusmtip2U;
        Tue, 13 Nov 2018 10:13:32 +0000 (GMT)
Subject: Re: [PATCH v2 05/11] Doc: DT: thermal: new irq-mode for trip point
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, mark.rutland@arm.com, corbet@lwn.net,
        b.zolnierkie@samsung.com, krzk@kernel.org
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <64aaa2aa-00ad-643f-3b44-f505a31f2ee8@partner.samsung.com>
Date:   Tue, 13 Nov 2018 11:13:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5bea0ecd.1c69fb81.d5613.1c9e@mx.google.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe7eds7PZ4m1ae7AsWoVmtRIkjhVRYHXAPgj1oRKqlQcvuc12
        MlsXMgldUsOKvMzwkpWxvDVXzTJQ09ZaZV4ytcSi+UFhH3JdMK3ldhb57f8+z+/h///DSwnl
        g0Q4laY9zuq16gwlKRU9fD75Zu3r6vGk9UP1G+n7JQ0E7W7NR3S5N4Ku6HhD0BV9/QTd1dUo
        pq1fZlRV3i0R3fv4Bkl7L3cg+vb7bgHta7GLafdnE7lVxtSW1yKm2TwsZqpbxgSM1XKRZD72
        t5BM061zTLXpGsGYbBbEeK1LEiX7pZuT2Yy0E6x+3ZZD0tSafpMos1928sq4k8xBZSEFSEIB
        joWJCz6yAEkpOb6L4E69V+RfyPE3BE03Q/iFF4GlJ1f878LlKQhe1CBofddG8A8Pgl91btJP
        heIEaDv/m/DrMLwMpvKKApAQPxBAo3FwxoOiSKwCu+WYn5HhHeB4WxOwFuGVMHz9O/LrBXgv
        GEfukTwzH5yl7gAjwXFQ39oZYIRYAUPuCgGvl8Ijzw2h3wvwpBhqW7sRHzse8kefErwOhXGH
        LVhnMfia+WPAHLw2Wkhen4F8pz3IbIJnjm7Cn1mIV0HD43X8eBs4H0wHxoDnwYBnPh9hHlx9
        WCzkxzIw5sl5Ogpsl94GjRZCTW2RuBApzbOKmWeVMc8qY/7vW4lEFqRgszhNCsvFaNlsFafW
        cFnaFNURncaKZj6c649jwo6+9xxuR5hCyrmyF8VjSXJCfYIzaNoRUEJlmKw5djxJLktWG06x
        et1BfVYGy7WjRZRIqZCdnvMpSY5T1MfZoyybyer/bQWUJDwH7Qxd8bOw90fUq6orsXUdnyq3
        HjDs3PduekRnH4seaOxcrvng6DncWxZR3sHGpLvb0vumDCWFXUP7pOnZc+I8BVEKiHNP7ir9
        HOJeyBh8roki3YHkYtdI5F3f7puO8DW20RzidsLwE2n810jXy3upqrOm+sQNttXkk8rMpxv2
        bM9VirhUdUy0UM+p/wJUHjSEbAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsVy+t/xe7pnF7+KNui5y2GxccZ6VosnB9oZ
        LeZ9lrWYf+Qcq8X8K9dYLc6f38BusekxkLWwbQmLxeVdc9gsPvceYbRYev0ik8X/PTvYLZ48
        7GNz4PVYM28No8fOWXfZPRbvecnksWlVJ5vHnWt72Dw2L6n3WNw3mdWjb8sqRo/Pm+QCOKP0
        bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0MpZf62Mp
        uMZbMfHVSbYGxtncXYycHBICJhKn33axdTFycQgJLGWUWHDkACtEQkxi0r7t7BC2sMSfazBF
        rxklvrb9AisSFvCWONj4F8wWEVCU+N02jRWkiFlgK5PE1ls3mSA6+pgk9v2cB5Th4GAT0JPY
        saoQpIFXwE3i+IXlLCA2i4CqxN2pXxlBbFGBCImzL9cxQtQISpyc+QSshlPAUmLdgaNgcWYB
        M4l5mx8yQ9jiEreezGeCsOUltr+dwzyBUWgWkvZZSFpmIWmZhaRlASPLKkaR1NLi3PTcYkO9
        4sTc4tK8dL3k/NxNjMC43nbs5+YdjJc2Bh9iFOBgVOLhPTH9ZbQQa2JZcWXuIUYJDmYlEd6d
        Jq+ihXhTEiurUovy44tKc1KLDzGaAj03kVlKNDkfmHLySuINTQ3NLSwNzY3Njc0slMR5zxtU
        RgkJpCeWpGanphakFsH0MXFwSjUwVu3ZmyofI/uwjXX/5av7+Uw2t33VCTV4ZVVhe/bMtbwK
        7Zv1PvtZ/nLLm6ucft90cnNd8+RfWy5VcOQcTF4Wpc6Tcv3X1+CqcjnfWxXF+t4iT2OMNapy
        luatEl9+/V9788HLsY8OXL+2Ucj6Y77OPpUGtcz/PltzunfEMdQrPWK7a2PYsl1KiaU4I9FQ
        i7moOBEABaWDugEDAAA=
X-CMS-MailID: 20181113101333eucas1p1a692b4910a12253bceae0f2d007b3c0d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181107171039eucas1p2227bd4bc573fd0d2a3a97986004be16b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181107171039eucas1p2227bd4bc573fd0d2a3a97986004be16b
References: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181107171039eucas1p2227bd4bc573fd0d2a3a97986004be16b@eucas1p2.samsung.com>
        <1541610593-28542-6-git-send-email-l.luba@partner.samsung.com>
        <5bea0ecd.1c69fb81.d5613.1c9e@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 11/12/18 8:09 PM, Rob Herring wrote:
> On Wed, Nov 07, 2018 at 06:09:47PM +0100, Lukasz Luba wrote:
>> Thermal trip point gets new flag in DT: irq-mode.
>> Trip point may have a new explicit flag which indicate
>> IRQ support when the temperature is met (so the thermal framework
>> deos not need to set polling for it).
>> It is useful for 'passive' cooling trip point,
>> which now will not register for polling the temperature.
>>
>> Update documentation about irq-mode for trip points.
> 
> This patch should come before you use it.
OK, I will re-order the patch set in v3.
> 
>>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>> Cc: Eduardo Valentin <edubezval@gmail.com>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   Documentation/devicetree/bindings/thermal/thermal.txt | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
>> index ca14ba9..bee21e3 100644
>> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
>> @@ -90,6 +90,10 @@ Required properties:
>>   	"critical":	Hardware not reliable.
>>     Type: string
>>   
>> +- irq-mode:		A flag indicating that trip rises irq, so there is no
>> +  Type: bool		need of polling in thermal framework.
>> +  Size: one cell
> 
> Should be optional, right?
Yes, it is optional. I will mention about it in change v3.

Thank you for the review.

Regards,
Lukasz
