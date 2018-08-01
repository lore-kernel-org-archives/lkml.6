Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E307BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DC22083E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KvzbQXyP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DC22083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388212AbeHAKDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:03:18 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:18392 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387860AbeHAKDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:03:18 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180801081844epoutp02deb48b1011082750ac5664500a7ecd28~GtM77Zznc1706617066epoutp022;
        Wed,  1 Aug 2018 08:18:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180801081844epoutp02deb48b1011082750ac5664500a7ecd28~GtM77Zznc1706617066epoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533111524;
        bh=bMb5GM13SsWefgabLtDaSdTBJzW5AL7Rnyd0cMXBFIU=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=KvzbQXyPwYDcxFksdoTGaWf4g9qWsLTnq68vRGArvJ7pkiBh0m/h3qSqeGjV3m+Xv
         5JVKsrS5QZNhTF5OiKLYvz99Cf8j23SYT73mB9o9/DQWiEN6ldQSjAqv5hKb7jhG72
         juMlhEUPUyn6IUh9HMyBs0yEQFAQD7DaB8HTJK98=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20180801081841epcas1p35aaab5835515ed204449c83bc5d1a3e4~GtM5PlaAG3018430184epcas1p3c;
        Wed,  1 Aug 2018 08:18:41 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.AA.04292.1EC616B5; Wed,  1 Aug 2018 17:18:41 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180801081841epcas1p1378cdfeb85e80d8ea163b97d79cc6b5e~GtM4_QDEk1836018360epcas1p1b;
        Wed,  1 Aug 2018 08:18:41 +0000 (GMT)
X-AuditID: b6c32a38-d53ff700000010c4-93-5b616ce176d5
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 29.52.03704.0EC616B5; Wed,  1 Aug
        2018 17:18:40 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PCR006YYWF48160@mmp2.samsung.com>; Wed, 01 Aug 2018 17:18:40 +0900 (KST)
Message-id: <5B616CE0.50400@samsung.com>
Date:   Wed, 01 Aug 2018 17:18:40 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5 07/12] PM / devfreq: export devfreq_class
In-reply-to: <20180731192904.GG68975@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHd3qf6DqP9XXEB3gzjbJQe1tazxw1+FpuojFk/KM2s97BDSB9
        pbcQ2f5hEmWrQhAjZJ0MfG2GVMcqUXBFBKooiEp9QESdjs7hcw9AnY5tbW/M/Ov8zu98vr+c
        7zfnsIQmRCey+Q6P5HaINo6eQJ7oXLQ49Z5NtOiGTk7G41XnGFwTuUriwB+/UbgudInCvd+2
        09g/2AFw6cHvady77TGDfxo7C/DVU/toPFIeAvhwf58KjzQOATz4+REad/eP0PhiT5jC21tD
        DP5hTMjQCP5v/EB49bIKCF+X9JFC8+1DQAg0fEkLt24EaaGt1s8I185vo4Sm62WkUNHUAISR
        wNzMiRul9DxJzJHcyZIj25mT78g1c2uyrCutRpOOT+Xfx0u4ZIdol8zcqrWZqR/m26LWuOQi
        0VYYbWWKsswtXpbudhZ6pOQ8p+wxcxae12t53RKtXh9dDR8v1RujyGYp71lpNePanbS1K9JO
        lIDymV6QwCKYhgL7z1BeMIHVwGaAentukrEDDXwOUKR/xWtotK6HUaBGgPy9vzKxAzWcjF7s
        uRMVsCwBk1AoXBBrE3ARGh6tIhX+NkCBH6uAwi9EtU92EbGahPNRQ8Wz+BwapqC24QE6Vk+C
        89D1F0Nxfhpcj1rqFGZqVBt5dRnEhhKwmkI7q/+NC6bADDRwuisOJUAdao200DEIwW4GeVvO
        kYqFVehC5XeMUk9BD7uamNitEZyFwmfNCl8G0OhwKaVsKgH6vfu4ShEY0P39XpXi7R30dGwX
        pYjV6IsdGgUR0EBbOa1YHlehzmAtUQnm+N5Iyfd/Sr43UqoHRAOYLrlke64k8640rSza5UJH
        rjbbaQ+A+AtOwc0geGltB4As4N5Wu4o3WzSUWCQX2zsAYgluqjp9ttWiUeeIxZ9KbqfVXWiT
        5A5gjIa8m0iclu2M/geHx8ob9QaDAafxJiPPczPU+nVZFg3MFT1SgSS5JPdrnYpNSCwBxgf7
        2Jq9GYP/sMf+ksOB1udZCwZ9j1Zri9hs3dG/Ny3Vz9gJ6+9OOjC+Q798w4pZd9/NrzelbTrz
        3vF7jYc/WvmkAm6f7frkgyTvL5Wr+yae+Mx0fk/SWxY2a2vRzwOpDzKv3I90mvbWFvdce0kG
        vwrPLOvbsHFu3ak/C9prDm0xU8uDPo6U80Q+hXDL4n9p0Ume1wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t9jQd0HOYnRBkdeW1v8nXSM3WL6k8ss
        Fps+vme1mH/kHKvF2WUH2SzW3D7EaNG8eD2bxdmmN+wW978eZbS4vGsOm8Xn3iOMFkuvX2Sy
        +LzhMaPF7cYVbBanrn9mszhz+hKrReveI+wWG796OAh5rJm3htHj969JjB6zGy6yeOy4u4TR
        Y9OqTjaPO9f2sHnsn7uG3ePKiSZWjy1X21k8+rasYvT4vEkugDuKyyYlNSezLLVI3y6BK+Nb
        8zT2gonyFcefHGRuYOyV7GLk5JAQMJH4Mv80excjF4eQwDpGiefXD7CBJHgFBCV+TL7H0sXI
        wcEsIC9x5FI2hKkuMWVKLkT5fUaJhs+zWCHKNSTmvu1hBrFZBFQlVvV9Ywex2QS0JPa/uAE2
        kl9AUeLqj8eMIHNEBSIkuk9UgoRFgFqf/D7PCGIzC8xgldh4IQbEFhZwkLix7zjUaX+ZJN7/
        XQO2i1PAQGLvk51sExgFZiG5dBbCpbMQLl3AyLyKUTK1oDg3PbfYqMAwL7Vcrzgxt7g0L10v
        OT93EyMwHrcd1urbwXh/SfwhRgEORiUe3hPVCdFCrIllxZW5hxglOJiVRHhtZOKjhXhTEiur
        Uovy44tKc1KLDzFKc7AoifPezjsWKSSQnliSmp2aWpBaBJNl4uCUamCUufQ+1OqD8GvVc9dy
        Pl95I7ZruliBUqaPT8jKlfc61bdNbbwzqWJfW9Gu8qpCaaMltue6mJ1WH3w6d8KGnwaXH0a9
        2lgr+9JcT9Exd/4JxZy16X9LNu85sIhXLExv9cHnLH+vbBS4Khio9tFUv2P2vi/6pb+3d05q
        WPbvls8eI94Zu6+bs7gGKLEUZyQaajEXFScCAOU/ZOnDAgAA
X-CMS-MailID: 20180801081841epcas1p1378cdfeb85e80d8ea163b97d79cc6b5e
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180703234837epcas5p1da751e0394c16816b95ac1956bf6de20
References: <20180703234705.227473-1-mka@chromium.org>
        <CGME20180703234837epcas5p1da751e0394c16816b95ac1956bf6de20@epcas5p1.samsung.com>
        <20180703234705.227473-8-mka@chromium.org> <5B3C5B78.6020401@samsung.com>
        <20180706180923.GH129942@google.com>
        <41164a91-b271-5f3b-b461-21ff5997cc84@samsung.com>
        <20180716194114.GA129942@google.com> <20180731192904.GG68975@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018년 08월 01일 04:29, Matthias Kaehlcke wrote:
> On Mon, Jul 16, 2018 at 12:41:14PM -0700, Matthias Kaehlcke wrote:
>> Hi Chanwoo,
>>
>> On Thu, Jul 12, 2018 at 06:08:36PM +0900, Chanwoo Choi wrote:
>>> Hi Matthias,
>>>
>>> On 2018년 07월 07일 03:09, Matthias Kaehlcke wrote:
>>>> Hi,
>>>>
>>>> On Wed, Jul 04, 2018 at 02:30:32PM +0900, Chanwoo Choi wrote:
>>>>
>>>>> I didn't see any framework which exporting the class instance.
>>>>> It is very dangerous. Unknown device drivers is able to reset
>>>>> the 'devfreq_class' instance. I can't agree this approach.
>>>>
>>>> While I agree that it is potential dangerous it is actually a common
>>>> practice to export the class:
>>>>
>>>
>>> I tried to find the real usage of exported class instance
>>> and I add the comment for each class instance. Almost exported class
>>> instance are used in the their own director or some exported class
>>> like rio_mport_class/switchtec_class are created from specific device driver
>>> instead of subsystem.
>>>
>>> Only following two cases are used on outside of subsystem directory.
>>> devtmpfs.c and alarmtimer.c are core feature of linux kernel.
>>>
>>> 	drivers/base/devtmpfs.c uses 'block_class'.
>>> 	kernel/time/alarmtimer.c uses 'rtc_class'.
>>>
>>> I cannot yet agree this approach due to only block_class and rtc_class.
>>
>> I thought your main concern was that the class is exported, which is
>> what several other subsystems do. That the class isn't used outside of
>> the subsystem directory most likely means that there is no need for
>> it, rather than that it shouldn't be done at all (depending on the
>> type of use of course).
>>
>> In any case not exporting the class object provides a limited
>> protection against potential abuse of the class at best. To use the
>> class API all that is needed is a 'struct device' of a devfreq device,
>> which has a pointer to the class object (dev->class).
>>
>> Theoretically I could register a fake devfreq device to obtain access
>> to the class object, though that doesn't seem a very neat approach ;-)
>>
>>> You added the following comment why devfreq_class instance is necessary.
>>> Actullay, I don't know the best solution right now. But, all device drivers
>>> can be added or removed if driver uses the module type. It is not a problem
>>> for only devfreq instance.
>>
>> Certainly it's not a problem limited to devfreq devices. In many other
>> cases bus notifiers can be used, but since devfreq devices areen't
>> tied to a specific bus this is not an option here.
>>
>> If you really don't want to export the class we could add wrappers
>> for (un)registering a class interface:
>>
>> int devfreq_class_interface_register(struct class_interface *)
>> void devfreq_class_interface_unregister(struct class_interface *)

About this approach, I agree because it doesn't export the devfreq_class
instance as you commented.


>>
>> The wrappers would have to assign ci->class since the throttler
>> can't see the class object.
>>
>> Or add notifiers for device addition/removal, though the throttler
>> relies on the behavior of the class_interface which also notifies
>> about devices added before registration. This might not be what other
>> potential users of the notifiers expect.
> 
> Ping
> 
> Could we please try to find a solution/reach a conclusion for this?
> 
> Not that it should affect the outcome of this discussion, but I want
> to mention that from my point of view it is a bit unfortunate that
> this and other fundamental concerns were only raised after I spent
> significant time on repeatedly refactoring the throttler driver to
> address other comments. Since you and MyungJoo Ham previously had only
> minor comments on the other devfreq patches in this series I assumed
> there were no major concerns from your side :(
> 
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
