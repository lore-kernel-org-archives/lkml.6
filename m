Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-701846-1527314170-2-12280751797794655177
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527314170; b=ExmHMTIw9uURqZKXevBrYfVc2vAmQ53M5pkWIZcYnejqZPKTdb
    gsK/IQLGkeJDsXU9Hh4tZkNrAEyYmCdWjubs45Y6KpMh8HKILphxh4KObKMm20dj
    BNXIAQdDpEsOszKvqfItvnp7lQT8DN9DkYixacboDxYVyCMDBnBfioFye2ElNyfL
    9od+VbKxOhiSVRwUBwH3LekhhZA8mPss6kJDH6TZMP8UvjUOsysKgnTUGz01b+Ps
    05tBUoieT6QD3w3vZm74S5Yn4/bbWHpCZumwaXT/wPVnAM5OTWe/IakvzGcX8XiP
    xGcNiA17S80NvmrfIuU1s1aA9U9mEkT3er9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527314170; bh=OHZrKgQxHL8bs53yHZzFK6N8eXkOFJ
    zGty00rExGwew=; b=e0Gw2MSGCKSY+VOiTG/6Q/iHUkK7wvHPAaZcI38qbmq0ze
    giXJ4KRrfYEY4Kz7kO89VfyVDAKsI9MS/e7Yz00mqMrL3O+2uN/1T8Dm1bpLqX09
    mM2eyUBfEWs7EarZWSVN4R6N8grdd2Q2gqzlVAA74E8Zj/1oBcq63Yuh1ac0RGZ2
    AenH/xCi2Z6In0+WUZEJJfzboOPSCVvJkACTzG2in+5498hXz7WKApbHN//HgtBc
    tbeDNctisEdtS8M1PqFnqR/GctQkx5nieR+0DRuEXbcXFwxYHxNoMUJYwzkDHW7y
    5S4xZVvUnA0mQeXXCojOBhlYD4H/qFjkbo7k9Yug==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=UUWk3QqA x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=B/SQ+o/u;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=UUWk3QqA x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=B/SQ+o/u;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNVLa0y9sUeMQf6wqpFzmeKvO00YoJPnE+bFGqpSYCwNpVR0q6DxdD43cl2gr8Hkl5pckkC/alYTDIpWUJgEKtgMPR9tGsIf8Yo88b03PGlhv6Aomsvr
    KlyT0nuJ1c+A2ZKGI2D9J6MpAtxH5W6IPFqKGjaHhzFvgEjTQjODyMwxIzuA/g3z0bvbVaFLpA6MVAC1+G3fSIYyOhCFQCLZV70Jj4SutBBtMpxvmxjHIetT
    X28FJMVi7h7SFdBJJIvGcw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=X4QjQfKnsHYA:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=ENiU0wAXagFydAwLdJcA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031051AbeEZF4G (ORCPT <rfc822;linux@kroah.com>);
        Sat, 26 May 2018 01:56:06 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34731 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932079AbeEZF4F (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 26 May 2018 01:56:05 -0400
X-Google-Smtp-Source: ADUXVKL9JD1lzQNjEdvjLzhuFA4GkFEIcOMLzbfBIjUh8Q25qciOgTd7GkmgJU3RFGwE/ru1Oq6Pjw==
Date: Sat, 26 May 2018 01:56:01 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Liu Bo <obuil.liubo@gmail.com>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, willy@infradead.org,
        gregkh@linuxfoundation.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, dev@openvswitch.org, shli@kernel.org,
        linux-raid@vger.kernel.org
Subject: Re: [PATCH 1/6] Generic radix trees
Message-ID: <20180526055601.GA26155@kmo-pixel>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
 <CANQeFDCLc56thuuGYBMdb_qvw_O=t7sLkJiP-LNYfKwgz74H_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANQeFDCLc56thuuGYBMdb_qvw_O=t7sLkJiP-LNYfKwgz74H_w@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 26, 2018 at 11:16:42AM +0800, Liu Bo wrote:
> > +/*
> > + * Returns pointer to the specified byte @offset within @radix, allocating it if
> > + * necessary - newly allocated slots are always zeroed out:
> > + */
> > +void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
> > +                          gfp_t gfp_mask)
> > +{
> > +       struct genradix_node **n;
> 
> Any reason that " struct genradix_node ** " is used here instead of "
> struct genradix_node * "?
> 
> Looks like this function only manipulates *n, am I missing something?

It stores to *n, when it has to allocate a node (including the root)
