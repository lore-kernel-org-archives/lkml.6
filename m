Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AABECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACF32152D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEdOU/Dq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACF32152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeJQUdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:33:07 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44106 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbeJQUdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:33:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id v6-v6so24144000ljc.11;
        Wed, 17 Oct 2018 05:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W78J92HdHiuSko633HBt9M7aCLB3lYyljdUE5TW5Uw0=;
        b=YEdOU/DqE7XgQ5/NWhUZ8YwYi38Yx50j2G0MHFiOWqfOC/suHo5ce2oeBIDgwHdToe
         8idSJjz5zZGBhD5Mih5DUJVEVrNlqOZB5/o6wkj+Cvgw0iZGG81KfD3pd6Wc1iWbJ1Oz
         NzngEUkhbSXVqvjfknuN/hf8nP4IpM2GaBPa+dxh451LKeV8a93bS8/6PpsaumuKy8Mj
         KvpC3/rCgM0GJasOov/dJYxME/UYRJOSBXhSiPAvvFDD5m+uT0K81hTFfCzFF0QGESFD
         +/GEjKNw8F0XF+79zBJAi16qrkjs7+v24RczjfelpnOI/c8DFcG3eyvt6ayAq8lUCXf6
         lGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W78J92HdHiuSko633HBt9M7aCLB3lYyljdUE5TW5Uw0=;
        b=tEsRG/eHoqeCmppRkOKw7aYBb7ALYAmGC9RwqPYGY/bqbVQ7628wslRECpV0Tm8YWP
         E0UbC95psBkhuYOxT2YwilRWYB+yPT+f3OVRqiSWTti3zYDEIVT835tZyLZnSZuKnZ9e
         3J8rc59lF1mkYW8z5GwlZIOjGRvflzrH6oc0A4qYTuiS2M8LefwM24xoQU/lmrx77ArS
         93J14FZEs5K+hGm41cn0lhZ0dlJ2aeA/0oPUyiJwlH0EQgAyFak6lVfSTIBiHrL1QAD8
         56VL6qb6m9fpcuLubKo0IOA3P6Yj3TjhSqrwqRanhx8rk8hNjbljpHDOBfUqHis2NCy7
         OizQ==
X-Gm-Message-State: ABuFfojR74yaoMxDRgGvCWJxlzZf/JCw8BQYO3WathWL9ZSuBwfc/w10
        FvUUey/TGdzucit5i5/+WTrqD+OC
X-Google-Smtp-Source: ACcGV630n7197ahgegiuhyzxgOn+GnJIVFrI6jupaK16C0GqdBc/IDmt4QXd7hxf84d4GFzfvzAK/w==
X-Received: by 2002:a2e:84c5:: with SMTP id q5-v6mr5452336ljh.65.1539779853619;
        Wed, 17 Oct 2018 05:37:33 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id a17-v6sm3686763lfj.13.2018.10.17.05.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 05:37:32 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1448e619-35c9-0195-c68a-604d10f4dc8b@gmail.com>
Date:   Wed, 17 Oct 2018 15:37:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <f38b38f1-0a60-d6fa-9047-23c619494b23@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 11:40 AM, Jon Hunter wrote:
> 
> On 30/08/2018 20:43, Dmitry Osipenko wrote:
>> Add device-tree binding that describes CPU frequency-scaling hardware
>> found on NVIDIA Tegra20/30 SoC's.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../cpufreq/nvidia,tegra20-cpufreq.txt        | 38 +++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>>
>> diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>> new file mode 100644
>> index 000000000000..2c51f676e958
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>> @@ -0,0 +1,38 @@
>> +Binding for NVIDIA Tegra20 CPUFreq
>> +==================================
>> +
>> +Required properties:
>> +- clocks: Must contain an entry for each entry in clock-names.
>> +  See ../clocks/clock-bindings.txt for details.
>> +- clock-names: Must include the following entries:
>> +  - pll_x: main-parent for CPU clock, must be the first entry
>> +  - backup: intermediate-parent for CPU clock
>> +  - cpu: the CPU clock
> 
> Is it likely that 'backup' will be anything other that pll_p? If not why
> not just call it pll_p? Personally, I don't 'backup' to descriptive even
> though I can see what you mean.
> 
> I can see that you want to make this flexible, but if the likelihood is
> that we will just use pll_p then I am not sure it is warranted at this
> point.

That won't describe HW, but software. And device tree should describe HW.
