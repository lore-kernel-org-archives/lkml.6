Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F684C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84A921A5B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vPeuPvGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84A921A5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733058AbeHGA1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:27:21 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:27095 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732382AbeHGA1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:27:20 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180806221608epoutp041f2cd8b296e3f3aaed9a06dd8c5a569f~Ia2g8FUPk2364523645epoutp04k;
        Mon,  6 Aug 2018 22:16:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180806221608epoutp041f2cd8b296e3f3aaed9a06dd8c5a569f~Ia2g8FUPk2364523645epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533593768;
        bh=76fFCD+hGaV5ZEm9ImfyhbvBBor0V3Z88ncR9IYFwWU=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=vPeuPvGg3n1pQwTk5Fcr4HTzHhn1x2p2nIs0uQGQh7nWd5H7+HBeKDn0nj/rkaUnP
         ANi7WO4XkDnexUK6pKPcR4AY+dYc0Jx84zKpb7jqvJ+D1meveVtgcOZQj6E8pmc5bc
         109BexN1BT/7ACf7WYOJeogaoQExX9uTc1yRhrXg=
Received: from epsmges2p3.samsung.com (unknown [182.195.40.152]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180806221606epcas1p49d88c1916bcf09ea21d1a5fb9797f174~Ia2ewKwUH1623616236epcas1p4q;
        Mon,  6 Aug 2018 22:16:06 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.C6.04412.6A8C86B5; Tue,  7 Aug 2018 07:16:06 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20180806221605epcas2p375c4df6e66a2d010af2ddc180fea26d9~Ia2ebWzkc0817208172epcas2p3u;
        Mon,  6 Aug 2018 22:16:05 +0000 (GMT)
X-AuditID: b6c32a47-271ff7000000113c-65-5b68c8a6804d
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.4F.03824.5A8C86B5; Tue,  7 Aug 2018 07:16:05 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PD200ACD8IT4440@mmp1.samsung.com>; Tue, 07 Aug 2018 07:16:05 +0900 (KST)
Message-id: <5B68C8A5.4070502@samsung.com>
Date:   Tue, 07 Aug 2018 07:16:05 +0900
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
In-reply-to: <20180806184638.GA160295@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGJsWRmVeSWpSXmKPExsWy7bCmme6yExnRBr/2cFj8nXSM3WL6k8ss
        Fps+vme1mH/kHKvF2WUH2SzW3D7EaNG8eD2bxdmmN+wW978eZbS4vGsOm8Xn3iOMFkuvX2Sy
        +LzhMaPF7cYVbBanrn9mszhz+hKrReveI+wWG796OAh5rJm3htHj969JjB6zGy6yeOy4u4TR
        Y9OqTjaPO9f2sHnsn7uG3ePKiSZWjy1X21k8+rasYvT4vEkugDsq1SYjNTEltUghNS85PyUz
        L91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6DUlhbLEnFKgUEBicbGSvp1NUX5p
        SapCRn5xia1StKGhkZ6hgbmekRGQNo61MjIFKklIzfh0bxtTwZKqik0fd7E0MHakdjFyckgI
        mEh8OfWBsYuRi0NIYAejxKZ/W9khnO+MEi/urGKHqdrS/Y4FIrGbUeJV5wdmkASvgKDEj8n3
        gBIcHMwC8hJHLmWDhJkFNCVefJkEVX+XUeLE2RYmiHotibXzOsFsFgFViSVTd4HZbEDx/S9u
        sIHY/AKKEld/PGYEsUUFIiR2zv8GdoSIgIbEk9/nwU5lFpjGKtE97T9Yg7CAj8S9js+sIDan
        gKHEidPfwF6QEDjGLrFn/Tw2iBdcJE7t3M4CYQtLvDq+Beo1aYlnqzYyQjS0M0p8edHMCuFM
        YJT4cGozE0SVscSzhV1MEM/xSXQc/ssO8rOEAK9ER5sQRImHxOs9z9mggccs8WTybLYJjLKz
        kIJpFiKYZiEF0wJG5lWMYqkFxbnpqcVGBcZ6xYm5xaV56XrJ+bmbGMFpWMt9B+O2cz6HGAU4
        GJV4eAWWZEQLsSaWFVfmHmKU4GBWEuHlzQQK8aYkVlalFuXHF5XmpBYfYjQFhvJEZinR5Hxg
        jsgriTc0NTI2NrYwNbc0NrBUEuet8guOFhJITyxJzU5NLUgtgulj4uCUamDUXmxq/OFe1AK7
        Re/EsxwU0/ayzBH92sMmHhexf1dSlOSs0JieV4YFZRtV2tROvzuWdHz6VX2zbT94JIPWnmnr
        7DJyeNFz4uzUw8EdnkdKPz2Z/a+OS+ZLz0mx1+rW17W4wx9016w22xrH9n3B7/86hTWXHcKn
        9etdNhHLYSi2eNQ8b/FJyWtKLMUZiYZazEXFiQBV3S4d2QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t9jAd2lJzKiDZZ91rf4O+kYu8X0J5dZ
        LDZ9fM9qMf/IOVaLs8sOslmsuX2I0aJ58Xo2i7NNb9gt7n89ymhxedccNovPvUcYLZZev8hk
        8XnDY0aL240r2CxOXf/MZnHm9CVWi9a9R9gtNn71cBDyWDNvDaPH71+TGD1mN1xk8dhxdwmj
        x6ZVnWwed67tYfPYP3cNu8eVE02sHluutrN49G1ZxejxeZNcAHcUl01Kak5mWWqRvl0CV8an
        e9uYCpZUVWz6uIulgbEjtYuRk0NCwERiS/c7FhBbSGAno8TFU0kgNq+AoMSPyfeA4hwczALy
        EkcuZUOY6hJTpuR2MXIBVd9nlJh8fAITRLmWxNp5nWA2i4CqxJKpu8BsNqD4/hc32EBsfgFF
        ias/HjOCzBEViJDoPlEJEhYR0JB48vs8I4jNLDCDVWLjhRgQW1jAR+Jex2dWiMu+MkvM/KED
        YnMKGEqcOP2NfQKjwCwkh85COHQWwqELGJlXMUqmFhTnpucWGxUY5aWW6xUn5haX5qXrJefn
        bmIExuK2w1r9OxgfL4k/xCjAwajEwyuwJCNaiDWxrLgy9xCjBAezkggvbyZQiDclsbIqtSg/
        vqg0J7X4EKM0B4uSOC9//rFIIYH0xJLU7NTUgtQimCwTB6dUA+Ouxz3r3njpFPz89F9XtGJ2
        0gm/7c0aTvv8n2+LuKeX8OHA09yXXB94ZSbsX7K+95JT7rs/u04+Euw4psg05c+b7F+NV974
        l9hNnnJ4mu0brT9xVnx/ntmf//59a0NW7aKDfYe621dnfC+0jdJJO/px9jepzx2cV/MeCEZN
        i11y++m+pV7H97ckKrEUZyQaajEXFScCAOjUdIDBAgAA
X-CMS-MailID: 20180806221605epcas2p375c4df6e66a2d010af2ddc180fea26d9
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180806184646epcas1p4ac406410c75625f00a570eda77bb0e73
References: <5B3C6C2A.1070205@samsung.com>
        <20180706175301.GG129942@google.com>
        <5399c191-e140-e2b8-629b-72ddfbf99b0f@samsung.com>
        <20180716175050.GZ129942@google.com> <20180731193953.GH68975@google.com>
        <5B610B48.4030802@samsung.com> <20180801170824.GJ68975@google.com>
        <5B626563.1090302@samsung.com> <20180802231343.GS68975@google.com>
        <5B639A49.3060804@samsung.com>
        <CGME20180806184646epcas1p4ac406410c75625f00a570eda77bb0e73@epcas1p4.samsung.com>
        <20180806184638.GA160295@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018년 08월 07일 03:46, Matthias Kaehlcke wrote:
> Hi Chanwoo,
> 
> On Fri, Aug 03, 2018 at 08:56:57AM +0900, Chanwoo Choi wrote:
>> Hi Matthias,
>>
>> On 2018년 08월 03일 08:13, Matthias Kaehlcke wrote:
>>> Hi Chanwoo,
>>>
>>> On Thu, Aug 02, 2018 at 10:58:59AM +0900, Chanwoo Choi wrote:
>>>> Hi Matthias,
>>>>
>>>> On 2018년 08월 02일 02:08, Matthias Kaehlcke wrote:
>>>>> Hi Chanwoo,
>>>>>
>>>>> On Wed, Aug 01, 2018 at 10:22:16AM +0900, Chanwoo Choi wrote:
>>>>>> On 2018년 08월 01일 04:39, Matthias Kaehlcke wrote:
>>>>>>> On Mon, Jul 16, 2018 at 10:50:50AM -0700, Matthias Kaehlcke wrote:
>>>>>>>> On Thu, Jul 12, 2018 at 05:44:33PM +0900, Chanwoo Choi wrote:
>>>>>>>>> Hi Matthias,
>>>>>>>>>
>>>>>>>>> On 2018년 07월 07일 02:53, Matthias Kaehlcke wrote:
>>>>>>>>>> Hi Chanwoo,
>>>>>>>>>>
>>>>>>>>>> On Wed, Jul 04, 2018 at 03:41:46PM +0900, Chanwoo Choi wrote:
>>>>>>>>>>
>>>>>>>>>>> Firstly,
>>>>>>>>>>> I'm not sure why devfreq needs the devfreq_verify_within_limits() function.
>>>>>>>>>>>
>>>>>>>>>>> devfreq already used the OPP interface as default. It means that
>>>>>>>>>>> the outside of 'drivers/devfreq' can disable/enable the frequency
>>>>>>>>>>> such as drivers/thermal/devfreq_cooling.c. Also, when some device
>>>>>>>>>>> drivers disable/enable the specific frequency, the devfreq core
>>>>>>>>>>> consider them.
>>>>>>>>>>>
>>>>>>>>>>> So, devfreq doesn't need to devfreq_verify_within_limits() because
>>>>>>>>>>> already support some interface to change the minimum/maximum frequency
>>>>>>>>>>> of devfreq device. 
>>>>>>>>>>>
>>>>>>>>>>> In case of cpufreq subsystem, cpufreq only provides 'cpufreq_verify_with_limits()'
>>>>>>>>>>> to change the minimum/maximum frequency of cpu. some device driver cannot
>>>>>>>>>>> change the minimum/maximum frequency through OPP interface.
>>>>>>>>>>>
>>>>>>>>>>> But, in case of devfreq subsystem, as I explained already, devfreq support
>>>>>>>>>>> the OPP interface as default way. devfreq subsystem doesn't need to add
>>>>>>>>>>> other way to change the minimum/maximum frequency.
>>>>>>>>>>
>>>>>>>>>> Using the OPP interface exclusively works as long as a
>>>>>>>>>> enabling/disabling of OPPs is limited to a single driver
>>>>>>>>>> (drivers/thermal/devfreq_cooling.c). When multiple drivers are
>>>>>>>>>> involved you need a way to resolve conflicts, that's the purpose of
>>>>>>>>>> devfreq_verify_within_limits(). Please let me know if there are
>>>>>>>>>> existing mechanisms for conflict resolution that I overlooked.
>>>>>>>>>>
>>>>>>>>>> Possibly drivers/thermal/devfreq_cooling.c could be migrated to use
>>>>>>>>>> devfreq_verify_within_limits() instead of the OPP interface if
>>>>>>>>>> desired, however this seems beyond the scope of this series.
>>>>>>>>>
>>>>>>>>> Actually, if we uses this approach, it doesn't support the multiple drivers too.
>>>>>>>>> If non throttler drivers uses devfreq_verify_within_limits(), the conflict
>>>>>>>>> happen.
>>>>>>>>
>>>>>>>> As long as drivers limit the max freq there is no conflict, the lowest
>>>>>>>> max freq wins. I expect this to be the usual case, apparently it
>>>>>>>> worked for cpufreq for 10+ years.
>>>>>>>>
>>>>>>>> However it is correct that there would be a conflict if a driver
>>>>>>>> requests a min freq that is higher than the max freq requested by
>>>>>>>> another. In this case devfreq_verify_within_limits() resolves the
>>>>>>>> conflict by raising p->max to the min freq. Not sure if this is
>>>>>>>> something that would ever occur in practice though.
>>>>>>>>
>>>>>>>> If we are really concerned about this case it would also be an option
>>>>>>>> to limit the adjustment to the max frequency.
>>>>>>>>
>>>>>>>>> To resolve the conflict for multiple device driver, maybe OPP interface
>>>>>>>>> have to support 'usage_count' such as clk_enable/disable().
>>>>>>>>
>>>>>>>> This would require supporting negative usage count values, since a OPP
>>>>>>>> should not be enabled if e.g. thermal enables it but the throttler
>>>>>>>> disabled it or viceversa.
>>>>>>>>
>>>>>>>> Theoretically there could also be conflicts, like one driver disabling
>>>>>>>> the higher OPPs and another the lower ones, with the outcome of all
>>>>>>>> OPPs being disabled, which would be a more drastic conflict resolution
>>>>>>>> than that of devfreq_verify_within_limits().
>>>>>>>>
>>>>>>>> Viresh, what do you think about an OPP usage count?
>>>>>>>
>>>>>>> Ping, can we try to reach a conclusion on this or at least keep the
>>>>>>> discussion going?
>>>>>>>
>>>>>>> Not that it matters, but my preferred solution continues to be
>>>>>>> devfreq_verify_within_limits(). It solves conflicts in some way (which
>>>>>>> could be adjusted if needed) and has proven to work in practice for
>>>>>>> 10+ years in a very similar sub-system.
>>>>>>
>>>>>> It is not true. Current cpufreq subsystem doesn't support external OPP
>>>>>> control to enable/disable the OPP entry. If some device driver
>>>>>> controls the OPP entry of cpufreq driver with opp_disable/enable(),
>>>>>> the operation is not working. Because cpufreq considers the limit
>>>>>> through 'cpufreq_verify_with_limits()' only.
>>>>>
>>>>> Ok, we can probably agree that using cpufreq_verify_with_limits()
>>>>> exclusively seems to have worked well for cpufreq, and that in their
>>>>> overall purpose cpufreq and devfreq are similar subsystems.
>>>>>
>>>>> The current throttler series with devfreq_verify_within_limits() takes
>>>>> the enabled OPPs into account, the lowest and highest OPP are used as
>>>>> a starting point for the frequency adjustment and (in theory) the
>>>>> frequency range should only be narrowed by
>>>>> devfreq_verify_within_limits().
>>>>>
>>>>>> As I already commented[1], there is different between cpufreq and devfreq.
>>>>>> [1] https://lkml.org/lkml/2018/7/4/80
>>>>>>
>>>>>> Already, subsystem already used OPP interface in order to control
>>>>>> specific OPP entry. I don't want to provide two outside method
>>>>>> to control the frequency of devfreq driver. It might make the confusion.
>>>>>
>>>>> I understand your point, it would indeed be preferable to have a
>>>>> single method. However I'm not convinced that the OPP interface is
>>>>> a suitable solution, as I exposed earlier in this thread (quoted
>>>>> below).
>>>>>
>>>>> I would like you to at least consider the possibility of changing
>>>>> drivers/thermal/devfreq_cooling.c to devfreq_verify_within_limits().
>>>>> Besides that it's not what is currently used, do you see any technical
>>>>> concerns that would make devfreq_verify_within_limits() an unsuitable
>>>>> or inferior solution?
>>>>
>>>> As we already discussed, devfreq_verify_within_limits() doesn't support
>>>> the multiple outside controllers (e.g., devfreq-cooling.c).
>>>
>>> That's incorrect, its purpose is precisely that.
>>>
>>> Are you suggesting that cpufreq with its use of
>>> cpufreq_verify_within_limits() (the inspiration for
>>> devfreq_verify_within_limits()) is broken? It is used by cpu_cooling.c
>>> and other drivers when receiving a CPUFREQ_ADJUST event, essentially
>>> what I am proposing with DEVFREQ_ADJUST.
>>>
>>> Could you elaborate why this model wouldn't work for devfreq? "OPP
>>
>> I don't mention that this model is not working. As I already commented[1],
>> devfreq used OPP interface to control OPP entry on outside of devfreq driver.
>> Because devfreq used OPP interface, I hope to provide only OPP method
>> to control the frequency on outside of devfreq.
>> [1] https://lkml.org/lkml/2018/7/4/80
>>
>>> interface is mandatory for devfreq" isn't really a technical argument,
>>> is it mandatory for any other reason than that it is the interface
>>> that is currently used?
>>
>> In case of controlling the frequency, OPP interface is mandatory for devfreq.
>>
>> cpufreq used cpufreq_verify_within_limit(). If outside driver disable
>> specific OPP entry, cpufreq don't consider them because after getting the frequency
>> from devicetree, cpufreq don't use the OPP interface for disabling/enabling.
>> Only if outside driver used cpufreq_verify_within_limit(), cpufreq consider
>> the range of minimum/maximum frequency. cpufreq core doesn't use 'dev_pm_opp_find_*'
>> function. It means that cpufreq code doesn't consider the statue of opp_diable/enable.
>>
>> devfreq used OPP interface.  If outside driver disable specific OPP entry, devfreq consider them. 
> 
> What exactly is this 'outside driver' you are referring? The driver
> that 'owns' the devfreq device, e.g. a GPU driver? Or just any
> non-devfreq driver, like devfreq-cooling.c?
> 
> If it's the first case then this isn't currently working as intended
> when the devfreq device is used as a cooling device, since the cooling
> device would overwrite the state set by the 'owner' in
> partition_enable_opps().
> 
>> When find available minimum frequency, devfreq used OPP interface. (find_available_min_freq)
>> When find available maximum frequency, devfreq used OPP interface. (find_available_max_freq)
>> When make freq_table of devfreq device, devfreq used OPP interface. (set_freq_table)
>> When outside driver disable or enable OPP entry, devfreq receives the notification
>>  from OPP interface and then update the scaling_min_freq/scaling_max_freq by using
>>  OPP interface. (devfreq_notifier_call)
>> At this point of using scaling_min_freq/scaling_max_freq on devfreq, it indicates
>> that devfreq used OPP interface because devfref tried to find scaling_min_freq/scaling_max_freq
>> through OPP interface.
>>
>> If outside driver use OPP interface in order to control frequency,
>> devfreq core is well working without any modification of devfreq
>> core.
> 
> Thanks for elaborating!
> 
> I understand that this is how it currently works, but unless I'm
> missing something about the outside driver disabling an OPP I still
> essentially read this as 'the OPP interface is mandatory because it's
> what is currently used by the devfreq core to limit the frequency
> range', rather than that using the OPP interface allows to provide a
> particular feature or is inherently better in some other way.
> 
> I don't propose to completely strip the OPP interface out of devfreq,
> but mainly to switch devfreq-cooling.c to
> devfreq_verify_within_limits() to avoid having two mechanisms for
> limiting the frequency range. Besides being simpler this would allow
> to support the case where the 'owner' disables a certain OPP and
> devfreq respects that. The code required in the devfreq core to
> support this would be minimal (this patch).
> 
>>>> After you are suggesting the throttler core, there are at least two
>>>> outside controllers (e.g., devfreq-cooling.c and throttler driver).
>>>> As I knew the problem about conflict, I cannot agree the temporary
>>>> method. OPP interface is mandatory for devfreq in order to control
>>>> the OPP (frequency/voltage). In this situation, we have to try to
>>>> find the method through OPP interface.
>>>
>>> What do you mean with "temporary method"?
>>
>> this expression might be not proper. Please ignore this expression.
>>
>>>
>>> We can try to find a method through the OPP interface, but at this
>>> point I'm not convinced that it is technically necessary or even
>>> preferable.
>>
>> I replied it about this as following.
>>
>>>
>>> Another inconvenient of the OPP approach for both devfreq-cooling.c
>>> and the throttler is that they have to bother with disabling all OPPs
>>> above/below the max/min (they don't/shouldn't have to care), instead
>>> of just telling devfreq the max/min.
>>
>> I think it doesn't matter. We can enable/disable the OPP entry by traversing.
>> partition_enable_opps() in drivers/thermal/devfreq-cools.c have already done so.
>>
>>>
>>>> We can refer to regulator/clock. Multiple device driver can use
>>>> the regulator/clock without any problem. I think that usage of OPP
>>>> is similiar with regulator/clock. As you mentioned, maybe OPP
>>>> would handle the negative count. Although opp_enable/opp_disable()
>>>> have to handle the negative count and opp_enable/opp_disable()
>>>> can support the multiple usage from device drivers, I think that
>>>> this approach is right.
>>>
>>> The regulator/clock approach with the typical usage counts seems more
>>> intuitive to me, personally I wouldn't write an interface with
>>> negative usage count if I could reasonably avoid it.
>>
>> I think the use of negative usage count is not problem if it's required.
>>
>>>
>>>>>> I want to use only OPP interface to enable/disable frequency
>>>>>> even if we have to modify the OPP interface.
>>>>>
>>>>> These are the concerns I raised earlier about a solution with OPP
>>>>> usage counts:
>>>>>
>>>>> "This would require supporting negative usage count values, since a OPP
>>>>> should not be enabled if e.g. thermal enables it but the throttler
>>>>> disabled it or viceversa.
>>>>
>>>> Already replied	about negative usage count. I think that negative usage count
>>>> is not problem if this approach could resolve the issue.
>>>>
>>>>>
>>>>> Theoretically there could also be conflicts, like one driver disabling
>>>>> the higher OPPs and another the lower ones, with the outcome of all
>>>>> OPPs being disabled, which would be a more drastic conflict resolution
>>>>> than that of devfreq_verify_within_limits()."
>>>>>
>>>>> What do you think about these points?
>>>>
>>>> It depends on how to use OPP interface on multiple device driver.
>>>> Even if devfreq/opp provides the control method, outside device driver
>>>> are misusing them. It is problem of user.
>>>
>>> I wouldn't call it misusing if two independent drivers take
>>> contradictory actions on an interface that doesn't provide
>>> arbitration. How can driver A know that it shouldn't disable OPPs a, b
>>> and c because driver B disabled d, e and f? Who is misusing the
>>> interface, driver A or driver B?
>>
>> Each outside driver has their own throttling policy to control OPP entries.
>> They don't care the requirement of other driver and cannot know the requirement
>> of other driver. devfreq core can only recognize them.
>>
>>>
>>>> Instead, if we use the OPP interface, we can check why OPP entry
>>>> is disabled or enabled through usage count.
>>>>
>>>>>
>>>>> The negative usage counts aren't necessarily a dealbreaker in a
>>>>> technical sense, though I'm not a friend of quirky interfaces that
>>>>> don't behave like a typical user would expect (e.g. an OPP isn't
>>>>> necessarily enabled after dev_pm_opp_enable()).
>>>>>
>>>>> I can sent an RFC with OPP usage counts, though due to the above
>>>>> concerns I have doubts it will be well received.
>>>>
>>>> Please add me to Cc list.
>>>
>>> Will do
>>
>> OK. Thanks.
> 
> This might take a bit for a few reasons. Before posting anything I
> would like to experiment a bit with it and find time to do so between
> other tasks (admittedly I'm also procrastinating a bit, because I'm
> unconvinced). And I will be out of office for two weeks starting
> nextweek, it's probably not the best to post and then disapear from
> the discussion. I might post the RFC if I can advance it in the next
> 48 hours, otherwise I think it is better to delay until I'm back from
> vacation.

I agree you better to do this after your vacation.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
