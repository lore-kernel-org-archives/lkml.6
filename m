Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A70C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DFC20878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P/wt/iDw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P/wt/iDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DFC20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeJHSKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:10:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51982 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbeJHSKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:10:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 79015607F4; Mon,  8 Oct 2018 10:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538996360;
        bh=VHb85eqr+delHW5EbNN62bVlBSEuc05Qlk3deLVAK0I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P/wt/iDw2VbDyJVYavyfVC+nxsO8k9rdqjHT5VtSjQuJpDhDYiBrkZEythQUZqvYZ
         +IABPPiqQIY8aG3CaL5WK0KeFfGmkpZjUmw89J2i1VtdYUqO7j9nx7ajbt2YpY4Gs+
         4SmzE36+TMDhuAIF8uKuTffg5AtDXO2+yAsYwW4A=
Received: from [192.168.225.247] (unknown [49.33.151.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 820AA60588;
        Mon,  8 Oct 2018 10:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538996360;
        bh=VHb85eqr+delHW5EbNN62bVlBSEuc05Qlk3deLVAK0I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P/wt/iDw2VbDyJVYavyfVC+nxsO8k9rdqjHT5VtSjQuJpDhDYiBrkZEythQUZqvYZ
         +IABPPiqQIY8aG3CaL5WK0KeFfGmkpZjUmw89J2i1VtdYUqO7j9nx7ajbt2YpY4Gs+
         4SmzE36+TMDhuAIF8uKuTffg5AtDXO2+yAsYwW4A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 820AA60588
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v8 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
To:     Niklas Cassel <niklas.cassel@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com
References: <1537698793-15285-1-git-send-email-tdas@codeaurora.org>
 <1537698793-15285-3-git-send-email-tdas@codeaurora.org>
 <20181008084012.GA23693@centauri.lan>
 <20181008095952.gl7di2tnuv3jwew6@vireshk-i7>
 <20181008103856.GA10890@centauri.lan>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <52643019-07d9-0055-ecd3-24c1a7863481@codeaurora.org>
Date:   Mon, 8 Oct 2018 16:29:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008103856.GA10890@centauri.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/8/2018 4:08 PM, Niklas Cassel wrote:
> On Mon, Oct 08, 2018 at 03:29:52PM +0530, Viresh Kumar wrote:
>> On 08-10-18, 10:40, Niklas Cassel wrote:
>>>> +		ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
>>>> +				"#freq-domain-cells", 0, &args);
>>>
>>> Hello Taniya,
>>>
>>> in your DT binding, you use
>>>
>>> #freq-domains-cells = <1>
>>>
>>> Yet here you parse for "#freq-domain-cells".
>>
>> And what is the problem with that ? Or are you suggesting her to call
>> of_parse_phandle_with_fixed_args() ?
> 
> Hello Viresh,
> 
> #freq-domain-cells != #freq-domains-cells
> 
> The code should parse for the exact same property name as stated in the
> DT binding.
> 
> Kind regards,
> Niklas
> 

The extra 's' was a typo, would fix it in the next patch.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
