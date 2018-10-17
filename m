Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AD0ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B6021526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hihdJYU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B6021526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeJQUie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:38:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43275 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeJQUie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:38:34 -0400
Received: by mail-lf1-f68.google.com with SMTP id p34-v6so19667252lfg.10;
        Wed, 17 Oct 2018 05:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YkFoC91zr0+ulBt6JxldTG6odQkPd8wVV6VzYJKB/yg=;
        b=hihdJYU68OFMrVA6rDAIDxs+GG3raFgIURR1aPMqx3F6X6I/KIltecpjJZ1BTwNiWd
         dID9rtyHVZsye8/s6gBQ2jQbMPxnH3s4Tgy+iOLYo91OZMlfns/d6eGwxBkKMnQ/6Dkz
         PF/kUj2LQsiz6t0W5WIFqpOzrRVDM+XGQTXQVt5mHxp8akm2s1x8IvxHbr7G56VqSPH7
         U/I5GugorusxUEszZKrd274zG8o0uEM3xth2JCz/Sh4NR57PDqdMiqg6HxC9/LcoshOP
         q3Jdx+lwVsJbwDy1YbjEXYd2J0qnR0o7rFaQdOTR7NlWxXfiEo1U9iqQ5jWIgPbBOGmI
         ZPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YkFoC91zr0+ulBt6JxldTG6odQkPd8wVV6VzYJKB/yg=;
        b=UReneaurR4BLyaoP9Cq22SUkqqMDqXHSegaK/SoP39IrdcyUmoyQJQzcwAvV7DqyUD
         3ZgqqjAGvkJ+vBgMMFrCIWOQ7dEE0YSbUKliX4uDxVnT46byoqZYvuOjsH5lWkxvYC8X
         rb/VlnzmvehdhVIR18m7UX9eXEiuzR/N6oBdCEtcPk9PJeOnwBrzLqCrZTc1ekLp3hvG
         8soq6LuP4cIO6Nxj4NIx8WH7vpCiYHHfRwncMCg2wvcYkFIlRBarO0ULyxSL2e/84Nlm
         g5rgSd4TRc1qEvsGlUq1AylnVqlVqU5BZVCQMWApxRnppsMinjqAv8SJpBFju6/bq7o/
         tZ5A==
X-Gm-Message-State: ABuFfoh45M0c/lrp/6eMSzu4jBRFxAdrbZQy18aUOQMQ1saLvPKyNhUb
        OyzdkMLkUjJgVyWiN8HHFZi1dNxZ
X-Google-Smtp-Source: ACcGV61Ab1/v8lS3O6UoxyWaTajbFVWdLNj/JiKYL2FGg04YQDFt6BdAFNcWuE31llgcdF0GOrM83g==
X-Received: by 2002:a19:59d3:: with SMTP id n202-v6mr15550928lfb.125.1539780179087;
        Wed, 17 Oct 2018 05:42:59 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id y3-v6sm4051874ljy.95.2018.10.17.05.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 05:42:58 -0700 (PDT)
Subject: Re: [PATCH v1 1/5] dt-bindings: cpufreq: Add binding for NVIDIA
 Tegra20/30
From:   Dmitry Osipenko <digetx@gmail.com>
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
Message-ID: <4b0966fa-c3f1-b7c9-e4bd-24337b8e97fe@gmail.com>
Date:   Wed, 17 Oct 2018 15:42:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1448e619-35c9-0195-c68a-604d10f4dc8b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 3:37 PM, Dmitry Osipenko wrote:
> On 10/17/18 11:40 AM, Jon Hunter wrote:
>>
>> On 30/08/2018 20:43, Dmitry Osipenko wrote:
>>> Add device-tree binding that describes CPU frequency-scaling hardware
>>> found on NVIDIA Tegra20/30 SoC's.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  .../cpufreq/nvidia,tegra20-cpufreq.txt        | 38 +++++++++++++++++++
>>>  1 file changed, 38 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>>> new file mode 100644
>>> index 000000000000..2c51f676e958
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>>> @@ -0,0 +1,38 @@
>>> +Binding for NVIDIA Tegra20 CPUFreq
>>> +==================================
>>> +
>>> +Required properties:
>>> +- clocks: Must contain an entry for each entry in clock-names.
>>> +  See ../clocks/clock-bindings.txt for details.
>>> +- clock-names: Must include the following entries:
>>> +  - pll_x: main-parent for CPU clock, must be the first entry
>>> +  - backup: intermediate-parent for CPU clock
>>> +  - cpu: the CPU clock
>>
>> Is it likely that 'backup' will be anything other that pll_p? If not why
>> not just call it pll_p? Personally, I don't 'backup' to descriptive even
>> though I can see what you mean.
>>
>> I can see that you want to make this flexible, but if the likelihood is
>> that we will just use pll_p then I am not sure it is warranted at this
>> point.
> 
> That won't describe HW, but software. And device tree should describe HW.
> 

Though indeed it is unlikely that anything else other than pll_p will be used, so it is a software/firmware description anyway.
