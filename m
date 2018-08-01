Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEEBC43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4D820851
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HzX5lCui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B4D820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732961AbeHADFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 23:05:23 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:38829 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732907AbeHADFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 23:05:22 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20180801012219epoutp01d443258d8270529c2341d5cd2f6bf5cf~GnhXUgqEG2798627986epoutp01z;
        Wed,  1 Aug 2018 01:22:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180801012219epoutp01d443258d8270529c2341d5cd2f6bf5cf~GnhXUgqEG2798627986epoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533086539;
        bh=f3qG1Q6loVfsFvCRbtPln5UrF52byAjSEQS9DBUcwYw=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=HzX5lCuitiud0pA93kGbUAoKPyGZSp7SzVzuVl13SSgsap8j9OotRUJiA/i9D0+fI
         dHLhwy7gZeSafpqzHAimyrkU3gDJ3vFr/BbsxbPFDMtJBGZJsk7uTqt9TUUx2J0fHs
         ITnLWJGwhK9HFuDSxbyWyxP2xWQHWTsu+LLVBxA0=
Received: from epsmges2p2.samsung.com (unknown [182.195.40.156]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20180801012217epcas1p379dd396ad890e05f17a4b004e74823fa~GnhUyurDa1005210052epcas1p3C;
        Wed,  1 Aug 2018 01:22:17 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.04.04443.84B016B5; Wed,  1 Aug 2018 10:22:16 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20180801012216epcas2p1c1df12162f447ac75d2c6db340c62e7e~GnhUYpZRJ1743417434epcas2p1D;
        Wed,  1 Aug 2018 01:22:16 +0000 (GMT)
X-AuditID: b6c32a46-d0bff7000000115b-eb-5b610b489136
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id C1.C4.03824.84B016B5; Wed,  1 Aug
        2018 10:22:16 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PCR00207D532TA0@mmp2.samsung.com>; Wed, 01 Aug 2018 10:22:16 +0900 (KST)
Message-id: <5B610B48.4030802@samsung.com>
Date:   Wed, 01 Aug 2018 10:22:16 +0900
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
In-reply-to: <20180731193953.GH68975@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzO6X0iVu+qbic4td5EA0Rqe2vHwVDiIsObSJSEmD0aU2/gWpi0
        t+ktbGiMqFGwxoXWCLMoPsDHKglQicFX1FJ8IUxQhonCFvHBCPOR+iAa1LbXRf863/l+3/c7
        5/flHBrThMkkutjhFl0OoYQlJ+GnOlJQGp8oWPTXxhejCd9lCtU+uIWj4POnBDoQ7iFQ99FL
        JGq6GwJoa0Mzibq3jFHo75edAN06s49EkV1hgI4M9KpQpGUYoLubj5Po+kCERDe6+gi07XyY
        Qq0v+SUavqm+CfBv3/gAX1fRi/Ptg42ADwZ2kPy9v86R/IX9TRR/++oWgm/rr8T539oCgI8E
        Z+cl/iRmFolCoejSio4CqbDYYTOzy/OtS62mb/SGNEMGSme1DsEumtns3Ly0nOKS6Gistkwo
        KY1SeYIsswuzMl1SqVvUFkmy28xaDAZOZ9Cn6zguuhpXL+ZMUckasahhqBZzVsz79cxoK1EB
        zs32AJqGzCJ4oiPJAybRGqYdwCMnz6qUzWsAOwe9uAckxEXbjj2llEILgP/+10XFCmrmCzi+
        ewiPdcKYOTDcty5GY0wKHHnhwxX9IIC/7/YSij4V3mj2gxjGmXlwvPJSnCej/IWRO2QMT2Xm
        wv7x4bhmBvMDPH3gVfys6UwyfPD2TxBrijE1BNxZ8z5umMbkwqGqSLxRAqOH2/sOx28KmcsU
        DAUeqpQRsuGJhlpKwdPg6JW2j3gmfBRoBYqhEsAXI1sJZVMN4LPrJz+6jfDRIY9KGW4KrOqY
        oJT01LBqu0aBPKzxblRGnlDBa0+8qmowy/9ZSv5PKfk/S+kgwALgS9Ep222izDk5nSzY5VKH
        TVcg2YMg/oJTc9pBY09uCDA0YCerneVrLBpCKJPL7SEAaYydrs782mrRqAuF8vWiS7K6SktE
        OQRM0ZC9WNKMAin6Hxxuq8HEGY1GZErPMOoz2K/U61fkWzSMTXCL60TRKbr+96nohKQKUDeQ
        ZTP77i0d2/VdNhqe0xLc0Kx1hOt/kcwXzczeQws6N10RHuffT08Ljvj9Xau+XfRjvY6bMtk7
        Ru9Jdt/8Wff6TVnKc/mdp27VKb8tZzSRfLwseHB+VurG3ld1gmXP4UZ4J++swfi9U7L2vwfk
        YKNP88/aWff/WJmYzLEPqyUWl4sEQyrmkoUPQhnqkdcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t9jQV0P7sRogzNvlCz+TjrGbjH9yWUW
        i00f37NazD9yjtXi7LKDbBZrbh9itGhevJ7N4mzTG3aL+1+PMlpc3jWHzeJz7xFGi6XXLzJZ
        fN7wmNHiduMKNotT1z+zWZw5fYnVonXvEXaLjV89HIQ81sxbw+jx+9ckRo/ZDRdZPHbcXcLo
        sWlVJ5vHnWt72Dz2z13D7nHlRBOrx5ar7SwefVtWMXp83iQXwB3FZZOSmpNZllqkb5fAlbH4
        3nTmggbVil2vNrI2MO6R62Lk5JAQMJFoXf6eHcQWEljHKPFkVyCIzSsgKPFj8j2WLkYODmYB
        eYkjl7IhTHWJKVNyuxi5gKrvM0q8mH2OFaJcS+LM+lmMIDaLgKrEj/aDYHE2oPj+FzfYQGx+
        AUWJqz8eM4LMERWIkOg+UQkSFhHQkHjy+zxYK7PADFaJjRdiQGxhAR+Jex2fWSF2/WWS6DjX
        BjaTU8BAou3SIvYJjAKzkFw6C+HSWQiXLmBkXsUomVpQnJueW2xUYJSXWq5XnJhbXJqXrpec
        n7uJERiN2w5r9e9gfLwk/hCjAAejEg/vieqEaCHWxLLiytxDjBIczEoivDYy8dFCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEefnzj0UKCaQnlqRmp6YWpBbBZJk4OKUaGJ3fTZFk6dm+MrthsXJy
        TNYGz4dJS8Ks/vTHz/dKtpwc1L63dP13r2uBlbdspPK+W/yVNnJ97Bfnqy8aP11z4Y3Kh07P
        dnNJNe62YP3gqfmgKLRGvNWcR6O9yO0g7+QVevnrK5y2XZ7Ltsxmx2zLCIllxky+jOLH5vDX
        N+89LP7C37zMNTBJiaU4I9FQi7moOBEAsYq6WcICAAA=
X-CMS-MailID: 20180801012216epcas2p1c1df12162f447ac75d2c6db340c62e7e
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180703234900epcas1p1cda806bab6bbe69228ca5ee56bc33f36
References: <20180703234705.227473-1-mka@chromium.org>
        <CGME20180703234900epcas1p1cda806bab6bbe69228ca5ee56bc33f36@epcas1p1.samsung.com>
        <20180703234705.227473-6-mka@chromium.org> <5B3C6C2A.1070205@samsung.com>
        <20180706175301.GG129942@google.com>
        <5399c191-e140-e2b8-629b-72ddfbf99b0f@samsung.com>
        <20180716175050.GZ129942@google.com> <20180731193953.GH68975@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 08월 01일 04:39, Matthias Kaehlcke wrote:
> On Mon, Jul 16, 2018 at 10:50:50AM -0700, Matthias Kaehlcke wrote:
>> On Thu, Jul 12, 2018 at 05:44:33PM +0900, Chanwoo Choi wrote:
>>> Hi Matthias,
>>>
>>> On 2018년 07월 07일 02:53, Matthias Kaehlcke wrote:
>>>> Hi Chanwoo,
>>>>
>>>> On Wed, Jul 04, 2018 at 03:41:46PM +0900, Chanwoo Choi wrote:
>>>>
>>>>> Firstly,
>>>>> I'm not sure why devfreq needs the devfreq_verify_within_limits() function.
>>>>>
>>>>> devfreq already used the OPP interface as default. It means that
>>>>> the outside of 'drivers/devfreq' can disable/enable the frequency
>>>>> such as drivers/thermal/devfreq_cooling.c. Also, when some device
>>>>> drivers disable/enable the specific frequency, the devfreq core
>>>>> consider them.
>>>>>
>>>>> So, devfreq doesn't need to devfreq_verify_within_limits() because
>>>>> already support some interface to change the minimum/maximum frequency
>>>>> of devfreq device. 
>>>>>
>>>>> In case of cpufreq subsystem, cpufreq only provides 'cpufreq_verify_with_limits()'
>>>>> to change the minimum/maximum frequency of cpu. some device driver cannot
>>>>> change the minimum/maximum frequency through OPP interface.
>>>>>
>>>>> But, in case of devfreq subsystem, as I explained already, devfreq support
>>>>> the OPP interface as default way. devfreq subsystem doesn't need to add
>>>>> other way to change the minimum/maximum frequency.
>>>>
>>>> Using the OPP interface exclusively works as long as a
>>>> enabling/disabling of OPPs is limited to a single driver
>>>> (drivers/thermal/devfreq_cooling.c). When multiple drivers are
>>>> involved you need a way to resolve conflicts, that's the purpose of
>>>> devfreq_verify_within_limits(). Please let me know if there are
>>>> existing mechanisms for conflict resolution that I overlooked.
>>>>
>>>> Possibly drivers/thermal/devfreq_cooling.c could be migrated to use
>>>> devfreq_verify_within_limits() instead of the OPP interface if
>>>> desired, however this seems beyond the scope of this series.
>>>
>>> Actually, if we uses this approach, it doesn't support the multiple drivers too.
>>> If non throttler drivers uses devfreq_verify_within_limits(), the conflict
>>> happen.
>>
>> As long as drivers limit the max freq there is no conflict, the lowest
>> max freq wins. I expect this to be the usual case, apparently it
>> worked for cpufreq for 10+ years.
>>
>> However it is correct that there would be a conflict if a driver
>> requests a min freq that is higher than the max freq requested by
>> another. In this case devfreq_verify_within_limits() resolves the
>> conflict by raising p->max to the min freq. Not sure if this is
>> something that would ever occur in practice though.
>>
>> If we are really concerned about this case it would also be an option
>> to limit the adjustment to the max frequency.
>>
>>> To resolve the conflict for multiple device driver, maybe OPP interface
>>> have to support 'usage_count' such as clk_enable/disable().
>>
>> This would require supporting negative usage count values, since a OPP
>> should not be enabled if e.g. thermal enables it but the throttler
>> disabled it or viceversa.
>>
>> Theoretically there could also be conflicts, like one driver disabling
>> the higher OPPs and another the lower ones, with the outcome of all
>> OPPs being disabled, which would be a more drastic conflict resolution
>> than that of devfreq_verify_within_limits().
>>
>> Viresh, what do you think about an OPP usage count?
> 
> Ping, can we try to reach a conclusion on this or at least keep the
> discussion going?
> 
> Not that it matters, but my preferred solution continues to be
> devfreq_verify_within_limits(). It solves conflicts in some way (which
> could be adjusted if needed) and has proven to work in practice for
> 10+ years in a very similar sub-system.

It is not true. Current cpufreq subsystem doesn't support external OPP
control to enable/disable the OPP entry. If some device driver
controls the OPP entry of cpufreq driver with opp_disable/enable(),
the operation is not working. Because cpufreq considers the limit
through 'cpufreq_verify_with_limits()' only.

As I already commented[1], there is different between cpufreq and devfreq.
[1] https://lkml.org/lkml/2018/7/4/80

Already, subsystem already used OPP interface in order to control
specific OPP entry. I don't want to provide two outside method
to control the frequency of devfreq driver. It might make the confusion.

I want to use only OPP interface to enable/disable frequency
even if we have to modify the OPP interface.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
