Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778B4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F512087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="urbhgqxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F512087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbeJLRJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:09:20 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57834 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbeJLRJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:09:20 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181012093743euoutp02640593a620828871fcec17199d7c3633~c0udkxsTI0035400354euoutp02c
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 09:37:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181012093743euoutp02640593a620828871fcec17199d7c3633~c0udkxsTI0035400354euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539337063;
        bh=RXBQjJYHBogHH6rtNqZUiBZ1z1bj5wIzKRqVqoEULsU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=urbhgqxDAGYbwq6v3QGB7ax0BxXJghyeY7UgcIMO/VCnT9GM1+Apc0HW7KnQqSD18
         fWxTKumIuqUFP/VMO4xpgD9bUbD5RhL1E08SaFkFaL1rbJbKzgwHbMJQ5fd/vaPgAK
         gFdSBIQqDfXw+D+sJELh3KIiDb0BUCw7rgxfPVWg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181012093742eucas1p29f301cf70a75574190ae5e36eaf6394b~c0ucdHMUu3034330343eucas1p2S;
        Fri, 12 Oct 2018 09:37:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 08.B7.04294.66B60CB5; Fri, 12
        Oct 2018 10:37:42 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181012093741eucas1p26a54ad3091e4ba2468f61083c64749db~c0ubdFqkD3034330343eucas1p2R;
        Fri, 12 Oct 2018 09:37:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181012093741eusmtrp2382e6aa869462a778c81dc9cd188073a~c0ubN4XDY2686026860eusmtrp2k;
        Fri, 12 Oct 2018 09:37:41 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-89-5bc06b6649f5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F6.32.04128.56B60CB5; Fri, 12
        Oct 2018 10:37:41 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181012093740eusmtip2bdde123366d4b87ad4d1435e861def5e~c0ualwCCY1799817998eusmtip2Z;
        Fri, 12 Oct 2018 09:37:40 +0000 (GMT)
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        linux-pm@vger.kernel.org, quentin.perret@arm.com,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Lukasz Luba <l.luba@partner.samsung.com>
Date:   Fri, 12 Oct 2018 11:37:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f099ded8-e074-da18-2eac-e07a5a99af18@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0yMcRze99733ns7rn07P/qsCLdsMqIYX7HGMK/Nr81QYhz3qugq9yoy
        m8aWQrJa6PpJo7pKdVJXGTlN4lCicjpjwmIp7vwIK673TP89n+fzPN/P82xfllJ+lnqxkdEH
        eF20OkrFyOmau4OPZu/Z1xg2t8oA5OenLBmpulAhJXn2yST/aYeUHC+sYEjm7VQJGTLkMqS9
        Poch9tQmRJ40FkhIc2qjhLw1VtAk15FJkZ7XZxjSmplFkeSmbxSp+sot9eDK8soQV6e3ybhr
        xTO5whu9Es5oSGG47o4bDHcrt0zG9d98xnBnqg2Isxt9Nsi3ypdo+KjIeF43J3inPOLdy1N0
        7CWfQ9b0l9JE1OlxErmxgOeD3nRfchLJWSUuRpB4t941OBC8s3S6BjuCUvt19M/SW1lLiYsi
        BF0ZFloc+hDYsp/LnKpxeCHct10YcYzHayDN+IVxiiicT8HVy9a/IpZlsD+YDPudGhpPhycZ
        ZsaJJ+AQaHp1ccSrwB7QktVDO+VuOBi6b2ucNIU9wdqTLxHxFKjtyxkJBPgiC6eOfXd546G/
        vIMWU6+AptzHlIjHwYfmapmIJ8FwnfgQYAEeJhsYER+BEy0ml2Yx3GlukzozUNgPKurniPQy
        +JiVPUIDdoeuPg8xjjuk15ynRFoByUlKUT0Dqk+3ug5NhKKyc7KzSKUf1VE/qph+VDH9/7sF
        iDYgTz5O0IbzQmA0f9BfUGuFuOhw/90xWiP6+xEfDDU7TKj+9y4zwixSjVUUpN0KU0rV8UKC
        1oyApVTjFQV7G8OUCo064TCvi9mhi4viBTPyZmmVp+JKXlWYEoerD/D7eD6W1/3bSlg3r0QU
        aVo+8cVO7+e9axKPDoUG8UMBG0O767b/UGnuxRS9DdEE2Ts35mzr/DVoWTU1MLvDuiDlRJFt
        HeRssqPY+EyrV3c257s5wmuw0jKQPqskbXhMr9+LEveGJGZti2+LvXbaBG2kI7x80WFjw3fc
        0G5emTGwft654NUJbyyOLe+p0jYVLUSoA2ZSOkH9BxoDFc2EAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42I5/e/4Pd3U7APRBnu6xSx+vZvJbrFxxnpW
        i3mfZS3mX7nGatG8eD2bxdSDvUwW/1bNZbO4vGsOm8Xn3iOMFpcOLGCyON57gMni6ab1LBZz
        v0xltnjysI/N4sLUmcwWHUe+MVts/OrhIOixZt4aRo+ds+6ye2xeoeWxeM9LJo9NqzrZPO5c
        28PmsX/uGnaP9/uusnn0bVnF6PF5k1wAV5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6h
        sXmslZGpkr6dTUpqTmZZapG+XYJexrN73SwFi+Qqbk26x9rAeF2wi5GTQ0LAROLlhu3MXYxc
        HEICSxklLt6/zwqREJOYtG87O4QtLPHnWhcbRNFrRom/n/cygiSEBcwlTt2dAWaLCPhI9G/6
        BFbELDCfWaLv9S9GiI57zBI3n18FGsvBwSagJ7FjVSFIA6+Am0T7/clgzSwCqhKXJh9iA7FF
        BSIkVi9/wQpRIyhxcuYTFpBWTgE7iTsHU0DCzAJmEvM2P2SGsMUlbj2ZzwRhy0tsfzuHeQKj
        0Cwk3bOQtMxC0jILScsCRpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgUlg27GfW3Ywdr0L
        PsQowMGoxMP7Y+L+aCHWxLLiytxDjBIczEoivAuyDkQL8aYkVlalFuXHF5XmpBYfYjQF+m0i
        s5Rocj4wQeWVxBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCUamBcvnHr
        8YXbFs0MVEhkDOlT/VGtw1jDpusnx2k8s3mNo0s54wO7dXnnTyw2CS4SUuBr47lYXSZd0T/j
        qNf5L6/2J3MYzXu9ZXbNcd11GWXc77/mt3sd1C66sVbkXUEWi93nrBkV1ou/iO14NKee13ui
        vJFblcC/QMVJP1cInLuuL7083tBA7oISS3FGoqEWc1FxIgDNbDbCGAMAAA==
Message-Id: <20181012093741eucas1p26a54ad3091e4ba2468f61083c64749db~c0ubdFqkD3034330343eucas1p2R@eucas1p2.samsung.com>
X-CMS-MailID: 20181012093741eucas1p26a54ad3091e4ba2468f61083c64749db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336
References: <CGME20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336@epcas1p4.samsung.com>
        <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
        <20181010153553eucas1p1b8f74f4aa45751ef029805fd118affc1~cSUmU58-F2963929639eucas1p1L@eucas1p1.samsung.com>
        <e2091e7e-b6e6-950d-ebab-18ba2de9264f@linaro.org>
        <20181011073510eucas1p100bfadd6055a523cd1e92b07bfacfc10~cfaLHcbIo1401014010eucas1p1d@eucas1p1.samsung.com>
        <f099ded8-e074-da18-2eac-e07a5a99af18@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/11/2018 10:23 AM, Daniel Lezcano wrote:
> On 11/10/2018 09:35, Lukasz Luba wrote:
>> Hi Daniel,
>>
>> On 10/10/2018 06:54 PM, Daniel Lezcano wrote:
>>> On 10/10/2018 17:35, Lukasz Luba wrote:
>>>> Hi Thara,
>>>>
>>>> I have run it on Exynos5433 mainline.
>>>> When it is enabled with step_wise thermal governor,
>>>> some of my tests are showing ~30-50% regression (i.e. hackbench),
>>>> dhrystone ~10%.
>>>>
>>>> Could you tell me which thermal governor was used in your case?
>>>> Please also share the name of that benchmark, i will give it a try.
>>>> Is it single threaded compute-intensive?
>>>
>>> aobench AFAICT
>>>
>>> It would be interesting if you can share the thermal profile of your board.
>>>
>> Thanks for the benchmark name.
>> It was tested on Samsung TM2 device with Exynos 5433 with debian.
>> Thermal stuff you can find in mainline:
>> arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
> 
> By thermal profile, I was meaning a figure with the temperature
> regulation (temperature idle, then workload, then temperature increase,
> mitigated temperature, end of workload, temperature decrease).
Currently, I cannot share these data.
> 
> The thermal description looks wrong in the DT. I suggest to experiment
> the series with the DT fixed.

Could you tell more what looks wrong or maybe send a draft/patch?
> eg. from hi6220.dtsi
> 
> 
>                  thermal-zones {
> 
>                          cls0: cls0 {
>                                  polling-delay = <1000>;
>                                  polling-delay-passive = <100>;
>                                  sustainable-power = <3326>;
> 
>                                  /* sensor ID */
>                                  thermal-sensors = <&tsensor 2>;
> 
>                                  trips {
>                                          threshold: trip-point@0 {
>                                                  temperature = <65000>;
>                                                  hysteresis = <0>;
>                                                  type = "passive";
>                                          };
> 
>                                          target: trip-point@1 {
>                                                  temperature = <75000>;
>                                                  hysteresis = <0>;
>                                                  type = "passive";
>                                          };
>                                  };
> 
>                                  cooling-maps {
>                                          map0 {
>                                                  trip = <&target>;
>                                                  cooling-device = <&cpu0
> THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>                                          };
>                                  };
>                          };
>                  };
> 
> Note the cooling devices are *passive*
> 
>
For me this DT looks like it is copied from ARM Juno board for IPA,
where AFAIR there were no interrupts for the temperature sensor
(due to some psci/scpi/firmware lack of support).
The cooling map is also short. I am not sure if it would work efficient
with step-wise, with IPA it will work.

The DT configuration for Exynos has been working OK for years.
Exynos5433 supports 8 trip points, Exynos5422 has 4.
So if you have more trip points you need to start 'polling'.
Therefore, for Exynos there is no need to run queued work
in thermal framework every 1s or 100ms just to
read the current temperature.
The exynos-tmu driver gets irq and calls thermal framework
when such trip point is crossed. Then there is 'monitoring
window' for the trip point...
Long story short: 'active' is used for that reason.

Regards,
Lukasz

