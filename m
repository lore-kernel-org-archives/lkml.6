Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A904C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44CB2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q/mHg9vK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cX2eLMfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44CB2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391114AbeHPNmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 09:42:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35114 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731031AbeHPNmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 09:42:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5044961D8E; Thu, 16 Aug 2018 10:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534416276;
        bh=JXNgaDG3g9gKpoTBTRJ5xAo+3UlfmEqWiVEtd8KVBIk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Q/mHg9vK4OPxa4lMsl8gli5pc3WINrLr2mTnqdlyVRJoyAIZn1fbtpYXph8u+qZjz
         qBbVyFQev/EVzSUSD1piZ3NoPWuJoLmHLh4IGDazo8IwAUw6R0NJdt2EEdsCSWUD33
         9zmfpNUnSI/zilbktytGK8TJA4gOOURO0zmV/vPM=
Received: from [10.206.24.124] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1DCA761FE9;
        Thu, 16 Aug 2018 10:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534416275;
        bh=JXNgaDG3g9gKpoTBTRJ5xAo+3UlfmEqWiVEtd8KVBIk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cX2eLMfuzmgDOjkV+SZW3tbzuGKguqvd/QR5ChViJwEttbxC7p7ko6YhvGhL69XjN
         Usr06XqKo3E5w8NZdHWzEkcz8PM38C7y6jppSB/SuIcPD6Ui1jnEBNBW01k0XJpTjW
         ypjp9wTsOm0D3mMg37f1977yDUNHOBZQnQgbZ5nk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1DCA761FE9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
Subject: Re: [PATCH V8 1/2] scsi: ufs: set the device reference clock setting
To:     Adrian Hunter <adrian.hunter@intel.com>, subhashj@codeaurora.org,
        cang@codeaurora.org, vivek.gautam@codeaurora.org,
        rnayak@codeaurora.org, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        asutoshd@codeaurora.org, evgreen@chromium.org,
        riteshh@codeaurora.org
Cc:     linux-scsi@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
References: <1533805799-5831-1-git-send-email-sayalil@codeaurora.org>
 <1533805799-5831-2-git-send-email-sayalil@codeaurora.org>
 <4efbbb33-95ec-c631-57d4-ca9898e6d475@intel.com>
From:   Sayali Lokhande <sayalil@codeaurora.org>
Message-ID: <1756f41e-6280-8a14-bc83-e4dab8fa4d9c@codeaurora.org>
Date:   Thu, 16 Aug 2018 16:14:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4efbbb33-95ec-c631-57d4-ca9898e6d475@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/13/2018 6:06 PM, Adrian Hunter wrote:
> On 09/08/18 12:09, Sayali Lokhande wrote:
>> From: Subhash Jadavani <subhashj@codeaurora.org>
>>
>> UFS host supplies the reference clock to UFS device and UFS device
>> specification allows host to provide one of the 4 frequencies (19.2 MHz,
>> 26 MHz, 38.4 MHz, 52 MHz) for reference clock. Host should set the
>> device reference clock frequency setting in the device based on what
>> frequency it is supplying to UFS device.
>>
>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>> Signed-off-by: Can Guo <cang@codeaurora.org>
>> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
>> ---
>>   drivers/scsi/ufs/ufs.h           | 21 ++++++++++
>>   drivers/scsi/ufs/ufshcd-pltfrm.c |  2 +
>>   drivers/scsi/ufs/ufshcd.c        | 89 ++++++++++++++++++++++++++++++++++++++++
>>   drivers/scsi/ufs/ufshcd.h        |  2 +
>>   4 files changed, 114 insertions(+)
>>
>> diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
>> index 14e5bf7..c555ac0 100644
>> --- a/drivers/scsi/ufs/ufs.h
>> +++ b/drivers/scsi/ufs/ufs.h
>> @@ -378,6 +378,27 @@ enum query_opcode {
>>   	UPIU_QUERY_OPCODE_TOGGLE_FLAG	= 0x8,
>>   };
>>   
>> +/* bRefClkFreq attribute values */
>> +enum ref_clk_freq_hz {
>> +	REF_CLK_FREQ_19_2_MHZ	= 19200000,
>> +	REF_CLK_FREQ_26_MHZ	= 26000000,
>> +	REF_CLK_FREQ_38_4_MHZ	= 38400000,
>> +	REF_CLK_FREQ_52_MHZ	= 52000000,
>> +};
>> +
>> +enum bref_clk_freq {
>> +	bREF_CLK_FREQ_0, /* 19.2 MHz */
>> +	bREF_CLK_FREQ_1, /* 26 MHz */
>> +	bREF_CLK_FREQ_2, /* 38.4 MHz */
>> +	bREF_CLK_FREQ_3, /* 52 MHz */
>> +	bREF_CLK_FREQ_INVAL,
>> +};
>> +
>> +struct ufs_ref_clk {
>> +	enum ref_clk_freq_hz freq_hz;
>> +	enum bref_clk_freq val;
>> +};
>> +
>>   /* Query response result code */
>>   enum {
>>   	QUERY_RESULT_SUCCESS                    = 0x00,
>> diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
>> index e82bde0..0953563 100644
>> --- a/drivers/scsi/ufs/ufshcd-pltfrm.c
>> +++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
>> @@ -343,6 +343,8 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
>>   	pm_runtime_set_active(&pdev->dev);
>>   	pm_runtime_enable(&pdev->dev);
>>   
>> +	ufshcd_parse_dev_ref_clk_freq(hba);
>> +
>>   	ufshcd_init_lanes_per_dir(hba);
>>   
>>   	err = ufshcd_init(hba, mmio_base, irq);
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> index c5b1bf1..0cbdde7 100644
>> --- a/drivers/scsi/ufs/ufshcd.c
>> +++ b/drivers/scsi/ufs/ufshcd.c
>> @@ -6296,6 +6296,89 @@ static void ufshcd_def_desc_sizes(struct ufs_hba *hba)
>>   	hba->desc_size.hlth_desc = QUERY_DESC_HEALTH_DEF_SIZE;
>>   }
>>   
>> +static struct ufs_ref_clk ufs_ref_clk_freqs[] = {
>> +	{REF_CLK_FREQ_19_2_MHZ, bREF_CLK_FREQ_0},
>> +	{REF_CLK_FREQ_26_MHZ, bREF_CLK_FREQ_1},
>> +	{REF_CLK_FREQ_38_4_MHZ, bREF_CLK_FREQ_2},
>> +	{REF_CLK_FREQ_52_MHZ, bREF_CLK_FREQ_3},
>> +};
>> +
>> +static inline enum bref_clk_freq
>> +ufs_get_bref_clk_for_ref_clk_freq_hz(u32 freq)
>> +{
>> +	enum bref_clk_freq val;
>> +
>> +	for (val = bREF_CLK_FREQ_0; val <= bREF_CLK_FREQ_3; val++)
>> +		if (ufs_ref_clk_freqs[val].freq_hz == freq)
>> +			return val;
>> +
>> +	/* if no match found, return invalid*/
>> +	return bREF_CLK_FREQ_INVAL;
>> +}
>> +
>> +void ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba)
>> +{
>> +	struct device *dev = hba->dev;
>> +	struct device_node *np = dev->of_node;
>> +	struct clk *refclk = NULL;
>> +	u32 freq = 0;
>> +
>> +	if (!np)
>> +		return;
>> +
>> +	hba->dev_ref_clk_freq = bREF_CLK_FREQ_INVAL;
>> +
>> +	refclk = of_clk_get_by_name(np, "ref_clk");
> What about users that don't use DT?
If there is no DT entry present for ref_clk, we simply set to 
bREF_CLK_FREQ_INVAL and thus ref clk will not be changed. It will 
maintain the Manufacturer default value whatever is set by the ufs 
device vendor.
>
>> +	if (!refclk)
>> +		return;
>> +
>> +	freq = clk_get_rate(refclk);
>> +	if (freq > REF_CLK_FREQ_52_MHZ) {
>> +		dev_err(hba->dev,
>> +		"%s: invalid ref_clk setting = %d\n",
>> +		__func__, freq);
>> +		return;
>> +	}
>> +
>> +	hba->dev_ref_clk_freq =
>> +		ufs_get_bref_clk_for_ref_clk_freq_hz(freq);
>> +}
>> +
>> +static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba)
>> +{
>> +	int err = 0;
>> +	int ref_clk = -1;
>> +
>> +	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
>> +			QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0, &ref_clk);
>> +
>> +	if (err) {
>> +		dev_err(hba->dev, "%s: failed reading bRefClkFreq. err = %d\n",
>> +			 __func__, err);
>> +		goto out;
>> +	}
>> +
>> +	if (ref_clk == hba->dev_ref_clk_freq)
>> +		goto out; /* nothing to update */
>> +
>> +	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
>> +			QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0,
>> +			&hba->dev_ref_clk_freq);
>> +
>> +	if (err)
>> +		dev_err(hba->dev, "%s: bRefClkFreq setting to %d Hz failed\n",
>> +		__func__, ufs_ref_clk_freqs[hba->dev_ref_clk_freq].freq_hz);
>> +	/*
>> +	 * It is good to print this out here to debug any later failures
>> +	 * related to gear switch.
>> +	 */
>> +	dev_dbg(hba->dev, "%s: bRefClkFreq setting to %d Hz succeeded\n",
>> +		__func__, ufs_ref_clk_freqs[hba->dev_ref_clk_freq].freq_hz);
>> +
>> +out:
>> +	return err;
>> +}
>> +
>>   /**
>>    * ufshcd_probe_hba - probe hba to detect device and initialize
>>    * @hba: per-adapter instance
>> @@ -6361,6 +6444,12 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
>>   			"%s: Failed getting max supported power mode\n",
>>   			__func__);
>>   	} else {
>> +		/*
>> +		 * Set the right value to bRefClkFreq before attempting to
>> +		 * switch to HS gears.
>> +		 */
>> +		if (hba->dev_ref_clk_freq < bREF_CLK_FREQ_INVAL)
> hba->dev_ref_clk_freq does not always get initialized
In ufshcd_parse_dev_ref_clk_freq() function we are initializing the 
hba->dev_ref_clk_freqto inval as default. This parse function will be 
always called in init and thus dev_ref_clk_freq should always get 
initialized to defult inval or valid setting if found (in between 19.2 
MHz to 52MHz).
>
>> +			ufshcd_set_dev_ref_clk(hba);
>>   		ret = ufshcd_config_pwr_mode(hba, &hba->max_pwr_info.info);
>>   		if (ret) {
>>   			dev_err(hba->dev, "%s: Failed setting power mode, err = %d\n",
>> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
>> index 8110dcd..101a75c 100644
>> --- a/drivers/scsi/ufs/ufshcd.h
>> +++ b/drivers/scsi/ufs/ufshcd.h
>> @@ -548,6 +548,7 @@ struct ufs_hba {
>>   	void *priv;
>>   	unsigned int irq;
>>   	bool is_irq_enabled;
>> +	u32 dev_ref_clk_freq;
>>   
>>   	/* Interrupt aggregation support is broken */
>>   	#define UFSHCD_QUIRK_BROKEN_INTR_AGGR			0x1
>> @@ -746,6 +747,7 @@ static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
>>   int ufshcd_wait_for_register(struct ufs_hba *hba, u32 reg, u32 mask,
>>   				u32 val, unsigned long interval_us,
>>   				unsigned long timeout_ms, bool can_sleep);
>> +void ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba);
>>   
>>   static inline void check_upiu_size(void)
>>   {
>>

