Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3800878-1524812313-2-17042359893003529326
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FSL_HELO_FAKE 2.361, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES ensk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524812313; b=ChtRU7BMe7lWVjy8HKXLibC46arsTqieYxTkB1Ja3mXCc8h2bs
    WNJe6mXF/E8fwyDhaw5Vknp+W620n5ybuOBS2uOYLZZxCxHO5mnmfFDywwTbs6jk
    va0SRrWHNQfqB/8kIYgrmDbF65ObDqRTUwnZghgFtefP6gpMN/GQ1ORvG7/9Pq0Q
    6snkb51vHLp3Kw6tNiQ7DrvX7Z02FAp1kNaV2B1Hyoj+182Kkc3KMGgHV8WmsU2M
    remSYZY5WBp5E2Rzk0bGKmpeCeXr3AiFDlRXos3FvbScjOQ54CU9lz7bPWnitD1t
    zMMAwcoQ0OJjgmkP44ASuYx6mKtwu0O0zh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524812313; bh=+TkQEiduDEQ43kFjHjFyePJoqJV7wG
    gDLpqhjOfYZVI=; b=fKKnJop7LkReRmVA+kcGeAasavq7L78+9AkZQeVoybqN/Y
    aGY/vqAEOQZQoL/Kgco4KVr1vtuM9QBh534itJhuk07fqZVnsOskMnVXHvA5ZzGz
    /GLB4dG2J2AIqIRdoPnp1t3WDPXxs4e57qEWzbGguDUaJ1L994fzmpRICm4uaFix
    7VLXohDxneYOveLoNh9mdbASOyt3ZwZNtuFKbljPolbvxWNKC6dylDhN3/xOzIps
    co49QOk3KOoRxNdy0M0DObPHVD5CYo5idRDqDNz5jKy7JTRzchsnbiuiDRlCBTU3
    j3PMJWFheKTTOrWeeMHxUwE03NU+pyUQ9J3RnYKg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ATXfa1TJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=f08tGbxC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ATXfa1TJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=f08tGbxC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBTqY74mWfO7SZazaxyXRjZ8vjwRaw8Zx1fR/sN+Msdw5uM1yp5i26mtK7vda5xZ+Eh+rVIXa/bLyjUfYHkdiFcbMRDExDNCerTFL1RGC9+R9G/8WR6R
    /vS7U4gs/ijifpb8eyh88iBLuTT/LRVKRz56YmQk7ZRQeMrAdv1dAaG6STTlgPubMEOacix60bvt7U520fKI9u0g/Y57/NbE4+mrsYIsnd5qU3AyvlSsHBP9
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=TPcCIOECNf9A0kI2_NMA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757541AbeD0G6Y (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 02:58:24 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:32935 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757494AbeD0G6V (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Apr 2018 02:58:21 -0400
X-Google-Smtp-Source: AB8JxZrg4w5Ik4WqLJFtwLM0rERv1+Y2acP6/KATVHYliJY4XS+yGgsZAInze42Kj16NCNsWmn7xew==
Date: Fri, 27 Apr 2018 08:58:17 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <20180427065817.tedhin5sy7brgq7m@gmail.com>
References: <152481117776.22588.1210388093668905564.stgit@devbox>
 <152481133105.22588.10668983189195179761.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152481133105.22588.10668983189195179761.stgit@devbox>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

>  	    (addr < (u8 *) jprobe_return_end)) {
>  		if (stack_addr(regs) != saved_sp) {
>  			struct pt_regs *saved_regs = &kcb->jprobe_saved_regs;
> -			printk(KERN_ERR
> -			       "current sp %p does not match saved sp %p\n",
> +			pr_err("current sp %pS does not match saved sp %pS\n",
>  			       stack_addr(regs), saved_sp);

Why does this use %pS? Stack pointers are typically pointing into general kernel 
RAM, which is totally pointless to display 'symbolically'.

Thanks,

	Ingo
