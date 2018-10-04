Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31ADEC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0A620877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fgj/Gt4q";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W5BRbqD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0A620877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeJEBWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:22:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41874 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeJEBWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:22:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7635E60BE8; Thu,  4 Oct 2018 18:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538677666;
        bh=JWvSM42PiT9OEfLKlK3iMamWi3yLC4q1BdBb4WnMSR4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fgj/Gt4qO1qDrWO/j759j3N6S5nQ5psG1gC4tSFcPB1u3q5dN5v/45QKCkpKx4Ha9
         G/KfSFPrZtiwsWPMqgIWbsD1xufZQrh/gDuZY5gaUHOMzNrgZ47f1Ahyfmn0tG/Zvk
         adsYA/Zb12fo6Hzk9ZnwoUehzvx/irev1ODQZ33s=
Received: from [10.79.40.96] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B50D460BE8;
        Thu,  4 Oct 2018 18:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538677665;
        bh=JWvSM42PiT9OEfLKlK3iMamWi3yLC4q1BdBb4WnMSR4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W5BRbqD7nM1d1SizNAaQP8xNjDuvEl9+OcrAoXCJTYjjdar9ZKnQnDRKnsGERAbVJ
         lvR4oVVhEDWrfl+/Azo+BkxLo8AM2S10u42KPpEEJtgqV8z+em5drzxJ0GTEyMV9Sl
         lF6ljdXJPwSFFLKllsVRexnpFwCv4WR0OBDoViPA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B50D460BE8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v3 0/6] Add support for PDC Global on SDM845 SoCs
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        p.zabel@pengutronix.de
Cc:     mka@chromium.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
References: <20180829191215.10071-1-sibis@codeaurora.org>
 <20180903193647.GJ3456@tuxbook-pro>
From:   Sibi Sankar <sibis@codeaurora.org>
Message-ID: <2ae729fe-321b-0918-a06c-d04e43b47101@codeaurora.org>
Date:   Thu, 4 Oct 2018 23:57:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903193647.GJ3456@tuxbook-pro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Phillip,

Will the PDC driver make the cut for reset/next this time for the
4.20rc?

On 09/04/2018 01:06 AM, Bjorn Andersson wrote:
> On Wed 29 Aug 12:12 PDT 2018, Sibi Sankar wrote:
> 
>> This patch series add support for PDC Global (Power Domain Controller)
>> on SDM845 SoCs and adds pdc reset lines assert/deassert to remoteproc
>> Q6v5 modem-pil. The first two patches adds PDC Global reset driver to
>> control reset signals of Modem, Compute, Display, GPU, Debug, AOP,
>> Sensors, Audio, SP and APPS. The last four patches (cleans up)/adds pdc
>> reset lines to q6v5 bindings and asserts/deasserts in modem start/stop
>> path.
>>
>> V3:
>>    refactored pdc reset driver to remove unused layer of indirection
>>    as suggested by Matthias
>>    Other minor fixes suggested by Matthias/Bjorn
>>
>> V2:
>>    Incorporated Philipp/Bjorn/Rob suggestions
>>    Renamed reset binding to pdc-global.txt
>>    replaced offset with #define of register name
>>    replaced with devm_reset_control_get_exclusive()
>>    Separted dt binding from the drivers
>>
>> Sibi Sankar (6):
>>    dt-bindings: reset: Add PDC Global binding for SDM845 SoCs
>>    reset: qcom: PDC Global (Power Domain Controller) reset controller
> 
> Philipp, there's no compile time dependencies between the PDC and
> remoteproc patches in this series. Will you take these two through your
> tree and I'll take the remaining four through the remoteproc tree?
> 
> Regards,
> Bjorn
> 
>>    dt-bindings: remoteproc: qcom: Remove additional definition tag
>>    dt-bindings: remoteproc: Add PDC reset binding for Q6V5 PIL
>>    remoteproc: qcom: q6v5-pil: Explicitly get mss_restart line
>>    remoteproc: qcom: q6v5-pil: Add PDC reset for modem on SDM845 SoCs
>>
>>   .../bindings/remoteproc/qcom,q6v5.txt         |   8 +-
>>   .../bindings/reset/qcom,pdc-global.txt        |  52 ++++++++
>>   drivers/remoteproc/qcom_q6v5_pil.c            |  31 ++++-
>>   drivers/reset/Kconfig                         |   9 ++
>>   drivers/reset/Makefile                        |   1 +
>>   drivers/reset/reset-qcom-pdc.c                | 124 ++++++++++++++++++
>>   include/dt-bindings/reset/qcom,sdm845-pdc.h   |  20 +++
>>   7 files changed, 237 insertions(+), 8 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/reset/qcom,pdc-global.txt
>>   create mode 100644 drivers/reset/reset-qcom-pdc.c
>>   create mode 100644 include/dt-bindings/reset/qcom,sdm845-pdc.h
>>
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
