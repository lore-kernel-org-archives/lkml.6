Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3996454-1521638142-2-18339076579940844748
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521638141; b=XSRmoiiHWy6VjJZIAFypdEqWDtj1LjLYvIB0qzHN/cw+Swp
    U4YHX392XKK2gst8yTCTL4x3z4JKvSe4MzDrV/bnvFnLEHOiLDLsWWIvcVgnPvwn
    IA6M1KLdUYUjvs0pkAslzxHjWjcEzAM5ESb8k/qKWVuM2osZd2hqi10cNC2AfPO1
    FyJT0ebZgOVbvI9Q4/mt4/rDm8lyBSARzEfezzwc1hD2DzvuohJIgxg7BY6pa777
    gnTnXaxOTlwktO5eK0V1h/8OzTLUU9EN2nnycO73XVAwngf6NzGd8aN79k1O2OSU
    4L00hXdfGqYHVqqnCYpd3cTYBM2egn8fk/5mZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521638141; bh=5gA2yQoWGzR0x9K0rjNWdRIIZ2
    u/RqwVjvZQ/u54/f4=; b=JRZzsk/n6a+jJoEw6UaBVr5SyPoRDmYso5SRGgXUEz
    wpO8PFMOUUZpcRQMgvKe+AK3OgFS20iOMENJUCnqK+fgaHKclsh1K9KBlf7HsIob
    gAnnUEs9RMRUFnKwk+jkPoCudSUg+leak9Gm4yoxc4FyxqBLIACOgDgjMCLTNmUu
    rIZ+2XbEmxj4tmViTQnw4Fk5nAs1vZ9XaVubYHJZ5hW0gHRt4cS6LlSnXZue4wfv
    TxRD2T/V79kuNmzZDXNE5Sod4vzSTcPG4XMBjOXjnFytbvEOhL3rtEqxUpH31TqP
    dter6r+4FZrAHS7k2wFTHKsZ4OLXcZ3ZmS8K6jPxhMfQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeCUNPj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 09:15:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36168 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbeCUNPg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 09:15:36 -0400
Date: Wed, 21 Mar 2018 14:15:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/134] 4.4.123-stable review
Message-ID: <20180321131534.GA17188@kroah.com>
References: <20180319171849.024066323@linuxfoundation.org>
 <29591855-050f-073a-bc29-f0ff2832ab40@roeck-us.net>
 <20180321052911.GA14175@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321052911.GA14175@flashbox>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 10:29:11PM -0700, Nathan Chancellor wrote:
> > powerpc:
> > 
> > arch/powerpc/mm/hugetlbpage.c: In function 'add_huge_page_size':
> > arch/powerpc/mm/hugetlbpage.c:840:2: error: implicit declaration of function 'radix_enabled'
> > 
> 
> Caused by commit 17cd5e81ded7 ("powerpc/mm/hugetlb: Filter out hugepage
> size not supported by page table layout"). It is introduced in 4.7 in
> upstream commit 566ca99af026 ("powerpc/mm/radix: Add dummy
> radix_enabled()") and not properly turned on until upstream commit
> a8ed87c92adf ("powerpc/mm/radix: Add MMU_FTR_RADIX"). I am going to
> assume from the fact there is a lot of MMU work after this and the
> wording of the Kconfig entry that this is probably not suitable fo
> a stable backport.

Now dropped from the 4.4.y queue as well, thanks to both of you for this
work.

Let me go do some more -rc releases now...

thanks,

greg k-h
