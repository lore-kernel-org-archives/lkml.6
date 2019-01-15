Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52878C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2172320859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390316AbfAOVQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:16:53 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.51]:22068 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730655AbfAOVQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:16:53 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id A96B7148A1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 15:16:24 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id jW4OgkVCK2qH7jW4OgO4hU; Tue, 15 Jan 2019 15:16:24 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=43896 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gjW4N-001bRz-MJ; Tue, 15 Jan 2019 15:16:24 -0600
Subject: Re: [PATCH] tracing: Replace kzalloc with kcalloc
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <20190115043408.GA23456@embeddedor>
 <20190115161255.6afa9dbd@gandalf.local.home>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <659f9838-9e3f-2ba8-3b02-9f19192bc252@embeddedor.com>
Date:   Tue, 15 Jan 2019 15:16:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115161255.6afa9dbd@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gjW4N-001bRz-MJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:43896
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/15/19 3:12 PM, Steven Rostedt wrote:
> On Mon, 14 Jan 2019 22:34:08 -0600
> "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> 
>> Replace kzalloc() function with its 2-factor argument form, kcalloc().
>>
>> This patch replaces cases of:
>>
>> 	kzalloc(a * b, gfp)
>>
>> with:
>> 	kcalloc(a * b, gfp)
> 
> I think you meant:
> 
> 	kcalloc(a, b, gfp)
> 

Yep. copy/paste error. :/

Thanks
--
Gustavo

> -- Steve
> 
>>
>> This code was detected with the help of Coccinelle.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   kernel/trace/trace_probe.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
>> index 9962cb5da8ac..57f0cbaf9c58 100644
>> --- a/kernel/trace/trace_probe.c
>> +++ b/kernel/trace/trace_probe.c
>> @@ -429,7 +429,7 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
>>   			 parg->count);
>>   	}
>>   
>> -	code = tmp = kzalloc(sizeof(*code) * FETCH_INSN_MAX, GFP_KERNEL);
>> +	code = tmp = kcalloc(FETCH_INSN_MAX, sizeof(*code), GFP_KERNEL);
>>   	if (!code)
>>   		return -ENOMEM;
>>   	code[FETCH_INSN_MAX - 1].op = FETCH_OP_END;
>> @@ -501,7 +501,7 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
>>   	code->op = FETCH_OP_END;
>>   
>>   	/* Shrink down the code buffer */
>> -	parg->code = kzalloc(sizeof(*code) * (code - tmp + 1), GFP_KERNEL);
>> +	parg->code = kcalloc(code - tmp + 1, sizeof(*code), GFP_KERNEL);
>>   	if (!parg->code)
>>   		ret = -ENOMEM;
>>   	else
> 
