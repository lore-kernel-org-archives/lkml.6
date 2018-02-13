Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-441706-1518539766-5-13991522290798663333
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518539766; b=LfF+pMl8+vFJk8bJTFPmcGIHkCeTX8ahsvEJLvWFCf3MkkP
    mOulD1QSltFkoMj3XckatznKrBL1OLFoBZMi8wH1DHnFxyNQWZcmkR2l+gF8mr+6
    +ujem8rEB0F5Bdwuim5O3KMN5WnAADMVxxzZAGlN4FqGrWQPZBWZ1d7LLU0bEg5r
    YDX8VOEO7S+t+X1IX/Mfg7l3JwaDVIr2yr+oTE09aB9VCL/kPyv8MbhzrJ4V2yv1
    Qqol+ytKSw+9/qAHX22w/o0vqCdedUeNoi5RYlEU9ys4ZphSPLAaIsBtxj4Y6fc5
    xemetoXM4Ev37O7/qzYE/j6P7uHb5V/SCTA3RXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518539766; bh=UGDC0Ss1zsjsJVU95E2lkLp7/Y
    eZC9EqSTwZZ1jrmoc=; b=S7yhMCJraMot0/3u+tWdQvzTpOAr7wQzTrXVeYvjvk
    VbCW2bYVZCdmYwCVu5gWJY1lcG4fN1F7JV95wmUegPN9aO6xVdpCxju0hoy7a2LJ
    KzgYxU+uRrfu5D+4FDskO546UCqE1n5yTJclTN6Uo+yrPXgx/jFFQ0ZFZCaf6pbl
    ArVeugyfWLyX2O31B99gYKwDdZYmK59N536ULX/NqTT2ElFv9PzOdYgYBjgLY3WK
    kyK45m/EN0mSCk0Ov/YNT/HcpLQCWf7NTx1GSb1nk7UgW9ZKtoGsCmYGNedGLCSk
    dnfrctljL5hx8OpFZsw2KOS2jJt8hCGMXk3d8nDkPnYA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965218AbeBMQgF (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 11:36:05 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44786 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965194AbeBMQgE (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Feb 2018 11:36:04 -0500
Date: Tue, 13 Feb 2018 17:32:39 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nick Lowe <nick.lowe@gmail.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        gnomes@lxorguk.ukuu.org.uk, ak@linux.intel.com,
        ashok.raj@intel.com, karahmed@amazon.de,
        torvalds@linux-foundation.org, peterz@infradead.org,
        Borislav Petkov <bp@alien8.de>, pbonzini@redhat.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 4.9 43/92] x86/pti: Do not enable PTI on CPUs which are
 not vulnerable to Meltdown
Message-ID: <20180213163239.GA17101@kroah.com>
References: <20180209133931.211869118@linuxfoundation.org>
 <20180209133934.259299920@linuxfoundation.org>
 <CADSoG1tjU2G9FUNOFod4ZsYSw7gOSsza_JWUv5H6pAkbftWywA@mail.gmail.com>
 <20180213150007.GJ26982@kroah.com>
 <b0680083-5cd2-e152-0d64-f5a931274a8e@linux.intel.com>
 <CADSoG1sv4-YmRh8AwD7A93_eDLn4ZTwD0Y7C9jyRyh6nOvwqjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADSoG1sv4-YmRh8AwD7A93_eDLn4ZTwD0Y7C9jyRyh6nOvwqjQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 03:27:47PM +0000, Nick Lowe wrote:
> Hi Arjan and Greg,
> 
> Sorry if I am not being clear enough.
> 
> My point is that there is a check for X86_VENDOR_AMD now in two places.
> 
> It is still hardcoded for the auto boot option which I think should
> not be there. The patch on that basis looked incomplete to me.
> 
> Put another way, there is no effect to the auto option where the
> contents of cpu_no_meltdown[] are changed and
> cpu_vulnerable_to_meltdown returns differently.
> 
> The auto option does not make use of a determination of the
> X86_BUG_CPU_MELTDOWN state.
> 
> This seems wrong to me. It does not seem correct to me for the auto
> option to have this duplication with a check for just X86_VENDOR_AMD.

Do you have a patch that reflects what you want to see changed here?

And can you test it?  :)

I don't have any AMD hardware, sorry.

thanks,

greg k-h
