Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3FDC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 23:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D1A215F0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 23:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rWQ6qEms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D1A215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbeHCBug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:50:36 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:54408 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731311AbeHCBug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:50:36 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180802235701epoutp0270bfe7c749d95ad3ceb650b41bb4df11~HNpdXcfE02020720207epoutp02I;
        Thu,  2 Aug 2018 23:57:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180802235701epoutp0270bfe7c749d95ad3ceb650b41bb4df11~HNpdXcfE02020720207epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533254221;
        bh=l2rwHfD5lQJ80vxSOg769hB6VKliIcmpeddecwEB9Xk=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=rWQ6qEms6Rm5TxoPwerBw1XCt5jPhRb606w/PWJGB9RQzTB9qH1Qc7p/xytOdWsGF
         bLVyo0qQ2glXbH9gY/huv5u2N0zMKOfCjdBlvrcyU7plIU44qX9fNzVDKdxtoGR0QL
         D1TwqCq3f4eDPc6UA9viD0nLgBjLJs45GM8599sk=
Received: from epsmges2p1.samsung.com (unknown [182.195.40.158]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20180802235659epcas1p33023b3a4079ba1b4566786150315e775~HNpbAj6Ri0124701247epcas1p30;
        Thu,  2 Aug 2018 23:56:59 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.08.04473.B4A936B5; Fri,  3 Aug 2018 08:56:59 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20180802235658epcas2p233523a34b074a86031b63c716b66ce55~HNpaaQCE92613426134epcas2p25;
        Thu,  2 Aug 2018 23:56:58 +0000 (GMT)
X-AuditID: b6c32a45-a2bff70000001179-d7-5b639a4bb86f
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 07.02.03824.A4A936B5; Fri,  3 Aug
        2018 08:56:58 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PCU00M64YIXLHA0@mmp2.samsung.com>; Fri, 03 Aug 2018 08:56:58 +0900 (KST)
Message-id: <5B639A49.3060804@samsung.com>
Date:   Fri, 03 Aug 2018 08:56:57 +0900
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
In-reply-to: <20180802231343.GS68975@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmua73rORogzuTOC3+TjrGbjH9yWUW
        i00f37NazD9yjtXi7LKDbBZrbh9itGhevJ7N4mzTG3aL+1+PMlpc3jWHzeJz7xFGi6XXLzJZ
        fN7wmNHiduMKNotT1z+zWZw5fYnVonXvEXaLjV89HIQ81sxbw+jx+9ckRo/ZDRdZPHbcXcLo
        sWlVJ5vHnWt72Dz2z13D7nHlRBOrx5ar7SwefVtWMXp83iQXwB2VapORmpiSWqSQmpecn5KZ
        l26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkD9JqSQlliTilQKCCxuFhJ386mKL+0
        JFUhI7+4xFYp2tDQSM/QwFzPyAhIG8daGZkClSSkZuw/v5a94GNqxYsp+5kbGHtCuhg5OSQE
        TCSOP7nK3sXIxSEksINR4srXRjYI5zujRMvMU0AOB1jV+14/iPgGRonfG9vYQbp5BQQlfky+
        xwJSwywgL3HkUjZImFlAU+LFl0ksILaQwF1GiQOXwUp4BbQkjj7yBwmzCKhK3D74lhnEZgMK
        739xgw3E5hdQlLj64zEjiC0qECGxc/43sE0iAhoST36fZwQ5gVlgGqtE97T/YA3CAj4S9zo+
        s4LYnAIGEo8v/mcBKZIQOMUucf39AzaIL10kGl9NZYWwhSVeHd/CDmFLSzxbtZERoqGdUeLL
        i2ZWCGcCo8SHU5uZIKqMJZ4t7GKCeI1PouPwX3ZIqPBKdLQJQZgeEtMm1kIC6BazxNErDWwT
        GGVnIYXRLEQYzUIKowWMzKsYxVILinPTU4uNCgz1ihNzi0vz0vWS83M3MYLTr5brDsYZ53wO
        MQpwMCrx8F5QTY4WYk0sK67MPcQowcGsJML7thMoxJuSWFmVWpQfX1Sak1p8iNEUGMgTmaVE
        k/OBuSGvJN7Q1MjY2NjC1NzS2MBSSZy32i84WkggPbEkNTs1tSC1CKaPiYNTqoFR6vv1ZubW
        113X+tK5Lh991xuSX+n35YpCIb/X7If1HC/tucOD9G79XcN1Yp/F4a+q+auNTU8HCi+/99ro
        VX7PfJuPxVZher1XN+nrO5sIsO9eKj/rxhLzms7824EzGeQPWpRybw7gnm015bs/T4nqb6Gt
        u1gdLO4e0N2x74TLoU/aN+5rnn+nxFKckWioxVxUnAgAVbQyVdUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t9jQV2vWcnRBnvOyVn8nXSM3WL6k8ss
        Fps+vme1mH/kHKvF2WUH2SzW3D7EaNG8eD2bxdmmN+wW978eZbS4vGsOm8Xn3iOMFkuvX2Sy
        +LzhMaPF7cYVbBanrn9mszhz+hKrReveI+wWG796OAh5rJm3htHj969JjB6zGy6yeOy4u4TR
        Y9OqTjaPO9f2sHnsn7uG3ePKiSZWjy1X21k8+rasYvT4vEkugDuKyyYlNSezLLVI3y6BK2P/
        +bXsBR9TK15M2c/cwNgT0sXIwSEhYCLxvtevi5GLQ0hgHaPE1393mLoYOTl4BQQlfky+xwJS
        wywgL3HkUjaEqS4xZUouRPl9Rolfnw8ygcR5BbQkjj7yB+lkEVCVuH3wLTOIzQYU3v/iBhuI
        zS+gKHH1x2NGkHJRgQiJ7hOVIGERAQ2JJ7/PM4LYzAIzWCU2XogBsYUFfCTudXxmhVh1h1li
        68pj7CAJTgEDiccX/7NMYBSYheTQWQiHzkI4dAEj8ypGydSC4tz03GKjAqO81HK94sTc4tK8
        dL3k/NxNjMBY3HZYq38H4+Ml8YcYBTgYlXh4L6gmRwuxJpYVV+YeYpTgYFYS4X3bCRTiTUms
        rEotyo8vKs1JLT7EKM3BoiTOy59/LFJIID2xJDU7NbUgtQgmy8TBKdXAWL35QF94wh1r9f6f
        v4N9pns9VVm6OnjXs4XhTYufSQRb3lPsOGscfv3WL43/c4wvpuwpZPtqbcoSyjNxif0Bg5y9
        U5zl81brb3rlMk//bESTS/gLG6OnXwNVNi6xEG8U2sV5zF16UetVLhH+r9ZX/AN33l0p+GTh
        xOyytrmph0pctNb/ag37ocRSnJFoqMVcVJwIAHJ2CTPBAgAA
X-CMS-MailID: 20180802235658epcas2p233523a34b074a86031b63c716b66ce55
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180703234900epcas1p1cda806bab6bbe69228ca5ee56bc33f36
References: <CGME20180703234900epcas1p1cda806bab6bbe69228ca5ee56bc33f36@epcas1p1.samsung.com>
        <20180703234705.227473-6-mka@chromium.org> <5B3C6C2A.1070205@samsung.com>
        <20180706175301.GG129942@google.com>
        <5399c191-e140-e2b8-629b-72ddfbf99b0f@samsung.com>
        <20180716175050.GZ129942@google.com> <20180731193953.GH68975@google.com>
        <5B610B48.4030802@samsung.com> <20180801170824.GJ68975@google.com>
        <5B626563.1090302@samsung.com> <20180802231343.GS68975@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018년 08월 03일 08:13, Matthias Kaehlcke wrote:
> Hi Chanwoo,
> 
> On Thu, Aug 02, 2018 at 10:58:59AM +0900, Chanwoo Choi wrote:
>> Hi Matthias,
>>
>> On 2018년 08월 02일 02:08, Matthias Kaehlcke wrote:
>>> Hi Chanwoo,
>>>
>>> On Wed, Aug 01, 2018 at 10:22:16AM +0900, Chanwoo Choi wrote:
>>>> On 2018년 08월 01일 04:39, Matthias Kaehlcke wrote:
>>>>> On Mon, Jul 16, 2018 at 10:50:50AM -0700, Matthias Kaehlcke wrote:
>>>>>> On Thu, Jul 12, 2018 at 05:44:33PM +0900, Chanwoo Choi wrote:
>>>>>>> Hi Matthias,
>>>>>>>
>>>>>>> On 2018년 07월 07일 02:53, Matthias Kaehlcke wrote:
>>>>>>>> Hi Chanwoo,
>>>>>>>>
>>>>>>>> On Wed, Jul 04, 2018 at 03:41:46PM +0900, Chanwoo Choi wrote:
>>>>>>>>
>>>>>>>>> Firstly,
>>>>>>>>> I'm not sure why devfreq needs the devfreq_verify_within_limits() function.
>>>>>>>>>
>>>>>>>>> devfreq already used the OPP interface as default. It means that
>>>>>>>>> the outside of 'drivers/devfreq' can disable/enable the frequency
>>>>>>>>> such as drivers/thermal/devfreq_cooling.c. Also, when some device
>>>>>>>>> drivers disable/enable the specific frequency, the devfreq core
>>>>>>>>> consider them.
>>>>>>>>>
>>>>>>>>> So, devfreq doesn't need to devfreq_verify_within_limits() because
>>>>>>>>> already support some interface to change the minimum/maximum frequency
>>>>>>>>> of devfreq device. 
>>>>>>>>>
>>>>>>>>> In case of cpufreq subsystem, cpufreq only provides 'cpufreq_verify_with_limits()'
>>>>>>>>> to change the minimum/maximum frequency of cpu. some device driver cannot
>>>>>>>>> change the minimum/maximum frequency through OPP interface.
>>>>>>>>>
>>>>>>>>> But, in case of devfreq subsystem, as I explained already, devfreq support
>>>>>>>>> the OPP interface as default way. devfreq subsystem doesn't need to add
>>>>>>>>> other way to change the minimum/maximum frequency.
>>>>>>>>
>>>>>>>> Using the OPP interface exclusively works as long as a
>>>>>>>> enabling/disabling of OPPs is limited to a single driver
>>>>>>>> (drivers/thermal/devfreq_cooling.c). When multiple drivers are
>>>>>>>> involved you need a way to resolve conflicts, that's the purpose of
>>>>>>>> devfreq_verify_within_limits(). Please let me know if there are
>>>>>>>> existing mechanisms for conflict resolution that I overlooked.
>>>>>>>>
>>>>>>>> Possibly drivers/thermal/devfreq_cooling.c could be migrated to use
>>>>>>>> devfreq_verify_within_limits() instead of the OPP interface if
>>>>>>>> desired, however this seems beyond the scope of this series.
>>>>>>>
>>>>>>> Actually, if we uses this approach, it doesn't support the multiple drivers too.
>>>>>>> If non throttler drivers uses devfreq_verify_within_limits(), the conflict
>>>>>>> happen.
>>>>>>
>>>>>> As long as drivers limit the max freq there is no conflict, the lowest
>>>>>> max freq wins. I expect this to be the usual case, apparently it
>>>>>> worked for cpufreq for 10+ years.
>>>>>>
>>>>>> However it is correct that there would be a conflict if a driver
>>>>>> requests a min freq that is higher than the max freq requested by
>>>>>> another. In this case devfreq_verify_within_limits() resolves the
>>>>>> conflict by raising p->max to the min freq. Not sure if this is
>>>>>> something that would ever occur in practice though.
>>>>>>
>>>>>> If we are really concerned about this case it would also be an option
>>>>>> to limit the adjustment to the max frequency.
>>>>>>
>>>>>>> To resolve the conflict for multiple device driver, maybe OPP interface
>>>>>>> have to support 'usage_count' such as clk_enable/disable().
>>>>>>
>>>>>> This would require supporting negative usage count values, since a OPP
>>>>>> should not be enabled if e.g. thermal enables it but the throttler
>>>>>> disabled it or viceversa.
>>>>>>
>>>>>> Theoretically there could also be conflicts, like one driver disabling
>>>>>> the higher OPPs and another the lower ones, with the outcome of all
>>>>>> OPPs being disabled, which would be a more drastic conflict resolution
>>>>>> than that of devfreq_verify_within_limits().
>>>>>>
>>>>>> Viresh, what do you think about an OPP usage count?
>>>>>
>>>>> Ping, can we try to reach a conclusion on this or at least keep the
>>>>> discussion going?
>>>>>
>>>>> Not that it matters, but my preferred solution continues to be
>>>>> devfreq_verify_within_limits(). It solves conflicts in some way (which
>>>>> could be adjusted if needed) and has proven to work in practice for
>>>>> 10+ years in a very similar sub-system.
>>>>
>>>> It is not true. Current cpufreq subsystem doesn't support external OPP
>>>> control to enable/disable the OPP entry. If some device driver
>>>> controls the OPP entry of cpufreq driver with opp_disable/enable(),
>>>> the operation is not working. Because cpufreq considers the limit
>>>> through 'cpufreq_verify_with_limits()' only.
>>>
>>> Ok, we can probably agree that using cpufreq_verify_with_limits()
>>> exclusively seems to have worked well for cpufreq, and that in their
>>> overall purpose cpufreq and devfreq are similar subsystems.
>>>
>>> The current throttler series with devfreq_verify_within_limits() takes
>>> the enabled OPPs into account, the lowest and highest OPP are used as
>>> a starting point for the frequency adjustment and (in theory) the
>>> frequency range should only be narrowed by
>>> devfreq_verify_within_limits().
>>>
>>>> As I already commented[1], there is different between cpufreq and devfreq.
>>>> [1] https://lkml.org/lkml/2018/7/4/80
>>>>
>>>> Already, subsystem already used OPP interface in order to control
>>>> specific OPP entry. I don't want to provide two outside method
>>>> to control the frequency of devfreq driver. It might make the confusion.
>>>
>>> I understand your point, it would indeed be preferable to have a
>>> single method. However I'm not convinced that the OPP interface is
>>> a suitable solution, as I exposed earlier in this thread (quoted
>>> below).
>>>
>>> I would like you to at least consider the possibility of changing
>>> drivers/thermal/devfreq_cooling.c to devfreq_verify_within_limits().
>>> Besides that it's not what is currently used, do you see any technical
>>> concerns that would make devfreq_verify_within_limits() an unsuitable
>>> or inferior solution?
>>
>> As we already discussed, devfreq_verify_within_limits() doesn't support
>> the multiple outside controllers (e.g., devfreq-cooling.c).
> 
> That's incorrect, its purpose is precisely that.
> 
> Are you suggesting that cpufreq with its use of
> cpufreq_verify_within_limits() (the inspiration for
> devfreq_verify_within_limits()) is broken? It is used by cpu_cooling.c
> and other drivers when receiving a CPUFREQ_ADJUST event, essentially
> what I am proposing with DEVFREQ_ADJUST.
> 
> Could you elaborate why this model wouldn't work for devfreq? "OPP

I don't mention that this model is not working. As I already commented[1],
devfreq used OPP interface to control OPP entry on outside of devfreq driver.
Because devfreq used OPP interface, I hope to provide only OPP method
to control the frequency on outside of devfreq.
[1] https://lkml.org/lkml/2018/7/4/80

> interface is mandatory for devfreq" isn't really a technical argument,
> is it mandatory for any other reason than that it is the interface
> that is currently used?

In case of controlling the frequency, OPP interface is mandatory for devfreq.

cpufreq used cpufreq_verify_within_limit(). If outside driver disable
specific OPP entry, cpufreq don't consider them because after getting the frequency
from devicetree, cpufreq don't use the OPP interface for disabling/enabling.
Only if outside driver used cpufreq_verify_within_limit(), cpufreq consider
the range of minimum/maximum frequency. cpufreq core doesn't use 'dev_pm_opp_find_*'
function. It means that cpufreq code doesn't consider the statue of opp_diable/enable.

devfreq used OPP interface.  If outside driver disable specific OPP entry, devfreq consider them. 

When find available minimum frequency, devfreq used OPP interface. (find_available_min_freq)
When find available maximum frequency, devfreq used OPP interface. (find_available_max_freq)
When make freq_table of devfreq device, devfreq used OPP interface. (set_freq_table)
When outside driver disable or enable OPP entry, devfreq receives the notification
 from OPP interface and then update the scaling_min_freq/scaling_max_freq by using
 OPP interface. (devfreq_notifier_call)
At this point of using scaling_min_freq/scaling_max_freq on devfreq, it indicates
that devfreq used OPP interface because devfref tried to find scaling_min_freq/scaling_max_freq
through OPP interface.

If outside driver use OPP interface in order to control frequency,
devfreq core is well working without any modification of devfreq core.

> 
>> After you are suggesting the throttler core, there are at least two
>> outside controllers (e.g., devfreq-cooling.c and throttler driver).
>> As I knew the problem about conflict, I cannot agree the temporary
>> method. OPP interface is mandatory for devfreq in order to control
>> the OPP (frequency/voltage). In this situation, we have to try to
>> find the method through OPP interface.
> 
> What do you mean with "temporary method"?

this expression might be not proper. Please ignore this expression.

> 
> We can try to find a method through the OPP interface, but at this
> point I'm not convinced that it is technically necessary or even
> preferable.

I replied it about this as following.

> 
> Another inconvenient of the OPP approach for both devfreq-cooling.c
> and the throttler is that they have to bother with disabling all OPPs
> above/below the max/min (they don't/shouldn't have to care), instead
> of just telling devfreq the max/min.

I think it doesn't matter. We can enable/disable the OPP entry by traversing.
partition_enable_opps() in drivers/thermal/devfreq-cools.c have already done so.

> 
>> We can refer to regulator/clock. Multiple device driver can use
>> the regulator/clock without any problem. I think that usage of OPP
>> is similiar with regulator/clock. As you mentioned, maybe OPP
>> would handle the negative count. Although opp_enable/opp_disable()
>> have to handle the negative count and opp_enable/opp_disable()
>> can support the multiple usage from device drivers, I think that
>> this approach is right.
> 
> The regulator/clock approach with the typical usage counts seems more
> intuitive to me, personally I wouldn't write an interface with
> negative usage count if I could reasonably avoid it.

I think the use of negative usage count is not problem if it's required.

> 
>>>> I want to use only OPP interface to enable/disable frequency
>>>> even if we have to modify the OPP interface.
>>>
>>> These are the concerns I raised earlier about a solution with OPP
>>> usage counts:
>>>
>>> "This would require supporting negative usage count values, since a OPP
>>> should not be enabled if e.g. thermal enables it but the throttler
>>> disabled it or viceversa.
>>
>> Already replied	about negative usage count. I think that negative usage count
>> is not problem if this approach could resolve the issue.
>>
>>>
>>> Theoretically there could also be conflicts, like one driver disabling
>>> the higher OPPs and another the lower ones, with the outcome of all
>>> OPPs being disabled, which would be a more drastic conflict resolution
>>> than that of devfreq_verify_within_limits()."
>>>
>>> What do you think about these points?
>>
>> It depends on how to use OPP interface on multiple device driver.
>> Even if devfreq/opp provides the control method, outside device driver
>> are misusing them. It is problem of user.
> 
> I wouldn't call it misusing if two independent drivers take
> contradictory actions on an interface that doesn't provide
> arbitration. How can driver A know that it shouldn't disable OPPs a, b
> and c because driver B disabled d, e and f? Who is misusing the
> interface, driver A or driver B?

Each outside driver has their own throttling policy to control OPP entries.
They don't care the requirement of other driver and cannot know the requirement
of other driver. devfreq core can only recognize them.

> 
>> Instead, if we use the OPP interface, we can check why OPP entry
>> is disabled or enabled through usage count.
>>
>>>
>>> The negative usage counts aren't necessarily a dealbreaker in a
>>> technical sense, though I'm not a friend of quirky interfaces that
>>> don't behave like a typical user would expect (e.g. an OPP isn't
>>> necessarily enabled after dev_pm_opp_enable()).
>>>
>>> I can sent an RFC with OPP usage counts, though due to the above
>>> concerns I have doubts it will be well received.
>>
>> Please add me to Cc list.
> 
> Will do

OK. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
