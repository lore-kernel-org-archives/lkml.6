Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9109CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F16920881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KhRidRzf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GVSd0MNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfA1TSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:18:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56794 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfA1TSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:18:08 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 80AC361C72; Mon, 28 Jan 2019 19:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548703086;
        bh=Kg7vvUwTktzmDpIqYZapRFXAV1l3wJ0DM/dbZeWt7EA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KhRidRzftTwDXxn9Hs/Olk6mPZV7x3Sw78XhbiSLGB46wf6zeFHsD5dh1MUXuOp7D
         42bcOqAVI4/lBa4DDXZ5JnWEywrYM82yUPzf4sjFwPGic/vQpQhNDh7oGm3OqtCCCq
         1dgP2TccA7n2hkVzi9eMGMiJ7O8fvAGk5bv7R77g=
Received: from [192.168.43.47] (unknown [27.59.122.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 20FE76182C;
        Mon, 28 Jan 2019 19:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548703083;
        bh=Kg7vvUwTktzmDpIqYZapRFXAV1l3wJ0DM/dbZeWt7EA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GVSd0MNdP9hQcuV5UN1znOxxTpsAo4+Ck5QXvYYAyrlcO+y5vkYvw4Tbh//pqj9nX
         X0L8eH+OmjdTLiMaxFGQ/1xQSrsc9DhlZEMJzZ5IzyQSTUmQjrEO3eiVZ1TJGUqJhX
         k8IG//pcUCvR46wr2mQJjyqEnObe9eIBLtJ0YGqY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20FE76182C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv4 1/4] arm64: dts: qcom: sdm845: Add Coresight support
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        John Horley <John.Horley@arm.com>
References: <cover.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <ad16cfb9b6f5efb85149458d5f5a1abf43fa027c.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <1bd39862-0725-70ce-6535-fdb59569f683@arm.com>
 <75ed74af-6946-b86d-092e-42dc16e55308@codeaurora.org>
 <91a90daa-9e14-2d2e-e633-2ddfdc0955bf@arm.com>
 <3906faf1-abbd-9c28-ad55-ed3800f06352@codeaurora.org>
 <c03b63bf-aca8-ea46-70ad-ee4558f0319e@arm.com>
 <5b54c6e0-7d22-ecee-486f-31333f49f84a@codeaurora.org>
 <18b70426-60fe-4871-6388-6e09fd5feb37@arm.com>
 <de6e021a-4f9a-8e2e-dff0-1e7c61ad8b2b@codeaurora.org>
 <CANLsYkxkTTfTMNNZZ1tmS=cjakcfveMDrW6wxXPXie8M9_VDOg@mail.gmail.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <eec64938-ef6a-a3d5-d93f-7a63df8b132f@codeaurora.org>
Date:   Tue, 29 Jan 2019 00:47:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CANLsYkxkTTfTMNNZZ1tmS=cjakcfveMDrW6wxXPXie8M9_VDOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/2019 10:45 PM, Mathieu Poirier wrote:

>> For SDM845(A75 based):
>>
>> *0xB_B8_03* does indicate that the JEP106 identification
>> code is 0x3B and continuation code is 0x4 which is of ARM and not
>> QCOM(JEP106 ID is 0x70) which is expected.
>>
>> And the other values of PIDR0[0:7] and PIDR1[3:0] are *Implementation
>> defined part numbers* and can be different from ARM A75/A55.
>>
>> I think this clears up case for SDM845.
>>
>> As for MSM8996, it is not based on any ARM derivative and hence the
>> JEP106 ID is of QCOM(0x70) from the value of pid = *0xF_02_11*
>> based on PIDR1[7:4] and PIDR2[2:0]. This clears this as well.
>>
>> Please correct me if I am wrong and also let me know if I can
>> continue with PID addition to table.
> 
> Please proceed.
> 

Thanks Mathieu, posted the next version now.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
