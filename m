Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2209064-1524730436-2-6652079605079574528
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
    1524730435; b=WJBKODR3+ELK65kDzodyBUHIvX68bfdjajWV2qINdAl6FAf+Bw
    2z4vCWHQmQ2sJtTGw+a/MPw1RsHIRGOotgH+vi0RWaT81e2GtPcZCxPt9cLUSHSe
    cd9rbzY2VCFLjvx5tg49GTn58CqS/S5IgyEjf12SGXFPOoGIOiqaafaUcJAsJb80
    9aVMEEVZCyQt9A4IFecoRcJEqosNIkZgiPD23e7Nsan1Bnn1Im6vywV+6EdYeqyH
    GjSILPGc48wgJdKSEhXpFjAdb3QGwpUl6gTyLeUNivgHo+X4jrEGc/N4PELwaE5B
    kvSmQIMZJ0+ccCYOelC9Cy1vLA2vOfCMtOjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524730435;
    bh=oGoFrHk64Ci+hE2Ld1BYmo7dpHuBVWBkdergx982PDc=; b=s5V6xRTDSsEn
    VBmJOGMnYuhoVoMEbfp7Hb7m2p4MlgRfw/su1CqhG9phDpWpmYqvPRkQYjBRJH7G
    yfe2dDxvydzPqislT2YaWuQNDjyRbk+Zit8GPBlowoebKgbad6ziKwNaK8HepgzC
    M8mcTelJUvi5sANOc/3uMQ/YGUZE04Dw0jfKmJN9fo1hJEjFNM0Fip+03+/XfGWF
    eyg+zwc8ZjpALWGRIAvxtqYmfyxx+zS9BV17CCLctTtG8zYYa/rfaQ3Rw86y0phO
    muXpyQadu3EXpS44ed1xfwkU2wx9m2Ze1QIvjybJFramGRk1BxB0/6MFhSfwZdPH
    +hLjCGk2UQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-85 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-85 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ02bpX8wMXMgHG4UjD/N/TZ0Xmgu963aqeLEMTWH34Unq60sljE8nWB7Rb2xRqQpv+7dJfWoq/e37mwKFpT715tl6kbmiSgCBbDtOq+MAULeE8NvcPy
    hsNPtJyNDXN6COiy1quNN+rZdsykvA+vZ2srKIfg+JpmCvYwgrV6rcfoPMZGTuerNlxOZQmJN6v7Th3TAd7A+oCvSwIm8oc8eySScfODICRHjxyUN90EPKRr
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=D19gQVrFAAAA:8 a=Ag2GKY2TJ1JtHe2dNT8A:9
    a=S9Id25sPtRSk1PkC:21 a=T3OiLwuRxJ7hajPE:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754183AbeDZINw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 04:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753968AbeDZINs (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 04:13:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE92821781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Thu, 26 Apr 2018 17:13:43 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
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
Message-Id: <20180426171343.630332329e9998a1ef617851@kernel.org>
In-Reply-To: <152473007907.8819.10449983839199591406.stgit@devbox>
References: <152473007907.8819.10449983839199591406.stgit@devbox>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 26 Apr 2018 17:08:00 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> This 2nd version of the series which fixes %p uses in kprobes.
> Some by replacing with %pS, some by replacing with %px but
> masking with kallsyms_show_value().

Oops, I missed to porting this on tip tree, but since this is
including some other archs, it can go directly to each trees
or linus tree.

Anyway, those should be cleanly applicable for the latest
linus tree too.

Thanks,

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


-- 
Masami Hiramatsu <mhiramat@kernel.org>
