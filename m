Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38D9C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F09214C1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTiAfD3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F09214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbeIYXiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:38:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46159 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeIYXiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:38:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so22523534ljj.13;
        Tue, 25 Sep 2018 10:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hi8rboMsFW4X2aKavM9k6laW/LPgjUmhL8jmgpoVVi0=;
        b=hTiAfD3vyVv/8OaB69EruPD48LcmHADDYYi4r/8Z8Sp9ODSjNpwjomolsq0c54i/da
         hvcxH3+wuWLlmBCje1pInCOMiaHd/GN3y/QGMl/udtfzY+fcKnzS0C014N8iskBAWFJL
         9mJv9eDGZw5wmjgedxo378/1tg6WYXVFkcGJ51odUf04hNLyMh81aPMPjQS/iBn+Woaa
         kv9WIlDRCRoRYOetrjTz+c+SU7FcP1YIjByGGtgc96KW2nm7UcHZwuZvE7iOy/8MXKUQ
         HUbNWdc++iGemEfylexo1Ncv7tsqOOR73gS+I9E1Dz7CyJ/mZScEHf0pvpNBa7Z2/dJS
         CcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hi8rboMsFW4X2aKavM9k6laW/LPgjUmhL8jmgpoVVi0=;
        b=MYdnikTdKE77btQLWkWcWWn4HUdRRUlnwEotVYwbw1CiEFiEpmnE9NDWN6X5OyPQoG
         n8i+/cVRqwzmYoIWvDfHKBlvEYqJVV8x4FnUPrQ2zuNLk5sfFT06pPoaBpHO4cCWCKpI
         xeD+Vcn0FE5lk2oKaL7D7AHkGY2p0GrM+7/E4uixX3u6COwfEOVIzFSN/aop3XCj/kra
         LHkIu0dqbckwneNN0xhuWfRU5SNZnZd+iMxs691jQw52E7oScWhupu7Th0/ZGKH5KMEd
         VD2RNSE4d0awoElVcNDgIHAejNppPw4dmlFOFWcpVb/swFJ8Ll8DudIqC75n5b/SVJxX
         J5Cw==
X-Gm-Message-State: ABuFfogLM4kOtHG3BFDP9d2TkN9PAOojaBbwhrl/eB0CnZ5cFHbs6BFF
        wksqobK1O11wSrWObAVIK8l4BryK
X-Google-Smtp-Source: ACcGV62eRraj7oUz5GHRx/az0CHy2Eabcvom3M7dq+MasRXKlQaalbpRvxONgLxpacVxyp6/54eWGw==
X-Received: by 2002:a2e:9a93:: with SMTP id p19-v6mr1625163lji.87.1537896571964;
        Tue, 25 Sep 2018 10:29:31 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.googlemail.com with ESMTPSA id x1-v6sm517639ljj.56.2018.09.25.10.29.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 10:29:31 -0700 (PDT)
Subject: Re: [PATCH v1 1/5] dt-bindings: cpufreq: Add binding for NVIDIA
 Tegra20/30
To:     Rob Herring <robh@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180830194356.14059-1-digetx@gmail.com>
 <20180830194356.14059-2-digetx@gmail.com> <20180925165810.GA32430@bogus>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <074a169d-294b-ad4b-ddbd-6db742278f2a@gmail.com>
Date:   Tue, 25 Sep 2018 20:29:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180925165810.GA32430@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/18 7:58 PM, Rob Herring wrote:
> On Thu, Aug 30, 2018 at 10:43:52PM +0300, Dmitry Osipenko wrote:
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
> The Cortex A9 has CLK, PERIPHCLK, and PERIPHCLKEN clocks and only CLK 
> is used for the cpu core. You can't just define your own clocks that 
> you happen to want access to.
> 
> Otherwise, you're not defining anything new here, so a binding document 
> isn't required.

PERIPHCLK is a different thing. Here we are defining the CPU clock and
its *parent* sources, the PLLX (main) and backup (intermediate clock
that is used while PLLX changes its rate). These are not some random
clocks "that you happen to want access to", they are essential for the
Tegra CPUFreq driver, CPU is running off them.

I assume that PERIPHCLK and other clocks are derived from the "CPU"
clock and their configuration is hardwired. Probably Peter knows how
it's implemented in HW.

I'm now working on v2 that will include more Tegra-specific stuff in the
binding, like custom "opp-supported-hw" property and probably some more.
