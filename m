Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27295C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7F6222CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GCqc6z00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfBMASb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 19:18:31 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:59954 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730629AbfBMAS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 19:18:29 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190213001826epoutp0455c6aacab82129204f2475f37cd62b18~CxFiOG6pp2024420244epoutp04b
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 00:18:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190213001826epoutp0455c6aacab82129204f2475f37cd62b18~CxFiOG6pp2024420244epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550017106;
        bh=iplie65ufORcVwGT/wZ8b/yV2ipYxi2JDPN5nj9LyYc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GCqc6z00oOmNfdQuYYzGaLyCLmCsA5LJjH/WJwYU0DTIi6M4uT3jHs0KejaRTrUbQ
         Fgfga7GcxvbiZtXxcLw/B/D0k+EUz9gRvSiOfSO8v/jV/VS5JNgo0TLpbeBW1BkZ3j
         kVBBpGvRopj6oQ8sFPCayRHF/s3jNpht7rYmuSaU=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190213001823epcas1p17a62e841b476aa5f82ee6dc96a8cad8c~CxFfzuk8Q0697106971epcas1p1J;
        Wed, 13 Feb 2019 00:18:23 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        00.0B.04288.F42636C5; Wed, 13 Feb 2019 09:18:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190213001822epcas1p125811e96cdbc21b7f87f21a57fafb4ae~CxFeir4cC0701007010epcas1p1Q;
        Wed, 13 Feb 2019 00:18:22 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190213001822epsmtrp28ca6ace91561454cbaafd734d98e16c3~CxFehSBC00511405114epsmtrp2_;
        Wed, 13 Feb 2019 00:18:22 +0000 (GMT)
X-AuditID: b6c32a38-c0fff700000010c0-d4-5c63624f175e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.6A.03601.E42636C5; Wed, 13 Feb 2019 09:18:22 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190213001822epsmtip2897affd1fa7bb9c505b24981897533a1~CxFeW9uMz2505125051epsmtip2T;
        Wed, 13 Feb 2019 00:18:22 +0000 (GMT)
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
Message-ID: <d9245497-ec63-4a5d-6c00-0ec2954af735@samsung.com>
Date:   Wed, 13 Feb 2019 09:18:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIJsWRmVeSWpSXmKPExsWy7bCmrq5/UnKMwbT9ehYbZ6xntZj26TKL
        xbIGVYuzTW/YLW41yFhc3jWHzeJz7xFGi7VH7rJbXDqwgMni84bHjBa3G1ewWezreMBkcfhN
        O6sDr8eaeWsYPWY3XGTxaNl3i91j4aevrB4H3+1h8ni/7yqbR9+WVYwenzfJBXBEZdtkpCam
        pBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAF2spFCWmFMKFApI
        LC5W0rezKcovLUlVyMgvLrFVSi1IySmwLNArTswtLs1L10vOz7UyNDAwMgUqTMjOeHDuJFvB
        ZpmKyzcnMzYw9ot1MXJySAiYSJx6+4m9i5GLQ0hgB6PEoYlPGCGcT4wS7f19LBDON0aJ938n
        MsO07FpwDqplL6PEl9a9bBDOe0aJx3tfs4FUCQuESMz8tYkFxBYRSJN4236XCaSIWeAjo8TG
        A+1gCTYBLYn9L26ANfALKEpc/fGYEcTmFbCTONrXC9TAwcEioCrR2agCEhYViJA43PsOqkRQ
        4uTMJ2BjOAW8Jc5MW8kKYjMLiEvcejKfCcKWl2jeOpsZZK+EwDZ2iT9NC9ghXnCR2LfqPNQ7
        whKvjm+BiktJfH63lw3CrpZYefIIG0RzB6PElv0XWCESxhL7l04GO45ZQFNi/S59iGV8Eu++
        9rCChCUEeCU62oQgqpUlLj+4ywRhS0osbu+EGu8h8fPePaYJjIqzkLwzC8kLs5C8MAth2QJG
        llWMYqkFxbnpqcWGBSbI0b2JEZyctSx2MO4553OIUYCDUYmHd8XRpBgh1sSy4srcQ4wSHMxK
        IrwtickxQrwpiZVVqUX58UWlOanFhxhNgYE9kVlKNDkfmDnySuINTY2MjY0tTAzNTA0NlcR5
        1zs4xwgJpCeWpGanphakFsH0MXFwSjUwigQa9LF/ePvzTSTTklSRCx658if4xMsN5MQ6BB0F
        0i9H332++MhLcfdr3XanHpal8G7W+tB0n5dPdP0vxmBGhae7/Rf5LP++03u9vLr9pS1phYem
        ygVuEKibcuC5k8AjoyMHpMtdei98+aFuVuTAZiRt966jkEs//Ot2x9KF9Y/3TDoVl+alxFKc
        kWioxVxUnAgATJMPLOQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSvK5fUnKMwcQZ4hYbZ6xntZj26TKL
        xbIGVYuzTW/YLW41yFhc3jWHzeJz7xFGi7VH7rJbXDqwgMni84bHjBa3G1ewWezreMBkcfhN
        O6sDr8eaeWsYPWY3XGTxaNl3i91j4aevrB4H3+1h8ni/7yqbR9+WVYwenzfJBXBEcdmkpOZk
        lqUW6dslcGU8OHeSrWCzTMXlm5MZGxj7xboYOTkkBEwkdi04x97FyMUhJLCbUaL12RpmiISk
        xLSLR4FsDiBbWOLw4WKQsJDAW0aJjvWWILawQIjEzF+bWEBsEYE0iUMNt8HmMAt8ZJQ49OwA
        1NB5jBItM54ygVSxCWhJ7H9xgw3E5hdQlLj64zEjiM0rYCdxtK+XCWQZi4CqRGejCkhYVCBC
        4uPTfUwQJYISJ2c+AVvGKeAtcWbaSlYQm1lAXeLPvEvMELa4xK0n85kgbHmJ5q2zmScwCs9C
        0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHKNaWjsYT5yI
        P8QowMGoxMO74mhSjBBrYllxZe4hRgkOZiUR3pbE5Bgh3pTEyqrUovz4otKc1OJDjNIcLEri
        vPL5xyKFBNITS1KzU1MLUotgskwcnFINjEuZstZFOWdOqlkx4X/yg/6g1orJ3Rcm/59epdK0
        UfzIibX7Cz/EeaxQqH595MtZfY67pufVl6kw5RzNPPyx4UAaq8nyVUcOOVS+jZXexjnnGaPm
        BbknYuLf3Xyid35fKPdR4uLlnVo/1ySvrPF3Y5I5UvP32511MTtcrj+RsO8U/Wu8oTksm02J
        pTgj0VCLuag4EQDRB6nkzQIAAA==
X-CMS-MailID: 20190213001822epcas1p125811e96cdbc21b7f87f21a57fafb4ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190212222422eucas1p1624203db4db3e495035820dea542e23a
References: <CGME20190212222422eucas1p1624203db4db3e495035820dea542e23a@eucas1p1.samsung.com>
        <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 2. 13. 오전 7:23, Lukasz Luba wrote:
> This patch set changes workqueue related features in devfreq framework.
> First patch switches to delayed work instead of deferred.
> The second switches to regular system work and deletes custom 'devfreq'.
> 
> Using deferred work in this context might harm the system performance.
> When the CPU enters idle, deferred work is not fired. The devfreq device's
> utilization does not have to be connected with a particular CPU.
> The drivers for GPUs, Network on Chip, cache L3 rely on devfreq governor.
> They all are missing opportunity to check the HW state and react when
> the deferred work is not fired.
> A corner test case, when Dynamic Memory Controller is utilized by CPUs running
> on full speed, might show x5 worse performance if the crucial CPU is in idle.
> 
> There was a discussion regarding v2 that the power usage because of waking up

We have not yet finished the any discussion. We only just had a few reply
and you didn't wait for any reply from other. As I already commented
on exynos5422-dmc series, please don't send the next patch
without any final agreement.

In this series, patch1/patch2 are same at version 2 patchset.
Even if we need to discuss more them, you just send same patches
without any agreement among reviewers. At least, you have to wait the reply
instead of just sending the new patchset. It is basic review rule on mailing list.


> an idle CPU would be too high. In my opinion it won't and fixing bug is more
> important than < 1% more power used [1].
> I have addressed also this issue. In this patch set there is a mechanism
> which prevents from to frequent checks when there is no need.
> When the device enters its lowest state (OPP) the framework sets polling
> interval to 'polling_idle_ms'. In default Kconfig it is 500ms, so 2 times per
> second.
> It is tunable from the sysfs interface per device, thus driver developer can
> experiment and choose best intervals for the system.
> 
> Changes:
> v3:
> - reordered first two patches
> - added functionality to lower power consumption when the device is less busy;
>   there is a new polling interval enabled when device enters lowest frequency;
> - added trace events to capture the behaviour of the system
> v2:
> - single patch split into two
> - added cover letter
> 
> link for the previous version and discussion:
> https://marc.info/?l=linux-pm&m=154989907416072&w=2
> https://marc.info/?l=linux-pm&m=154904631226997&w=2
> 
> Regards,
> Lukasz Luba
> 
> [1] https://marc.info/?l=linux-kernel&m=155000641622443&w=2
> 
> Lukasz Luba (7):
>   drivers: devfreq: change deferred work into delayed
>   drivers: devfreq: change devfreq workqueue mechanism
>   Kconfig: drivers: devfreq: add default idle polling
>   include: devfreq: add polling_idle_ms to 'profile'
>   drivers: devfreq: add longer polling interval in idle
>   trace: events: add devfreq trace event file
>   drivers: devfreq: add tracing for scheduling work
> 
>  MAINTAINERS                               |   1 +
>  drivers/devfreq/Kconfig                   |  13 +++
>  drivers/devfreq/devfreq.c                 | 184 ++++++++++++++++++++++++------
>  drivers/devfreq/governor.h                |   3 +-
>  drivers/devfreq/governor_simpleondemand.c |   6 +-
>  include/linux/devfreq.h                   |   6 +
>  include/trace/events/devfreq.h            |  39 +++++++
>  7 files changed, 218 insertions(+), 34 deletions(-)
>  create mode 100644 include/trace/events/devfreq.h
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
