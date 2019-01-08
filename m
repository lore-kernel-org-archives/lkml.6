Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53164C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F42E20850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSlHBvja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfAHKbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:31:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35267 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfAHKbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:31:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so3506200wrb.2;
        Tue, 08 Jan 2019 02:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mA+o/tumhnHwsweFr2kiAOw3rjX0qpLK1pDcred9wPI=;
        b=aSlHBvja+XeFRF/ZPDWyjL3/5L3aI/4GCIqnyovUSId9OnwebBaOQWvfWy4/U/pOLt
         +ankXkB82MTNKi8QhfN2jjqMhcDLOmmqHlDEWL4jwmoYBpJz9xGH/l3yl4RLqAbJJsgz
         2UJXtLzhVLjuUeE47je0+4t7gyJlgMgL0Q1ysXlEMQFHOTGLGCQOUR194vJRHVi0p0It
         lHWT1n3rfrXM7y8LU0xVALPVo2IBq2BNFfvDrP5sSktuEtA6eYu8ivkVUWtiOvd65HJz
         xegSu5NwnWnQrY7Powm2M2Yh4FxfcMIYZeattzhia2BOcCLeskxc6zTlE0oNQmJ73EIC
         QljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mA+o/tumhnHwsweFr2kiAOw3rjX0qpLK1pDcred9wPI=;
        b=T1Mj78l7QFKvILMnr6N9C25U59SAfvvCPlAqsDHkZZFMMPhH6JNfXhKEPYTyqHYrdv
         eGlpGYi0tJNmkgZht6lX1BXVLlF4UGh9Rbw7i2LqZdAXYFblsBDB4UxctrHk3RP81h5v
         vMvU42ye5h6xGe139Vk3QTQxJYv/Qfl87WdbqsHeCJ30SlEzOLgUJYGg3EOjY6T98uUq
         73OZAowNL0yX/1DiKBnBnKXI5FcI5Tv8+7nH1jujXMDVzeXVH+N4tFxWi//3QoDa0t9z
         PYvolia1mumqGb1gc/HkQxVYQ/gY5hlOgj2uSMhfJQA86plRK5Vos451F9hQaLizJbWp
         vNGQ==
X-Gm-Message-State: AJcUukeguv18i9j2zFad50TKVIJd5ANH+gRmwKA9lbOlFTtALb6pRySR
        vpfhsSJQb7sG+Hm4HxeUPQ==
X-Google-Smtp-Source: ALg8bN7SGF/hLrdR+eMkeOQS5tvYRonSc4UPdvCe2g+R1Ab6y2tJP4E7PFd2oT2JD5lXrpLzXunb3A==
X-Received: by 2002:adf:9246:: with SMTP id 64mr1077687wrj.130.1546943462930;
        Tue, 08 Jan 2019 02:31:02 -0800 (PST)
Received: from localhost (host89-130-dynamic.43-79-r.retail.telecomitalia.it. [79.43.130.89])
        by smtp.gmail.com with ESMTPSA id k128sm12226301wmd.37.2019.01.08.02.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 02:31:02 -0800 (PST)
Date:   Tue, 8 Jan 2019 11:31:01 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] kprobes: Fix kretprobe issues
Message-ID: <20190108103101.GE5966@xps-13>
References: <154692263564.1133.17363562046971295490.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154692263564.1133.17363562046971295490.stgit@devbox>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 01:43:55PM +0900, Masami Hiramatsu wrote:
> Hello,
> 
> This is v2 series of fixing kretprobe incorrect stacking order patches.
> In this version, I fixed a lack of kprobes.h including and added new
> patch for kretprobe trampoline recursion issue. (and add Cc:stable)
> 
> (1) kprobe incorrct stacking order problem
> 
> On recent talk with Andrea, I started more precise investigation on
> the kernel panic with kretprobes on notrace functions, which Francis
> had been reported last year ( https://lkml.org/lkml/2017/7/14/466 ).
> 
> See the investigation details in 
> https://lkml.kernel.org/r/154686789378.15479.2886543882215785247.stgit@devbox
> 
> When we put a kretprobe on ftrace_ops_assist_func() and put another
> kretprobe on probed-function, below happens
> 
> <caller>
>  -><probed-function>
>    ->fentry
>     ->ftrace_ops_assist_func()
>      ->int3
>       ->kprobe_int3_handler()
>       ...->pre_handler_kretprobe()
>            push the return address (*fentry*) of ftrace_ops_assist_func() to
>            top of the kretprobe list and replace it with kretprobe_trampoline.
>       <-kprobe_int3_handler()
>      <-(int3)
>      ->kprobe_ftrace_handler()
>       ...->pre_handler_kretprobe()
>            push the return address (caller) of probed-function to top of the
>            kretprobe list and replace it with kretprobe_trampoline.
>      <-(kprobe_ftrace_handler())
>     <-(ftrace_ops_assist_func())
>     [kretprobe_trampoline]
>      ->tampoline_handler()
>        pop the return address (caller) from top of the kretprobe list
>      <-(trampoline_handler())
>     <caller>
>     [run caller with incorrect stack information]
>    <-(<caller>)
>   !!KERNEL PANIC!!
> 
> Therefore, this kernel panic happens only when we put 2 k*ret*probes on
> ftrace_ops_assist_func() and other functions. If we put kprobes, it
> doesn't cause any issue, since it doesn't change the return address.
> 
> To fix (or just avoid) this issue, we can introduce a frame pointer
> verification to skip wrong order entries. And I also would like to
> blacklist those functions because those are part of ftrace-based 
> kprobe handling routine.
> 
> (2) kretprobe trampoline recursion problem
> 
> This was found by Andrea in the previous thread
> https://lkml.kernel.org/r/20190107183444.GA5966@xps-13
> 
> ----
>  echo "r:event_1 __fdget" >> kprobe_events
>  echo "r:event_2 _raw_spin_lock_irqsave" >> kprobe_events
>  echo 1 > events/kprobes/enable
>  [DEADLOCK]
> ----
> 
> Because kretprobe trampoline_handler uses spinlock for protecting
> hash table, if we probe the spinlock itself, it causes deadlock.
> Thank you Andrea and Steve for discovering this root cause!!
> 
> This bug has been introduced with the asm-coded trampoline
> code, since previously it used another kprobe for hooking
> the function return placeholder (which only has a nop) and
> trampoline handler was called from that kprobe.
> 
> To fix this bug, I introduced a dummy kprobe and set it in
> current_kprobe as we did in old days.
> 
> Thank you,

It looks all good to me, with this patch set I couldn't break the
kernel in any way.

Tested-by: Andrea Righi <righi.andrea@gmail.com>

Thanks,
-Andrea
