Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3800878-1524812205-2-10324088291793676697
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FSL_HELO_FAKE 2.361, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524812204; b=I/AGHUuM9cTaNhroKjsIx+7tj+h9MljZvSq+il9lYQMUS2hQ++
    0/U7VUaHzK7ld6UETJgEHVHhZqTRoEQV+zAuab2wNxmywi9CzgNs+xJDNeEiQWDr
    1ccoISMq1yyG8e/bvZneX3QIhW3w/w1WrIeZ+8xJrbR9SPlNN9BfMzbwxqvcSzL+
    H8+UU2xWvLYYe0o51LY9wzoIlrG6yzGXzJS0G+VbhG2bMb/gC2aBbLDKbdwE6wov
    oeQtpub5e1ci+zkDkUHyROr/OY8kF+uo39pSXtj4kyhL3v6hCq6FJFl+joKCpiL3
    Nl2m6b/8Bd6/kUYE0JbmbPyUQ0Iwl9IxCGZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524812204; bh=NLeIj6Br1mUIA/p6Lp4ARRT1yA+u3T
    fxK3LcrhEmF0M=; b=Mu8fXR6PvPOp1eHZveAT1YPNmMU2gnbTJFvSwF3A2HO6aq
    Hr4T1dfXOWfoS0TsIgzkjtl2XGpxCUBxa3Oyo7Ylsrn91OD+Oq39ZZjFUCtZIt0A
    kH05T159cwzPbfSHLoBYM2wI/mNFdqDwg9kQJxYTv0wLx6OkICTjbN1USrxEKrUM
    v2IIhI37Mwj8L13j/pQfezWORoH7mRKHKIoFRHBTZutCHqNPaDxUg+pRf97jej3t
    O4abUsoiUuSHiGbAvqIzK9b/fhC/SQwvVNW8+UVW9+jSxqCRJOK5plCw0kmtRFBt
    tO9BYi9nD+H5NkYIcbzS6UxIwiWQPi2kVKXWyPvw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nEzLRABn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=W5jPzlPP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nEzLRABn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=W5jPzlPP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMcEo4Y2zGt4iCmrPCLHVInD1AhzKuD3NgiSz5j4wQpVaEQ5ow6mV1Fh+ltvQEKezkQatEnC8jQiAq9pZDDPSbjX01+AIhDSBKHjN/Zyu0+dnvE7c9hr
    BbUD2M+i8XBnknFCOsIvMSQAjRZ5HqlJNkRhPMhnmWZSsSbYI82Ey+WqSSKdJQE32c12UKjF9/yzAqhUxuwoym8oKGI8Z9NdZL218AhhpdwPuHKMJcmB1gwC
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=C9qCzCLpqlGvL2cgW0IA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757514AbeD0G4m (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 02:56:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34880 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757283AbeD0G4l (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Apr 2018 02:56:41 -0400
X-Google-Smtp-Source: AB8JxZrodiJnJimzIQ+0vDs8dG2K1TzlD2atJtJ3vlnRErnSK/32fpUTfXmlBgCnSGwnVOLnNjmg4g==
Date: Fri, 27 Apr 2018 08:56:36 +0200
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
Subject: Re: [PATCH v3 4/7] kprobes: Replace %p with other pointer types
Message-ID: <20180427065636.ells635z7cw4b4oz@gmail.com>
References: <152481117776.22588.1210388093668905564.stgit@devbox>
 <152481130062.22588.10747314456340608852.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152481130062.22588.10747314456340608852.stgit@devbox>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> @@ -712,7 +712,7 @@ static void reuse_unused_kprobe(struct kprobe *ap)
>  	op = container_of(ap, struct optimized_kprobe, kp);
>  	if (unlikely(list_empty(&op->list)))
>  		printk(KERN_WARNING "Warning: found a stray unused "
> -			"aggrprobe@%p\n", ap->addr);
> +			"aggrprobe@%pS\n", ap->addr);

Is this a kernel bug? If yes then please convert this to a WARN_ON_ONCE() that 
doesn't print any kernel addresses.

>  	/* Enable the probe again */
>  	ap->flags &= ~KPROBE_FLAG_DISABLED;
>  	/* Optimize it again (remove from op->list) */
> @@ -985,7 +985,8 @@ static int arm_kprobe_ftrace(struct kprobe *p)
>  	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
>  				   (unsigned long)p->addr, 0, 0);
>  	if (ret) {
> -		pr_debug("Failed to arm kprobe-ftrace at %p (%d)\n", p->addr, ret);
> +		pr_debug("Failed to arm kprobe-ftrace at %pS (%d)\n",
> +			 p->addr, ret);
>  		return ret;

Can this happen during normal use? If yes then just remove the warning message.

>  	}
>  
> @@ -1025,7 +1026,8 @@ static int disarm_kprobe_ftrace(struct kprobe *p)
>  
>  	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
>  			   (unsigned long)p->addr, 1, 0);
> -	WARN(ret < 0, "Failed to disarm kprobe-ftrace at %p (%d)\n", p->addr, ret);
> +	WARN(ret < 0, "Failed to disarm kprobe-ftrace at %pS (%d)\n",
> +	     p->addr, ret);

As this is a signal of a kernel bug, just convert this to a regular WARN_ONCE() 
that doesn't print any kernel addresses.

> +/* Caller must NOT call this in usual path. This is only for critical case */
>  void dump_kprobe(struct kprobe *kp)
>  {
> -	printk(KERN_WARNING "Dumping kprobe:\n");
> -	printk(KERN_WARNING "Name: %s\nAddress: %p\nOffset: %x\n",
> -	       kp->symbol_name, kp->addr, kp->offset);
> +	pr_err("Dumping kprobe:\n");
> +	pr_err("Name: %s\nOffset: %x\nAddress: %pS\n",
> +	       kp->symbol_name, kp->offset, kp->addr);

No, this function should just go away and be replaced by a WARN() in 
reenter_kprobe().

Thanks,

	Ingo
