Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2294769-1518722318-2-6603134957685429847
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518722317; b=LeID1bjgzv/UAfb9XK1TRHcBw59GwoipCqjee88lfOXQedV
    OGUQiesESOgg1YIARcvHmNXeP1O+txXoguGLXZ7ZjDPNBqOccz4tg5ndUHmyigP+
    erPDCnPlPvzFqtzFs9He8lNto/P6HYiXUpAxt9HyJlPWT4uSWTOG+jQd1+7aMGg0
    8/07YKbRbBw2MYu0JWieq5bWxEVQ206uf45GwMevltnwjPyhZ5NbPV4vak4mhXos
    dkEAOi3OArYIgujw3sGrpO5Qe9v2lH9R8DKZbndvgHCVYjVNDy+bBr36sHY7R3F1
    +297OpJY0POnaHC0pdCBw9LXdVu5OeFbvEJcrag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=arctest; t=1518722317; bh=CZE14iiVEm6liRiWKGFiNZ7dhGSrxmbHJ0/
    St0bAWkE=; b=FaIOFP71yga/APlUBavmekkQ6JYfBC9pX4c8Ybe5tkfYQ0VZoJm
    yi6bzrL99AiQ7PK6iZpwrge+EP4Fv6Gj47T6zcW8/2C6HvTy84tnPuKdCDkzYY/2
    w4F0uMl1shgQDs6/xcUlFRmcEfP94RbKhutrf7iZ+CZnDcUUPqZBDGlxKkLd4zCO
    bwvUxL4AItWzOZUKs+f17920AX49C6AD1ORZnZOW+itHXQkY4QivYd7pmi3W5LLn
    yTCiq7mcaC1mT0JOdSe9iyEFgfSOcLsQjTDelRCH5DZ6EEF48Av+qr0ntgyn908g
    g/eYDEAojxGhzPZZdtswYqFwNN/UeIEoZbQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=kP+4p2bg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EetDXKP5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=kP+4p2bg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EetDXKP5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162446AbeBOTSe (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 14:18:34 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42921 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161053AbeBOTSd (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 14:18:33 -0500
X-Google-Smtp-Source: AH8x227MCRRzdK9jYqIm5TfDzZ+A5Co2yPXIa4Cfvv9W12fVIy41ih9wBy4WxvwlZNdEEkJvkNs6FA==
Date: Thu, 15 Feb 2018 11:18:21 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] [stable-4.9] x86: fix build without
 CONFIG_X86_VSYSCALL_EMULATION
In-Reply-To: <20180215164922.GB6699@kroah.com>
Message-ID: <alpine.LSU.2.11.1802151104240.1652@eggly.anvils>
References: <20180215151710.1473117-1-arnd@arndb.de> <20180215164922.GB6699@kroah.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 15 Feb 2018, Greg Kroah-Hartman wrote:
> On Thu, Feb 15, 2018 at 04:16:56PM +0100, Arnd Bergmann wrote:
> > I ran into a 4.9 build regression in randconfig testing, starting with the
> > KAISER patches:
> > 
> > arch/x86/mm/kaiser.c: In function 'kaiser_init':
> > arch/x86/mm/kaiser.c:347:8: error: 'vsyscall_pgprot' undeclared (first use in this function); did you mean 'massage_pgprot'?
> > 
> > This is easy enough to fix, we just need to make the declaration visible
> > outside of the #ifdef. This works because the code using it is optimized
> > away when vsyscall_enabled() returns false at compile time.
> > 
> > Fixes: 9a0be5afbfbb ("vsyscall: Fix permissions for emulate mode with KAISER/PTI")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/x86/include/asm/vsyscall.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Thanks for these, I'll queue them up in the next round after these
> kernels get released in a few days.

Thanks to Arnd, but please drop this vsyscall one Greg: it duplicates
my/Tobias's "kaiser: fix compile error without vsyscall" that you just
sent out for 4.4 and 4.9 review.

Arnd's PAE one looks good for 4.4 and 4.9 (well, in another context I'd
object to using a different prototype in the stub, but I'm pretty sure
Arnd feels the same way, but has made the appropriate choice for our
Kaiser backports context): so please do take his 2/2 "x86: fix build
warnign with 32-bit PAE" for both 4.4 and 4.9.

Thanks,
Hugh
