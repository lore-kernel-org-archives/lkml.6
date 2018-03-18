Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3317507-1521355690-2-8317653664317397132
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521355689; b=hkimTWt9zVBxmQwnfbgMjSjHY1iH85Ccqis3xe8HLoSXdY+
    yNYE41h2BjYnpzvRyRG1IIlDiGGVTbjk0R4LF2bWzD2NOhEoHtqQDmh6lxsb9qNn
    FaNjAPwfdZjH/RNVq3zrg7dPbmnoky3h5G9fou9XtjUYrJhb1ps7mxCUNcaOFNvv
    Db3LLMoW3iUW5Aa/pAGmNtvbuzrBHj9vLG9mT6kOEgDy06fkHYq101KCf+tClJxx
    D8l8KPsL2xIvftU8zYo+PwJ7tDjjLysSUurtBUSgAE//x0A/X5YjA8UOggki/S1m
    q1jHelpi/4mm4KaYSM4gttLknNKwm+xoDkIVccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521355689; bh=Xg7CUu7hWBxz6LZ3U5Kx9HEq5m
    87gp8R+mHu4Resin0=; b=lavhK+SmtP1+b/Fl9xIX9rYGG0SDYeUFKybCzXbYKE
    eQyMWr9hEpx/uD0GZPAgWdWqVpyObyIpWurqARsyGJZIg6HVs0wnsCvshB1UKsni
    tJiq6i8Vlv+P3JeDKCIkrZKtaRUHITPFBw3HLdyJAyCeLGRbwFKPWOBfIm2C7bTu
    TCMSS/SW4UBddb7sEEIqyIdSMsQOYuVgq2EH686KO/RijHx07ysZop4kV0H7lwZf
    V9FpaQPzLtw7ERSd4hlBVR7I+DWI1O6JyxHh3Pi+vpPbh7S2rDNI5vdvgSHtAnCB
    +BML4OIsBNIRWhBwdUz1oZAIGJ93Kgiq1V/Zb3rR3xBw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=dominikbrodowski.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=dominikbrodowski.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=dominikbrodowski.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=dominikbrodowski.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeCRGsH (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 02:48:07 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:57552 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbeCRGsG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 18 Mar 2018 02:48:06 -0400
Date: Sun, 18 Mar 2018 07:47:38 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Howard McLauchlan <hmclauchlan@fb.com>
Cc: Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yonghong Song <yhs@fb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Garnier <thgarnie@google.com>,
        kernel-team <kernel-team@fb.com>
Subject: Re: [PATCH] bpf: whitelist syscalls for error injection
Message-ID: <20180318064738.GA22649@light.dominikbrodowski.net>
References: <20180313231627.1247-1-hmclauchlan@fb.com>
 <CALCETrWWAB4FcDe=uUUBiq9YZ-jN1G7kNjdEw=Pwe1SSqyL5LQ@mail.gmail.com>
 <f47e1374-43eb-d7c6-dd0a-5d530ff2b4e2@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f47e1374-43eb-d7c6-dd0a-5d530ff2b4e2@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 03:55:04PM -0700, Howard McLauchlan wrote:
> On 03/13/2018 04:56 PM, Andy Lutomirski wrote:
> > On Tue, Mar 13, 2018 at 11:16 PM, Howard McLauchlan <hmclauchlan@fb.com> wrote:
> >> Error injection is a useful mechanism to fail arbitrary kernel
> >> functions. However, it is often hard to guarantee an error propagates
> >> appropriately to user space programs. By injecting into syscalls, we can
> >> return arbitrary values to user space directly; this increases
> >> flexibility and robustness in testing, allowing us to test user space
> >> error paths effectively.
> > 
> > Temporary NAK IMO.  Specifically:
> > 
> >> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> >> index a78186d826d7..e8c6d63ace78 100644
> >> --- a/include/linux/syscalls.h
> >> +++ b/include/linux/syscalls.h
> >> @@ -191,6 +191,8 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
> >>
> >>  #define SYSCALL_DEFINE0(sname)                                 \
> >>         SYSCALL_METADATA(_##sname, 0);                          \
> >> +       asmlinkage long sys_##sname(void);                      \
> >> +       ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);              \
> > 
> > sys_xyz() is not just the syscall itself; it's also a helper that's
> > used for entirely silly reasons by various bits of kernel code for
> > quite a few syscalls.  Fortunately, Dominik has patches to fix that,
> > and Linus is even considering pulling them for 4.16.  This patch will
> > most likely conflict with the final result of Dominik's series.
> > 
> > Can you and Dominik coordinate a bit to get this patch or its
> > equivalent landed on top of Dominik's work?  It might make sense for
> > Dominik to just add this patch to his series so it can land with the
> > rest of it.  Dominik, Ingo, what do you think?
> > 
> > --Andy
> > 
> 
> Dominik, 
> 
> This patch applies cleanly on top of your patch series. Is there anything you'd need from me to get this in on top of your work? 

Howard,

would this form part of the kernel<->userspace interface and therefore needs
to be kept stable? If so, this patch should wait until the arch-specific
syscall calling convention is agreed upon.

Moreover, the patches I sent out already do not cover all syscalls yet.
Until all in-kernel users of sys_*() are gone (or at least outside arch/),
I'd prefer to postpone this patch.

Thanks,
	Dominik
