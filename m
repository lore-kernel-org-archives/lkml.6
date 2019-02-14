Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49085C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35FD222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AYo5ANpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfBNAlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:41:21 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:11688 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfBNAlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:41:20 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190214004117epoutp0129b6c877668463b98a34c723331f7b00~DFCxnK6bE1811118111epoutp012
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 00:41:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190214004117epoutp0129b6c877668463b98a34c723331f7b00~DFCxnK6bE1811118111epoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550104877;
        bh=5FlheUoYItWOb1odSrI4ZWPcrxgWoHqRHSpHhdfX08c=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=AYo5ANpUqjfb7V1o9BctBUvyC4sT0XGqj9eR9FWYOQswSuCQDGD9DB3FArxR3m7dV
         ZYR5ikjKN08DQZtlwvQd4Y7MVQuojsQOHauV6C6QPSS1+TGpVxTvGBu5lvSp4Utp4P
         yutLBAsw8ktBuhhLrOeRxVh9eaJwlUvefUCNSRvI=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190214004114epcas1p4d903ad3517b2e365533e6a68d531a30c~DFCvFWifm0650906509epcas1p4v;
        Thu, 14 Feb 2019 00:41:14 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.2B.04288.A29B46C5; Thu, 14 Feb 2019 09:41:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190214004114epcas1p410500a78f1542d5dcb5af9b1292b49f6~DFCuaFSZP0813908139epcas1p4R;
        Thu, 14 Feb 2019 00:41:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190214004114epsmtrp109413fa9c1b9d117c855ec7427f14ac9~DFCuYXHng0114601146epsmtrp1_;
        Thu, 14 Feb 2019 00:41:14 +0000 (GMT)
X-AuditID: b6c32a38-bf7ff700000010c0-e1-5c64b92a51e4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.43.03971.A29B46C5; Thu, 14 Feb 2019 09:41:14 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190214004113epsmtip104aa1808ac745790d5b0abb48f79fae7~DFCuGkMqR2849628496epsmtip1j;
        Thu, 14 Feb 2019 00:41:13 +0000 (GMT)
Subject: Re: [PATCH v3 0/7] drivers: devfreq: fix and optimize workqueue
 mechanism
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, joel@joelfernandes.org,
        chris.diamand@arm.com, mka@chromium.org, rostedt@goodmis.org,
        mingo@redhat.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <3657574e-a258-e6cb-9632-9d17b66e7379@samsung.com>
Date:   Thu, 14 Feb 2019 09:41:13 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <80cd346e-a0a3-ff66-40a6-c15fd23ba904@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAJsWRmVeSWpSXmKPExsWy7bCmrq7WzpQYg4fnTC02zljPajHt02UW
        i2UNqhZnm96wW9xqkLG4vGsOm8Xn3iOMFmuP3GW3uHRgAZPF5w2PGS1uN65gs9jX8YDJ4vCb
        dlYHXo8189YwesxuuMji0bLvFrvHwk9fWT0OvtvD5PF+31U2j74tqxg9Pm+SC+CIyrbJSE1M
        SS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpYSaEsMacUKBSQ
        WFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBXnJhbXJqXrpecn2tlaGBgZApUmJCdceRhVsFb
        44pJv3ewNjD+1Ohi5OSQEDCR2PXjKUsXIxeHkMAORond31ayQjifGCW6/z1kgnC+MUo8/jyN
        EaZl2f1udhBbSGAvo8TE8wEQRe8ZJf5t2AJWJCwQIjHz1yYWEFtEIE3ibftdsEnMAh8ZJTYe
        aAdLsAloSex/cYMNxOYXUJS4+uMxWDOvgJ3EgQVbwOIsAqoSOx5cA4uLCkRIHO59B1UjKHFy
        5hOwOZwC7hL3um+xgtjMAuISt57MZ4Kw5SWat85mBlksIbCOXeLwpRvMEC+4SHy/+ZUNwhaW
        eHV8CzuELSXxsr8Nyq6WWHnyCBtEcwejxJb9F1ghEsYS+5dOBtrAAbRBU2L9Ln2IZXwS7772
        sIKEJQR4JTrahCCqlSUuP7jLBGFLSixu74Ra6yHx8949pgmMirOQvDMLyQuzkLwwC2HZAkaW
        VYxiqQXFuempxYYFJsixvYkRnJq1LHYw7jnnc4hRgINRiYe3QiglRog1say4MvcQowQHs5II
        76TNQCHelMTKqtSi/Pii0pzU4kOMpsDQnsgsJZqcD8wbeSXxhqZGxsbGFiaGZqaGhkrivOsd
        nGOEBNITS1KzU1MLUotg+pg4OKUaGJv+/8sVm8S+2y5AlLsj6s2i8A2hpyMLcnsZ5q92U5A2
        vb7kTkJN72vDxUH3vpxbaVxwTe71dt/zpyz9PHuun8qS/yeWde9Y1tZjqlEHHfmfGx3kPsMY
        vOtprP2PO9rsh+cdd2nzm1y00GhqScLZH6qdF+w7e9vjnkRvWb8toa/Bd+nUepsILSWW4oxE
        Qy3mouJEAOXJHI7jAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSnK7WzpQYg9blLBYbZ6xntZj26TKL
        xbIGVYuzTW/YLW41yFhc3jWHzeJz7xFGi7VH7rJbXDqwgMni84bHjBa3G1ewWezreMBkcfhN
        O6sDr8eaeWsYPWY3XGTxaNl3i91j4aevrB4H3+1h8ni/7yqbR9+WVYwenzfJBXBEcdmkpOZk
        lqUW6dslcGUceZhV8Na4YtLvHawNjD81uhg5OSQETCSW3e9m72Lk4hAS2M0o0XvvCCtEQlJi
        2sWjzF2MHEC2sMThw8UgYSGBt4wSL+/Zg9jCAiESM39tYgGxRQTSJA413AabwyzwkVHi0LMD
        UEMnMElc/P+DDaSKTUBLYv+LG2A2v4CixNUfjxlBbF4BO4kDC7aAxVkEVCV2PLgGFhcViJD4
        +HQfE0SNoMTJmU/AtnEKuEvc674FdiizgLrEn3mXmCFscYlbT+YzQdjyEs1bZzNPYBSehaR9
        FpKWWUhaZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzhGtTR3MF5eEn+I
        UYCDUYmHt0IoJUaINbGsuDL3EKMEB7OSCO+kzUAh3pTEyqrUovz4otKc1OJDjNIcLErivE/z
        jkUKCaQnlqRmp6YWpBbBZJk4OKUaGKUEi58zaKVPmZN9cUkHV0Gq/EnX5YuvuLrPvzThfHo+
        u/bu+TXBqmEBmr69YfkZcvcnpSx+dVyUX2J5xa65zF/mrnrmk/gw6XnHTv+LVdHazvPXft/O
        G8Eg3ZPxgYdlWnRL+9XOPAlBN7+W6aGilyp0nBbpbNOJ39W/g0n9irXD7NyjNq27lViKMxIN
        tZiLihMBLOo8C80CAAA=
X-CMS-MailID: 20190214004114epcas1p410500a78f1542d5dcb5af9b1292b49f6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190212222422eucas1p1624203db4db3e495035820dea542e23a
References: <CGME20190212222422eucas1p1624203db4db3e495035820dea542e23a@eucas1p1.samsung.com>
        <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <d9245497-ec63-4a5d-6c00-0ec2954af735@samsung.com>
        <80cd346e-a0a3-ff66-40a6-c15fd23ba904@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 19. 2. 13. 오후 8:14, Lukasz Luba wrote:
> Hi Chanwoo,
> 
> On 2/13/19 1:18 AM, Chanwoo Choi wrote:
>> On 19. 2. 13. 오전 7:23, Lukasz Luba wrote:
>>> This patch set changes workqueue related features in devfreq framework.
>>> First patch switches to delayed work instead of deferred.
>>> The second switches to regular system work and deletes custom 'devfreq'.
>>>
>>> Using deferred work in this context might harm the system performance.
>>> When the CPU enters idle, deferred work is not fired. The devfreq device's
>>> utilization does not have to be connected with a particular CPU.
>>> The drivers for GPUs, Network on Chip, cache L3 rely on devfreq governor.
>>> They all are missing opportunity to check the HW state and react when
>>> the deferred work is not fired.
>>> A corner test case, when Dynamic Memory Controller is utilized by CPUs running
>>> on full speed, might show x5 worse performance if the crucial CPU is in idle.
>>>
>>> There was a discussion regarding v2 that the power usage because of waking up
>>
>> We have not yet finished the any discussion. We only just had a few reply
>> and you didn't wait for any reply from other. As I already commented
>> on exynos5422-dmc series, please don't send the next patch
>> without any final agreement.
>>
>> In this series, patch1/patch2 are same at version 2 patchset.
>> Even if we need to discuss more them, you just send same patches
>> without any agreement among reviewers. At least, you have to wait the reply
>> instead of just sending the new patchset. It is basic review rule on mailing list.
> I think you are blocking the fixes.
> Matthias is currently fixing devfreq governors which lack 'case SUSPEND'
> and he is interested in these v3. I have fixed a month ago issue with
> system suspend and OPP state of devfreq devices, which Tobias was rising
> and sending patches a few years ago, but you have blocked them.

I never blocked any something. I spent many times to review the devfreq patches
to imporve the devfreq frameworw. In case of Tobias's patch,
I just suggested other opinion and approach, but he didn't finish them.

If I blocked some patches for devfreq, why am I review your suspend patch
and agree them? It is very ridiculous of your thinking.

> 
> These version is ready for comments regarding 'battery powered devices'.
> The v3 has introduced approach for 2 polling intervals similar to
> thermal framework.
> It also has trace events. The trace events are *really* important in
> this discussion because we need some measurements.
> 
> You said:
> 'When release the real mobile product like galaxy phone,
> it is very important issue to remove the unneeded wakeup on idle state.'
> Was it a real reason for profiling the devfreq framework and core
> workqueue mechanism? There are embedded devices which are not using

Yes. I think that deferrable workqueue is very important for some case.
But, on the other hand, it might be always true.

I don't just want to remove the deferrable work. But, I agree that
to support both delayed and deferrable work according to the
choice of devfreq device drivers.

If remove the deferrable work, it always wakeup the idle state.
The device driver never handle them. Someone want to get the
high-performance but, someone don't want to wakeup from idle state.

On your v2 patchset, just remove the deferrable work without
any tunable feature. So, I try to discuss them. But, you just
sent next patches without any discussion. And then, you also
asked that we had to check the next patches.

It is wrong for review sequence. I have to wait the review
/discuss before sending the next patches.

Once again,
I don't just want to remove the deferrable work without
any tunable interface. But, I agree that to support both
delayed and deferrable work according to the choice of
devfreq device drivers.


> battery and probably developers were not aware because there was no
> traces which could give any information about devfreq behavior.
> Power is important, performance is important but relaying on randomness
> is not the best solution. As I said earlier, your driver can stuck on
> highest OPP waiting for next callback which will not come...
> 
> Regards,
> Lukasz
>>
>>
>>> an idle CPU would be too high. In my opinion it won't and fixing bug is more
>>> important than < 1% more power used [1].
>>> I have addressed also this issue. In this patch set there is a mechanism
>>> which prevents from to frequent checks when there is no need.
>>> When the device enters its lowest state (OPP) the framework sets polling
>>> interval to 'polling_idle_ms'. In default Kconfig it is 500ms, so 2 times per
>>> second.
>>> It is tunable from the sysfs interface per device, thus driver developer can
>>> experiment and choose best intervals for the system.
>>>
>>> Changes:
>>> v3:
>>> - reordered first two patches
>>> - added functionality to lower power consumption when the device is less busy;
>>>    there is a new polling interval enabled when device enters lowest frequency;
>>> - added trace events to capture the behaviour of the system
>>> v2:
>>> - single patch split into two
>>> - added cover letter
>>>
>>> link for the previous version and discussion:
>>> https://marc.info/?l=linux-pm&m=154989907416072&w=2
>>> https://marc.info/?l=linux-pm&m=154904631226997&w=2
>>>
>>> Regards,
>>> Lukasz Luba
>>>
>>> [1] https://marc.info/?l=linux-kernel&m=155000641622443&w=2
>>>
>>> Lukasz Luba (7):
>>>    drivers: devfreq: change deferred work into delayed
>>>    drivers: devfreq: change devfreq workqueue mechanism
>>>    Kconfig: drivers: devfreq: add default idle polling
>>>    include: devfreq: add polling_idle_ms to 'profile'
>>>    drivers: devfreq: add longer polling interval in idle
>>>    trace: events: add devfreq trace event file
>>>    drivers: devfreq: add tracing for scheduling work
>>>
>>>   MAINTAINERS                               |   1 +
>>>   drivers/devfreq/Kconfig                   |  13 +++
>>>   drivers/devfreq/devfreq.c                 | 184 ++++++++++++++++++++++++------
>>>   drivers/devfreq/governor.h                |   3 +-
>>>   drivers/devfreq/governor_simpleondemand.c |   6 +-
>>>   include/linux/devfreq.h                   |   6 +
>>>   include/trace/events/devfreq.h            |  39 +++++++
>>>   7 files changed, 218 insertions(+), 34 deletions(-)
>>>   create mode 100644 include/trace/events/devfreq.h
>>>
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
