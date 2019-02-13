Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5DCC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424562190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ekk5gRtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391721AbfBMLOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:14:53 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51565 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfBMLOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:14:52 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190213111450euoutp0211458b67d3c528aa2541fe3b56b13d02~C6Cp2G-3-0832108321euoutp02b
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 11:14:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190213111450euoutp0211458b67d3c528aa2541fe3b56b13d02~C6Cp2G-3-0832108321euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550056490;
        bh=vEqO8MX9r+GtqSM9EYgTHpieZoC5IZf+WCwcuUvBhGc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Ekk5gRtfHEeW8Ws7sgAFaHUL9eY8xr3bU1Jfjks4el1ndoxr0szm4VEFxw5y+qU/x
         t+TC/6aK9tTq7500yd7S6Coe0C80ygXHaUnh1oHvMKlXZHTmUVVw+L4T4uFnGKiAF/
         DKZGFjUAxF3d2nXkrr8MF2mH9D4+aPqevPtYpVWg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190213111450eucas1p1f4c797cad85b267589fd0c3754ff1220~C6CpMIziK0491004910eucas1p1m;
        Wed, 13 Feb 2019 11:14:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 68.A6.04294.92CF36C5; Wed, 13
        Feb 2019 11:14:49 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190213111449eucas1p16fe9972fc0c13515b16d8582191efaa7~C6CoaIhdv3105731057eucas1p1I;
        Wed, 13 Feb 2019 11:14:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190213111449eusmtrp231c41faf91df851dad8cc72a3d96ed33~C6CoYsgdM1310413104eusmtrp2Q;
        Wed, 13 Feb 2019 11:14:49 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-17-5c63fc2916b7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 79.D8.04284.92CF36C5; Wed, 13
        Feb 2019 11:14:49 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190213111448eusmtip20912148c4f46057869f8f013e9971190~C6CnzHoVN3238532385eusmtip2M;
        Wed, 13 Feb 2019 11:14:48 +0000 (GMT)
Subject: Re: [PATCH v3 0/7] drivers: devfreq: fix and optimize workqueue
 mechanism
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, joel@joelfernandes.org,
        chris.diamand@arm.com, mka@chromium.org, rostedt@goodmis.org,
        mingo@redhat.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <80cd346e-a0a3-ff66-40a6-c15fd23ba904@partner.samsung.com>
Date:   Wed, 13 Feb 2019 12:14:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d9245497-ec63-4a5d-6c00-0ec2954af735@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+3nv3b2ubv02NU8WBSMlhXxkwoWkB0WsB1EU9FJsztsUt2m7
        WmkG67kVFlGgbmo+SxPDMrVlZLVZNmNWRmmJYCREkUbqECta3V0j//ue7/kczvnCYQilhwpj
        Mow5vMmo0atkcrLt6dSL5ZG/tEmxny2x3O2SJoorGntNcn0Tnyjuujmc85z8SnOv28tk3PiF
        TsTd7Bykud5HlQHc+K2PiBs4US/jOqxDAZzrq4Vay6obrzYidan5Fak+3fGeVleNeSn1t443
        MvXFlgakHm9evJ3eJ09M4/UZh3lTzOoD8vS2zhqUPRlxdNRTYEZ9i8+jQAbwSrji9BHnkZxR
        4noExb1NtFRMILjW1UNKxTgC72Wf7N/IgxsPaVErcR0C329egkYQ9BT5/I0gvAtsP5r/TjNM
        ME6FEl+iyBD4O4Lbjyx+X4ajwdFwSMRZvBG6P9ykRZvE4eD6qRLtELwHXBdGkYQowG0bJkUd
        iNeAz/uMEjWBQ+H9cEWApJfAqdZSfxrA32noG6qYvnkDlPcNIkkHwZeuFlrSi8B3TxoGLIDH
        2jDNF4DF7ZhmVoGr6xUl3kbgSGhqj5HsdTBSN+BPAngu9I8opBPmwuW2YkKyWbCeVUr0Mmgp
        fDm9aD7UNRbRl5DKPiOYfUYY+4ww9v97KxHZgEL5XMGg44UVRv5ItKAxCLlGXbQ2y9CM/j7Z
        899dEw7U/ivViTCDVHPY+iepSUpKc1jIMzgRMIQqmO0f0yYp2TRNXj5vykox5ep5wYkWMqQq
        lD02a2i/Eus0OXwmz2fzpn/dACYwzIy0B0OGgxIEW0iCs3x2mIHyxEToltbcjS98xzl86d2t
        +/VvHVNb72sfH7Qet5GZFTU9OWWl+VOb46rZyUJTSrIlesHEuU29O/cODnh3BNWUOBS25FXV
        1z/fiV2/J7uoyjVvlNti76+VbTIuc58xyBOjThmLj0fEKxII97ba3XMyVaSQromLIkyC5g/N
        87Z3YAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsVy+t/xe7qaf5JjDH4e4LTYOGM9q8W0T5dZ
        LK5/ec5qsaxB1eJs0xt2i8u75rBZfO49wmix9shddotLBxYwWXze8JjR4nbjCjaLfR0PmCwO
        v2lndeD1WDNvDaPH7IaLLB4t+26xeyz89JXV4/2+q2wefVtWMXp83iQXwB6lZ1OUX1qSqpCR
        X1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7HtyGLGgu9qFe/O1jQw
        XpfrYuTkkBAwkdi7cj97FyMXh5DAUkaJ3VdOsEEkxCQm7dvODmELS/y51sUGUfSaUeJi4wkm
        kISwQIjEzF+bWEBsEYEkiSnHH4AVMQt8ZJQ49OwAWLeQwGVGieUP8rsYOTjYBPQkdqwqBAnz
        CrhJnHq4lh0kzCKgKnH4txJIWFQgQuLj031MECWCEidnPgEbzylgL/H/6wlWEJtZwExi3uaH
        zBC2uMStJ/OZIGx5ieats5knMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2yoV5yYW1ya
        l66XnJ+7iREYv9uO/dy8g/HSxuBDjAIcjEo8vCuOJsUIsSaWFVfmHmKU4GBWEuG98Sk5Rog3
        JbGyKrUoP76oNCe1+BCjKdBvE5mlRJPzgaklryTe0NTQ3MLS0NzY3NjMQkmc97xBZZSQQHpi
        SWp2ampBahFMHxMHp1QD4zSGs6/nnjd/pfTA1+b5EnaGnXX+FiscRS9PE+ecufPnq4gTKo6S
        xp+U/jV+7jo5u7T+pblfUIhb4z7rt7MXWs5Q+p9dtWZ5wKoKFoFHLB1T/3LvV1zUtDbF9tyZ
        WzWv+Zd4CXPv0dxucGzey2DZ1l1n1XhcGNW/OQrZ3vr4SJ27bPmhvX/swpVYijMSDbWYi4oT
        AXrhmYX1AgAA
X-CMS-MailID: 20190213111449eucas1p16fe9972fc0c13515b16d8582191efaa7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190212222422eucas1p1624203db4db3e495035820dea542e23a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190212222422eucas1p1624203db4db3e495035820dea542e23a
References: <CGME20190212222422eucas1p1624203db4db3e495035820dea542e23a@eucas1p1.samsung.com>
        <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <d9245497-ec63-4a5d-6c00-0ec2954af735@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 2/13/19 1:18 AM, Chanwoo Choi wrote:
> On 19. 2. 13. 오전 7:23, Lukasz Luba wrote:
>> This patch set changes workqueue related features in devfreq framework.
>> First patch switches to delayed work instead of deferred.
>> The second switches to regular system work and deletes custom 'devfreq'.
>>
>> Using deferred work in this context might harm the system performance.
>> When the CPU enters idle, deferred work is not fired. The devfreq device's
>> utilization does not have to be connected with a particular CPU.
>> The drivers for GPUs, Network on Chip, cache L3 rely on devfreq governor.
>> They all are missing opportunity to check the HW state and react when
>> the deferred work is not fired.
>> A corner test case, when Dynamic Memory Controller is utilized by CPUs running
>> on full speed, might show x5 worse performance if the crucial CPU is in idle.
>>
>> There was a discussion regarding v2 that the power usage because of waking up
> 
> We have not yet finished the any discussion. We only just had a few reply
> and you didn't wait for any reply from other. As I already commented
> on exynos5422-dmc series, please don't send the next patch
> without any final agreement.
> 
> In this series, patch1/patch2 are same at version 2 patchset.
> Even if we need to discuss more them, you just send same patches
> without any agreement among reviewers. At least, you have to wait the reply
> instead of just sending the new patchset. It is basic review rule on mailing list.
I think you are blocking the fixes.
Matthias is currently fixing devfreq governors which lack 'case SUSPEND'
and he is interested in these v3. I have fixed a month ago issue with
system suspend and OPP state of devfreq devices, which Tobias was rising
and sending patches a few years ago, but you have blocked them.

These version is ready for comments regarding 'battery powered devices'.
The v3 has introduced approach for 2 polling intervals similar to
thermal framework.
It also has trace events. The trace events are *really* important in
this discussion because we need some measurements.

You said:
'When release the real mobile product like galaxy phone,
it is very important issue to remove the unneeded wakeup on idle state.'
Was it a real reason for profiling the devfreq framework and core
workqueue mechanism? There are embedded devices which are not using
battery and probably developers were not aware because there was no
traces which could give any information about devfreq behavior.
Power is important, performance is important but relaying on randomness
is not the best solution. As I said earlier, your driver can stuck on
highest OPP waiting for next callback which will not come...

Regards,
Lukasz
> 
> 
>> an idle CPU would be too high. In my opinion it won't and fixing bug is more
>> important than < 1% more power used [1].
>> I have addressed also this issue. In this patch set there is a mechanism
>> which prevents from to frequent checks when there is no need.
>> When the device enters its lowest state (OPP) the framework sets polling
>> interval to 'polling_idle_ms'. In default Kconfig it is 500ms, so 2 times per
>> second.
>> It is tunable from the sysfs interface per device, thus driver developer can
>> experiment and choose best intervals for the system.
>>
>> Changes:
>> v3:
>> - reordered first two patches
>> - added functionality to lower power consumption when the device is less busy;
>>    there is a new polling interval enabled when device enters lowest frequency;
>> - added trace events to capture the behaviour of the system
>> v2:
>> - single patch split into two
>> - added cover letter
>>
>> link for the previous version and discussion:
>> https://marc.info/?l=linux-pm&m=154989907416072&w=2
>> https://marc.info/?l=linux-pm&m=154904631226997&w=2
>>
>> Regards,
>> Lukasz Luba
>>
>> [1] https://marc.info/?l=linux-kernel&m=155000641622443&w=2
>>
>> Lukasz Luba (7):
>>    drivers: devfreq: change deferred work into delayed
>>    drivers: devfreq: change devfreq workqueue mechanism
>>    Kconfig: drivers: devfreq: add default idle polling
>>    include: devfreq: add polling_idle_ms to 'profile'
>>    drivers: devfreq: add longer polling interval in idle
>>    trace: events: add devfreq trace event file
>>    drivers: devfreq: add tracing for scheduling work
>>
>>   MAINTAINERS                               |   1 +
>>   drivers/devfreq/Kconfig                   |  13 +++
>>   drivers/devfreq/devfreq.c                 | 184 ++++++++++++++++++++++++------
>>   drivers/devfreq/governor.h                |   3 +-
>>   drivers/devfreq/governor_simpleondemand.c |   6 +-
>>   include/linux/devfreq.h                   |   6 +
>>   include/trace/events/devfreq.h            |  39 +++++++
>>   7 files changed, 218 insertions(+), 34 deletions(-)
>>   create mode 100644 include/trace/events/devfreq.h
>>
> 
> 
