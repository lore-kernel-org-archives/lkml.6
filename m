Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08F8ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 17:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D349208A3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 17:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A4SHPokC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N/aUkQpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D349208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeIVXke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 19:40:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60572 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbeIVXke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 19:40:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BB38660DD9; Sat, 22 Sep 2018 17:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537638371;
        bh=5iGM/oS6fptPo1x5d7UeBAteCjF71bYUubfE9UYFn9M=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=A4SHPokCmZ0rYIsQyiwX3c62ScmvvIcdVJpl7q186arwkW75wwyM+vG4GzY0cwuV7
         /XRRlY/2rld/U0NMVkJ9QvahcZpL9t7yFrIY68dBy7AyNX3hA51ziBEKeEvzLt/E7T
         bo4UievpKcPO0/DOhIIqsa05feTJfxrZVVJ1t2KM=
Received: from [192.168.43.47] (unknown [223.237.247.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2502F60DAD;
        Sat, 22 Sep 2018 17:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537638370;
        bh=5iGM/oS6fptPo1x5d7UeBAteCjF71bYUubfE9UYFn9M=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=N/aUkQpJvUu8bjZTiRLMhqulB2NOIAie/lmhMQKS2ELqwVuBZFn7l9QpD70vU7PhX
         7oVpST3omm4uU/tzNWun7hc37C/5u4Pn4Rt6v3bsMuGxMmQFZoaZab9+nvfaEqCEhS
         SPcmOfyWDlsmLsdLrgVhqlUwj5pLRJEntQjM3PUk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2502F60DAD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 2/6] pstore: Add event tracing support
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
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
 <e8fdef37-afcd-24b3-1005-e707b73f20b1@codeaurora.org>
Message-ID: <f4d51d5a-fe1d-8697-6dc0-3ead7dc4ed6d@codeaurora.org>
Date:   Sat, 22 Sep 2018 23:15:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e8fdef37-afcd-24b3-1005-e707b73f20b1@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/2018 10:07 PM, Sai Prakash Ranjan wrote:
> On 9/22/2018 2:35 PM, Joel Fernandes wrote:
>> On Sat, Sep 8, 2018 at 4:28 PM Sai Prakash Ranjan
>> <saiprakash.ranjan@codeaurora.org> wrote:
> 
> 
>> Also I think this spinlock can be moved further down.
>>
> 
> OK. Something like this would suffice?
> 
> {{{
> spin_lock_irqsave(&psinfo->buf_lock, flags);
> 
> record.buf = (char *)(seq->buffer);
> record.size = seq->len;
> psinfo->write(&record);
> 
> spin_unlock_irqrestore(&psinfo->buf_lock, flags);
> }}}
> 
> 

If I move the spinlock further down like above, I get this backtrace:

[    1.367708] console [pstore-1] enabled
[    1.368874] pstore: Registered ramoops as persistent store backend
[    1.372637] ramoops: attached 0x100000@0xbff00000, ecc: 0/0
[    1.389382] WARNING: CPU: 2 PID: 2 at kernel/trace/trace_output.c:289 
trace_raw_output_prep+0x18/0xa0
[    1.389416] Modules linked in:
[    1.397572] CPU: 2 PID: 2 Comm: kthreadd Not tainted 
4.19.0-rc4-00032-g71e30ed20433-dirty #9
[    1.409122] pstate: 80000005 (Nzcv daif -PAN -UAO)
[    1.415804] pc : trace_raw_output_prep+0x18/0xa0
[    1.420404] lr : trace_raw_output_sched_process_fork+0x1c/0x70
[    1.425176] sp : ffff00000803bc00
[    1.430815] x29: ffff00000803bc00 x28: ffff80003ca68d80
[    1.434204] x27: ffff00000810d000 x26: 0000000000000001
[    1.439586] x25: 0000000000000000 x24: ffff80000eb05090
[    1.444881] x23: ffff80003ca68d80 x22: ffff00000803bd58
[    1.450176] x21: ffff000009e63000 x20: ffff80003cbf8988
[    1.455470] x19: ffff80000eb04000 x18: ffffffffffffffff
[    1.460766] x17: 000000000006df2c x16: 0000000000000000
[    1.466061] x15: ffff000009b496c8 x14: 0000000000000040
[    1.471356] x13: ffffffffffffffff x12: 0000000000000000
[    1.476651] x11: ffff80003c49a6a8 x10: 00000000000005d8
[    1.481947] x9 : ffff80003c89f400 x8 : ffff00000803bc60
[    1.487242] x7 : 0000000000000034 x6 : 0000000005d97d4a
[    1.492536] x5 : 00ffffffffffffff x4 : 0000000000000050
[    1.497831] x3 : 0000000000000056 x2 : ffff000009b657a0
[    1.503127] x1 : ffff000009b657c0 x0 : ffff80000eb04000
[    1.508422] Call trace:
[    1.513716]  trace_raw_output_prep+0x18/0xa0
[    1.515890]  pstore_event_call+0xbc/0x130
[    1.520402]  trace_event_buffer_commit+0xf8/0x248
[    1.524308]  trace_event_raw_event_sched_process_fork+0xc0/0xf8
[    1.528999]  _do_fork+0x234/0x418
[    1.534724]  kernel_thread+0x48/0x58
[    1.538196]  kthreadd+0x178/0x1f0
[    1.541842]  ret_from_fork+0x10/0x1c
[    1.545052] ---[ end trace 97d58905d13e7aea ]---
[    1.560654] s1: supplied by regulator-dummy
[    1.560714] s1: Bringing 0uV into 375000-375000uV

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
