Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeBFJnv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:43:51 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34676 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752248AbeBFJnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:43:47 -0500
X-Google-Smtp-Source: AH8x227XcasbpawhBYlD7bpRGaGEA1MbpmE+bTBp0U3iCwKk6tnhdkhgMELELeAu2VkK33r4RnYiQg==
Subject: Re: [PATCH 3/4] lightnvm: add 2.0 geometry identification
To: Randy Dunlap <rdunlap@infradead.org>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, javier@cnexlabs.com
References: <20180205121505.27563-1-mb@lightnvm.io>
 <20180205121505.27563-4-mb@lightnvm.io>
 <b8ddae5a-064c-7468-d5e2-a5a20a93de19@infradead.org>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <1861efa4-bbba-2211-4c45-735b795e4e34@lightnvm.io>
Date: Tue, 6 Feb 2018 10:43:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <b8ddae5a-064c-7468-d5e2-a5a20a93de19@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2018 07:04 PM, Randy Dunlap wrote:
> On 02/05/2018 04:15 AM, Matias Bjørling wrote:
>> Implement the geometry data structures for 2.0 and enable a drive
>> to be identified as one, including exposing the appropriate 2.0
>> sysfs entries.
>>
>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>> ---
>>   drivers/lightnvm/core.c      |   2 +-
>>   drivers/nvme/host/lightnvm.c | 334 +++++++++++++++++++++++++++++++++++++------
>>   include/linux/lightnvm.h     |  11 +-
>>   3 files changed, 295 insertions(+), 52 deletions(-)
>>
>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>> index c72863b36439..250e74dfa120 100644
>> --- a/drivers/lightnvm/core.c
>> +++ b/drivers/lightnvm/core.c
>> @@ -934,7 +934,7 @@ static int nvm_init(struct nvm_dev *dev)
>>   	pr_debug("nvm: ver:%x nvm_vendor:%x\n",
>>   			dev->identity.ver_id, dev->identity.vmnt);
>>   
>> -	if (dev->identity.ver_id != 1) {
>> +	if (dev->identity.ver_id != 1 && dev->identity.ver_id != 2) {
>>   		pr_err("nvm: device not supported by kernel.");
>>   		goto err;
>>   	}
> 
> Hi,
> The pr_err() above could be a bit more informative to the user. E.g.,
> 		pr_err("nvm: device ver_id %d not supported by kernel.",
> 			dev->identity.ver_id);
> 
> BTW, isn't that line missing a '\n'?
> 

Good point! Thanks. I'll add it in.
