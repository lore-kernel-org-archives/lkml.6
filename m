Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF21C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F76620866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="buCJjSA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F76620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406474AbeKWEZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:25:05 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52404 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389307AbeKWEZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:25:05 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181122174440euoutp0270bf64862d43d9e277c4a52eb13f69cc~pg0U307z91385513855euoutp02T
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 17:44:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181122174440euoutp0270bf64862d43d9e277c4a52eb13f69cc~pg0U307z91385513855euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542908680;
        bh=6OpKffNPyTf6bD7r1zmErLdYfZYZWIrSuKk926FurGo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=buCJjSA9Jm9+c7mMmRuBYjp6vbEZruFrCFnyuZTDFnfLpcBjnNf/MdhEW1SNhMw56
         mn3jvojmoOcQjEa/HkfexXqY4ZfeZ6mLXqoF7XY6ASvXSl0IOIngcQ+3wGLfLaIb87
         FSyiERTI9dlkc5pOqBa/i1B3RGA73dkMHw2lcKnU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181122174439eucas1p2c58b0daa8d45b78d1d868ab14b8f8f69~pg0TrV7Ve2468424684eucas1p2F;
        Thu, 22 Nov 2018 17:44:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id AE.16.04441.60BE6FB5; Thu, 22
        Nov 2018 17:44:39 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181122174438eucas1p13eb29eefa78d8555b967f05b1c4492f0~pg0SxiK8b0614206142eucas1p1j;
        Thu, 22 Nov 2018 17:44:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181122174438eusmtrp1a681e7f9cd7e46d3760ba31419a946d2~pg0SgenHw0757007570eusmtrp1H;
        Thu, 22 Nov 2018 17:44:38 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-f4-5bf6eb069e27
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DC.B8.04284.50BE6FB5; Thu, 22
        Nov 2018 17:44:37 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181122174437eusmtip26ed8396e46a651b65be9ccbfd81f89bc~pg0RmGZYf1886018860eusmtip2P;
        Thu, 22 Nov 2018 17:44:37 +0000 (GMT)
Subject: Re: [PATCH 0/6] devfreq: handle suspend/resume
To:     Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, rjw@rjwysocki.net, len.brown@intel.com,
        pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <36b5f798-e2ce-f23e-f469-98b5d385fcde@partner.samsung.com>
Date:   Thu, 22 Nov 2018 18:44:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1d9cf1b6-b625-4b6d-7578-0f02f7efdb8a@math.uni-bielefeld.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa1BMYRjHvedenDqtyz5Thpk1SJNcxvC6TMOMy2FMGD6Y+sDBmTLasKdy
        nVEkSbTurHWZZGRbqm1tuWVKFym2TRQmmcm4ZV2KjAnpdDL69nv+z/O+z///zsuROisTyK2P
        i5dNcVKsgfGlXJU/3ePZts6oiY8PE7j0+jhccCqPxkUFnTRu/PaWxufLH9F4z8U8BtceMOLM
        1jYSu935LH64+yOLLcfuENjR+pTGj29aGdxxsBzhU+4SAl8tb2bxpUYPgV8k5zC4+UFFz/ma
        ehrvvVPO4tTcLzT+WPeSmq0XXbdctGg/Z0fimSQPJZoz25F48fZ7QnTY9jPi3bN2VizM3iX+
        qWRF55N9lHjIaUNiTu4PVuxwjFjKR/rOWifHrk+UTRPCV/vGZFS8oTalBGy15zdTScjFpyOO
        A2EK5DUOTEe+nE7IQZBdW0lqxTcEpT9rGa3oQNBtzurp+PSe6D6dTGiNywgOfHWyWuFFcMOa
        TKv3DhamQdUvk6oPERoQtNxoptWCFH4T0JVewahDjBAGxbbNKvLCfPiVulhdQAmjoeh+CqHy
        UGElpLXkMirzQgBUn35NqewjLISuksJeJgU9PH99ntB4JBR5rb0RQGjioHWvg9Bcz4W3F47T
        Gg+GD1WqaZWHQ83RDEpjBR6m2RiNd8K+6uK+mZlwr8rTm4sUxkHezQmaPAc8Jc9J7Rn9oMkb
        oFnwgyOuk30yD2mpOm06GJwZdX1mhsFl+wnWjAyWfsEs/cJY+oWx/N97AVE2pJcTFGO0rEyK
        k7eEKZJRSYiLDlu70ehAPX+25k9VezH6Xr+mDAkcMgzi8ws6o3S0lKhsM5Yh4EjDEF681yPx
        66Rt22XTxlWmhFhZKUNBHGXQ8zsGvIrSCdFSvLxBljfJpn9dgvMJTEKRhd31jwI9wWOnTdx6
        9qQ0alTEklAcE/FuRpCVCAF7SuCeZzWJT/kBa/ymdu73Bs+cHHpcDCKq/a9lT5luHnNow61V
        rvBF/vE2d9ewYO+VtE+xI82hde7w5XfjI6XCNqn9y65l+vE5DdHzVizIzM9qcSVds7icDe+r
        F9RHlIZ8bjpjoJQYaVIIaVKkv3wg0aevAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRiA+8591YHj1Pyy+7Af3WbHpfsMk4KIY0QkQYUWebCDk5zTnRkZ
        RFpmZTcLf9gqlSywuXKbNkellbdu2tRMxdSItAiNIkMtNdtagf+e9/K8Ly+8DK60kcFMcqpJ
        MqaKKSpqNvHy99P+NdTQaPzaCgV6cm8FshdWkKjaPkqirh+fSFTc8IpEJ0orKNR8Vo8ufhjC
        kdtto1HL8WEamQtqMOT40Emi1/evUWjkfANAhe5aDN1p6KPRra42DL3NLqNQ34tGj/+ynUQn
        axpolFv+jUTDrf3ExiDB+cBJCtYiKxCuZrURQv7F70AoffgZExyWM5Tw6LqVFipvHhN+N9FC
        1ZtThHChygKEsvIxWhhxLN7BxqmjjIYMk7RUZ5BNG1TxPApT85FIHbYuUs1rtPvWh4WrQqOj
        DkgpyYckY2h0glp3rvEjkZbjd9hq6yOygJPNAwoGcuvg9JVsLA/MZpTcLQDzmwcoX2EevFxb
        TfvYH0525lG+piEApztPkHmAYfw5LXw6afTmA7gOALsGe2lvgHNTGBwsGv83tg9A+3A35TUo
        Tg1dlnQvstwWOJm7zbuA4JbD6mc5mJcDuT2w5fNd4GWW84PPrwwQXlZwMXCitvIv41wELKp8
        j/s4CPYMFGM+XgKrv1zD84HSPEM3z1DMMxTzDKUEEBYQIGXI+iS9zKtlUS9npCapEw16B/B8
        i7PpZ6ULtNt31gGOAaq5rM0+Gq8kxUNypr4OQAZXBbBCvSfFHhAzj0hGw35jRook14Fwz3GX
        8ODARIPn91JN+/lwXosiea1Gq4lAqiDWvTYzTskliSbpoCSlScb/HsYogrNAYdCmBTtibmpO
        t8aK7hDhsbmkXeekTh+zTDQtdBV0TAC/3BzXopieLV82d7qnxH77O7r7RtXWcXtJ95Q76t2D
        wPie2Pze0FXmX7umb4/NaTlTUVr7aX7s9vrzxx3LvkWHJH+dSBiJWFBq47dpCvfutrLm5lkF
        oSOrx9YrGs8ejU5XEbJO5FfiRln8A26t3KZDAwAA
X-CMS-MailID: 20181122174438eucas1p13eb29eefa78d8555b967f05b1c4492f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181121180156eucas1p225af7f4341a039264ff26f2a9ad9bb12
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181121180156eucas1p225af7f4341a039264ff26f2a9ad9bb12
References: <CGME20181121180156eucas1p225af7f4341a039264ff26f2a9ad9bb12@eucas1p2.samsung.com>
        <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <1d9cf1b6-b625-4b6d-7578-0f02f7efdb8a@math.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobias,

On 11/22/18 6:24 PM, Tobias Jakobi wrote:
> Hey Lukasz,
> 
> just wanted to say hi and thanks for picking this up. Sadly my work no longer
> permits me to spend time working on the kernel.
Fingers crossed for your current work and maybe for come back to kernel
development in the future!
> 
> Anyway, great that this issue finally gets solved! :)
Thank you for your idea and development of these patches in v1 and v2.
This functionality is really needed.

Regards,
Lukasz

> 
> With best wishes,
> Tobias
> 
> 
> Lukasz Luba wrote:
>> Hi all,
>>
>> This patch set aims to address the issue with devfreq devices' frequency
>> during suspend/resume. It extends suspend/resume by calls to Devfreq
>> framework. In the devfreq framework there is a small refactoring to avoid
>> code duplication in changging frequency (patch 2) and there are extensions
>> for suspending devices.
>>
>> It has been tested on Odroid u3 with Exynos 4412.
>>
>> The patch set draws on Tobias Jakobi's work posted ~2 years ago, who tried
>> to solve issue with devfreq device's frequency during suspend/resume.
>> During the discussion on LKML some corner cases and comments appeared
>> related to the design. This patch set address them keeping in mind
>> suggestions from Chanwoo Choi.
>> Tobias's paches:
>> https://www.spinics.net/lists/linux-samsung-soc/msg56602.html
>>
>> Regards,
>> Lukasz Luba
>>
>> Lukasz Luba (6):
>>    devfreq: add basic fileds supporting suspend functionality
>>    devfreq: refactor set_target frequency function
>>    devfreq: add support for suspend/resume of a devfreq device
>>    devfreq: add devfreq_suspend/resume() functions
>>    drivers: power: suspend: call devfreq suspend/resume
>>    arm: dts: exynos4: set opp-suspend for DMC and leftbus
>>
>>   arch/arm/boot/dts/exynos4210.dtsi |   2 +
>>   arch/arm/boot/dts/exynos4412.dtsi |   2 +
>>   drivers/base/power/main.c         |   3 +
>>   drivers/devfreq/devfreq.c         | 159 ++++++++++++++++++++++++++++++--------
>>   include/linux/devfreq.h           |  11 +++
>>   5 files changed, 146 insertions(+), 31 deletions(-)
>>
> 
> 
> 
