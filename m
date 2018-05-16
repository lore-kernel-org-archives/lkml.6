Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-464884-1526485824-2-12207559438872253565
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526485823; b=BHNaagmPZ5Oa06NKtIp1uvKwC0PCvESt2zS7m+3ZlrkRMQVw6K
    Iuy3QPzm9d01Jj3jkHaGnLGGBnlZNn6FMgjgT+bzgbkfvy6BsLIgG3nKBSPJQGAY
    ag97AMmfT1lzRWVDmBpdJZbvUr4a0eiJwDoEGeuXf7YCSQM57l5GFB04FODkyhRl
    qxpjSthUglzJXSQUlooksBi03hkYhGz1jrJl2g4JCfkHlOgSDJBXfGToxHtLXsMB
    OOer2nZFkvxl54DwdT0zb8nTXxiVmxtEaHZXzcCdFQhpIXFbzdo+19OOv0Bt8HO1
    fw5LC/yMJ86X3htvc8U/466K7j9e5jwNeHFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526485823; bh=XktMXmnyT/3pDjyxBkv3eYk36gTq2a
    eIm2qsHyxRnrk=; b=bcB4QiHiX0PtUwK9ZUSE4CeEwEWrgSFjdUKYXDyZq00IQn
    niO28H0mEN1Ic5zMQLJ2WGIk6nBx6NY1Wi6jvsXV7q8C9AvaCrY9WjBvesgvKDQ7
    HyKYFQCh1T8i8nAjApLgXB9xVckt6QTsPPp1BNOzy7FnkFfp6rahDtJ1MKw8gvwu
    1H7qX41bzHLIXYUw14973ZqLyLpFaFtKkNRZdYqgo6R0/DQS628uSvFb91Hj/CCG
    cUUtFGaGkc0zuWBBvMFCCPOdJL49DsBC5408tHCrzxv/P0ktYbLiduD4BVCJYInC
    wIbsSszr+iAzK3KYQnKi2uJGwyYiEuSichqbzCTg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNjFmnafkqcVmn/B7bBJ9QKTbxXqGJv/UY50FaZrGI1gvmQc6daJWsZ0M516xtdg9sxE9z33knEBzrTxIj6AJCc7HDvKXlgXL8CjEx8zA63isTHMTQVI
    nUMjG8Xf6uYPmgT/my0fzg5e9tD62mNypZcUEQXjkkS3XadQeNp7JdZfbxh22gpKadbBt8NIBFDNzrLAgcVtDW4oUtfl0XqxY/MunIaG41nVoVdCWHVsdaut
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=3_uRt0xjAAAA:8 a=VwQbUJbxAAAA:8 a=1SLPAJIcIObXxY9mHrMA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=z1SuboXgGPGzQ8_2mWib:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750935AbeEPPuJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 11:50:09 -0400
Received: from foss.arm.com ([217.140.101.70]:50790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750746AbeEPPuI (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 11:50:08 -0400
Date: Wed, 16 May 2018 16:49:59 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Rich Felker <dalias@libc.org>
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
Message-ID: <20180516154957.GT7753@e103592.cambridge.arm.com>
References: <1526480447-18185-1-git-send-email-Dave.Martin@arm.com>
 <20180516152913.GY1392@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516152913.GY1392@brightrain.aerifal.cx>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 11:29:13AM -0400, Rich Felker wrote:
> On Wed, May 16, 2018 at 03:20:47PM +0100, Dave Martin wrote:
> > There are constraints on defining AT_* auxvec tags that are not
> > obvious to the casual maintainer of either the global
> > <uapi/linux/auxvec.h> or the arch-specific headers.  This is likely
> > to lead to mistakes.  (I certainly fell foul of it...)
> > 
> > For the benefit of future maintainers, this patch collects the
> > relevant information in one place, documenting how the namespace
> > needs to be managed, and noting all the values currently in use.
> > 
> > Maintaining a global list may result in some merge conflicts, but
> > AT_* values are not added frequently.  I'm open to suggestions on
> > the best approach.
> > 
> > I also assume that values 38 and 39 may have been used for
> > historical purposes, such as an architecture that is no longer
> > supported.  If they have definitely never been used for anything,
> > they could be removed from the "reserved" list.
> 
> On the userspace side (elf.h) all the AT_* constants are in one file.
> Why don't we just do the same here and eliminate the
> arch/*/include/uapi/asm/auxvec.h files and likewise the need to
> manually maintain consistency of the comments about reservations?
> 
> If there are reasons not to do that, I'm not opposed to this patch
> as-is.

I agree, it would be better to merge them.

My concern was that the correct way to get these definitions from
userspace is very unclear, so there may be software out there
including <asm/auxvec.h> directly, which would now lack expected
definitions.

codesearch.debian.net shows no real hits for that, so maybe I'm too
paranoid.

Since <linux/auxvec.h> only contains #defines, it may be enough for arch
<asm/auxvec.h> headers to include <linux/auxvec.h>.

Thoughts?

Cheers
---Dave
