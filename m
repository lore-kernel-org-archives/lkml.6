Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-356304-1524841617-2-8998435238163191463
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524841617; b=izb3pkZAGqKq/nBdcsyFwBsDR3nV53yMU1vt80+lK72yCKwbsn
    XOxdWGhBMP55tQZvBh930ICIk5EXmMG2yPi7zTfSh1wwAySIUcrJoUVsfqhJsp/I
    XgBUWh/kQxU09Nj8v++Abs9XI6+Iafwm4h54/VKk9dQBmTrfCYoA63vnan63Ng6k
    ljLsszklG+Ezm39L3ZgzqOak9sYr5JnmPqik0t2Qigar0uQVMyCyGbzV/4JwOQln
    V+51YxsU8ZMMW5fAqYPivg80TumUR1JG3FiPKZD/WTQnXP3DeHOf+3DSF7mwRg5f
    U/DkbuOdE7fOzy0LjXAdErgOE/IqZnAUc+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524841617;
    bh=WQkZrHpGTysNxiU7KB4glTD7pALtLK9McPISuiVmrpI=; b=M/nF4mdawwzz
    GkEQFdHc5gwmZIULYOD0tf/iycvvPG1wCpDrwIa9Yvq8cHAbRWv+WDb2+WIXvsu3
    B6jCSoQvCeobk9y/siMnvKvtwoMrAnoHiiqDsXdWMnzh4dP17fQOSP0yGDz7JOwb
    3lTPB1ffa5qiM3B+6yUlppKAegSQakXLnZcDBQRO4uTYGnedrZVn+uueyazzM48J
    QkQdzXhoemePrhemINzGmXk7K0QAbaq/Cv96mq19y9B2NmXA7+63ShzA0blVTjGH
    zmCtks2D1VEqYUSGWyzJPsXBHJt0wAmnSjweeOUzXdv0rzDyt5E3Z5Ae1SGNLk7/
    CQfJkVlNaA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfClrZEY2Lw5i+tbI6Bp27o9pa8l6pxpzjz8db0d3tj1rjD6OJJQjjV7D8OcO8eZDun4FS34fEKpS8jm6dBMkyQoS6Zb3YjxsHU8Cd+q8EGkRkJ4taLir
    oUlf2tFwLZplac+vbjdBLnIEmunirjA3kQDlxV7Q4bj1YZrscgrJeV/PDrCuCH4NmHX1pMpKx+lfOM/YPJ4uj4QVyrJgev7xzBmfok33h9ejUmEyKP2iiebw
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ynlnh4FcoAxGFrrfPYgA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933820AbeD0PGh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 11:06:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933207AbeD0PGf (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 11:06:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A30DD21892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Sat, 28 Apr 2018 00:06:30 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jon Medhurst <tixy@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 5/7] kprobes/x86: Fix %p uses in error messages
Message-Id: <20180428000630.aa8584a67686dd68d1bc9f83@kernel.org>
In-Reply-To: <20180427065817.tedhin5sy7brgq7m@gmail.com>
References: <152481117776.22588.1210388093668905564.stgit@devbox>
        <152481133105.22588.10668983189195179761.stgit@devbox>
        <20180427065817.tedhin5sy7brgq7m@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 27 Apr 2018 08:58:17 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> >  	    (addr < (u8 *) jprobe_return_end)) {
> >  		if (stack_addr(regs) != saved_sp) {
> >  			struct pt_regs *saved_regs = &kcb->jprobe_saved_regs;
> > -			printk(KERN_ERR
> > -			       "current sp %p does not match saved sp %p\n",
> > +			pr_err("current sp %pS does not match saved sp %pS\n",
> >  			       stack_addr(regs), saved_sp);
> 
> Why does this use %pS? Stack pointers are typically pointing into general kernel 
> RAM, which is totally pointless to display 'symbolically'.

That was I pointed in the last thread, but not accepted.
OK, anyway, there are no good reason to show such a dynamic value.
And now jprobes are gone. I just drop %p from this part.

Thanks,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
