Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8D3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEFB20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="namiebOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbfAQHkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:40:16 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:33275 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730050AbfAQHkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:40:16 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 43gGFV3kskz1yS3;
        Thu, 17 Jan 2019 08:40:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1547710814; bh=5khhPaM7nKlBntW+RqEWqlC0HjQeUDoCIc1HqDolihY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From:To:CC:
         Subject;
        b=namiebOjQLmRaCLnNOweFttBKktThCwrWSYd1Aj/DU0+ogSIxEvkkFdlGswDRpw17
         LD53AFaIgGKomnlJdMVCjJgDAQcHODBQpfa1bx8uqb+faxE3FQ7/ih2Gq3e6FRXZSC
         u/PqyYmCBxxwrjQ9FcBG0V2DOD0u1xZBOguBPe+ZRzpCf8g7LiKzEu8fJRFPLZQm6U
         lulY25uE/Uj9rjuQcKc079toNiMcoEXb9U0efuFq7A3IcGl2vteZYjwde9rbjrNkVp
         YKj394+h8HghhKtbbU1yLOHyAaNEHyP8sVGZ4PntMqCzucrO4Z8M+HgK2+6/INiaiI
         0p7tGmicNOZmw==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2a01:c22:6e20:6c00:cd9e:a8ac:efa3:425d
Received: from [IPv6:2a01:c22:6e20:6c00:cd9e:a8ac:efa3:425d] (unknown [IPv6:2a01:c22:6e20:6c00:cd9e:a8ac:efa3:425d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX18vvlM2fHeeUq3qiKcHKU+N9ygxVZeQvEk=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 43gGFS1Jqpz1y7m;
        Thu, 17 Jan 2019 08:40:12 +0100 (CET)
Subject: Re: [PATCH v2] tracing/uprobes: Fix output for multiple string
 arguments
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <20190116084021.34b0beee@gandalf.local.home>
 <20190116141629.5752-1-andreas.ziegler@fau.de>
 <20190117150107.17f2c0c37e41126120c5eebb@kernel.org>
From:   Andreas Ziegler <andreas.ziegler@fau.de>
Openpgp: preference=signencrypt
Message-ID: <b5defce3-b52a-db20-bfd1-81eec9972fab@fau.de>
Date:   Thu, 17 Jan 2019 08:40:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190117150107.17f2c0c37e41126120c5eebb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.01.19 07:01, Masami Hiramatsu wrote:
> On Wed, 16 Jan 2019 15:16:29 +0100
> Andreas Ziegler <andreas.ziegler@fau.de> wrote:
> 
>> When printing multiple uprobe arguments as strings the output for the
>> earlier arguments would also include all later string arguments.
>>
>> This is best explained in an example:
>>
>> Consider adding a uprobe to a function receiving two strings as
>> parameters which is at offset 0xa0 in strlib.so and we want to print
>> both parameters when the uprobe is hit (on x86_64):
>>
>> $ echo 'p:func /lib/strlib.so:0xa0 +0(%di):string +0(%si):string' > \
>>     /sys/kernel/debug/tracing/uprobe_events
>>
>> When the function is called as func("foo", "bar") and we hit the probe,
>> the trace file shows a line like the following:
>>
>>   [...] func: (0x7f7e683706a0) arg1="foobar" arg2="bar"
>>
>> Note the extra "bar" printed as part of arg1. This behaviour stacks up
>> for additional string arguments.
>>
>> The strings are stored in a dynamically growing part of the uprobe
>> buffer by fetch_store_string() after copying them from userspace via
>> strncpy_from_user(). The return value of strncpy_from_user() is then
>> directly used as the required size for the string. However, this does
>> not take the terminating null byte into account as the documentation
>> for strncpy_from_user() cleary states that it "[...] returns the
>> length of the string (not including the trailing NUL)" even though the
>> null byte will be copied to the destination.
>>
>> Therefore, subsequent calls to fetch_store_string() will overwrite
>> the terminating null byte of the most recently fetched string with
>> the first character of the current string, leading to the
>> "accumulation" of strings in earlier arguments in the output.
>>
>> Fix this by incrementing the return value of strncpy_from_user() by
>> one if we did not hit the maximum buffer size.
>>
> 
> Yeah, I had eventually same conclusion. However, you also have to increse
> the return value of fetch_store_strlen() too. (And I found another issue)
> 

I don't think we need to increase that since the documentation for
strnlen_user() says that it "[r]eturns the size of the string
INCLUDING the terminating NUL." so its return value will already be
one more than that of strncpy_from_user().

Thanks,

Andreas

> Could you fix fetch_store_strlen in the same patch?
> 
> Thank you,
> 
>> Signed-off-by: Andreas Ziegler <andreas.ziegler@fau.de>
>> ---
>> v2: removed a wrong check for (ret > 0)
>>
>>  kernel/trace/trace_uprobe.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
>> index e335576b9411..3a1d5ab6b4ba 100644
>> --- a/kernel/trace/trace_uprobe.c
>> +++ b/kernel/trace/trace_uprobe.c
>> @@ -160,6 +160,13 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
>>  	if (ret >= 0) {
>>  		if (ret == maxlen)
>>  			dst[ret - 1] = '\0';
>> +		else
>> +			/*
>> +			 * Include the terminating null byte. In this case it
>> +			 * was copied by strncpy_from_user but not accounted
>> +			 * for in ret.
>> +			 */
>> +			ret++;
>>  		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
>>  	}
>>
>> --
>> 2.17.1
>>
> 
> 

