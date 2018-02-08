Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeBHRFC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 12:05:02 -0500
Received: from gateway36.websitewelcome.com ([192.185.193.12]:33299 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751094AbeBHRFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 12:05:01 -0500
Subject: Re: [PATCH] ACPI / CPPC: Use 64-bit arithmetic instead of 32-bit
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180206233617.GA30829@embeddedgus>
 <2503109.MpnWDuSnnD@aspire.rjw.lan>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <1f5cffd5-4806-a8e6-48d7-bc2f8ec1d440@embeddedor.com>
Date: Thu, 8 Feb 2018 10:40:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2503109.MpnWDuSnnD@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.4.238
X-Source-L: No
X-Exim-ID: 1ejpFX-002jTM-KD
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.69]) [189.175.4.238]:51026
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/08/2018 03:49 AM, Rafael J. Wysocki wrote:
> On Wednesday, February 7, 2018 12:36:17 AM CET Gustavo A. R. Silva wrote:
>> Add suffix ULL to constant 500 in order to give the compiler complete
>> information about the proper arithmetic to use. Notice that this
>> constant is used in a context that expects an expression of type
>> u64 (64 bits, unsigned).
>>
>> The expression NUM_RETRIES * cppc_ss->latency at line 578, which at
>> preprocessing time translates to 500 * cppc_ss->latency is currently
>> being evaluated using 32-bit arithmetic.
>>
>> Addresses-Coverity-ID: 1382602
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>> Notice that another option is to cast NUM_RETRIES to u64 at line 578,
>> but as there is only one instace in which this macro is being used I
>> think adding the ULL is just enough.
>>
>>   drivers/acpi/cppc_acpi.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 06ea474..0afbb26 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -119,7 +119,7 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>>    * to PCC commands. Keeping it high enough to cover emulators where
>>    * the processors run painfully slow.
>>    */
>> -#define NUM_RETRIES 500
>> +#define NUM_RETRIES 500ULL
>>   
>>   struct cppc_attr {
>>   	struct attribute attr;
>>
> 
> Applied, thanks!
> 
> 

Thank you, Rafael.

-- 
Gustavo
