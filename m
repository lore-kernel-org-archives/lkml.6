Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22538ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D085321477
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L724xqaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D085321477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeJREyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:54:35 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37968 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbeJREyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:54:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id x24-v6so5157527lfe.5;
        Wed, 17 Oct 2018 13:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aZwFUgwyntR1+nPUoCmSdDUaoWeKRSjG0tMNvx+KqFU=;
        b=L724xqajLLt/ANU8bTWielB7Xd6lyRZDaU8cyKozR5vu3m7CxoRlCv8M3DF28tAzse
         oHS6aReJZzCHF0NkYxwdu5kD61nDkW5FzuUwerAudZJA7ae1i+1cvm6GYIHtAkm4giiw
         Z14XInaGlnUMb2rx3Dr+ePoikocW73eYJr72GbMdICYkdxNuIZ1zU6M5G2pfokWmNKVt
         z81Zq0tbmVnfgS7IwojS/wHSIK/6fiAg7Rlxwm5GHlt35JpEhVp6GMw20TbstTy12aqd
         IHvn4ua/HFavUu8W8k5s/mr62SDm6E0dENekEi81J6k78p2bLwHyLxQdX4XsHqC3S4sr
         0yNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aZwFUgwyntR1+nPUoCmSdDUaoWeKRSjG0tMNvx+KqFU=;
        b=arhkR3qOQNlLv8oQ5Bk2jcIrhwBs1bBsaa3aBcWOboiS7ITxePQTt9DssQF7xbnRjT
         pySA/7mF5t4wb4J9ouAE9bt8IX00R+lfToJvQHp4Ihi+iZmk/3txHLXJMv3Zwc4ClxdL
         mZksJF0gMwqwewOOiV2f6Nrbupwa1QiBq6O0YV6cK7WtCkeuwlEehbyMx9bAOTNSkNXX
         gB0u7e5x++NHItttzn8SgrdzIdG2ao1w76ASWgm1/4WkapvIVDMCmHp0y2mqkDTEb+bw
         WaZR7qYW1mii8Ku4wCfWCwTAdAIMGqZmtIq65NcKLKKaf9sillXKVaWZfYd0HXag0SCe
         y1vg==
X-Gm-Message-State: ABuFfogVsBxsoezFMujJ0G4o+odL9WyoQSB1WmkTIuLoqASxleWtz2uf
        cYcnZlVr2JNq3agOpzJvX2jV73LM
X-Google-Smtp-Source: ACcGV61PnWUeH+CGY/41pB0fwRzYefA4jY/9OSs89I58QiSDJWzftYbrytqqlq/f/LAPijX9EqkP0A==
X-Received: by 2002:a19:4f17:: with SMTP id d23-v6mr16030822lfb.121.1539809824259;
        Wed, 17 Oct 2018 13:57:04 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id o185-v6sm410145lfo.40.2018.10.17.13.57.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 13:57:03 -0700 (PDT)
Subject: Re: [PATCH v1 1/5] dt-bindings: cpufreq: Add binding for NVIDIA
 Tegra20/30
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180830194356.14059-1-digetx@gmail.com>
 <20180830194356.14059-2-digetx@gmail.com>
 <f38b38f1-0a60-d6fa-9047-23c619494b23@nvidia.com>
 <1448e619-35c9-0195-c68a-604d10f4dc8b@gmail.com>
 <a9b6e683-3802-896c-27ad-9c49853c231f@nvidia.com>
 <a0dd5d75-6683-f938-c5e5-a95a5c2b86e4@gmail.com>
 <3c72f573-d109-b607-b7b7-d70aea3e03df@nvidia.com>
 <c6249de9-bcaa-ab3e-8546-40f8c2c17599@gmail.com>
 <4db9c51c-0c1d-c9a2-b781-250c053e6e24@nvidia.com>
 <e4f63df9-d92a-4e57-05ba-c999bdda9cc0@gmail.com>
 <821c13a9-ff9c-c9bd-83f6-7566f7bb4477@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0b88ce49-dfe4-63c3-dcf8-67dbb98c8be6@gmail.com>
Date:   Wed, 17 Oct 2018 23:57:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <821c13a9-ff9c-c9bd-83f6-7566f7bb4477@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 10:29 PM, Jon Hunter wrote:
> 
> On 17/10/2018 15:43, Dmitry Osipenko wrote:
>> On 10/17/18 5:14 PM, Jon Hunter wrote:
>>>
>>> On 17/10/2018 14:46, Dmitry Osipenko wrote:
>>>> On 10/17/18 4:34 PM, Jon Hunter wrote:
>>>>>
>>>>> On 17/10/2018 14:07, Dmitry Osipenko wrote:
>>>>>> On 10/17/18 3:59 PM, Jon Hunter wrote:
>>>>>>>
>>>>>>> On 17/10/2018 13:37, Dmitry Osipenko wrote:
>>>>>>>> On 10/17/18 11:40 AM, Jon Hunter wrote:
>>>>>>>>>
>>>>>>>>> On 30/08/2018 20:43, Dmitry Osipenko wrote:
>>>>>>>>>> Add device-tree binding that describes CPU frequency-scaling hardware
>>>>>>>>>> found on NVIDIA Tegra20/30 SoC's.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>>>>>> ---
>>>>>>>>>>  .../cpufreq/nvidia,tegra20-cpufreq.txt        | 38 +++++++++++++++++++
>>>>>>>>>>  1 file changed, 38 insertions(+)
>>>>>>>>>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>>>>>>>>>>
>>>>>>>>>> diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>>>>>>>>>> new file mode 100644
>>>>>>>>>> index 000000000000..2c51f676e958
>>>>>>>>>> --- /dev/null
>>>>>>>>>> +++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>>>>>>>>>> @@ -0,0 +1,38 @@
>>>>>>>>>> +Binding for NVIDIA Tegra20 CPUFreq
>>>>>>>>>> +==================================
>>>>>>>>>> +
>>>>>>>>>> +Required properties:
>>>>>>>>>> +- clocks: Must contain an entry for each entry in clock-names.
>>>>>>>>>> +  See ../clocks/clock-bindings.txt for details.
>>>>>>>>>> +- clock-names: Must include the following entries:
>>>>>>>>>> +  - pll_x: main-parent for CPU clock, must be the first entry
>>>>>>>>>> +  - backup: intermediate-parent for CPU clock
>>>>>>>>>> +  - cpu: the CPU clock
>>>>>>>>>
>>>>>>>>> Is it likely that 'backup' will be anything other that pll_p? If not why
>>>>>>>>> not just call it pll_p? Personally, I don't 'backup' to descriptive even
>>>>>>>>> though I can see what you mean.
>>>>>>>>>
>>>>>>>>> I can see that you want to make this flexible, but if the likelihood is
>>>>>>>>> that we will just use pll_p then I am not sure it is warranted at this
>>>>>>>>> point.
>>>>>>>>
>>>>>>>> That won't describe HW, but software. And device tree should describe HW.
>>>>>>>
>>>>>>> Hmm ... well that's my point exactly. So why call it 'backup'? Sounds
>>>>>>> like a software description to me.
>>>>>>
>>>>>> Because HW is designed the way that CPU parent need to be switched to the backup clock source while main clock changes its rate. HW also allow to select among different parents, pll_p is one of those parents.
>>>>>
>>>>> Yes that part is understood. I am just splitting hairs over the actual
>>>>> name. We do the same for tegra124 but we just call it 'pll_p'. See ...
>>>>>
>>>>> Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt
>>>>
>>>> tegra124-cpufreq choose to hardwire to the pll_p, but it could be other clocks. Technically abstracting backup clock should be more correct, but result is the same in the end.
>>>
>>> Yes and that is probably intentional as that is the configuration that
>>> has been validated. So unless we are planning to test and verify every
>>> possibility, my preference is to keep it simple. But yes the result is
>>> the same.
>>>
>>> I was simply curious of your intention here because of the other series
>>> you posted with regard to the cpu clocks.
>>
>> Actually I tried other parents on T30 and they worked with no problems. The intention of having 'backup' is to describe HW properly in the device tree, that's it. We'll have backup set to pll_p by default. ACK?
> 
> Yes but I don't find the name 'backup' very descriptive because like you
> say it is an intermediate clock for switching frequency. But at the same
> time I don't have a good suggestion. Anyway it is more of a
> bike-shedding comment.

I'll consider renaming 'backup' to 'intermediate' in the v2 which I'll probably manage to send out tomorrow as RFC (CPUFreq now depends on yet-not-reviewed coupled-regulators patches).
