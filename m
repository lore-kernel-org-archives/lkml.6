Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2252230-1524732041-2-11081774929948843144
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524732040; b=vaoUlM3P2mLxj3Q7Ulq0WFKmSDawPbmHP9ee84v2ABWYRCqhoQ
    ssVeOBQRlAcnzS/N2QdJHEnxfUFJiS8eOO5pf4N6BW3hNdAoQx0nDCX1puqvFKzJ
    jvErLUJWfvQGhPHZ3DFOKFziX6hktravhyqG0XGNXAUbv29iMNBGLmY5fdrfGJ/1
    8KEPonVobkB4mmHlBXTBFTH6odu806eE93WYRgNVPCghRnRFBlINjSt+80s7nz4s
    krhp18JA9KbdUEi/1bGMKjZW2+GPBMObUeHkil0SnWCZaXrAwsRyXvjUVau+L5S6
    U7VzFJfS8sv5jK+9DDCe+K16xaF77pD/4gYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524732040; bh=2B0JsAL77y/+jydMhMYFXiWcbcjFN/
    VvDxUmulEG7Mw=; b=CEKeFtLA9R3iFpnH5+h5J24wYS3cUFiEClmjqn/sEatFX8
    WPJPrfyqF8ldiaEAQuzhSVZmBQ/CBG1QwTD32qQbEZNUTLeSV5uxL2xuGiel0GNx
    Oykh/QiN4NGAoRY52g3i3W5w4bxuhb0PRss3QX9FIjdWLEPPNgFbUnfYoXjr/tJI
    hxdOgqHMxLB4FBCo8TJpz8JuOo8W9i2ezlS5ipW/bkafzsN04v5YCxvl7g1SKnwJ
    AHZqojIpj3fVMVetPN77cg1K0Nc995WSQ5I3F0SXIWpOkjq5FJyjJdno/UGCfk23
    4X6p8M2ZCDc78bbnFTBt36SJM52G1rh0+clfeQeQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBGIbWmLbeFP6q42HSEcLj6YK3VFz8sbmpfJgvzYL+PNqUY8WvPCMELFJfr8p58X9eCcDwHC5VPRWYJRzK8OVajOras1pZ6mxWtZuD3NbZFk3G8U5zpv
    Y5YEVx6PKDxZ2Z1IwRX6HNuCOtQZYl+bh9bnTud8pQyZovtd6A/Sx158H8hXaLG3e5m9CHvAgC3H9UbNMxFNu6xw3D/BaDyEGAtBRNuxfHmqUSRpV0hIY0jZ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=Ag2GKY2TJ1JtHe2dNT8A:9
    a=Sc-nGd-tSMoN1Rli:21 a=7MvWy1D4kA2oqz9F:21 a=CjuIK1q_8ugA:10
    a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=W4TVW4IDbPiebHqcZpNg:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754562AbeDZIki (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 04:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754543AbeDZIkg (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 04:40:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225F5214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
Date: Thu, 26 Apr 2018 10:40:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
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
Subject: Re: [PATCH -tip v2 0/7] kprobes: Fix %p in kprobes
Message-ID: <20180426084022.GA6777@kroah.com>
References: <152473007907.8819.10449983839199591406.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152473007907.8819.10449983839199591406.stgit@devbox>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 05:08:00PM +0900, Masami Hiramatsu wrote:
> Hi,
> 
> This 2nd version of the series which fixes %p uses in kprobes.
> Some by replacing with %pS, some by replacing with %px but
> masking with kallsyms_show_value().
> 
> V1 series is here:
>  https://lkml.org/lkml/2018/1/25/1
> 
> I've read the thread about %pK and if I understand correctly
> we shouldn't print kernel addresses. However, kprobes debugfs
> interface can not stop to show the actual probe address because
> it should be compared with addresses in kallsyms for debugging.
> So, it depends on that kallsyms_show_value() allows to show
> address to user, because if it returns true, anyway that user
> can dump /proc/kallsyms.
> 
> Other error messages are replaced it with %pS, and one critical
> function uses %px which is called right before BUG().
> 
> Also, I tried to fix this issue on each arch port. I searched
> it by
> 
>  # find arch/* | grep -e 'kprobe.*c' | xargs grep -w %p
> 
> And fixed all %p uses in those files.
> 
> Changes in this version;
>  - [1/7] is newly added.
>  - patches for MN10300(deleted) and s390(merged) are removed.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (7):
>       kprobes: Make blacklist root user read only
>       kprobes: Show blacklist addresses as same as kallsyms does
>       kprobes: Show address of kprobes if kallsyms does
>       kprobes: Replace %p with other pointer types
>       kprobes/x86: Fix %p uses in error messages
>       kprobes/arm: Fix %p uses in error messages
>       kprobes/arm64: Fix %p uses in error messages
> 
> 
>  arch/arm/probes/kprobes/core.c      |   10 ++++----
>  arch/arm/probes/kprobes/test-core.c |    1 -
>  arch/arm64/kernel/probes/kprobes.c  |    4 ++-
>  arch/x86/kernel/kprobes/core.c      |   12 +++------
>  kernel/kprobes.c                    |   46 ++++++++++++++++++++++-------------
>  5 files changed, 40 insertions(+), 33 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
