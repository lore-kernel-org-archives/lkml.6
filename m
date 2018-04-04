Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbeDDIVG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:21:06 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55427 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751167AbeDDIVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:21:04 -0400
Subject: Re: [PATCH v2 5/6] i2c: i2c-stm32f7: Add DMA support
To: Wolfram Sang <wsa@the-dreams.de>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-6-git-send-email-pierre-yves.mordret@st.com>
 <20180403153925.lg37rezuvs6hefks@ninjato>
From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Message-ID: <273ac8d2-6861-c1ad-c2fc-f9c5cc2ac3de@st.com>
Date: Wed, 4 Apr 2018 10:20:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180403153925.lg37rezuvs6hefks@ninjato>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-04_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/03/2018 05:39 PM, Wolfram Sang wrote:
> 
>> +#define STM32F7_I2C_DMA_LEN_MIN			0x1
> ...
> 
>> +	if (i2c_dev->dma && f7_msg->count >= STM32F7_I2C_DMA_LEN_MIN) {
> 
> Are you using DMA for every message with a length >= 1? The setup of
> that might be more expensive than the DMA gain, if so.
> 
Well yes. I am in charge of DMA IPs as well. I2C is the only devices that I had
to test DMA outside standard DMA Engine test. Quite convenient.
I believe to stress both I2C and DMA, this value was relevant.
Now I agree this value can be tuned a little bit. I might raise this threshold
in V3.
