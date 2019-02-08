Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42C2C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CE6218D9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vNvmETJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfBHMEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:04:25 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40180 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfBHMEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:04:24 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190208120422euoutp011021539db0bc7810938e68ec7ff84eb9~BYfdna1vN2188621886euoutp01h
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 12:04:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190208120422euoutp011021539db0bc7810938e68ec7ff84eb9~BYfdna1vN2188621886euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549627462;
        bh=hGQeptA4OIFpm7NzVBC6qIx1nX53j4NGZo22jmAReLA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=vNvmETJ0Mr0h4sk/GozypLK6G1Akisp+5NVQuIrT6/caOG4X1/J5XQ7P29lmeTd3s
         FBSqIzafG2R880AcftCk9t31oxm3TYv3ThoYqloekEgm7wabrVlS8zMaOIPPLOTp+W
         oZYkNN84S7aW6t9AOLVejcrfM9mPuJyw/CqcGOeg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190208120421eucas1p104f66070815fbe336aa7361b450ae08d~BYfc5mvRf2196021960eucas1p11;
        Fri,  8 Feb 2019 12:04:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 66.75.04806.4407D5C5; Fri,  8
        Feb 2019 12:04:20 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190208120420eucas1p2c46c39b25939153fab4e158d8c8c0215~BYfcBys901722617226eucas1p2x;
        Fri,  8 Feb 2019 12:04:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190208120420eusmtrp2f1e332c574a2001ac4391b01d26d69d2~BYfbzH0Jf1867818678eusmtrp2M;
        Fri,  8 Feb 2019 12:04:20 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-5d-5c5d704476bc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 71.43.04284.3407D5C5; Fri,  8
        Feb 2019 12:04:20 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190208120419eusmtip297f96cb024429acf5fbfd2862df8b278~BYfbOdQM02468424684eusmtip2Q;
        Fri,  8 Feb 2019 12:04:19 +0000 (GMT)
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <66b33c07-4970-b60a-d924-d4baba79c836@samsung.com>
Date:   Fri, 8 Feb 2019 13:04:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190208115122.GA13043@e107155-lin>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfyyUcRz2vfe9915yt69zzWdq2W6NVYssrbdpJqPelj9qa2tx0uEdxh3d
        IfSPZfPjwsyELtQWE7NEQnYk5Dg/u8YoFSYzkebHsBo5L+W/5/N5nmfP59k+NCEdEDrSkeo4
        TqNWRsspG7Kha2PwpG9skOLUfN45praoRsiMrWYImY/NxRSznN2JmKLBVgEzv94vYPp6zUJm
        c6SWZCpMTSRTu8oyld16wvsAW11ajdi6qkyKHR8xUGz9cDrJ5tRXIbbHNE2yxtFGAbtcd+Qq
        HWBzPoyLjkzgNG5et20i5jK/UbFbkkTDUAlKQdm2OmRNA/aAlqUaQodsaCl+juDt0n1kIaR4
        BYG5APPEMoKt752iPYch45WIJyoQzL1/uTssIvj1+RlhUdljP5hJ7dtxyLALlPXXI4uIwIsC
        WCtvEVoICruDbkFHWbAYe8FG1U/Sgkl8FFIflO5oDmIF5A/w0WJsBz2Ppnc01ttew1TZjobA
        TtC4UEzw2AE+TT8RWMIAT4kgdTaL4u/2hfnVFcRje5gz1u/2OQxbb/YMqQjSi/QifshC8Lq4
        adftCR3GD9tx9HbEMahpduPXF8DUUUlZ1oAlMLpgxx8hgbyGQoJfiyEjTcqrnUFvfPEv9t2Q
        mchFcv2+avp9dfT76uj/5z5FZBVy4OK1qnBOe1rN3XXVKlXaeHW4a2iMqg5tf1nvpnG1CbX+
        CWlHmEZyW/HQCYVCKlQmaJNU7QhoQi4Tu6iCFFJxmDIpmdPEBGviozltOzpEk3IH8T2riUAp
        DlfGcVEcF8tp9lgBbe2YgsY6AwymO1EVW4sysbIlLeThjYlQw1nWUxbk0zDZlmGGpPEvj/td
        RLIcx4g4P9Ow5GZJ0PXfo5Lcdee1kFldW463ekpa9rXcxzM5QT9jfynESn4xO9+KKpBNBv64
        zE6LnHXrhdc8uhbMiX0CdZmLf0x3SVjXlVvsGSf/8dHYYDmpjVC6Hyc0WuVf/vWRPWEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsVy+t/xe7ouBbExBp0PGS02zljPanHzawer
        xeVdc9gsPvceYbSYcX4fk8WbH2eZLM6cvsRq8e/aRhaL5ad2sFhs/OphsfLELGYHbo8189Yw
        emxa1cnmcefaHjaPLVfbWTz6tqxi9Dh56gmLx/Eb25k8Pm+SC+CI0rMpyi8tSVXIyC8usVWK
        NrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mt41XmfreA/X8WeC3MZGxh7eboY
        OTkkBEwk9nRsZu9i5OIQEljKKHF86lVGiISMxMlpDawQtrDEn2tdbBBFbxkl9i3cAlYkLOAq
        8az5DDuILSKgLrHkLEici4NZ4D2TxNZNB5ggOiYzSexpPcIMUsUmYCjR9RZkFCcHr4CdxM9V
        71hAbBYBFYnm7nlA6zg4RAViJK6eY4QoEZQ4OfMJWAknUOueR0vALmIGWvZn3iVmCFteYvvb
        OVC2uMStJ/OZJjAKzULSPgtJyywkLbOQtCxgZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kR
        GLvbjv3cvIPx0sbgQ4wCHIxKPLwaejExQqyJZcWVuYcYJTiYlUR41XNjY4R4UxIrq1KL8uOL
        SnNSiw8xmgL9NpFZSjQ5H5hW8kriDU0NzS0sDc2NzY3NLJTEec8bVEYJCaQnlqRmp6YWpBbB
        9DFxcEo1MErlLp3jZqb41+nEKcFggRiuxftmVW36+GD5UetqQwVh3sqifZKXJR9PbgsVuqrs
        33XUyYzRTczhxifFC0cXPLryxOfStx2Km5csyWqLK+pb9FLuvuFW7QXy68Vn+CmdTKn3eP9O
        ++/j2oMv1O7rZeifNForH5GdreHwQ7WSL+xo/sXl5RuNw5VYijMSDbWYi4oTAWUJEErzAgAA
X-CMS-MailID: 20190208120420eucas1p2c46c39b25939153fab4e158d8c8c0215
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190207122255eucas1p1cdebed838c799eca46cce6a654a26187
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190207122255eucas1p1cdebed838c799eca46cce6a654a26187
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
        <20190207122227.19873-1-m.szyprowski@samsung.com>
        <20190208110053.GA7913@e107155-lin>
        <87302853-74cc-8eeb-6bd4-6338746e0738@samsung.com>
        <20190208115122.GA13043@e107155-lin>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On 2019-02-08 12:51, Sudeep Holla wrote:
> On Fri, Feb 08, 2019 at 12:47:06PM +0100, Marek Szyprowski wrote:
>> On 2019-02-08 12:00, Sudeep Holla wrote:
>>> On Thu, Feb 07, 2019 at 01:22:25PM +0100, Marek Szyprowski wrote:
>>>> Dear All,
>>>>
>>>> This is a scenario that triggers the above issue:
>>> [...]
>>>> 1. system disables non-boot cpu's at the end of system suspend procedure,
>>>> 2. this in turn deinitializes cpufreq drivers for the disabled cpus,
>>>> 3. early in the system resume procedure all cpus are got back to online
>>>>    state,
>>>> 4. this in turn causes cpufreq to be initialized for the newly onlined
>>>>    cpus,
>>>> 5. cpufreq-dt acquires all its resources (clocks, regulators) during
>>>>    ->init() callback,
>>> This is strictly not just restricted to cpufreq-dt, but to any driver
>>> supporting multiple policies. So we need a generic fix not just
>>> cpufreq-dt specific.
>> Could you point which other driver needs similar fix? Here in cpufreq-dt
>> the problem was caused by using regulator api (indirectly) from
>> ->init(). All other drivers, which have regulators support, are for old,
>> obsolete, uni-processor systems, which don't have the problem of
>> secondary cpu suspend during system suspend/resume cycle.
>>
> scmi_cpufreq for instance. We can fix that in driver my moving to polling
> to get cpufreq_get_rate, but we support both polling and interrupt based.
> We may wait for remote processor interrupt in get_rate.

Frankly, I don't feel I know enough to touch this driver and I don't
think that this can even be fixed in a generic way in the cpufreq core.
Maybe a comment somewhere is needed that ->init() might be called during
early system resume with irqs off and driver is responsible for handling
such case until the proper resume?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

