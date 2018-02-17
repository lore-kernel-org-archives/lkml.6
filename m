Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2858053-1518875162-2-366597779169807242
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518875161; b=i7lFk/+bMto++UdFIp5DwsNYncB+8lZGFOElbAPosx/TaD0
    kn2xucFNy4+nMT424gRWDkDcNQzNTOpwPw7zTnURhFBI/Muc9EkTV7besQHcbD8N
    aOcT7FZFBz1ZpX3OK/xNIi80p12I3r0E5sMChESIbRKD9B1dp8bHhK83rz6uwmjD
    VB1BIs+3+YElRtbQmsiYMBU+b4Ko/pcwPbHxwkgFaYCbdx5RVa9mJMNX+sPeZWy9
    TyL7+hA7kflJdmJhxyT5QcdaxxpfvT8Ug9ZUtaomtDYo9XERfVHafXhdKuqD/GjT
    bkSMdciLxWZQVYEZsRg9fI012PfzXTd2kGfUF0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518875161; bh=xx5xj08uFwyzG1QGtcX1u/rd0y
    J+6OSQFld+PYMPTEo=; b=fR5gXONUy22WxjhRgIj4uLm63Z01hjXkliHavfLE66
    IvWtva2cguE2ysbQg8HZM6kNnRKkaO2cChJ6Qarb3DSsjPlnIWcrRi4elVjzUMcH
    jd+uNN9vevnkaaC4IvaQRB/hYpt1zrGXaT1PNbhmPdRuWsUjAu1CwOK+4vHA47Tk
    MGTwKlGmP0zhE5tbd1t4rGFOQkfDsvXteeqdKC0H6xzIRmMA6FwoedR0cvaNcPf+
    CbPA3uu5N4SUVmLJ8b91V6EgrjRB+AxlU5KARATLRWmXs99p2pP+IaZJ1jJ7qGvD
    PVUaCEG22qsEnIoLd89cvhGf6TNVeRAJa4nGbbSzs/6Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbeBQNqA (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Feb 2018 08:46:00 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50526 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbeBQNqA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Feb 2018 08:46:00 -0500
Date: Sat, 17 Feb 2018 14:45:56 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yves-Alexis Perez <corsac@debian.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/92] 4.9.81-stable review
Message-ID: <20180217134556.GC28145@kroah.com>
References: <20180209133931.211869118@linuxfoundation.org>
 <556ea00b-e265-7f14-395c-c5e6629bf194@roeck-us.net>
 <20180213093651.GA29675@kroah.com>
 <7c1ed8b1-bd9c-4b9f-051b-f9f19591cdbb@roeck-us.net>
 <20180213152907.GA29190@kroah.com>
 <1518874313.9465.1.camel@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518874313.9465.1.camel@debian.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 17, 2018 at 02:31:53PM +0100, Yves-Alexis Perez wrote:
> On Tue, 2018-02-13 at 16:29 +0100, Greg Kroah-Hartman wrote:
> > > arch/powerpc/kernel/entry_64.S: Assembler messages:
> > > arch/powerpc/kernel/entry_64.S:260: Error: unrecognized opcode: `rfi_to_user'
> > > arch/powerpc/kernel/entry_64.S:270: Error: unrecognized opcode: `rfi_to_kernel'
> > > arch/powerpc/kernel/entry_64.S:885: Error: unrecognized opcode: `rfi_to_user'
> > > arch/powerpc/kernel/entry_64.S:900: Error: unrecognized opcode: `rfi_to_kernel'
> > > 
> > > Looks like 222f20f140623 ("powerpc/64s: Simple RFI macro conversions") is missing,
> > > or at least part of it. Unfortunately it doesn't apply cleanly.
> > 
> > Ugh.  Let's see if the ppc developers care about this or not :)
> 
> Hi,
> 
> in Debian we extracted the following hunk from 222f20f140623 to fix build on
> powerpc/ppc64el. Only compile tested against Debian builds though.
> 
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 3320bcac7192..e68faa4d1b13 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -37,6 +37,11 @@
>  #include <asm/tm.h>
>  #include <asm/ppc-opcode.h>
>  #include <asm/export.h>
> +#ifdef CONFIG_PPC_BOOK3S
> +#include <asm/exception-64s.h>
> +#else
> +#include <asm/exception-64e.h>
> +#endif
>  

Ah, thanks!  I've now queued up this portion of the patch.

greg k-h
