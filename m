Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61318C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E652121A56
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="erN817eK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E652121A56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733170AbeHGBCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:02:02 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:64345 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732135AbeHGBCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:02:02 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180806225043epoutp02b70bdeda63bd330be4449d107eb5178e~IbUtYuIHi1506815068epoutp02g;
        Mon,  6 Aug 2018 22:50:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180806225043epoutp02b70bdeda63bd330be4449d107eb5178e~IbUtYuIHi1506815068epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533595843;
        bh=9j9trWKbOOumatepgi5XD2yjZa+N+hmxBW9ABRcQgnE=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=erN817eKYyVYB01yym2CBxDUetbsG3NKj3ZekOqIXv/fqNN2ykxLj7ENtOT7cSm3H
         69f+CkOTdS8tIUubTHhRkDL45I1fASAuUc+s0W7H/hyu7b/8mgosvS0V2w/eXIGlbb
         TKiU5XhbDAig4rTqk+oMr2ux5NjmG1eeyu4BewIY=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180806225041epcas1p46b3ec9f2169257926e13a081f9d8388c~IbUrItC9S2798727987epcas1p45;
        Mon,  6 Aug 2018 22:50:41 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.03.04292.0C0D86B5; Tue,  7 Aug 2018 07:50:41 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180806225040epcas1p1e249c3eaca06270fa23e4d63723e5c22~IbUqoRRZw0612006120epcas1p1R;
        Mon,  6 Aug 2018 22:50:40 +0000 (GMT)
X-AuditID: b6c32a38-d3bff700000010c4-22-5b68d0c0352a
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id E5.11.03704.0C0D86B5; Tue,  7 Aug
        2018 07:50:40 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PD20000SA4FLR20@mmp2.samsung.com>; Tue, 07 Aug 2018 07:50:40 +0900 (KST)
Message-id: <5B68D0BF.5020709@samsung.com>
Date:   Tue, 07 Aug 2018 07:50:39 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Matthias Kaehlcke <mka@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
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
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5 05/12] PM / devfreq: Add support for policy notifiers
In-reply-to: <5B68CC34.8040102@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCJsWRmVeSWpSXmKPExsWy7bCmge7BCxnRBjPWMln8nXSM3WL6k8ss
        Fps+vme1mH/kHKvF2WUH2SzW3D7EaNG8eD2bxdmmN+wW978eZbS4vGsOm8Xn3iOMFkuvX2Sy
        +LzhMaPF7cYVbBanrn9mszhz+hKrReveI+wWG796OAh5rJm3htHj969JjB6zGy6yeOy4u4TR
        Y9OqTjaPO9f2sHnsn7uG3ePKiSZWjy1X21k8+rasYvT4vEkugDsq1SYjNTEltUghNS85PyUz
        L91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6DUlhbLEnFKgUEBicbGSvp1NUX5p
        SapCRn5xia1StKGhkZ6hgbmekRGQNo61MjIFKklIzfjwppm94GlOxexHH1gbGHdGdDFyckgI
        mEi8evOarYuRi0NIYAejxNIZn1khnO+MEh/PvQDKcIBVnTiTCBHfwChx9uUmZpBuXgFBiR+T
        77GA1DALyEscuZQNEmYW0JR48WUSC0T9XUaJ7l29UPVaEtduvmcEsVkEVCU+797PDmKzAcX3
        v7jBBmLzCyhKXP3xGKxGVCBCYuf8b2A1IgJBEqe3XmICGcos8I5F4unUiywgCWEBH4l7HSBX
        c3JwCmhLTGrdywxSJCFwil1i6SGISRICLhIH9k2AsoUlXh3fwg7xmbTEpaO2EPXtjBJfXjSz
        QjgTGCU+nNrMBNFgLPFsYRcTxG98Eu++9rBCNPNKdLQJQZR4SLQsuM4O8fInZol5U3pYJzDK
        zkIKpVmIUJqFFEoLGJlXMYqlFhTnpqcWGxaY6BUn5haX5qXrJefnbmIEp2Atix2Me875HGIU
        4GBU4uEVWJIRLcSaWFZcmXuIUYKDWUmElzcTKMSbklhZlVqUH19UmpNafIjRFBjIE5mlRJPz
        gfkhryTe0NTI2NjYwsTQzNTQUEmc18gvOFpIID2xJDU7NbUgtQimj4mDU6qB0TGrvXXJM+mI
        Cfl7/55Z7+C37r8nI8P6/qr4qjtJW86kbo+45zi15Pg6pv/ncpm5VPnN87/Ot4jLm5Yq/qp6
        xdz7+6xl7S9t/yL8/VMzS56BmtHWK/MOB8W0Xw6utTMMilnNfEzboHa1ATtPhs2lU9rHF+4s
        C9qxRHtZV8IbfocpGzuy1bMTlFiKMxINtZiLihMBVqlML9cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t9jQd0DFzKiDeY8l7X4O+kYu8X0J5dZ
        LDZ9fM9qMf/IOVaLs8sOslmsuX2I0aJ58Xo2i7NNb9gt7n89ymhxedccNovPvUcYLZZev8hk
        8XnDY0aL240r2CxOXf/MZnHm9CVWi9a9R9gtNn71cBDyWDNvDaPH71+TGD1mN1xk8dhxdwmj
        x6ZVnWwed67tYfPYP3cNu8eVE02sHluutrN49G1ZxejxeZNcAHcUl01Kak5mWWqRvl0CV8aH
        N83sBU9zKmY/+sDawLgzoouRg0NCwETixJnELkYuDiGBdYwSkx7cYu1i5OTgFRCU+DH5HgtI
        DbOAvMSRS9kQprrElCm5EOX3GSW+Lj3MBlGuJXHt5ntGEJtFQFXi8+797CA2G1B8/4sbYDX8
        AooSV388ZgSZIyoQIdF9ohIkLCIQINHe/IQdZCazwDsWiSkzHjODJIQFfCTudXxmhVj2iVli
        zqq3YEM5BbQlJrXuZZ7AKDALyamzEE6dhXDqAkbmVYySqQXFuem5xUYFhnmp5XrFibnFpXnp
        esn5uZsYgfG47bBW3w7G+0viDzEKcDAq8fAKLMmIFmJNLCuuzD3EKMHBrCTCy5sJFOJNSays
        Si3Kjy8qzUktPsQozcGiJM57O+9YpJBAemJJanZqakFqEUyWiYNTqoGRp95EYO2aeSEuRY9y
        +PecsDLzNyvZ8SrvWlvPnOrPnYrr99RcUamfFxLjMT04dreRskVX4Lrk98axsySPRMlYmCif
        ypJet/aE74IJ5/6+iXkVc65uevttpYJbM19vuCPzM48rauvnGP+AJ0JplpxBKpve64lYB00z
        8fryIbjROsbt0apWRSElluKMREMt5qLiRAAA+lNkwwIAAA==
X-CMS-MailID: 20180806225040epcas1p1e249c3eaca06270fa23e4d63723e5c22
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180802234831epcas5p3951e8f64381a27d40865d339878751d1
References: <5399c191-e140-e2b8-629b-72ddfbf99b0f@samsung.com>
        <20180716175050.GZ129942@google.com> <20180731193953.GH68975@google.com>
        <5B610B48.4030802@samsung.com> <20180801170824.GJ68975@google.com>
        <5B626563.1090302@samsung.com> <20180802231343.GS68975@google.com>
        <CGME20180802234831epcas5p3951e8f64381a27d40865d339878751d1@epcas5p3.samsung.com>
        <20180802234820.GU68975@google.com> <5B639E76.6050901@samsung.com>
        <20180806192111.GB160295@google.com> <5B68CC34.8040102@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh Kumar,

I have a question about dev_pm_opp_enable() and dev_pm_opp_disable().
Two functions have 'available' field to indicate the status of specific OPP.

If different device drivers try to control the same OPP,
dev_pm_opp_enable() and dev_pm_opp_disable() will consider only last operation.
It means that OPP should be enabled/disabled by only one device driver.

For example,
opp_table of driver a(dev_a)
- 500Mhz
- 400Mhz
- 300Mhz
- 200Mhz
- 100Mhz

Driver B, opp_disable(dev_a, 500)
Driver C, opp_enable(dev_a, 500)
-> 500Mhz is enabled. But, driver B might want to enable 500Mhz at this time such as cooling.

I think that if OPP support the use of multiple device drivers,
dev_pm_opp_enable() and dev_pm_opp_disable() should support the usage count
such as regulator/clock.

I would like your opinion.

Regards,
Chanwoo Choi


On 2018년 08월 07일 07:31, Chanwoo Choi wrote:
> Hi Matthias,
> 
> On 2018년 08월 07일 04:21, Matthias Kaehlcke wrote:
>> Hi Chanwoo,
>>
>> On Fri, Aug 03, 2018 at 09:14:46AM +0900, Chanwoo Choi wrote:
>>> Hi Matthias,
>>>
>>> On 2018년 08월 03일 08:48, Matthias Kaehlcke wrote:
>>>> On Thu, Aug 02, 2018 at 04:13:43PM -0700, Matthias Kaehlcke wrote:
>>>>> Hi Chanwoo,
>>>>>
>>>>> On Thu, Aug 02, 2018 at 10:58:59AM +0900, Chanwoo Choi wrote:
>>>>>> Hi Matthias,
>>>>>>
>>>>>> On 2018년 08월 02일 02:08, Matthias Kaehlcke wrote:
>>>>>>> Hi Chanwoo,
>>>>>>>
>>>>>>> On Wed, Aug 01, 2018 at 10:22:16AM +0900, Chanwoo Choi wrote:
>>>>>>>> On 2018년 08월 01일 04:39, Matthias Kaehlcke wrote:
>>>>>>>>> On Mon, Jul 16, 2018 at 10:50:50AM -0700, Matthias Kaehlcke wrote:
>>>>>>>>>> On Thu, Jul 12, 2018 at 05:44:33PM +0900, Chanwoo Choi wrote:
>>>>>>>>>>> Hi Matthias,
>>>>>>>>>>>
>>>>>>>>>>> On 2018년 07월 07일 02:53, Matthias Kaehlcke wrote:
>>>>>>>>>>>> Hi Chanwoo,
>>>>>>>>>>>>
>>>>>>>>>>>> On Wed, Jul 04, 2018 at 03:41:46PM +0900, Chanwoo Choi wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>> Firstly,
>>>>>>>>>>>>> I'm not sure why devfreq needs the devfreq_verify_within_limits() function.
>>>>>>>>>>>>>
>>>>>>>>>>>>> devfreq already used the OPP interface as default. It means that
>>>>>>>>>>>>> the outside of 'drivers/devfreq' can disable/enable the frequency
>>>>>>>>>>>>> such as drivers/thermal/devfreq_cooling.c. Also, when some device
>>>>>>>>>>>>> drivers disable/enable the specific frequency, the devfreq core
>>>>>>>>>>>>> consider them.
>>>>>>>>>>>>>
>>>>>>>>>>>>> So, devfreq doesn't need to devfreq_verify_within_limits() because
>>>>>>>>>>>>> already support some interface to change the minimum/maximum frequency
>>>>>>>>>>>>> of devfreq device. 
>>>>>>>>>>>>>
>>>>>>>>>>>>> In case of cpufreq subsystem, cpufreq only provides 'cpufreq_verify_with_limits()'
>>>>>>>>>>>>> to change the minimum/maximum frequency of cpu. some device driver cannot
>>>>>>>>>>>>> change the minimum/maximum frequency through OPP interface.
>>>>>>>>>>>>>
>>>>>>>>>>>>> But, in case of devfreq subsystem, as I explained already, devfreq support
>>>>>>>>>>>>> the OPP interface as default way. devfreq subsystem doesn't need to add
>>>>>>>>>>>>> other way to change the minimum/maximum frequency.
>>>>>>>>>>>>
>>>>>>>>>>>> Using the OPP interface exclusively works as long as a
>>>>>>>>>>>> enabling/disabling of OPPs is limited to a single driver
>>>>>>>>>>>> (drivers/thermal/devfreq_cooling.c). When multiple drivers are
>>>>>>>>>>>> involved you need a way to resolve conflicts, that's the purpose of
>>>>>>>>>>>> devfreq_verify_within_limits(). Please let me know if there are
>>>>>>>>>>>> existing mechanisms for conflict resolution that I overlooked.
>>>>>>>>>>>>
>>>>>>>>>>>> Possibly drivers/thermal/devfreq_cooling.c could be migrated to use
>>>>>>>>>>>> devfreq_verify_within_limits() instead of the OPP interface if
>>>>>>>>>>>> desired, however this seems beyond the scope of this series.
>>>>>>>>>>>
>>>>>>>>>>> Actually, if we uses this approach, it doesn't support the multiple drivers too.
>>>>>>>>>>> If non throttler drivers uses devfreq_verify_within_limits(), the conflict
>>>>>>>>>>> happen.
>>>>>>>>>>
>>>>>>>>>> As long as drivers limit the max freq there is no conflict, the lowest
>>>>>>>>>> max freq wins. I expect this to be the usual case, apparently it
>>>>>>>>>> worked for cpufreq for 10+ years.
>>>>>>>>>>
>>>>>>>>>> However it is correct that there would be a conflict if a driver
>>>>>>>>>> requests a min freq that is higher than the max freq requested by
>>>>>>>>>> another. In this case devfreq_verify_within_limits() resolves the
>>>>>>>>>> conflict by raising p->max to the min freq. Not sure if this is
>>>>>>>>>> something that would ever occur in practice though.
>>>>>>>>>>
>>>>>>>>>> If we are really concerned about this case it would also be an option
>>>>>>>>>> to limit the adjustment to the max frequency.
>>>>>>>>>>
>>>>>>>>>>> To resolve the conflict for multiple device driver, maybe OPP interface
>>>>>>>>>>> have to support 'usage_count' such as clk_enable/disable().
>>>>>>>>>>
>>>>>>>>>> This would require supporting negative usage count values, since a OPP
>>>>>>>>>> should not be enabled if e.g. thermal enables it but the throttler
>>>>>>>>>> disabled it or viceversa.
>>>>>>>>>>
>>>>>>>>>> Theoretically there could also be conflicts, like one driver disabling
>>>>>>>>>> the higher OPPs and another the lower ones, with the outcome of all
>>>>>>>>>> OPPs being disabled, which would be a more drastic conflict resolution
>>>>>>>>>> than that of devfreq_verify_within_limits().
>>>>>>>>>>
>>>>>>>>>> Viresh, what do you think about an OPP usage count?
>>>>>>>>>
>>>>>>>>> Ping, can we try to reach a conclusion on this or at least keep the
>>>>>>>>> discussion going?
>>>>>>>>>
>>>>>>>>> Not that it matters, but my preferred solution continues to be
>>>>>>>>> devfreq_verify_within_limits(). It solves conflicts in some way (which
>>>>>>>>> could be adjusted if needed) and has proven to work in practice for
>>>>>>>>> 10+ years in a very similar sub-system.
>>>>>>>>
>>>>>>>> It is not true. Current cpufreq subsystem doesn't support external OPP
>>>>>>>> control to enable/disable the OPP entry. If some device driver
>>>>>>>> controls the OPP entry of cpufreq driver with opp_disable/enable(),
>>>>>>>> the operation is not working. Because cpufreq considers the limit
>>>>>>>> through 'cpufreq_verify_with_limits()' only.
>>>>>>>
>>>>>>> Ok, we can probably agree that using cpufreq_verify_with_limits()
>>>>>>> exclusively seems to have worked well for cpufreq, and that in their
>>>>>>> overall purpose cpufreq and devfreq are similar subsystems.
>>>>>>>
>>>>>>> The current throttler series with devfreq_verify_within_limits() takes
>>>>>>> the enabled OPPs into account, the lowest and highest OPP are used as
>>>>>>> a starting point for the frequency adjustment and (in theory) the
>>>>>>> frequency range should only be narrowed by
>>>>>>> devfreq_verify_within_limits().
>>>>>>>
>>>>>>>> As I already commented[1], there is different between cpufreq and devfreq.
>>>>>>>> [1] https://lkml.org/lkml/2018/7/4/80
>>>>>>>>
>>>>>>>> Already, subsystem already used OPP interface in order to control
>>>>>>>> specific OPP entry. I don't want to provide two outside method
>>>>>>>> to control the frequency of devfreq driver. It might make the confusion.
>>>>>>>
>>>>>>> I understand your point, it would indeed be preferable to have a
>>>>>>> single method. However I'm not convinced that the OPP interface is
>>>>>>> a suitable solution, as I exposed earlier in this thread (quoted
>>>>>>> below).
>>>>>>>
>>>>>>> I would like you to at least consider the possibility of changing
>>>>>>> drivers/thermal/devfreq_cooling.c to devfreq_verify_within_limits().
>>>>>>> Besides that it's not what is currently used, do you see any technical
>>>>>>> concerns that would make devfreq_verify_within_limits() an unsuitable
>>>>>>> or inferior solution?
>>>>>>
>>>>>> As we already discussed, devfreq_verify_within_limits() doesn't support
>>>>>> the multiple outside controllers (e.g., devfreq-cooling.c).
>>>>>
>>>>> That's incorrect, its purpose is precisely that.
>>>>>
>>>>> Are you suggesting that cpufreq with its use of
>>>>> cpufreq_verify_within_limits() (the inspiration for
>>>>> devfreq_verify_within_limits()) is broken? It is used by cpu_cooling.c
>>>>> and other drivers when receiving a CPUFREQ_ADJUST event, essentially
>>>>> what I am proposing with DEVFREQ_ADJUST.
>>>>>
>>>>> Could you elaborate why this model wouldn't work for devfreq? "OPP
>>>>> interface is mandatory for devfreq" isn't really a technical argument,
>>>>> is it mandatory for any other reason than that it is the interface
>>>>> that is currently used?
>>>>>
>>>>>> After you are suggesting the throttler core, there are at least two
>>>>>> outside controllers (e.g., devfreq-cooling.c and throttler driver).
>>>>>> As I knew the problem about conflict, I cannot agree the temporary
>>>>>> method. OPP interface is mandatory for devfreq in order to control
>>>>>> the OPP (frequency/voltage). In this situation, we have to try to
>>>>>> find the method through OPP interface.
>>>>>
>>>>> What do you mean with "temporary method"?
>>>>>
>>>>> We can try to find a method through the OPP interface, but at this
>>>>> point I'm not convinced that it is technically necessary or even
>>>>> preferable.
>>>>>
>>>>> Another inconvenient of the OPP approach for both devfreq-cooling.c
>>>>> and the throttler is that they have to bother with disabling all OPPs
>>>>> above/below the max/min (they don't/shouldn't have to care), instead
>>>>> of just telling devfreq the max/min.
>>>>
>>>> And a more important one: both drivers now have to keep track which
>>>> OPPs they enabled/disabled previously, done are the days of a simple
>>>> dev_pm_opp_enable/disable() in devfreq_cooling. Certainly it is
>>>> possible and not very complex to implement, but is it really the
>>>> best/a good solution?
>>>
>>>
>>> As I replied them right before, Each outside driver has their own throttling
>>> policy to control OPP entries. They don't care the requirement of other
>>> driver and cannot know the requirement of other driver. devfreq core can only
>>> recognize them and then only consider enabled OPP entris without disabled OPP entries.
>>>
>>> For example1,
>>>        | devfreq-cooling| throttler
>>> ---------------------------------------
>>> 500Mhz | disabled       | disabled
>>> 400Mhz | disabled       | disabled
>>> 300Mhz |                | disabled
>>> 200Mhz |                |
>>> 100Mhz |                |
>>> => devfreq driver can use only 100/200Mhz
>>>
>>>
>>> For example2,
>>>        | devfreq-cooling| throttler
>>> ---------------------------------------
>>> 500Mhz | disabled       | disabled
>>> 400Mhz | disabled       |
>>> 300Mhz | disabled       |
>>> 200Mhz |                |
>>> 100Mhz |                |
>>> => devfreq driver can use only 100/200Mhz
>>>
>>>
>>> For example3,
>>>        | devfreq-cooling| throttler
>>> ---------------------------------------
>>> 500Mhz | disabled       | disabled
>>> 400Mhz |                |
>>> 300Mhz |                |
>>> 200Mhz |                | disabled
>>> 100Mhz |                | disabled
>>> => devfreq driver can use only 300/400Mhz
>>
>> These are all cases without conflicts, my concern is about this:
>>
>>>        | devfreq-cooling| throttler
>>> ---------------------------------------
>>> 500Mhz | disabled       |
>>> 400Mhz | disabled       |
>>> 300Mhz |                | disabled
>>> 200Mhz |                | disabled
>>> 100Mhz |                | disabled
>>> => devfreq driver can't use any frequency?
> 
> There are no any enabled frequency. Because device driver
> (devfreq-cooling, throttler) disable all frequencies.
> 
> Outside drivers(devfreq-cooling, throttler) can enable/disable
> specific OPP entries. As I already commented, each outside driver
> doesn't consider the policy of other device driver about OPP entries.
> 
> OPP interface is independent on devfreq and just control OPP entries.
> After that, devfreq just consider the only enabled OPP entries.

In this case, at least one OPP should be remained on enabled state.
Maybe, OPP interface should provide the function which cannot disable
specific OPP entry.

> 
>>
>> Actually my above comment wasn't about this case, but about the
>> added complexity in devfreq-cooling.c and the throttler:
>>
>> A bit simplified partition_enable_opps() currently does this:
>>
>> for_each_opp(opp) {
>>   if (opp->freq <= max)
>>      opp_enable(opp)
>>   else
>>      opp_disable(opp)
>> }
>>
>> With the OPP usage/disable count this doesn't work any longer. Now we
>> need to keep track of the enabled/disabled state of the OPP, something
>> like:
>>
>> dev_pm_opp_enable(opp) {
>>   if (opp->freq <= max) {
>>     if (opp->freq > prev_max)
>>       opp_enable(opp)
>>   } else {
>>     if (opp->freq < prev_max)
>>       opp_disable(opp)
>>   }
>> }
>>
>> And duplicate the same in the throttler (and other possible
>> drivers). Obviously it can be done, but is there really any gain
>> from it?
>>
>> Instead they just could do:
>>
>> devfreq_verify_within_limits(policy/freq_pair, 0, max_freq)
>>
>> without being concerned about implementation details of devfreq.
>>
> 
> I don't think so. dev_pm_opp_enable()/dev_pm_opp_disable()
> have to consider only one OPP entry without any other OPP entry.
> 
> dev_pm_opp_enable()/dev_pm_opp_disable() can never know the other
> OPP entries. After some driver(devfreq-cooling.c and throttler) 
> enable or disable specific OPP entries, the remaining OPP entry 
> with enabled state will be considered on devfreq driver.
> 
