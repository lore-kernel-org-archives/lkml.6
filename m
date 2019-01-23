Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AFBC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279C720861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mPJ/Kv2s";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oAGLcM2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfAWMMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:12:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36590 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfAWMMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:12:07 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0A452607C6; Wed, 23 Jan 2019 12:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548245526;
        bh=TOwqByPOK0JcqDzIL0TmrrT3a7x2WZU8v1t4RkS0TnM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mPJ/Kv2sqgYTWbDdJNJaMU/v/Jv1cfLZLJz4JGoaAfXEproekFb/BywpIgmeVnhbO
         TEVuqitntoVaflvRqMbIkzBYmRS6sAvzZ7XCuIqIJQFe4RVJCgxBDhBMIDkpMJQoLd
         m8Sa6Xfer+SQJBkpFchLlz1/rR/U8eZzLR/nHBFA=
Received: from [10.79.129.250] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1798602BA;
        Wed, 23 Jan 2019 12:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548245525;
        bh=TOwqByPOK0JcqDzIL0TmrrT3a7x2WZU8v1t4RkS0TnM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oAGLcM2SANEZaUiyEp/kv9ys321vLR2E8Or16hna5DCgNXLQwOaRzFMfuKfRtrRdi
         Vtddcb3Lj7/vZGOjuhantWkhbpeyWAicbN6KbJuOvYwJ7ZSqjkQ4sGSCA/NlJ2JKzh
         2vnT9y3tGds/QO2u8Zs9XwQElyvACqeRyg7V67zM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1798602BA
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
        linux-arm-msm@vger.kernel.org, john.horley@arm.com
References: <cover.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <ad16cfb9b6f5efb85149458d5f5a1abf43fa027c.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <1bd39862-0725-70ce-6535-fdb59569f683@arm.com>
 <75ed74af-6946-b86d-092e-42dc16e55308@codeaurora.org>
 <91a90daa-9e14-2d2e-e633-2ddfdc0955bf@arm.com>
 <3906faf1-abbd-9c28-ad55-ed3800f06352@codeaurora.org>
 <c03b63bf-aca8-ea46-70ad-ee4558f0319e@arm.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <5b54c6e0-7d22-ecee-486f-31333f49f84a@codeaurora.org>
Date:   Wed, 23 Jan 2019 17:41:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c03b63bf-aca8-ea46-70ad-ee4558f0319e@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 1/23/2019 1:42 AM, Suzuki K Poulose wrote:
> Hi Sai,
> 
> On 01/22/2019 04:48 PM, Sai Prakash Ranjan wrote:
>> Hi Suzuki,
>>
[..]
>>
>> SDM845 has 4 Kryo 385 Gold (ARM A75) + 4 Kryo 385 Silver (ARM A55),
>> so the PID values should be same for 4 ETMs atleast. But here one
>> pid value(001bb803) is same for 6 ETMs and other one for 2
>> ETMs(001bb802) which seems odd and hence the doubt if these pids
>> are even valid ones.
> 
> Have you checked other SoCs with A55 for the ETM PID ? The drivers
> usually only care about PID0[7-0], PID1[7-0], PID2[3-0] and ignores
> the other fields that may change over revisions of the core. So, in your
> case the ETM ID could be treated as 0xbb802 and 0xbb803.
> 

Very sorry to have mislead you here. I checked again today on SDM845 and 
as you said 4 ETMs based on A75 has 0xbb803 and other 4 ETMs based on
A55 has 0Xbb803. I wrongly mentioned it as 6 and 2.

[    6.688809] resname=etm@7040000 pid = 0x1bb803
[    6.694957]
[    6.694957] resname=etm@7140000 pid = 0x1bb803
[    6.701135]
[    6.701135] resname=etm@7240000 pid = 0x1bb803
[    6.707256]
[    6.707256] resname=etm@7340000 pid = 0x1bb803
[    6.713454]
[    6.713454] resname=etm@7440000 pid = 0x1bb802
[    6.719621]
[    6.719621] resname=etm@7540000 pid = 0x1bb802
[    6.725814]
[    6.725814] resname=etm@7640000 pid = 0x1bb802
[    6.731971]
[    6.731971] resname=etm@7740000 pid = 0x1bb802

So is it ok to add these to table as below in etm4x driver with the
following comment since these do not exactly match A75 and A55 PIDs
which you provided? Or any other way you prefer?

@@ -1079,6 +1079,10 @@ static const struct amba_id etm4_ids[] = {
         ETM4x_AMBA_ID(0x000bb95a),              /* Cortex-A72 */
         ETM4x_AMBA_ID(0x000bb959),              /* Cortex-A73 */
         ETM4x_AMBA_ID(0x000bb9da),              /* Cortex-A35 */
+       ETM4x_AMBA_ID(0x000f0211),              /* Qualcomm Kryo */
+       ETM4x_AMBA_ID(0x000f0205),              /* Qualcomm Kryo */
+       ETM4x_AMBA_ID(0x000bb803),              /* Qualcomm Kryo 385 
Cortex-A75 */
+       ETM4x_AMBA_ID(0x000bb802),              /* Qualcomm Kryo 385 
Cortex-A55 */
         {},
  };

For msm8996, cpu debug module pid returned is same as ETM
which is causing the probe failure for cpu debug coresight module
as shown in below logs.
For this case, I tried adding these ids to cpu debug driver, but it
splits some errors (coresight-cpu-debug: probe of 3840000.etm failed 
with error -16) since the ids are same. Can we override for this case
or there is something else we can do here?

[    5.480629] resname=debug@3810000 pid = 0x102f0211
[    5.480920] OF: graph: no port node found in /soc/debug@3810000
[    5.513214] coresight-etm4x: probe of 3810000.debug failed with error -22
[    5.524362]
[    5.524362] resname=debug@3910000 pid = 0x102f0211
[    5.524888] OF: graph: no port node found in /soc/debug@3910000
[    5.537586] coresight-etm4x: probe of 3910000.debug failed with error -22
[    5.541481]
[    5.549643] resname=debug@3a10000 pid = 0x102f0205
[    5.580990] OF: graph: no port node found in /soc/debug@3a10000
[    5.586817] coresight-etm4x: probe of 3a10000.debug failed with error -22
[    5.592082]
[    5.592629] resname=debug@3b10000 pid = 0x102f0205
[    5.604922] OF: graph: no port node found in /soc/debug@3b10000
[    5.611234] coresight-etm4x: probe of 3b10000.debug failed with error -22


Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
