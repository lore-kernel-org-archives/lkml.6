Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3452472-1527040875-2-9515820452678470140
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enrosk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527040874; b=V1evNYMPDh2SxseQ/iCyeFE4JcCUYePvr+uFydCMb2dL8AcloU
    YX4PS65cxkdLpd1wYUo/mlS0vhIoWxqlkIs8iCkCxa6EA/7ajCp2KJZyiSpLGTYE
    78SgqJt9L/FXdb+hO3iKnhCVtnEse7nV/FdreOP3utQz2f/yEOhzijDoLVzuVPuc
    gQWChRibyY4PcYbixw7eKPHyBVDHP6/1zEW2ehpH322LI8DMKWfBmeT1CetphQLz
    exoAUakJJEXiABJe43UK68AoApvdHj0RfaMt0cdXwzw8HdYtJ/PDWJqX8figTcqx
    Clf+1aH5O8QMfx5WduJUTRKzakdNkK5AqzhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527040874; bh=R6L0cY1DpnaH9iiVUka1Pw57xycwp+
    /3yZSMXY6Sx1A=; b=i7RuYVR1TUVctjv3riMoMmUimsMipqDVASiPwwlQJK3h+a
    tTOaoUejIfkf2uM6O1zIOg35vpgob6R+6PRIYigx2MUiGpR++MULkhZWSyykYYS6
    gQMhQOkFkKqS/fxe9KeIyUEiGwJw3+kQvZo0tXSrNVRU1FtW6PsCzL7/NZwgyqcq
    EqnkG5qN4+H5sf4CPHjroVUbCE2xcZwcV++C/9tJvWekNyPjDbWDCAB2GcKmQcwL
    3clQe4T9bv2xQqKcmapcxO4Ko7DhLtBi7bBGTQlkp+fp+bDdEyKwZ+EIjznosFEw
    pjjTa6H1of9GYX+DCgGQMr5bp0n+BEWQyd1XAF0Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=VMmw8r20 x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=JVLjOQg4;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=VMmw8r20 x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=JVLjOQg4;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNvIIE8Pg5T379rwIDg357kMVkusi9hggwT9uzMmhHi7Z8N0sc2qVreN7j3pzaxZKjzKAYkjiv5665dp+J9YWm/QZgQLc/5QVg1hd4ME9Wi+86QQX8Iv
    2JuW0NTpv/CWvmWrpmfq00xBjRW0uL1rlMysiY0Ok52VTS+DBMmi6l8KvXWCYlLXwdhfWJobqQRzZuQJ3uFRMn/cy5tL2n5a1UBan46xXi7HbJKHvPKfnb/C
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=_cTQiL8xM1sA:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=N7CCSKu_7ocp7UroZP4A:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753629AbeEWCBN (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 22:01:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38159 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753609AbeEWCBM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 May 2018 22:01:12 -0400
X-Google-Smtp-Source: AB8JxZrH0kDcawfv/FuSJwvXKc4QksxmH2/85vba5JDKzRqONt55njT7xAvrg1SkgH7e4VqVEyFGGw==
Date: Wed, 23 May 2018 11:01:07 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, "4 . 13+" <stable@vger.kernel.org>
Subject: Re: [PATCH] printk/nmi: Prevent deadlock when serializing NMI
 backtraces
Message-ID: <20180523020107.GA8465@jagdpanzerIV>
References: <20180517143903.19339-1-pmladek@suse.com>
 <20180517143903.19339-1-pmladek@suse.com>
 <20180522174320.10ced885@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522174320.10ced885@gandalf.local.home>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On (05/22/18 17:43), Steven Rostedt wrote:
> > CPU0			CPU1			CPU2
> > 
> > printk()
> >   vprintk_emit()
> >     spin_lock(&logbuf_lock)
> > 
> > 						trigger_all_cpu_backtrace()
> > 						  raise()
> > 
> > 			nmi_enter()
> > 			  printk_nmi_enter()
> > 			    if (this_cpu_read(printk_context)
> > 			      & PRINTK_SAFE_CONTEXT_MASK)
> > 			      // false
> > 			    else
> > 			      // looks safe to use printk_deferred()
> > 			      this_cpu_or(printk_context,
> > 				PRINTK_NMI_DEFERRED_CONTEXT_MASK);
> > 
> > 			  nmi_cpu_backtrace()
> > 			    arch_spin_lock(&lock);
> 
> What branch is this based on, because I can't find the
> "arch_spin_lock()" you are talking about here.

This arch_spin_lock() is in lib/nmi_backtrace.c

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/nmi_backtrace.c?h=v4.17-rc6#n94

	-ss
