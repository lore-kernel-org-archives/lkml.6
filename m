Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-464884-1526484565-2-4183654283613327018
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526484565; b=junsXSQD5GizT/H0lX6/4hH8MfIC7BsCnqdrxgHN2YR9QIw/WR
    dG2/P/I2th5c3aXVT7PZV0V8vfOPo+d6pbVodwhBidyXE+GR5B1JEcsUJ1GZsh8v
    3HClsyzwQnQ+uUiQi7fcWCYbpWjPRwummeuzg6fqu5yM6MbkaUDFQUdLF9crjCFq
    89gotKCAYqAz7UAFQgfzZ0ZSiZr6p+LGvyWk3VHJsp0v1kiqiA1hA1OfvCHdeYm+
    gWorQ4Hv8H6rZN8P5V4/e2oXidGGxslDZY8izi0EZ6kbDiFozLgHpxgf5iDmCqgL
    4hyyERVQG0BPRHOvX5nnNddw3e8U9OtOdmlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526484565; bh=htNgo48u79cMaX3SVeUEEvREaVadEO
    90KBlD55ZVW0s=; b=IrM4F9DFR6BXncceAAEj5ELOZQzeKNOgSB4D6zUkLMDL3D
    oRoKUUy9PUDENSt/PkB2HSctxEXDrPQzeSBDFpslC7g+b0KcLaIq+f8777WjNmUj
    zIfocxRAPhUcq78SH751NREHDHveDwSdAC3hep2cdPGmt5RNT3olAjW26lcU99w7
    gFvE8WkMHWPmK8l2tIWhA66xXS+6NX9qONhKZJfpRrV0JmZnPt3E5+aS3pNlEJLQ
    FA7URQvtx6kcLw2/45e4wYV2euTqS1RHiC1beLvCOQn9CFaZhnhw4M3wXbeEX+fq
    XKORoZz2ge68n7SdWqzcE9IJc8noR1UIolTIAh5A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=libc.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=libc.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=libc.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=libc.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMFu33GYGkKY0++ey7rLuXX7cDb6Tvf9snnLDkMGYCoDPUaJp+9X0OR/S3g1Ym2lCrxh+eUKeabpXHgmHVYhk9CE0AHjuWxDEd8fF2B8H8O4JGSHX7xx
    8xtCjK6s78rAtJuHDLjUN2EYdBzhH3QojzhuV5jv106diRKqBrVYcHB1o+uufONvQQ4JqZ9WwKJ6nyh67VGDxjJqxXu+RSrtltFeEzQ4G8qrqdrWvlk680/S
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=OwNxuvSxhCER4x0mGg0A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbeEPP3W (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 11:29:22 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:54160 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbeEPP3V (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 16 May 2018 11:29:21 -0400
Date: Wed, 16 May 2018 11:29:13 -0400
From: Rich Felker <dalias@libc.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [RFC PATCH] UAPI: Document auxvec AT_* namespace policy and note
 reservations
Message-ID: <20180516152913.GY1392@brightrain.aerifal.cx>
References: <1526480447-18185-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526480447-18185-1-git-send-email-Dave.Martin@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 03:20:47PM +0100, Dave Martin wrote:
> There are constraints on defining AT_* auxvec tags that are not
> obvious to the casual maintainer of either the global
> <uapi/linux/auxvec.h> or the arch-specific headers.  This is likely
> to lead to mistakes.  (I certainly fell foul of it...)
> 
> For the benefit of future maintainers, this patch collects the
> relevant information in one place, documenting how the namespace
> needs to be managed, and noting all the values currently in use.
> 
> Maintaining a global list may result in some merge conflicts, but
> AT_* values are not added frequently.  I'm open to suggestions on
> the best approach.
> 
> I also assume that values 38 and 39 may have been used for
> historical purposes, such as an architecture that is no longer
> supported.  If they have definitely never been used for anything,
> they could be removed from the "reserved" list.

On the userspace side (elf.h) all the AT_* constants are in one file.
Why don't we just do the same here and eliminate the
arch/*/include/uapi/asm/auxvec.h files and likewise the need to
manually maintain consistency of the comments about reservations?

If there are reasons not to do that, I'm not opposed to this patch
as-is.

Rich
