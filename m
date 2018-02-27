Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeB0HpY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 02:45:24 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:18903 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751956AbeB0HpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 02:45:21 -0500
Subject: Re: [PATCH] i2c-stm32f4: remove redundant initialization of pointer
 reg
To: Wolfram Sang <wsa@the-dreams.de>,
        Colin King <colin.king@canonical.com>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180116174404.19464-1-colin.king@canonical.com>
 <20180226200639.tfll2y4efepm2sos@ninjato>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <25b0397b-5df3-2f5c-a18f-238db83205da@st.com>
Date: Tue, 27 Feb 2018 08:44:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226200639.tfll2y4efepm2sos@ninjato>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/26/2018 09:06 PM, Wolfram Sang wrote:
> On Tue, Jan 16, 2018 at 05:44:04PM +0000, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The pointer reg is assigned a value that is never read, it is later
>> overwritten with a new value, hence the redundant initialization can
>> be removed.
>>
>> Cleans up clang warning:
>> drivers/i2c/busses/i2c-stm32f4.c:352:16: warning: Value stored to 'reg'
>> during its initialization is never read
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Maxime? Alexandre? Are you OK with this patch?

Sorry for delay.

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>

regards
alex

> 
>> ---
>>   drivers/i2c/busses/i2c-stm32f4.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-stm32f4.c
>> index 47c8d00de53f..ba600d77a3f8 100644
>> --- a/drivers/i2c/busses/i2c-stm32f4.c
>> +++ b/drivers/i2c/busses/i2c-stm32f4.c
>> @@ -349,7 +349,7 @@ static void stm32f4_i2c_read_msg(struct stm32f4_i2c_dev *i2c_dev)
>>   static void stm32f4_i2c_terminate_xfer(struct stm32f4_i2c_dev *i2c_dev)
>>   {
>>   	struct stm32f4_i2c_msg *msg = &i2c_dev->msg;
>> -	void __iomem *reg = i2c_dev->base + STM32F4_I2C_CR2;
>> +	void __iomem *reg;
>>   
>>   	stm32f4_i2c_disable_irq(i2c_dev);
>>   
>> -- 
>> 2.15.1
>>
