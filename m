Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 90B09C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 05:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438552086A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 05:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S6HVgI6B";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IK50Zl0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438552086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755686AbeFOFox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 01:44:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34644 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755563AbeFOFov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 01:44:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 65E7260116; Fri, 15 Jun 2018 05:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529041490;
        bh=MTDFZ54X4aS0x461rDWnSOFSNFq+PxsezZCM+v2ORxQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S6HVgI6BZoFlGarg6gSD9UuKBKh7qA2rVZtKP0f1BWazGKZ6iXe+Nq0sHsDnFYW+G
         lBYGq2KnyCXQ+9+LZ/SJ/YHG7EaEy1CtBDE5PUodNTzqqSMDMFBNj+s7gn+k3bN+Se
         5nN3tGUFIdi8UGvctctMEBZF5mOvkhSZtzuiBNXQ=
Received: from [10.206.25.30] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vviswana@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C942160116;
        Fri, 15 Jun 2018 05:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529041489;
        bh=MTDFZ54X4aS0x461rDWnSOFSNFq+PxsezZCM+v2ORxQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IK50Zl0L478qB61dz9VEjMkHICtYApcDNgpMAvYHp3BjNP6W4vDIW3P7Zo+hPF/yG
         zjvMqmQrQaqVmfI3WGnZYBUsvdQKDJZLIx7icFi7zBhlB1q6nMPnh2CVCb+mq+2UbN
         7hTlmK1Gik1QXcuR69Y9Mws2Guxzoh1bO1YHhAz4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C942160116
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vviswana@codeaurora.org
Subject: Re: [PATCH V2 4/4] mmc: host: Register changes for sdcc V5
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
 <1527587561-27448-5-git-send-email-vviswana@codeaurora.org>
 <152884592336.16708.2751337614926643627@swboyd.mtv.corp.google.com>
From:   Vijay Viswanath <vviswana@codeaurora.org>
Message-ID: <4a215e3a-16af-4574-efca-0ebe5960705a@codeaurora.org>
Date:   Fri, 15 Jun 2018 11:14:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <152884592336.16708.2751337614926643627@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/2018 4:55 AM, Stephen Boyd wrote:
> Quoting Vijay Viswanath (2018-05-29 02:52:41)
>> @@ -137,6 +125,12 @@
>>   /* Timeout value to avoid infinite waiting for pwr_irq */
>>   #define MSM_PWR_IRQ_TIMEOUT_MS 5000
>>   
>> +#define MSM_HOST_READL(msm_host, host, offset) \
>> +       msm_host->var_ops->msm_readl_relaxed(host, offset)
>> +
>> +#define MSM_HOST_WRITEL(msm_host, val, host, offset) \
>> +       msm_host->var_ops->msm_writel_relaxed(val, host, offset)
> 
> Is there a reason these macros are capitalized? We don't have READL and
> WRITEL macros in the kernel because function-like macros are typically
> lowercase.
> 

will change them to lower case. Didn't notice that...

>> +
>>   struct sdhci_msm_offset {
>>          u32 core_hc_mode;
>>          u32 core_mci_data_cnt;
>> @@ -268,6 +262,14 @@ struct sdhci_msm_host {
>>          const struct sdhci_msm_offset *offset;
>>   };
>>   
>> +const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
> 
> static?
> 

will do

>> +{
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +
>> +       return msm_host->offset;
>> +}
>> +
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
