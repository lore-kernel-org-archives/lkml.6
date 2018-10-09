Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF8CECDFDF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806F320835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MjhIfQf1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Zcbcsg54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806F320835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbeJJBks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 21:40:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51748 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeJJBkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 21:40:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 50BA160C62; Tue,  9 Oct 2018 18:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539109352;
        bh=ci6DRu+IuaSD6gh6gpDJOAyakDVlk6SW0YQLHzM9Skc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MjhIfQf1iulRvQh4yr1C2Qa4ffbAlZh/N9WKUGfXqrjh2FlZVrv/d+AxAEyT5qzBf
         bIAdEJW/Tqb65M7TARnW+T1a/k6N68KBpKZZQbnjgz9pk1WaxqLBRZDSOs7T04zu/i
         HPODw3go7jfImJHx1teUwpsPqAZIGoStn111EEQE=
Received: from [192.168.43.47] (unknown [106.206.17.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2233960BFE;
        Tue,  9 Oct 2018 18:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539109350;
        bh=ci6DRu+IuaSD6gh6gpDJOAyakDVlk6SW0YQLHzM9Skc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Zcbcsg54REHHvpoipKr/ZIB1Y+D3EXcE3pEwApnd255QxIq6w29hKgYPVz71AqLeD
         26SSBcUbpUaAiOQnTCy102mDXiP6bp0bCy2NcRllpKOrQ5urtL6Tr4ddsXxqk/Wmdo
         s1JRckZjl3viJMg1xm6ZwnGRtCdmRM20vF8Wzq7k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2233960BFE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 3/6] tracing: Add tp_pstore cmdline to have tracepoints go
 to pstore
To:     Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>, tsoni@codeaurora.org,
        Anton Vorontsov <anton@enomsg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>, devicetree@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        Jason Baron <jbaron@akamai.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        Tony Luck <tony.luck@intel.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jim Cromie <jim.cromie@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bryan Huntsman <bryanh@codeaurora.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kernel-team@android.com, Colin Cross <ccross@android.com>,
        Joe Perches <joe@perches.com>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <f65e9fa6e047b9b14d4f64362f9fe1f89b306050.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <CAEXW_YRQtJb=3V0RKHSAejfQXKssh5qBp7nmD1OUC-wTyqGDEQ@mail.gmail.com>
 <1f546234-bd7b-448a-3666-3f8baa249608@codeaurora.org>
 <08f1fadc-3ce7-4bef-ba17-e038b8450fc8@codeaurora.org>
 <20181008103659.5bc14b28@gandalf.local.home>
 <20181008224056.GA213420@joelaf.mtv.corp.google.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <174a465d-aedd-6561-e4e5-1f97ca4d0b0a@codeaurora.org>
Date:   Tue, 9 Oct 2018 23:52:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008224056.GA213420@joelaf.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/2018 4:10 AM, Joel Fernandes wrote:
> On Mon, Oct 08, 2018 at 10:36:59AM -0400, Steven Rostedt wrote:
>> On Mon, 8 Oct 2018 19:46:15 +0530
>> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
>>
>>> Hi Joel,
>>>
>>> Sorry for the long delay in updating this thread.
>>> But I just observed one weird behaviour in ftrace-ramoops when I was
>>> trying to use binary record instead of rendering text for event-ramoops.
>>>
>>> Even though we set the ftrace-size in device tree for ramoops, the
>>> actual ftrace-ramoops record seems to have more records than specified size.
>>> Is this expected or some bug?
>>
>> If ftrace-ramoops is using logic similar to the ftrace ring buffer,
>> then yes, it will be able to store more events than specified. The
>> ftrace ring buffer is broken up into pages, and everything is rounded
>> up to the nearest page (note, the data may be smaller than a page,
>> because each page also contains a header).
> 
> In the pstore code, the pages are contiguous. The platform drivers for that
> platform configure 'ftrace-size' which is in bytes. That is further divided
> by the number of CPUs. The records from all the buffers are then merged at read time.
> 
> Each function trace record is of type:
> struct pstore_ftrace_record {
>          unsigned long ip;
>          unsigned long parent_ip;
>          u64 ts;
> };
> 
> which should be 24 bytes.
> 
> But there is an ECC block (with ECC data and ECC header) added to each CPU in
> this case of the backing store of the pstore being RAM (pstore backing stores
> can be other media types too).
> 

Thanks for this info.

>>> Below is the ftrace-ramoops size passed in dtsi for db410c and we can
>>> see that the ftrace record is more.
>>>
>>> # cat /sys/module/ramoops/parameters/ftrace_size
>>> 131072
>>
>> I'm assuming this too is like the ftrace ring buffer, where the size is
>> per cpu (and why you do a search per cpu below).
>>
>>> #
>>> # cat /sys/fs/pstore/ftrace-ramoops-0 | wc -c
>>> 560888
>>> #
>>> # cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:0 | wc -c
>>> 137758
>>> #
>>> # cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:1 | wc -c
>>> 140560
>>> #
>>> # cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:2 | wc -c
>>> 141174
>>> #
>>> # cat /sys/fs/pstore/ftrace-ramoops-0 | grep CPU:3 | wc -c
>>> 141396
>>> #
> 
> That could be because you're counting text characters when you're counting.
> You need to count the binary size.
> 

Right thanks.

>> If you are using binary record, isn't this what you want? The
>> ftrace_size is the size of how much binary data is stored. When you
>> translate the binary into human text, the text should be bigger.
>>
>>> I don't see this in console or dmesg ramoops and also with the
>>> event-ramoops which I have posted since we don't use binary record, only
>>> ftrace-ramoops uses binary record to store trace data.
>>>
>>> Also regarding the warning on "event_call->event.funcs->trace()" call,
>>> I see it everytime without spinlock. Also we see output_printk using
>>> spinlock when making this call. I could not find a way to pass event
>>> buffer size and allocate in pstore. Steven can give some hints with this
>>> I guess.
> 
> The spinlock warning you're talking about is this one correct?
> 
> [    1.389382] WARNING: CPU: 2 PID: 2 at kernel/trace/trace_output.c:289 trace_raw_output_prep+0x18/0xa0
> [    1.389416] Modules linked in:
> which you reported here:
> https://lkml.org/lkml/2018/9/22/319
> 
> This warning happens I think because you're trying to format the events while
> the trace events are being generated. You said you got this warning when you
> didn't use the spinlock. I believe the spinlocking prevents such races, but
> if you didn't need to format the events into text into text in the first
> place, then you wouldn't need such locking at all.
> 
> I believe ftrace doesn't have such issues because such locking is taken care
> off when the trace events are formatted from the trace buffer and displayed,
> but I could be wrong about that.. I'll let Steven provide more inputs about
> how this warning can occur.
Yes Steven would have more insight on this warning.

> 
> As a suggestion, please always provide references to the warnings you're
> referring to, such as previous LKML posts or atleast the warning message so
> folks know which warning you're talking about.
> 

Yes sure.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
