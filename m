Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CB1C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960792080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jucLq9aF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960792080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeJaAm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:42:26 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34012 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbeJaAm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:42:26 -0400
Received: by mail-lf1-f66.google.com with SMTP id n26-v6so9278418lfl.1;
        Tue, 30 Oct 2018 08:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GcZ7EOi9s7kPW7Txdhst3pBLq8Z9IPCc8E47B//kiq8=;
        b=jucLq9aF5NfjYmVfFWxLsrmNQLBSZTI4+N6moDLB4383t/Bl14q62Y/FmZ/iZeheel
         lAjE+PTUW3npGg5htFhzEoUeA9E1eDW7C7l0wdyCZ1s0AG4dbKhTtvC64B0tmFo7STcA
         WLaqxRyuQuhddbVM799j3OJNzctxK9RM1Mrif4YaGykDXaZW0TGpGfv2NBSHEcCXVb98
         B4NyUNx09aI6LrUVi1I5np5oQHdIyxavGA+JCGycxadjq0OnoOqzAUpFadFJOohm9yv/
         Lnew0JuPMQMP4vAu0aoeCuvknUZAZYw/C0q4nb30cSnTapyAMalKadUGvgctq86pNTu0
         EF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GcZ7EOi9s7kPW7Txdhst3pBLq8Z9IPCc8E47B//kiq8=;
        b=JdSP0bMGvsghSHllZS5EBS0Hk0Ee5T8s4Tz8UcZB0dftMvD+h0Py0zUy7h9NcRftOe
         mHPMzC8/bj+GAar5/W2fGKDbPGsCXQb5lBImo/FeFwdVXUJSfWnoYOYnHXXWq4Xwf6DP
         NYL2l+B+zBzHEiW/Zwbd1wXZtk5mUSnsDoJJvOZIRib+WInFh589DQiI/ja6NifjWTam
         96/63pBCT/gj/rUfGPNoYHWwWKZp58tcRW4bv4+BuoO1cb6DuPU8/0KykG6WRdiZyGoJ
         dFAmfF5XxBw0ODUErVLeCDK8c3kMa4tHuDBZj5Qp/dzJD2WYYMEQgsSOZRDSYvM8N3Cw
         +bcQ==
X-Gm-Message-State: AGRZ1gIimiqGcBeeg2T1/310B2jWtB4xFP9cpHiyUQqoLddQLm6d1Lok
        jrEm0TizkjwsdgiwNZz6JxGcCOXJ
X-Google-Smtp-Source: AJdET5cwqSlQKvX9mhH/FvKIvRw8GfsBsc4WOvIAKOnuPwo52s4EYPI/NUEcMMieGUufSdf6IXC5/w==
X-Received: by 2002:a19:d405:: with SMTP id l5mr2383302lfg.133.1540914503068;
        Tue, 30 Oct 2018 08:48:23 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id v5-v6sm1272177lje.78.2018.10.30.08.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 08:48:22 -0700 (PDT)
Subject: Re: [RFC PATCH v2 01/17] OPP: Allow to request stub voltage
 regulators
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181021205501.23943-1-digetx@gmail.com>
 <20181021205501.23943-2-digetx@gmail.com>
 <20181022053636.ag62j3rj3vovbz53@vireshk-i7>
 <e4027793-9436-413d-2a7b-34cf519218c3@gmail.com>
 <20181022113224.b5fiebgy2aap66nd@vireshk-i7>
 <29f893be-feed-c4c5-8468-51f7228dd468@gmail.com>
 <20181024064123.lbpbeervghp35fe7@vireshk-i7>
 <ba782346-6ac0-7bf3-e187-00d2634b145b@gmail.com>
 <20181029065328.6vkbwjnq2zzwxric@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <08a1978a-32b2-0234-a461-a11e1abcff6a@gmail.com>
Date:   Tue, 30 Oct 2018 18:48:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181029065328.6vkbwjnq2zzwxric@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/18 9:53 AM, Viresh Kumar wrote:
> On 26-10-18, 15:03, Dmitry Osipenko wrote:
>> On 10/24/18 9:41 AM, Viresh Kumar wrote:
>>> On 22-10-18, 15:12, Dmitry Osipenko wrote:
>>>> Because there is one Tegra20 board (tegra20-trimslice) that doesn't declare
>>>> necessary regulators, but we want to have CPU frequency scaling. I couldn't
>>>> find board schematics and so don't know if CPU / CORE voltages are fixed on
>>>> Trim-Slice or it is just preferable not to have DVFS for that board, it is an
>>>> outlet-powered device [0]. Hence tegra20-cpufreq driver will request a dummy
>>>> regulators when appropriate. 
>>>
>>> We have been using the regulator_get_optional() variant until now in the OPP
>>> core to make sure that we don't do DVFS for the CPU without the mandatory
>>> regulators being present, as that may make things unstable and cause harm to the
>>> SoC if we try to take CPU to frequency range over the currently programmed
>>> regulator can support.
>>>
>>> Now coming back to tegra-20 SoC, which actually requires a regulator normally by
>>> design. On one of the boards (which is outlet powered), you aren't sure if there
>>> is a programmable regulator or not, or if DVFS should really be done or not.
>>> Isn't it worth checking the same from Tegra maintainers, or whomsoever has
>>> information on that board ?
>>
>> I'll try to find out more detailed information for the next revision of the patchset.
> 
> Thanks Dmitry.
> 
>>  What would happen if there actually was a regulator
> 
> Please preserve the '>' from previous replies at the beginning of the
> lines. Otherwise it looks as if you have written the above line. :)
> 
>>> and its default settings aren't good enough for high end frequencies ?
>>
>> Usually this causes kernel/applications crashes and/or machine hang.
> 
> Sure. I also do remember from some guys (maybe TI), where they
> mentioned that such scenarios can harm the hardware as well sometimes.
> Don't remember the details though.
> 
>>  And because you are moving to regulator_get() API for
>>> the entire SoC (i.e. its cpufreq driver), people will never find the missing
>>> regulator.
>>
>> Regulators core prints info message when dummy regulator is being used.
> 
> Sure, but they are easy to miss and they are only seen by developers
> not regular users of a machine.
> 
>>> If we can do it safely for all tegra20 boards, why not migrate to using
>>> regulator_get() instead of regulator_get_optional() in the OPP core API itself
>>> for everyone ?
>>>
>>
>> This should be a platform-specific decision. For Tegra we know that regulators should be in a good state at kernel boot time, I don't think that this applies to other platforms.
> 
> Based on the other discussion with Lucas on this thread, I don't think
> this is correct any more ?
> 
> Don't get me wrong, I am all good for changes and another API change
> doesn't matter much to me. I am just wondering if it would be the
> right approach to fix the issue. Why not rather call
> dev_pm_opp_set_regulators() conditionally and avoid calling it for the
> specific tegra20 board.

The right approach should be to specify device tree correctly. Probably we won't need this change at all with the correct DT, will see.

Calling dev_pm_opp_set_regulators() conditionally should work, but that is extra churning in the driver that I tried to avoid.
