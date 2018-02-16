Return-Path: <haiyue.wang@linux.intel.com>
X-Google-Smtp-Source: AH8x224TSOywmZY4qNO+fwnEXanWcyG9SYcxYMiDp7G1jIrSzs7PyFd906RR+IccakYAaTSbHJ+J
ARC-Seal: i=1; a=rsa-sha256; t=1518769624; cv=none;
        d=google.com; s=arc-20160816;
        b=Q5M2qqCQe8oJDtCYm0uLSSMXcdZ6wEdkgmDmp3XzUPHUbO+BeUfgBUio5ufbUha5O0
         FR0adLgjas5pSjrlfRtB+F6lOOvQqJ6YslA6/M7NpSteV9hNJviUdxAUfKN4oS1oOHyE
         6u5TmRqBDWANyGJD3jBiRKtQY95hfP0RFMvTsxAcLlmvVOqSdNDEOniFWPnkiNB4CgJB
         2FioZDpb4XqzQEWpr0BMFXBCLfp9aDgz3g5tmTAF7WzZSSpHvCivZjcGa7AsRtYk3+Mn
         VTUoHOVbaz9oP8NMtJ7nQAdVVM0QQhPp+L4lmeU/2mryKcj8J/YYgElo39tHaBbRaL05
         hN7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=aAjLBraNp8r+oonFVpf4E2BLFKekoNVSFhTcxJ9EhtM=;
        b=cZAHVOoM7Yn6b5ZRDDRFuKtEZnMR/pXEUaX02rjz1izgJ3NF3fgqA1FyEXcbilDS72
         nEMaIEy1KkRDH5L7vmlwFh//RiY8azMSTquvKgmqLHScNmapeEFrOun6lsjvNJBhFEiJ
         QsBAvMO9/O91tRxiFnpRXHSzZ3CzlPqNHC0qVTWpnlrxUzn1V8aAY50gK7pMJXxbGLLQ
         6quo7294uzQyWfpTfltAJHLomb6q81DZyU8/kGziaTGD1WmgAamejLsIVORiFRYZ3cn8
         SPrybQ3csEjZvSbqypF2g2qw9izdjt+xfrNhVXlxRulyrzLkk8NU41y4hSDIZjbhGGbQ
         yydQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of haiyue.wang@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=haiyue.wang@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of haiyue.wang@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=haiyue.wang@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="204771811"
Subject: Re: [PATCH] ipmi: kcs_bmc: mark expected switch fall-through in
 kcs_bmc_handle_data
To: minyard@acm.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20180214173029.GA15661@embeddedor.com>
 <9098c6c8-83e5-5e1f-519b-68e14738c24a@acm.org>
From: "Wang, Haiyue" <haiyue.wang@linux.intel.com>
Message-ID: <3b2c65e6-a8bd-9b6c-5b13-c1d80f546215@linux.intel.com>
Date: Fri, 16 Feb 2018 16:27:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9098c6c8-83e5-5e1f-519b-68e14738c24a@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592398376863502226?=
X-GMAIL-MSGID: =?utf-8?q?1592545377655453476?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2018-02-15 05:46, Corey Minyard wrote:
> On 02/14/2018 11:30 AM, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>
> Thanks, queued for next release.
>
> -corey
>
>> Addresses-Coverity-ID: 1465255 ("Missing break in switch")
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> ---
>> This code was compiled with GCC 7.3.0
>>
>>   drivers/char/ipmi/kcs_bmc.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
>> index 3a3498a..6476bfb 100644
>> --- a/drivers/char/ipmi/kcs_bmc.c
>> +++ b/drivers/char/ipmi/kcs_bmc.c
>> @@ -95,6 +95,7 @@ static void kcs_bmc_handle_data(struct kcs_bmc 
>> *kcs_bmc)
>>       switch (kcs_bmc->phase) {
>>       case KCS_PHASE_WRITE_START:
>>           kcs_bmc->phase = KCS_PHASE_WRITE_DATA;
>> +        /* fall through */
Thanks, Gustavo. I see many modules have '/* fall through */', but I 
thought it was a just C comment, I didn't
add it for making code clean. Learned it, thank you! :-)
>>         case KCS_PHASE_WRITE_DATA:
>>           if (kcs_bmc->data_in_idx < KCS_MSG_BUFSIZ) {
>
>
