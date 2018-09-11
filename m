Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724E9C43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 03:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D077206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 03:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LDsKv9u4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XyHi5qQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D077206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeIKIq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 04:46:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48584 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeIKIq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 04:46:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BBA9D608C1; Tue, 11 Sep 2018 03:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536637783;
        bh=Q91tNlquruQ5sePIkZ0X0fz5fLZs+7smm9OtnmsoRWk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LDsKv9u4WtdDHqDRijKA2CpYP6oewW4j2KReXtLbgTbymFnnIzUWUmUW6uDLEqLsE
         5JTt+F6PusFguqzlzplHCJzAa6A7SvzpmaGhxKE3zvjIEObnwR1Hb4QXxb2joZmHDB
         lnpy2+OChrmYETgpuWGnW8p24DpGw/rL/xIsByB0=
Received: from [10.204.110.203] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8DD7A607F4;
        Tue, 11 Sep 2018 03:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536637782;
        bh=Q91tNlquruQ5sePIkZ0X0fz5fLZs+7smm9OtnmsoRWk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XyHi5qQRTmnRoFNUnCgFU3UlAMyxkoMmsg4ALg6bAwfeU5Q+YPdHJ/Wc2F49sn2sC
         +koNSm9gdd5ICzCp1BC9rHh0SpTIZgKikTBTIpmh+bV4nOJ6ur2EOKiMZJeA61wrgN
         PP1NcXFxG3ENVzyUyXNkj66LYph7qLsyRgOOaAII=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8DD7A607F4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [PATCH v3 2/2] remoteproc: qcom: Introduce Non-PAS ADSP PIL
 driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     ohad@wizery.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org
References: <1535975560-8200-1-git-send-email-rohitkr@codeaurora.org>
 <1535975560-8200-3-git-send-email-rohitkr@codeaurora.org>
 <20180910183147.GE2523@minitux>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <55e95ff3-0aba-00d5-438a-89c191cfb366@codeaurora.org>
Date:   Tue, 11 Sep 2018 09:19:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910183147.GE2523@minitux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Bjorn for reviewing.


On 9/11/2018 12:01 AM, Bjorn Andersson wrote:
> On Mon 03 Sep 04:52 PDT 2018, Rohit kumar wrote:
>
>> This adds Non PAS ADSP PIL driver for Qualcomm
>> Technologies Inc SoCs.
>> Added initial support for SDM845 with ADSP bootup and
>> shutdown operation handled from Application Processor
>> SubSystem(APSS).
>>
>> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> Thanks for the changes Rohit, this looks good.
>
> Once we hear from DT maintainers that patch 1 can be applied I will
> update the name of the file and driver as I apply it to match the naming
> scheme I'm aiming for - no need for you to resend because of this.
Sure, I will just update dt-bindings with addressing some comments given 
by Rob.

>> ---
>>   drivers/remoteproc/Kconfig         |  14 ++
>>   drivers/remoteproc/Makefile        |   1 +
>>   drivers/remoteproc/qcom_adsp_pil.c | 500 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 515 insertions(+)
>>   create mode 100644 drivers/remoteproc/qcom_adsp_pil.c
>>
>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>> index c98c0b2..445de2d 100644
>> --- a/drivers/remoteproc/Kconfig
>> +++ b/drivers/remoteproc/Kconfig
>> @@ -139,6 +139,20 @@ config QCOM_Q6V5_WCSS
>>   	  Say y here to support the Qualcomm Peripheral Image Loader for the
>>   	  Hexagon V5 based WCSS remote processors.
>>   
>> +config QCOM_ADSP_PIL
> I will make this QCOM_Q6V5_ADSP
>
> [..]
>> diff --git a/drivers/remoteproc/qcom_adsp_pil.c b/drivers/remoteproc/qcom_adsp_pil.c
> Make this qcom_q6v5_adsp.c
>
> [..]
>> +static struct platform_driver adsp_pil_driver = {
>> +	.probe = adsp_probe,
>> +	.remove = adsp_remove,
>> +	.driver = {
>> +		.name = "qcom_adsp_pil",
> and this qcom_q6v5_adsp".
>
>> +		.of_match_table = adsp_of_match,
>> +	},
>> +};
> Please let me know if you have any objections to this.
Naming looks fine.

Thanks,
Rohit
> Regards,
> Bjorn

