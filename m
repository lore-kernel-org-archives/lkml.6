Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242C2C7112C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0159206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OJKJu8KB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nnJP7uEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0159206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeJXMh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 08:37:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55178 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbeJXMh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 08:37:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3D7DA610DA; Wed, 24 Oct 2018 04:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540354297;
        bh=+3QIdjvJuiCkjIpFe1sSDQ5E5k7iPTZuaNs9Me0GrdQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OJKJu8KBk46FjVinuGnvL1WvsZ1hlPNqrluDrioGsupGAwa+qLkAJGb1GtALzJrCN
         vV+USjgaLvNR7GHCEAt93QNsbEUQ2KTX12VWTuguOLhP10pXjYSQTJrcRzb39rO0kJ
         dbqx5hav+khLHg/dxvVSYCL7QBfzCG/I186Xy5VE=
Received: from [10.201.3.39] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 340646030F;
        Wed, 24 Oct 2018 04:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540354296;
        bh=+3QIdjvJuiCkjIpFe1sSDQ5E5k7iPTZuaNs9Me0GrdQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nnJP7uEE2lkJ2D/U7Yl+QDXaBH4PcV9DuHr+tENfmRNWNanbMO8tOcSu8caPLF4rE
         IWCMPL/OEt7eg7LIQn3TPpCub7cPy13dbK5hxUkaVNCqajufRWJjxWPackMgQpw3TS
         Z5lYJzyH2IbUEezEsiLTwkAmM3QtirgrpB1r5L1I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 340646030F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH V12 00/14] Krait clocks + Krait CPUfreq
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Craig <ctatlor97@gmail.com>,
        andy.gross@linaro.org, david.brown@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux@arm.linux.org.uk,
        linux@armlinux.org.uk, mark.rutland@arm.com,
        mturquette@baylibre.com, rjw@rjwysocki.net, robh@kernel.org,
        sboyd@codeaurora.org, sudeep.holla@arm.com,
        thierry.escande@linaro.org, viresh.kumar@linaro.org
References: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
 <2ae96741-94c0-ba4c-fc19-05d33179683c@codeaurora.org>
 <d682580d-5070-0271-197f-29d988172937@codeaurora.org>
 <D8FC68C0-2572-4A86-81D9-D0099D314A45@gmail.com>
 <F5A89365-C613-4FE2-AD32-DC0AC6DF380B@gmail.com>
 <fb81b8d5-3d24-b413-8d59-33cb70e46f8b@codeaurora.org>
 <153979105280.5275.841088095583550635@swboyd.mtv.corp.google.com>
 <153980741313.5275.10376918222904341760@swboyd.mtv.corp.google.com>
 <c5f492c0-19a2-db8f-a114-d3cfe17ae6c6@codeaurora.org>
 <20181022153005.GA23950@centauri.lan>
From:   Sricharan R <sricharan@codeaurora.org>
Message-ID: <a9fed22d-89c2-9d3d-f6bb-594dac0e3ec5@codeaurora.org>
Date:   Wed, 24 Oct 2018 09:41:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181022153005.GA23950@centauri.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

On 10/22/2018 9:00 PM, Niklas Cassel wrote:
> On Mon, Oct 22, 2018 at 09:39:03AM +0530, Sricharan R wrote:
>> Hi Stephen,
>>
>> On 10/18/2018 1:46 AM, Stephen Boyd wrote:
>>> Quoting Stephen Boyd (2018-10-17 08:44:12)
>>>> Quoting Sricharan R (2018-09-20 06:03:31)
>>>>>
>>>>>
>>>>> On 9/20/2018 1:54 AM, Craig wrote:
>>>>>> Yup, this patch seems to have fixed the higher frequencies from the quick test I did.
>>>>>>
>>>>>       Thanks !!. Can i take that as 
>>>>>           Tested-by: Craig Tatlor <ctatlor97@gmail.com>  ?
>>>>>
>>>>
>>>> Is this patch series going to be resent?
>>>>
>>>
>>> Nevermind. Looking at it I think I can apply all the clk ones and we're
>>> good to go. If you can send a followup patch series to change the
>>> registration and provider APIs to be clk_hw instead of clk based I would
>>> appreciate it.
>>>
>>
>> Sorry for the late response. Was away.
>> Only pending thing was separating out the binding documentation for the cpu-freq
>> driver and fixing the text in documentation.  That means, yes its fine to merge
>> the clk ones as you said. I will resend that. Also, will send a follow up series for clk_hw to
>> clk change as you mentioned separately.
> 
> Hello Sricharan,
> 
> Great to see that the clk parts has been marged to clk-next!
> 
> Are you also planning on sending out a new version of the cpufreq driver
> consolidation parts?
> 
   yeah right, will send a new version, sometime next week.

> I'm planning on extending your consilidated cpufreq driver with support
> for msm8916 (Cortex-A53), where I plan to read PVS/speedbin, in order to
> set opp_supported_hw(), and also register with cpufreq (since Viresh/Ulf
> suggested that we shouldn't register with cpufreq in the CPR power-domain
> driver).

   ok sure.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
