Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919B9C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B992075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="c6efbC+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfBKMWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:22:35 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53566 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfBKMWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:22:34 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190211122232euoutp010a59aa566b46a07273efad67afe12337~CTrL_N6kQ3194631946euoutp01O
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 12:22:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190211122232euoutp010a59aa566b46a07273efad67afe12337~CTrL_N6kQ3194631946euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549887752;
        bh=FEymqXMagb8tOAk1L8rW9QWxJeADpSQGMvDaz3bgrAA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=c6efbC+A5nF1kTIle7HCvtqXIkc15DP5HtTeMVmlCS8wl0pW0JkXFJdmo7GLyJI8/
         uw4/MOMOvaUo5qoscmdgFqSBhwR2bGZpEjVKfQ0QvGt/AdI8ttqg/9t4uY49hL+EIV
         F5lgaHk6Tz6JHUsIdLjZ2NOdWUOo8hRL6Rw70mew=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190211122231eucas1p2f51155f16314ebf15debba010f1dd737~CTrLMnq-p0488704887eucas1p2f;
        Mon, 11 Feb 2019 12:22:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E2.DC.04441.709616C5; Mon, 11
        Feb 2019 12:22:31 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190211122230eucas1p1322a19c1ae5bd583fc4940a5cd9e4d43~CTrKLdKkz3022830228eucas1p1l;
        Mon, 11 Feb 2019 12:22:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190211122230eusmtrp23b9e09218f9d6840165e8cc080fdd438~CTrJ8yEHl2466224662eusmtrp2b;
        Mon, 11 Feb 2019 12:22:30 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-67-5c616907887a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 61.66.04128.609616C5; Mon, 11
        Feb 2019 12:22:30 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190211122229eusmtip21be096dcd7fb038a9dfe4c617623161b~CTrJIAe510083400834eusmtip2q;
        Mon, 11 Feb 2019 12:22:29 +0000 (GMT)
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>, Sudeep.Holla@arm.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <f9f54181-f7bc-6add-2c06-2ed3d6410d01@samsung.com>
Date:   Mon, 11 Feb 2019 13:22:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190211095527.5brreiqppn7kk3yt@vireshk-i7>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djP87rsmYkxBsfbhSw2zljPanHzawer
        xeVdc9gsPvceYbSYcX4fk8WbH2eZLM6cvsRq8e/aRhaL5ad2sFhs/OphsfLELGYHbo8189Yw
        emxa1cnmcefaHjaPLVfbWTz6tqxi9Dh56gmLx/Eb25k8Pm+SC+CI4rJJSc3JLEst0rdL4MqY
        9e4xU8FLrop9k9exNjB+4ehi5OSQEDCRaH69haWLkYtDSGAFo8TxfbegnC+MEm+WTGOCcD4z
        Sux+/oIVpuXlnr1sEInljBIHnr5hh3DeM0qcbz8NViUs4CrxrPkMUIKDQ0RAS+LlzVSQGmaB
        20wSW5o/MIHUsAkYSnS97WIDqeEVsJOYe1wbJMwioCrRfecLO4gtKhAjMeXcETCbV0BQ4uTM
        JywgNqeApcTsGRfBbGYBeYntb+cwQ9jiEreezAe7WkLgJbtEz/V/TCDzJQRcJDbsZ4F4QFji
        1fEt7BC2jMT/nTD1zYwS7TNmsUM4PYwSW+fsYIOospY4fPwiK8ggZgFNifW79CHCjhKnDq9k
        g5jPJ3HjrSDEDXwSk7ZNZ4YI80p0tAlBVKtJzDq+Dm7twQuXmCcwKs1C8tksJN/MQvLNLIS9
        CxhZVjGKp5YW56anFhvmpZbrFSfmFpfmpesl5+duYgSmsdP/jn/awfj1UtIhRgEORiUe3g+J
        CTFCrIllxZW5hxglOJiVRHhDfRNjhHhTEiurUovy44tKc1KLDzFKc7AoifNWMzyIFhJITyxJ
        zU5NLUgtgskycXBKNTCqchyesuKbzNrpATuPNBr/t7t8z3Pp41Mp/seuTJzopiT1uvPZFHfj
        Fw/jw1tTbG/kr3zxqmDFG+Pgvy+P5zTy6egK2VjtzdzH8v3e7zen77rMn51ccP7XsvVH/zNz
        Kbsf/KgSwJBRkrbcZPNc496p+1zu3pcysKvkEuN66vZ6I+duDoluU5EOJZbijERDLeai4kQA
        QoH1TV8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsVy+t/xe7psmYkxBpPWcVtsnLGe1eLm1w5W
        i8u75rBZfO49wmgx4/w+Jos3P84yWZw5fYnV4t+1jSwWy0/tYLHY+NXDYuWJWcwO3B5r5q1h
        9Ni0qpPN4861PWweW662s3j0bVnF6HHy1BMWj+M3tjN5fN4kF8ARpWdTlF9akqqQkV9cYqsU
        bWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJcx691jpoKXXBX7Jq9jbWD8wtHF
        yMkhIWAi8XLPXjYQW0hgKaPEjX3mEHEZiZPTGlghbGGJP9e6gGq4gGreMkos2r+BBSQhLOAq
        8az5DHsXIweHiICWxMubqSA1zAJ3mSSWT5/GDNGwhEmiacMEZpAGNgFDia63IJM4OHgF7CTm
        HtcGCbMIqEp03/kCNkdUIEbi6jlGkDCvgKDEyZlPwFZxClhKzJ5xEcxmFlCX+DPvEjOELS+x
        /e0cKFtc4taT+UwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/d
        xAiM2m3Hfm7Zwdj1LvgQowAHoxIP74fEhBgh1sSy4srcQ4wSHMxKIryhvokxQrwpiZVVqUX5
        8UWlOanFhxhNgX6byCwlmpwPTCh5JfGGpobmFpaG5sbmxmYWSuK85w0qo4QE0hNLUrNTUwtS
        i2D6mDg4pRoYxeWlH/gapL7nOzj30jTuvoX9j+amp0oXHjr6sz+4RXzy2YdCC2bOrzWLru7m
        ucUn0zjBO2Sr1qeKrsDkYv6DB3aLqgXvaZuwga9PO/t1wM7mRwvEls0I7DGNNNyjlqfUf1JA
        LM6EOUBY8/C9NKbzlzUqVAqauU8JvDPWvy719NDByWe7hRuUWIozEg21mIuKEwGremaK8AIA
        AA==
X-CMS-MailID: 20190211122230eucas1p1322a19c1ae5bd583fc4940a5cd9e4d43
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190207122255eucas1p1cdebed838c799eca46cce6a654a26187
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190207122255eucas1p1cdebed838c799eca46cce6a654a26187
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
        <20190207122227.19873-1-m.szyprowski@samsung.com>
        <20190211084413.b53qyx6sgkxsjhdv@vireshk-i7>
        <9b4a6c9a-93f9-474f-b8c0-4353a531e128@samsung.com>
        <20190211095527.5brreiqppn7kk3yt@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 2019-02-11 10:55, Viresh Kumar wrote:
> On 11-02-19, 10:52, Marek Szyprowski wrote:
>> On 2019-02-11 09:44, Viresh Kumar wrote:
>>> On 07-02-19, 13:22, Marek Szyprowski wrote:
>>>> Dear All,
>>>>
>>>> Recent commit 9ac6cb5fbb17 ("i2c: add suspended flag and accessors for
>>>> i2c adapters") added a visible warning for an attempt to do i2c transfer
>>>> over a suspended i2c bus. This revealed a long standing issue in the
>>>> cpufreq-dt driver, which gives a following warning during system
>>>> suspend/resume cycle:
>>> Marek,
>>>
>>> I have sent a patchset which is not directly related to the problem
>>> you are facing, but it may solve your problem as a side effect. Can
>>> you please see if that works to solve this issue as well ?
>>>
>>> https://lore.kernel.org/lkml/cover.1549874368.git.viresh.kumar@linaro.org/T/#u
>> Thanks for the patch. It indeed solves the problem of the i2c transfer
>> in cpu hotplug procedure during system resume, although my resources
>> management rewrite is still valid as a way to fix remaining 'todos' in
>> the cpufreq-dt driver.
> Which remaining todos are you talking about ? Sorry I am not able to
> recall :(

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/cpufreq/cpufreq-dt.c#n347

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

