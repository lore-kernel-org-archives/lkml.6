Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7512EECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62472146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n8gxN29I";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e35IKDB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62472146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbeISCsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 22:48:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48348 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbeISCsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 22:48:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 668DB60C54; Tue, 18 Sep 2018 21:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537305233;
        bh=VQwTAayGUzUy0CZjvYqH2mTee36S4Xe4ScKUf6F/1B4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=n8gxN29IKo6zYlbJCv8mO3l9BRy+ckD5ypfmVKuQCG8TydgJZZHtwtr1EYteeYauk
         KdqqH4c9v+x83oncz3s6VxKrZ13xnG9To75SzqKaSVcQtu542GUcEZBxnmbzLaMmqm
         SPZo/vksdpL6QV3COucnTT2ft3ohxNcIj8XyQKdY=
Received: from [192.168.43.47] (unknown [27.59.117.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 07AC86034E;
        Tue, 18 Sep 2018 21:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537305231;
        bh=VQwTAayGUzUy0CZjvYqH2mTee36S4Xe4ScKUf6F/1B4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=e35IKDB9R9ZpmY9waHBJxzb74BlAKuFvFAM6BNQmE3t75WoW4n94ldnSQWRH1Nf19
         5h/sZEovyW216jIrrmSyiMJ7yAow0GOYtuJr0VGSU87KeR79OIhCPd3Aet1MWkbTb6
         HUYOO+H5n1ArQpaxdE5OhTD9/YKt2F7cJNTvnVhk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 07AC86034E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 2/6] pstore: Add event tracing support
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, Bryan Huntsman <bryanh@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <20180917193426.41c99fd5@gandalf.local.home>
 <cb17a8c9-fca1-5492-3255-eab0ea33577c@codeaurora.org>
 <20180918164434.472294f3@gandalf.local.home>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <bad69c36-2600-f0b3-5bfd-c865039ae97f@codeaurora.org>
Date:   Wed, 19 Sep 2018 02:43:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918164434.472294f3@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/2018 2:14 AM, Steven Rostedt wrote:
> On Tue, 18 Sep 2018 23:22:48 +0530
> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> 
>> On 9/18/2018 5:04 AM, Steven Rostedt wrote:
>>>
>>> It looks like pstore_event_call() gets called from a trace event. You
>>> can't call kmalloc() from one. One thing is that kmalloc has
>>> tracepoints itself. You trace those you just entered an infinite loop.
>>>
>>>    
>>
>> Ok will remove it in v2. But any alternative way to do this?
> 
> I think I describe it below.
> 

Ok got it, will change and post the 2nd version soon.

>>
>>>> +
>>>> +	event_call = fbuffer->trace_file->event_call;
>>>> +	if (!event_call || !event_call->event.funcs ||
>>>> +	    !event_call->event.funcs->trace)
>>>> +		goto fail_event;
>>>> +
>>>> +	event = &fbuffer->trace_file->event_call->event;
>>>> +
>>>> +	spin_lock_irqsave(&psinfo->buf_lock, flags);
>>>> +
>>>> +	trace_seq_init(&iter->seq);
>>>> +	iter->ent = fbuffer->entry;
>>>
>>> I guess what you are doing is needing to translate the raw data into
>>> ascii output, and need the trace_iterator to do so.
>>>
>>> You are already under a psinfo->buf_lock. Add a dummy iterator to that
>>> and use it instead.
>>>
>>> 	trace_seq_init(&psinfo->iter->seq);
>>>    
>>>> +	event_call->event.funcs->trace(iter, 0, event);
>>>
>>> 				      (psinfo->iter, 0 , event);
>>>
>>> etc.
>>>    
>>
>> Sure, will update in v2.
>>
>>>> +	trace_seq_putc(&iter->seq, 0);
>>>> +
>>>> +	if (seq->size > psinfo->bufsize)
>>>> +		seq->size = psinfo->bufsize;
>>>> +
>>>> +	s = &iter->seq;
>>>> +	seq = &s->seq;
>>>> +
>>>> +	record.buf = (char *)(seq->buffer);
>>>> +	record.size = seq->len;
>>>> +	psinfo->write(&record);
>>>> +
>>>> +	spin_unlock_irqrestore(&psinfo->buf_lock, flags);
>>>
>>> You may also need to convert these spin_locks into raw_spin_locks as
>>> when PREEMPT_RT enters the kernel you don't want them to turn into
>>> mutexes.
>>>
>>> But that can be another patch.
>>>    
>>
>> I will change this in v2, but can't we have it in same patch?
> 
> I suggested a separate patch because buf_lock is used elsewhere.
> Changing it to "raw_spin_lock" will affect more than just what this
> patch series does. Thus, I recommend making it a separate patch to keep
> this patch series from being more intrusive than it needs to be.
> 

Sure, thanks a lot.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
