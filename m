Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE69C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A29621848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nl3zqzmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfBSIdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:33:53 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35860 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfBSIdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:33:53 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190219083350euoutp012199f8c9710cc8ded78e003e4fcf9f3f~Etty11-ya1976919769euoutp01F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 08:33:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190219083350euoutp012199f8c9710cc8ded78e003e4fcf9f3f~Etty11-ya1976919769euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550565230;
        bh=QYM9M/lZ3eMbIbw/ZlL2H9CKQdsV4vaYjEemKEdo9SY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nl3zqzmnkNXaqVqX+sAhLU0SDJJ6Gen/JBQkabAu+53mDL5KxKttUqswnqQXNmv/C
         tlR7FuTwxg9tPPqbNq8ZFZdcAEcXEsN7FKe4olVUT+yPa3kPwSJW6o9VVvzoSGBybV
         tCNSqZAvNihKQX02SCoEtoIdpXzgTGtwNljGjFnc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190219083349eucas1p137ed05d332007b2a1a1764941c418945~Ettx2zZHH1871818718eucas1p1p;
        Tue, 19 Feb 2019 08:33:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B1.A9.04806.D6FBB6C5; Tue, 19
        Feb 2019 08:33:49 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190219083348eucas1p14aa9cfa32150c6336e5e7c27b179f923~Ettw8u2-g0030600306eucas1p1a;
        Tue, 19 Feb 2019 08:33:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190219083348eusmtrp198cb312fe122dc191010c2f5ef4c030e~Ettwtyan_2757327573eusmtrp1R;
        Tue, 19 Feb 2019 08:33:48 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-6c-5c6bbf6d7e1e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 35.42.04128.C6FBB6C5; Tue, 19
        Feb 2019 08:33:48 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190219083347eusmtip2bda16ed7025f275fcb0114b4f2359f84~EttwISXql1678916789eusmtip2f;
        Tue, 19 Feb 2019 08:33:47 +0000 (GMT)
Subject: Re: [PATCH v3 5/7] drivers: devfreq: add longer polling interval in
 idle
To:     myungjoo.ham@samsung.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        "tkjos@google.com" <tkjos@google.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "chris.diamand@arm.com" <chris.diamand@arm.com>,
        "mka@chromium.org" <mka@chromium.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <e5e9c6f0-5a1e-8ba1-556a-74edb1782980@partner.samsung.com>
Date:   Tue, 19 Feb 2019 09:33:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218043311epcms1p33ccb2c312e871294025171d97bb87ac6@epcms1p3>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUhUYRSG++auWiOfo+XRbGHAVhqTIi5pUdBy+1NRf3KUatKb64w2Ny1L
        SE0aNTXL0BylLCpz0EoxNYMpF5xM3DFFk4ykxTTL0VbTHK+R/573nPd857zwsYSim3JjQ3Qn
        Bb1OE66k7cny+p/N67RPw/zXf/noypVce0BxWaMdJNc19p7i7sZ5cE0JQwzXUZVHc9a0OsQV
        1/UxXPuzfBlnffgWcb3x92jOnNQv42qHDBQ3kiluc+CLrhchPjeujeQTzT0Mn18axd8cHaf4
        EXMnzaeXmRBvLV26n1Xb+wQK4SHRgt5z61H74OKv8yMfLzn9abSEiUP1LinIjgW8EXIaEmUp
        yJ5V4HsIrlwqJCQxNi1yrbQkrAgak18T/0ZK2tMZGytwAYLm8QDJNIwgc3SAtDWc8EGYGKif
        edcZZyG48806Iwj8nYCM4vsoBbEsjVVQaTphG5DjXdD6pJW2MYk9oCt9aoYX4kNQm/YZSR5H
        aMiRFtjhvVCd/YuyMYFdoGfghkziZVAxnDeTAfAfBlobX8qks3dA1vPftMROMGgpYyR2h8bM
        VFJiEZqSTLOeWDA0VM56vKHW0kbZbibwanhQ5SmVt8N5ax9jKwN2gO5hR+kEB7hSnk1IZTkk
        XVBI7lVQlto6e8wiKCjKYjKQ0jgnmHFOGOOcMMb/e/MRaUIuQpSoDRLEDTrhlErUaMUoXZAq
        IEJbiqb/W+OkZbwSmSeO1SDMIuUCeX5BqL+C0kSLMdoaBCyhdJZ/vxvmr5AHamLOCPqII/qo
        cEGsQYtZUukiPzuv30+BgzQnhTBBiBT0/7oy1s4tDm1y+jAZPyW+Mh4fUpXvMnfGK/3brx6m
        Mna+TecnZUvfJPf2vyseUieOG9beopPPeQRcPZAaWvhD9OkoRS9Cqzv9HsWoL9pZtsjcz1Fh
        mwer9RUxLRFesb7ZOkOsuM+worLFkqTuSVi+23PlxOVMhd5c6DtGJe95t2nn7fs13tGuSlIM
        1nitIfSi5i97NRlaawMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsVy+t/xe7o5+7NjDPZfkLbYOGM9q8W0T5dZ
        LK5/ec5qsaxB1eJs0xt2i8u75rBZfO49wmix9shddotLBxYwWXze8JjR4nbjCjaLfR0PmCwO
        v2lntXg/udiBz2PNvDWMHrMbLrJ4tOy7xe6xYFOpx8JPX1k93u+7yubRt2UVo8fnTXIBHFF6
        NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GWs/chfs
        lK14/WkjewPjMfEuRk4OCQETiY2X+ti7GLk4hASWMkq8vLGACSIhJjFp33Z2CFtY4s+1LjaI
        oteMEn/WTWQBSQgLBEv8eXKMCSQhIjCNUeLdgS6wDmaBv8wST3aYgthCAtOZJN72RXcxcnCw
        CehJ7FhVCBLmFXCTuLD7AhuIzSKgKnG97z+YLSoQIfHx6T4miBpBiZMzn4Dt4hTwkzg4/Rcr
        xHgziXmbHzJD2OISt57MZ4Kw5SW2v53DPIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9Nxi
        I73ixNzi0rx0veT83E2MwIjeduznlh2MXe+CDzEKcDAq8fAuWJ4VI8SaWFZcmXuIUYKDWUmE
        9/uy7Bgh3pTEyqrUovz4otKc1OJDjKZAz01klhJNzgcmm7ySeENTQ3MLS0NzY3NjMwslcd7z
        BpVRQgLpiSWp2ampBalFMH1MHJxSDYwTbjG4fehMMg57v8349z1v10cTxG87u7Oe1XKYk3Ys
        fSXzhQqTExMO7F6U9omHn8mno9viyQ6HuJkr5BYv0rdltL55Y4v1sb2G9h8U7tSm1pt3+B1V
        ElwavZSlYJr8m3M91zc0rDA9+brF3ymgKin2kkvR1O7pWWKb317r0lsU9jEiRnTxEmMlluKM
        REMt5qLiRAAls3XB/gIAAA==
X-CMS-MailID: 20190219083348eucas1p14aa9cfa32150c6336e5e7c27b179f923
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190212222436eucas1p21eebc80796406787a2ebf9a84ee5b868
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190212222436eucas1p21eebc80796406787a2ebf9a84ee5b868
References: <1550010238-24002-6-git-send-email-l.luba@partner.samsung.com>
        <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222436eucas1p21eebc80796406787a2ebf9a84ee5b868@epcms1p3>
        <20190218043311epcms1p33ccb2c312e871294025171d97bb87ac6@epcms1p3>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi MyungJoo,

Thank you for taking part in the discussion.
Please check my comments below.

On 2/18/19 5:33 AM, MyungJoo Ham wrote:
>> This patch adds new mechanism for devfreq devices which changes polling
>> interval. The system should sleep longer when the devfreq device is almost
>> not used. The devfreq framework will not schedule the work too often.
>> This low-load state is recognised when the device is operating at the lowest
>> frequency and has low busy_time/total_time factor (< 30%).
>> When the frequency is different then min, the device is under normal polling
>> which is the value defined in driver's 'polling_ms'.
>> When the device is getting more pressure, the framework is able to catch it
>> based on 'load' in lowest frequency and will start polling more frequently.
>> The second scenario is when the governor recognised heavy load at minimum
>> frequency and increases the frequency. The devfreq framework will start
>> polling in shorter intervals.
>> The polling interval, when the device is not heavily, can also be changed
>> from userspace of defined by the driver's author.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/devfreq/devfreq.c                 | 151 +++++++++++++++++++++++++++---
>>   drivers/devfreq/governor.h                |   3 +-
>>   drivers/devfreq/governor_simpleondemand.c |   6 +-
>>   3 files changed, 145 insertions(+), 15 deletions(-)
>>
> 
> There are some requirements that you need to consider:
> 
> Is 30% really applicable to ALL devfreq devices?
The 30% load while the device is on lowest OPP is to filter some noise.
It might be tunable over sysfs for each device if you like.
>      - What if some devices do not want such behaviors?
They can set polling_idle_ms and polling_ms the same value.
>      - What if some devices want different values (change behavors)?
Need of sysfs tunable here.
>      - What if some manufactures want different default values?
Like above (sysfs).
>      - What if some devices want to let the framework know that it's in idle?
There might be a filed in devfreq->state which could handle this.
>      - What if some other kernel context, device (drivers),
>      or userspace process want to notify that it's no more idling?This issue is more related to the new movement in the 'interconnect'
development. They have a goal for this kind of interactions and QoS
between devices or their clients. In devfreq it would be possible
to tackle this, but would require a lot of changes (notification chain,
state machines in devices,

> 
> As mentioned in the internal thread (tizen.org),
> I'm not convinced by the idea of assuming that a device can be considered "idling"
> if it has simply "low" utilization.
> 
> You are going to deteriorate the UI response time of mobile devices significantly.
Current devfreq wake-up also does not guarantee that, maybe on a single
CPU platform does.

I will try to address your and Chanwoo's comments that the devfreq still
needs deferred polling in some platforms.
Would it be OK if we have two options: deferred and delayed work while
registering a wakeup for a device?
That would be a function like: polling_mode_init(devfreq) instead of
simple INIT_DEFERRED_WORK(), which will check the device's preference.
The device driver could set a filed in 'polling_mode' to enum:
POWER_EFFICIENT or RELIABLE_INTERVAL. For compatibility with old drivers
where the polling_mode = 0, SYSTEM_DEFAULT_POLLING_MODE (which is one
of these two) would be used.
Then the two-phase-polling-interval from this patch could only be used
for the RELIABLE_INTERVAL configuration or even dropped.

Regards,
Lukasz
> 
> Cheers,
> MyungJoo.
> 
> 
