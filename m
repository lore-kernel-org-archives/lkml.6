Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E38C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA15920676
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e0DEffGG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VzwwPG+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA15920676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbeIYQcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:32:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41068 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeIYQcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:32:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4C38060C67; Tue, 25 Sep 2018 10:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537871115;
        bh=tyemIGHxWpOuvAsT/Jdw+x2orXo9m3yEcCyOTtcvn14=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=e0DEffGGGJ7AU0tiq8TdECIIj+MSMCDfXf0KgiBzW+goxYIgNepFEvw4Plo1e5OpE
         WAfqkNvVhcrBonl3BIZfMHk1dv97SgsFtLP/3l0RVZSfSs5zj8DS/GDohsiijo4l8F
         S/cp+CmYIoWdHPNSBxBlM0qGowolJ0w3UwDDCCPQ=
Received: from [10.79.128.25] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 793A660BF7;
        Tue, 25 Sep 2018 10:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537871111;
        bh=tyemIGHxWpOuvAsT/Jdw+x2orXo9m3yEcCyOTtcvn14=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VzwwPG+24Qmc/VfiTdXiGXVKt1ixwTPJ1d13dfKni4sD0CeqTWWr4uKykZAbEZDjy
         8VIZi0mJEuwZu0V660GgriWuUj3yCc6Np+swBFbVsdpu+dlP+E3eZTBB25gsJS4+zC
         wjmUnjfJqZm53LwLRXaHW+vwSFH7DRiptJvkskHI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 793A660BF7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v4 2/6] dt-bindings: power: Add qcom rpm power domain
 driver bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Collins <collinsd@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180627045234.27403-1-rnayak@codeaurora.org>
 <20180627045234.27403-3-rnayak@codeaurora.org>
 <20180703223554.GA32313@rob-hp-laptop>
 <20180704055757.4li26b6poxllmh2k@vireshk-i7>
 <1463d24b-481d-eecd-9e44-e7a5a993e5fc@codeaurora.org>
 <CAL_JsqJe+m4hD3nxQDjOT1JzRoSMXppy1r6APV1w=NtgCr-X_A@mail.gmail.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <271db7b1-f65b-f42d-b00b-9362429b3749@codeaurora.org>
Date:   Tue, 25 Sep 2018 15:55:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJe+m4hD3nxQDjOT1JzRoSMXppy1r6APV1w=NtgCr-X_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

[]...
>>>>> +   rpmhpd_opp_table: opp-table {
>>>>> +           compatible = "operating-points-v2-qcom-level";
>>>>> +
>>>>> +           rpmhpd_opp_ret: opp1 {
>>>>> +                   qcom,level = <RPMH_REGULATOR_LEVEL_RETENTION>;
>>>>> +           };
>>>>
>>>> I don't see the point in using the OPP binding here when you aren't
>>>> using *any* of the properties from it.
>>>
>>> Yeah, that's the case for now. But there are cases (as Stephen
>>> mentioned earlier [1]) where the voltage values (and maybe other
>>> values like current, etc) would be known and filled in DT. And that's
>>> why we all agreed to use OPP tables for PM domains as well, as these
>>> are really "operating performance points" of these PM domains.
>>
>> Rob, are you fine with these bindings then?
> 
> Okay, my only thought is whether we should just use 'reg' here, or do
> we need 'level' for anything else and should make it common?

I am not quite sure I understood what you are suggesting here :(

