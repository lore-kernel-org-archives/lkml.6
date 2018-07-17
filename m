Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2501AECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9957208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XyGAr17T";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Fd5IlWIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9957208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeGQFpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 01:45:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39384 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbeGQFpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 01:45:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 681B460B72; Tue, 17 Jul 2018 05:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531804498;
        bh=jdThji/Cif9t6qfB0B0pPha/Msv2XFSL+cObgORezaU=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=XyGAr17T+nCSbRz1VZzzoQFGHfgp1G+XrKFclogFvoKzGEGVVnZ8hMT2eHAp6JDnE
         HdebAxFrDWQd1YDkx7acUNH53Huul5G40PDUutkzrr4Yvczneu4XBQ6dhmhwzAjI/4
         5w0DjOxy2zPgk2mGfeOyn+G5hFL+hDSpfi3T1vps=
Received: from [10.252.222.164] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vviswana@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D6AC60274;
        Tue, 17 Jul 2018 05:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531804497;
        bh=jdThji/Cif9t6qfB0B0pPha/Msv2XFSL+cObgORezaU=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=Fd5IlWIn7gOaw0mHNVr0hLp5hgbu8PI/4/9HSN4ytZJqghjNk0cmd2cBJm6mnndbj
         kjdxheuoxzl12rzxtYget3ZgTxjY+JoD3ZyPdAAjbMVOt2nsrup+0+qIpiIlczOYIW
         S3HjgBoEHomhHxZKqGudpNGV//M9KcT96Wi3py6Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D6AC60274
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vviswana@codeaurora.org
From:   Vijay Viswanath <vviswana@codeaurora.org>
Subject: Re: [PATCH RFC 1/2] mmc: sdhci: Allow platform controlled voltage
 switching
To:     Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, dianders@google.com,
        sayalil@codeaurora.org, Evan Green <evgreen@chromium.org>
References: <1529583826-42020-1-git-send-email-vviswana@codeaurora.org>
 <1529583826-42020-2-git-send-email-vviswana@codeaurora.org>
 <53c6d61f-47f5-2e4e-8280-6f76f707799e@intel.com>
Message-ID: <0d9b1934-d80d-a726-8094-688c97474afa@codeaurora.org>
Date:   Tue, 17 Jul 2018 10:44:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <53c6d61f-47f5-2e4e-8280-6f76f707799e@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/2018 4:37 PM, Adrian Hunter wrote:
> On 21/06/18 15:23, Vijay Viswanath wrote:
>> Some controllers can have internal mechanism to inform the SW that it
>> is ready for voltage switching. For such controllers, changing voltage
>> before the HW is ready can result in various issues.
>>
>> Add a quirk, which can be used by drivers of such controllers.
>>
>> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>> ---
>>   drivers/mmc/host/sdhci.c | 20 +++++++++++++++-----
>>   drivers/mmc/host/sdhci.h |  2 ++
>>   2 files changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 1c828e0..f0346d4 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1615,7 +1615,8 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>>   void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>>   		     unsigned short vdd)
>>   {
>> -	if (IS_ERR(host->mmc->supply.vmmc))
>> +	if (IS_ERR(host->mmc->supply.vmmc) ||
>> +			(host->quirks2 & SDHCI_QUIRK2_INTERNAL_PWR_CTL))
> 
> I think you should provide your own ->set_power() instead of this
> 

will do

>>   		sdhci_set_power_noreg(host, mode, vdd);
>>   	else
>>   		sdhci_set_power_reg(host, mode, vdd);
>> @@ -2009,7 +2010,9 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>>   		ctrl &= ~SDHCI_CTRL_VDD_180;
>>   		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>>   
>> -		if (!IS_ERR(mmc->supply.vqmmc)) {
>> +		if (!IS_ERR(mmc->supply.vqmmc) &&
>> +				!(host->quirks2 &
>> +					SDHCI_QUIRK2_INTERNAL_PWR_CTL)) {
> 
> And your own ->start_signal_voltage_switch()
> 

sdhci_msm_start_signal_voltage_switch() would be an exact copy of 
sdhci_start_signal_voltage_switch()..... will incorporate this if not 
using quirk.

>>   			ret = mmc_regulator_set_vqmmc(mmc, ios);
>>   			if (ret) {
>>   				pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
>> @@ -2032,7 +2035,8 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>>   	case MMC_SIGNAL_VOLTAGE_180:
>>   		if (!(host->flags & SDHCI_SIGNALING_180))
>>   			return -EINVAL;
>> -		if (!IS_ERR(mmc->supply.vqmmc)) {
>> +		if (!IS_ERR(mmc->supply.vqmmc) &&
>> +			!(host->quirks2 & SDHCI_QUIRK2_INTERNAL_PWR_CTL)) {
>>   			ret = mmc_regulator_set_vqmmc(mmc, ios);
>>   			if (ret) {
>>   				pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
>> @@ -3485,7 +3489,10 @@ int sdhci_setup_host(struct sdhci_host *host)
>>   	 * the host can take the appropriate action if regulators are not
>>   	 * available.
>>   	 */
>> -	ret = mmc_regulator_get_supply(mmc);
>> +	if (!(host->quirks2 & SDHCI_QUIRK2_INTERNAL_PWR_CTL))
> 
> Since we expect mmc_regulator_get_supply() to have been called, this could be:
> 
> 	if (!mmc->supply.vmmc) {
> 		ret = mmc_regulator_get_supply(mmc);
> 		enable_vqmmc = true;
> 	} else {
> 		ret = 0;
> 	}
> >> +		ret = mmc_regulator_get_supply(mmc);
>> +	else
>> +		ret = 0;
>>   	if (ret)
>>   		return ret;
>>   
>> @@ -3736,7 +3743,10 @@ int sdhci_setup_host(struct sdhci_host *host)
>>   
>>   	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
>>   	if (!IS_ERR(mmc->supply.vqmmc)) {
>> -		ret = regulator_enable(mmc->supply.vqmmc);
>> +		if (!(host->quirks2 & SDHCI_QUIRK2_INTERNAL_PWR_CTL))
> 
> And this could be:
> 
> 		if (enable_vqmmc)
> 			ret = regulator_enable(mmc->supply.vqmmc);
> 		else
> 			ret = 0;
>  > However, you still need to ensure regulator_disable(mmc->supply.vqmmc) is
> only called if regulator_enable() was called.
I missed this. Will cover it.

Also I missed one more place where we are doing regulator_disable. 
During sdhci-msm unbinding, we would end up doing an extra regulator 
disable (thanks Evan for pointing it out) in sdhci_remove_host.

To avoid the quirk( or having any flag), it would require copying the 
code of sdhci_start_signal_voltage_switch() and sdhci_remove_host() and 
creating 2 new functions in sdhci_msm layer which would do the exact 
same as above, with just the regulator parts removed.

This looks messy (considering any future changes to the 2 sdhci API will 
need to be copied to their duplicate sdhci_msm API) and a bit overkill 
to avoid quirk. At the same time, I don't know how useful such a quirk 
would be to other platform drivers.

Please let me know your view/suggestions.
> 
>> +			ret = regulator_enable(mmc->supply.vqmmc);
>> +		else
>> +			ret = 0;
>>   		if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
>>   						    1950000))
>>   			host->caps1 &= ~(SDHCI_SUPPORT_SDR104 |
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 23966f8..3b0c97a 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -450,6 +450,8 @@ struct sdhci_host {
>>    * obtainable timeout.
>>    */
>>   #define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
>> +/* Regulator voltage changes are being done from platform layer */
>> +#define SDHCI_QUIRK2_INTERNAL_PWR_CTL				(1<<18)
> 
> So maybe the quirk is not needed.
> 
>>   
>>   	int irq;		/* Device IRQ */
>>   	void __iomem *ioaddr;	/* Mapped address */
>>
> 

Thanks for the review & suggestions!
Vijay
