Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B4BECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5D1214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XVEiKyrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5D1214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeJQV3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:29:55 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12887 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbeJQV3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:29:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc73a4b0000>; Wed, 17 Oct 2018 06:34:04 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 17 Oct 2018 06:34:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 17 Oct 2018 06:34:11 -0700
Received: from [10.26.11.110] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 17 Oct
 2018 13:34:07 +0000
Subject: Re: [PATCH v1 1/5] dt-bindings: cpufreq: Add binding for NVIDIA
 Tegra20/30
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180830194356.14059-1-digetx@gmail.com>
 <20180830194356.14059-2-digetx@gmail.com>
 <f38b38f1-0a60-d6fa-9047-23c619494b23@nvidia.com>
 <1448e619-35c9-0195-c68a-604d10f4dc8b@gmail.com>
 <a9b6e683-3802-896c-27ad-9c49853c231f@nvidia.com>
 <a0dd5d75-6683-f938-c5e5-a95a5c2b86e4@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <3c72f573-d109-b607-b7b7-d70aea3e03df@nvidia.com>
Date:   Wed, 17 Oct 2018 14:34:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a0dd5d75-6683-f938-c5e5-a95a5c2b86e4@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539783244; bh=EugO07srDsUXCHppSJ5HLETkrHxBjlxbVnIMa5dyd3M=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=XVEiKyrNZyOzqfFciRyCFldKHelXQbIPkCxJxU09EHmZbm39OJjVw4s6tQo9frkls
         XZY3PestpRoFpT4HSr6ieuMPheghW4AntIwAGdOSOHzixJILZG2R/ML/XCeaNagyZZ
         n87IWPvwlaGa7xP5M9ORjkYBxeofa0vPAOrY6O9L8MsXDbc5ODSc9GBtNEryauRQS+
         en9J8vGJxWGGqj3FgPVFJR7H4MlO2IP9Hibd/Vcs3+0cc8qMRd5Uaq0AuXlw/P3glg
         8iv+IcQ2vyLHXBCU+HT68EHNVdJJHdzeHPmC6+yghm3resKbg4Uc4P199oAFv1a+9y
         pEH3VbNv7QJMg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/10/2018 14:07, Dmitry Osipenko wrote:
> On 10/17/18 3:59 PM, Jon Hunter wrote:
>>
>> On 17/10/2018 13:37, Dmitry Osipenko wrote:
>>> On 10/17/18 11:40 AM, Jon Hunter wrote:
>>>>
>>>> On 30/08/2018 20:43, Dmitry Osipenko wrote:
>>>>> Add device-tree binding that describes CPU frequency-scaling hardware
>>>>> found on NVIDIA Tegra20/30 SoC's.
>>>>>
>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>> ---
>>>>>  .../cpufreq/nvidia,tegra20-cpufreq.txt        | 38 +++++++++++++++++++
>>>>>  1 file changed, 38 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>>>>> new file mode 100644
>>>>> index 000000000000..2c51f676e958
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>>>>> @@ -0,0 +1,38 @@
>>>>> +Binding for NVIDIA Tegra20 CPUFreq
>>>>> +==================================
>>>>> +
>>>>> +Required properties:
>>>>> +- clocks: Must contain an entry for each entry in clock-names.
>>>>> +  See ../clocks/clock-bindings.txt for details.
>>>>> +- clock-names: Must include the following entries:
>>>>> +  - pll_x: main-parent for CPU clock, must be the first entry
>>>>> +  - backup: intermediate-parent for CPU clock
>>>>> +  - cpu: the CPU clock
>>>>
>>>> Is it likely that 'backup' will be anything other that pll_p? If not why
>>>> not just call it pll_p? Personally, I don't 'backup' to descriptive even
>>>> though I can see what you mean.
>>>>
>>>> I can see that you want to make this flexible, but if the likelihood is
>>>> that we will just use pll_p then I am not sure it is warranted at this
>>>> point.
>>>
>>> That won't describe HW, but software. And device tree should describe HW.
>>
>> Hmm ... well that's my point exactly. So why call it 'backup'? Sounds
>> like a software description to me.
> 
> Because HW is designed the way that CPU parent need to be switched to the backup clock source while main clock changes its rate. HW also allow to select among different parents, pll_p is one of those parents.

Yes that part is understood. I am just splitting hairs over the actual
name. We do the same for tegra124 but we just call it 'pll_p'. See ...

Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt

Cheers
Jon

-- 
nvpublic
