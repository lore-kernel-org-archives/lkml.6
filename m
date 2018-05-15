Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754034AbeEOPYU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 11:24:20 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:25823 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752323AbeEOPYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 11:24:18 -0400
Subject: Re: [PATCH] iio: adc: stm32-dfsdm: Add support for stm32mp1
To: Jonathan Cameron <jic23@kernel.org>
CC: Rob Herring <robh@kernel.org>, <alexandre.torgue@st.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@linaro.org>,
        <arnaud.pouliquen@st.com>
References: <1525266323-4922-1-git-send-email-fabrice.gasnier@st.com>
 <20180507205151.GA25321@rob-hp-laptop> <20180512103324.5068c893@archlinux>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <781b346a-e457-9c67-2e11-6f6edba88d63@st.com>
Date: Tue, 15 May 2018 17:23:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180512103324.5068c893@archlinux>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-15_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2018 11:33 AM, Jonathan Cameron wrote:
> On Mon, 7 May 2018 15:51:51 -0500
> Rob Herring <robh@kernel.org> wrote:
> 
>> On Wed, May 02, 2018 at 03:05:23PM +0200, Fabrice Gasnier wrote:
>>> Add support for DFSDM (Digital Filter For Sigma Delta Modulators)
>>> to STM32MP1. This variant is close to STM32H7 DFSDM, it implements
>>> 6 filter instances. Registers map is also increased.
>>>
>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>> ---
>>>  .../bindings/iio/adc/st,stm32-dfsdm-adc.txt         |  7 +++++--
>>>  drivers/iio/adc/stm32-dfsdm-core.c                  | 21 +++++++++++++++++++++
>>>  2 files changed, 26 insertions(+), 2 deletions(-)  
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> Applied.   Whilst doing this I note that I'm getting a few sparse
> warnings for this driver that would be nice to clean up...
> 
>   CHECK   drivers/iio/adc/stm32-dfsdm-adc.c
> drivers/iio/adc/stm32-dfsdm-adc.c:503:21: warning: expression using sizeof(void)
> drivers/iio/adc/stm32-dfsdm-adc.c:503:21: warning: expression using sizeof(void)
> 
> Which is mystifying at first glance... Something deep and dirty in the min macro
> but I can't see what..

Hi Jonathan,

I just sent a patch to clean bellow warning. But this is more obscure
regarding min macro...

Many thanks,
Fabrice

> 
> drivers/iio/adc/stm32-dfsdm-adc.c:680:5: warning: symbol 'stm32_dfsdm_get_buff_cb' was not declared. Should it be static?
> drivers/iio/adc/stm32-dfsdm-adc.c:703:5: warning: symbol 'stm32_dfsdm_release_buff_cb' was not declared. Should it be static?
> 
> Are rather more obvious
> 
