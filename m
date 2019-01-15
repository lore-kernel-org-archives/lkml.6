Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A76C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F96F20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389619AbfAOUBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:01:13 -0500
Received: from www62.your-server.de ([213.133.104.62]:50996 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732293AbfAOUBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:01:13 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gjUtY-0006Nt-AP; Tue, 15 Jan 2019 21:01:08 +0100
Received: from [178.197.248.17] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gjUtY-0007Kw-3m; Tue, 15 Jan 2019 21:01:08 +0100
Subject: Re: [PATCH 2/2] bpf: annotate implicit fall through
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mathieu Malaterre <malat@debian.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190114202941.16183-1-malat@debian.org>
 <20190114202941.16183-2-malat@debian.org>
 <476963d1-fc1a-b185-6b33-c780fbb009c5@cogentembedded.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <79030d7e-4db4-c03a-b2e0-53f1b30e0924@iogearbox.net>
Date:   Tue, 15 Jan 2019 21:01:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <476963d1-fc1a-b185-6b33-c780fbb009c5@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25300/Tue Jan 15 11:33:07 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/15/2019 10:03 AM, Sergei Shtylyov wrote:
> On 14.01.2019 23:29, Mathieu Malaterre wrote:
> 
>> There is a plan to build the kernel with -Wimplicit-fallthrough and
>> thise place in the code produced a warnings (W=1).
> 
>    This?
> 
>> In this particular case change a ‘:’ with a ‘,’ so as to match the
>> regular expression expected by GCC.
>>
>> This commit remove the following warning:
>>
>>    net/core/filter.c:5310:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Please respin and also make the two subject lines not exactly the same.

Thanks,
Daniel

>> ---
>>   net/core/filter.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 447dd1bad31f..c8069a142994 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -5309,7 +5309,7 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>>       case BPF_FUNC_trace_printk:
>>           if (capable(CAP_SYS_ADMIN))
>>               return bpf_get_trace_printk_proto();
>> -        /* else: fall through */
>> +        /* else, fall through */
> 
>    The other patches seem to just drop "else:"...
> 
>>       default:
>>           return NULL;
>>       }
>>
> 
> MBR, Sergei

