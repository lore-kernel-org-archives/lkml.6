Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA23CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979C921B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O02kSG4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbfBNXmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:42:39 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:62540 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfBNXmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:42:38 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190214234234epoutp02ce0a975d90c051910692b796ac919bef~DX4y64Plr1857118571epoutp02E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 23:42:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190214234234epoutp02ce0a975d90c051910692b796ac919bef~DX4y64Plr1857118571epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550187754;
        bh=d2gwwTniVcaEAKwnCw47Sn/MDZ42s5E9VDK7JGV/X6Y=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=O02kSG4r8hs9Ug4XpFTtd/NWXo0VX8ID6X67hsOAsH/uEVC1aZlvZcTAzQMHm+73M
         menHjF/M3U1CUi1Am72p4GopAlhuEHfowXmKG58uc+FThLdoAxTmRJuNLbT05qwooq
         npQWkdnGTfAiDFF+/xXPuSvSFQS7mCd3D5xf3TCU=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190214234231epcas1p12b7a66a46d06548e21c647536e656d0f~DX4vz4ie10332103321epcas1p10;
        Thu, 14 Feb 2019 23:42:31 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.06.04074.7ECF56C5; Fri, 15 Feb 2019 08:42:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190214234230epcas1p4c03a70dbc11e9f3b6cecb3127416cd07~DX4vN51Da0907309073epcas1p4P;
        Thu, 14 Feb 2019 23:42:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190214234230epsmtrp23c6eb517d7cd7f114df74b5442f278ae~DX4vMl8ZY0986209862epsmtrp2M;
        Thu, 14 Feb 2019 23:42:30 +0000 (GMT)
X-AuditID: b6c32a35-297ff70000000fea-99-5c65fce7bb9c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.DE.03971.6ECF56C5; Fri, 15 Feb 2019 08:42:30 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190214234230epsmtip1ab82dccde2225302453ad74545d93f1b~DX4u86dRf2197321973epsmtip12;
        Thu, 14 Feb 2019 23:42:30 +0000 (GMT)
Subject: Re: [PATCH 4/4] PM / devfreq: Handle monitor start/stop in the
 devfreq core
To:     Matthias Kaehlcke <mka@chromium.org>,
        Chanwoo Choi <cwchoi00@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Lukasz Luba <l.luba@partner.samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b28e763d-c3c9-0673-6216-f67561112b60@samsung.com>
Date:   Fri, 15 Feb 2019 08:42:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214192855.GD117604@google.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmge7zP6kxBsteiVk8O6pt0TJrEYvF
        2aY37Ba3GmQsLu+aw2bxufcIo0Xnl1lA1obHjBa3G1ewWfzcNY/FgctjdsNFFo+ds+6ye/Q2
        v2PzOPhuD5NH35ZVjB6fN8kFsEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgr
        KeQl5qbaKrn4BOi6ZeYAHaakUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKbAs0CtO
        zC0uzUvXS87PtTI0MDAyBSpMyM6Y//82c0GPSMW2L99ZGxhbBLoYOTkkBEwkVr57xdzFyMUh
        JLCDUaLnxiEo5xOjxJqzv5hAqoQEvjFKXJgkBtPRM6+LCaJoL6PEkxkLWCCK3jNKfJumA2IL
        C4RJvP+4hQ3EFhHwlvj7fyUbSAOzwHkmiRfXnjKCJNgEtCT2v7gBVsQvoChx9cdjsDivgJ3E
        hTW/gIZycLAIqEq87HUDCYsKREgc7n0HVSIocXLmE7C9nAKGEm0fVoHZzALiEreezGeCsOUl
        mrfOBvtGQqCbXeLUptksEB+4SMyZ18EOYQtLvDq+BcqWkvj8bi8bhF0tsfLkETaI5g5GiS37
        L7BCJIwl9i+dzARyHLOApsT6XfoQy/gk3n3tYQUJSwjwSnS0CUFUK0tcfnCXCcKWlFjc3gk1
        3kNi89+jbBMYFWcheWcWkhdmIXlhFsKyBYwsqxjFUguKc9NTiw0LDJEjexMjOM1qme5gnHLO
        5xCjAAejEg/viozUGCHWxLLiytxDjBIczEoivNcfAoV4UxIrq1KL8uOLSnNSiw8xmgIDeyKz
        lGhyPjAH5JXEG5oaGRsbW5gYmpkaGiqJ8653cI4REkhPLEnNTk0tSC2C6WPi4JRqYFQN+a5r
        G8r+50bAx5kS+xzOH7gdf/d9cv1uZd7FvjdO/HvWGq13LpfbrJH1+1X3V37f+xJrZL4zvrif
        H+D2supf4A03jsctN1apMcS8Nblcr7D96oH23sC4EH6OH6cSV6bxC2kYeMgHhkl5n9Kurzwf
        /VmqfKLO+gOpHlJxpyWaJ7K0rS2NVGIpzkg01GIuKk4EACfl/z/JAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWy7bCSnO6zP6kxBrOnaFk8O6pt0TJrEYvF
        2aY37Ba3GmQsLu+aw2bxufcIo0Xnl1lA1obHjBa3G1ewWfzcNY/FgctjdsNFFo+ds+6ye/Q2
        v2PzOPhuD5NH35ZVjB6fN8kFsEVx2aSk5mSWpRbp2yVwZcz/f5u5oEekYtuX76wNjC0CXYyc
        HBICJhI987qYuhi5OIQEdjNK/HnYxgyRkJSYdvEokM0BZAtLHD5cDFHzllHi1ZW3TCA1wgJh
        Eu8/bmEDsUUEvCX+/l/JBlLELHCZSaJ79y+oqUuZJG7/WM0KUsUmoCWx/8UNsA5+AUWJqz8e
        M4LYvAJ2EhfW/GIB2cYioCrxstcNJCwqECHx8ek+JogSQYmTM5+wgNicAoYSbR9WgdnMAuoS
        f+ZdYoawxSVuPZnPBGHLSzRvnc08gVF4FpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GLDAsO8
        1HK94sTc4tK8dL3k/NxNjOCY09LcwXh5SfwhRgEORiUe3hUZqTFCrIllxZW5hxglOJiVRHiv
        PwQK8aYkVlalFuXHF5XmpBYfYpTmYFES532adyxSSCA9sSQ1OzW1ILUIJsvEwSnVwLhk/vlU
        5v51hix/Rd52buEUf3S/g3tl5N/PyYePv4uJUF3Q+WjKF3OGykgZFunZphOklpc0ymeqxLv9
        3rSWNfX47BVHZcy3iy8z4f5pw3V309t/m+8c3By4JbxM9ZDl0YTXlz8sa1mkxMm5mONVmJGi
        e81tpYaUA4eqTWyX2v6e9mfvkv7XSUpKLMUZiYZazEXFiQD/PgL3tQIAAA==
X-CMS-MailID: 20190214234230epcas1p4c03a70dbc11e9f3b6cecb3127416cd07
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190214192933epcas5p204c34010accb5e63480abd3ca34991eb
References: <20190214013042.254790-1-mka@chromium.org>
        <20190214013042.254790-5-mka@chromium.org>
        <CAGTfZH118diXgKHetWwiNMXHALxXqt=MSh9oVv+nt4-SJkzN2Q@mail.gmail.com>
        <CGME20190214192933epcas5p204c34010accb5e63480abd3ca34991eb@epcas5p2.samsung.com>
        <20190214192855.GD117604@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 19. 2. 15. 오전 4:28, Matthias Kaehlcke wrote:
> Hi Chanwoo,
> 
> On Thu, Feb 14, 2019 at 11:17:36PM +0900, Chanwoo Choi wrote:
>> Hi Matthias,
>>
>> As I commented on the first patch, it is not possible to call some codes
>> according to the intention of each governor between 'devfreq_moniotr_*()'
>> and some codes which are executed before or after 'devfreq_moniotr_*()'
>>
>> For example, if some governor requires the following sequence,
>> after this patch, it is not possible.
>>
>> case DEVFREQ_GOV_xxx:
>>         /* execute some code before devfreq_monitor_xxx() */
>>         devfreq_monitor_xxx()
>>         /* execute some code after devfreq_monitor_xxx() */
> 
> As for the suspend/resume case I agree that the patch introduces this
> limitation, but I'm not convinced that this is an actual problem.
> 
> For governor_start(): why can't the governor execute the code
> before polling started, does it make any difference to the governor
> that a work is scheduled?

The some governors might want to do something before starting
the work and do something after work started. I think that
the existing style is more flexible.

And,
It has one more problem when changing the governor on the fly
from simple_ondemand to other governors like performance,
powersave and so on.

Even if other governors don't need to monitor the utilization,
the work timer will be executed continually because the devfreq
device has the polling_ms value. It is not necessary
of the other governors such as performance, powersave.

It means that only specific governor like simple_ondemand
have to call the devfreq_monitor_start() by itself
instead of calling it on devfreq core.

> 
> For governor_stop(): why would the governor require polling to be
> active during stop? If it needs update_devfreq() to run (called by
> devfreq_monitor()) it can call it directly, instead of waiting for the
> monitor to run at some later time.

As I knew, if the current governors are performance/powersave/
userspace, the monitoring is already stopped and not used.
Because they don't need to handle the codes related to the work
like queue_delayed_work(), cancel_delayed_work_sync().

And,
In case of the existing style for calling devfreq_monitor_*(),
other governors like performance/powersave/userspace/passice
don't need to call the devfreq_monitor_stop() because they
didn't use the work timer.

> 
> Cheers
> 
> Matthias
> 
> 
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
