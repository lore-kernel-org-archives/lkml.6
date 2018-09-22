Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEF3C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 16:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3C820883
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 16:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QcIhpgiR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g0KkklPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3C820883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbeIVWbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 18:31:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39974 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbeIVWbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 18:31:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CA89F60E40; Sat, 22 Sep 2018 16:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537634241;
        bh=zT/NbF/QSNZxCN2Yx3mpwRGqaFPsmMELlfVQoUUMaN0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QcIhpgiRObHzOg2MWh6RzX+R59IMlWsQVynEJ4teOwPj8+p6wnaSUgyXEUANeBpoy
         4epGetb0jWD3Z8f0zKtLeDpygTSHRR1JS7jZPhljmxiy5O0708cOeenR7fbpNXyWS7
         NunQ54MQW2AFDLQqW1C4lbQiQc4FgBFoD5m7MecU=
Received: from [192.168.43.47] (unknown [223.237.247.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5FF3C60D0B;
        Sat, 22 Sep 2018 16:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537634240;
        bh=zT/NbF/QSNZxCN2Yx3mpwRGqaFPsmMELlfVQoUUMaN0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=g0KkklPCT8yA/qql/1thP7soA362xV+VOdYXwIJspSRclunsXogZovj1sySxgFQz/
         vJ0dsVsTt894SIu8BPmp4XmQ5RBOCPrcLqDPr5uD//uzHegYv00/YkL036esRFlsyh
         p/xywuVD6HLpGtWNyjXxOn328G9knkoZFNJRMvGg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5FF3C60D0B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 2/6] pstore: Add event tracing support
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, Bryan Huntsman <bryanh@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        kernel-team <kernel-team@android.com>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <CAEXW_YRXQwKvnahv5X1F_Bu_98vMg=w1xpo8PZ+aNT02vBrwwg@mail.gmail.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <e8fdef37-afcd-24b3-1005-e707b73f20b1@codeaurora.org>
Date:   Sat, 22 Sep 2018 22:07:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAEXW_YRXQwKvnahv5X1F_Bu_98vMg=w1xpo8PZ+aNT02vBrwwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/2018 2:35 PM, Joel Fernandes wrote:
> On Sat, Sep 8, 2018 at 4:28 PM Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>>
> Could you just split the pstore space into a per-cpu event buffer like
> we are doing for ftrace-on-pstore? Then you don't need to lock. I fear
> the lock contention will be apparent. The pstore code already has
> plumbing to split the store buffer per CPU.
> 

Hi Joel,

Thanks a lot for reviewing.

I just looked at per-cpu buffer for ftrace and itseems the pstore percpu 
records will need to be merged into one record if we add this support 
for events. Merging of ftrace logs is based on timestamp, but for events 
we do not have timestamp field (for this specific reason I have added 
timestamp field for IO event tracing so that atleast we can know the cpu 
number in pstore output). For example, the sched event pstore output 
below has no timestamp field, so how do we merge per-cpu logs?

# tail /sys/fs/pstore/event-ramoops-0
sched_waking: comm=rcu_sched pid=11 prio=120 target_cpu=002
sched_wakeup: comm=rcu_sched pid=11 prio=120 target_cpu=002

Also Pstore ftrace log format is fixed i.e.,(CPU:%d ts:%llu %08lx  %08lx 
  %pf <- %pF\n"), but different events will have different formats and 
we will not be able to add timestamp field like how pstore ftrace does 
using  pstore_ftrace_write_timestamp() and pstore_ftrace_read_timestamp().

Sorry if I am confusing you, I can explain better I guess.

> Also I think this spinlock can be moved further down.
> 

OK. Something like this would suffice?

{{{
spin_lock_irqsave(&psinfo->buf_lock, flags);

record.buf = (char *)(seq->buffer);
record.size = seq->len;
psinfo->write(&record);

spin_unlock_irqrestore(&psinfo->buf_lock, flags);
}}}

>> +
>> +       trace_seq_init(&iter->seq);
>> +       iter->ent = fbuffer->entry;
>> +       event_call->event.funcs->trace(iter, 0, event);
>> +       trace_seq_putc(&iter->seq, 0);
> 
> Would it be possible to store the binary trace record in the pstore
> buffer instead of outputting text? I suspect that will both be faster
> and less space.
> 

I will try this and come back.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
