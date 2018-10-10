Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6EBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644C321479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nB2JBzQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644C321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeJJRSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:18:07 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37705 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeJJRSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:18:07 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181010095641euoutp01c45e4c3a8eeba0f11488d7dc77725a81~cNscOkMKW1826918269euoutp01F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 09:56:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181010095641euoutp01c45e4c3a8eeba0f11488d7dc77725a81~cNscOkMKW1826918269euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539165401;
        bh=gtSICDYTnrhsN3Nzo/rhS2HhO+ZJHodZuOgy+WiUPGE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nB2JBzQHJB1SIfBOBMwt8KtkYQY3+gF40tlLd+B6XMeTe3WA60fx+ZTqaLBvwF+tQ
         q1xvY+a4omHUDBjNl3Lsb4Y1kadjbmwoYKGuFD0dZvWyPtxz/EGjuQ5BdjngEQsHBc
         ytqQEegGEaV+7ERmZeHR2Cnh1HHY/f0Gbj7+yw+w=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181010095640eucas1p284514ec33d8c7ad45932c01cdf0400bc~cNsbfwk102622526225eucas1p23;
        Wed, 10 Oct 2018 09:56:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C4.D6.04806.8DCCDBB5; Wed, 10
        Oct 2018 10:56:40 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181010095639eucas1p2aa4f4906cac34deb0cfb14383199e3c5~cNsaskok62622626226eucas1p2n;
        Wed, 10 Oct 2018 09:56:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181010095639eusmtrp1da63b1e5b66173ae99833787442250e4~cNsabpz6U2963229632eusmtrp1Y;
        Wed, 10 Oct 2018 09:56:39 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-d4-5bbdccd8d1ee
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E6.B7.04284.7DCCDBB5; Wed, 10
        Oct 2018 10:56:39 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181010095638eusmtip2c3fe9713cc88a5beb818df0ccbb5921e~cNsaH_de73093330933eusmtip2M;
        Wed, 10 Oct 2018 09:56:38 +0000 (GMT)
Subject: Re: [PATCH] config: arm: exynos: remove PROVE_LOCKING from
 defconfig
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Lukasz Luba <l.luba@partner.samsung.com>
Date:   Wed, 10 Oct 2018 11:56:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPeSLxeHR-n0yAqbYMi4y9sZhX0Omk=C6-8du7x27X4aWA@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djP87o3zuyNNuhfy2axccZ6Vov+x6+Z
        Lc6f38BusenxNVaLy7vmsFmsPXKX3YHNY9OqTjaPzUvqPfq2rGL0+LxJLoAlissmJTUnsyy1
        SN8ugStj2f2zbAW3RCo6tj1lbWB8KNDFyMkhIWAicaFxE1sXIxeHkMAKRolXfa9ZIZwvjBJv
        3y1hBKkSEvjMKHG4kQOmY97Ow8wQRcsZJdb83cgGUfSWUeLf+QgQW1jAX+LJteVgzSICmhLX
        /34Hm8oscIdR4vn+xUAJDg42AT2JHasKQWpYBFQlpu3exQxiiwpESBx5sBCsl1dAUOLkzCcs
        IDanQKDE81ermEBsZgFxiVtP5kPZ8hLb385hhjhuFbvE/AnCEL1lEusmNzNBxF0knnXugbKF
        JV4d38IOYctInJ7cwwJhF0uc7VjFBmHXSLSf3AFVYy1x+PhFVpCTmYF+Wb9LHyLsKPGp5wjY
        JxICfBI33gpCXMMnMWnbdGaIMK9ER5sQRLWGxJaeC1AHiEksXzONfQKj0iwkP85C8tcsJH/N
        Qti7gJFlFaN4amlxbnpqsXFearlecWJucWleul5yfu4mRmCaOf3v+NcdjPv+JB1iFOBgVOLh
        bbiwJ1qINbGsuDL3EKMEB7OSCO+tw3ujhXhTEiurUovy44tKc1KLDzFKc7AoifMum7cxWkgg
        PbEkNTs1tSC1CCbLxMEp1cB4YnbjJreLn9eflA+bZVf+UEyVcVtlFn9eZOnp5js3ikVZxCNZ
        Qhg3uz1a3rEsX5Sx59jXD5Wna6qYHs+pkZW5vLHu2zWDF7teOjnrzzhmdqm9efJ8qVsdr1iC
        MxY9XZLNliczbYeYie/FxrfL/b4YReX4xO3YPe/eRVl9aUY2Bbb/DNPzflUpsRRnJBpqMRcV
        JwIAuL4/fS8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xe7rXz+yNNvg+ld9i44z1rBb9j18z
        W5w/v4HdYtPja6wWl3fNYbNYe+QuuwObx6ZVnWwem5fUe/RtWcXo8XmTXABLlJ5NUX5pSapC
        Rn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Gsvtn2QpuiVR0bHvK
        2sD4UKCLkZNDQsBEYt7Ow8xdjFwcQgJLGSX6Nh1nhUiISUzat50dwhaW+HOtiw2i6DWjxP81
        9xhBEsICvhLH/p0GaxAR0JS4/vc7K0gRs8AdRomdTxZDdUxkkpi+8R5TFyMHB5uAnsSOVYUg
        DbwCbhJvHtxlA7FZBFQlpu3exQxiiwpESKxe/oIVokZQ4uTMJywgNqdAoMTzV6uYQGxmATOJ
        eZsfMkPY4hK3nsyHistLbH87h3kCo9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xYZ6xYm5
        xaV56XrJ+bmbGIERtu3Yz807GC9tDD7EKMDBqMTD23BhT7QQa2JZcWXuIUYJDmYlEd5bh/dG
        C/GmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MPrzSuINTQ3NLSwNzY3Njc0slMR5zxtURgkJ
        pCeWpGanphakFsH0MXFwSjUwurcrtR3//lPvsXrtr2mTJt0KtNJuYOPwjHm8a8H7Gd8jeNVu
        l11sa2HqiXwcvsBx8+Y9orsL3lTK5bubaWxtWL/vT9lb97m3l3r2rRI/YzWZ7/EOzoO7Xm8L
        NDjapL6PyaLL8ZN9l+exf7o3mdaLnA7ZduDtr6cJLfp+c6f85xcO+ZoQ3l2TrMRSnJFoqMVc
        VJwIAEJwSm7GAgAA
Message-Id: <20181010095639eucas1p2aa4f4906cac34deb0cfb14383199e3c5~cNsaskok62622626226eucas1p2n@eucas1p2.samsung.com>
X-CMS-MailID: 20181010095639eucas1p2aa4f4906cac34deb0cfb14383199e3c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009153439eucas1p19956dc093074fb7603ad4b39d7cd215a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009153439eucas1p19956dc093074fb7603ad4b39d7cd215a
References: <CGME20181009153439eucas1p19956dc093074fb7603ad4b39d7cd215a@eucas1p1.samsung.com>
        <20181009153439eucas1p19956dc093074fb7603ad4b39d7cd215a~b_qPT4nMA1415514155eucas1p16@eucas1p1.samsung.com>
        <CAJKOXPeSLxeHR-n0yAqbYMi4y9sZhX0Omk=C6-8du7x27X4aWA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Is it still valid that the Exynos has locking issues?
Or is it enabled 'just-in-case'?
On arm64 the config misses that setting.
Should be enabled there as well?
You have introduced this entry a year ago, probably during bug 
investigation.

The issue is in lockdep, the setting which enables it in Exynos
is prove_locking. For now, just get rid of the second.
My tests showed lockdep impact and not other minor debug features
enabled.

Regards,
Lukasz

On 10/10/2018 11:18 AM, Krzysztof Kozlowski wrote:
> On Tue, 9 Oct 2018 at 17:34, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> PROVE_LOCKING enables LOCKDEP, which causes big overhead on cache and
>> bus transactions.
>>
>> On some ARM big.LITTLE architecutres (Exynos 5433) the overhead is really big.
>> The overhead can be measures using hackbench test which will speed up
>> by x3 times (11sec -> 3.4sec).
>> When you check transaction on cache or buses, the results are way higher
>> than normal for the same hackbench test:
>> L1d cache invalidations: 26mln vs 4mln
>> L2u cache invalidations: 42mln vs 12mln
>> bus cyc/access: 30cyc/access vs. 20cyc/access
>> context switch is x3 times cheaper
>>
>> Enable this option only when you have some locking issue to investigate.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   arch/arm/configs/exynos_defconfig | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
>> index 27ea6dfc..fbf52f3 100644
>> --- a/arch/arm/configs/exynos_defconfig
>> +++ b/arch/arm/configs/exynos_defconfig
>> @@ -324,7 +324,6 @@ CONFIG_MAGIC_SYSRQ=y
>>   CONFIG_DEBUG_KERNEL=y
>>   CONFIG_SOFTLOCKUP_DETECTOR=y
>>   # CONFIG_DETECT_HUNG_TASK is not set
>> -CONFIG_PROVE_LOCKING=y
> 
> You just disabled all debugging around locks (so also basic checks).
> You did not describe this in the message... and it also makes me
> wonder what were you testing? Kernel without any lock debugging (so
> this patch) or kernel without lockdep only (not this patch).
> 
> As for the reason behind this change, I am not sure. We had locking
> issues and this change really helped us to spot them. Most of the
> issues are solved so maybe this is not needed anymore but on the other
> hand - this is development/debugging config, not a distro-ready. It
> might serve as a reference for distro configs but clearly it is not
> for production.
> 
> Best regards,
> Krzysztof
> 
>>   CONFIG_DEBUG_ATOMIC_SLEEP=y
>>   CONFIG_DEBUG_USER=y
>>   CONFIG_CRYPTO_RSA=m
>> --
>> 2.7.4
>>
> 
> 
