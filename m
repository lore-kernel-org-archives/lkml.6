Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C61C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36F121708
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="f2qTPY1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36F121708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbeHCCI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 22:08:28 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:62043 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbeHCCI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 22:08:28 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180803001452epoutp02d2f229edfdbe0143eb45a7314291e440~HN5CYT0Kf0066000660epoutp02Z;
        Fri,  3 Aug 2018 00:14:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180803001452epoutp02d2f229edfdbe0143eb45a7314291e440~HN5CYT0Kf0066000660epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533255292;
        bh=zc91UhEhTYFLzlWtGZcLd+BjI9C/BIk1/OBBLMmcRxw=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=f2qTPY1vUxgeLVjrp8DhPpmT/G1ZqXI6c+zuf+fAsDzvuaLppu3p06YaNfbnIAYK7
         013WTbJx5i70ZdMFn+g/VdD+cklSkHjjeEfiFe5zA1biOA4+DdLyeyYK6W/QX97d3i
         OjeenJjivzUvISg1OIdBlJGu+TxybmEUjbBI7C+c=
Received: from epsmges2p1.samsung.com (unknown [182.195.40.155]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180803001447epcas1p44a3ab2004f1944f9675a5ae0d4a62bc6~HN49-yx740865408654epcas1p4y;
        Fri,  3 Aug 2018 00:14:47 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        FE.E1.04473.77E936B5; Fri,  3 Aug 2018 09:14:47 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20180803001446epcas2p2140f46d3940f347d13c02a4afe1e708e~HN49Rzj6t3046830468epcas2p2Y;
        Fri,  3 Aug 2018 00:14:46 +0000 (GMT)
X-AuditID: b6c32a45-a2bff70000001179-7e-5b639e777134
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 25.72.03824.67E936B5; Fri,  3 Aug
        2018 09:14:46 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PCU00INLZCMJG00@mmp2.samsung.com>; Fri, 03 Aug 2018 09:14:46 +0900 (KST)
Message-id: <5B639E76.6050901@samsung.com>
Date:   Fri, 03 Aug 2018 09:14:46 +0900
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
In-reply-to: <20180802234820.GU68975@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmqW75vORog+N9ohZ/Jx1jt5j+5DKL
        xaaP71kt5h85x2pxdtlBNos1tw8xWjQvXs9mcbbpDbvF/a9HGS0u75rDZvG59wijxdLrF5ks
        Pm94zGhxu3EFm8Wp65/ZLM6cvsRq0br3CLvFxq8eDkIea+atYfT4/WsSo8fshossHjvuLmH0
        2LSqk83jzrU9bB77565h97hyoonVY8vVdhaPvi2rGD0+b5IL4I5KtclITUxJLVJIzUvOT8nM
        S7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBek1JoSwxpxQoFJBYXKykb2dTlF9a
        kqqQkV9cYqsUbWhopGdoYK5nZASkjWOtjEyBShJSM16cuMtUsMynYu3+l4wNjJ12XYycHBIC
        JhKzptxg7mLk4hAS2MEocfrobEYI5zujRMv1/4wwVf8W34dKbGCU2DDjIztIgldAUOLH5Hss
        XYwcHMwC8hJHLmWDhJkFNCVefJnEAlF/l1Hi1vsuRpAaXgEtiTtv80BqWARUJXa0TGQCsdmA
        wvtf3GADsfkFFCWu/ngMtldUIEJi5/xvYKtEBDQknvw+D3YDs8A0Vonuaf/BGoQFfCTudXxm
        BbE5BQwkJl1fxwZSJCFwjl1i6ex5bBAfuEg8vLCHCcIWlnh1fAs7hC0t8WzVRkaIhnZGiS8v
        mlkhnAmMEh9ObYbqMJZ4trCLCeI3PomOw3/ZQd6REOCV6GgTgijxkGhZcJ0d4uUGFonGW6+Z
        JjDKzkIKpVmIUJqFFEoLGJlXMYqlFhTnpqcWGxUY6hUn5haX5qXrJefnbmIEJ2Et1x2MM875
        HGIU4GBU4uG9oJocLcSaWFZcmXuIUYKDWUmE920nUIg3JbGyKrUoP76oNCe1+BCjKTCUJzJL
        iSbnAzNEXkm8oamRsbGxham5pbGBpZI4b7VfcLSQQHpiSWp2ampBahFMHxMHp1QDY27jr5xn
        uRL1W0onbT15y8nzRfPuIxnv+t+2hPJ8T0icO7//5/+ChQXsi/fEPzm05VlSYcppc8OAtgge
        3oR6b413XPsTpB9dS9H/KTRtIV9Gd1P7fba5Z4vjXdZlzns3LS/iuZPw+YdZL2a4cpSei1Wd
        vzT6q/XZF2vLIk95Lmjf2SAd28E4RYmlOCPRUIu5qDgRAKWovgzYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t9jQd2yecnRBlMfaVn8nXSM3WL6k8ss
        Fps+vme1mH/kHKvF2WUH2SzW3D7EaNG8eD2bxdmmN+wW978eZbS4vGsOm8Xn3iOMFkuvX2Sy
        +LzhMaPF7cYVbBanrn9mszhz+hKrReveI+wWG796OAh5rJm3htHj969JjB6zGy6yeOy4u4TR
        Y9OqTjaPO9f2sHnsn7uG3ePKiSZWjy1X21k8+rasYvT4vEkugDuKyyYlNSezLLVI3y6BK+PF
        ibtMBct8Ktbuf8nYwNhp18XIySEhYCLxb/F9xi5GLg4hgXWMEv/OH2QDSfAKCEr8mHyPpYuR
        g4NZQF7iyKVsCFNdYsqUXJAKIYH7jBKdP8xBwrwCWhJ33uaBhFkEVCV2tExkArHZgML7X9wA
        G8gvoChx9cdjRpByUYEIie4TlSBhEQENiSe/zzOC2MwCM1glNl6IAbGFBXwk7nV8ZoU4rIFF
        YtaDlSwgCU4BA4lJ19exTWAUmIXkzlkId85CuHMBI/MqRsnUguLc9NxiowKjvNRyveLE3OLS
        vHS95PzcTYzAWNx2WKt/B+PjJfGHGAU4GJV4eC+oJkcLsSaWFVfmHmKU4GBWEuF92wkU4k1J
        rKxKLcqPLyrNSS0+xCjNwaIkzsuffyxSSCA9sSQ1OzW1ILUIJsvEwSnVwDjb6M8fvU7v49O3
        mz7dHNFm81E8P6poTvfVPdxh3+5M098knBq8eqnCvd0mZpqaW5SSbVnTc65c+fOoZe6MnuXh
        C7q/z50k2PTAU6HiZlSG/tfEWydDW+IU/T/v+mZop/DbZfFqz009O55OnJgXoHTgfNu/M805
        nuyqj9/FTmpdGuDYtD7a11aJpTgj0VCLuag4EQBO0v3SwQIAAA==
X-CMS-MailID: 20180803001446epcas2p2140f46d3940f347d13c02a4afe1e708e
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180802234831epcas5p3951e8f64381a27d40865d339878751d1
References: <20180703234705.227473-6-mka@chromium.org>
        <5B3C6C2A.1070205@samsung.com> <20180706175301.GG129942@google.com>
        <5399c191-e140-e2b8-629b-72ddfbf99b0f@samsung.com>
        <20180716175050.GZ129942@google.com> <20180731193953.GH68975@google.com>
        <5B610B48.4030802@samsung.com> <20180801170824.GJ68975@google.com>
        <5B626563.1090302@samsung.com> <20180802231343.GS68975@google.com>
        <CGME20180802234831epcas5p3951e8f64381a27d40865d339878751d1@epcas5p3.samsung.com>
        <20180802234820.GU68975@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018년 08월 03일 08:48, Matthias Kaehlcke wrote:
> On Thu, Aug 02, 2018 at 04:13:43PM -0700, Matthias Kaehlcke wrote:
>> Hi Chanwoo,
>>
>> On Thu, Aug 02, 2018 at 10:58:59AM +0900, Chanwoo Choi wrote:
>>> Hi Matthias,
>>>
>>> On 2018년 08월 02일 02:08, Matthias Kaehlcke wrote:
>>>> Hi Chanwoo,
>>>>
>>>> On Wed, Aug 01, 2018 at 10:22:16AM +0900, Chanwoo Choi wrote:
>>>>> On 2018년 08월 01일 04:39, Matthias Kaehlcke wrote:
>>>>>> On Mon, Jul 16, 2018 at 10:50:50AM -0700, Matthias Kaehlcke wrote:
>>>>>>> On Thu, Jul 12, 2018 at 05:44:33PM +0900, Chanwoo Choi wrote:
>>>>>>>> Hi Matthias,
>>>>>>>>
>>>>>>>> On 2018년 07월 07일 02:53, Matthias Kaehlcke wrote:
>>>>>>>>> Hi Chanwoo,
>>>>>>>>>
>>>>>>>>> On Wed, Jul 04, 2018 at 03:41:46PM +0900, Chanwoo Choi wrote:
>>>>>>>>>
>>>>>>>>>> Firstly,
>>>>>>>>>> I'm not sure why devfreq needs the devfreq_verify_within_limits() function.
>>>>>>>>>>
>>>>>>>>>> devfreq already used the OPP interface as default. It means that
>>>>>>>>>> the outside of 'drivers/devfreq' can disable/enable the frequency
>>>>>>>>>> such as drivers/thermal/devfreq_cooling.c. Also, when some device
>>>>>>>>>> drivers disable/enable the specific frequency, the devfreq core
>>>>>>>>>> consider them.
>>>>>>>>>>
>>>>>>>>>> So, devfreq doesn't need to devfreq_verify_within_limits() because
>>>>>>>>>> already support some interface to change the minimum/maximum frequency
>>>>>>>>>> of devfreq device. 
>>>>>>>>>>
>>>>>>>>>> In case of cpufreq subsystem, cpufreq only provides 'cpufreq_verify_with_limits()'
>>>>>>>>>> to change the minimum/maximum frequency of cpu. some device driver cannot
>>>>>>>>>> change the minimum/maximum frequency through OPP interface.
>>>>>>>>>>
>>>>>>>>>> But, in case of devfreq subsystem, as I explained already, devfreq support
>>>>>>>>>> the OPP interface as default way. devfreq subsystem doesn't need to add
>>>>>>>>>> other way to change the minimum/maximum frequency.
>>>>>>>>>
>>>>>>>>> Using the OPP interface exclusively works as long as a
>>>>>>>>> enabling/disabling of OPPs is limited to a single driver
>>>>>>>>> (drivers/thermal/devfreq_cooling.c). When multiple drivers are
>>>>>>>>> involved you need a way to resolve conflicts, that's the purpose of
>>>>>>>>> devfreq_verify_within_limits(). Please let me know if there are
>>>>>>>>> existing mechanisms for conflict resolution that I overlooked.
>>>>>>>>>
>>>>>>>>> Possibly drivers/thermal/devfreq_cooling.c could be migrated to use
>>>>>>>>> devfreq_verify_within_limits() instead of the OPP interface if
>>>>>>>>> desired, however this seems beyond the scope of this series.
>>>>>>>>
>>>>>>>> Actually, if we uses this approach, it doesn't support the multiple drivers too.
>>>>>>>> If non throttler drivers uses devfreq_verify_within_limits(), the conflict
>>>>>>>> happen.
>>>>>>>
>>>>>>> As long as drivers limit the max freq there is no conflict, the lowest
>>>>>>> max freq wins. I expect this to be the usual case, apparently it
>>>>>>> worked for cpufreq for 10+ years.
>>>>>>>
>>>>>>> However it is correct that there would be a conflict if a driver
>>>>>>> requests a min freq that is higher than the max freq requested by
>>>>>>> another. In this case devfreq_verify_within_limits() resolves the
>>>>>>> conflict by raising p->max to the min freq. Not sure if this is
>>>>>>> something that would ever occur in practice though.
>>>>>>>
>>>>>>> If we are really concerned about this case it would also be an option
>>>>>>> to limit the adjustment to the max frequency.
>>>>>>>
>>>>>>>> To resolve the conflict for multiple device driver, maybe OPP interface
>>>>>>>> have to support 'usage_count' such as clk_enable/disable().
>>>>>>>
>>>>>>> This would require supporting negative usage count values, since a OPP
>>>>>>> should not be enabled if e.g. thermal enables it but the throttler
>>>>>>> disabled it or viceversa.
>>>>>>>
>>>>>>> Theoretically there could also be conflicts, like one driver disabling
>>>>>>> the higher OPPs and another the lower ones, with the outcome of all
>>>>>>> OPPs being disabled, which would be a more drastic conflict resolution
>>>>>>> than that of devfreq_verify_within_limits().
>>>>>>>
>>>>>>> Viresh, what do you think about an OPP usage count?
>>>>>>
>>>>>> Ping, can we try to reach a conclusion on this or at least keep the
>>>>>> discussion going?
>>>>>>
>>>>>> Not that it matters, but my preferred solution continues to be
>>>>>> devfreq_verify_within_limits(). It solves conflicts in some way (which
>>>>>> could be adjusted if needed) and has proven to work in practice for
>>>>>> 10+ years in a very similar sub-system.
>>>>>
>>>>> It is not true. Current cpufreq subsystem doesn't support external OPP
>>>>> control to enable/disable the OPP entry. If some device driver
>>>>> controls the OPP entry of cpufreq driver with opp_disable/enable(),
>>>>> the operation is not working. Because cpufreq considers the limit
>>>>> through 'cpufreq_verify_with_limits()' only.
>>>>
>>>> Ok, we can probably agree that using cpufreq_verify_with_limits()
>>>> exclusively seems to have worked well for cpufreq, and that in their
>>>> overall purpose cpufreq and devfreq are similar subsystems.
>>>>
>>>> The current throttler series with devfreq_verify_within_limits() takes
>>>> the enabled OPPs into account, the lowest and highest OPP are used as
>>>> a starting point for the frequency adjustment and (in theory) the
>>>> frequency range should only be narrowed by
>>>> devfreq_verify_within_limits().
>>>>
>>>>> As I already commented[1], there is different between cpufreq and devfreq.
>>>>> [1] https://lkml.org/lkml/2018/7/4/80
>>>>>
>>>>> Already, subsystem already used OPP interface in order to control
>>>>> specific OPP entry. I don't want to provide two outside method
>>>>> to control the frequency of devfreq driver. It might make the confusion.
>>>>
>>>> I understand your point, it would indeed be preferable to have a
>>>> single method. However I'm not convinced that the OPP interface is
>>>> a suitable solution, as I exposed earlier in this thread (quoted
>>>> below).
>>>>
>>>> I would like you to at least consider the possibility of changing
>>>> drivers/thermal/devfreq_cooling.c to devfreq_verify_within_limits().
>>>> Besides that it's not what is currently used, do you see any technical
>>>> concerns that would make devfreq_verify_within_limits() an unsuitable
>>>> or inferior solution?
>>>
>>> As we already discussed, devfreq_verify_within_limits() doesn't support
>>> the multiple outside controllers (e.g., devfreq-cooling.c).
>>
>> That's incorrect, its purpose is precisely that.
>>
>> Are you suggesting that cpufreq with its use of
>> cpufreq_verify_within_limits() (the inspiration for
>> devfreq_verify_within_limits()) is broken? It is used by cpu_cooling.c
>> and other drivers when receiving a CPUFREQ_ADJUST event, essentially
>> what I am proposing with DEVFREQ_ADJUST.
>>
>> Could you elaborate why this model wouldn't work for devfreq? "OPP
>> interface is mandatory for devfreq" isn't really a technical argument,
>> is it mandatory for any other reason than that it is the interface
>> that is currently used?
>>
>>> After you are suggesting the throttler core, there are at least two
>>> outside controllers (e.g., devfreq-cooling.c and throttler driver).
>>> As I knew the problem about conflict, I cannot agree the temporary
>>> method. OPP interface is mandatory for devfreq in order to control
>>> the OPP (frequency/voltage). In this situation, we have to try to
>>> find the method through OPP interface.
>>
>> What do you mean with "temporary method"?
>>
>> We can try to find a method through the OPP interface, but at this
>> point I'm not convinced that it is technically necessary or even
>> preferable.
>>
>> Another inconvenient of the OPP approach for both devfreq-cooling.c
>> and the throttler is that they have to bother with disabling all OPPs
>> above/below the max/min (they don't/shouldn't have to care), instead
>> of just telling devfreq the max/min.
> 
> And a more important one: both drivers now have to keep track which
> OPPs they enabled/disabled previously, done are the days of a simple
> dev_pm_opp_enable/disable() in devfreq_cooling. Certainly it is
> possible and not very complex to implement, but is it really the
> best/a good solution?


As I replied them right before, Each outside driver has their own throttling
policy to control OPP entries. They don't care the requirement of other
driver and cannot know the requirement of other driver. devfreq core can only
recognize them and then only consider enabled OPP entris without disabled OPP entries.

For example1,
       | devfreq-cooling| throttler
---------------------------------------
500Mhz | disabled       | disabled
400Mhz | disabled       | disabled
300Mhz |                | disabled
200Mhz |                |
100Mhz |                |
=> devfreq driver can use only 100/200Mhz


For example2,
       | devfreq-cooling| throttler
---------------------------------------
500Mhz | disabled       | disabled
400Mhz | disabled       |
300Mhz | disabled       |
200Mhz |                |
100Mhz |                |
=> devfreq driver can use only 100/200Mhz


For example3,
       | devfreq-cooling| throttler
---------------------------------------
500Mhz | disabled       | disabled
400Mhz |                |
300Mhz |                |
200Mhz |                | disabled
100Mhz |                | disabled
=> devfreq driver can use only 300/400Mhz


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
