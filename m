Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D614C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096A621916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E4BOUi+w";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TD6RlVOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfBHFOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 00:14:55 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41930 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfBHFOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 00:14:55 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 857D060A60; Fri,  8 Feb 2019 05:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549602893;
        bh=BN+IwVB+jo/hG86eIynovwh2uHK3TLFHFAxCWtsZUWE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=E4BOUi+wrQrm9ob14fE0IHsiWMPRi4ioaV/Mnu/prMh+0mRjn/1GklBMzCjmycZhn
         N9I51bTYj8MucKbKdQjLxRV89NrSJJXgrTJtEBEQflf7h8Zbr6a+0PMPVQrX9uy2DT
         W2s5IMIG9jlBch996td2MpycjMIV92zUPZIomIgQ=
Received: from [192.168.43.47] (unknown [106.206.90.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 916B56090B;
        Fri,  8 Feb 2019 05:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549602884;
        bh=BN+IwVB+jo/hG86eIynovwh2uHK3TLFHFAxCWtsZUWE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TD6RlVOS7AaF0Di7rtX+HrbpQipfx9LAjmXTPM8GmEaKIqoB8rH9Azx38oM/VoOK3
         H/Gy8h20m7m5T/e7ty0v9OY78IUzURlwNLXj9WBampyYD+ffnjYc5z2m2YKk96hbig
         sD1GRp5b+GguBcqq+a86/jZIoIXuqf136omo/V5Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 916B56090B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv7 6/6] coresight: cpu-debug: Add support for Qualcomm Kryo
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org>
 <53cf9d9d3b14f503a6c842754f3c55413f5a3392.1548981329.git.saiprakash.ranjan@codeaurora.org>
 <CANLsYky9ujRyftg3WoeSWK37=3_k5hw9x=DV34P_YrUXCLApXw@mail.gmail.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <d6f568ca-be16-ef1a-b83b-83b9a613582d@codeaurora.org>
Date:   Fri, 8 Feb 2019 10:44:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CANLsYky9ujRyftg3WoeSWK37=3_k5hw9x=DV34P_YrUXCLApXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/2019 1:58 AM, Mathieu Poirier wrote:
> On Thu, 31 Jan 2019 at 17:55, Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>>
>> Add support for coresight CPU debug module on Qualcomm
>> Kryo CPUs. This patch adds the UCI entries for Kryo CPUs
>> found on MSM8996 which shares the same PIDs as ETMs.

[..]

> I have reviewed your work and things look good to me.  Once again
> there isn't much I can do with it right now.  Please re-submit when
> Mike's set has been merged.
> 

Sure, thanks.


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
