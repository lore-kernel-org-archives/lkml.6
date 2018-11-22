Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F3DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18C520864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KUIwFAUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18C520864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437734AbeKWCK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:10:29 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37796 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437719AbeKWCK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:10:28 -0500
Received: by mail-wm1-f67.google.com with SMTP id p2-v6so9466432wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 07:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/gdyEMmwIpDA7UWL4y3n+Qu2eQKbycMOptMcNyq9TtM=;
        b=KUIwFAUojixNVqwyOkA7px+DwBP5BnsrypPW6Kf08K20Abmxx6gpgVglCYlWsOr+SK
         PjETrOPTMoaqBrmjHlOpWe7+XI8iU4+Ifg6x1Dn/qazVdHkDQm7j6n0m0T+dC+FeaEaF
         rs/qWJkmYQmSkgn+a/DUBff1eTXBCB3jus6V0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/gdyEMmwIpDA7UWL4y3n+Qu2eQKbycMOptMcNyq9TtM=;
        b=Vl3HVqE53Gnb/BE4TO8ZzQkDK56KOOAUSevtOuEBDrN05IjoLEfSDYpKguVcYqG1SQ
         AhFmAkLrJ/Ga2xh24VaaBy/bOYBkJnSx6mTlKUEXP6LfnroE7taqxqhJ2hV4i0LCWefu
         K/BuJSP9/a980TLJQDJKRTrNprlZoilb0Gud6LfDMw8FAde9h1aI6Ncw35HVFv7S8zS9
         temJtvoOSB5u0PuzyzpZFHTgOB2YwBCqAAshl2nVtJmnUM0DcDkVkZ4xXnxTQr0Zg6Tx
         sagKg6rsn1lHO2nyBHNcqpa/Y6CMdb7iyFAqN4ixHEL7us1e9xa51ITRp8Y70Qdta7uY
         Mknw==
X-Gm-Message-State: AA+aEWbGhATITKzk0OHxSWifrq0i/DPtlMXR1ldK3t6OrOdtyDH+dS0k
        AaRLnh5sxcc2JgRoK0vgxivkfaeidFE=
X-Google-Smtp-Source: AFSGD/XbH00E0euf9fkANB+RDL/SEgN8+xfY41NYNere2lbUWntPvO05aB1Ur4tU6ZijhleEQUFceQ==
X-Received: by 2002:a1c:cec1:: with SMTP id e184mr2247209wmg.75.1542900636264;
        Thu, 22 Nov 2018 07:30:36 -0800 (PST)
Received: from [192.168.0.40] (44.65.136.77.rev.sfr.net. [77.136.65.44])
        by smtp.googlemail.com with ESMTPSA id p14sm15918641wrt.37.2018.11.22.07.30.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 07:30:35 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: renesas: r8a7796: Add CMT device nodes
To:     Biju Das <biju.das@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <Marc.Zyngier@arm.com>
References: <1540542307-63158-1-git-send-email-biju.das@bp.renesas.com>
 <1be47ef6-1a92-e032-12c1-1deae5b67960@linaro.org>
 <OSBPR01MB210312547BBCBBC9FC01A616B8D80@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <67cf2385-9379-f02a-36fd-b2e07dfd5497@linaro.org>
 <TYAPR01MB2111A4092907D265493DDF3FB8D80@TYAPR01MB2111.jpnprd01.prod.outlook.com>
 <dbc5f62d-aff0-8c6a-e957-e7dea15cc002@linaro.org>
 <OSBPR01MB21030159FAA26E6C8FE492FFB8DB0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <a82d3315-7608-3ff8-eaa1-e2a2c05c0694@linaro.org>
 <OSBPR01MB21034E0B1AE2304A9A17DE50B8DB0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <84b6bc0e-486d-e9f4-7579-0d6b513c15ba@linaro.org>
Date:   Thu, 22 Nov 2018 16:30:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB21034E0B1AE2304A9A17DE50B8DB0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Added Marc Zyngier in Cc.

On 22/11/2018 16:16, Biju Das wrote:
> Hello Daniel,
> 
> Thanks for the feedback.
> 
>>>> Subject: Re: [PATCH] arm64: dts: renesas: r8a7796: Add CMT device
>>>> nodes
>>>>
>>>> On 19/11/2018 16:50, Biju Das wrote:
>>>>> Hi Daniel,
>>>>>
>>>>> Thanks for the feedback.
>>>>>
>>>>>>>> Subject: Re: [PATCH] arm64: dts: renesas: r8a7796: Add CMT device
>>>>>>>> nodes
>>>>>>>>
>>>>>>>> On 26/10/2018 10:25, Biju Das wrote:
>>>>>>>>> This patch adds CMT{0|1|2|3} device nodes for r8a7796 SoC.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
>>>>>>>>> ---
>>>>>>>>> This patch is tested against renesas-dev
>>>>>>>>>
>>>>>>>>> I have executed on inconsistency-check, nanosleep and
>>>>>>>>> clocksource_switch selftests on this arm64 SoC. The
>>>>>>>>> inconsistency-check and nanosleep tests are working fine.The
>>>>>>>>> clocksource_switch asynchronous test is failing due to
>>>>>>>>> inconsistency-check
>>>>>>>> failure on "arch_sys_counter".
>>>>>>>>>
>>>>>>>>> But if i skip the clocksource_switching of "arch_sys_counter",
>>>>>>>>> the asynchronous test is passing for CMT0/1/2/3 timer.
>>>>>>>>>
>>>>>>>>> Has any one noticed this issue?
>>>>>>>>
>>>>>>>> So now that you mention that, I've been through the
>>>>>>>> clocksource_switch on another ARM64 platform (hikey960) and
>>>>>>>> disabled the
>>>>>>>> ARM64_ERRATUM_858921 config option. I can see the same issue.
>>>>>>>>
>>>>>>>> Is this option set on your config ?
>>>>>>>
>>>>>>> No.  As per  " config ARM64_ERRATUM_858921", it is "Workaround for
>>>>>> Cortex-A73 erratum 858921"
>>>>>>>
>>>>>>> Our SoC is 2xCA-57 + 4 x CA-53.  Does  it impact CA-57 + CA_53?
>>>>>>
>>>>>> Dunno :/
>>>>>>
>>>>>>> Any way I will enable this config option and will provide you the
>> results.
>>>>>>
>>>>>> Ok, thanks!
>>>>>
>>>>> The following config is enabled by default on upstream
>>>>> kernel(4.20-rc3) CONFIG_ARM_ARCH_TIMER_EVTSTREAM=y
>>>>> CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND=y
>>>>> CONFIG_FSL_ERRATUM_A008585=y
>>>>> CONFIG_HISILICON_ERRATUM_161010101=y
>>>>> CONFIG_ARM64_ERRATUM_858921=y
>>>>>
>>>>> For a quick testing,  I have activated the erratum using the
>>>>> property
>>>> "fsl,erratum-a008585" on device tree.
>>>>> With this I confirm the issue is fixed.
>>>>>
>>>>> I have  some questions on this.
>>>>> 1) Based  on the test result ,do you think renesas soc also
>>>>> impacted by the
>>>> ARM64_ERRATUM_858921?
>>>>> 2) Is there any way to find, is this Erratum actually causing the
>>>> asynchronous test to fail?
>>>>
>>>> I guess, you can hack the __fsl_a008585_read_reg macro and check if
>>>> the invalid condition is reached.
>>>>
>>>> This thread https://lkml.org/lkml/2018/5/10/773 will give you all the
>>>> answers you are looking for (well very likely).
>>>>
>>>> Let me know if it helped.
>>>
>>> In our case , Delta: 174760 ns
>>>
>>> 1530553351:205762284
>>> 1530553351:205762404
>>> --------------------
>>> 1530553351:205951226
>>> 1530553351:205776466
>>> --------------------
>>>
>>> I have tried the workaround for ARM64_ERRATUM_858921, that also fixes
>> the issue.
>>>
>>> But all the workaround disables ARM64 VDSO. How do we conclude that is
>> it VDSO issue or ARM64_ERRATUM issue?
>>
>> May be disable all errata and set vdso_default to false?
>>
>> [ ... ]
>>
>> -static bool vdso_default = true;
>> +static bool vdso_default = false;
>>
>> [ ... ]
> 
> I have disabled the  activation of errata from device tree and set vdso_default=false.
> With this also it works fine. So looks like arm64 vdso is the issue in our case.
> 
> Do you agree with the conclusion?

I agree we have an element to investigate the issue. That is very
specific to this timer and a good knowledge of the internals is required.

Certainly Marc Zyngier or Mark Rutland can help here.

> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=6
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] arch_timer: cp15 timer(s) running at 8.32MHz (virt).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x1eb398c07, max_idle_ns: 440795202503 ns
> [    0.000004] sched_clock: 56 bits at 8MHz, resolution 120ns, wraps every 2199023255503ns



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

