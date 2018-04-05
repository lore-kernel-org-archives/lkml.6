Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1580473-1522894642-2-12937728914664677777
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522894641; b=Vs2kp0aQPhsl6LojTQaD/TUsEhujWM64/4cMCDjB4XBCXbIJPp
    jnxoSA7JunwSA4WS6/tOhoMX6dq/iMoPFKK7P2V1TTtIxsE7irlXR/Wqkp1TCVHr
    XvjnxLzNpwO4LmL+FGPX+8CJ+FN7TNQfh7z34xIDJeLQzjPXx+MSA5w8zKSbu/Tt
    MTtHJdleVzxdSXuSRabP/tzhh8H2t96boxDaFHJFVa0KRX6YVlIS4R94KBGwspj7
    C4yEvabKzjcGSssvDUHRQ+//CA+5C0i10IBBCFiWNgdSJBiMvgigg1VOWyAQxjw6
    d8LmdubGwjwq4n54c2OJJgUgKfHU067OEdAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522894641; bh=mM7RFL8llu9jiXpRgKEarztlCPRPry
    vv8sT3Fjq26Ck=; b=e5sq3srMlS5IsXmyH/c5mQxlJU/iUYGsedmqXHCo8RnZhI
    wIsQvL8d+7bSRqksvsy4MD6NMvyjcGw1SKfL7HLF8nWHlBFJc9K64FuYiFPlFqpN
    j6G1vVmGRSQnrloz5MpTp1WlBLkLSVI+kKctwXENxgFZ2sVere1dHkAj5/qyrcmG
    jF5IyWgMNJTLrPaubaumK1Wez/FGtRH9CxPsDSECZDTqnj2srY/osmOuzsK9GxXT
    plrtwDQlTsP/D1CWBDgNH3VAFWgjEdfbwdflCtQh/WX/8k6UcNUrS+alyql+Mrft
    91QcqU9Pw4SLfAq6K2m6bSuhz2XJO+fYXG5QEsCA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOh/XrvT0U1ohs20AuEOChQNFm99yVi/8vpOVkDvqCueTBJdE4UjkmL629c1KSE5NWoP4AYlI6gkIUAbOKIILDzrvO0IgERKrWrPvg0BozayYKhKOeia
    sVUvMoa1+XB/t62ezTQVH2uxn2M7P3YlORPqlcGaNL6Jpb3AOTQwbG++AElUqKUxkym38ivNpCDPqTV/BybUYeEqJNuWZSBdZZqk/4uvvrCvh/VAY5XuC2IK
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=VgKRqyJbdwQXQt1S8sMA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbeDECRI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 22:17:08 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:40318 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752674AbeDECRH (ORCPT
        <rfc822;groupwise-linux-api@vger.kernel.org:0:0>);
        Wed, 4 Apr 2018 22:17:07 -0400
Date: Thu, 5 Apr 2018 10:16:50 +0800
From: joeyli <jlee@suse.com>
To: David Howells <dhowells@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: An actual suggestion (Re: [GIT PULL] Kernel lockdown for secure
 boot)
Message-ID: <20180405021650.GC7362@linux-l9pv.suse>
References: <CALCETrUVQLDC6_VEvuAbdCOuGrmcxohqTB6P8eyNojm9AryNkg@mail.gmail.com>
 <1119.1522858644@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119.1522858644@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi David, 

On Wed, Apr 04, 2018 at 05:17:24PM +0100, David Howells wrote:
> Andy Lutomirski <luto@kernel.org> wrote:
> 
> > Since this thread has devolved horribly, I'm going to propose a solution.
> > 
> > 1. Split the "lockdown" state into three levels:  (please don't
> > bikeshed about the names right now.)
> > 
> > LOCKDOWN_NONE: normal behavior
> > 
> > LOCKDOWN_PROTECT_INTEGREITY: kernel tries to keep root from writing to
> > kernel memory
> > 
> > LOCKDOWN_PROTECT_INTEGRITY_AND_SECRECY: kernel tries to keep root from
> > reading or writing kernel memory.
> 
> In theory, it's good idea, but in practice it's not as easy to implement as I
> think you think.
> 
> Let me list here the things that currently get restricted by lockdown:
> 
[...snip]
>  (5) Kexec.
>

About IMA with kernel module signing and kexec(not on x86_64 yet)...

Because IMA can be used to verify the integrity of kernel module or even
the image for kexec. I think that the
IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY must be enabled at runtime
when kernel is locked-down.

Because the root can enroll master key to keyring then IMA trusts the ima key
derived from master key. It causes that the arbitrary signed module can be loaded
when the root compromised.

Thanks
Joey Lee
