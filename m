Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3066914-1526609235-2-12335128413671661090
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526609234; b=EdIccfMALpto2/Bwr9VbwRvQ/8DPa4kUa2HD5JsOhKDT5JUxhW
    YXALJ6JVDpIcGTmIK/M2JhsKmO+fZUoz8qiNAF2CGmwl9zVP1cffi14qF8sXWRY/
    vdUXNtPLysF+tJRCo5Zn79yYRG7861ba0fMLWB/kPV6mwdHoKau9xHG8nzwusSJ/
    eAdgNGf9N+TQBWA6JLSvE0ZFrYtpZE2lx0tANjJUj/VNSU7EH5sx5+V6m90egZqB
    4z+6586NPEIR1NqV1Tt3o+aNr8bCRrp9O7e7Z0lBiqZjufVS462X0sbbEWlQ3mpx
    R8rGNNGHJubNpVDrj0bWXXU1tILqBw3cSXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526609234; bh=hNDFIsX5YNEYn/PHP4e1fxkn8/T+Ii
    kgyuoosQ3SkMw=; b=nBcREl1eIRacTPYJM/fQBOPrGLpD3GiUIeZPWwEtxMvoni
    v+kv7p3+jL1AeDfOGkYDEZlp0UvP0GIUtQEb/U4t08XkSWgjfnZK1shKtwyE5HKD
    lixi8IxERjlFDC/jGzsD9/Arsen4USelW0nxh4eynQ1odyzbDDgTu30/mRO2BTMI
    nXDZgEokIPxQfxvcnYeDJhqpc+w+fuFOh+LlkdzsnaTG+C3QLH/qA3Wd8aobVrpH
    Vjm6gaUdqdU9WA9VeA0WULpp4rbnfERtT48N8k3qMRzQtGUs85H+Qp34ZWCF8uBu
    XtKmTTjSl8WgQEc0CQei5c9jMWdvRVQkR82fXvQQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=sI+s0Ju/ x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=Gt6NEFv6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=sI+s0Ju/ x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=Gt6NEFv6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfClnmcnV6chKskMw3fONijqzvTyHQ10JYggJ5NDHCnpyp8l7Wx/z9xmdGrW/3QEL9CKUM8Mh+32Z7waAziITi6nFuGdCw9J0cNm6+uDBPonuT7NvUwKK
    AEfaT7GhDSJwOPam8CYR57X9XUm2jOMF+C+JKCNDWywqixn19O7Pqubzv6NdvXUPCy/MhgOQzQChMjecOT8jTeOO6SCbcoEeetXGRiepQLYHuXA6O5SqkkpX
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=_cTQiL8xM1sA:10 a=VUJBJC2UJ8kA:10 a=iox4zFpeAAAA:8 a=pGLkceISAAAA:8
    a=iz_rM1gKICY-djV1GYsA:9 a=CjuIK1q_8ugA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbeERCHL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 22:07:11 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40850 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbeERCHK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 May 2018 22:07:10 -0400
X-Google-Smtp-Source: AB8JxZohOhLYsDGtnSNtwxdpICUhAiztFxlSulQGqLEsGB8pl8wmiKACfmYzVYvZ1DqW8ek+NrMdxQ==
Date: Fri, 18 May 2018 11:07:05 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, "4 . 13+" <stable@vger.kernel.org>
Subject: Re: [PATCH] printk/nmi: Prevent deadlock when serializing NMI
 backtraces
Message-ID: <20180518020705.GB1160@jagdpanzerIV>
References: <20180517143903.19339-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517143903.19339-1-pmladek@suse.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On (05/17/18 16:39), Petr Mladek wrote:
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
[..]
> Signed-off-by: Petr Mladek <pmladek@suse.com>

This is a pretty cool find!

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

> -	if ((this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK) &&
> -	    raw_spin_is_locked(&logbuf_lock)) {
> +	if (raw_spin_is_locked(&logbuf_lock))
>  		this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> -	} else {
> +	else
>  		this_cpu_or(printk_context, PRINTK_NMI_DEFERRED_CONTEXT_MASK);
> -	}

A question - can we switch to a bitwise OR?

if (this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK) ||
	raw_spin_is_locked(&logbuf_lock)

just to check per-CPU `printk_context' first and only afterwards
access the global `logbuf_lock'. printk_nmi_enter() happens on
every CPU, so maybe we can avoid some overhead by checking the
local per-CPU data first.

	-ss
