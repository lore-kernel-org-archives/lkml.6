Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1096172-1517922853-2-553524042876910232
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
    t=1517922852; b=H0sKNcP/wV4iV5rePJIGeqUQQwoFaUGITtcjoWwKz6UnWjP
    EeOQn/Zuvld/d7gbVuUZXjfspTo5B9dSE4P8CK1nrkH5UX/TBU2g6Pz/rmeJtuzA
    BN9UBoz17FoyDtpLyokp44YHqoCcW/Wh3SHNvSi4D5+GCNezxk/7izObMRyNwFJ9
    Cvtr9ILVC/kH1PpB2orEIzC6YSDQnsxT4w/AdVBjM6Zhv9rajmoeF2y6mEPQSlLK
    Ielw1CmA6KENYQFSscaxIPvTR78NO+8Uxup8ujujb9hz8uzjSecyGFzoNYe0nF2G
    PS6BjjHk5oWlhjVe1SNZYBd1BK2nrcct1spTbeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517922852; bh=5eiGKSKe7FB1bROc3lyFqoykFv
    a/1LmWhRs28qx+EsU=; b=HJiQdI9CtG35nFA16Qsm6xwKRLoCZ4nMQYQwSK0vHg
    xHevtxCV8Gfr6Ty3RqSGM9f4D1aSHFO97gmDiTdulTFF/3L+NzGBHltMEjhxl6Ft
    3VJPTk+Dx5M/SFBbvn0lH+LP6uOVUOToUf0aXExDGgJ31fFrUtFHekviYmWMbC5x
    fmXz8gJYVcvoCl2gAZ7+ZxHBZTmTnZKXA2UQP3qVB+3rv7oJRMTTppDWbhMPWArj
    BHUf3W/Q3jv81SeiIo6EM521r/lweMpxbA/hziqp5gfABQAOOJFEhPrHc/bHRO9A
    o7oVyLhFaxbZ8bi6kUkr8nFT7/51nB0vm1NLM83lVfvA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeBFNOJ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 08:14:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48594 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbeBFNOJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 08:14:09 -0500
Date: Tue, 6 Feb 2018 05:14:07 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harsh Shandilya <msfjarvis@gmail.com>
Cc: akpm@linux-foundation.org, ben.hutchings@codethink.co.uk,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        shuahkh@osg.samsung.com, stable@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 3.18 00/36] 3.18.94-stable review
Message-ID: <20180206131407.GA4222@kroah.com>
References: <20180205182351.774761393@linuxfoundation.org>
 <CALpmF+GKNPabSb1QjBf4nogZRryhU7oD6MRsB8yrU3esT0KxMA@mail.gmail.com>
 <20180206103404.GC10790@kroah.com>
 <CALpmF+G1Cn7-1Oe2xiNXcGq-cvSPj8GPQTEf0AEF7wN-FDLvFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALpmF+G1Cn7-1Oe2xiNXcGq-cvSPj8GPQTEf0AEF7wN-FDLvFQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 11:42:15AM +0000, Harsh Shandilya wrote:
> On Tue 6 Feb, 2018, 4:04 PM Greg Kroah-Hartman, <gregkh@linuxfoundation.org>
> wrote:
> 
> > On Tue, Feb 06, 2018 at 06:48:53AM +0000, Harsh Shandilya wrote:
> > > On Tue 6 Feb, 2018, 12:09 AM Greg Kroah-Hartman, <
> > gregkh@linuxfoundation.org>
> > > wrote:
> > >
> > > > This is the start of the stable review cycle for the 3.18.94 release.
> > > > There are 36 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Wed Feb  7 18:23:41 UTC 2018.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >
> > > > kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.94-rc1.gz
> > > > or in the git tree and branch at:
> > > >   git://
> > git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > > > linux-3.18.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > > >
> > >
> > > Builds and boots on the OnePlus 3T, no regressions noticed.
> >
> > Yeah!  That device is the only reason I keep this tree alive :)
> >
> > thanks for testing and letting me know.
> >
> > greg k-h
> >
> 
> Guess I should drop my kernel tree for the device and save you the pain of
> maintaining 3.18 :P

Heh, maybe :)

> Atleast CAF has been keeping up with upstream now thanks to your
> kernel-common merges so there's still hope for MSM platform users :)

That's good to see. Now if only those platform users would actually
update their kernels to these new versions :(

> P.S. common merge should go in cleanly, both the merge conflicts I had were
> from CAF changes.

Thanks for letting me know, that's great to hear as I just had a
question from some companies who are worried that taking stable patches
will cause tons of merge issues.  It hasn't in my experience, and seeing
reports of this from others is great news.

thanks,

greg k-h
