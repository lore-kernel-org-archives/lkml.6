Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3419880-1522822343-2-9008285235480269985
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522822342; b=wOaSfUlBXzorpiLivI5f+/s4k1PXya16OR6Bqx/yyivqUhOaz/
    x/X0bZkuNycQwfl4fvXBY8xaDYua0/pFdGstluISKg4nWl7i5RfX9OkThHkTESfF
    W/uThy7wuYsISZcnNw/gxms9c0NDudNLgFm9oD7XMzsiPmCHmi/4p+Ms+ZfDkrP2
    rWUjULv5c3dkmKCLtXcHNieXt04kNpi5w5lLM/OO8JPyD03dZkFf5HBuJj8S8Tt9
    RSesVUh7HfrolXiUYKZ0nUgj0fnV1LBVIn9ThZOZJX/VyNxPQLcUoInPCYcPORli
    N1o07Bmd9ckV6Yigf5eb7GwZrKUetE29bK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522822342; bh=cc8n4hJNpId3JYzTW9Jw9HfjvERMiJ
    GKd4wF/ZcOpSA=; b=vAtFcgeCoPlfNvjFTEcrpkogfYRZ32WYY2GhZd7KSuaxTh
    ozpLcSUjTy29hEMU8LnauqvJ2PpOKvJ2v13JgMVmbVUZIhua5ZqfXxibznH9Ax/c
    IXW37EaFBVhSb6mQAy2E660oIBBoj5+bY5sYCQxn8el+oEc5ym4h1Ztxje6lw1up
    iTyLDlRRj9B42OAQA9EdWSYVITtSFO67PNsKcqZZmAP15VjullSjoOTP7Vhsx9ol
    1Xw1yszllZQxWKdOflAALAr4tJj2nkFbnsfydv7IsILvm8QCCgxgAyfxRUsgW93O
    JPvMoy6Y1Vt36ADNQp4bO9aHNQ3auqEbhx3Nbw6w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=kJ3JhjQP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=kJ3JhjQP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMoSjEPL92OHFjAUupi5rgb+b+T9Ggw6FjvxxNwkX5Yqa+dgIxWEHoO5UKxB5+cuDNo1CWxE9XNeyEb4dTY5tfm0cYca9h3kIYNK14211iERlHSnX37X
    VJRkKPPs+/45tJZYQuN1VAdJq0WTYJgF+6EHkfm7AWvyL0DfFSlpkr+2bnvZfVkhNiA+bNOPAi5PdwFHoQkzZNDGa1NJlQioBFl3h+n4q7N5Qrfss7dLC0iO
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=3Xw2PVSnxIHiOtJzUXEA:9 a=CjuIK1q_8ugA:10 a=UmJe55C3X6MA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbeDDGMI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 02:12:08 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44995 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750938AbeDDGMH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Apr 2018 02:12:07 -0400
X-ME-Sender: <xms:tmzEWlYW094gL4qycmMw6D78wiBGdXCjFipUxHc5T25icVvDp1zeKQ>
Date: Wed, 4 Apr 2018 08:12:06 +0200
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Omar Sandoval <osandov@osandov.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: Please add 21035965f60b ("bitmap: fix memset optimization on
 big-endian systems") to the stable tree
Message-ID: <20180404061206.GA16241@kroah.com>
References: <817147544aa3ecc2b78d6cadeab713869d8805e6.1522709616.git.osandov@fb.com>
 <20180403181457.GB17679@vader>
 <CA+55aFyDWoumDsNKNYD8B_zdMuFc19+Ngi0Nh7bUGVKn9TT=OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyDWoumDsNKNYD8B_zdMuFc19+Ngi0Nh7bUGVKn9TT=OA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 11:57:26AM -0700, Linus Torvalds wrote:
> 
> Greg - if your automation has changed, and you actually really want
> the "vger", let me know. Because I tend to just use
> "stable@kernel.org"

Either is fine, my scripts pick up both variants.

thanks,

greg k-h
