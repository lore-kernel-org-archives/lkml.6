Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-823031-1525893596-2-8981230001189797390
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525893596; b=bKz9dulSxKP2hkKVZqFGB8iVTPozlyJgWS5BpymRenskELuzru
    pqA1X798N3sUS9pTO9PQkXjSWKb59Oo5gNWV+v1Uum0HPOr6zGJbG0PluNMw8HJK
    ERMfG7AYQBjIvwGdEXXLUlzzEhj8rOsgTCO0NmeRpbA2vWKEZv0IgYcw4yfarMay
    sasQKRMyFB++D55TwOGLUeSqljwI6Ul11igGAJd0txUNvTH75oVktSmcoYTEE45j
    W2QEkhldQBId4sltUVVJrN3+/zHQwd3FVGPyHw0bKn/j3eequ27WATNotZIAvtlZ
    OPBIUUBeDpiNmlXqldQkMNLuizK/Ci2kaoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1525893596; bh=gywN3Lm10neVyvae6o1toP7gup0nC37KxCvtjg1
    QK2k=; b=REvqcM8Swoav7MwUDued4ex34+W/4PLWIpRPW8I2QoaeB8FMUiwmgCO
    4HzwJdv5idPHr9GeqA7lQgE2qCCx3KGoIAn7kLgKtmRdlqkXy+AhbT/hUO2DuxBk
    A0Xu6ikCOHtnMjHNBk78X1u1ct60eV++uMIRexkdlEfB+IVK19GeGN8NyRg7dn4D
    AgCGMAeau50ZZJRWY3IteAIIs8Y+tT0vOQXQEfn43o6LLoGYg0PJQrqEqZce2BME
    heJ3nq01ztClPgAeQ6X50BR2nUfyys6ysLYFPNt7JUwOdy/CL/huxo7QGah6Apbr
    NQWtOf8UZChNX5elQ0C3Mtm1/m8/RbA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfBXM5lX//cWiSp0nXYRhSLyc2pVJr+MiBb4n++OZ+AHbn+wKOHZK4pTuViNKllWV5a5NRTlHSiccuyjEdfaJL0/l0wnrXtEkmdnao6BV8m6O3p4rb63z
    MKNuQ+HR2/0qRJrd4lJQUFqYBSiWgSp+yt98OfoQwXz1lp02FIXzGLP5in7aEX4rHL8h0QIzdmQ0KdO+5SaPjRjE6d75GRnar8SbRuJZPCZLQIZziMYFyTAp
    mTdWhrjVrR1PiJxvUlq28A==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=oOTyUqYRAAAA:8 a=D19gQVrFAAAA:8 a=20KFwNOVAAAA:8 a=K6HrmWtEAAAA:8
    a=hBqU3vQJAAAA:8 a=UGG5zPGqAAAA:8 a=pGLkceISAAAA:8 a=cm27Pg_UAAAA:8
    a=VwQbUJbxAAAA:8 a=NoVLVvp6mdNuD1_LbXQA:9 a=D0PdExiY3ip0vbQm:21
    a=CmhA1kjc5XGd_jNF:21 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=gC6dlE560Mj-nRUNeoyZ:22 a=W4TVW4IDbPiebHqcZpNg:22 a=yV38gEssg_2GhkhKF82i:22
    a=WLjMIN4s_96MqnBbPenP:22 a=17ibUXfGiVyGqR_YBevW:22 a=xmb-EsYY8bH0VWELuYED:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965265AbeEITTx (ORCPT <rfc822;linux@kroah.com>);
        Wed, 9 May 2018 15:19:53 -0400
Received: from namei.org ([65.99.196.166]:59956 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965017AbeEITTw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 May 2018 15:19:52 -0400
Date: Thu, 10 May 2018 05:19:31 +1000 (AEST)
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
In-Reply-To: <CAGXu5jLL7NeX+zUNqcYW_LDF87CPg-5Z4R5+FZ5uPDT-sTisng@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1805100519200.12749@namei.org>
References: <20180424202639.19830-1-tycho@tycho.ws> <CAGXu5jLL7NeX+zUNqcYW_LDF87CPg-5Z4R5+FZ5uPDT-sTisng@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 8 May 2018, Kees Cook wrote:

> On Tue, Apr 24, 2018 at 1:26 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> > We're interested in getting rid of all of the stack allocated arrays in the
> > kernel [1]. This patch simply hardcodes the iv length to match that of the
> > hardcoded cipher.
> >
> > [1]: https://lkml.org/lkml/2018/3/7/621
> >
> > v2: hardcode the length of the nonce to be the GCM AES IV length, and do a
> >     sanity check in init(), Eric Biggers
> > v3: * remember to free big_key_aead when sanity check fails
> >     * define a constant for big key IV size so it can be changed along side
> >       the algorithm in the code
> >
> > Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> > CC: David Howells <dhowells@redhat.com>
> > CC: James Morris <jmorris@namei.org>
> > CC: "Serge E. Hallyn" <serge@hallyn.com>
> > CC: Jason A. Donenfeld <Jason@zx2c4.com>
> > CC: Eric Biggers <ebiggers3@gmail.com>
> 
> Please consider this and patches 2 and 3:
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> James, are these something you can take into your tree?

> 
> Thanks!
> 
> -Kees
> 
> > ---
> >  security/keys/big_key.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/keys/big_key.c b/security/keys/big_key.c
> > index 933623784ccd..2806e70d7f8f 100644
> > --- a/security/keys/big_key.c
> > +++ b/security/keys/big_key.c
> > @@ -22,6 +22,7 @@
> >  #include <keys/user-type.h>
> >  #include <keys/big_key-type.h>
> >  #include <crypto/aead.h>
> > +#include <crypto/gcm.h>
> >
> >  struct big_key_buf {
> >         unsigned int            nr_pages;
> > @@ -85,6 +86,7 @@ struct key_type key_type_big_key = {
Sure!

-- 
James Morris
<jmorris@namei.org>

