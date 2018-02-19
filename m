Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeBSK4V (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:56:21 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57668 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752468AbeBSK4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:56:19 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Feb 2018 16:26:18 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] i2c: qup: change completion timeout according to
 transfer length
In-Reply-To: <7dcbac1f-edaf-aecf-8e58-04d243384758@codeaurora.org>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-9-git-send-email-absahu@codeaurora.org>
 <7dcbac1f-edaf-aecf-8e58-04d243384758@codeaurora.org>
Message-ID: <6a1983c0ca81afce908f622a53abd563@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-16 10:18, Sricharan R wrote:
> On 2/3/2018 1:28 PM, Abhishek Sahu wrote:
>> Currently the completion timeout is being taken according to
>> maximum transfer length which is too high if SCL is operating in
>> high frequency. This patch calculates timeout on the basis of
>> one-byte transfer time and uses the same for completion timeout.
>> 
>> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
>> ---
>>  drivers/i2c/busses/i2c-qup.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/i2c/busses/i2c-qup.c 
>> b/drivers/i2c/busses/i2c-qup.c
>> index a91fc70..6df65ea 100644
>> --- a/drivers/i2c/busses/i2c-qup.c
>> +++ b/drivers/i2c/busses/i2c-qup.c
>> @@ -130,8 +130,8 @@
>>  #define MX_TX_RX_LEN			SZ_64K
>>  #define MX_BLOCKS			(MX_TX_RX_LEN / QUP_READ_LIMIT)
>> 
>> -/* Max timeout in ms for 32k bytes */
>> -#define TOUT_MAX			300
>> +/* Min timeout for i2c transfers */
>> +#define TOUT_MIN			2
>> 
> 
>  may be you can mention, why is this 2 ?
> 

  This 2 seconds is timeout which I am adding on the top of maximum
  xfer time calculated from bus speed to compensate the interrupt
  latency and other factors. It will make xfer timeout minimum as
  2 seconds.

  I will update the comment to explain it in more detail.

  Thanks,
  Abhishek
