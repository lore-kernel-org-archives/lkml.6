Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1495316-1519347394-2-8586511118650754743
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519347394; b=XXEAiR4MCaEagemTemNVd+gUjO3zm7GGr7/aLCWMCu3k/my
    j7i//kj5TneSBtRCx9U/JtrKeyJNz8h1rNH84E9nbTBh/2NJul1OJ9VgM2DF80aE
    GxYx0vvLx6OiFVv5fn/dzZSdzXyz26JrxxuaHhHFcS+S7BujmJs74oiaKRJumP/R
    +cfMrzD/lxr/lHKRwXqI4E+mOYhUlb8lV0MZ5mNiNs6A15YjaPDomF3YEHPBSs7T
    ieWjCIk7Ph3N8cdYhmFweIfCTwjfBrn/J9vktv8CNmaG4Uw7JGVFTs+xQIDyKQv2
    g6Pt0zlN8VD3rOvjQ9TZyf+4PFRj/9TiYO3pN2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=arctest; t=1519347394; bh=ApIViDa70/FTS4LQbjiNM9mIVprMz04Hq3A
    fnCVpHP4=; b=B+qUGo+RMl40BvzujkBlLCexdFTLkwL/9rBNYPnr7WKziZBTMxC
    hBW2FC6myd68XPUlNmDbHTJgArNAULVFCW4M0EXt6byn2gcI9Zm+oF9e9kQBlbAr
    75DANvB1xRtoIWBXUoWEQnr8+KfVkCYFw59Clhe74NIr9jFKEISMNvT1MrT4Fl4o
    ezkt4LmZyyvy55YqF1Au3uk70Z5wov9ot5qISHu+ceD6k8T1uosJj7xKHeXj6Tss
    YwV9xzt5Ymztkdr8lC11v6AgBc1WbhgmuO9X1q5RrYJYWQQ3qVesyWiHcZf5C0oC
    cGEsXvCNHnj0ADqVLrUmMtBfY4nelZsNObw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=namei.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=namei.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=namei.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=namei.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750916AbeBWA4c (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 19:56:32 -0500
Received: from namei.org ([65.99.196.166]:50364 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750776AbeBWA4b (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 22 Feb 2018 19:56:31 -0500
Date: Fri, 23 Feb 2018 11:24:05 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: David Howells <dhowells@redhat.com>
cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [RFC][PATCH 0/6] KEYS: Fixes
In-Reply-To: <29946.1519343081@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.21.1802231123500.21075@namei.org>
References: <151931642737.27713.5082532296556836948.stgit@warthog.procyon.org.uk> <29946.1519343081@warthog.procyon.org.uk>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 22 Feb 2018, David Howells wrote:

> I've posted an update that converts the min() to a min_t() and tagged it:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/tag/?h=keys-fixes-20180222-2
> 
> Do you want me to repost the patches?

Nope, I'll grab them from there.


-- 
James Morris
<jmorris@namei.org>
