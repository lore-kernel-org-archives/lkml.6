Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F6BC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A22B20842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f20Wwbjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A22B20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbeIZEHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 00:07:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44006 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725732AbeIZEHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 00:07:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id m84-v6so23191547lje.10;
        Tue, 25 Sep 2018 14:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zqzwUdXpqSlExtslIYE46de93AAScJzatAnRWsqBz3c=;
        b=f20Wwbjr5O2MnPE6KUtYuYScH4VqfEdeTW69TMgoXu3onxdItE35nqyR3Pm4oaJTFt
         ZzhxAOv4agBvZTgOk6ZjUBUKK13Fsyzhh0p7igz4gF/5ii2Xj5wePlPbpx+qe+fT79g2
         WvM9UI0ofLIS3SM0JUZmlRdsfVHo2Q59FUBfSQImBVYIH1HD9aZJLuJlEWOcjh4JqZu1
         Fg8byn+I4pCvkfEIw8BNDNolrL53b94ROwyQ8a8M4OqXAXetgIwkNbaHX20Z1rivycxD
         LL25jsbfC3FwlZSPL9Zyzr2d8XU5uk2pT9uF2HnfrEEmLSAHnfiwdOjkj/l9MA+5um2S
         T3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zqzwUdXpqSlExtslIYE46de93AAScJzatAnRWsqBz3c=;
        b=bm6qUBIOrgsrW4q59LlQdGYXWOXN5VAgh4PbXKAtk+yfzTIw5teElEk+KwJYo93zxe
         pQcl7JxFQuL/vzYYg1voIA+YYMGWk/onbAXoL+jacXi6ZQTcckdOaHj+rqx7FOnm++5S
         t96gJ7amhA9T2f+pEa2wQyCBB/fofKh6akAyZJV0tokTYxvNhem8XRcVtOv324yBabi+
         wNHoXgj2OQddORVkGOi4NXmxhZSLNCHc4jDBNMlEmeXaQ9wN0WxvNzmop7dKOhlBhDWP
         MDlJdKoCkxD6yMkDgiJfHoLsH9rkA2OooWVCsrHAVM0lFqtxSwyc9v530wd2R+/riiIT
         qsdg==
X-Gm-Message-State: ABuFfoirfQ0MwRMhRDBradGVBpn2GPZt1LQfVFIBmMx8msKu2W/OEsT9
        lLrzhIBn/wHRU8wpAnvYD2TYy+9k
X-Google-Smtp-Source: ACcGV60r7FUQOAGGmT6Bj0JXl7HzEMXYGYdsS3qOehqNLEzFHplKgYUUNXEJWwpII0ktmso1726hhw==
X-Received: by 2002:a2e:544f:: with SMTP id y15-v6mr526214ljd.51.1537912680594;
        Tue, 25 Sep 2018 14:58:00 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.213])
        by smtp.googlemail.com with ESMTPSA id u6-v6sm624102lfu.42.2018.09.25.14.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 14:57:59 -0700 (PDT)
Subject: Re: [PATCH v1 1/5] dt-bindings: cpufreq: Add binding for NVIDIA
 Tegra20/30
To:     Rob Herring <robh@kernel.org>
Cc:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180830194356.14059-1-digetx@gmail.com>
 <20180830194356.14059-2-digetx@gmail.com> <20180925165810.GA32430@bogus>
 <074a169d-294b-ad4b-ddbd-6db742278f2a@gmail.com>
 <CAL_JsqLf+_Q8ZQAo=k8yQ4XKMccUHpm8WsQ3z_Q-PMY6gbQbbA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2f060ecc-44a2-9a8f-459e-5ae21990b65e@gmail.com>
Date:   Wed, 26 Sep 2018 00:57:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLf+_Q8ZQAo=k8yQ4XKMccUHpm8WsQ3z_Q-PMY6gbQbbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/18 10:36 PM, Rob Herring wrote:
> On Tue, Sep 25, 2018 at 12:29 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> On 9/25/18 7:58 PM, Rob Herring wrote:
>>> On Thu, Aug 30, 2018 at 10:43:52PM +0300, Dmitry Osipenko wrote:
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
>>> The Cortex A9 has CLK, PERIPHCLK, and PERIPHCLKEN clocks and only CLK
>>> is used for the cpu core. You can't just define your own clocks that
>>> you happen to want access to.
>>>
>>> Otherwise, you're not defining anything new here, so a binding document
>>> isn't required.
>>
>> PERIPHCLK is a different thing.
> 
> Right, that's what I meant. Only CLK is used.
> 
>> Here we are defining the CPU clock and
>> its *parent* sources, the PLLX (main) and backup (intermediate clock
>> that is used while PLLX changes its rate). These are not some random
>> clocks "that you happen to want access to", they are essential for the
>> Tegra CPUFreq driver, CPU is running off them.
> 
> assigned-clocks is generally how we get parent clocks in this
> situation. "clocks" is for what physical clocks are attached to a
> given block. ARM very clearly documents the clocks for their IP
> blocks.

Okay, seems I see now what you're meaning. The PLLX is specifically
dedicated to CPU HW on Tegra, so it shouldn't be questioning to put it
within the CPU node, unlike the backup.

The assigned-clocks are about static clocks configuration, that is
exactly opposite to what is needed. I'm not sure what you are trying to
convey.. we don't need to get the parent clock, but set it.

How the backup/intermediate clock should be represented then? It is a
part of HW description which potentially may vary depending on the board
configuration.
