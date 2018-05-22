Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1989818-1526974622-2-7785152786132587579
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526974622; b=Jr3pEbDvof2OGJHtl4NgxFCWj+0QHJKD0ve2DX1nGQ3oflCEIF
    02+M9RnAjNJVe216WrmLMQWOB65rb2TDJTlYCAcYrcntkecN0eMm8kef7WLb38d3
    +1oqvgr3DEk/3tqe6BNkv1lRnFWkDKyKXsbDuKNcOeqK8FCSdKTcYjztkPuH8gsF
    nLVt1Ru9Prpo+aTkY8UyscP1II6FgeBxXE/YfLiMZcWvN/oEqds8r6u7hTcYOKMn
    nSp9ULLy7LcAgMs5grwnvSzUE9p0J5KCSFkfdhiZJk64ohoKUAhl/qeKcPQKd1xJ
    0HvmWgtkAsSlz9lIbpvOo2UbA4STHWkGvYsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526974622; bh=bmaw5iV4Qyv6XOYBDeyt7LIyfvCXCC
    tLc/5sHkrkm6Y=; b=HgwwouQMc1dIoPIXtfQZXX7hwwponyMJABX2S0PxCnqbYK
    GqlSm6v2bdk2LEJBptOKfB6EGgQgukoGq8x9i+a5tz2IFLAiHz955H5hehT/Ctf1
    /sBaZZSHYQ9W53oTnbdrmicPZhWC8WitxjNSWKiO2FFp1uRqpZgTQSaATY32iCzj
    cJpikPcUtJfLCWOsckWAZmb38ikKS0g70AZ3tANhWJ97dfwjbjg5I06l50nRxrVa
    qNt9LwQsvICgRs7JGfa5NH8gGlE/4RQsyNqH0+HaXF1vVAOZFgZNjQT05XTBTDhC
    sg+PDVa5cjxyC42zdtPHa3e2AMxXXFo1+GzheSGQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=rg5n5yij
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=rg5n5yij
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBB4+pywhkaVdBQ80Q4rHdeoa3hTbGPxFoCzwI8Lhxm/MOB2b5/ztPFqA1bVga0mKuCRatC0unSYcXCg638QkJq6nLlB0GEZlKNOBKx3Gpc2TVvh+5dE
    HB/3vGydWNKXb/U4u+Y9jJGEn/0hUhhMVu9Bo421N+kMYZ97qgqvO1EbEu93m3sn/kr7JGm9UL8MB6YzN+Owr+g8DJGwLjs2PD+JAYbHI4+HJ7zXZwvqCUEN
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=81F_irlNwp__jJMsQXQA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbeEVHhB (ORCPT <rfc822;linux@kroah.com>);
        Tue, 22 May 2018 03:37:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49374 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeEVHhA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 May 2018 03:37:00 -0400
Date: Tue, 22 May 2018 09:36:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Naresh Bhat <naresh.bhat@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH V3 2/3] efi: Introduce efi_queue_work() to queue any
 efi_runtime_service() on efi_rts_wq
Message-ID: <20180522073618.GN12198@hirez.programming.kicks-ass.net>
References: <1526958784-14688-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1526958784-14688-3-git-send-email-sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526958784-14688-3-git-send-email-sai.praneeth.prakhya@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 21, 2018 at 08:13:03PM -0700, Sai Praneeth Prakhya wrote:
> +	/*								\
> +	 * queue_work() returns 0 if work was already on queue,         \
> +	 * _ideally_ this should never happen.                          \
> +	 */								\
> +	if (queue_work(efi_rts_wq, &efi_rts_work.work))			\
> +		flush_work(&efi_rts_work.work);				\

Since you're _always_ going to wait for it, it is _much_ cheaper to put
a completion in your actual work and wait for that.

