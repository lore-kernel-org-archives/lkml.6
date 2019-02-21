Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826A5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6652084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VVSLXA6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfBUF4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 00:56:39 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:10661 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBUF4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 00:56:39 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190221055635epoutp044903d3f4305be25f1c258852c1aa9edf~FS3EXaKN93231532315epoutp04Z
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 05:56:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190221055635epoutp044903d3f4305be25f1c258852c1aa9edf~FS3EXaKN93231532315epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550728595;
        bh=fHxGA2+byZUQBIQOLuIV86db2BH3IMMTgSKdEmo1bk0=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=VVSLXA6mgPJhHQsfDYOkEXoC20XdERyZDxC5T2PjUoD2G5eLsZBUshkLboysx8Naa
         J0LDCV9HJ/FLmMafiZv0T80pmEjZ1/PwHcAxtoPsAk5kRala+sCleP3HYz/xXxdix+
         d3Baoxke5a3Zj4zizkrWtvKzeGffWmQ1l8NJpnKc=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190221055630epcas1p1e63a576f81e10e95deca7812297bd614~FS2-b-xkQ0334403344epcas1p1c;
        Thu, 21 Feb 2019 05:56:30 +0000 (GMT)
X-AuditID: b6c32a36-a2c1c9c00000104d-85-5c6e3d715991
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.91.04173.17D3E6C5; Thu, 21 Feb 2019 14:56:01 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH v3 5/7] drivers: devfreq: add longer polling
 interval in idle
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
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
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <e5e9c6f0-5a1e-8ba1-556a-74edb1782980@partner.samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190221055601epcms1p7b87bba9a878683453f7e46c84ed032b9@epcms1p7>
Date:   Thu, 21 Feb 2019 14:56:01 +0900
X-CMS-MailID: 20190221055601epcms1p7b87bba9a878683453f7e46c84ed032b9
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDJsWRmVeSWpSXmKPExsWy7bCmvm6hbV6MwexGeYuNM9azWkz7dJnF
        4uUhTYvrX56zWixrULU42/SG3eJWg4zF5V1z2Cw+9x5htFh75C67xaUDC5gsPm94zGixr+MB
        k8XhN+2sFu8nFzvwe6yZt4bRY3bDRRaPln232D0WbCr1WPjpK6vHwXd7mDze77vK5tG3ZRWj
        x+dNcgGcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6Z
        OUDXKymUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKLAv0ihNzi0vz0vWS83OtDA0M
        jEyBChOyM5beWMZc0C9d0XZxOnMD41vRLkZODgkBE4kzk6awdDFycQgJ7GCUWHJ4OpDDwcEr
        ICjxd4cwSI2wQLjE8atP2EBsIQEliYab+5gh4voSHQ+2MYLYbAK6Els33GUBsUUEljFKzH1r
        DTKTWeA7s8Sn79cZIZbxSsxof8oCYUtLbF++FSzOKeAu8fzNI6i4qMTN1W/ZYez3x+ZD9YpI
        tN47ywxhC0o8+LmbEWbOjCn/oXqrJR71XGQGWSwh0MIosWrmNiaIhL7EmbknwT7gFfCV2ND3
        AMxmEVCVeLdwMxtEjYvEpGttYDazgLzE9rdzmEEBwSygKbF+lz7M/Q0bf7Ojs5kF+CTefe1h
        hYnvmPcEaq2axKHdS6DqZSROT18Idb+HxJHJ3xgnMCrOQgT1LCSLZyEsXsDIvIpRLLWgODc9
        tdiwwAg5djcxglOyltkOxkXnfA4xCnAwKvHwbojIjRFiTSwrrsw9xCjBwawkwnvMNC9GiDcl
        sbIqtSg/vqg0J7X4EKMp0P8TmaVEk/OB+SKvJN7Q1MjY2NjCxNDM1NBQSZx3vYNzjJBAemJJ
        anZqakFqEUwfEwenVAPjCem568w7f6+s6q3eNvFDqM2DtIntiUfWl83Lenp1GcuLGyf+eYnw
        tvTdDOWfadZaVNK5X/+y/eeufWEJzb8rK27e+cnIcqlht8HrFfPDv6X0XuvWr22zfHraoWej
        zBeLzbrxK5NFFttfEVFStN6ttt2fU/c156Ntt87ei2tVXLF+l+JD/ssTlFiKMxINtZiLihMB
        P4zu1d8DAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190212222436eucas1p21eebc80796406787a2ebf9a84ee5b868
References: <e5e9c6f0-5a1e-8ba1-556a-74edb1782980@partner.samsung.com>
        <1550010238-24002-6-git-send-email-l.luba@partner.samsung.com>
        <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <20190218043311epcms1p33ccb2c312e871294025171d97bb87ac6@epcms1p3>
        <CGME20190212222436eucas1p21eebc80796406787a2ebf9a84ee5b868@epcms1p7>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> There are some requirements that you need to consider:
>> 
>> Is 30% really applicable to ALL devfreq devices?
>The 30% load while the device is on lowest OPP is to filter some noise.
>It might be tunable over sysfs for each device if you like.
>>      - What if some devices do not want such behaviors?
>They can set polling_idle_ms and polling_ms the same value.
>>      - What if some devices want different values (change behavors)?
>Need of sysfs tunable here.
>>      - What if some manufactures want different default values?
>Like above (sysfs).
>>      - What if some devices want to let the framework know that it's in idle?
>There might be a filed in devfreq->state which could handle this.
>>      - What if some other kernel context, device (drivers),
>>      or userspace process want to notify that it's no more idling?This issue is more related to the new movement in the 'interconnect'
>development. They have a goal for this kind of interactions and QoS
>between devices or their clients. In devfreq it would be possible
>to tackle this, but would require a lot of changes (notification chain,
>state machines in devices,
>
>> 
>> As mentioned in the internal thread (tizen.org),
>> I'm not convinced by the idea of assuming that a device can be considered "idling"
>> if it has simply "low" utilization.
>> 
>> You are going to deteriorate the UI response time of mobile devices significantly.
>Current devfreq wake-up also does not guarantee that, maybe on a single
>CPU platform does.

Yes, the current devfreq does not enhance UI response time in the sense
that it would keep the same reponse time anyway.

However, your current approach will surely deteriorate it by lengthen
the polling latency.

For mobile and wearable devices, in many cases I've been witnessing,
the device idles right before the user's input (launching an app,
scrolling messages or web pages, or press a play button).
For mitigation, we often relay UI inputs to DVFS mechanisms so that
we either increase frequency for any UI inputs for a short period or
shorten the polling latency for a short period.
When a highly user-interactive device is idling or operating a low frequency,
we should assume that it's going to be highly performing anytime;
loosening the checking period is not a good solution in that sense
although it is probable for servers or workstations.
But, I don't think servers/workstations do care power consumption of
DVFS checking loops anyway.



>
>I will try to address your and Chanwoo's comments that the devfreq still
>needs deferred polling in some platforms.
>Would it be OK if we have two options: deferred and delayed work while
>registering a wakeup for a device?
>That would be a function like: polling_mode_init(devfreq) instead of
>simple INIT_DEFERRED_WORK(), which will check the device's preference.
>The device driver could set a filed in 'polling_mode' to enum:
>POWER_EFFICIENT or RELIABLE_INTERVAL. For compatibility with old drivers
>where the polling_mode = 0, SYSTEM_DEFAULT_POLLING_MODE (which is one
>of these two) would be used.
>Then the two-phase-polling-interval from this patch could only be used
>for the RELIABLE_INTERVAL configuration or even dropped.

One thing I want to add is: let's not over-complicate it.
Do you have any experimental results on how much power is saved by doing this?
(and user response time losses)


Cheers,
MyungJoo

