Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8806FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486B1213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486B1213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbeKZVf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:35:29 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:26384 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726177AbeKZVf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:35:29 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wAQAd6t0010031;
        Mon, 26 Nov 2018 11:41:05 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2nxvnaja9q-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 26 Nov 2018 11:41:05 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A5CA725B;
        Mon, 26 Nov 2018 11:40:33 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 48C3B2778;
        Mon, 26 Nov 2018 10:41:02 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.47) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 26 Nov
 2018 11:41:01 +0100
Subject: Re: [PATCH 1/3] iio: adc: stm32-adc: move self-calibration to prepare
 routine
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1542708752-26163-1-git-send-email-fabrice.gasnier@st.com>
 <1542708752-26163-2-git-send-email-fabrice.gasnier@st.com>
 <20181125130339.61430399@archlinux> <20181125131426.07055b30@archlinux>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <e65c0f72-6270-1381-597b-9c100d9a189a@st.com>
Date:   Mon, 26 Nov 2018 11:41:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181125131426.07055b30@archlinux>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-26_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/18 2:14 PM, Jonathan Cameron wrote:
> On Sun, 25 Nov 2018 13:03:39 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> On Tue, 20 Nov 2018 11:12:30 +0100
>> Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>>
>>> Move self-calibration routine to prepare routine.
>>> - This is precursor patch to ease power management handling.
>>> - This also allow to factorize few error cases (error handling).
>>>
>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>  
>> one trivial point inline.  Otherwise seems a sensible bit of refactoring.
> Given this was the only 'issue' I found in the whole set I've
> just applied it with that changed.

Hi Jonathan,

Many thanks.

Best Regards,
Fabrice
> 
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.
> 
> Thanks,
> 
> Jonathan
> 
>>
>> Thanks,
>>
>> Jonathan
>>
>>> ---
>>>  drivers/iio/adc/stm32-adc.c | 59 ++++++++++++++++++---------------------------
>>>  1 file changed, 24 insertions(+), 35 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
>>> index 3784118..dca8733 100644
>>> --- a/drivers/iio/adc/stm32-adc.c
>>> +++ b/drivers/iio/adc/stm32-adc.c
>>> @@ -199,11 +199,13 @@ struct stm32_adc_trig_info {
>>>   * @calfact_s: Calibration offset for single ended channels
>>>   * @calfact_d: Calibration offset in differential
>>>   * @lincalfact: Linearity calibration factor
>>> + * @calibrated: Indicates calibration status
>>>   */
>>>  struct stm32_adc_calib {
>>>  	u32			calfact_s;
>>>  	u32			calfact_d;
>>>  	u32			lincalfact[STM32H7_LINCALFACT_NUM];
>>> +	bool			calibrated;
>>>  };
>>>  
>>>  /**
>>> @@ -251,7 +253,6 @@ struct stm32_adc_regspec {
>>>   * @trigs:		external trigger sources
>>>   * @clk_required:	clock is required
>>>   * @has_vregready:	vregready status flag presence
>>> - * @selfcalib:		optional routine for self-calibration
>>>   * @prepare:		optional prepare routine (power-up, enable)
>>>   * @start_conv:		routine to start conversions
>>>   * @stop_conv:		routine to stop conversions
>>> @@ -264,7 +265,6 @@ struct stm32_adc_cfg {
>>>  	struct stm32_adc_trig_info	*trigs;
>>>  	bool clk_required;
>>>  	bool has_vregready;
>>> -	int (*selfcalib)(struct stm32_adc *);
>>>  	int (*prepare)(struct stm32_adc *);
>>>  	void (*start_conv)(struct stm32_adc *, bool dma);
>>>  	void (*stop_conv)(struct stm32_adc *);
>>> @@ -777,6 +777,7 @@ static void stm32h7_adc_disable(struct stm32_adc *adc)
>>>  /**
>>>   * stm32h7_adc_read_selfcalib() - read calibration shadow regs, save result
>>>   * @adc: stm32 adc instance
>>> + * Note: Must be called once ADC is enabled, so LINCALRDYW[1..6] are writable
>>>   */
>>>  static int stm32h7_adc_read_selfcalib(struct stm32_adc *adc)
>>>  {
>>> @@ -784,11 +785,6 @@ static int stm32h7_adc_read_selfcalib(struct stm32_adc *adc)
>>>  	int i, ret;
>>>  	u32 lincalrdyw_mask, val;
>>>  
>>> -	/* Enable adc so LINCALRDYW1..6 bits are writable */
>>> -	ret = stm32h7_adc_enable(adc);
>>> -	if (ret)
>>> -		return ret;
>>> -
>>>  	/* Read linearity calibration */
>>>  	lincalrdyw_mask = STM32H7_LINCALRDYW6;
>>>  	for (i = STM32H7_LINCALFACT_NUM - 1; i >= 0; i--) {
>>> @@ -801,7 +797,7 @@ static int stm32h7_adc_read_selfcalib(struct stm32_adc *adc)
>>>  						   100, STM32_ADC_TIMEOUT_US);
>>>  		if (ret) {
>>>  			dev_err(&indio_dev->dev, "Failed to read calfact\n");
>>> -			goto disable;
>>> +			return ret;
>>>  		}
>>>  
>>>  		val = stm32_adc_readl(adc, STM32H7_ADC_CALFACT2);
>>> @@ -817,11 +813,9 @@ static int stm32h7_adc_read_selfcalib(struct stm32_adc *adc)
>>>  	adc->cal.calfact_s >>= STM32H7_CALFACT_S_SHIFT;
>>>  	adc->cal.calfact_d = (val & STM32H7_CALFACT_D_MASK);
>>>  	adc->cal.calfact_d >>= STM32H7_CALFACT_D_SHIFT;
>>> +	adc->cal.calibrated = true;
>>>  
>>> -disable:
>>> -	stm32h7_adc_disable(adc);
>>> -
>>> -	return ret;
>>> +	return 0;
>>>  }
>>>  
>>>  /**
>>> @@ -898,9 +892,9 @@ static int stm32h7_adc_restore_selfcalib(struct stm32_adc *adc)
>>>  #define STM32H7_ADC_CALIB_TIMEOUT_US		100000
>>>  
>>>  /**
>>> - * stm32h7_adc_selfcalib() - Procedure to calibrate ADC (from power down)
>>> + * stm32h7_adc_selfcalib() - Procedure to calibrate ADC
>>>   * @adc: stm32 adc instance
>>> - * Exit from power down, calibrate ADC, then return to power down.
>>> + * Note: Must be called once ADC is out of power down.
>>>   */
>>>  static int stm32h7_adc_selfcalib(struct stm32_adc *adc)
>>>  {
>>> @@ -908,9 +902,8 @@ static int stm32h7_adc_selfcalib(struct stm32_adc *adc)
>>>  	int ret;
>>>  	u32 val;
>>>  
>>> -	ret = stm32h7_adc_exit_pwr_down(adc);
>>> -	if (ret)
>>> -		return ret;
>>> +	if (adc->cal.calibrated)
>>> +		return adc->cal.calibrated;  
>> return true seems more logical given this is a boolean.
>>
>>>  
>>>  	/*
>>>  	 * Select calibration mode:
>>> @@ -927,7 +920,7 @@ static int stm32h7_adc_selfcalib(struct stm32_adc *adc)
>>>  					   STM32H7_ADC_CALIB_TIMEOUT_US);
>>>  	if (ret) {
>>>  		dev_err(&indio_dev->dev, "calibration failed\n");
>>> -		goto pwr_dwn;
>>> +		goto out;
>>>  	}
>>>  
>>>  	/*
>>> @@ -944,18 +937,13 @@ static int stm32h7_adc_selfcalib(struct stm32_adc *adc)
>>>  					   STM32H7_ADC_CALIB_TIMEOUT_US);
>>>  	if (ret) {
>>>  		dev_err(&indio_dev->dev, "calibration failed\n");
>>> -		goto pwr_dwn;
>>> +		goto out;
>>>  	}
>>>  
>>> +out:
>>>  	stm32_adc_clr_bits(adc, STM32H7_ADC_CR,
>>>  			   STM32H7_ADCALDIF | STM32H7_ADCALLIN);
>>>  
>>> -	/* Read calibration result for future reference */
>>> -	ret = stm32h7_adc_read_selfcalib(adc);
>>> -
>>> -pwr_dwn:
>>> -	stm32h7_adc_enter_pwr_down(adc);
>>> -
>>>  	return ret;
>>>  }
>>>  
>>> @@ -972,19 +960,28 @@ static int stm32h7_adc_selfcalib(struct stm32_adc *adc)
>>>   */
>>>  static int stm32h7_adc_prepare(struct stm32_adc *adc)
>>>  {
>>> -	int ret;
>>> +	int calib, ret;
>>>  
>>>  	ret = stm32h7_adc_exit_pwr_down(adc);
>>>  	if (ret)
>>>  		return ret;
>>>  
>>> +	ret = stm32h7_adc_selfcalib(adc);
>>> +	if (ret < 0)
>>> +		goto pwr_dwn;
>>> +	calib = ret;
>>> +
>>>  	stm32_adc_writel(adc, STM32H7_ADC_DIFSEL, adc->difsel);
>>>  
>>>  	ret = stm32h7_adc_enable(adc);
>>>  	if (ret)
>>>  		goto pwr_dwn;
>>>  
>>> -	ret = stm32h7_adc_restore_selfcalib(adc);
>>> +	/* Either restore or read calibration result for future reference */
>>> +	if (calib)
>>> +		ret = stm32h7_adc_restore_selfcalib(adc);
>>> +	else
>>> +		ret = stm32h7_adc_read_selfcalib(adc);
>>>  	if (ret)
>>>  		goto disable;
>>>  
>>> @@ -1880,12 +1877,6 @@ static int stm32_adc_probe(struct platform_device *pdev)
>>>  		goto err_clk_disable;
>>>  	stm32_adc_set_res(adc);
>>>  
>>> -	if (adc->cfg->selfcalib) {
>>> -		ret = adc->cfg->selfcalib(adc);
>>> -		if (ret)
>>> -			goto err_clk_disable;
>>> -	}
>>> -
>>>  	ret = stm32_adc_chan_of_init(indio_dev);
>>>  	if (ret < 0)
>>>  		goto err_clk_disable;
>>> @@ -1961,7 +1952,6 @@ static int stm32_adc_remove(struct platform_device *pdev)
>>>  	.regs = &stm32h7_adc_regspec,
>>>  	.adc_info = &stm32h7_adc_info,
>>>  	.trigs = stm32h7_adc_trigs,
>>> -	.selfcalib = stm32h7_adc_selfcalib,
>>>  	.start_conv = stm32h7_adc_start_conv,
>>>  	.stop_conv = stm32h7_adc_stop_conv,
>>>  	.prepare = stm32h7_adc_prepare,
>>> @@ -1974,7 +1964,6 @@ static int stm32_adc_remove(struct platform_device *pdev)
>>>  	.adc_info = &stm32h7_adc_info,
>>>  	.trigs = stm32h7_adc_trigs,
>>>  	.has_vregready = true,
>>> -	.selfcalib = stm32h7_adc_selfcalib,
>>>  	.start_conv = stm32h7_adc_start_conv,
>>>  	.stop_conv = stm32h7_adc_stop_conv,
>>>  	.prepare = stm32h7_adc_prepare,  
>>
> 
