Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DBFC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD4E20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AT9LbDgN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OoJvQnwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfAVPDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:03:03 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40796 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbfAVPDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:03:03 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A54556074E; Tue, 22 Jan 2019 15:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548169381;
        bh=6pR4WJEX9BrwhrjL8sF/7l6ind7XQnrqoNa0E6QRTgs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AT9LbDgNy92/MdUH9cS6pNida/us1FGZcsyiBTSnBa5PmaZ9WVlTGXkSb5vVbw7k4
         MM1N+yJDQta21jc0EK/bzEAylq2DJ6mkKNmL+a6HMWMdrfXYHYbnO9/jH2iUKBvOHm
         T3CFZsS2XnpC/3OCS+sFueEQIXWfC1vCpAUVVedU=
Received: from [192.168.1.100] (unknown [157.49.207.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 656FA6044E;
        Tue, 22 Jan 2019 15:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548169380;
        bh=6pR4WJEX9BrwhrjL8sF/7l6ind7XQnrqoNa0E6QRTgs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OoJvQnwPOCRW+AYRzCS10erMp1zqlgtu0wE7+N6EWQETZyPjlLHbOV4pQ8EKvPq0m
         VyUPbNbJdg4cLSx+GcJlXWvrf/WzJEa5zPE5Zrq/8mEWpqzk6jELf7KuUHf+pkAAd0
         pXX7wBRClhNRlH9MAM+KCxWyzDrXZLhtsNCk5eWg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 656FA6044E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv4 1/4] arm64: dts: qcom: sdm845: Add Coresight support
To:     Suzuki K Poulose <suzuki.poulose@arm.com>, robh+dt@kernel.org,
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
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <75ed74af-6946-b86d-092e-42dc16e55308@codeaurora.org>
Date:   Tue, 22 Jan 2019 20:32:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1bd39862-0725-70ce-6535-fdb59569f683@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

Thanks for looking into this. Please find my response inline.

On 1/22/2019 7:30 PM, Suzuki K Poulose wrote:
> Hi Sai,
> 
> On 01/22/2019 01:37 PM, Sai Prakash Ranjan wrote:
>> Add coresight components found on Qualcomm SDM845 SoC.
>>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>>
> 
> Sorry, but I hadn't noticed the PID override strings below. Please
> find the question.
>
[..]

>> +        /*
>> +         * On QCOM SDM845, we bypass the normal AMBA bus discovery
>> +         * method by forcing the peripheral ID because of the wrong
>> +         * value read from ETM PID registers.
>> +         */
> 
> What is the value read back from the ETM PIDx registers ? Do they
> provide inconsistent or incompatible value w.r.t the ETM/Coresight
> architecture ? If it is an unsupported CPU with proper values,
> you must add them to the table in etm4x driver.
> 

The values read from ETM PIDx registers are actually inconsistent
and is different for some ETMs.

Below are the PIDs read for SDM845:

[    5.996448] resname=etm@7040000 pid=001bb803
[    6.052891] resname=etm@7140000 pid=001bb803

<snip> .. (Same pid=001bb803 for etm@7240000 to etm@7540000 but differs
for other 2 cpus as shown below)

[    6.266687] resname=etm@7640000 pid=001bb802
[    6.329171] resname=etm@7740000 pid=001bb802

This is the case for MSM8996 also as shown below where PID
value is not correct and has to be hardcoded.

For MSM8996:

resname=etm@3b40000 pid=102f0205

>> +        etm@7040000 {
>> +            compatible = "arm,coresight-etm4x", "arm,primecell";
>> +            arm,primecell-periphid = <0x000bb95d> > +            reg 
>> = <0 0x07040000 0 0x1000>;
>> +
>> +            cpu = <&CPU0>;
>> +
> 
> You seem to be specifying the PID of A53 ETM all over, while at least
> one of your cores is ETMv4.2 (from the other patch) and A53 is not
> ETMv4.2. As above, it would be good to add the PID to the table.
> 

As explained in above comment, PID values read are not correct. Please 
let me know if I am not clear.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
