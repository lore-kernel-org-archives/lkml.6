Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902E2C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A4E20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pJezpRW2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="U/tmy3/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A4E20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbeGYNfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:35:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51160 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbeGYNfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:35:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 273F1605BD; Wed, 25 Jul 2018 12:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532521442;
        bh=PgsZ4JvIqro1KS+tgAW3wTZWrc2OjaQTjRoaQk7P/ug=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pJezpRW2QmBRl02G6BVrCqnYfY5g7WAMDI/+lVWpRlOveNcRnW7VaC29CmgqB1wip
         Kl9FEiUGGXYdXV8BWUfz3aXEpJ2ljP2Bh42pyQjTJB2DeEcbwj0q01nUDJVmjUoChj
         Zdf1KhNSqjmKS30ARmW3NfeveoyRY7hSWEC/YFF4=
Received: from [10.206.25.25] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vviswana@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3BE1260481;
        Wed, 25 Jul 2018 12:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532521441;
        bh=PgsZ4JvIqro1KS+tgAW3wTZWrc2OjaQTjRoaQk7P/ug=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=U/tmy3/9cPRS4OzrUDZvvWvcPZJFWPCBlFHgKH2FWxKERTAEdR1nDRbK2QD+ieKtU
         HPFx03Wo9cwejOw7MAUuf7lJ2/hq7hUm5iAJTkVNJPgepBSkMCFwDaiEmp4RqoFb+0
         16PKQL3hiqLKHD/HhJSRifTllFZGY3ozzXWYcOew=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3BE1260481
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vviswana@codeaurora.org
Subject: Re: [PATCH V1 1/3] mmc: sdhci: Allow platform controlled voltage
 switching
To:     Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, evgreen@chromium.org, dianders@google.com,
        sayalil@codeaurora.org, rampraka@codeaurora.org
References: <1532083566-43215-1-git-send-email-vviswana@codeaurora.org>
 <1532083566-43215-2-git-send-email-vviswana@codeaurora.org>
 <33e12e51-4b96-032f-845f-7910d654018c@intel.com>
From:   Vijay Viswanath <vviswana@codeaurora.org>
Message-ID: <42ee57f7-8a99-b815-12db-2727ed67872b@codeaurora.org>
Date:   Wed, 25 Jul 2018 17:53:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <33e12e51-4b96-032f-845f-7910d654018c@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,


On 7/25/2018 5:23 PM, Adrian Hunter wrote:
> On 20/07/18 13:46, Vijay Viswanath wrote:
>> Some controllers can have internal mechanism to inform the SW that it
>> is ready for voltage switching. For such controllers, changing voltage
>> before the HW is ready can result in various issues.
>>
>> During setup/cleanup of host, check whether regulator enable/disable
>> was already done by platform driver.
>>
>> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>> ---
>>   drivers/mmc/host/sdhci.c | 21 ++++++++++++++++-----
>>   1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 1c828e0..494a1e2 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -3472,6 +3472,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>>   	unsigned int override_timeout_clk;
>>   	u32 max_clk;
>>   	int ret;
>> +	bool enable_vqmmc = false;
>>   
>>   	WARN_ON(host == NULL);
>>   	if (host == NULL)
>> @@ -3485,7 +3486,12 @@ int sdhci_setup_host(struct sdhci_host *host)
>>   	 * the host can take the appropriate action if regulators are not
>>   	 * available.
>>   	 */
>> -	ret = mmc_regulator_get_supply(mmc);
>> +	if (!mmc->supply.vmmc) {
>> +		ret = mmc_regulator_get_supply(mmc);
>> +		enable_vqmmc  = true;
>> +	} else {
>> +		ret = 0;
>> +	}
>>   	if (ret)
>>   		return ret;
> 
> Why not
> 
> 	if (!mmc->supply.vmmc) {
> 		ret = mmc_regulator_get_supply(mmc);
> 	  	if (ret)
>    			return ret;
> 		enable_vqmmc  = true;
> 	}
> 

looks neater. Will do.

>>   
>> @@ -3736,7 +3742,10 @@ int sdhci_setup_host(struct sdhci_host *host)
>>   
>>   	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
>>   	if (!IS_ERR(mmc->supply.vqmmc)) {
>> -		ret = regulator_enable(mmc->supply.vqmmc);
>> +		if (enable_vqmmc)
>> +			ret = regulator_enable(mmc->supply.vqmmc);
> 
> Please introduce host->vqmmc_enabled = !ret;
> 

Any reason to introduce vqmmc_enabled variable in sdhci_host structure ? 
We can get around with a local variable and using regulator_is_enabled API.

>> +		else
>> +			ret = 0;
>>   		if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
>>   						    1950000))
>>   			host->caps1 &= ~(SDHCI_SUPPORT_SDR104 |
>> @@ -3984,7 +3993,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>>   	return 0;
>>   
>>   unreg:
>> -	if (!IS_ERR(mmc->supply.vqmmc))
>> +	if (!IS_ERR(mmc->supply.vqmmc) && enable_vqmmc)
> 
> And just make this
> 
> 	if (host->vqmmc_enabled)
> 
>>   		regulator_disable(mmc->supply.vqmmc);
>>   undma:
>>   	if (host->align_buffer)
>> @@ -4002,7 +4011,8 @@ void sdhci_cleanup_host(struct sdhci_host *host)
>>   {
>>   	struct mmc_host *mmc = host->mmc;
>>   
>> -	if (!IS_ERR(mmc->supply.vqmmc))
>> +	if (!IS_ERR(mmc->supply.vqmmc) &&
>> +			(regulator_is_enabled(mmc->supply.vqmmc) > 0))
> 
> 	if (host->vqmmc_enabled)
> 
>>   		regulator_disable(mmc->supply.vqmmc);
>>   
>>   	if (host->align_buffer)
>> @@ -4135,7 +4145,8 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
>>   
>>   	tasklet_kill(&host->finish_tasklet);
>>   
>> -	if (!IS_ERR(mmc->supply.vqmmc))
>> +	if (!IS_ERR(mmc->supply.vqmmc) &&
>> +			(regulator_is_enabled(mmc->supply.vqmmc) > 0))
> 
> 	if (host->vqmmc_enabled)
> 
>>   		regulator_disable(mmc->supply.vqmmc);
>>   
>>   	if (host->align_buffer)
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Thanks,
Vijay
