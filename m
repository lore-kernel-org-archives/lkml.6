Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F85C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32A320866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hpCjeKqT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Npz1B8DB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32A320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeIKPpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:45:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42008 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeIKPpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:45:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 99C9F609A1; Tue, 11 Sep 2018 10:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536662774;
        bh=lKDwahSXQxWb1/f7tI9S3oU8rkg5qgXE0AzRwOwC4kA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hpCjeKqTkC85zhmK3D4XYebEApdtdiXasuOe9tvmIG5UFHKtaaJa3xktnrWI1J/QZ
         mFYsqeKh/KXJY0Os2wrcPDDdYnU5JH8oqLzzglN8YJ7UvGZ/6d0+jpHBctra4ZPvBc
         pAagCrUZ17N8Z+zU5uTFYXnPs4HP8UPGxO/PmqG4=
Received: from [10.79.128.64] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1B69D601B4;
        Tue, 11 Sep 2018 10:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536662772;
        bh=lKDwahSXQxWb1/f7tI9S3oU8rkg5qgXE0AzRwOwC4kA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Npz1B8DBZimuE+DjDcIgehnRRJnp4VUfwcvgtXcK3XZrdzb0HrhGdA7oo95R79L1D
         1WXPIYg27xOgOb2I1FFc628T1pkNzad63ffmCCGSld1UbpcHSFhc2WHnL68G/P5w3H
         ltn6N2OAUpnEpO/xYLLio3yMgRVEkYZbm8qcY2aI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B69D601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 2/6] pstore: Add event tracing support
To:     Steven Rostedt <rostedt@goodmis.org>,
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
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
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
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <444d7b13-2653-ba0e-e9e6-a448fded2a77@codeaurora.org>
Date:   Tue, 11 Sep 2018 16:16:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/2018 1:57 AM, Sai Prakash Ranjan wrote:
> +void notrace pstore_event_call(struct trace_event_buffer *fbuffer)
> +{
> +	struct trace_iterator *iter;
> +	struct trace_seq *s;
> +	struct trace_event_call *event_call;
> +	struct pstore_record record;
> +	struct trace_event *event;
> +	struct seq_buf *seq;
> +	unsigned long flags;
> +
> +	if (!psinfo)
> +		return;
> +
> +	if (unlikely(oops_in_progress))
> +		return;
> +
> +	pstore_record_init(&record, psinfo);
> +	record.type = PSTORE_TYPE_EVENT;
> +
> +	iter = kmalloc(sizeof(*iter), GFP_KERNEL);
> +	if (!iter)
> +		return;
> +
> +	event_call = fbuffer->trace_file->event_call;
> +	if (!event_call || !event_call->event.funcs ||
> +	    !event_call->event.funcs->trace)
> +		goto fail_event;
> +
> +	event = &fbuffer->trace_file->event_call->event;
> +
> +	spin_lock_irqsave(&psinfo->buf_lock, flags);
> +
> +	trace_seq_init(&iter->seq);
> +	iter->ent = fbuffer->entry;
> +	event_call->event.funcs->trace(iter, 0, event);
> +	trace_seq_putc(&iter->seq, 0);
> +
> +	if (seq->size > psinfo->bufsize)
> +		seq->size = psinfo->bufsize;
> +
> +	s = &iter->seq;
> +	seq = &s->seq;
> +
> +	record.buf = (char *)(seq->buffer);
> +	record.size = seq->len;
> +	psinfo->write(&record);
> +
> +	spin_unlock_irqrestore(&psinfo->buf_lock, flags);
> +
> +fail_event:
> +	kfree(iter);
> +}
> +
> 

When tracing sched events on sdm845 mtp, I hit below bug repeatedly.
Seems like pstore_event_call can be called in atomic context.
I will respin the below fix in next version of the patch.
Reviews on other parts would be appreciated, thanks.

diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
index d47dc93ac098..a497cf782ee8 100644
--- a/fs/pstore/ftrace.c
+++ b/fs/pstore/ftrace.c
@@ -73,6 +73,7 @@ void notrace pstore_event_call(struct 
trace_event_buffer *fbuffer)
         struct trace_event *event;
         struct seq_buf *seq;
         unsigned long flags;
+       gfp_t gfpflags;

         if (!psinfo)
                 return;
@@ -83,7 +84,9 @@ void notrace pstore_event_call(struct 
trace_event_buffer *fbuffer)
         pstore_record_init(&record, psinfo);
         record.type = PSTORE_TYPE_EVENT;

-       iter = kmalloc(sizeof(*iter), GFP_KERNEL);
+       gfpflags = (in_atomic() || irqs_disabled()) ? GFP_ATOMIC : 
GFP_KERNEL;
+
+       iter = kmalloc(sizeof(*iter), gfpflags);
         if (!iter)
                 return;

Backtrace:

[    0.433204] clocksource: Switched to clocksource arch_sys_counter
[    0.440035] pstore: using zlib compression
[    0.444265] BUG: sleeping function called from invalid context at 
/mnt/host/source/src/third_party/kernel/v4.14/mm/page_alloc.c:4134
[    0.444268] in_atomic(): 1, irqs_disabled(): 128, pid: 1, name: swapper/0
[    0.444277] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.14.65 #19
[    0.444286] Call trace:
[    0.444303] [<ffffff800808a91c>] dump_backtrace+0x0/0x254
[    0.444309] [<ffffff800808ab90>] show_stack+0x20/0x28
[    0.444320] [<ffffff8008913794>] dump_stack+0x90/0xb0
[    0.444329] [<ffffff80080d9080>] ___might_sleep+0x110/0x128
[    0.444332] [<ffffff80080d9110>] __might_sleep+0x78/0x88
[    0.444343] [<ffffff80081b83c4>] __alloc_pages_nodemask+0xe4/0xef4
[    0.444351] [<ffffff80081da1ac>] kmalloc_order+0x34/0x5c
[    0.444355] [<ffffff80081da210>] kmalloc_order_trace+0x3c/0x10c
[    0.444366] [<ffffff800832b5fc>] pstore_event_call+0x64/0x148
[    0.444374] [<ffffff800817b754>] trace_event_buffer_commit+0x230/0x25c
[    0.444379] [<ffffff80080d774c>] 
trace_event_raw_event_sched_stat_runtime+0x78/0xc8
[    0.444385] [<ffffff80080e4d5c>] update_curr+0x184/0x208
[    0.444388] [<ffffff80080e5fc0>] task_tick_fair+0x58/0x478
[    0.444394] [<ffffff80080dd834>] scheduler_tick+0x78/0xb4
[    0.444404] [<ffffff800811d714>] update_process_times+0x48/0x5c
[    0.444411] [<ffffff800812e198>] tick_sched_handle.isra.9+0x58/0x6c
[    0.444415] [<ffffff800812e1f4>] tick_sched_timer+0x48/0x84
[    0.444420] [<ffffff800811e218>] __hrtimer_run_queues+0x1f0/0x31c
[    0.444423] [<ffffff800811eb78>] hrtimer_interrupt+0xa8/0x1c8
[    0.444435] [<ffffff8008720bc8>] arch_timer_handler_phys+0x3c/0x48
[    0.444443] [<ffffff800810a750>] handle_percpu_devid_irq+0x124/0x27c
[    0.444448] [<ffffff8008104e48>] generic_handle_irq+0x30/0x44
[    0.444452] [<ffffff80081054dc>] __handle_domain_irq+0x90/0xbc
[    0.444457] [<ffffff8008081250>] gic_handle_irq+0x144/0x1ac
[    0.444460] Exception stack(0xffffff800805b5f0 to 0xffffff800805b730)
[    0.444465] b5e0:                                   0000000000000040 
ffffffc0fb2d8000
[    0.444468] b600: 00000040f7046000 ffffffffffffffff 0000000000000000 
0000000000000000
[    0.444472] b620: ffffffc0fb288f00 0720072007200720 0720072007200720 
0720072007200720
[    0.444475] b640: 0720072007200720 0720072007200720 0720072007200720 
0720072007200720
[    0.444479] b660: 0720072007200720 0000000000000010 0000000000000003 
0000000000004600
[    0.444482] b680: 000000000000000c ffffff8009152000 ffffff8009192000 
000000000000002e
[    0.444485] b6a0: ffffff8009192458 0000000000000000 0000000000000000 
ffffff8009031410
[    0.444490] b6c0: ffffff8008ec7018 ffffff8009031410 ffffff8009031000 
ffffff800805b730
[    0.444495] b6e0: ffffff80081030d4 ffffff800805b730 ffffff80081030dc 
0000000060c00049
[    0.444498] b700: 0000000000000000 ffffff80090916a0 ffffffffffffffff 
ffffff8008ec7018
[    0.444502] b720: ffffff800805b730 ffffff80081030dc
[    0.444506] [<ffffff8008082a30>] el1_irq+0xb0/0x124
[    0.444510] [<ffffff80081030dc>] console_unlock+0x27c/0x4e0
[    0.444512] [<ffffff80081035b0>] vprintk_emit+0x270/0x290
[    0.444515] [<ffffff80081037c0>] vprintk_default+0x7c/0x84
[    0.444518] [<ffffff8008104db8>] vprintk_func+0x154/0x180
[    0.444522] [<ffffff8008104448>] printk+0x80/0xa0
[    0.444525] [<ffffff800832a944>] pstore_register+0x148/0x1f8
[    0.444529] [<ffffff800832cb5c>] ramoops_probe+0x56c/0x6e8
[    0.444537] [<ffffff8008551d64>] platform_drv_probe+0x58/0xa4
[    0.444544] [<ffffff800854f9c4>] driver_probe_device+0x204/0x438
[    0.444547] [<ffffff800854fe44>] __device_attach_driver+0xf8/0x110
[    0.444552] [<ffffff800854d6dc>] bus_for_each_drv+0x98/0xc8
[    0.444556] [<ffffff800854f6ec>] __device_attach+0xac/0x150
[    0.444559] [<ffffff800854fe80>] device_initial_probe+0x24/0x30
[    0.444563] [<ffffff800854e96c>] bus_probe_device+0x38/0x98
[    0.444567] [<ffffff800854c478>] device_add+0x318/0x560
[    0.444575] [<ffffff8008737440>] of_device_add+0x44/0x50
[    0.444579] [<ffffff80087379f8>] 
of_platform_device_create_pdata+0x8c/0xc4
[    0.444582] [<ffffff8008737a64>] of_platform_device_create+0x34/0x40
[    0.444593] [<ffffff8008e3e9e8>] 
of_platform_default_populate_init+0x58/0xa8
[    0.444596] [<ffffff8008083558>] do_one_initcall+0xa0/0x138
[    0.444605] [<ffffff8008e00f10>] kernel_init_freeable+0x198/0x24c
[    0.444610] [<ffffff8008925a7c>] kernel_init+0x18/0x108
[    0.444616] [<ffffff800808477c>] ret_from_fork+0x10/0x18
[    0.856135] console [pstore-1] enabled
