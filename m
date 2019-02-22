Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B6EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB922070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zo7KeeLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfBVQDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:03:09 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49668 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBVQDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 11:03:09 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190222160306euoutp02a6d3801f01b101c7d4c5fdd40a3c038b~Fux6cTQip2234922349euoutp02x
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 16:03:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190222160306euoutp02a6d3801f01b101c7d4c5fdd40a3c038b~Fux6cTQip2234922349euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550851386;
        bh=c02xZuS25+CWlmvfyl8GNIqv8hILY4bTatyqwmrosaw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Zo7KeeLywPbvzWcPi14hkQEuc0Z3btSB59gl+YqcC+Fxqqfs0hSOmGqnAi/Til1h8
         hz5pTxaKGaOM/ns+M4jAy/dOjGJCzObSt9OhO1EAm1VsEyEn/0IA9H1KsjsRIG+7Mo
         CBXD+nHSZleVurqk9jPNgQd1QahnohSkEGaN0lYo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190222160305eucas1p17ed2d09b3ff8b0eb80410f51cbc77c19~Fux5euHw03190131901eucas1p18;
        Fri, 22 Feb 2019 16:03:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 50.FC.04441.93D107C5; Fri, 22
        Feb 2019 16:03:05 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190222160305eucas1p2357aaf3e5236ffeab966434d1dece674~Fux4vMLdi1619516195eucas1p2c;
        Fri, 22 Feb 2019 16:03:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190222160304eusmtrp2e32bf45c86b7e82f40080ab9c697f9e4~Fux4Wp8772518825188eusmtrp2y;
        Fri, 22 Feb 2019 16:03:04 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-ee-5c701d39be4d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D1.CB.04128.83D107C5; Fri, 22
        Feb 2019 16:03:04 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190222160303eusmtip167b261cad910748df4fa42877972b06f~Fux3xpxwK0974609746eusmtip1Z;
        Fri, 22 Feb 2019 16:03:03 +0000 (GMT)
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
Message-ID: <dbde3366-a115-3fe0-abb4-65ef0d8b760d@partner.samsung.com>
Date:   Fri, 22 Feb 2019 17:03:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221055601epcms1p7b87bba9a878683453f7e46c84ed032b9@epcms1p7>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3Z2OYrT47R8vcNEqLCZ0OWIIWkXzh8RUgSWQq48qbhN23Ga
        l2JTS/GG2ZimouZd0UwRb6SUysRESS0STRAyhqGJTi1LZs4zyf9+7/s+7/c+D3w4JprhueAx
        igRaqZDKxHxrbpd+e+KUv3t8+OmlKQ+yvaSNR+rWp7nklw0Dj6xXe5Pj6csCcrqvnE8a84cR
        2To8LyCn3lVxSOObb4ic0zTyyYHsBQ45tJzFI1dfMBdtqZaKFkSVqSe5VObArICq6lBRr9Y3
        edTqwGc+VdDZjChjh0cIfsf6QiQti0mklb6BEdbRBcVPOfFZXo/KamswNcp0y0FWOBBnQLvV
        wstB1riIaERgyvmKscUGgsblT4gtjAj09bvoYGVIX8g3s4hoQND03o0VrSDIHzPsDxyIm7Cz
        qOeYB46EDkHdlnG/wIhfGBS2vt57Csf5hAR6mh+aF4TEVZjfmheYmUt4Q5NGxzHzUSIUhvJ/
        IlZjD6MvF7lmtiKuQ75mbl+DEU4wu1hpYU/oXinHWKfbAsjNDWX5MoxUrVkSOMCPkU4By26w
        28vuAsHAeHYzn+U0yBrtsWgCYGhkkme2jBEnoK3Pl20HQYbRbBnfY1uYWbFnHdhCUVcxxraF
        kP1MxKqPQ2feR8uhY9DQohMUInHpoVylh7KUHspS+v9uFeI2IydaxcijaMZPQSdJGKmcUSmi
        JPfj5B1o77+NmUbWe9Dm1L1BROBIbCP8vRoXLuJJE5lk+SACHBM7CvWmvZYwUpqcQivj7ipV
        MpoZRK44V+wkTD2yECYioqQJdCxNx9PKgykHt3JRo0vOhu/PA3duFPVqO6urbaLstKnt558Y
        bMv+UMK12Noew2LwmI+9LuysKWT7ttzOuaS6csHB1dNfrs3DGj6EZ9+SPV41ra3I/OL76qb/
        9rs6SDRx6mGna5u1rfqkgIyKperoACztnE9kTUpEf8hESPqSJuiK5G23l11ljnvwA4OYy0RL
        /U5iSkb6D4Fl3TdrAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xu7oWsgUxBqsfKFlsnLGe1WLap8ss
        Fte/PGe1WNaganG26Q27xeVdc9gsPvceYbRYe+Quu8WlAwuYLD5veMxocbtxBZvFvo4HTBaH
        37SzWryfXOzA57Fm3hpGj9kNF1k8WvbdYvdYsKnUY+Gnr6we7/ddZfPo27KK0ePzJrkAjig9
        m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jL7prUwF
        7coVs5csZm5gbJHpYuTkkBAwkTh8bAJbFyMXh5DAUkaJiQ3f2SESYhKT9m2HsoUl/lzrgip6
        zSjx/dMRFpCEsECwxJ8nx5hAEiIC0xgl3h3oAutgFvjLLPFkhylExwxmiXVfr7B2MXJwsAno
        SexYVQhSwyvgJnH3212wehYBVYmVjdOYQGxRgQiJj0/3MUHUCEqcnPkEbBmngJ9Eb+NtJoj5
        ZhLzNj9khrDFJW49mQ8Vl5fY/nYO8wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLjfSK
        E3OLS/PS9ZLzczcxAqN627GfW3Ywdr0LPsQowMGoxMP7431+jBBrYllxZe4hRgkOZiUR3mP/
        gEK8KYmVValF+fFFpTmpxYcYTYGem8gsJZqcD0w4eSXxhqaG5haWhubG5sZmFkrivOcNKqOE
        BNITS1KzU1MLUotg+pg4OKUaGJdGJmxftfWToOZZjovpnb/UviXYST1aMmlF+arfrxfU33ew
        2VulOqH4ZsPntWJZaisXF99+rDtfQ+yUUnDz1s7cYzXlNg9l1LXzv77N67i65VbL0b1WJy/V
        3b6yMzUuzG/BhHW/723ybJYT++FpoGvU2u2jVch2JjrbZ/UVj/dflimEmH98N02JpTgj0VCL
        uag4EQCk1CzGAAMAAA==
X-CMS-MailID: 20190222160305eucas1p2357aaf3e5236ffeab966434d1dece674
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190212222436eucas1p21eebc80796406787a2ebf9a84ee5b868
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190212222436eucas1p21eebc80796406787a2ebf9a84ee5b868
References: <e5e9c6f0-5a1e-8ba1-556a-74edb1782980@partner.samsung.com>
        <1550010238-24002-6-git-send-email-l.luba@partner.samsung.com>
        <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <20190218043311epcms1p33ccb2c312e871294025171d97bb87ac6@epcms1p3>
        <CGME20190212222436eucas1p21eebc80796406787a2ebf9a84ee5b868@epcms1p7>
        <20190221055601epcms1p7b87bba9a878683453f7e46c84ed032b9@epcms1p7>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi MyungJoo,

On 2/21/19 6:56 AM, MyungJoo Ham wrote:
>>>
>>> There are some requirements that you need to consider:
>>>
>>> Is 30% really applicable to ALL devfreq devices?
>> The 30% load while the device is on lowest OPP is to filter some noise.
>> It might be tunable over sysfs for each device if you like.
>>>       - What if some devices do not want such behaviors?
>> They can set polling_idle_ms and polling_ms the same value.
>>>       - What if some devices want different values (change behavors)?
>> Need of sysfs tunable here.
>>>       - What if some manufactures want different default values?
>> Like above (sysfs).
>>>       - What if some devices want to let the framework know that it's in idle?
>> There might be a filed in devfreq->state which could handle this.
>>>       - What if some other kernel context, device (drivers),
>>>       or userspace process want to notify that it's no more idling?This issue is more related to the new movement in the 'interconnect'
>> development. They have a goal for this kind of interactions and QoS
>> between devices or their clients. In devfreq it would be possible
>> to tackle this, but would require a lot of changes (notification chain,
>> state machines in devices,
>>
>>>
>>> As mentioned in the internal thread (tizen.org),
>>> I'm not convinced by the idea of assuming that a device can be considered "idling"
>>> if it has simply "low" utilization.
>>>
>>> You are going to deteriorate the UI response time of mobile devices significantly.
>> Current devfreq wake-up also does not guarantee that, maybe on a single
>> CPU platform does.
> 
> Yes, the current devfreq does not enhance UI response time in the sense
> that it would keep the same reponse time anyway.
> 
> However, your current approach will surely deteriorate it by lengthen
> the polling latency.
> 
> For mobile and wearable devices, in many cases I've been witnessing,
> the device idles right before the user's input (launching an app,
> scrolling messages or web pages, or press a play button).
> For mitigation, we often relay UI inputs to DVFS mechanisms so that
> we either increase frequency for any UI inputs for a short period or
> shorten the polling latency for a short period.
> When a highly user-interactive device is idling or operating a low frequency,
> we should assume that it's going to be highly performing anytime;
> loosening the checking period is not a good solution in that sense
> although it is probable for servers or workstations.
> But, I don't think servers/workstations do care power consumption of
> DVFS checking loops anyway.
It is not just mobiles or servers (I agree servers are not in scope).
Devices like TVs, set-top-boxes, IP cameras, car IVI, they might care
about DVFS, but they do not have batteries (maybe a big car battery...).
They probably have more than 1 CPU and have some accelerators, which
they might register devfreq devices.
> 
> 
> 
>>
>> I will try to address your and Chanwoo's comments that the devfreq still
>> needs deferred polling in some platforms.
>> Would it be OK if we have two options: deferred and delayed work while
>> registering a wakeup for a device?
>> That would be a function like: polling_mode_init(devfreq) instead of
>> simple INIT_DEFERRED_WORK(), which will check the device's preference.
>> The device driver could set a filed in 'polling_mode' to enum:
>> POWER_EFFICIENT or RELIABLE_INTERVAL. For compatibility with old drivers
>> where the polling_mode = 0, SYSTEM_DEFAULT_POLLING_MODE (which is one
>> of these two) would be used.
>> Then the two-phase-polling-interval from this patch could only be used
>> for the RELIABLE_INTERVAL configuration or even dropped.
> 
> One thing I want to add is: let's not over-complicate it.
> Do you have any experimental results on how much power is saved by doing this?
> (and user response time losses)
No I don't have such results. Maybe it is not even worth to add this
two-phase-polling because the polling using DELAYED does not increase
the power consumption too much. Like for the device mentioned above.

Simplest first step.
What would you say to add just the possibility of choosing between:
INIT_DEFERRED_WORK() and INIT_DELAYED_WORK() in runtime via sysfs?
There would be also Kconfig which sets default.
No additional code for different custom polling modes.

Regards,
Lukasz
> 
> 
> Cheers,
> MyungJoo
> 
> 
> 
