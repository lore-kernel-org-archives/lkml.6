Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3641714-1526633619-2-8553626919246984716
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526633619; b=lqVn7p3VZsXQ9LKO/1Xme9QWYoKs7Zyp8RIV7LoW5Qgi7Qp+wH
    tTItm3Cd7Cwzr6xY0txTMKDHPH37uFKbmLSi4u97LsQ6cMUMwLCheR4ibU9bbBDg
    15nEcS7jKnCUlJZalSYTOkzpH++/gw/NTpDjtcOwLhSXaL06XVuOXYRXT/pEfTuF
    eSNEr6goZM1ZlbCGo3n9SY0JaJZdzAI2eIK5CXNW0AQoMFsNcMC8diZF3xcpjJ8C
    NAZuYICqbXNTawqTSrImpXxgRK7SNYTgroMCBzqWPw4OXnc9zix7mKnt5JxU5dNT
    AoVepcjKC8u/NQ0V29lWcBZbFRS9inAsU/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526633619; bh=F8ZRgr3kxK7dod0jK9eKv39dqc7yKA
    napUWkLW2OxCU=; b=E8hbnJ244u0Xlr5Yw/uPawsWR+ZnA7ZvKI77UqN8X7Hknn
    v/WVGNqfY3Ixy/mOVwf+dvQINGFQA2lYe+RpVfiuHkBKy9ztCjMSzyL6hVBQ3M8Q
    /SEQb8ePck0eFOdIYQ/0MKSZqh1J+1162YFw/bMPtZcWv469KIQEMiJBxKq8pzmk
    Z6lsqZDSX/mSk5WOlweSunw2+E4hQEqnYgjVXCmfZwILgq1JmbHfpi5E73eMS56/
    xcHByiH/k/wqongmsnK9IxZQcS8/+ymslAVfaea77D7hfdcbdX/uu3VcOTtWr0Ep
    IST20L+mjuEbu6kMswLI2QVZFg7YRDdW/QkCJlxg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCiwAHKTK4DX2lJvCoaBZWlbWqtH6jGGh9kXVEb9WD5xnaMps8VZw1aUUl40ZPgzojh/FHaCh4KJ6HiNqbgu2paQA2GNjvJwJLXfU4HnYAn4j0atUXrs
    no9Adq9DeppWn1Hph+phTMqEG1HZrj8gwfgPPWbZBqnxxM2lp8++rTmSWeKilRypPdy37ENx6R+sD8yR8oquTKkujIWyA4edP+hv2ZO4qvfXB9Cydrz44+Pn
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=l-qExSHx9O-NDgFdUrMA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751304AbeERIxL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 04:53:11 -0400
Received: from verein.lst.de ([213.95.11.211]:57801 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752383AbeERIwu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 18 May 2018 04:52:50 -0400
Date: Fri, 18 May 2018 10:57:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: James Hogan <jhogan@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] aio: implement io_pgetevents
Message-ID: <20180518085731.GA24387@lst.de>
References: <20180502211448.18276-1-hch@lst.de> <20180502211448.18276-8-hch@lst.de> <20180518082837.GA3264@jamesdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518082837.GA3264@jamesdev>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 09:28:38AM +0100, James Hogan wrote:
> Given this:
> 
> On Wed, May 02, 2018 at 11:14:48PM +0200, Christoph Hellwig wrote:
> > +struct __aio_sigset {
> > +	sigset_t __user	*sigmask;
> > +	size_t		sigsetsize;
> > +};
> 
> and:
> 
> > +asmlinkage long sys_io_pgetevents(aio_context_t ctx_id,
> > +				long min_nr,
> > +				long nr,
> > +				struct io_event __user *events,
> > +				struct timespec __user *timeout,
> > +				const struct __aio_sigset *sig);
> 
> The following paragraph in the commit message would appear to be
> misleading since __aio_sigset contains a size:
> 
> > Note that unlike many other signal related calls we do not pass a sigmask
> > size, as that would get us to 7 arguments, which aren't easily supported
> > by the syscall infrastructure.  It seems a lot less painful to just add a
> > new syscall variant in the unlikely case we're going to increase the
> > sigset size.
> 
> Is it possible to correct it before this gets merged?

True, the calling convention change based on feedback.  Al, is the
branch stable or you can edit this out?
