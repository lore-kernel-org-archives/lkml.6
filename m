Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31065C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4082086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UW2P0Lru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4082086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbeJLTlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:41:05 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53147 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbeJLTlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:41:05 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181012120852euoutp01623dbe386a55023773287135da9f5bb1~c2ybgJT3l0633506335euoutp01f
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 12:08:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181012120852euoutp01623dbe386a55023773287135da9f5bb1~c2ybgJT3l0633506335euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539346132;
        bh=Dk5j5dg6F3QSPMYu3zZY+GQAYeNUqecqVq4sZrQC11w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=UW2P0LruTv02KBRHtO8poAbKCcqVCb3bCFAVlUInVJqFJn2H36vlllolBihfPLZo+
         TDMPo3oY8BEvIrjBmFPIS1o0apX/EIG/Z8aLICFZJ8XaAqNcR4LabWaMEJEkmSUw50
         WlphhusBY8foKn5TdCs+AY5Wi3Rj0ZtNkoydSIe4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181012120852eucas1p21eb8cbe8767dd1ab3b51eb780ee49c6c~c2ya-1Gn90943209432eucas1p2V;
        Fri, 12 Oct 2018 12:08:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7F.E9.04294.3DE80CB5; Fri, 12
        Oct 2018 13:08:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181012120851eucas1p27177441e71df4665a87d0a5d87a61796~c2yaPCm9h0943209432eucas1p2Q;
        Fri, 12 Oct 2018 12:08:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181012120851eusmtrp16e82883f7dee42f06eec1a7ce4ea99d7~c2yaA-S0x2645226452eusmtrp1g;
        Fri, 12 Oct 2018 12:08:51 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-ae-5bc08ed309ac
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4D.F3.04128.2DE80CB5; Fri, 12
        Oct 2018 13:08:51 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181012120850eusmtip2d603811ba97177b9b9b12c8b3869ee38~c2yZ1iR7F2490624906eusmtip2P;
        Fri, 12 Oct 2018 12:08:50 +0000 (GMT)
Subject: Re: [PATCH] mfd: remove redundant 'default n' from Kconfig
To:     Lee Jones <lee.jones@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Fri, 12 Oct 2018 14:08:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181011054806.GS4939@dell>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsWy7djPc7qX+w5EGyxsMrG4//Uoo8XlXXPY
        HJg87lzbw+bxeZNcAFMUl01Kak5mWWqRvl0CV8au+8cZC14KVVyYHtTAuJWvi5GDQ0LARKL/
        FG8XIxeHkMAKRok/b1pYIZwvjBJX3/yCcj4zSixqXcDYxcgJ1rFtXi8zRGI5o8Sr2eegqt4z
        Sry/NYcNpEpYwFli0euPbCA7RARUJM69MQcJMwuoS2zbd4UVxGYTsJKY2L4KbCiLgKrEp6s3
        wcpFBSIk+s+og4R5BQQlTs58wgJicwpoSnS8W8MCMUZeYvvbOWA3SAg8Z5M4eeklE0RDmcTx
        j0tZIA51kVg1+S8zhC0s8er4FnYIW0bi9OQeFojm6YwSb34thXLWM0qsOXOMCaLKWuLw8Yus
        IBcxA61ev0sfEl6OEtca3SBMPokbbwUh7uGTmLRtOjNEmFeio00IYoaaxIZlG9hgtnbtXAl1
        jYfExActLBMYFWch+XIWks9mIaxdwMi8ilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzAp
        nP53/MsOxl1/kg4xCnAwKvHwLujfHy3EmlhWXJl7iFGCg1lJhHdB1oFoId6UxMqq1KL8+KLS
        nNTiQ4zSHCxK4rzL5m2MFhJITyxJzU5NLUgtgskycXBKNTBy3Cntdg+UcLKpaKs2Ft728nfM
        6XfvPhzmPdG+4OfXR3c1Et9uL62qm3D/oKiHg6bnacfF7y3OrDA905ESZ/82QWVLc4nMBvuz
        XzXrttVyH/RoFHe8VqnQN3NeQXbPK/+PkQfvCJ0xUJ/s+2I+h3dOwbWQqn9ZPX/CLnM+/hwl
        +mr+iW1tO1crsRRnJBpqMRcVJwIASQJ+bgYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsVy+t/xe7qX+w5EG3zsZrK4//Uoo8XlXXPY
        HJg87lzbw+bxeZNcAFOUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1K
        ak5mWWqRvl2CXsau+8cZC14KVVyYHtTAuJWvi5GTQ0LARGLbvF7mLkYuDiGBpYwSv868Zexi
        5ABKyEgcX18GUSMs8edaFxtEzVtGiT2fO5hAEsICzhKLXn9kA6kXEVCROPfGHKLmJaPE6uMz
        WEFqmAXUJbbtuwJmswlYSUxsX8UIYvMK2Ek8m3yaBcRmEVCV+HT1JhuILSoQIXHrYQcLRI2g
        xMmZT8BsTgFNiY53a1hgZv6Zd4kZwpaX2P52DvMERsFZSFpmISmbhaRsASPzKkaR1NLi3PTc
        YiO94sTc4tK8dL3k/NxNjMCA33bs55YdjF3vgg8xCnAwKvHw/pi4P1qINbGsuDL3EKMEB7OS
        CO+CrAPRQrwpiZVVqUX58UWlOanFhxhNgZ6YyCwlmpwPjMa8knhDU0NzC0tDc2NzYzMLJXHe
        8waVUUIC6YklqdmpqQWpRTB9TBycUg2MMrmH899MPDd/Rljo46DNPy3Yr37qvK3eWbfpvUVk
        29Ztpukh5muCi7cunqnL++xgH+cxVfmH1Su1kk6XZbp83JffqJlzKPNG5/JYk9mncxv2rq46
        IPtH01Qi2kFfieOJXEEV+0op6z+BBtxMXA33f049dHTa1A8lzddCD0t/DVLYdlOX8VmJEktx
        RqKhFnNRcSIAJSz1GY4CAAA=
Message-Id: <20181012120851eucas1p27177441e71df4665a87d0a5d87a61796~c2yaPCm9h0943209432eucas1p2Q@eucas1p2.samsung.com>
X-CMS-MailID: 20181012120851eucas1p27177441e71df4665a87d0a5d87a61796
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181010145127eucas1p2fcd5b5f91fa3ac7f763a51c0d5e8b3cb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181010145127eucas1p2fcd5b5f91fa3ac7f763a51c0d5e8b3cb
References: <CGME20181010145127eucas1p2fcd5b5f91fa3ac7f763a51c0d5e8b3cb@eucas1p2.samsung.com>
        <20181010145127eucas1p2fcd5b5f91fa3ac7f763a51c0d5e8b3cb~cRtzjSAO11833118331eucas1p2t@eucas1p2.samsung.com>
        <20181011054806.GS4939@dell>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/11/2018 07:48 AM, Lee Jones wrote:
> On Wed, 10 Oct 2018, Bartlomiej Zolnierkiewicz wrote:
> 
>> 'default n' is the default value for any bool or tristate Kconfig
>> setting so there is no need to write it explicitly.
>>
>> Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
>> is not set' for visible symbols") the Kconfig behavior is the same
>> regardless of 'default n' being present or not:
>>
>>     ...
>>     One side effect of (and the main motivation for) this change is making
>>     the following two definitions behave exactly the same:
>>     
>>         config FOO
>>                 bool
>>     
>>         config FOO
>>                 bool
>>                 default n
>>     
>>     With this change, neither of these will generate a
>>     '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
>>     That might make it clearer to people that a bare 'default n' is
>>     redundant.
>>     ...
>>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> ---
>>  drivers/mfd/Kconfig |    6 ------
>>  1 file changed, 6 deletions(-)
> 
> The change looks okay to me, but I would also like you to include the
> Maintainers/Reviewers for the affected source files.

Could you please explain in more details what do you mean?

The only affected source file is drivers/mfd/Kconfig:

$ ./scripts/get_maintainer.pl -f drivers/mfd/Kconfig 
Lee Jones <lee.jones@linaro.org> (supporter:MULTIFUNCTION DEVICES (MFD))
linux-kernel@vger.kernel.org (open list)

> Also, I assume you are not just submitting these changes to the MFD
> subsystem.  My suggesting is to change each subsystem per patch (as
> you have done here), and submit them in one patch-set with each of the
> subsystem Maintainers included, so each of us has some visibility into
> how the general idea is being received.

The general idea is trivial - remove redundant "default n" from Kconfig
files and as a result cut ~700 LOC kernel wide. I assume that this is so
trivial change that there is no need for longer deliberations.

Also I'm sorry but I simply cannot invest few days straight in preparing
the full patchset. OTOH investing few minutes a day or a week is fine so
this is why I'm doing this change incrementally.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
