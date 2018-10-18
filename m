Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BADC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABE3208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TvXRJKbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABE3208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeJRQMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:12:30 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45356 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeJRQMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:12:30 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181018081239euoutp023238cb62a519976f4f7ed14b352a54eb~epb5W0S7U0688706887euoutp02P
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 08:12:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181018081239euoutp023238cb62a519976f4f7ed14b352a54eb~epb5W0S7U0688706887euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539850359;
        bh=c6C6h5a+JUjlckMI5xgYQjKlgLQlLPtyXbf7HPWhgDM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TvXRJKbMXVhzsss4e/cou9eF9DJOp9c1KabKBq1SqefSj0tVv1rFwbhMLXVyT+Xvr
         4VdbKqlR2sb/33ds3Y2ikzw6MAxy+/u/VUWBK//PuE1lziFxvQJFT/dyQWFmXApRTB
         F1H0nQ+7Y+0DL515yY1LTmQShsHb4sFwh2nsD/wA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181018081238eucas1p1aa1019e68dd0744e1a14df6ee0e09d5f~epb4DWTOu2170621706eucas1p1I;
        Thu, 18 Oct 2018 08:12:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 49.A2.04441.57048CB5; Thu, 18
        Oct 2018 09:12:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181018081237eucas1p1380ba533db3f718b6ada8289e83f0f10~epb3RbYC73110831108eucas1p1j;
        Thu, 18 Oct 2018 08:12:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181018081237eusmtrp180501b7cca49eb32f17036a4e0edc9ed~epb3Aztv11288912889eusmtrp1a;
        Thu, 18 Oct 2018 08:12:37 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-63-5bc84075fe24
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CA.A2.04128.47048CB5; Thu, 18
        Oct 2018 09:12:36 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181018081236eusmtip1d96001ee542d5337c71797789e1b1220~epb2Yh1kX1409014090eusmtip1m;
        Thu, 18 Oct 2018 08:12:36 +0000 (GMT)
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        b.zolnierkie@samsung.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Date:   Thu, 18 Oct 2018 10:12:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBZam-+3sbKa+XffhoxkPX_ndTLoxioVwU-iz0qTnnPAw@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGczvT6VCtuS0IJ7jFRhJFZYmiNxFFIzFjjNuLMWAiI4yIAtYO
        4PqA0QAiEJegtJbFGAGbRqQ2gIrKpgURRBFUlFgMJLggSLVRH1DbKZG375zz/2e5uSylGZcH
        skmpaYI+lU/WMkq65vGvZ0vT17bGhjnKwsjvrwYFqS6qkpMS5xxS+rJXTk5dq2JIYWO+jEyY
        ixnSfdfEEGd+CyIvGspkxJ7fICND1iqaFH8vpMjgQAFDugoNFMlpcVGk+ge3Vs1ZSiyIu2Ps
        V3C3K4O5a/UfZZzVfIbh3vXWM9zDYouCG33Qw3AFNjPinNa525QxysgEITkpQ9CHrolT7svK
        rUS6N/5Hmhr7UCbK1eQiHxbwcrB+MChykZLV4EoET9s7aSn4jqDh/g2ZFDgRdEx8kk9aBtqe
        ei0VCB4Nt3otIwgaO7ORW+WLV8KT/iIP++Ew+PVtnHKLKFwmh/q86n99WZbBIVBnPuTW0DgI
        TM1/PBNm4p3Q4rjq8aqwGtoMg7SbffB2uHm5h3EzhQOgb7BUJvE8qB0xefoDvsrC6exuhWTO
        gFtFRbS0djScf+RgJPaFT3abQuLZ0H4xz6sRoSPH7NWcgOy2Oq9mFTTbn8vdO1N4EVTdDZXS
        6+Cz4YonDXgGvB5RS+vMgAs1lykprYKcLO9TLwRbXpdMYn+osFxSnENa45QjjVMOM045zPh/
        bhmizShASBdTEgUxPFU4HCLyKWJ6amJI/MEUK/r3E9sn7ON16MeLPU0Is0g7XeUQ7LEaOZ8h
        Hk1pQsBSWj/V8RWtsRpVAn/0mKA/uFufniyITWgWS2sDVOUl1bEanMinCQcEQSfoJ6sy1icw
        E9UuSFsStXrkZFR/uWnn4uj3rk0dMVnzNmwkhA8dvVMRV/BWzfP5P38HjXVfd83tebU+vn6v
        +vQJTfiy5sX8UIRpf7mrZMcS+p7O12XE29ixTZY03bCN+xK4g3x+HK9rD4jcHGFOXAhJDYEf
        d0WfdTg6g5wx67dsnfbNOd82v7VDS4v7+PBgSi/yfwFlUKLphQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42I5/e/4Xd0ShxPRBuvfWlv8ejeT3WLjjPWs
        FvM+y1rMv3KN1aJ58Xo2i6kHe5ks/q2ay2ZxedccNovPvUcYLS4dWMBkcbz3AJPF003rWSzm
        fpnKbPHkYR+bxYWpM5ktOo58Y7bY+NXDQdBjzbw1jB47Z91l99i8Qstj8Z6XTB6bVnWyedy5
        tofNY//cNewe7/ddZfPo27KK0ePzJrkArig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1D
        Y/NYKyNTJX07m5TUnMyy1CJ9uwS9jLauFYwFN8UqDh28xdjA2CXUxcjJISFgIvHw5Bn2LkYu
        DiGBpYwS18/9ZYNIiElM2redHcIWlvhzrYsNoug1o8TE6U2MIAlhAXOJU3dngNkiAgYSPz9+
        YgYpYhZYwipxZtcqsElCAneZJU7dY+pi5OBgE9CT2LGqECTMK+AmsWbtF7AFLAKqEnMO/2cF
        sUUFIiRWL3/BClEjKHFy5hMWEJtTIFBi3fSrYCOZBcwk5m1+yAxhi0vcejKfCcKWl9j+dg7z
        BEahWUjaZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECk8C2Yz+37GDs
        ehd8iFGAg1GJh/dB6vFoIdbEsuLK3EOMEhzMSiK81WYnooV4UxIrq1KL8uOLSnNSiw8xmgI9
        N5FZSjQ5H5ig8kriDU0NzS0sDc2NzY3NLJTEec8bVEYJCaQnlqRmp6YWpBbB9DFxcEo1MO7o
        WqRT+8Po1cTGe1vWCLPWZfKnJEedX+r2oi1HOOUqdz1/x/WVK864Jx2f4eMRYOjI7jUzq+dC
        iVMe76wVYYsNOfRz231Lo5Uq6ldcOfzHVEXqt+FSZoupU9i+iusJlJj+lYzescS3iqf/mfb2
        1HrxxRfY05c8d/VxlDi2dsbL8zc7dLT5lFiKMxINtZiLihMBfeW3vRgDAAA=
Message-Id: <20181018081237eucas1p1380ba533db3f718b6ada8289e83f0f10~epb3RbYC73110831108eucas1p1j@eucas1p1.samsung.com>
X-CMS-MailID: 20181018081237eucas1p1380ba533db3f718b6ada8289e83f0f10
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336
References: <CGME20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336@epcas1p4.samsung.com>
        <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
        <20181010153553eucas1p1b8f74f4aa45751ef029805fd118affc1~cSUmU58-F2963929639eucas1p1L@eucas1p1.samsung.com>
        <5BBE3751.7000908@linaro.org>
        <20181011111025eucas1p2125db99d798a60a8e38da97c2a1c7436~ciWHHd0YW0102601026eucas1p2b@eucas1p2.samsung.com>
        <CAKfTPtBZam-+3sbKa+XffhoxkPX_ndTLoxioVwU-iz0qTnnPAw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 10/16/2018 07:11 PM, Vincent Guittot wrote:
> Hi Lukasz,
> 
> On Thu, 11 Oct 2018 at 13:10, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>>
>>
>> On 10/10/2018 07:30 PM, Thara Gopinath wrote:
>>> Hello Lukasz,
>>>
>>> On 10/10/2018 11:35 AM, Lukasz Luba wrote:
>>>> Hi Thara,
>>>>
>>>> I have run it on Exynos5433 mainline.
>>>> When it is enabled with step_wise thermal governor,
>>>> some of my tests are showing ~30-50% regression (i.e. hackbench),
>>>> dhrystone ~10%.
>>>
>>> That is interesting. If I understand correctly, dhrystone spawns 16
>>> threads or so and floods the system. In "theory", such a test should not
>>> see any performance improvement and degradation. What is the thermal
>>> activity like in your system? I will try running one of these tests on
>>> hikey960.
>> I use this dhrystone implementation:
>> https://github.com/Keith-S-Thompson/dhrystone/blob/master/v2.2/dry.c
>> It does not span new threads/processes and I pinned it to a single cpu.
>>
>> My thermal setup is probably different than yours.
>> You have (on hikey960) probably 1 sensor for whole SoC and one thermal
>> zone (if it is this mainline file:
>> arch/arm64/boot/dts/hisilicon/hi3660.dtsi).
>> This thermal zone has two cooling devices - two clusters with dvfs.
>> Your temperature signal read out from that sensor is probably much
>> smoother. When you have sensor inside cluster, the rising factor
>> can be even 20deg/s (for big cores).
>> In my case, there are 4 thermal zones, each cluster has it's private
>> sensor and thermal zone. There is no 'SoC sensor' or 'PCB sensor',
>> which is recommended for IPA.
>>>>
>>>> Could you tell me which thermal governor was used in your case?
>>>> Please also share the name of that benchmark, i will give it a try.
>>>> Is it single threaded compute-intensive?
>>>
>>> Step-wise governor.
>>> I use aobench which is part of phoronix-test-suite.
>>>
>>> Regards
>>> Thara
>>>
>> I have built this aobench and run it pinned to single big cpu:
>> time taskset -c 4 ./aobench
> 
> Why have you pinned the test only on CPU4 ?
> Goal of thermal pressure is to inform the scheduler of reduced compute
> capacity and help the scheduler to take better decision in tasks
> placement.
> So I would not expect perf impact on your test as the bench will stay
> pinned on the cpu4
> That being said you obviously have perf impact as shown below in your results
> And other tasks on the system are not pinned and might come and
> disturb your bench
Unpinned runs on this platform have a lot of variation. The tests take
even 16min to finish.

Regards,
Lukasz
> 
>> The results:
>> 3min-5:30min [mainline]
>> 5:15min-5:50min [+patchset]
>>
>> The idea is definitely worth to investigate further.
> 
> Yes I agree
> 
> Vincent
>>
>> Regards,
>> Lukasz
>>
>>
>>
> 
> 
