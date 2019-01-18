Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1C8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157202086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfARME0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:04:26 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55792 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbfARMEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:04:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59CED80D;
        Fri, 18 Jan 2019 04:04:25 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A4E43F557;
        Fri, 18 Jan 2019 04:04:22 -0800 (PST)
Subject: Re: [PATCHv2 2/4] arm64: dts: qcom: msm8996: Add Coresight support
To:     saiprakash.ranjan@codeaurora.org, robh+dt@kernel.org,
        mathieu.poirier@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, andy.gross@linaro.org,
        david.brown@linaro.org, vivek.gautam@codeaurora.org,
        dianders@chromium.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com
Cc:     rnayak@codeaurora.org, sibis@codeaurora.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <cover.1547798966.git.saiprakash.ranjan@codeaurora.org>
 <552e408950525b1bac39d05b8b4f2ae1975397e0.1547798966.git.saiprakash.ranjan@codeaurora.org>
 <1311e78a-21f6-6470-7861-39b3499974ce@arm.com>
 <6543ad5c-bbcf-b3ec-332c-115e8e3d0825@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <1b7d4c2f-98f7-4b80-4e32-6e0fe5c906ce@arm.com>
Date:   Fri, 18 Jan 2019 12:04:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6543ad5c-bbcf-b3ec-332c-115e8e3d0825@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/01/2019 11:48, Sai Prakash Ranjan wrote:
> Hi Suzuki,
> 
> On 1/18/2019 4:27 PM, Suzuki K Poulose wrote:
>>
>> If you want to use the scatter-gather mode, you must add
>> "arm,scatter-gather"
>> property to the node here.
>>
>> Have you tested the scatter-gather mode on the chip ? Does that work at
>> all ?
>> Note: You could try this by setting a buffer_size > 1M for the ETR and use
>> it as a sink from the sysfs mode.
>>
> 
> Yes the chip supports scatter-gather mode[1]. But is it required in
> dt node since it's an optional property?

If you would like to use the scatter-gather mode, you must specify it
explicitly. We have had some other boards with broken scatter-gather
mode integration which causes mysterious issues when used. So we have
a white-list approach for enabling the scatter-gather mode in the driver.

So, if you have tested to make sure that the mode works fine with a recent
kernel version (v4.19 onwards), you may want to add the property.

Suzuki

