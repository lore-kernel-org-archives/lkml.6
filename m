Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60DEC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9AFD20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9AFD20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeILPfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:35:00 -0400
Received: from foss.arm.com ([217.140.101.70]:57210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbeILPfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:35:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2320B7A9;
        Wed, 12 Sep 2018 03:31:05 -0700 (PDT)
Received: from [10.4.13.23] (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 346023F614;
        Wed, 12 Sep 2018 03:31:03 -0700 (PDT)
Subject: Re: [PATCH 04/11] dts: qcom: Update coresight bindings for hardware
 ports
To:     leo.yan@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        arm@kernel.org, sudeep.holla@arm.com,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "Ivan T . Ivanov" <ivan.ivanov@linaro.org>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
 <1536661032-30481-5-git-send-email-suzuki.poulose@arm.com>
 <20180912101753.GB3353@leoy-ThinkPad-X240s>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <98004d69-8be3-ab3f-b622-92236489e9c2@arm.com>
Date:   Wed, 12 Sep 2018 11:31:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912101753.GB3353@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 12/09/18 11:17, leo.yan@linaro.org wrote:
> Hi Suzuki,
> 
> On Tue, Sep 11, 2018 at 11:17:05AM +0100, Suzuki K Poulose wrote:
>> Switch to updated coresight bindings for hw ports
>>
>> Cc: Andy Gross <andy.gross@linaro.org>
>> Cc: David Brown <david.brown@linaro.org>
>> Cc: Ivan T. Ivanov <ivan.ivanov@linaro.org>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/msm8916.dtsi | 98 ++++++++++++++++++++++-------------
>>   1 file changed, 63 insertions(+), 35 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
>> index 7b32b89..5bed52b 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
>> @@ -1099,10 +1099,11 @@
>>   			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>>   			clock-names = "apb_pclk", "atclk";
>>   
>> -			port {
>> -				tpiu_in: endpoint {
>> -					slave-mode;
>> -					remote-endpoint = <&replicator_out1>;
>> +			out-ports {
> 
> Here should be in-ports for tpiu node?
> 
> BTW, if upper comment is valid, this means the DT binding doc also
> gives wrong example for tpiu node [1].

You are right on both counts.

> 
> I tested this patch with upper changing to 'in-ports', etm with perf
> mode can work well on DB410c board.
> 

Thanks a lot for the testing. I will fix both the problems.

Suzuki
