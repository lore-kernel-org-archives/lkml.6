Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9965CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D95020851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="bdiAx45p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfAQIIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:08:47 -0500
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:42813 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727383AbfAQIIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:08:47 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 43gGtN594MzPjrp;
        Thu, 17 Jan 2019 09:08:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1547712524; bh=+JdAt6sGJaI7QERC5JCqV6jfF4utgTk+OljfH2ilbn4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From:To:CC:
         Subject;
        b=bdiAx45pa1kR+fwk5Bk4uj0we+ZJRLmfj2AZlk2p+lVaYOHPeaRRDIz/qy3QaFZg6
         ZEIwuAcBWjOUgKMwS1bzePUo1gfb/AQQQ1J9+4ClrDgJTNFYk9rn/MSc4HS/jqAPS2
         ICCF2OYywqFraZGZ+iiVsWLJMjxnMUbcR8pIpu56mUiFk617NkynWIVr2Nbuj4BibF
         HQpLp0xeob+oByNIm6wx4dQDpO3mht2FkThf5rYG9ANnshJL4FaEvaYBpuuUT+bKM2
         hwMrGd4WT8OhdkNwfSbY6fntrEVZPoBX9EarMkbZqg+mNyGgVU40OmzljODc6xUmMB
         BT08T3t5NN/qw==
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2a01:c22:6e20:6c00:cd9e:a8ac:efa3:425d
Received: from [IPv6:2a01:c22:6e20:6c00:cd9e:a8ac:efa3:425d] (unknown [IPv6:2a01:c22:6e20:6c00:cd9e:a8ac:efa3:425d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX192M+T4UIEMI4SDwmhsQtUpebbaGdkuKJM=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 43gGtL3MDmzPjvp;
        Thu, 17 Jan 2019 09:08:42 +0100 (CET)
Subject: Re: uprobes: bug in comm/string output?
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <bf358673-ceb2-65bf-80c9-4b1c09a8a264@fau.de>
 <8b67136d-28d7-a734-6366-9511e30d66a7@fau.de>
 <20190116190054.ac22c8495540578834446236@kernel.org>
 <62276858-9135-2393-8993-64e1088db7b9@fau.de>
 <20190117151309.711d41ebdd761b525a168837@kernel.org>
 <20190117170015.403157bf619907f8467189fe@kernel.org>
From:   Andreas Ziegler <andreas.ziegler@fau.de>
Openpgp: preference=signencrypt
Autocrypt: addr=andreas.ziegler@fau.de; prefer-encrypt=mutual; keydata=
 mQINBFIE1XQBEADX62jd3k/mh7G9vig+SJKeEteSbvk6m++f4M2Y0BaGe4q8QVdQgdtLm4pH
 4ZrGrtCbsZwKW9QWswKR0aUZORlmi0Spx7CHymFDPkKAA+URk0zAhwXVMxAAr63U81TZYRvZ
 e/sAZ59SVu7fE2kFd0Bph7OGM91P1tBNGWtJ6XQHXEJo8oTv+fIAQiHbqBOkdNfQTF7F1/dV
 /QHqkTQtLRKdK7Rjz8Reemh3xmaSuABMX6eA1HlfxX6OOK4OfAGAO4+TdoMeKyItcgNFlrqU
 dzIO5jRjF6j4/VSwDWTVEy7INHys2Trt/Jm2DYuwRbiCDS2s3pFC5iExmMGg4SQcVeLp6lJc
 zQYwPTdAoUrNfL4scYnJZKLnIqwVcbVJuL9msl+kfV2Pi2uG9gRqg/1+Mmh3nuED1QX3Idz0
 nGF370pgL1YGBdSePlfTehlep7fc4RafvPCe5WWLdeDx+A1npWJBeU4VIDuqL7O9aZa/kZak
 sMbBik1Z2PN7UzEaUcGqHOYoC5FoX1bHSj2zFk9vbpzRdJbi7pfgHKnQh7/x6WinoV4AHn2D
 StgHbAph/cpMBqTkRLHvqvmqe0sHmvSjXV5MTF/qdUfGqkQlhEIKSU+OjLxVgvYhsaCdNSxh
 FiPy0D2QycGcI7Q3+yENkzoZcjeg97II/pP57JuhEiPWRk1F4wARAQABtChBbmRyZWFzIFpp
 ZWdsZXIgPGFuZHJlYXMuemllZ2xlckBmYXUuZGU+iQI+BBMBAgAoBQJV4CHsAhsjBQkHiLTL
 BgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCQaEAPaqNtuGpxD/sGZTiBCEJYs9hwVHOG
 hOtHEuz6OHnaN3R373Z02InEIfPIlkl4VchphuAEeRHuR1uFgHAUERIGW3+y8ZGGR/OZ72yP
 k+53M8yuooI/SRT5mj6K16m4/LvU8C1rOTI9I329wgQQxNNAhDhEt4oG7+l4GzU+HwOzLnoJ
 ESIhc5fvh+PZEb8ZI6ckBFYYQu6bDTs/V5B39kCU1zqwadn8QrWYcroLCsBc7+9rngX4A7lU
 qOC3BIBfnMBZwITXBxvowfjgttDxjsO20sTcmBL/2sYhGLRrTnG+ASz8hfeO9OHjYtoAttgb
 RENbM8V9rwtBHG4nDcuAAliIe0f80FRKpzP8md5NvWwfuYv/5AYOJXpCbu0sDMPwN4YT60nY
 bFIt1PJxdmGtNbssUNP+sfKAXX7mbB7L04wLce3R2NemMhXaB69PpoyXpT0WpVbg/nIs3LJ9
 ZXU+U5pSmruZOM0sJMnp01ZNE6vXmpLNPsathdhs8TiZlqS8yswFzIbvplU6zg9SFEUY+pwd
 SyfYsCPAjJkxli3ZVDOwySTnDRHAmDgqVvgzZZxR7qLD86sV0ppyRJb0UsvwveAInaol+qvj
 qWz3hQZKSRJFLRB5rbCYPD7EnPUqMPfhKOQ2QlfnIeKeCqwKrDLubKlkDHGqHZKCoPR7fXTd
 eM+P+TAFeNENJL72rQ==
Message-ID: <17147ef5-4348-9a02-d781-0f089fe603f5@fau.de>
Date:   Thu, 17 Jan 2019 09:08:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190117170015.403157bf619907f8467189fe@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.01.19 09:00, Masami Hiramatsu wrote:
> On Thu, 17 Jan 2019 15:13:09 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
>> On Wed, 16 Jan 2019 11:16:07 +0100
>> Andreas Ziegler <andreas.ziegler@fau.de> wrote:
>>
>>>
>>> I went into this a bit deeper today, and right now it is simply failing 
>>> to parse the code because there is no FETCH_OP_COMM case in 
>>> process_fetch_insn() for uprobes so that will return -EILSEQ, leading to 
>>> a make_data_loc(0, ...) in store_trace_args(). If we just add 
>>> FETCH_OP_COMM and let val point to current->comm (that's what 
>>> trace_kprobe.c does), we get an -EFAULT return value from 
>>> fetch_store_string because strncpy_from_user() checks if the argument is 
>>> in user space.
>>
>> Correct. I missed to add OP_COMM support. And uprobe's fetch_store_string
>> is only for user space strings.
>>
>>> So I think we might need a special case for that, something like 
>>> FETCH_OP_ST_COMM_STRING which is only used for FETCH_OP_COMM and copies 
>>> current->comm over to the dynamic area. The implementation could be 
>>> similar to the old fetch_comm_string implementation before your rewrite.
>>
>> Hmm, instead, I would like to add current->comm checker and only allows
>> to copy that. That would be simpler and enough.
>>
>> Could you test below patch?
>>
>>
>> tracing: uprobes: Re-enable $comm support for uprobe events
>>
>> From: Masami Hiramatsu <mhiramat@kernel.org>
>>
>> Since commit 533059281ee5 ("tracing: probeevent: Introduce new
>> argument fetching code") dropped the $comm support from uprobe
>> events, this re-enable it.

this should read 're-enables'.

>>
>> For $comm support, use strncpy() instead of strncpy_from_user()
                             ^
we're using strlcpy(), not strncpy().

>> to copy current task's comm. Because it is in the kernel space,
>> strncpy_from_user() always fails to copy the comm.
>> This also use strlen() instead of strlen_user() to measure the
               ^                        ^
'uses', and the function should be 'strnlen_user()'.

>> length of the comm.
>>
>> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
>> Reported-by: Andreas Ziegler <andreas.ziegler@fau.de>
>> ---
>>  kernel/trace/trace_uprobe.c |   13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
>> index e335576b9411..97d134e83e0f 100644
>> --- a/kernel/trace/trace_uprobe.c
>> +++ b/kernel/trace/trace_uprobe.c
>> @@ -156,7 +156,10 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
>>  	if (unlikely(!maxlen))
>>  		return -ENOMEM;
>>  
>> -	ret = strncpy_from_user(dst, src, maxlen);
>> +	if (addr == (unsigned long)current->comm)
>> +		ret = strlcpy(dst, current->comm, maxlen);
>> +	else
>> +		ret = strncpy_from_user(dst, src, maxlen);
>>  	if (ret >= 0) {
>>  		if (ret == maxlen)
>>  			dst[ret - 1] = '\0';
>> @@ -173,7 +176,10 @@ fetch_store_strlen(unsigned long addr)
>>  	int len;
>>  	void __user *vaddr = (void __force __user *) addr;
>>  
>> -	len = strnlen_user(vaddr, MAX_STRING_SIZE);
>> +	if (addr == (unsigned long)current->comm)
>> +		len = strlen(current->comm);
> 
> To balance with the strnlen_user, we must increse the len in this block.
> (strlen doesn't count the final '\0', but strnlen_user counts it)
> 

yes, we need to add a '+ 1' here.

With the typos and this one fixed, this is

Acked-by: Andreas Ziegler <andreas.ziegler@fau.de>

> Thank you,
> 
>> +	else
>> +		len = strnlen_user(vaddr, MAX_STRING_SIZE);
>>  
>>  	return (len > MAX_STRING_SIZE) ? 0 : len;
>>  }
>> @@ -213,6 +219,9 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
>>  	case FETCH_OP_IMM:
>>  		val = code->immediate;
>>  		break;
>> +	case FETCH_OP_COMM:
>> +		val = (unsigned long)current->comm;
>> +		break;
>>  	case FETCH_OP_FOFFS:
>>  		val = translate_user_vaddr(code->immediate);
>>  		break;
> 
> 

