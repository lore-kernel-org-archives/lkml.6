Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CC4ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9437D21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AV2eXIWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9437D21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbeJQVmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:42:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40164 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJQVmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:42:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id t22-v6so19855113lfb.7;
        Wed, 17 Oct 2018 06:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wgEmNyjm3p/r25Qb8kV0YbhcJLvXLDpm0IdVhZ/4jeU=;
        b=AV2eXIWRsgagMVEpiNWO06Hsqvy+9FyGXtNS0DoL4hCah79Mzs2jlPqJix7poMmLFK
         1nIEGUWsVWTH+lf7Yzdk4HldCgbXlEyZavBjbiencstEXi0lBGJzrNiIl0IHbHvp6qUF
         ZgsyvuGBdX8WVi7s1pWjZ4X4yMy0vecEJdUiHk6IPtmL3PeFRczvQWNhAX3SkmkXrK2L
         jxJVJaiyY1+uSvmi2nnN+OfhNzVZ5Ef8sJb4PoeMkWb7agTv9p3gsQRdpgzZwOyEW/Cl
         x+AryTiNYx3TUaYjR7murkeWoQmfVQ4HEeO33NdKzPJC3YojaB8e0pb6/44jIur0K9KH
         locg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wgEmNyjm3p/r25Qb8kV0YbhcJLvXLDpm0IdVhZ/4jeU=;
        b=WU8QFi+4wtywNyPGvT6+J9FBIX9PP47q5GGHNVBKmZKACzj9hCduPZhkhLgixKg+di
         13MB5CnKPnakwLSpzQC9k0LKZwiF+dnLmdYWz7j/kZuUXKBDtYcK/wQ2M87Usw4+pH3W
         Cd1k4FOnWXAa2F8SfrRRrYBUIQLiWq1rmMoUOoGkfqmeEusonp8UMy6hVu5LaU7GM8H0
         Ml+VndaPeGgqywFHcTOSuJ5hy+/MCR6+73Gf/clKLSiDgNxqvo1Me+RyHIuAqDrK7TQ+
         5Dt3j6ByPyIyJtQuV2fhUMwa9pbD/mMhTnCvonNpnSJWvlv28kz+vp/+moxStlFUobZH
         l7Jw==
X-Gm-Message-State: ABuFfohe90DE3RS+uFQSZYCGgLF1Tvd6qN1JpdAjT96OAFEX7Wb10Oa7
        9TefmC2SWngbMvpQoaooisp0yX5X
X-Google-Smtp-Source: ACcGV62jq2GP3ojKQD5HTrxMtJPxoPP5qnH19zyHbILd+TwLG2zyYSrseeAxTbMEtvVMGBEcdF1aUg==
X-Received: by 2002:a19:c4c5:: with SMTP id u188-v6mr8782966lff.141.1539784013023;
        Wed, 17 Oct 2018 06:46:53 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id b64-v6sm4199086ljf.0.2018.10.17.06.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 06:46:52 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c6249de9-bcaa-ab3e-8546-40f8c2c17599@gmail.com>
Date:   Wed, 17 Oct 2018 16:46:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <3c72f573-d109-b607-b7b7-d70aea3e03df@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 4:34 PM, Jon Hunter wrote:
> 
> On 17/10/2018 14:07, Dmitry Osipenko wrote:
>> On 10/17/18 3:59 PM, Jon Hunter wrote:
>>>
>>> On 17/10/2018 13:37, Dmitry Osipenko wrote:
>>>> On 10/17/18 11:40 AM, Jon Hunter wrote:
>>>>>
>>>>> On 30/08/2018 20:43, Dmitry Osipenko wrote:
>>>>>> Add device-tree binding that describes CPU frequency-scaling hardware
>>>>>> found on NVIDIA Tegra20/30 SoC's.
>>>>>>
>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>> ---
>>>>>>  .../cpufreq/nvidia,tegra20-cpufreq.txt        | 38 +++++++++++++++++++
>>>>>>  1 file changed, 38 insertions(+)
>>>>>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>>>>>> new file mode 100644
>>>>>> index 000000000000..2c51f676e958
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>>>>>> @@ -0,0 +1,38 @@
>>>>>> +Binding for NVIDIA Tegra20 CPUFreq
>>>>>> +==================================
>>>>>> +
>>>>>> +Required properties:
>>>>>> +- clocks: Must contain an entry for each entry in clock-names.
>>>>>> +  See ../clocks/clock-bindings.txt for details.
>>>>>> +- clock-names: Must include the following entries:
>>>>>> +  - pll_x: main-parent for CPU clock, must be the first entry
>>>>>> +  - backup: intermediate-parent for CPU clock
>>>>>> +  - cpu: the CPU clock
>>>>>
>>>>> Is it likely that 'backup' will be anything other that pll_p? If not why
>>>>> not just call it pll_p? Personally, I don't 'backup' to descriptive even
>>>>> though I can see what you mean.
>>>>>
>>>>> I can see that you want to make this flexible, but if the likelihood is
>>>>> that we will just use pll_p then I am not sure it is warranted at this
>>>>> point.
>>>>
>>>> That won't describe HW, but software. And device tree should describe HW.
>>>
>>> Hmm ... well that's my point exactly. So why call it 'backup'? Sounds
>>> like a software description to me.
>>
>> Because HW is designed the way that CPU parent need to be switched to the backup clock source while main clock changes its rate. HW also allow to select among different parents, pll_p is one of those parents.
> 
> Yes that part is understood. I am just splitting hairs over the actual
> name. We do the same for tegra124 but we just call it 'pll_p'. See ...
> 
> Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt

tegra124-cpufreq choose to hardwire to the pll_p, but it could be other clocks. Technically abstracting backup clock should be more correct, but result is the same in the end.
