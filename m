Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F80C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A7D20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JrqOhD/u";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mqov6+qj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbfAOQ32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:29:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51300 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731571AbfAOQ3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:29:25 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4A6E56098C; Tue, 15 Jan 2019 16:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547569764;
        bh=UvXAVr5rAfYcmmPYgTtQFy9MuZWOaQi5am+NVzDZMm4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JrqOhD/u5hEdUU3X3SfMTPXX2MDMRfNUBFmWN3jTEt7pQiN0ezUBEqtrWXUwKKScb
         YDPYsW4Qqfa1Noi/K0C0AQzNCr4qVZ5CBh31dWn+j9vrPjXsMX1OT9YLPAGv5QQGuM
         OHV2Lb5xEkHsyy68oHLBVG2pafP378scSoHXhuTU=
Received: from [192.168.43.47] (unknown [223.237.252.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AFE6A605A0;
        Tue, 15 Jan 2019 16:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547569763;
        bh=UvXAVr5rAfYcmmPYgTtQFy9MuZWOaQi5am+NVzDZMm4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Mqov6+qjpmZKrAZcajDHX1ZW1s6UIdGD+XFxYXOQ7iPk3f6PGCMBGiVyewCv5WIzk
         10HJsWb56XciJCE+OyXx41wGZwm5yHC0ZiVSp5Kj3jAwe67gRPJjbFoLkXs7C8m2p1
         tr3qN2UekdJ0gtEo77WTDRgBy3RgzkJw5/SMyIwI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AFE6A605A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm845: Add Coresight support
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Leo Yan <leo.yan@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        linux-arm-msm-owner@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <a13ad49d3ae8d9a5a972027283b7212ab19f97d0.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <20190111184643.GA22691@xps15>
 <81172d85ed7782e0db561fcf96a82d46@codeaurora.org>
 <20190114153509.GA29374@xps15>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <f792b36a-4357-49f2-f242-8a7c8ed464a8@codeaurora.org>
Date:   Tue, 15 Jan 2019 21:59:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190114153509.GA29374@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 1/14/2019 9:05 PM, Mathieu Poirier wrote:
> On Sat, Jan 12, 2019 at 06:21:00PM +0530, saiprakash.ranjan@codeaurora.org wrote:
>> Hi Mathieu,
>>
>>>> +
>>>> +	etm@7040000 {
>>>> +		compatible = "arm,coresight-etm4x", "arm,primecell";
>>>> +		arm,primecell-periphid = <0x000bb95d>;
>>>
>>> I'm a little curious as to why you need to bypass the normal AMBA bus
>>> discovery
>>> method by forcing the peripheral ID.  Tracers don't show up the way
>>> other
>>> coresight devices do at boot time?
>>>
>>
>> Yes on some Qcom SoC's like SDM845 and also on some previous ones, for
>> ETM(only) amba bus discovery method fails because of wrong pid read from the
>> registers. So we have to force this primecell peripheral ids to probe etm.
> 
> Ok, if that is the case please add a comment to explain the situation.
> Otherwise someone will assuredly ask again in the future.
> 

Sure, will add it in the next version.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
