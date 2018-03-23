Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-212616-1521777560-2-14983539106568587264
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521777559; b=KzuVEzIxRUH7i243opK4zrI1fKoDITu3pDUtGWlPgSE5sat
    oj2G5UcTEzWKQK240D9iMPQ3qg9XLOfQtNInbcup51sngWTkUtuxAN4eELO36WtO
    NlKOV7UHRicKYbkQcgtg00g/HcQJHepBz4frDADCWvr/Dc9gYeyUZxdbgGNEYvkq
    11NWFJcDUcbu9VXAERWQU+BDw915ZydjHKp3YNOY1GDpLNr9MdaEcBBWuNfogzio
    DUHxD6FubeLeBAoZBBdzZ6rQFJAuuBNfox+iH7fu3zrtrANyOG6HNQp7e+y52x3J
    zv/zuKWfvcEE6KLNN7VxL7ZOVyyRxj4GkVqJH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521777559; bh=5SvjjoAUaysI2wrTTFD9UUpWnSloq+ThLng+isqMh9o=; b=b
    PLEJ/lMYSLgo0F9Z9Oa6qLCtZQFBmzuGjCmRdVjVRFchDCIoGB+ao3JYWHtZxuP5
    3G1MnG6Rc3JUJTYEZjzqwLBX8x05YIZu2FtGk/PF7hs28P75r3/cNTY04I4YQZXb
    XYgdptbyNC2B9EZS/s7W0ySx4Ni7CmOXbieGZIfPkmoKdHSD0oLZUavudJGNpFp7
    g2BUszfOH4VY+zAeHqzeCc7o/uqf/lOR65IQYGcuPl0vS58Fy1ZI04MBCoOWXf8M
    5cfW/FC4AJf8J1bh1K0CIMiW9bLzQ3wai68jiVO4QZI2xhCsWsCX59nG/OpfgaSX
    SFDkK0k+cMIutdIu18ymw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=flygoat.com header.i=@flygoat.com header.b=bOqWGPya x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dkim=pass (1024-bit rsa key sha256) header.d=flygoat.com header.i=@flygoat.com header.b=lHkXx2N2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=flygoat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=flygoat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=flygoat.com header.i=@flygoat.com header.b=bOqWGPya x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dkim=pass (1024-bit rsa key sha256) header.d=flygoat.com header.i=@flygoat.com header.b=lHkXx2N2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=flygoat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=flygoat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeCWD7Q (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 23:59:16 -0400
Received: from forward106p.mail.yandex.net ([77.88.28.109]:46269 "EHLO
        forward106p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751899AbeCWD7Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Mar 2018 23:59:16 -0400
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Message-ID: <1521777055.1510.9.camel@flygoat.com>
Subject: Re: [PATCH V3] ZBOOT: fix stack protector in compressed boot phase
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: James Hogan <jhogan@kernel.org>, Huacai Chen <chenhc@lemote.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        stable@vger.kernel.org
Date: Fri, 23 Mar 2018 11:50:55 +0800
In-Reply-To: <20180322222107.GJ13126@saruman>
References: <1521186916-13745-1-git-send-email-chenhc@lemote.com>
         <20180322222107.GJ13126@saruman>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

在 2018-03-22四的 22:21 +0000，James Hogan写道：
> On Fri, Mar 16, 2018 at 03:55:16PM +0800, Huacai Chen wrote:
> > diff --git a/arch/mips/boot/compressed/decompress.c
> > b/arch/mips/boot/compressed/decompress.c
> > index fdf99e9..5ba431c 100644
> > --- a/arch/mips/boot/compressed/decompress.c
> > +++ b/arch/mips/boot/compressed/decompress.c
> > @@ -78,11 +78,6 @@ void error(char *x)
> >  
> >  unsigned long __stack_chk_guard;
> 
> ...
> 
> > diff --git a/arch/mips/boot/compressed/head.S
> > b/arch/mips/boot/compressed/head.S
> > index 409cb48..00d0ee0 100644
> > --- a/arch/mips/boot/compressed/head.S
> > +++ b/arch/mips/boot/compressed/head.S
> > @@ -32,6 +32,10 @@ start:
> >  	bne	a2, a0, 1b
> >  	 addiu	a0, a0, 4
> >  
> > +	PTR_LA	a0, __stack_chk_guard
> > +	PTR_LI	a1, 0x000a0dff
> > +	sw	a1, 0(a0)
> 

Hi James

Huacai Can't reply this mail. His chenhc@lemote.com is blcoked by
Linux-MIPS mailing list while his Gmail didn't receive this email, so
I'm replying for him.

> Should that not be LONG_S? Otherwise big endian MIPS64 would get a
> word-swapped canary (which is probably mostly harmless, but still).

Yes, he said it's considerable.

> 
> Also I think it worth mentioning in the commit message the MIPS
> configuration you hit this with, presumably a Loongson one? For me
> decompress_kernel() gets a stack guard on loongson3_defconfig, but
> not
> malta_defconfig or malta_defconfig + 64-bit. I presume its sensitive
> to
> the compiler inlining stuff into decompress_kernel() or something
> such
> that it suddenly qualifies for a stack guard.

Have you tested with CONFIG_CC_STACKPROTECTOR_STRONG=y ?
Huacai reproduced the issue by this[1] config with GCC 4.9.

[1] https://github.com/loongson-community/linux-stable/blob/rebase-4.14
/arch/mips/configs/loongson3_defconfig

> 
> Cheers
> James
