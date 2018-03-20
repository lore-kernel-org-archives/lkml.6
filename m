Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbeCTJIe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:08:34 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:7144 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752436AbeCTJIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:08:32 -0400
Subject: Re: [RESEND PATCH v1] i2c: i2c-stm32f7: fix no check on returned
 setup
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1520859201-30549-1-git-send-email-pierre-yves.mordret@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <8271066c-e8c3-839c-e099-c7c406331c2c@st.com>
Date: Tue, 20 Mar 2018 10:08:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520859201-30549-1-git-send-email-pierre-yves.mordret@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-20_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre-Yves

On 03/12/2018 01:53 PM, Pierre-Yves MORDRET wrote:
> Before assigning returned setup structure check if not null
> 
> Fixes: 463a9215f3ca7600b5ff ("i2c: stm32f7: fix setup structure")
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>    Version history:
>       v1:
>           * Initial
> ---
> ---
>   drivers/i2c/busses/i2c-stm32f7.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
> index b445b3b..16c7d77 100644
> --- a/drivers/i2c/busses/i2c-stm32f7.c
> +++ b/drivers/i2c/busses/i2c-stm32f7.c
> @@ -888,6 +888,10 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
>   	}
>   
>   	setup = of_device_get_match_data(&pdev->dev);
> +	if (!setup) {
> +		dev_err(&pdev->dev, "Can't get device data\n");
> +		goto clk_free;

You have to fill "ret" with error statement before go to "clk_free"

> +	}

>   	i2c_dev->setup = *setup;
>   
>   	ret = device_property_read_u32(i2c_dev->dev, "i2c-scl-rising-time-ns",
> 
