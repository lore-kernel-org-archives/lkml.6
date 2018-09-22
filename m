Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143FDC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 06:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D92121567
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 06:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F6YKhIdc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ht5iC4o+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D92121567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeIVMlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 08:41:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57094 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeIVMlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 08:41:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A36EC61015; Sat, 22 Sep 2018 06:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537598952;
        bh=Qc/Z8hH2he3TstOd5b5Z0cZhxfO3r9EiHeCvz9+vONY=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=F6YKhIdccktpkRtW1HwuQblN2l20wmSG9iG9ocQvQUz2/mVU4x1dHWI+PVz3PxyKH
         YnV5f3Y1B7/ePjn77EHt38hfPOmN4i50FELt7uMY0PNg/wU808LMJTIKIb1ph34CZb
         mbu9PnA5+x/iXFE6GOjGlvy+h90//qYgjI66xsCg=
Received: from [192.168.43.47] (unknown [223.186.123.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2FA25606FA;
        Sat, 22 Sep 2018 06:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537598951;
        bh=Qc/Z8hH2he3TstOd5b5Z0cZhxfO3r9EiHeCvz9+vONY=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=ht5iC4o+XOuAbkPV0tKRWN/yq6xKazwjCS/bI/KN0jGzdSrP9OovOgufKAEdBv0u9
         95SM6r1Z28dHmBVR4JNjbSEgOsgOuTy3cd9GJW10aSBypA7KzLkDZ4bx5eJOAnbflx
         z+Gi5WbobXUZP8+Q2wn7g95ljkOMpZEi5F39jFF0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2FA25606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 2/6] pstore: Add event tracing support
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
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
 <bad69c36-2600-f0b3-5bfd-c865039ae97f@codeaurora.org>
Message-ID: <8cb8851c-ab65-98ba-81ca-ba36957dc852@codeaurora.org>
Date:   Sat, 22 Sep 2018 12:18:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bad69c36-2600-f0b3-5bfd-c865039ae97f@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/2018 2:43 AM, Sai Prakash Ranjan wrote:
> On 9/19/2018 2:14 AM, Steven Rostedt wrote:
>> On Tue, 18 Sep 2018 23:22:48 +0530
>> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
>>
>>> On 9/18/2018 5:04 AM, Steven Rostedt wrote:
>>>>
>>>> It looks like pstore_event_call() gets called from a trace event. You
>>>> can't call kmalloc() from one. One thing is that kmalloc has
>>>> tracepoints itself. You trace those you just entered an infinite loop.
>>>>
>>>
>>> Ok will remove it in v2. But any alternative way to do this?
>>
>> I think I describe it below.
>>
> 
> Ok got it, will change and post the 2nd version soon.
> 

Hi Steven,

Instead of dummy iterator, can't we have something like below, there 
won't be any infinite loop if we trace kmalloc in this case. This is 
same as tp_printk.

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 018cbbefb769..271b0573f44a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8644,8 +8644,14 @@ void __init early_trace_init(void)
                         static_key_enable(&tracepoint_printk_key.key);
         }

-       if (tracepoint_pstore)
-               static_key_enable(&tracepoint_pstore_key.key);
+       if (tracepoint_pstore) {
+               tracepoint_pstore_iter =
+                       kmalloc(sizeof(*tracepoint_pstore_iter), 
GFP_KERNEL);
+               if (WARN_ON(!tracepoint_pstore_iter))
+                       tracepoint_pstore = 0;
+               else
+                       static_key_enable(&tracepoint_pstore_key.key);
+       }

         tracer_alloc_buffers();
  }
diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
index f5263b6fb96f..0534546aef6d 100644
--- a/fs/pstore/ftrace.c
+++ b/fs/pstore/ftrace.c
@@ -73,7 +73,6 @@ void notrace pstore_event_call(struct 
trace_event_buffer *fbuffer)
         struct trace_event *event;
         struct seq_buf *seq;
         unsigned long flags;
-       gfp_t gfpflags;

         if (!psinfo)

         if (!psinfo)
                 return;
@@ -81,20 +80,17 @@ void notrace pstore_event_call(struct 
trace_event_buffer *fbuffer)
         if (unlikely(oops_in_progress))
                 return;

-       pstore_record_init(&record, psinfo);
-       record.type = PSTORE_TYPE_EVENT;
-
-       /* Can be called in atomic context */
-       gfpflags = (in_atomic() || irqs_disabled()) ? GFP_ATOMIC : 
GFP_KERNEL;
-
-       iter = kmalloc(sizeof(*iter), gfpflags);
+       iter = tracepoint_pstore_iter;
         if (!iter)
                 return;

+       pstore_record_init(&record, psinfo);
+       record.type = PSTORE_TYPE_EVENT;
+
         event_call = fbuffer->trace_file->event_call;
         if (!event_call || !event_call->event.funcs ||
             !event_call->event.funcs->trace)
-               goto fail_event;
+               return;

         event = &fbuffer->trace_file->event_call->event;

@@ -116,9 +112,6 @@ void notrace pstore_event_call(struct 
trace_event_buffer *fbuffer)
         psinfo->write(&record);

         spin_unlock_irqrestore(&psinfo->buf_lock, flags);
-
-fail_event:
-       kfree(iter);
  }

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
