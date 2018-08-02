Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3969DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF3F208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="c6xWJ/su"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF3F208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbeHBDrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 23:47:49 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:50036 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbeHBDrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 23:47:49 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180802015904epoutp03004608ab0e73e8b8de3dfd4a5b527ffc~G7quzI6-U1515115151epoutp03j;
        Thu,  2 Aug 2018 01:59:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180802015904epoutp03004608ab0e73e8b8de3dfd4a5b527ffc~G7quzI6-U1515115151epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533175144;
        bh=cqk+Psm1MRRV6v5cySSy/65a/mSX4T3KInwOWT04t0g=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=c6xWJ/suTQpuhV1aqB9StEl/ZwfWFjyJoUtXYFMt99wyNyBPCT1tUr2dV7CxpONL6
         xRk3/1TQIDieWfLI25bcZ14beE0ytbfydoroX8rOGvbOVIDaXUGlR41AEwPom+BToH
         oESZkut5q4EjWCy5se+tzuYkOThCaCAn+/xxH6ew=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180802015900epcas1p2e9c280da3e0368f8add6055f49e3673c~G7qrl9SCY2717427174epcas1p29;
        Thu,  2 Aug 2018 01:59:00 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.51.04176.465626B5; Thu,  2 Aug 2018 10:59:00 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180802015900epcas1p11ff577c0eec97e3a14bc3b099d2108ff~G7qrMWeOe2210622106epcas1p1L;
        Thu,  2 Aug 2018 01:59:00 +0000 (GMT)
X-AuditID: b6c32a37-6ddff70000001050-53-5b626564ea3f
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.E7.03704.465626B5; Thu,  2 Aug 2018 10:59:00 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PCT00D4M9IBRV00@mmp1.samsung.com>; Thu, 02 Aug 2018 10:59:00 +0900 (KST)
Message-id: <5B626563.1090302@samsung.com>
Date:   Thu, 02 Aug 2018 10:58:59 +0900
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
In-reply-to: <20180801170824.GJ68975@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmgW5KalK0QVefmcXfScfYLaY/ucxi
        senje1aL+UfOsVqcXXaQzWLN7UOMFs2L17NZnG16w25x/+tRRovLu+awWXzuPcJosfT6RSaL
        zxseM1rcblzBZnHq+mc2izOnL7FatO49wm6x8auHg5DHmnlrGD1+/5rE6DG74SKLx467Sxg9
        Nq3qZPO4c20Pm8f+uWvYPa6caGL12HK1ncWjb8sqRo/Pm+QCuKNSbTJSE1NSixRS85LzUzLz
        0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAXlNSKEvMKQUKBSQWFyvp29kU5ZeW
        pCpk5BeX2CpFGxoa6RkamOsZGQFp41grI1OgkoTUjPvLzAu+OVWcmvWKrYHxg1kXIyeHhICJ
        xI4DfUxdjFwcQgI7GCVuTt0L5XxnlPi1s58ZpurvyclQid2MEjsufWIDSfAKCEr8mHyPpYuR
        g4NZQF7iyKVskDCzgKbEiy+TWCDq7zJKbP77mRGiXkui7WAXWC+LgKrExEd/weJsQPH9L26A
        xfkFFCWu/ngMFhcViJDYOf8bO4gtIqAh8eT3eUaQocwC01gluqf9B2sQFvCRuNfxmRXE5hQw
        kOh+sxnsUgmBU+wS049fhnrBReLC5YesELawxKvjW9hBrpYQkJa4dNQWor6dUeLLi2ZWCGcC
        o8SHUyCTQBqMJZ4t7GKC+I1P4t3XHlaIZl6JjjYhCNNDYtrEWoiPDzFL7F5ynHUCo+wspECa
        hQikWUiBtICReRWjWGpBcW56arFhgbFecWJucWleul5yfu4mRnAC1jLfwbjhnM8hRgEORiUe
        3hsMSdFCrIllxZW5hxglOJiVRHibPYBCvCmJlVWpRfnxRaU5qcWHGE2BYTyRWUo0OR+YHfJK
        4g1NjYyNjS1MDM1MDQ2VxHmN/IKjhQTSE0tSs1NTC1KLYPqYODilGhid+Pfn7Nhn+3nBpVsO
        WU6rbqmc3+S64aeNt1S9jsfuc+VC839xzLL++e7LwtC9qVdqWZNnVN8+NC86zUlxrpx8+s1N
        FZdEX4jyrFOUDgp58H6TinlhoYj00459Yiv+Hmm+nyfELJ+hmqDhuc393qJ5q+scHTa+r0t5
        8F38v0KKvOWvZzNMrq1VYinOSDTUYi4qTgQAo8+JmNYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t9jAd2U1KRogy2npC3+TjrGbjH9yWUW
        i00f37NazD9yjtXi7LKDbBZrbh9itGhevJ7N4mzTG3aL+1+PMlpc3jWHzeJz7xFGi6XXLzJZ
        fN7wmNHiduMKNotT1z+zWZw5fYnVonXvEXaLjV89HIQ81sxbw+jx+9ckRo/ZDRdZPHbcXcLo
        sWlVJ5vHnWt72Dz2z13D7nHlRBOrx5ar7SwefVtWMXp83iQXwB3FZZOSmpNZllqkb5fAlXF/
        mXnBN6eKU7NesTUwfjDrYuTkkBAwkfh7cjJTFyMXh5DATkaJA1fnM4MkeAUEJX5MvsfSxcjB
        wSwgL3HkUjaEqS4xZUouSIWQwH1Gic9X0iCqtSTaDnaxgdgsAqoSEx/9ZQSx2YDi+1/cAIvz
        CyhKXP3xmBFkjKhAhET3iUqQsIiAhsST3+fBypkFZrBKbLwQA2ILC/hI3Ov4zApx2SFmiZd7
        drKCJDgFDCS632xmmsAoMAvJobMQDp2FcOgCRuZVjJKpBcW56bnFRgWGeanlesWJucWleel6
        yfm5mxiBsbjtsFbfDsb7S+IPMQpwMCrx8Db8S4wWYk0sK67MPcQowcGsJMLb7JEULcSbklhZ
        lVqUH19UmpNafIhRmoNFSZz3dt6xSCGB9MSS1OzU1ILUIpgsEwenVAOjzaVTP+N2aXH9rSt+
        k/nB/s/DpX7P7UWnhC7z4zTo2B/adDQ/rSZbM/oE/5xP/nLlinrTttzmEj5ZqsqfVKT+6cbW
        zQIHNu2Q3HDasGdKygaxysced45ckTrcLM3rI3qtxUuF6b/6053XZ75UKm14J7V+wmcbQQ8O
        bpfsG+uzxHsWWL9kmTtbiaU4I9FQi7moOBEApnhbYMECAAA=
X-CMS-MailID: 20180802015900epcas1p11ff577c0eec97e3a14bc3b099d2108ff
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180703234900epcas1p1cda806bab6bbe69228ca5ee56bc33f36
References: <20180703234705.227473-1-mka@chromium.org>
        <CGME20180703234900epcas1p1cda806bab6bbe69228ca5ee56bc33f36@epcas1p1.samsung.com>
        <20180703234705.227473-6-mka@chromium.org> <5B3C6C2A.1070205@samsung.com>
        <20180706175301.GG129942@google.com>
        <5399c191-e140-e2b8-629b-72ddfbf99b0f@samsung.com>
        <20180716175050.GZ129942@google.com> <20180731193953.GH68975@google.com>
        <5B610B48.4030802@samsung.com> <20180801170824.GJ68975@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018년 08월 02일 02:08, Matthias Kaehlcke wrote:
> Hi Chanwoo,
> 
> On Wed, Aug 01, 2018 at 10:22:16AM +0900, Chanwoo Choi wrote:
>> On 2018년 08월 01일 04:39, Matthias Kaehlcke wrote:
>>> On Mon, Jul 16, 2018 at 10:50:50AM -0700, Matthias Kaehlcke wrote:
>>>> On Thu, Jul 12, 2018 at 05:44:33PM +0900, Chanwoo Choi wrote:
>>>>> Hi Matthias,
>>>>>
>>>>> On 2018년 07월 07일 02:53, Matthias Kaehlcke wrote:
>>>>>> Hi Chanwoo,
>>>>>>
>>>>>> On Wed, Jul 04, 2018 at 03:41:46PM +0900, Chanwoo Choi wrote:
>>>>>>
>>>>>>> Firstly,
>>>>>>> I'm not sure why devfreq needs the devfreq_verify_within_limits() function.
>>>>>>>
>>>>>>> devfreq already used the OPP interface as default. It means that
>>>>>>> the outside of 'drivers/devfreq' can disable/enable the frequency
>>>>>>> such as drivers/thermal/devfreq_cooling.c. Also, when some device
>>>>>>> drivers disable/enable the specific frequency, the devfreq core
>>>>>>> consider them.
>>>>>>>
>>>>>>> So, devfreq doesn't need to devfreq_verify_within_limits() because
>>>>>>> already support some interface to change the minimum/maximum frequency
>>>>>>> of devfreq device. 
>>>>>>>
>>>>>>> In case of cpufreq subsystem, cpufreq only provides 'cpufreq_verify_with_limits()'
>>>>>>> to change the minimum/maximum frequency of cpu. some device driver cannot
>>>>>>> change the minimum/maximum frequency through OPP interface.
>>>>>>>
>>>>>>> But, in case of devfreq subsystem, as I explained already, devfreq support
>>>>>>> the OPP interface as default way. devfreq subsystem doesn't need to add
>>>>>>> other way to change the minimum/maximum frequency.
>>>>>>
>>>>>> Using the OPP interface exclusively works as long as a
>>>>>> enabling/disabling of OPPs is limited to a single driver
>>>>>> (drivers/thermal/devfreq_cooling.c). When multiple drivers are
>>>>>> involved you need a way to resolve conflicts, that's the purpose of
>>>>>> devfreq_verify_within_limits(). Please let me know if there are
>>>>>> existing mechanisms for conflict resolution that I overlooked.
>>>>>>
>>>>>> Possibly drivers/thermal/devfreq_cooling.c could be migrated to use
>>>>>> devfreq_verify_within_limits() instead of the OPP interface if
>>>>>> desired, however this seems beyond the scope of this series.
>>>>>
>>>>> Actually, if we uses this approach, it doesn't support the multiple drivers too.
>>>>> If non throttler drivers uses devfreq_verify_within_limits(), the conflict
>>>>> happen.
>>>>
>>>> As long as drivers limit the max freq there is no conflict, the lowest
>>>> max freq wins. I expect this to be the usual case, apparently it
>>>> worked for cpufreq for 10+ years.
>>>>
>>>> However it is correct that there would be a conflict if a driver
>>>> requests a min freq that is higher than the max freq requested by
>>>> another. In this case devfreq_verify_within_limits() resolves the
>>>> conflict by raising p->max to the min freq. Not sure if this is
>>>> something that would ever occur in practice though.
>>>>
>>>> If we are really concerned about this case it would also be an option
>>>> to limit the adjustment to the max frequency.
>>>>
>>>>> To resolve the conflict for multiple device driver, maybe OPP interface
>>>>> have to support 'usage_count' such as clk_enable/disable().
>>>>
>>>> This would require supporting negative usage count values, since a OPP
>>>> should not be enabled if e.g. thermal enables it but the throttler
>>>> disabled it or viceversa.
>>>>
>>>> Theoretically there could also be conflicts, like one driver disabling
>>>> the higher OPPs and another the lower ones, with the outcome of all
>>>> OPPs being disabled, which would be a more drastic conflict resolution
>>>> than that of devfreq_verify_within_limits().
>>>>
>>>> Viresh, what do you think about an OPP usage count?
>>>
>>> Ping, can we try to reach a conclusion on this or at least keep the
>>> discussion going?
>>>
>>> Not that it matters, but my preferred solution continues to be
>>> devfreq_verify_within_limits(). It solves conflicts in some way (which
>>> could be adjusted if needed) and has proven to work in practice for
>>> 10+ years in a very similar sub-system.
>>
>> It is not true. Current cpufreq subsystem doesn't support external OPP
>> control to enable/disable the OPP entry. If some device driver
>> controls the OPP entry of cpufreq driver with opp_disable/enable(),
>> the operation is not working. Because cpufreq considers the limit
>> through 'cpufreq_verify_with_limits()' only.
> 
> Ok, we can probably agree that using cpufreq_verify_with_limits()
> exclusively seems to have worked well for cpufreq, and that in their
> overall purpose cpufreq and devfreq are similar subsystems.
> 
> The current throttler series with devfreq_verify_within_limits() takes
> the enabled OPPs into account, the lowest and highest OPP are used as
> a starting point for the frequency adjustment and (in theory) the
> frequency range should only be narrowed by
> devfreq_verify_within_limits().
> 
>> As I already commented[1], there is different between cpufreq and devfreq.
>> [1] https://lkml.org/lkml/2018/7/4/80
>>
>> Already, subsystem already used OPP interface in order to control
>> specific OPP entry. I don't want to provide two outside method
>> to control the frequency of devfreq driver. It might make the confusion.
> 
> I understand your point, it would indeed be preferable to have a
> single method. However I'm not convinced that the OPP interface is
> a suitable solution, as I exposed earlier in this thread (quoted
> below).
> 
> I would like you to at least consider the possibility of changing
> drivers/thermal/devfreq_cooling.c to devfreq_verify_within_limits().
> Besides that it's not what is currently used, do you see any technical
> concerns that would make devfreq_verify_within_limits() an unsuitable
> or inferior solution?

As we already discussed, devfreq_verify_within_limits() doesn't support
the multiple outside controllers (e.g., devfreq-cooling.c).

After you are suggesting the throttler core, there are at least two
outside controllers (e.g., devfreq-cooling.c and throttler driver).
As I knew the problem about conflict, I cannot agree the temporary
method. OPP interface is mandatory for devfreq in order to control
the OPP (frequency/voltage). In this situation, we have to try to
find the method through OPP interface.

We can refer to regulator/clock. Multiple device driver can use
the regulator/clock without any problem. I think that usage of OPP
is similiar with regulator/clock. As you mentioned, maybe OPP
would handle the negative count. Although opp_enable/opp_disable()
have to handle the negative count and opp_enable/opp_disable()
can support the multiple usage from device drivers, I think that
this approach is right.


> 
>> I want to use only OPP interface to enable/disable frequency
>> even if we have to modify the OPP interface.
> 
> These are the concerns I raised earlier about a solution with OPP
> usage counts:
> 
> "This would require supporting negative usage count values, since a OPP
> should not be enabled if e.g. thermal enables it but the throttler
> disabled it or viceversa.

Already replied	about negative usage count. I think that negative usage count
is not problem if this approach could resolve the issue.

> 
> Theoretically there could also be conflicts, like one driver disabling
> the higher OPPs and another the lower ones, with the outcome of all
> OPPs being disabled, which would be a more drastic conflict resolution
> than that of devfreq_verify_within_limits()."
> 
> What do you think about these points?

It depends on how to use OPP interface on multiple device driver.
Even if devfreq/opp provides the control method, outside device driver
are misusing them. It is problem of user.

Instead, if we use the OPP interface, we can check why OPP entry
is disabled or enabled through usage count.

> 
> The negative usage counts aren't necessarily a dealbreaker in a
> technical sense, though I'm not a friend of quirky interfaces that
> don't behave like a typical user would expect (e.g. an OPP isn't
> necessarily enabled after dev_pm_opp_enable()).
> 
> I can sent an RFC with OPP usage counts, though due to the above
> concerns I have doubts it will be well received.

Please add me to Cc list.

> 
> Thanks
> 
> Matthias
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
