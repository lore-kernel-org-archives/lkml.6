Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9FBECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A756E2152C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPjsJxC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A756E2152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeJQVC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:02:58 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47095 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeJQVC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:02:58 -0400
Received: by mail-lf1-f68.google.com with SMTP id p143-v6so8704817lfp.13;
        Wed, 17 Oct 2018 06:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gXKUe5+NOIqph7dJXdSP0B+RfpuTb+GEiwcjOTnggpk=;
        b=IPjsJxC7uKzVMTGYAHLRleYrPOiaytxqHmaCuR71dWzW3+Uhfw8/L/3lF2Tm7PgZae
         Rq3CAhPjy5vI2wjC+dzkXiyOaY20g1DUfIoGnhDcHDT3s67xs0ZIpQDVf8TLYXWavPm5
         UF5iUfIFrERtKbNTBkZm3Suj+PXMRWlg2fqDZBUyqWc8rXT0FeB6QyKgLL76AyVNOU+b
         pD+m3RHQWgoOMQ30FoD7ojUaek2ZpECZtJHqdP3Lc61+VJ0bEObkpDl7IvwxhkeNSAhg
         kn2ETWQLUMozuIHCB7jv4Pv2OnbB4pa4n0ijZQzcfrYdwmT7wSb3OnCRF5rME3+rLl4u
         UW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gXKUe5+NOIqph7dJXdSP0B+RfpuTb+GEiwcjOTnggpk=;
        b=V+Bdzi6tXaz2Po8cweuL27wVf+kTJhMSaikaPGTOXSQEgypVgdUqv3QGMSTASElvOV
         lT0etiTIWQvrC3AJGWWsN2l7ZCw3zoS9OSr/RZ7Vci79IpYb/wcneOHGITgCNib2jZHD
         VpRUXCGksQMCiwNVKdqoolXZvLrAn+/hQ1EOXD+TNJ89pRCG+nq9FrWJmrHSZczw9fhM
         OA29NhMbr5AbDKcbyxUNLhEzmn0EKdPGJ9wU0E3nh4eQiXcbfPDRoOLuGu7R53SMU3ZX
         SW0Lj8Kv0onkIrCny5pqdHa8PP5TapVMtYcwyM7YQgvOzF5H1yKSG1jw2Swmx1LSX1Vg
         ZiFg==
X-Gm-Message-State: ABuFfog//BmLwBw2SfpLEvWwx6TT1QzxF2s5T2ilBApO7InprWtmCMJg
        1cOyZajfJh0KRMaoAiBcaEjpjO0X
X-Google-Smtp-Source: ACcGV63VoPxXeZShF2542sd/4u4olx2GkrQPlOFitoLyp7plYkvfnzVJMCVxCIEyX02nCFrjevth1w==
X-Received: by 2002:a19:9585:: with SMTP id x127-v6mr15797115lfd.112.1539781638443;
        Wed, 17 Oct 2018 06:07:18 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id 12-v6sm4016263lje.67.2018.10.17.06.07.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 06:07:17 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a0dd5d75-6683-f938-c5e5-a95a5c2b86e4@gmail.com>
Date:   Wed, 17 Oct 2018 16:07:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <a9b6e683-3802-896c-27ad-9c49853c231f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 3:59 PM, Jon Hunter wrote:
> 
> On 17/10/2018 13:37, Dmitry Osipenko wrote:
>> On 10/17/18 11:40 AM, Jon Hunter wrote:
>>>
>>> On 30/08/2018 20:43, Dmitry Osipenko wrote:
>>>> Add device-tree binding that describes CPU frequency-scaling hardware
>>>> found on NVIDIA Tegra20/30 SoC's.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  .../cpufreq/nvidia,tegra20-cpufreq.txt        | 38 +++++++++++++++++++
>>>>  1 file changed, 38 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>>>> new file mode 100644
>>>> index 000000000000..2c51f676e958
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>>>> @@ -0,0 +1,38 @@
>>>> +Binding for NVIDIA Tegra20 CPUFreq
>>>> +==================================
>>>> +
>>>> +Required properties:
>>>> +- clocks: Must contain an entry for each entry in clock-names.
>>>> +  See ../clocks/clock-bindings.txt for details.
>>>> +- clock-names: Must include the following entries:
>>>> +  - pll_x: main-parent for CPU clock, must be the first entry
>>>> +  - backup: intermediate-parent for CPU clock
>>>> +  - cpu: the CPU clock
>>>
>>> Is it likely that 'backup' will be anything other that pll_p? If not why
>>> not just call it pll_p? Personally, I don't 'backup' to descriptive even
>>> though I can see what you mean.
>>>
>>> I can see that you want to make this flexible, but if the likelihood is
>>> that we will just use pll_p then I am not sure it is warranted at this
>>> point.
>>
>> That won't describe HW, but software. And device tree should describe HW.
> 
> Hmm ... well that's my point exactly. So why call it 'backup'? Sounds
> like a software description to me.

Because HW is designed the way that CPU parent need to be switched to the backup clock source while main clock changes its rate. HW also allow to select among different parents, pll_p is one of those parents.

I think cpufreq-mediatek has a similar description, see Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
