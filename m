Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeEQXQD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 19:16:03 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:11995 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeEQXQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 19:16:00 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180517231558epoutp024e818f93c1b77a68072b174ac7d08cb3~vkaofNVyQ0337203372epoutp02O
X-AuditID: b6c32a46-15dff70000001024-8c-5afe0d2bfe57
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5AFE0D2B.6090201@samsung.com>
Date: Fri, 18 May 2018 08:15:55 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Matthias Kaehlcke <mka@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] PM / devfreq: Remove redundant frequency adjustment
 from governors
In-reply-to: <20180517154705.GN19594@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRmVeSWpSXmKPExsWy7bCmma4O778ogymtXBabPr5ntTi77CCb
        xdmmN+wWl3fNYbP43HuE0eLzhseMFrcbV7A5sHvMbrjI4tG3ZRWjx+dNcgHMUak2GamJKalF
        Cql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUDLlRTKEnNKgUIBicXF
        Svp2NkX5pSWpChn5xSW2StGGhkZ6hgbmekZGQNo41srIFKgkITVj57qtrAUdChXz12o0MHZK
        dTFyckgImEh039vM3sXIxSEksINRYuHsTVDOd0aJN+3H2WCqph9dxA5iCwnsZpQ4uz4QxOYV
        EJT4MfkeSxcjBwezgLzEkUvZIGFmAU2JF18msUDMucsoMeH/UTaIei2JrvsHGEFsFgFViW97
        3jGB2GxA8f0vboDV8AsoSlz98RisRlQgQmLn/G9ge0UENCSe/D7PCDKUWeA5o8Tbps9gDcIC
        kRKr/iwGszkFDCSeTjgK9oGEwB42iS3XmtkhPnCRONazkxnCFpZ4dXwLVFxa4tmqjYwQDe2M
        Eu175zFDOFMYJc5dv8cEUWUs8WxhFxPEc3wSHYf/soP8LCHAK9HRJgRR4iGxYs8yaHA5Smzf
        +JIV4v9zjBL7e3axTWCUm4UUZLMQQTYLKcgWMDKvYhRLLSjOTU8tNiow0itOzC0uzUvXS87P
        3cQITm9abjsYl5zzOcQowMGoxMP7YuLfKCHWxLLiytxDjBIczEoivH6VQCHelMTKqtSi/Pii
        0pzU4kOMpsAQn8gsJZqcD0y9eSXxhqZGxsbGFqbmlsYGlkrivGuUvkYJCaQnlqRmp6YWpBbB
        9DFxcEo1MIq0LKpZbvxykSCrjabjtMUz4szlbF6/cON8xb7u1bucSyVSBfItu460f/mn2LVF
        h51piiDLtbw3D3ie31losFWh33a+qLZ99Nf6d4Vn838KHN/+72XYj1pmlVbDVTyzzb4fP+n8
        37Vx+waHz59nP2F4aMJpfmrGi6Brm3mu1tgvOmWhr+uozanEUpyRaKjFXFScCADHQH2BhQMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsVy+t9jAV1t3n9RBlNatC02fXzPanF22UE2
        i7NNb9gtLu+aw2bxufcIo8XnDY8ZLW43rmBzYPeY3XCRxaNvyypGj8+b5AKYo7hsUlJzMstS
        i/TtErgydq7bylrQoVAxf61GA2OnVBcjJ4eEgInE9KOL2LsYuTiEBHYySnx628MEkuAVEJT4
        MfkeSxcjBwezgLzEkUvZEKa6xJQpuRDl9xklLp9/zQpRriXRdf8AI4jNIqAq8W3PO7AxbEDx
        /S9usIHY/AKKEld/PGYEmSMqECHRfaISJCwioCHx5Pd5RpCZzALPGSWW7J0M1issEClx6+Zq
        ZohlFxglfpx7xQKS4BQwkHg64Sj7BEaBWUhOnYVw6iyEUxcwMq9ilEwtKM5Nzy02KjDKSy3X
        K07MLS7NS9dLzs/dxAgM6W2Htfp3MD5eEn+IUYCDUYmH98XEv1FCrIllxZW5hxglOJiVRHj9
        KoFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEefnzj0UKCaQnlqRmp6YWpBbBZJk4OKUaGF1ClsoU
        /Lg5naVuxeXnevt37Sqadybv/+yrKbU/r3WVdfg5RL6btOz15i08sp+v9N85KL8t62NVX42q
        hLtpR1Jqf+eEuPJp4SVKYYfPHVkwmeFDsek5X6b5E7X2merU2sYHapzT+xn10pv9ccuPB0pB
        LExqSUL1wvt39s1/3j1lkUnO10uFvUosxRmJhlrMRcWJALacg7JlAgAA
X-CMS-MailID: 20180517231555epcas2p29b38e02ce0fc00ee7cd6d18fafd660ac
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180516211119epcas2p4370ceb0c9d959bd1441fa71493a9b0e0
X-RootMTR: 20180516211119epcas2p4370ceb0c9d959bd1441fa71493a9b0e0
References: <CGME20180516211119epcas2p4370ceb0c9d959bd1441fa71493a9b0e0@epcas2p4.samsung.com>
        <20180516211051.78875-1-mka@chromium.org> <5AFCDE68.6000804@samsung.com>
        <20180517154705.GN19594@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 05월 18일 00:47, Matthias Kaehlcke wrote:
> Hi,
> 
> On Thu, May 17, 2018 at 10:44:08AM +0900, Chanwoo Choi wrote:
>> Hi,
>>
>> On 2018년 05월 17일 06:10, Matthias Kaehlcke wrote:
>>> The performance, powersave, simpleondemand and userspace governors
>>> determine a target frequency and then adjust it according to the
>>> df->min/max_freq limits that might have been set by user space. This
>>> adjustment is redundant, it is done in update_devfreq() for any
>>> governor, right after governor->get_target_freq().
>>>
>>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>>> ---
>>>  drivers/devfreq/governor_performance.c    | 10 ++--------
>>>  drivers/devfreq/governor_powersave.c      |  5 -----
>>>  drivers/devfreq/governor_simpleondemand.c |  7 +------
>>>  drivers/devfreq/governor_userspace.c      | 16 ++++------------
>>>  4 files changed, 7 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
>>> index 4d23ecfbd948..31ee30622c00 100644
>>> --- a/drivers/devfreq/governor_performance.c
>>> +++ b/drivers/devfreq/governor_performance.c
>>> @@ -16,14 +16,8 @@
>>>  static int devfreq_performance_func(struct devfreq *df,
>>>  				    unsigned long *freq)
>>>  {
>>> -	/*
>>> -	 * target callback should be able to get floor value as
>>> -	 * said in devfreq.h
>>> -	 */
>>> -	if (!df->max_freq)
>>> -		*freq = UINT_MAX;
>>> -	else
>>> -		*freq = df->max_freq;
>>> +	*freq = UINT_MAX;
>>> +
>>
>> It is difficult to understand why use UINT_MAX instead of df->max_freq.
>>
>> Instead, after merged the commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq
>> when adding the devfreq device"), df->max/min_freq have the specific frequency
>> value always. So, we can change it as following without UINT_MAX. 
>>
>> 	*freq = df->max_freq;
> 
> There are two reasons why I don't like to return df->max_freq:
> 
> 1. update_devfreq() already handles the user limits (which is what
> min/max_freq actually are), no need to spread parts of this
> additionally over all governors.

As I already commented, each function have to keep their own role.
Actually, this function doesn't know the future work in update_devfreq().
Only, devfreq_performance_func have to set the maximum frequency to "*freq".
It is role of performance governor.

> 
> 2. I plan to introduce the concept of a devfreq policy [1], which
> would introduce another pair of frequencies, df->policy.min/max, and
> min/max_freq would become df->policy.user.min/max. The governors would
> then return df->policy.user.min/max, which isn't really incorrect
> since update_devfreq() takes care of adjusting the value with
> df->policy.min/max if needed, but it also isn't very clear. And we
> almost certainly shouldn't additionally handle df->policy.min/max in
> the governors.

I have not seen any patch. Also, it is not proper to discuss on this patch
because this patch doesn't include devfreq policy(?).

> 
> I agree though that just returning UINT_MAX isn't very clear either,
> even though that's what some governors are doing currently when
> df->min/max_freq is not set (which can still occur, since user space
> is free to set the value to 0).
> 
> I think there are two better options than returning df->min/max_freq:
> 
> a) create constants DEVFREQ_MIN/MAX_FREQ and return them, this clearly
> states the intent.
> 
> b) return df->scaling_min/max_freq, which is the min/max frequency
> that is actually available on the device side, depending on the
> enabled OPPs.
> 
> A slightly related question: Is it actually intended to keep
> supporting a value of 0 for df->min/max_freq to keep backwards
> compatibility, or should the related code be removed?
> 
> Thanks
> 
> Matthias
> 
> [1] https://patchwork.kernel.org/patch/10401999/ (first draft, without
> df->policy.min/max)
> 
> 
> 

And when you reply, please remain previous my comments of another point.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
