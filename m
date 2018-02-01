Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbeBANWE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 08:22:04 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:61530 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752831AbeBANV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 08:21:59 -0500
From: Olivier MOYSAN <olivier.moysan@st.com>
To: Ladislav Michl <ladis@linux-mips.org>
CC: "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@stlinux.com" <kernel@stlinux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: stm32: add of dependency for stm32
 drivers
Thread-Topic: [alsa-devel] [PATCH 1/1] ASoC: stm32: add of dependency for
 stm32 drivers
Thread-Index: AQHTmzpPwShwJRjPnEWfx6EWOpE7DKOPMbUAgABFpIA=
Date: Thu, 1 Feb 2018 13:19:28 +0000
Message-ID: <3bd3ba89-5c69-4485-c913-ff1c1ad67190@st.com>
References: <1517475281-6444-1-git-send-email-olivier.moysan@st.com>
 <20180201091012.GA10746@lenoch>
In-Reply-To: <20180201091012.GA10746@lenoch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <18AFC50D9BD39642A7707A77A16E5836@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-01_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w11DMBTu011168

hello,

On 02/01/2018 10:10 AM, Ladislav Michl wrote:
> On Thu, Feb 01, 2018 at 09:54:41AM +0100, Olivier Moysan wrote:
>> Add of dependency for STM32 ASoC drivers.
>> DFSDM of dependency is already inherited
>> from STM32_DFSDM_ADC dependency.
>>
>> Signed-off-by: olivier moysan <olivier.moysan@st.com>
>> ---
>>   sound/soc/stm/Kconfig | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/sound/soc/stm/Kconfig b/sound/soc/stm/Kconfig
>> index 3ad881f..b5375f9 100644
>> --- a/sound/soc/stm/Kconfig
>> +++ b/sound/soc/stm/Kconfig
>> @@ -3,6 +3,7 @@ menu "STMicroelectronics STM32 SOC audio support"
>>   config SND_SOC_STM32_SAI
>>   	tristate "STM32 SAI interface (Serial Audio Interface) support"
>>   	depends on ARCH_STM32 || COMPILE_TEST
>> +	depends on OF
> 
> depends on (ARCH_STM32 && OF) || COMPILE_TEST ?
> 

I can find in many configs "depends on OF && (ARCH_X || COMPILE_TEST)"
This seems reasonable to me, as the driver always requires OF 
dependency, regardless the compilation context.
In fact, I cannot see why OF would not have to be selected
for COMPILE_TEST.

BRs

>>   	depends on SND_SOC
>>   	select SND_SOC_GENERIC_DMAENGINE_PCM
>>   	select REGMAP_MMIO
>> @@ -12,6 +13,7 @@ config SND_SOC_STM32_SAI
>>   config SND_SOC_STM32_I2S
>>   	tristate "STM32 I2S interface (SPI/I2S block) support"
>>   	depends on ARCH_STM32 || COMPILE_TEST
>> +	depends on OF
>>   	depends on SND_SOC
>>   	select SND_SOC_GENERIC_DMAENGINE_PCM
>>   	select REGMAP_MMIO
>> @@ -21,6 +23,7 @@ config SND_SOC_STM32_I2S
>>   config SND_SOC_STM32_SPDIFRX
>>   	tristate "STM32 S/PDIF receiver (SPDIFRX) support"
>>   	depends on ARCH_STM32 || COMPILE_TEST
>> +	depends on OF
>>   	depends on SND_SOC
>>   	select SND_SOC_GENERIC_DMAENGINE_PCM
>>   	select REGMAP_MMIO
>> -- 
>> 1.9.1
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
