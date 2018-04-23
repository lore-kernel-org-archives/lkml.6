Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754078AbeDWHtq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 03:49:46 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58866 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751216AbeDWHtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 03:49:43 -0400
Subject: Re: [PATCH 5/7] iio: adc: stm32-dfsdm: misc style improvements and
 fixes
To: Jonathan Cameron <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <benjamin.gaignard@linaro.org>,
        <arnaud.pouliquen@st.com>
References: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
 <1519390261-25453-6-git-send-email-fabrice.gasnier@st.com>
 <20180224130309.7129e79f@archlinux>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <453b8fe0-3b32-b9b7-001f-78a3b1d0b56f@st.com>
Date: Mon, 23 Apr 2018 09:48:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180224130309.7129e79f@archlinux>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/24/2018 02:03 PM, Jonathan Cameron wrote:
> On Fri, 23 Feb 2018 13:50:59 +0100
> Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> 
>> Misc fixes & style improvements:
>> - checkpatch warns about line over 80 characters.
>> - remove extra spaces and a blank line (e.g. checkpatch --strict)
>> - remove bad error message always printed in probe routine.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> I'd have preferred this as 3 patches doing one type fo fix each.
> 
> Anyhow, I'll need to hold this until the fixes have made there
> way upstream.  Give me a poke if I seem to have forgotten
> and the dependencies have made it back to my togreg branch.

Hi Jonathan,

There are few pending patches in this series. I'm not sure everything
have been merged yet.
Do you wish I resend those patches as separate series ?

Please let me know,
Thanks in advance,
BR,
Fabrice

> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>  drivers/iio/adc/stm32-dfsdm-adc.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
>> index 01422d1..57bcb45 100644
>> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
>> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
>> @@ -253,7 +253,8 @@ static int stm32_dfsdm_start_filter(struct stm32_dfsdm *dfsdm,
>>  				  DFSDM_CR1_RSWSTART(1));
>>  }
>>  
>> -static void stm32_dfsdm_stop_filter(struct stm32_dfsdm *dfsdm, unsigned int fl_id)
>> +static void stm32_dfsdm_stop_filter(struct stm32_dfsdm *dfsdm,
>> +				    unsigned int fl_id)
>>  {
>>  	/* Disable conversion */
>>  	regmap_update_bits(dfsdm->regmap, DFSDM_CR1(fl_id),
>> @@ -337,7 +338,7 @@ static int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
>>  					    "st,adc-channel-types", chan_idx,
>>  					    &of_str);
>>  	if (!ret) {
>> -		val  = stm32_dfsdm_str2val(of_str, stm32_dfsdm_chan_type);
>> +		val = stm32_dfsdm_str2val(of_str, stm32_dfsdm_chan_type);
>>  		if (val < 0)
>>  			return val;
>>  	} else {
>> @@ -349,7 +350,7 @@ static int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
>>  					    "st,adc-channel-clk-src", chan_idx,
>>  					    &of_str);
>>  	if (!ret) {
>> -		val  = stm32_dfsdm_str2val(of_str, stm32_dfsdm_chan_src);
>> +		val = stm32_dfsdm_str2val(of_str, stm32_dfsdm_chan_src);
>>  		if (val < 0)
>>  			return val;
>>  	} else {
>> @@ -1093,7 +1094,6 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
>>  	char *name;
>>  	int ret, irq, val;
>>  
>> -
>>  	dev_data = of_device_get_match_data(dev);
>>  	iio = devm_iio_device_alloc(dev, sizeof(*adc));
>>  	if (!iio) {
>> @@ -1161,7 +1161,6 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
>>  	if (ret < 0)
>>  		goto err_cleanup;
>>  
>> -	dev_err(dev, "of_platform_populate\n");
>>  	if (dev_data->type == DFSDM_AUDIO) {
>>  		ret = of_platform_populate(np, NULL, NULL, dev);
>>  		if (ret < 0) {
> 
