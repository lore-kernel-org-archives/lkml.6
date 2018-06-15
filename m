Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6D607C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 04:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134862086A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 04:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RNtR3yCP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QaFzK83M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134862086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755611AbeFOE5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 00:57:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46442 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755590AbeFOE4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 00:56:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CA224607E4; Fri, 15 Jun 2018 04:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529038613;
        bh=SCjTCwkDcKHGPJbEQOvLXIzIJkoEKE6e7obqn/3kzPI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RNtR3yCPzgh9Vto+0S0YLbQlKUHzvRTMejv9VULPE88B2YzGOHT1lvtw6DD0HP5u/
         gjZOBfxa/mzMoZ4Z3yExPGMfJhSzmyAe1XEIkqCY0Xc9nHw/fVLgBxPxHxIdXdqwz9
         R/iDaSMeDr+1q+iFqshN6/MpcErGBFyrIwZg3Xds=
Received: from [10.206.25.30] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vviswana@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5CBD960132;
        Fri, 15 Jun 2018 04:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529038612;
        bh=SCjTCwkDcKHGPJbEQOvLXIzIJkoEKE6e7obqn/3kzPI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QaFzK83MazL/m/Vo4PNyRyut4ks26fAllM20W3Uy5rcASkz4cSSTjd6vmtZGePjrS
         w44iyofUAUPcptGMA0qJNMEPxFZ9JRwXc8mvlnOTQjGFomFdqxX2f/StVN3Sj9lmXm
         e6KRqy8auddricV2o2ipRGaU/ECKNvBpKAqBUw7w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5CBD960132
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vviswana@codeaurora.org
Subject: Re: [PATCH V2 2/4] mmc: sdhci-msm: Add msm version specific ops and
 data structures
To:     Stephen Boyd <swboyd@chromium.org>, adrian.hunter@intel.com,
        mark.rutland@arm.com, robh+dt@kernel.org, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, dianders@google.com,
        sayalil@codeaurora.org
References: <1527587561-27448-1-git-send-email-vviswana@codeaurora.org>
 <1527587561-27448-3-git-send-email-vviswana@codeaurora.org>
 <152884658650.16708.8327586252448186103@swboyd.mtv.corp.google.com>
From:   Vijay Viswanath <vviswana@codeaurora.org>
Message-ID: <a6458995-a9ba-341e-425d-2092461d9626@codeaurora.org>
Date:   Fri, 15 Jun 2018 10:26:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <152884658650.16708.8327586252448186103@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 6/13/2018 5:06 AM, Stephen Boyd wrote:
> Quoting Vijay Viswanath (2018-05-29 02:52:39)
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 4050c99..2a66aa0 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -226,6 +226,24 @@ struct sdhci_msm_offset {
>>          .core_ddr_config_2 = 0x1bc,
>>   };
>>   
>> +struct sdhci_msm_variant_ops {
>> +       u8 (*msm_readb_relaxed)(struct sdhci_host *host, u32 offset);
>> +       u32 (*msm_readl_relaxed)(struct sdhci_host *host, u32 offset);
>> +       void (*msm_writeb_relaxed)(u8 val, struct sdhci_host *host, u32 offset);
>> +       void (*msm_writel_relaxed)(u32 val, struct sdhci_host *host,
>> +                       u32 offset);
>> +};
>> +
>> +/*
>> + * From V5, register spaces have changed. Wrap this info in a structure
>> + * and choose the data_structure based on version info mentioned in DT.
>> + */
> 
> This is sort of odd. Usually we have a read/write function that swizzles
> based on register variants, and that's contained with that function. Now
> it's the other way.
> 
>> +struct sdhci_msm_variant_info {
>> +       bool mci_removed;
>> +       const struct sdhci_msm_variant_ops *var_ops;
>> +       const struct sdhci_msm_offset *offset;
>> +};
>> +
>>   struct sdhci_msm_host {
>>          struct platform_device *pdev;
>>          void __iomem *core_mem; /* MSM SDCC mapped address */
>> @@ -245,8 +263,45 @@ struct sdhci_msm_host {
>>          wait_queue_head_t pwr_irq_wait;
>>          bool pwr_irq_flag;
>>          u32 caps_0;
>> +       bool mci_removed;
>> +       const struct sdhci_msm_variant_ops *var_ops;
>> +       const struct sdhci_msm_offset *offset;
>>   };
>>   
>> +/*
>> + * APIs to read/write to vendor specific registers which were there in the
>> + * core_mem region before MCI was removed.
>> + */
>> +static u32 sdhci_msm_mci_variant_readl_relaxed(struct sdhci_host *host,
>> +               u32 offset)
>> +{
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +
>> +       return readl_relaxed(msm_host->core_mem + offset);
> 
> Is core_mem assigned in the new hardware? Maybe that needs to be
> 'repurposed' for vendor specific registers on v5 and renamed to
> something like msm_host::vendor_base or something like that.
> 

There is no core_mem in the new hardware. We can assign hc_mem address 
to core_mem variable (if SDCC5) and do away with the need of special 
read/write functions, but I feel thats a bad approach and misleading.

>> +}
>> +
>> +static u32 sdhci_msm_v5_variant_readl_relaxed(struct sdhci_host *host,
>> +               u32 offset)
>> +{
>> +       return readl_relaxed(host->ioaddr + offset);
>> +}
>> +
>> +static void sdhci_msm_mci_variant_writel_relaxed(u32 val,
>> +               struct sdhci_host *host, u32 offset)
>> +{
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +
>> +       writel_relaxed(val, msm_host->core_mem + offset);
>> +}
>> +
>> +static void sdhci_msm_v5_variant_writel_relaxed(u32 val,
>> +               struct sdhci_host *host, u32 offset)
>> +{
>> +       writel_relaxed(val, host->ioaddr + offset);
>> +}
>> +
>>   static unsigned int msm_get_clock_rate_for_bus_mode(struct sdhci_host *host,
>>                                                      unsigned int clock)
>>   {
>> @@ -1481,6 +1536,28 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
>>          pr_debug("%s: supported caps: 0x%08x\n", mmc_hostname(mmc), caps);
>>   }
>>   
>> +static const struct sdhci_msm_variant_ops mci_var_ops = {
>> +       .msm_readl_relaxed = sdhci_msm_mci_variant_readl_relaxed,
>> +       .msm_writel_relaxed = sdhci_msm_mci_variant_writel_relaxed,
>> +};
>> +
>> +static const struct sdhci_msm_variant_ops v5_var_ops = {
>> +       .msm_readl_relaxed = sdhci_msm_v5_variant_readl_relaxed,
>> +       .msm_writel_relaxed = sdhci_msm_v5_variant_writel_relaxed,
>> +};
>> +
>> +static const struct sdhci_msm_variant_info sdhci_msm_mci_var = {
>> +       .mci_removed = 0,
> 
> Please use true and false instead of 0 and 1 when the type is bool.
>

Will do

>> +       .var_ops = &mci_var_ops,
>> +       .offset = &sdhci_msm_mci_offset,
>> +};
>> +
>> +static const struct sdhci_msm_variant_info sdhci_msm_v5_var = {
>> +       .mci_removed = 1,
>> +       .var_ops = &v5_var_ops,
>> +       .offset = &sdhci_msm_v5_offset,
>> +};
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
