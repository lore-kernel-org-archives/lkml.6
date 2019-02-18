Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A885C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C8521848
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zw5TmzTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbfBRLWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:22:18 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:44586 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfBRLWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:22:18 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190218112214epoutp0247f5436091f788b1a5805056e00275cd~EcXix4sPM2352023520epoutp02r
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 11:22:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190218112214epoutp0247f5436091f788b1a5805056e00275cd~EcXix4sPM2352023520epoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550488934;
        bh=ZGhyztmNpsyqMybUQGxO4gznTwgUBOQmyjP9cpNHIA8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Zw5TmzTSV1masfxN/JFO4Be1FKUNCBz2kgynDMPi4vlS5HIJq90TSGQ0IvMgGOCad
         zjzQxcWR6zmd9rOBSYM9OmBxdTOFJvau6IClPNXoZG5JdwqqqeTgtIB1923iqEsUdf
         67IMXabjjhgBYGU3xN0Jx6jvKerFkZslmZZ1SIwA=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190218112210epcas1p4e7aec218040dccb33d69c09b49911e52~EcXfDMtOy1098310983epcas1p4A;
        Mon, 18 Feb 2019 11:22:10 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.72.04069.2659A6C5; Mon, 18 Feb 2019 20:22:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190218112210epcas1p1ae2febb02d9a0b8f3fea0320e9609678~EcXefpPOb1520415204epcas1p1R;
        Mon, 18 Feb 2019 11:22:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190218112210epsmtrp1931411fce132ba5f26f3d46df84084e2~EcXeb31sE3191931919epsmtrp19;
        Mon, 18 Feb 2019 11:22:10 +0000 (GMT)
X-AuditID: b6c32a37-971ff70000000fe5-9f-5c6a9562fe7c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.58.03971.2659A6C5; Mon, 18 Feb 2019 20:22:10 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190218112210epsmtip11f78b46756a3379255697e0fcabe0cd4~EcXeOIYUS0342503425epsmtip1g;
        Mon, 18 Feb 2019 11:22:10 +0000 (GMT)
Subject: Re: [PATCH 4/4] PM / devfreq: Handle monitor start/stop in the
 devfreq core
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Chanwoo Choi <cwchoi00@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Lukasz Luba <l.luba@partner.samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <59a6bb5a-17d8-6b90-4ad4-ca508eac0c39@samsung.com>
Date:   Mon, 18 Feb 2019 20:22:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215225621.GG117604@google.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmnm7S1KwYg2m79S2eHdW2aJm1iMXi
        bNMbdotbDTIWl3fNYbP43HuE0aLzyywga8NjRovbjSvYLH7umsfiwOUxu+Eii8fOWXfZPXqb
        37F5HHy3h8mjb8sqRo/Pm+QC2KKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyV
        FPISc1NtlVx8AnTdMnOADlNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFFgW6BUn
        5haX5qXrJefnWhkaGBiZAhUmZGfM2XCCveC6QUXX2lWMDYwH1LoYOTkkBEwk1p2cxdLFyMUh
        JLCDUeLCv7eMEM4nRonutk6ozDdGiebrtxhhWv493sQKkdjLKHFuwWYo5z2jxKon91lBqoQF
        wiTef9zCBmKLCGhIPPl9Hmwus8AXJolNbX+ZQBJsAloS+1/cACviF1CUuPrjMdgKXgE7iT87
        17CD2CwCqhJLdh4EqxEViJA43PsOqkZQ4uTMJywgNqeAocSkEw1gM5kFxCVuPZkPZctLNG+d
        zQyyWEKgm13i2LWLbBA/uEhsenONCcIWlnh1fAs7hC0l8bK/Dcqullh58ggbRHMHo8SW/RdY
        IRLGEvuXTgZq5gDaoCmxfpc+xDI+iXdfe1hBwhICvBIdbUIQ1coSlx/chVolKbG4vRPqBA+J
        zX+Psk1gVJyF5J1ZSF6YheSFWQjLFjCyrGIUSy0ozk1PLTYsMEaO702M4GSrZb6DccM5n0OM
        AhyMSjy8H8oyY4RYE8uKK3MPMUpwMCuJ8AbFZsUI8aYkVlalFuXHF5XmpBYfYjQFhvZEZinR
        5HxgJsgriTc0NTI2NrYwMTQzNTRUEudd7+AcIySQnliSmp2aWpBaBNPHxMEp1cAoV3Ekmru4
        /svBwrWtL9fMcd5+Z4rfMhGm6lPpbKcWSJjkuM1ndr1oqyl47+KFnb481UUKebJ+/kte86n5
        WHOdZNyUpuPOljbldd5X103foheLem6atuLQovpdjw/bvd5fHxGQe17//f+AnNd1Qa8O7N58
        4caViv3uq6qnvsyN02pYHjBdq9VViaU4I9FQi7moOBEA6Ugc9MwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWy7bCSnG7S1KwYg+tTOS2eHdW2aJm1iMXi
        bNMbdotbDTIWl3fNYbP43HuE0aLzyywga8NjRovbjSvYLH7umsfiwOUxu+Eii8fOWXfZPXqb
        37F5HHy3h8mjb8sqRo/Pm+QC2KK4bFJSczLLUov07RK4MuZsOMFecN2gomvtKsYGxgNqXYyc
        HBICJhL/Hm9i7WLk4hAS2M0oceTzJTaIhKTEtItHmbsYOYBsYYnDh4tBwkICbxklTq2wArGF
        BcIk3n/cAlYuIqAh8eT3eUYQm1ngG5PE9NehEDPvMkt8+fKHCSTBJqAlsf/FDbAGfgFFias/
        HoM18ArYSfzZuYYdxGYRUJVYsvMgWI2oQITEx6f7mCBqBCVOznzCAmJzChhKTDrRwASxTF3i
        z7xLzBC2uMStJ/Oh4vISzVtnM09gFJ6FpH0WkpZZSFpmIWlZwMiyilEytaA4Nz232LDAMC+1
        XK84Mbe4NC9dLzk/dxMjOOK0NHcwXl4Sf4hRgINRiYf3Q1lmjBBrYllxZe4hRgkOZiUR3qDY
        rBgh3pTEyqrUovz4otKc1OJDjNIcLErivE/zjkUKCaQnlqRmp6YWpBbBZJk4OKUaGNtSrbdP
        Yri3y/9dV1PI9yO1Aeu33D7TX/dLnudv1hL5k3HrhWeVJE7pFYyzMI+0Xrzp9kTW7hMSzzfm
        P74zvfHG9ecVFQwHDc6p8sglrpi2VG5Hyfr50kei0v70TDfwOWw545DSNL4LqRFFPteLDNtK
        Vt6fMtdkIvfri4sUedqV79y19WUoXKfEUpyRaKjFXFScCADqwioWtAIAAA==
X-CMS-MailID: 20190218112210epcas1p1ae2febb02d9a0b8f3fea0320e9609678
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
        <b28e763d-c3c9-0673-6216-f67561112b60@samsung.com>
        <20190215001947.GF117604@google.com>
        <1671c5fa-5414-8a83-b372-99f7f057a2ac@samsung.com>
        <20190215225621.GG117604@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 19. 2. 16. 오전 7:56, Matthias Kaehlcke wrote:
> Hi Chanwoo,
> 
> On Fri, Feb 15, 2019 at 09:33:05AM +0900, Chanwoo Choi wrote:
>> Hi Matthias,
>>
>> On 19. 2. 15. 오전 9:19, Matthias Kaehlcke wrote:
>>> Hi Chanwoo,
>>>
>>> On Fri, Feb 15, 2019 at 08:42:30AM +0900, Chanwoo Choi wrote:
>>>> Hi Matthias,
>>>>
>>>> On 19. 2. 15. 오전 4:28, Matthias Kaehlcke wrote:
>>>>> Hi Chanwoo,
>>>>>
>>>>> On Thu, Feb 14, 2019 at 11:17:36PM +0900, Chanwoo Choi wrote:
>>>>>> Hi Matthias,
>>>>>>
>>>>>> As I commented on the first patch, it is not possible to call some codes
>>>>>> according to the intention of each governor between 'devfreq_moniotr_*()'
>>>>>> and some codes which are executed before or after 'devfreq_moniotr_*()'
>>>>>>
>>>>>> For example, if some governor requires the following sequence,
>>>>>> after this patch, it is not possible.
>>>>>>
>>>>>> case DEVFREQ_GOV_xxx:
>>>>>>         /* execute some code before devfreq_monitor_xxx() */
>>>>>>         devfreq_monitor_xxx()
>>>>>>         /* execute some code after devfreq_monitor_xxx() */
>>>>>
>>>>> As for the suspend/resume case I agree that the patch introduces this
>>>>> limitation, but I'm not convinced that this is an actual problem.
>>>>>
>>>>> For governor_start(): why can't the governor execute the code
>>>>> before polling started, does it make any difference to the governor
>>>>> that a work is scheduled?
>>>>
>>>> The some governors might want to do something before starting
>>>> the work and do something after work started. I think that
>>>> the existing style is more flexible.
>>>
>>> Could you provide a practical example that answers my question above:
>>>
>>> "why can't the governor execute the code before polling started, does
>>> it make any difference to the governor that a work is scheduled?"
>>
>> Actually, as for now, I don't know the correct practice and now.
>> I want to say that the existing style is more flexible for the
>> new governor in the future.
> 
> If you try submitting 'flexible' code in other parts of the kernel
> without users of this flexibility and no solid arguments why this
> flexibility is needed it would most likely be rejected.
> 
> Unnecessary flexibility can be a burden, rather than an advantage.
> 
>> If there are no any special benefits I think we don't need to harm
>> the flexibility.
> 
> There are multiple benefits, the following shortcomings of the current
> approach are eliminated:
> 
> - it is error prone and allows governors to do the wrong thing, e.g.
>   - start monitoring before the governor is fully ready
>   - keep monitoring when the governor is partially 'stopped'
>   - omit mandatory calls
> - delegates tasks to the governors which are responsibility of the
>   core
> - code is harder to read
>   - switch from common code to governor code and back
> - unecessary boilerplate code in governors
> - option to replace ->event_handler() with ->start(), ->stop(), etc,
>   which is cleaner
> 
> I'm easily convinced if the flexibility is really needed. I'm not even
> expecting a real world example, just be creative and make something
> up that sounds reasonable.
> 
> start/resume()
> {
> 	// prepare governor
> 
> 	// start polling
> 
> =>	what needs to be done here that couldn't have been done
> =>	before polling was started?
> }
> 
> stop/suspend()
> {
> =>	what needs to be done here that couldn't be done after polling
> =>	is stopped?
> 
> 	// stop polling
> 
> 	// 'unprepare' governor
> }
> 
>>>> And,
>>>> It has one more problem when changing the governor on the fly
>>>> from simple_ondemand to other governors like performance,
>>>> powersave and so on.
>>>>
>>>> Even if other governors don't need to monitor the utilization,
>>>> the work timer will be executed continually because the devfreq
>>>> device has the polling_ms value. It is not necessary
>>>> of the other governors such as performance, powersave.
>>>>
>>>> It means that only specific governor like simple_ondemand
>>>> have to call the devfreq_monitor_start() by itself
>>>> instead of calling it on devfreq core.
>>>
>>> yes, I noticed that too, it can be easily fixed with a flag in the
>>> governor.
>>
>> Right, If we add some codes like flag, it is easy.
>> Actually, it is just difference how to support them.
>>
>> I think that the existing style has not any problem and is not
>> complicated to develop the new governor. If there are no
>> some benefits, IMO, we better to keep the flexibility.
>> It can give the flexibility to the developer of governor.
> 
> I listed several benefits, please comment on the specific items if you
> disagree, instead of just saying there are no benefits.
> 
> OTOH so far we haven't seen an even hypothetical example that shows
> that the flexibility *could* be needed.
> 
> And even if such a rare case that we currently can't imagine came up,
> it could be easily addressed with notifiers, a standard mechanism in
> the kernel to inform drivers about events they are interested in.

As I said on previous mail, I didn't know the correct practice.

When we develop the something, I think that there are no need
to consider too much flexibility. But, if already developed code
had the more flexibility than the new refactoring code,
I think that keep the existing code if there are no any special benefits.

Also as I said, it is just refactoring without any changes or improvement
of feature. If the existing code have some bug, I will agree them without
any question.

Actually, the monitoring feature are used on only simple_ondemand
governor and tegra-devfreq.c driver. The devfreq core don't need
to consider the start/stop monitoring because each governor/driver
can handle them enough with the existing method.

IMHO, I think that it is just different way how to implement them
because the existing code doesn't have the bug.

I have no any strong objection. But, in my case, it is not easy
to like this. You better to wait the comments from devfreq maintainer.


> 
> Cheers
> 
> Matthias
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
