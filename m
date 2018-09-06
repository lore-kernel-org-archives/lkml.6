Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9FBC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E588E2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sL3RBH+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E588E2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbeIFHFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:05:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41572 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeIFHE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:04:59 -0400
Received: by mail-pl1-f194.google.com with SMTP id b12-v6so4205126plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 19:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/4IsrxseRseUhrBF+P1uyG+EzbVZazxsP5OOtSJm3G4=;
        b=sL3RBH+BzSB6MxYQ3yCObIzwcmlwh38GAJ2ctwYjySL/8chUqurAu6Wx79wqdOhPsu
         iRInXm9AM450ADjqNQpx3MDgWYk7654hWJnvVP6ACf0/ekK3mJtdFSOMrWt6K8oth1Mk
         IUH6bRP5jrkHd+2JkR4rmHDziNx6HIdigQQ5lDB2aRFwQPFgCkziRS3IZHDM69g7gf/c
         bjjgBjdF4wgnCV5UQlrSCPeqLz8gKrGqaS6vbDL2SfNAreJtP6ky1lIcQ1KRR14O4k66
         D9MClmbIT3/awY8sbuheZuMJ3hiPsrYNXwB//6OqVYaYgpzu5LmBHQA7nv8GxCm3z3Ol
         Vnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/4IsrxseRseUhrBF+P1uyG+EzbVZazxsP5OOtSJm3G4=;
        b=X4MZwBnjwjh4mo/WRGCnzxF2U1hILb5epaIUnNzSXTYyAYoUCXBpTN5WnJY87sg+Wo
         Fve00qoRX4lox2OyaKHSE/y/wdhdfFO5C9d011E8M4HKurh08onSgnv1E9s2PLKp7YvO
         aj+5aYzRWbVOUkFRi5lhDbgOE5ZJRgN+3GpIMU1GOELmVqNVPgiRjDAR1ZFp8O++8/Ge
         mUqE0zZtnOD18lqql9Idif/kr2HHfcZ9ZYd3+Oxo5fxK6HDRJOWc6zc4hEJXdM7TGcpz
         /DTkjY3+xCqmzmvPAvgfgJpqM4Lfc46zX/RjcGmvJPRckrK1xMs9p5qUb09pwaIw6Nve
         tmKA==
X-Gm-Message-State: APzg51AABs7CHEo0XMkXiKdw8OVk+9EctfHaWzlZ7Ntc8v4uDHKe0XIM
        QKKtz0g9zPEpwxts74DZv90=
X-Google-Smtp-Source: ANB0VdbP0vLmdq6FhUb7GOpZRnzZtPnuSVI7PYepefAeDjMm6RyaivDQSkcoTBp4Yj/TSAQVDGcaaA==
X-Received: by 2002:a17:902:864b:: with SMTP id y11-v6mr572720plt.335.1536201115800;
        Wed, 05 Sep 2018 19:31:55 -0700 (PDT)
Received: from localhost ([110.70.59.68])
        by smtp.gmail.com with ESMTPSA id r85-v6sm5782676pfd.144.2018.09.05.19.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 19:31:54 -0700 (PDT)
Date:   Thu, 6 Sep 2018 11:31:51 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] printk/tracing: Do not trace printk_nmi_enter()
Message-ID: <20180906023151.GA749@jagdpanzerIV>
References: <20180905213334.03375777@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905213334.03375777@vmware.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On (09/05/18 21:33), Steven Rostedt wrote:
>   do_idle {
> 
>     [interrupts enabled]
> 
>     <interrupt> [interrupts disabled]
> 	TRACE_IRQS_OFF [lockdep says irqs off]
> 	[...]
> 	TRACE_IRQS_IRET
> 	    test if pt_regs say return to interrupts enabled [yes]
> 	    TRACE_IRQS_ON [lockdep says irqs are on]
> 
> 	    <nmi>
> 		nmi_enter() {
> 		    printk_nmi_enter() [traced by ftrace]
> 		    [ hit ftrace breakpoint ]
> 		    <breakpoint exception>
> 			TRACE_IRQS_OFF [lockdep says irqs off]
> 			[...]
> 			TRACE_IRQS_IRET [return from breakpoint]
> 			   test if pt_regs say interrupts enabled [no]
> 			   [iret back to interrupt]
> 	   [iret back to code]
> 
>     tick_nohz_idle_enter() {
> 
> 	lockdep_assert_irqs_enabled() [lockdep say no!]
> 
> Although interrupts are indeed enabled, lockdep thinks it is not, and since
> we now do asserts via lockdep, it gives a false warning. The issue here is
> that printk_nmi_enter() is called before lockdep_off(), which disables
> lockdep (for this reason) in NMIs. By simply not allowing ftrace to see
> printk_nmi_enter() (via notrace annotation) we keep lockdep from getting
> confused.

Great catch and I like the patch!

Indeed, with printk_nmi we changed the "everything that nmi_enter does
should happen after lockdep_off" to "everything that nmi_enter does should
happen after printk_nmi_enter" // +similar change to nmi_exit.

An alternative option, thus, could be re-instating back the rule that
lockdep_off/on should be the first and the last thing we do in
nmi_enter/nmi_exit. E.g.

nmi_enter()
	lockdep_off();
	printk_nmi_enter();

nmi_exit()
	printk_nmi_exit();
	lockdep_on();

I guess that we can keep printk_nmi_enter/printk_nmi_exit at the top
and at the bottom of nmi_enter/nmi_exit correspondingly just in case
if lockdep_off/lockdep_on sometime in the future starts invoking printk(),
which would deadlock us. Hence

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>


> Cc: stable@vger.kernel.org
> Fixes: 099f1c84c0052 ("printk: introduce per-cpu safe_print seq buffer")

A minor nitpick,

printk_nmi was introduced by 42a0bb3f71383b457 ("printk/nmi: generic
solution for safe printk in NMI") - in that commit we declared a new
printk_nmi_enter/exit should be the first and the last thing we do in
nmi_enter/nmi_exit rule.

	-ss
