Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeBSK0m (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:26:42 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36388 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbeBSK0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:26:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Feb 2018 15:56:38 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] i2c: qup: remove redundant variables for BAM SG
 count
In-Reply-To: <a20dc9c0-e012-d1a5-e182-5c7ddbcc8515@codeaurora.org>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-4-git-send-email-absahu@codeaurora.org>
 <a20dc9c0-e012-d1a5-e182-5c7ddbcc8515@codeaurora.org>
Message-ID: <796cbb857fe16266403d286e8047698a@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-09 07:46, Sricharan R wrote:
> Hi Abhishek,
> 
> On 2/3/2018 1:28 PM, Abhishek Sahu wrote:
>> The rx_nents and tx_nents are redundant. rx_buf and tx_buf can
>> be used for total number of SG entries.
>> 
>> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
>> ---
>>  drivers/i2c/busses/i2c-qup.c | 26 ++++++++++----------------
>>  1 file changed, 10 insertions(+), 16 deletions(-)
>> 
>> diff --git a/drivers/i2c/busses/i2c-qup.c 
>> b/drivers/i2c/busses/i2c-qup.c
>> index c68f433..bb83a2967 100644
>> --- a/drivers/i2c/busses/i2c-qup.c
>> +++ b/drivers/i2c/busses/i2c-qup.c
>> @@ -692,7 +692,7 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev 
>> *qup, struct i2c_msg *msg,
>>  	struct dma_async_tx_descriptor *txd, *rxd = NULL;
>>  	int ret = 0, idx = 0, limit = QUP_READ_LIMIT;
>>  	dma_cookie_t cookie_rx, cookie_tx;
>> -	u32 rx_nents = 0, tx_nents = 0, len, blocks, rem;
>> +	u32 len, blocks, rem;
>>  	u32 i, tlen, tx_len, tx_buf = 0, rx_buf = 0, off = 0;
>>  	u8 *tags;
>> 
> 
>  This is correct. Just a nit, may be rx/tx_buf can be changed to
>  rx/tx_count to make it more clear.
> 

  Yes, rx/tx_count will be more meaningful. rx/tx_buf gives the
  impression that it is uchar buffer.  I will change that.

  Thanks,
  Abhishek
