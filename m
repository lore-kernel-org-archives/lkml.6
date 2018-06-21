Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86DCC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448B021ADE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iVXolsZI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y6La5I0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448B021ADE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933595AbeFUVTP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:19:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57586 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754363AbeFUVTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:19:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7C70460227; Thu, 21 Jun 2018 21:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529615951;
        bh=dnb/cwfQKaunVj9iR0dNQ1Dn8aXNBJGkVLlRrx4Lsso=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iVXolsZInkWXY1l3UkSl/p6zTSy8m1n//E+XdC6fRMHeHA9IkBQzKUMoX6dSPD8dw
         McpBgcdVQkgef0R9BoPDSyko3jZKQUONHV91iKUxN6044UD900nlXANQcSIB/mPVoS
         RfBNHVtygstpG0g7zqdNrbFkRYudNaabd3etcgdk=
Received: from [192.168.1.7] (c-24-9-79-3.hsd1.co.comcast.net [24.9.79.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pprakash@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 48B6B60227;
        Thu, 21 Jun 2018 21:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529615950;
        bh=dnb/cwfQKaunVj9iR0dNQ1Dn8aXNBJGkVLlRrx4Lsso=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Y6La5I0gct9nIsZquMCbdcAoFvKcmb8q0gG2DKwup3UXsEiPTYy0QogAYzqwmi7gf
         RpJOFt/+MDHU/OkQE3KCV8dLw0YJe/144k1zaMJBLKMTGA3cl9entu2b+7lj2jmjAW
         GC5WxNoyeXUsbmCD92Sa390qpsuynErgp8ripsfY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 48B6B60227
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pprakash@codeaurora.org
Subject: Re: [PATCH v2] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
To:     George Cherian <gcherian@caviumnetworks.com>,
        George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net
References: <1529056995-122792-1-git-send-email-george.cherian@cavium.com>
 <67822500-0c9d-ac24-71bc-2717831ab29d@codeaurora.org>
 <44d52166-ed9d-c199-3e19-3df1317ee78c@caviumnetworks.com>
From:   "Prakash, Prashanth" <pprakash@codeaurora.org>
Message-ID: <5ccc0d29-554b-fd5f-84fb-a1ef5bd3d559@codeaurora.org>
Date:   Thu, 21 Jun 2018 15:19:09 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <44d52166-ed9d-c199-3e19-3df1317ee78c@caviumnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

On 6/20/2018 3:17 AM, George Cherian wrote:
> Hi Prakash,
>
> Thanks for the review.
>
> On 06/19/2018 01:51 AM, Prakash, Prashanth wrote:
>> External Email
>>
>> Hi George,
>>
>> On 6/15/2018 4:03 AM, George Cherian wrote:
>>> Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
>>> feedback via set of performance counters. To determine the actual
>>> performance level delivered over time, OSPM may read a set of
>>> performance counters from the Reference Performance Counter Register
>>> and the Delivered Performance Counter Register.
>>>
>>> OSPM calculates the delivered performance over a given time period by
>>> taking a beginning and ending snapshot of both the reference and
>>> delivered performance counters, and calculating:
>>>
>>> delivered_perf = reference_perf X (delta of delivered_perf counter / delta of reference_perf counter).
>>>
>>> Implement the above and hook this to the cpufreq->get method.
>>>
>>> Signed-off-by: George Cherian <george.cherian@cavium.com>
>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>>>   drivers/cpufreq/cppc_cpufreq.c | 71 ++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 71 insertions(+)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index 3464580..3fe7625 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -296,10 +296,81 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>>        return ret;
>>>   }
>>>
>>> +static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
>>> +                                  struct cppc_perf_fb_ctrs fb_ctrs_t0,
>>> +                                  struct cppc_perf_fb_ctrs fb_ctrs_t1)
>>> +{
>>> +     u64 delta_reference, delta_delivered;
>>> +     u64 reference_perf, delivered_perf;
>>> +
>>> +     reference_perf = fb_ctrs_t0.reference_perf;
>>> +     if (fb_ctrs_t1.reference > fb_ctrs_t0.reference) {
>>> +             delta_reference = fb_ctrs_t1.reference - fb_ctrs_t0.reference;
>>> +     } else {
>> There should be another if () here to check if the reference counters are equal.
>> We cannot assume, there was a overflow when the counters are equal. As I
>> mentioned on last patch, the counters *may* pause in idle states.
> My Bad... I somehow, over looked that point. In case of delta_reference being zero there is actually a check below to avoid divide-by-zero. There I returned  reference perf instead of desired perf, same I will take care in v3. Isn't that sufficient or is there a need for an explicit check here for delta = zero?

I am not sure I followed the above. The gist of my comment was when the counters
are equal we cannot assume that there was a overflow. So change the ">" condition
to ">=" and my concern about assuming overflow when equal should be take care of.

The above change would be required for both reference and delivered counters.

