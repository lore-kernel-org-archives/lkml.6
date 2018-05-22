Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3155680-1527025406-2-13361789700001148399
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527025406; b=UQ2JSaUFvXAzbtjwUJhyaSclADds9QLeEs6w1YjAkpqx/IvbL6
    51jCJIn4SbpsF+g/5G9c/KjsznAB4W16tZ+8CcK0n20QVclZQbyq0bAAzVhabLPw
    6lctspMcbI3sZEWBXJYy1h/zaqi6migEsrEaBfnznKAVZOADyFj0kYxuCp/z4J7H
    wvFTSTBFS8wydwB6ABdD2ERU7fmOUa0dts3uAo/Ajx+PbJxrgdz5m+urNZgZ3dkh
    GAjnG8XP/Ep4oUVilI9T97aF53xTn3djbN4ON3cLAt1osh8JL/R+0fXIEid9O5PB
    68KCkn7Nml1CBCuZyHYs/bxbq2YqmLjekMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527025406;
    bh=pRSwoJENsJhrbgdaAW46QjoMiFQoHG18JqQfP8nyXio=; b=lV4b8uKFKwg7
    BsxvzEI12Fx/nxnz3Y5ne5joymoWJP1gtptT1ww+MlrmUeEnCRfHCzzlYbp1+Pjf
    sSS99Hkue3ydXd2WY6GzyQ7Zm0ybsFzS2STbYOA3/LtJ319Sc1YNQUoP/wblKM5M
    xqgs/HgYkjGE5s8B9oLhvzPJh9T/7z+pN9Fan2FD81cBI448w3KNn8yVMl5YeXNo
    mXemj0eDx8MsrinpHFflYvdprCp1jDNqfKnAmIokMqEp27ikZJGH4SO3SqyMguBx
    6z66U+g5HBwEwzXmryYZUiYcUq4uf4ZPosIPlEC0ZnkF7EvPZd9bUYRFv15s5sZz
    Wa53jkdLcQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLiDvPMIs/GtiB5UOKEbBAUC/1WN5iQrxJc0rrSYPR6WpORt8pE6peR4SdmlfM25ynsoIIBB9PykYrdXUDdVEGk1oNSl1lKGiCzkkYaA3q+krrOluKJg
    02Rtfr3kCMH9DEUALBEl9OX+5vVXR+uctfw5tTd3rcxQRBC/NoSnq+hxTLgZubAs8ePG3W78XDZTTR1GABISIfIfKHscpiEj7jGyDTy0yoHo3x0GtLk3AvO0
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8 a=YCR806yNieFIIYbKfGwA:9 a=CjuIK1q_8ugA:10
    a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753036AbeEVVnX (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 17:43:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752969AbeEVVnX (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 22 May 2018 17:43:23 -0400
Date: Tue, 22 May 2018 17:43:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, "4 . 13+" <stable@vger.kernel.org>
Subject: Re: [PATCH] printk/nmi: Prevent deadlock when serializing NMI
 backtraces
Message-ID: <20180522174320.10ced885@gandalf.local.home>
In-Reply-To: <20180517143903.19339-1-pmladek@suse.com>
References: <20180517143903.19339-1-pmladek@suse.com>
        <20180517143903.19339-1-pmladek@suse.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 17 May 2018 16:39:03 +0200
Petr Mladek <pmladek@suse.com> wrote:

> The commit 719f6a7040f1bdaf96fcc ("printk: Use the main logbuf in NMI when
> logbuf_lock is available") tried to detect when logbuf_lock was taken
> on another CPU. Then it looked safe to wait for the lock even in NMI.
> 
> It would be safe if other locks were not involved. Ironically the same
> commit introduced an ABBA deadlock scenario. It added a spin lock into
> nmi_cpu_backtrace() to serialize logs from different CPUs. The effect
> is that also the NMI handlers are serialized. As a result, logbuf_lock
> might be blocked by NMI on another CPU:
> 
> CPU0			CPU1			CPU2
> 
> printk()
>   vprintk_emit()
>     spin_lock(&logbuf_lock)
> 
> 						trigger_all_cpu_backtrace()
> 						  raise()
> 
> 			nmi_enter()
> 			  printk_nmi_enter()
> 			    if (this_cpu_read(printk_context)
> 			      & PRINTK_SAFE_CONTEXT_MASK)
> 			      // false
> 			    else
> 			      // looks safe to use printk_deferred()
> 			      this_cpu_or(printk_context,
> 				PRINTK_NMI_DEFERRED_CONTEXT_MASK);
> 
> 			  nmi_cpu_backtrace()
> 			    arch_spin_lock(&lock);

What branch is this based on, because I can't find the
"arch_spin_lock()" you are talking about here.

-- Steve

> 			      show_regs()
> 
> nmi_enter()
>   nmi_cpu_backtrace()
>     arch_spin_lock(&lock);
> 
> 			      printk()
> 				vprintk_func()
> 				  vprintk_deferred()
> 				    vprintk_emit()
> 				      spin_lock(&logbuf_lock)
> 
> DEADLOCK: between &logbuf_lock from vprintk_emit() and
> 		  &lock from nmi_cpu_backtrace().
> 
> CPU0			CPU1
> lock(logbuf_lock)	lock(lock)
>   lock(lock)		  lock(logbuf_lock)
> 
> I have found this problem when stress testing trigger_all_cpu_backtrace()
> and the system frozen.
> 
> Note that lockdep is not able to detect these dependencies because
> there is no support for NMI context. Let's stay on the safe side
> and always use printk_safe buffers when logbuf_lock is taken
> when entering NMI.
> 
> Fixes: 719f6a7040f1bdaf96fcc ("printk: Use the main logbuf in NMI when logbuf_lock is available")
> Cc: 4.13+ <stable@vger.kernel.org> # v4.13+
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/printk/printk_safe.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
> index 449d67edfa4b..a2ebd749c053 100644
> --- a/kernel/printk/printk_safe.c
> +++ b/kernel/printk/printk_safe.c
> @@ -310,15 +310,12 @@ void printk_nmi_enter(void)
>  {
>  	/*
>  	 * The size of the extra per-CPU buffer is limited. Use it only when
> -	 * the main one is locked. If this CPU is not in the safe context,
> -	 * the lock must be taken on another CPU and we could wait for it.
> +	 * the main one is locked.
>  	 */
> -	if ((this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK) &&
> -	    raw_spin_is_locked(&logbuf_lock)) {
> +	if (raw_spin_is_locked(&logbuf_lock))
>  		this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> -	} else {
> +	else
>  		this_cpu_or(printk_context, PRINTK_NMI_DEFERRED_CONTEXT_MASK);
> -	}
>  }
>  
>  void printk_nmi_exit(void)
