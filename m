Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4468C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60F221470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JKfM5iF+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LKsAwFSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60F221470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeJMBmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:42:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38906 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbeJMBmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:42:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 873B760BFE; Fri, 12 Oct 2018 18:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539367708;
        bh=HPaRH2SCTiuRQ6MypohP49lkHMdsk9FCdVfJ1WNK8FE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JKfM5iF+9iFGSkiQfGDR+gow3yM+09+6HLhFJyv4232y1ZiDLBHt6ACdnSbdyRPNf
         +nItG7N3lcXzSM7WT6HCDHGAgDSrPFHjIZ6p27GqftIroa1vrw2VndlFv4g95BZT3o
         w0h8b8MlrG5cg0KR7k68r81mZaSD6bZijS+Qf/p4=
Received: from [192.168.1.3] (unknown [183.83.77.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7229A6060A;
        Fri, 12 Oct 2018 18:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539367707;
        bh=HPaRH2SCTiuRQ6MypohP49lkHMdsk9FCdVfJ1WNK8FE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LKsAwFSUd6oIqBrI7U/q8RGGSZBq/sYZzpTMOj2xh/5LgF8mv1MrLlFcBKDAfwvSt
         HBbsySTfNQAeP9M5I68EmOd5xKRFT1dN+EmZICswxFFsw/gv+fT3FCRziGSd/f3UKt
         PmlRvCsW1imsyfU6V9srLWelw/avV79eql70gp6E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7229A6060A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
Subject: Re: [PATCH RFC v1 5/8] dt-bindings: introduce cpu power domain
 bindings for Qualcomm SoCs
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        ulf.hansson@linaro.org, khilman@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-6-git-send-email-rplsssn@codeaurora.org>
 <20181011110849.GA32752@e107155-lin>
From:   Raju P L S S S N <rplsssn@codeaurora.org>
Message-ID: <d023628d-d130-d353-db5d-4c8a8e7be34e@codeaurora.org>
Date:   Fri, 12 Oct 2018 23:38:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011110849.GA32752@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2018 4:38 PM, Sudeep Holla wrote:
> On Thu, Oct 11, 2018 at 02:50:52AM +0530, Raju P.L.S.S.S.N wrote:
>> Add device binding documentation for Qualcomm Technology Inc's cpu
>> domain driver. The driver is used for managing system sleep activities
>> that are required when application processor is going to deepest low
>> power mode.
>>
> 
> So either we are not using PSCI or the binding is not so clear on
> how this co-exist with PSCI power domains. Could you provide details ?
> 
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
>> ---
>>   .../bindings/soc/qcom/cpu_power_domain.txt         | 39 ++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt b/Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt
>> new file mode 100644
>> index 0000000..1c8fe69
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt
>> @@ -0,0 +1,39 @@
>> +Qualcomm Technologies cpu power domain
>> +-----------------------------------------
>> +
>> +CPU power domain handles the tasks that need to be performed during
>> +application processor deeper low power mode entry for QCOM SoCs which
>> +have hardened IP blocks combinedly called as RPMH (Resource Power Manager
>> +Hardened) for shared resource management. Flushing the buffered requests
>> +to TCS (Triggered Command Set) in RSC (Resource State Coordinator) and
>> +programming the wakeup timer in PDC (Power Domain Controller) for timer
>> +based wakeup are handled as part of domain power down.
>> +
> 
> And which is this not hidden as part of PSCI CPU_SUSPEND ?
> 
>> +The bindings for cpu power domain is specified in the RSC section in
>> +devicetree.
>> +
>> +Properties:
>> +- compatible:
>> +	Usage: required
>> +	Value type: <string>
>> +	Definition: must be "qcom,cpu-pm-domain".
>> +
> 
> NACK until details on how this can co-exist with PSCI is provided.

Platform coordinated mode is used on this SoC. So they both can 
co-exist. I hope with the discussion on other thread, the details are clear.

> 
> --
> Regards,
> Sudeep
> 
