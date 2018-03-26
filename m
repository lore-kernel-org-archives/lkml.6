Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750955AbeCZElm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 00:41:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60400 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeCZElk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 00:41:40 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Mon, 26 Mar 2018 10:11:39 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Austin Christ <austinwc@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/13] Major code reorganization to make all i2c
 transfers working
In-Reply-To: <20180324122206.c4loxtob5o3lm7al@ninjato>
References: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
 <20180324122206.c4loxtob5o3lm7al@ninjato>
Message-ID: <b766f9c42c1aef2404d4636ca10843bd@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-24 17:52, Wolfram Sang wrote:
> On Mon, Mar 12, 2018 at 06:44:49PM +0530, Abhishek Sahu wrote:
>> * v2:
>> 
>> 1. Address review comments in v1
>> 2. Changed the license to SPDX
>> 3. Changed commit messages for some of the patch having more detail
>> 4. Removed event-based completion and changed transfer completion
>>    detection logic in interrupt handler
>> 5. Removed dma_threshold and blk_mode_threshold from global structure
>> 6. Improved determine mode logic for QUP v2 transfers
>> 7. Fixed function comments
>> 8. Fixed auto build test WARNING ‘idx' may be used uninitialized
>>    in this function
>> 9. Renamed tx/rx_buf to tx/rx_cnt
>> 
>> * v1:
>> 
>> The current driver is failing in following test case
>> 1. Handling of failure cases is not working in long run for BAM
>>    mode. It generates error message “bam-dma-engine 7884000.dma: 
>> Cannot
>>    free busy channel” sometimes.
>> 2. Following I2C transfers are failing
>>    a. Single transfer with multiple read messages
>>    b. Single transfer with multiple read/write message with maximum
>>       allowed length per message (65K) in BAM mode
>>    c. Single transfer with write greater than 32 bytes in QUP v1 and
>>       write greater than 64 bytes in QUP v2 for non-DMA mode.
>> 3. No handling is present for Block/FIFO interrupts. Any non-error
>>    interrupts are being treated as the transfer completion and then
>>    polling is being done for available/free bytes in FIFO.
>> 
>> To fix all these issues, major code changes are required. This patch
>> series fixes all the above issues and makes the driver interrupt based
>> instead of polling based. After these changes, all the mentioned test
>> cases are working properly.
>> 
>> The code changes have been tested for QUP v1 (IPQ8064) and QUP
>> v2 (IPQ8074) with sample application written over i2c-dev.
>> 
>> Abhishek Sahu (13):
>>   i2c: qup: fix copyrights and update to SPDX identifier
>>   i2c: qup: fixed releasing dma without flush operation completion
>>   i2c: qup: minor code reorganization for use_dma
>>   i2c: qup: remove redundant variables for BAM SG count
>>   i2c: qup: schedule EOT and FLUSH tags at the end of transfer
>>   i2c: qup: fix the transfer length for BAM RX EOT FLUSH tags
>>   i2c: qup: proper error handling for i2c error in BAM mode
>>   i2c: qup: use the complete transfer length to choose DMA mode
>>   i2c: qup: change completion timeout according to transfer length
>>   i2c: qup: fix buffer overflow for multiple msg of maximum xfer len
>>   i2c: qup: send NACK for last read sub transfers
>>   i2c: qup: reorganization of driver code to remove polling for qup v1
>>   i2c: qup: reorganization of driver code to remove polling for qup v2
> 
> Applied to for-next, thanks! Also thanks to the reviewers!

  Thanks Wolfram for your help in getting this big
  patch series applied to for-next.

  Thanks to Andy, Sricharan, Austin and other reviewers for
  reviewing/testing the patches.

  Regards,
  Abhishek
