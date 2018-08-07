Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6737C4646D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B9921A70
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bkNSw1Th"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B9921A70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732612AbeHGDrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 23:47:41 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:28699 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729786AbeHGDrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 23:47:41 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180807013545epoutp0219e02b1fae68f1ecf225332f4d5d65de~IdkzfXtLw3178431784epoutp02I;
        Tue,  7 Aug 2018 01:35:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180807013545epoutp0219e02b1fae68f1ecf225332f4d5d65de~IdkzfXtLw3178431784epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533605745;
        bh=W3N33v4Gb0lx/YhbPqmN/ZWE3lZxeAz/Kr+Dyo6mSmc=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=bkNSw1ThWMvGyrdpTOAka8JQERmKsz0nrJkpsdbk3f+rWVHM8sH1+NBXkWjPgHpTB
         awWG2Go2QfPYgYXh95faIrfEnHzK5UGeOE79QavHG4AwOFE9Kq0R0ENWjoJjB/buBD
         OYCKVBLjeg+LIZbhSs1Dx2vp5umdFQYSSa/hHqmk=
Received: from epsmges2p1.samsung.com (unknown [182.195.40.155]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180807013538epcas1p1466cd7946dc291a6418c6dbe3f8ab898~IdktOAXL_2499824998epcas1p1T;
        Tue,  7 Aug 2018 01:35:38 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.4A.04473.A67F86B5; Tue,  7 Aug 2018 10:35:38 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20180807013538epcas2p231cb4497ed145f40c06ad1d7b7839dc6~Idks8yItV0103001030epcas2p20;
        Tue,  7 Aug 2018 01:35:38 +0000 (GMT)
X-AuditID: b6c32a45-a43ff70000001179-e9-5b68f76a776e
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 27.B4.03824.A67F86B5; Tue,  7 Aug
        2018 10:35:38 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PD2005H1HRD1F90@mmp2.samsung.com>; Tue, 07 Aug 2018 10:35:38 +0900 (KST)
Message-id: <5B68F769.10302@samsung.com>
Date:   Tue, 07 Aug 2018 10:35:37 +0900
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
Subject: Re: [PATCH v5 05/12] PM / devfreq: Add support for policy notifiers
In-reply-to: <20180807002340.GC160295@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02TbUxTVxjHd3pfUTrPiswTFgVvQqIYkNtaOBhZlujmTSSGyD4YgdU7uKMV
        2pLeohM/iCCKmDHHiC9QEeZLtooOOqJAUGKtuODUAVbcEF/QkIYRFCtqNERvezHz0/k/z/k9
        J+f/zzksobtCx7AWm1Ny2MQijp5Dnru8NCVxy0tzdnJ/7wo8U9vL4EOPB0nsmXpC4WO+GxS+
        fuoSjVuGvQBXHP+dxtfLJxh8f/oKwINdLhoHf/ABfHKoX4ODrY8AHt71K437hoI0/uvaAIUr
        L/gY3DYtfKETWhpbgPDmdS0QGsr6SaFj5AQQPO59tHD3djct9BxtYYRbf5ZTQrt/LynUtLuB
        EPQsypy7SVpllsR8yREn2fLs+RZbQTq3Lsu02mRMSeYT+TScysXZRKuUzq3JyEz8ylKkWOPi
        topFJUorU5Rlbvnnqxz2EqcUZ7bLznQum+f1SXxyapJer6yG3JV6o4Jslsy+8rdMccN+8P3r
        3yLLwG5HNYhgEVyBHno8ZDWYw+pgB0BnBi4QavESoLrO/5j3VHfj4CzVCpDrwU0ytKGFn6BX
        P99TNMsSMBb5BgpDbQIuRYHntbP8CEAXf6mkVX4JcrtugxBPwnjkORXmaZiAegJ3wsg8uBj5
        Xz0CIR0NN6LOYy/Cd5ivjD5+cxOEziTgQQrtP/g2PBAFM9C9qiAV0hGQR1O1rUwIQrCPQWcP
        N9OqgzWoavAFpeooNH61fdbZZ2jM3QbUgb0APQ9UUGpxAKCnfX9oVMqAxpqrNaq3j1HV5Rkm
        ZAFBLarao1MRAe1uGmJUyz0EOv+wgTgAFtZ/kFL9/ynVf5BSEyDc4FOpWLYWSLK+mE+SRatc
        YitIyrNbPSD8hBO+7ACHb2R4AWQBF6mFJ8zZOkrcKm+3egFiCW6+VmtRWtp8cXup5LCbHCVF
        kuwFRiXkn4iY6Dy78iFsThNv1BsMBmxMTTMkp3ELtDvWZ2XrYIHolAolqVhyvJ/TsBExZSDW
        tXpo56Xx7l5rij9lWt8rukfu1xyyVHxXGN0M87+e/Me/a0HAVVgZOD4vZ5m3NGfts0nTnbzT
        ExM1ubGTfaWmb2q2zYz9PRE12rbz2sVlw2nxOVviN2XhUfutIxH+cTz1o36kbtGGUZ3m37Fz
        kV2Nbbry3Kaj8nDXR9+SdRsaO+9ypGwW+QTCIYvvADJgYlXYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t9jQd2s7xnRBqdfyFn8nXSM3WL6k8ss
        Fps+vme1mH/kHKvF2WUH2SzW3D7EaNG8eD2bxdmmN+wW978eZbS4vGsOm8Xn3iOMFkuvX2Sy
        +LzhMaPF7cYVbBanrn9mszhz+hKrReveI+wWG796OAh5rJm3htHj969JjB6zGy6yeOy4u4TR
        Y9OqTjaPO9f2sHnsn7uG3ePKiSZWjy1X21k8+rasYvT4vEkugDuKyyYlNSezLLVI3y6BK+NI
        03/2gtndjBW/VvI0MLYUdTFyckgImEjsmXeZpYuRi0NIYB2jxPtpd9hBErwCghI/Jt8DSnBw
        MAvISxy5lA1hqktMmZILUiEkcJ9R4vOEWohqDYlVc64xgpSwCKhKbFqWDRJmE9CS2P/iBhuI
        zS+gKHH1x2OwElGBCInuE5UgYRGgzie/zzOC2MwCM1glNl6IAbGFBXwk7nV8ZoU4bD+zxMmZ
        t5lBEpwChhIfJ21gn8AoMAvJnbMQ7pyFcOcCRuZVjJKpBcW56bnFRgVGeanlesWJucWleel6
        yfm5mxiBsbjtsFb/DsbHS+IPMQpwMCrx8AosyYgWYk0sK67MPcQowcGsJMLLmwkU4k1JrKxK
        LcqPLyrNSS0+xCjNwaIkzsuffyxSSCA9sSQ1OzW1ILUIJsvEwSnVwMgzd/4abZ2Zj2ZUO/ft
        33tW82BVS+TqNN+2d3ffc1c9FLq1pMtP9/Su7XfC3lUI3VaKn334gvemq18atdoVf9X7dPm/
        sP+RMC9P5rhjbNY3m+SYdZzy30tn9oW0hWYrPhTd5qgUU/T6zoVHCavuLr4btv/4Egfb5N45
        W7Tvbsy6OJd7od/8adJKLMUZiYZazEXFiQCLIKcIwQIAAA==
X-CMS-MailID: 20180807013538epcas2p231cb4497ed145f40c06ad1d7b7839dc6
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180802234831epcas5p3951e8f64381a27d40865d339878751d1
References: <20180731193953.GH68975@google.com>
        <5B610B48.4030802@samsung.com> <20180801170824.GJ68975@google.com>
        <5B626563.1090302@samsung.com> <20180802231343.GS68975@google.com>
        <CGME20180802234831epcas5p3951e8f64381a27d40865d339878751d1@epcas5p3.samsung.com>
        <20180802234820.GU68975@google.com> <5B639E76.6050901@samsung.com>
        <20180806192111.GB160295@google.com> <5B68CC34.8040102@samsung.com>
        <20180807002340.GC160295@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018년 08월 07일 09:23, Matthias Kaehlcke wrote:
> Hi Chanwoo,
> 
> On Tue, Aug 07, 2018 at 07:31:16AM +0900, Chanwoo Choi wrote:
>> Hi Matthias,
>>
>> On 2018년 08월 07일 04:21, Matthias Kaehlcke wrote:
>>> Hi Chanwoo,
>>>
>>> On Fri, Aug 03, 2018 at 09:14:46AM +0900, Chanwoo Choi wrote:
>>>> Hi Matthias,
>>>>
>>>> On 2018년 08월 03일 08:48, Matthias Kaehlcke wrote:
>>>>> On Thu, Aug 02, 2018 at 04:13:43PM -0700, Matthias Kaehlcke wrote:
>>>>>> Hi Chanwoo,
>>>>>>
>>>>>> On Thu, Aug 02, 2018 at 10:58:59AM +0900, Chanwoo Choi wrote:
>>>>>>> Hi Matthias,
>>>>>>>
>>>>>>> On 2018년 08월 02일 02:08, Matthias Kaehlcke wrote:
>>>>>>>> Hi Chanwoo,
>>>>>>>>
>>>>>>>> On Wed, Aug 01, 2018 at 10:22:16AM +0900, Chanwoo Choi wrote:
>>>>>>>>> On 2018년 08월 01일 04:39, Matthias Kaehlcke wrote:
>>>>>>>>>> On Mon, Jul 16, 2018 at 10:50:50AM -0700, Matthias Kaehlcke wrote:
>>>>>>>>>>> On Thu, Jul 12, 2018 at 05:44:33PM +0900, Chanwoo Choi wrote:
>>>>>>>>>>>> Hi Matthias,
>>>>>>>>>>>>
>>>>>>>>>>>> On 2018년 07월 07일 02:53, Matthias Kaehlcke wrote:
>>>>>>>>>>>>> Hi Chanwoo,
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Wed, Jul 04, 2018 at 03:41:46PM +0900, Chanwoo Choi wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>> Firstly,
>>>>>>>>>>>>>> I'm not sure why devfreq needs the devfreq_verify_within_limits() function.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> devfreq already used the OPP interface as default. It means that
>>>>>>>>>>>>>> the outside of 'drivers/devfreq' can disable/enable the frequency
>>>>>>>>>>>>>> such as drivers/thermal/devfreq_cooling.c. Also, when some device
>>>>>>>>>>>>>> drivers disable/enable the specific frequency, the devfreq core
>>>>>>>>>>>>>> consider them.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> So, devfreq doesn't need to devfreq_verify_within_limits() because
>>>>>>>>>>>>>> already support some interface to change the minimum/maximum frequency
>>>>>>>>>>>>>> of devfreq device. 
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> In case of cpufreq subsystem, cpufreq only provides 'cpufreq_verify_with_limits()'
>>>>>>>>>>>>>> to change the minimum/maximum frequency of cpu. some device driver cannot
>>>>>>>>>>>>>> change the minimum/maximum frequency through OPP interface.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> But, in case of devfreq subsystem, as I explained already, devfreq support
>>>>>>>>>>>>>> the OPP interface as default way. devfreq subsystem doesn't need to add
>>>>>>>>>>>>>> other way to change the minimum/maximum frequency.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Using the OPP interface exclusively works as long as a
>>>>>>>>>>>>> enabling/disabling of OPPs is limited to a single driver
>>>>>>>>>>>>> (drivers/thermal/devfreq_cooling.c). When multiple drivers are
>>>>>>>>>>>>> involved you need a way to resolve conflicts, that's the purpose of
>>>>>>>>>>>>> devfreq_verify_within_limits(). Please let me know if there are
>>>>>>>>>>>>> existing mechanisms for conflict resolution that I overlooked.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Possibly drivers/thermal/devfreq_cooling.c could be migrated to use
>>>>>>>>>>>>> devfreq_verify_within_limits() instead of the OPP interface if
>>>>>>>>>>>>> desired, however this seems beyond the scope of this series.
>>>>>>>>>>>>
>>>>>>>>>>>> Actually, if we uses this approach, it doesn't support the multiple drivers too.
>>>>>>>>>>>> If non throttler drivers uses devfreq_verify_within_limits(), the conflict
>>>>>>>>>>>> happen.
>>>>>>>>>>>
>>>>>>>>>>> As long as drivers limit the max freq there is no conflict, the lowest
>>>>>>>>>>> max freq wins. I expect this to be the usual case, apparently it
>>>>>>>>>>> worked for cpufreq for 10+ years.
>>>>>>>>>>>
>>>>>>>>>>> However it is correct that there would be a conflict if a driver
>>>>>>>>>>> requests a min freq that is higher than the max freq requested by
>>>>>>>>>>> another. In this case devfreq_verify_within_limits() resolves the
>>>>>>>>>>> conflict by raising p->max to the min freq. Not sure if this is
>>>>>>>>>>> something that would ever occur in practice though.
>>>>>>>>>>>
>>>>>>>>>>> If we are really concerned about this case it would also be an option
>>>>>>>>>>> to limit the adjustment to the max frequency.
>>>>>>>>>>>
>>>>>>>>>>>> To resolve the conflict for multiple device driver, maybe OPP interface
>>>>>>>>>>>> have to support 'usage_count' such as clk_enable/disable().
>>>>>>>>>>>
>>>>>>>>>>> This would require supporting negative usage count values, since a OPP
>>>>>>>>>>> should not be enabled if e.g. thermal enables it but the throttler
>>>>>>>>>>> disabled it or viceversa.
>>>>>>>>>>>
>>>>>>>>>>> Theoretically there could also be conflicts, like one driver disabling
>>>>>>>>>>> the higher OPPs and another the lower ones, with the outcome of all
>>>>>>>>>>> OPPs being disabled, which would be a more drastic conflict resolution
>>>>>>>>>>> than that of devfreq_verify_within_limits().
>>>>>>>>>>>
>>>>>>>>>>> Viresh, what do you think about an OPP usage count?
>>>>>>>>>>
>>>>>>>>>> Ping, can we try to reach a conclusion on this or at least keep the
>>>>>>>>>> discussion going?
>>>>>>>>>>
>>>>>>>>>> Not that it matters, but my preferred solution continues to be
>>>>>>>>>> devfreq_verify_within_limits(). It solves conflicts in some way (which
>>>>>>>>>> could be adjusted if needed) and has proven to work in practice for
>>>>>>>>>> 10+ years in a very similar sub-system.
>>>>>>>>>
>>>>>>>>> It is not true. Current cpufreq subsystem doesn't support external OPP
>>>>>>>>> control to enable/disable the OPP entry. If some device driver
>>>>>>>>> controls the OPP entry of cpufreq driver with opp_disable/enable(),
>>>>>>>>> the operation is not working. Because cpufreq considers the limit
>>>>>>>>> through 'cpufreq_verify_with_limits()' only.
>>>>>>>>
>>>>>>>> Ok, we can probably agree that using cpufreq_verify_with_limits()
>>>>>>>> exclusively seems to have worked well for cpufreq, and that in their
>>>>>>>> overall purpose cpufreq and devfreq are similar subsystems.
>>>>>>>>
>>>>>>>> The current throttler series with devfreq_verify_within_limits() takes
>>>>>>>> the enabled OPPs into account, the lowest and highest OPP are used as
>>>>>>>> a starting point for the frequency adjustment and (in theory) the
>>>>>>>> frequency range should only be narrowed by
>>>>>>>> devfreq_verify_within_limits().
>>>>>>>>
>>>>>>>>> As I already commented[1], there is different between cpufreq and devfreq.
>>>>>>>>> [1] https://lkml.org/lkml/2018/7/4/80
>>>>>>>>>
>>>>>>>>> Already, subsystem already used OPP interface in order to control
>>>>>>>>> specific OPP entry. I don't want to provide two outside method
>>>>>>>>> to control the frequency of devfreq driver. It might make the confusion.
>>>>>>>>
>>>>>>>> I understand your point, it would indeed be preferable to have a
>>>>>>>> single method. However I'm not convinced that the OPP interface is
>>>>>>>> a suitable solution, as I exposed earlier in this thread (quoted
>>>>>>>> below).
>>>>>>>>
>>>>>>>> I would like you to at least consider the possibility of changing
>>>>>>>> drivers/thermal/devfreq_cooling.c to devfreq_verify_within_limits().
>>>>>>>> Besides that it's not what is currently used, do you see any technical
>>>>>>>> concerns that would make devfreq_verify_within_limits() an unsuitable
>>>>>>>> or inferior solution?
>>>>>>>
>>>>>>> As we already discussed, devfreq_verify_within_limits() doesn't support
>>>>>>> the multiple outside controllers (e.g., devfreq-cooling.c).
>>>>>>
>>>>>> That's incorrect, its purpose is precisely that.
>>>>>>
>>>>>> Are you suggesting that cpufreq with its use of
>>>>>> cpufreq_verify_within_limits() (the inspiration for
>>>>>> devfreq_verify_within_limits()) is broken? It is used by cpu_cooling.c
>>>>>> and other drivers when receiving a CPUFREQ_ADJUST event, essentially
>>>>>> what I am proposing with DEVFREQ_ADJUST.
>>>>>>
>>>>>> Could you elaborate why this model wouldn't work for devfreq? "OPP
>>>>>> interface is mandatory for devfreq" isn't really a technical argument,
>>>>>> is it mandatory for any other reason than that it is the interface
>>>>>> that is currently used?
>>>>>>
>>>>>>> After you are suggesting the throttler core, there are at least two
>>>>>>> outside controllers (e.g., devfreq-cooling.c and throttler driver).
>>>>>>> As I knew the problem about conflict, I cannot agree the temporary
>>>>>>> method. OPP interface is mandatory for devfreq in order to control
>>>>>>> the OPP (frequency/voltage). In this situation, we have to try to
>>>>>>> find the method through OPP interface.
>>>>>>
>>>>>> What do you mean with "temporary method"?
>>>>>>
>>>>>> We can try to find a method through the OPP interface, but at this
>>>>>> point I'm not convinced that it is technically necessary or even
>>>>>> preferable.
>>>>>>
>>>>>> Another inconvenient of the OPP approach for both devfreq-cooling.c
>>>>>> and the throttler is that they have to bother with disabling all OPPs
>>>>>> above/below the max/min (they don't/shouldn't have to care), instead
>>>>>> of just telling devfreq the max/min.
>>>>>
>>>>> And a more important one: both drivers now have to keep track which
>>>>> OPPs they enabled/disabled previously, done are the days of a simple
>>>>> dev_pm_opp_enable/disable() in devfreq_cooling. Certainly it is
>>>>> possible and not very complex to implement, but is it really the
>>>>> best/a good solution?
>>>>
>>>>
>>>> As I replied them right before, Each outside driver has their own throttling
>>>> policy to control OPP entries. They don't care the requirement of other
>>>> driver and cannot know the requirement of other driver. devfreq core can only
>>>> recognize them and then only consider enabled OPP entris without disabled OPP entries.
>>>>
>>>> For example1,
>>>>        | devfreq-cooling| throttler
>>>> ---------------------------------------
>>>> 500Mhz | disabled       | disabled
>>>> 400Mhz | disabled       | disabled
>>>> 300Mhz |                | disabled
>>>> 200Mhz |                |
>>>> 100Mhz |                |
>>>> => devfreq driver can use only 100/200Mhz
>>>>
>>>>
>>>> For example2,
>>>>        | devfreq-cooling| throttler
>>>> ---------------------------------------
>>>> 500Mhz | disabled       | disabled
>>>> 400Mhz | disabled       |
>>>> 300Mhz | disabled       |
>>>> 200Mhz |                |
>>>> 100Mhz |                |
>>>> => devfreq driver can use only 100/200Mhz
>>>>
>>>>
>>>> For example3,
>>>>        | devfreq-cooling| throttler
>>>> ---------------------------------------
>>>> 500Mhz | disabled       | disabled
>>>> 400Mhz |                |
>>>> 300Mhz |                |
>>>> 200Mhz |                | disabled
>>>> 100Mhz |                | disabled
>>>> => devfreq driver can use only 300/400Mhz
>>>
>>> These are all cases without conflicts, my concern is about this:
>>>
>>>>        | devfreq-cooling| throttler
>>>> ---------------------------------------
>>>> 500Mhz | disabled       |
>>>> 400Mhz | disabled       |
>>>> 300Mhz |                | disabled
>>>> 200Mhz |                | disabled
>>>> 100Mhz |                | disabled
>>>> => devfreq driver can't use any frequency?
>>
>> There are no any enabled frequency. Because device driver
>> (devfreq-cooling, throttler) disable all frequencies.
>>
>> Outside drivers(devfreq-cooling, throttler) can enable/disable
>> specific OPP entries. As I already commented, each outside driver
>> doesn't consider the policy of other device driver about OPP entries.
> 
> And wouldn't it be preferable to have an interface that tries to avoid
> this situation in the first place and has a clear policy for conflict
> resolution?
> 
>> OPP interface is independent on devfreq and just control OPP entries.
>> After that, devfreq just consider the only enabled OPP entries.
>>
>>>
>>> Actually my above comment wasn't about this case, but about the
>>> added complexity in devfreq-cooling.c and the throttler:
>>>
>>> A bit simplified partition_enable_opps() currently does this:
>>>
>>> for_each_opp(opp) {
>>>   if (opp->freq <= max)
>>>      opp_enable(opp)
>>>   else
>>>      opp_disable(opp)
>>> }
>>>
>>> With the OPP usage/disable count this doesn't work any longer. Now we
>>> need to keep track of the enabled/disabled state of the OPP, something
>>> like:
>>>
>>> dev_pm_opp_enable(opp) {
>>>   if (opp->freq <= max) {
>>>     if (opp->freq > prev_max)
>>>       opp_enable(opp)
>>>   } else {
>>>     if (opp->freq < prev_max)
>>>       opp_disable(opp)
>>>   }
>>> }
>>>
>>> And duplicate the same in the throttler (and other possible
>>> drivers). Obviously it can be done, but is there really any gain
>>> from it?
>>>
>>> Instead they just could do:
>>>
>>> devfreq_verify_within_limits(policy/freq_pair, 0, max_freq)

I have a new question about using devfreq_verify_within_limits().

For example,
Driver A has following opp-table
- 500Mhz
- 400Mhz
- 300Mhz
- 200Mhz
- 100Mhz

Basically, driver A has following init value:
- policy->min is 100
- policy->max is 500

Driver B, devfreq_verify_within_limits(200, 300)
	policy->min is 200
	policy->max is 300
Driver C, devfreq_verify_within_limits(300, 400)
	policy->min is 300
	policy->max is 300
Driver D, devfreq_verify_within_limits(400, 500)
	policy->min is 400
	policy->max is 400

In result, it looks like the requirement of Driver B are disappeared.
is it the intention of devfreq_verify_within_limits()?

>>>
>>> without being concerned about implementation details of devfreq.
>>>
>>
>> I don't think so.
> 
> What are you referring to, the change that I claim that will be needed
> in partition_enable_opps() when OPPs have usage/disable counts? If so,
> how do you avoid that the function doesn't enable/disable an OPP that
> was already enabled/disabled in the previous iteration?

Just about changes of "dev_pm_opp_enable(opp)".

> 
>> dev_pm_opp_enable()/dev_pm_opp_disable() have to consider only one
>> OPP entry without any other OPP entry.
> 
> I agree with this :)
> 
>> dev_pm_opp_enable()/dev_pm_opp_disable() can never know the other
>> OPP entries. After some driver(devfreq-cooling.c and throttler) 
>> enable or disable specific OPP entries, the remaining OPP entry 
>> with enabled state will be considered on devfreq driver.
> 
> Having multiple drivers (or even a single one) enable and disable
> OPPs independently and at the time of their choosing sounds like a
> recipe for race conditions.
> 
> What happens if e.g. the devfreq core calls
> dev_pm_opp_find_freq_ceil/floor() and right after returning another
> driver disables the OPP? devfreq uses the disabled OPP. Probably not a\

devfreq doesn't use the disabled OPP.

For example,
1. devfreq-cooling.c disable/enable some OPP and OPP send notification about OPP changes.
2. devfreq receives the notification (devfreq_notifier_call() is executed)
3. devfreq_notifier_call() try to find scaling_min_freq/scaling_max_freq
4. devfreq_notifier_call() executes update_devfreq() in order to apply the OPP changes.
5. devfreq can consider only enabled frequencies right after dev_pm_opp_disable/enable()

> big deal if disabling the OPP is only a semantic question, but I
> imagine there can be worse scenarios. Currently the only user of
> dev_pm_opp_disable() besides devfreq_cooling.c is imx6q-cpufreq.c, and
> it is well behaved and only disables OPPs during probe().

imx6q-cpufreq.c used the dev_pm_opp_disable() before calling dev_pm_opp_init_cpufreq_table(). After registered cpufreq_register_driver(), imx6q-cpufreq.c doesn't use the dev_pm_opp_disable/enable(). It means that dev_pm_opp_disable() of imx6q-cpufreq.c doesn't affect the frequency choice of cpufreq on the runtime after registered cpufreq driver.

On the other hand, devfreq_cooling.c use dev_pm_opp_disable/enable() on the runtime after registering devfreq driver. It affect the frequency choice of devfreq on the runtime.

> 
> I keep missing a clear answer to the question in which sense
> manipulating the OPPs in devfreq_cooling.c is superior over narrowing
> down the frequency during DEVFREQ_ADJUST, which would avoid potential
> races and allow to resolve conflicts. Does it allow for some

You mentioned the race conditions eariler. Actually, I don't know the potential races.

> functionality that couldn't be achieved otherwise, does it make the
> code significantly less complex, is some integration with the OPP
> subsystem needed that I'm overlooking, is it more efficient, ...?
> 
> I'm not just insisting because I'm stubborn. I'd be happy to use any
> interface that fits the bill, or to adjust one to fit the bill, but as
> of now I mainly see drawbacks on the OPPs side and haven't seen
> convincing arguments that it is really needed in devreq_cooling.c or a
> better solution.

During we discussed, we knew that OPP doesn't provide all operation perfectly. As of now, OPP is standard framework to control the pair of frequency/voltage. devfreq need to use OPP to the pair of frequency/voltage. Even if OPP doesn't provide all of our requirements, I think that devfreq should use OPP interface after updating OPP framework, instead of adding other functionality to control frequency in outside driver(devfreq-cooling.c, throttler).

Finally,
I asked to Viresh (OPP maintainer). If dev_pm_opp_enable() and dev_pm_opp_disable() don't support the usecase on multiple device drivers, opp interface could not be used in order to support both devfreq-cooling.c and throttler. So, We better to wait the opinion from OPP maintainer.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
