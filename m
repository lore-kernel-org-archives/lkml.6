Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F141C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9D520823
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbfAVQGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:06:55 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56562 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728806AbfAVQGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:06:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68A60A78;
        Tue, 22 Jan 2019 08:06:54 -0800 (PST)
Received: from [10.37.10.44] (unknown [10.37.10.44])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F4503F589;
        Tue, 22 Jan 2019 08:06:50 -0800 (PST)
Subject: Re: [PATCHv4 1/4] arm64: dts: qcom: sdm845: Add Coresight support
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
References: <cover.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <ad16cfb9b6f5efb85149458d5f5a1abf43fa027c.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <1bd39862-0725-70ce-6535-fdb59569f683@arm.com>
 <75ed74af-6946-b86d-092e-42dc16e55308@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <91a90daa-9e14-2d2e-e633-2ddfdc0955bf@arm.com>
Date:   Tue, 22 Jan 2019 16:08:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <75ed74af-6946-b86d-092e-42dc16e55308@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

On 01/22/2019 03:02 PM, Sai Prakash Ranjan wrote:
> Hi Suzuki,
> 
> Thanks for looking into this. Please find my response inline.
> 
> On 1/22/2019 7:30 PM, Suzuki K Poulose wrote:
>> Hi Sai,
>>
>> On 01/22/2019 01:37 PM, Sai Prakash Ranjan wrote:
>>> Add coresight components found on Qualcomm SDM845 SoC.
>>>
>>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>>>
>>
>> Sorry, but I hadn't noticed the PID override strings below. Please
>> find the question.
>>
> [..]
> 
>>> +        /*
>>> +         * On QCOM SDM845, we bypass the normal AMBA bus discovery
>>> +         * method by forcing the peripheral ID because of the wrong
>>> +         * value read from ETM PID registers.
>>> +         */
>>
>> What is the value read back from the ETM PIDx registers ? Do they
>> provide inconsistent or incompatible value w.r.t the ETM/Coresight
>> architecture ? If it is an unsupported CPU with proper values,
>> you must add them to the table in etm4x driver.
>>
> 
> The values read from ETM PIDx registers are actually inconsistent
> and is different for some ETMs.

By inconsistent, I meant the registers provides values which are not
the same on two different CPUs of the *same type*. And it is expected
that two different CPU/ETM implementations will have different PIDs.

> 
> Below are the PIDs read for SDM845:
> 
> [    5.996448] resname=etm@7040000 pid=001bb803
> [    6.052891] resname=etm@7140000 pid=001bb803
> 
> <snip> .. (Same pid=001bb803 for etm@7240000 to etm@7540000 but differs
> for other 2 cpus as shown below)
> 
> [    6.266687] resname=etm@7640000 pid=001bb802
> [    6.329171] resname=etm@7740000 pid=001bb802
> 
> This is the case for MSM8996 also as shown below where PID
> value is not correct and has to be hardcoded.

They differ because they are two different types of CPU cores (and thus 
different ETM PIDs). What does the Register descriptions say for
the Cores ?

To me it looks like there are two different types of Qualcomm
Cores with their respective ETMs which are missing in the ETM4x
driver and we are trying to "make the ETM" work by faking it as
something else, which is not nice. I would rather prefer
to add the appropriate masks and the expected value for these
two different ETM implementations and be done with it, instead
of faking it in all the DTs where these cores appear.

> 
> For MSM8996:
> 
> resname=etm@3b40000 pid=102f0205

I don't know what CPUs the MSM8996 have. If they don't have A53, you
must add the actual PIDs to the table once and for all.

> 
>>> +        etm@7040000 {
>>> +            compatible = "arm,coresight-etm4x", "arm,primecell";
>>> +            arm,primecell-periphid = <0x000bb95d> > +            reg 
>>> = <0 0x07040000 0 0x1000>;
>>> +
>>> +            cpu = <&CPU0>;
>>> +
>>
>> You seem to be specifying the PID of A53 ETM all over, while at least
>> one of your cores is ETMv4.2 (from the other patch) and A53 is not
>> ETMv4.2. As above, it would be good to add the PID to the table.
>>
> 
> As explained in above comment, PID values read are not correct. Please 
> let me know if I am not clear.

There is no measure for "correctness" here. If the ETM exposes different
PID than what you expect from the TRM, then we could think of overriding
it. Otherwise please add the PIDs to the table.

Cheers
Suzuki
