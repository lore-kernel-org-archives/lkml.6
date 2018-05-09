Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-823031-1525893718-2-16420349046712927464
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525893717; b=RimrgnYFlLu/cBEfmcZmIxleEGZiLBuDg4MOdLcY9kL+9v6P5V
    S0yL12HztELgWbnF7Io3db57lLEx3yExgIhOWCt+r+GiJM4kbemI/TT5ZYv//BQX
    bsUNflSkXmhb4zdvgD/d5/Z4gztJWEh21NxCZn7V4/6Q24VLW3ari4YDPKsoOswF
    t9/SEswZeOFZVZBoycJb0frxIrCVmoF2ouomOjsqh9QAKDLzqvr6Q4a9W6d0csD3
    m4fAE8fJpIS93nKr9Czv6YDNFK0W2Lu9qXaabLx/HdkRr0HqhfTvcfj9OgtOvW1a
    /2TT+armqQ9O/uds2/SFCx8UVDFwIFaz0RNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1525893717; bh=zN5rrNpnyU9p9H1AxN6/Zfw8AQhX/KOfzRa2M02
    HGP8=; b=NPrjxWSvrAok0WD3Np0JDDeMh9/vMzYWSHJDvcAjGHizDw45NxrjNen
    Uke5+63i4EfxwJ01GNtJc6YGS6IvY+hk4yBAoWqfTg2mqbNP1SSWGZCjcWJ+FN8w
    +XYBvfHB0wFtgCXLMg5ioQap2PQSlfoB1e7YnveTvvxvqKDqK8gDPadfQGzqIt4T
    WEDRDOxQb4nSPc6dAikyT5TfwvAM78MWolYm7bn0pL8vH/VobE6WesanL61K/mYv
    LfHMEO8qD0SMhE3co05fr5d0A9HCSGLvBq1OYcGUlpwV+cHUIv3YmWkAZrL+CnUk
    bE2C/7GfCLxkPs5K9F8aBfsq6ZKkVfQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=namei.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=namei.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=namei.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=namei.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMHUSqqEKMwHEh1QLkGZ/w9gL4ZbQw4781Rap7w1pYThE/UZhDFggUkaeHFQOLvTIHOrhgFiYDLu76ouXtB+c09hgBCIoUNPEVfaYOktZ2ZieUsuFKs2
    AduGXBl/YwiPpU7M/gakGFfm/9gxoYuA0Tj0ol3rH/rz8GkqD3uNUx9IXCyDKOXBrJQnD+ksjp7+LDIw8sSWZhakZ4ICh6G3C5VyB0tq64mKbOafwetcLzb0
    K2HcXocdRD3eSjeB+slvvw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=cm27Pg_UAAAA:8 a=K6HrmWtEAAAA:8 a=VwQbUJbxAAAA:8 a=6nUXITN49fC6jhMlmTEA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=xmb-EsYY8bH0VWELuYED:22
    a=yV38gEssg_2GhkhKF82i:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965168AbeEITVy (ORCPT <rfc822;linux@kroah.com>);
        Wed, 9 May 2018 15:21:54 -0400
Received: from namei.org ([65.99.196.166]:59978 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965143AbeEITVy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 May 2018 15:21:54 -0400
Date: Thu, 10 May 2018 05:21:37 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Kees Cook <keescook@chromium.org>
cc: Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH v3 1/3] big key: get rid of stack array allocation
In-Reply-To: <alpine.LRH.2.21.1805100519200.12749@namei.org>
Message-ID: <alpine.LRH.2.21.1805100520100.12749@namei.org>
References: <20180424202639.19830-1-tycho@tycho.ws> <CAGXu5jLL7NeX+zUNqcYW_LDF87CPg-5Z4R5+FZ5uPDT-sTisng@mail.gmail.com> <alpine.LRH.2.21.1805100519200.12749@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 10 May 2018, James Morris wrote:

> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> > James, are these something you can take into your tree?
> 
> Sure!

Although, normally, these would likely come in to mine via David's tree.  

Please do that unless there's a special case here.


-- 
James Morris
<jmorris@namei.org>

