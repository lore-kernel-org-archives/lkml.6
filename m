Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561C6ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86F62086E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ONo8PHwm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DmGpfp9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86F62086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeJSO7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 10:59:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42046 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbeJSO7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 10:59:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EB1F060B73; Fri, 19 Oct 2018 06:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539932057;
        bh=Sro5rLP1zks4xnLrYUKVViZYycmd0Ebsy4ilLXACb4M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ONo8PHwmO4w8Hw9PVeXY6vvmxNesr0Wi1JaZk5hASZe2Z7GDA1ZcOgt0v9Y14nhn9
         r4CrOt4u8i9MBJpPUO1LpdeZjcYk9X08uwbon4/cAHKUWkgL58xUWmg9m+MqGtwX/l
         THWl301yicJmOXvh8saOCNp+upsXa4AcsEPG+KKw=
Received: from [192.168.43.47] (unknown [223.227.22.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 608A360364;
        Fri, 19 Oct 2018 06:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539932056;
        bh=Sro5rLP1zks4xnLrYUKVViZYycmd0Ebsy4ilLXACb4M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DmGpfp9qDLVUMg8xB7yD/9fZuMmlzkQwDoAfq8suHZrLuLPK5YIdVgOtq1wVVx5Bj
         ln6sGih37H52X4kRWb2SKww7VhvA8StoenqCt6W4Yao0jO/6CNuhfIJW+zRWYjNh/a
         b++Wpmz1Bp2WGx02dPnUWX0LgxR8nYax8pr4kdvA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 608A360364
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
To:     Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pramod Gurav <gpramod@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
References: <472db11e-49a6-a1ee-e298-791ee1bbb10b@codeaurora.org>
 <20181016141610.639b9000@gandalf.local.home>
 <accdce6d-8fd2-9f15-d4cd-704cbf0b32eb@codeaurora.org>
 <20181016144123.24c47b38@gandalf.local.home>
 <7781815e-cba2-9e36-db6d-268298747876@codeaurora.org>
 <20181016150328.3450d718@gandalf.local.home>
 <c94103d2-ed5d-bf43-fc71-c60e108f303e@codeaurora.org>
 <20181017223334.29ca2837@vmware.local.home>
 <58d2474c-53cd-e6cb-2d25-db38d1a88da6@codeaurora.org>
 <20181018091706.62310b38@gandalf.local.home>
 <20181019041740.GB141835@joelaf.mtv.corp.google.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <8a75f2d5-f1bd-504e-b545-ae2e2f61ca8f@codeaurora.org>
Date:   Fri, 19 Oct 2018 12:24:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181019041740.GB141835@joelaf.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/2018 9:47 AM, Joel Fernandes wrote:
> On Thu, Oct 18, 2018 at 09:17:06AM -0400, Steven Rostedt wrote:
>> On Thu, 18 Oct 2018 10:51:18 +0530
>> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
>>
>>>> So something else is causing an issue besides just msm_read.
>>>>
>>>> Can you do an objdump -dr of the entire vmlinux binary and gzip it and
>>>> post it somewhere. Not sure if it would be too big to email. You could
>>>> try sending it to me privately. I'd like to see the binary that you are
>>>> using.
>>>>    
>>>
>>> I have sent the objdump and dot config to you privately.
>>
>> Thanks. I don't see anything that pops out, but then again, my arm asm
>> foo is very rusty (it has been literally decades since I did any arm
>> asm). I wonder if it could simply be a timing issue?
>>
>> ffff0000086eb538 <msm_read.isra.1>:
>> ffff0000086eb538:       a9be7bfd        stp     x29, x30, [sp,#-32]!
>> ffff0000086eb53c:       910003fd        mov     x29, sp
>> ffff0000086eb540:       a90153f3        stp     x19, x20, [sp,#16]
>> ffff0000086eb544:       aa0003f4        mov     x20, x0
>> ffff0000086eb548:       2a0103f3        mov     w19, w1
>> ffff0000086eb54c:       aa1e03e0        mov     x0, x30
>> ffff0000086eb550:       97e6bae4        bl      ffff00000809a0e0 <_mcount>
>>
>> The above is changed to nop on boot, but then to:
>>
>> 	bl ftrace_caller
>>
>> When ftrace is enabled.
>>
>> ffff0000086eb554:       8b334280        add     x0, x20, w19, uxtw
>> ffff0000086eb558:       b9400000        ldr     w0, [x0]
>> ffff0000086eb55c:       a94153f3        ldp     x19, x20, [sp,#16]
>> ffff0000086eb560:       a8c27bfd        ldp     x29, x30, [sp],#32
>> ffff0000086eb564:       d65f03c0        ret
>>
>>
>>
>> ffff00000809a0e4 <ftrace_caller>:
>> ffff00000809a0e4:       a9bf7bfd        stp     x29, x30, [sp,#-16]!
>> ffff00000809a0e8:       910003fd        mov     x29, sp
>> ffff00000809a0ec:       d10013c0        sub     x0, x30, #0x4
>> ffff00000809a0f0:       f94003a1        ldr     x1, [x29]
>> ffff00000809a0f4:       f9400421        ldr     x1, [x1,#8]
>> ffff00000809a0f8:       d1001021        sub     x1, x1, #0x4
>>
>> ffff00000809a0fc <ftrace_call>:
>> ffff00000809a0fc:       d503201f        nop
>>
>> The above nop gets patched to:
>>
>> 	bl ftrace_ops_no_ops
>>
>> Which will iterate through all the registered functions.
>>
>>
>> ffff00000809a100 <ftrace_graph_call>:
>> ffff00000809a100:       d503201f        nop
>>
>> The above only gets set when function graph tracer is enabled, which it
>> is not in this case.
>>
>> ffff00000809a104:       a8c17bfd        ldp     x29, x30, [sp],#16
>> ffff00000809a108:       d65f03c0        ret
>>
>>
>> Anyone see any problems here?
> 
> This seems sane to me, he says in the other thread that he put 'notrace' to
> the msm serial functions (which AIUI should prevent ftrace instrumentation)
> and he still sees the issue.
> 

Yes I did add notrace to all functions in msm serial and checked the 
objdump to make sure that those were not instrumented, and yet the 
target crashed. This doesnt seem like an issue with ftrace but rather 
with msm early con.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
