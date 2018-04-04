Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-426418-1522856313-2-15685419158755071829
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522856313; b=LVvgmwSq23/KMLIXFZsDVTZD5l9gQOjdZxs1q+EGEgXMiuo3GH
    vYlPnXRX0/WRTKtswOvM3as70jvfGpmCtT8DAy8+/mge/afyEEqUnkVKy6r1idNk
    3YBuMXkL8fQ0E3FLJ64teQ8kkAuSYzywEePOY69AqtRrCFdE3E9CfYu+KqwST9rp
    GsEhB+mndFkEFnmI/nhml2QFySJ25B5cLCjdsxYxhW6L9bXSrZRA3BZw/yNwtm7H
    TOIORxur6z/PPqQUo2u050wJermL3goFFnD91hR3sC4KNTsoIfSlYordnrWane4E
    1+tWXn2u9gUZ/HymDXKOiZK2/ScKRQ8yNFfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522856313; bh=TkVlO1G09VyjXVi2zQTq9UXG5YZTJt
    e5/3tCaI9oys4=; b=quxmurvEjBMC1na2PO22sfiP7kroqGI1kbFD5yh97+8+5N
    /w+BEILL2PWlLL3yjhMTOngCcrJwRKOo05ieD6Kzz4eaptncHphMaRgJuPRQTOsO
    5fGgFBKu6D59qEHi6Z0CSQ6KFry9Hhi+nXb0XE98byp8vrkn2A96/p/iROSgH83T
    S4ReSI7BkZWkI9+rKVAgZMsl/gzGsM0P6WIkR5IMtOXeZRXrcpHWK1QBtrNCovMI
    7shJDVilNFFftAMWWKnrRGnyyChQ10sKevvuE77PxvKDOnBSQg9+Z9ueeqskgqcG
    0qv3hzC+t8I79IfDsF2TA9yNtXxMqGfOeegNGB7Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=iO5SJy2M x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=iO5SJy2M x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEuz4YMkNVCx95XskAgiAoW7YC1LFUZmnPxi8oQQK2L2byJ6JZgBiKaD2jAiV0hsqWrPr0KPCyCtpOiT+0zkfVtTYz8sGPfUJlqRLuUQI86E7gFIbPa0
    CBkHZUVATbMrPrc2XSafn4ELyNglq0IXq3h0oyD+XstOssW7hBB/BYC216Vb5ewveW6r1IP8UTX0ScprTF7fMUKYuhvnIrCWV0jKIFjkNjfaYQ3EGpaLutxD
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=TAu22Ok865csWW7xEhUA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeDDPia (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 11:38:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752125AbeDDPi3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Apr 2018 11:38:29 -0400
Date: Wed, 4 Apr 2018 17:35:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: mingo@redhat.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] locking/qrwlock: Give priority to readers with irqs
 disabled to prevent deadlock
Message-ID: <20180404153534.GI4043@hirez.programming.kicks-ass.net>
References: <152285543936.4080.5025412328012618076.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152285543936.4080.5025412328012618076.stgit@localhost.localdomain>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 06:24:39PM +0300, Kirill Tkhai wrote:
> The following situation leads to deadlock:
> 
> [task 1]                          [task 2]                         [task 3]
> kill_fasync()                     mm_update_next_owner()           copy_process()
>  spin_lock_irqsave(&fa->fa_lock)   read_lock(&tasklist_lock)        write_lock_irq(&tasklist_lock)
>   send_sigio()                    <IRQ>                             ...
>    read_lock(&fown->lock)         kill_fasync()                     ...
>     read_lock(&tasklist_lock)      spin_lock_irqsave(&fa->fa_lock)  ...
> 
> Task 1 can't acquire read locked tasklist_lock, since there is
> already task 3 expressed its wish to take the lock exclusive.
> Task 2 holds the read locked lock, but it can't take the spin lock.
> 
> The patch makes queued_read_lock_slowpath() to give task 1 the same
> priority as it was an interrupt handler, and to take the lock

That re-introduces starvation scenarios. And the above looks like a
proper deadlock that should be sorted by fixing the locking order.
