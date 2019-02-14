Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F19DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1292321B1A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Mi849S4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395396AbfBNDtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:49:46 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:50091 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387562AbfBNDtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:49:45 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190214034942epoutp01d185c440801cb9931683a30b8eae204b~DHnRsvmel2809528095epoutp01i
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 03:49:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190214034942epoutp01d185c440801cb9931683a30b8eae204b~DHnRsvmel2809528095epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550116182;
        bh=+FlN4TrELWk62V0opIWTvR9r+o/knFWJtr6LKmr8cbw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Mi849S4VshZk0qMc3r5Q2r25VJW0gibq61Nn2zig1K0KXAjDwA46tZ1AZhoqf3uuX
         hvFgEZHAzyM+fWpsHsACCM6BKH6i64mBWWzaqWsUQeS0l5BbA77GMsWErZ+0Nfk0pu
         i7cYBBKumFCKA/2l8SgckEclObPpXtYH7YaVujRw=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190214034939epcas1p390a7ea2330b96e083ac338b920bd7625~DHnPDqeSm2904529045epcas1p3W;
        Thu, 14 Feb 2019 03:49:39 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.64.04074.355E46C5; Thu, 14 Feb 2019 12:49:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190214034938epcas1p455b53b20fd2e4f01876dba2d1b8c5ffe~DHnOoNCsX1913819138epcas1p4H;
        Thu, 14 Feb 2019 03:49:38 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190214034938epsmtrp2c82124e8220b81608bc9a31ac6558960~DHnOnACY32339123391epsmtrp2I;
        Thu, 14 Feb 2019 03:49:38 +0000 (GMT)
X-AuditID: b6c32a35-297ff70000000fea-57-5c64e5535ab1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.69.03601.255E46C5; Thu, 14 Feb 2019 12:49:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190214034938epsmtip1593510c0efc24157fc076d79a66007e0~DHnOVcIG-2753127531epsmtip17;
        Thu, 14 Feb 2019 03:49:38 +0000 (GMT)
Subject: Re: [PATCH] devfreq: Use of_node_name_eq for node name comparisons
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <5cc4b5a3-c4ad-46a9-2856-3ed67c6755d3@samsung.com>
Date:   Thu, 14 Feb 2019 12:49:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+xpRPvj=UcSo+jQKX1pB=9B3SV9jB5ZVhaVsKvOqtoOg@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmrm7w05QYg59LuS3mHznHatH/+DWz
        xfnzG9gtzja9YbfY9Pgaq8XlXXPYLD73HmG0mHF+H5PF7cYVbBb/9+xgd+Dy2LSqk81j85J6
        j74tqxg9Pm+SC2CJyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy
        8QnQdcvMAbpHSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBXnJhbXJqXrpec
        n2tlaGBgZApUmJCd8XffccaC/SIVE1f3sDcwPuXvYuTgkBAwkZj93LCLkYtDSGAHo8Tl891M
        EM4nRolnvzvZuhg5gZxvjBJPO/NAbJCG3R+3skEU7WWUuDl7BlTHe0aJf62LWECqhAW8JTY/
        6WAFsUUE6iT6dl9gBSliFnjPJDH7/n+wsWwCWhL7X9wAs/kFFCWu/njMCGLzCthJ3P71nx3E
        ZhFQlfj9ewlYjahAhMTh3ndQNYISJ2c+AVvGKRAosXPiXbA4s4C4xK0n85kgbHmJ5q2zmSHO
        bmaXeLMoHcJ2kXhy5TkLhC0s8er4FnYIW0ri87u9bBB2tcTKk0fA3pQQ6GCU2LL/AitEwlhi
        /9LJTKDAYxbQlFi/Sx9iF5/Eu689rJAw5ZXoaBOCqFaWuPzgLhOELSmxuL0TaryHxJ+Vnxkn
        MCrOQvLNLCQfzELywSyEZQsYWVYxiqUWFOempxYbFhgiR/YmRnBS1TLdwTjlnM8hRgEORiUe
        3gqhlBgh1sSy4srcQ4wSHMxKIry7HwGFeFMSK6tSi/Lji0pzUosPMZoCA3sis5Rocj4w4eeV
        xBuaGhkbG1uYGJqZGhoqifOud3COERJITyxJzU5NLUgtgulj4uCUamDccsRhctibO0XV92eq
        BRxwELFi8j7llDqxJTIr6WO5zZYtt8sOqZsmmHRqZL1zuDmPLYt/TYNUSeRrV48uz3Uzmjfp
        RIhG1M3pFFzLkbZpVvzPFbEvPyzbkN3xIrdj24Sj7FsumlZMrJW3/PdzfW/VJZeXjuKfJX1u
        ftKo6pOt+rQiXrpmwm4lluKMREMt5qLiRABmlt1BwAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnG7Q05QYg2uTtC3mHznHatH/+DWz
        xfnzG9gtzja9YbfY9Pgaq8XlXXPYLD73HmG0mHF+H5PF7cYVbBb/9+xgd+Dy2LSqk81j85J6
        j74tqxg9Pm+SC2CJ4rJJSc3JLEst0rdL4Mr4u+84Y8F+kYqJq3vYGxif8ncxcnJICJhI7P64
        la2LkYtDSGA3o8SCK5MZIRKSEtMuHmXuYuQAsoUlDh8uhqh5yyjx+sEsJpAaYQFvic1POlhB
        bBGBOolNy74xgxQxC3xkklg96yYrRMc5RomF99vYQarYBLQk9r+4wQZi8wsoSlz98RhsG6+A
        ncTtX//BalgEVCV+/14CViMqECHx8ek+JogaQYmTM5+wgNicAoESOyfeBetlFlCX+DPvEjOE
        LS5x68l8JghbXqJ562zmCYzCs5C0z0LSMgtJyywkLQsYWVYxSqYWFOem5xYbFhjlpZbrFSfm
        Fpfmpesl5+duYgTHmJbWDsYTJ+IPMQpwMCrx8CoIpMQIsSaWFVfmHmKU4GBWEuHd/QgoxJuS
        WFmVWpQfX1Sak1p8iFGag0VJnFc+/1ikkEB6YklqdmpqQWoRTJaJg1OqgTGMp/DbmgDx0xIN
        U+6+8EsvfJldUNC4mGWd8d4jRcdeP/9wlqWsmmX//Yg4RctNfxctNPnJFaEUEKh47vik2Ud6
        LQJYLun/c2GftfHOg3+5s36yL8xuPtp5Ucjmp/mE02tZC+6cUf+w9dyjRz8Psv+u3TLfS7K4
        6NfiuAPBm9x8TDwtl/47Pv21EktxRqKhFnNRcSIAexXXBq0CAAA=
X-CMS-MailID: 20190214034938epcas1p455b53b20fd2e4f01876dba2d1b8c5ffe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190213161024epcas3p3acc5c074714ad1d44fb90ab3f21cfcff
References: <20181205195050.4759-6-robh@kernel.org>
        <CGME20190213161024epcas3p3acc5c074714ad1d44fb90ab3f21cfcff@epcas3p3.samsung.com>
        <CAL_Jsq+xpRPvj=UcSo+jQKX1pB=9B3SV9jB5ZVhaVsKvOqtoOg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 19. 2. 14. 오전 1:09, Rob Herring wrote:
> On Wed, Dec 5, 2018 at 1:50 PM Rob Herring <robh@kernel.org> wrote:
>>
>> Convert string compares of DT node names to use of_node_name_eq helper
>> instead. This removes direct access to the node name pointer.
>>
>> For instances using of_node_cmp, this has the side effect of now using
>> case sensitive comparisons. This should not matter for any FDT based
>> system which all of these are.
>>
>> Cc: Chanwoo Choi <cw00.choi@samsung.com>
>> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>> Cc: linux-pm@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-samsung-soc@vger.kernel.org
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>  drivers/devfreq/devfreq-event.c     | 2 +-
>>  drivers/devfreq/event/exynos-ppmu.c | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Can someone apply this please.

Myungjoo picked up this patch[1] on devfreq.git
but has not yet sent the pull request.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git/commit/?h=for-next&id=0c1e8ce295acc3becc95e393e88a9a6da233074f

> 
>>
>> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
>> index d67242d87744..87e93406d7cd 100644
>> --- a/drivers/devfreq/devfreq-event.c
>> +++ b/drivers/devfreq/devfreq-event.c
>> @@ -240,7 +240,7 @@ struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(struct device *dev,
>>         }
>>
>>         list_for_each_entry(edev, &devfreq_event_list, node) {
>> -               if (!strcmp(edev->desc->name, node->name))
>> +               if (of_node_name_eq(node, edev->desc->name))
>>                         goto out;
>>         }
>>         edev = NULL;
>> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
>> index c61de0bdf053..c2ea94957501 100644
>> --- a/drivers/devfreq/event/exynos-ppmu.c
>> +++ b/drivers/devfreq/event/exynos-ppmu.c
>> @@ -529,7 +529,7 @@ static int of_get_devfreq_events(struct device_node *np,
>>                         if (!ppmu_events[i].name)
>>                                 continue;
>>
>> -                       if (!of_node_cmp(node->name, ppmu_events[i].name))
>> +                       if (of_node_name_eq(node, ppmu_events[i].name))
>>                                 break;
>>                 }
>>
>> --
>> 2.19.1
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
