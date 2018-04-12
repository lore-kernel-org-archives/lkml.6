Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-461662-1523521406-2-16497953845697438688
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523521405; b=Z1pXIgQ0kKvw/gS30tYH73nQiLQgqQ3eZ+RX+tacNoWx+OFxyK
    EnL46YL0FdqT1M4E1boXi3WQImFd386iGO8+U4S/g0pIkyQJjRdRiSWnC1AM5YpD
    538xE1eMhnIj6xrsuaLf881oFARQpA9BJEuLPuuugEuqpmdZUdiTdL2ASXNhfvaZ
    W3OiFZ4xY8w/x0UIbf+LIv33z2bscgRjCNkELJEiOP86ngbbtpUY4aP47ovjTPHf
    71kHaCMYLKaYJpv5ldx2gEuF6XnV9JLEV30J+XR0S4rRXg5G8Abp8u+IvIIW9cxh
    x/PAfMSxowzW4OXOV8w8HXPd3SwY7fFJ2i7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523521405; bh=brJr/bAvwkYf3kR7NC04f5uRp7htcS
    6CJ3yJAGrFhGI=; b=iufL0iW2WsVivUzU2kx5G9fXKtkTdpOMYhP3ZhAflwxlOw
    lYvgvev+aU32fRYIlZeXgLUQr5SvMhayVu02nSTA8vhkomepT0jrbBr4sV+qN4y+
    Bfms2fj4ekWBdmpD+qRygrOo1QGuKs5oxeKKkvUF26mvH83v9EDs/CMNj+ZL/L6z
    F1E9h8NiGpi1RaEQhym313HhTvcv0fIQJDxddYBpEELVkksxlmCjoCwDYi6MEULI
    091fKItinyWjjq+zCgEZiQuwLbuZJCogMywCdwaGOTx4Y74d0/5QoIVpdvvt1gok
    0fB2XnazLGh+ZHBkwdMRfQ7AfNzii+OZlLSP5btQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=gDN3C51l x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=gDN3C51l x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCDx7wO6K7gsRKb+NRAP9iXeiG7dBWB2RMM64jFSCbUh6pxOWBnx+/fftrm+KqF9ksQzXobZKMfCpWwVvorhF2sjQmXaLtDQgw0X7dd25LVWKE5Jr1/h
    i6A95gXkOe0F65qiGee4Qa9dnAQj7emF7Udywm+s6j/qlcEoMNymqBvt4ZzuYyC55q+PtsuulM8Fsa3EEb5nM1LhFqqzHovUBhJoyGLHH+99b+m06VIBgCwx
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=2C6YHBdLAAAA:8 a=VwQbUJbxAAAA:8 a=6M7dUV8o_Gsp-c_K26cA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=yxGMNg53M24zlVSZdvMH:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752735AbeDLIXX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 04:23:23 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37559 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750743AbeDLIXV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 04:23:21 -0400
X-ME-Sender: <xms:eBfPWkgC8rfjm8hipob-FukggPXuiOqrsePv5_RK7Rs9ggkJUhckjQ>
Date: Thu, 12 Apr 2018 10:23:13 +0200
From: Greg KH <greg@kroah.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 24/24] debugfs: Restrict debugfs when the kernel is
 locked down
Message-ID: <20180412082313.GA6054@kroah.com>
References: <20180411195436.GA7126@kroah.com>
 <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346403637.4030.15247096217928429102.stgit@warthog.procyon.org.uk>
 <12769.1523477356@warthog.procyon.org.uk>
 <20180411203308.GA10167@kroah.com>
 <CALCETrWynogzZcaKMLWKce1rMvAC_sViReBDyiEWL-rm21HvAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWynogzZcaKMLWKce1rMvAC_sViReBDyiEWL-rm21HvAg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 07:54:12PM -0700, Andy Lutomirski wrote:
> On Wed, Apr 11, 2018 at 1:33 PM, Greg KH <greg@kroah.com> wrote:
> > On Wed, Apr 11, 2018 at 09:09:16PM +0100, David Howells wrote:
> >> Greg KH <greg@kroah.com> wrote:
> >>
> >> > Why not just disable debugfs entirely?  This half-hearted way to sorta
> >> > lock it down is odd, it is meant to not be there at all, nothing in your
> >> > normal system should ever depend on it.
> >> >
> >> > So again just don't allow it to be mounted at all, much simpler and more
> >> > obvious as to what is going on.
> >>
> >> Yeah, I agree - and then I got complaints because it seems that it's been
> >> abused to allow drivers and userspace components to communicate.
> >
> > With in-kernel code?  Please let me know and I'll go fix it up to not
> > allow that, as that is not ok.
> >
> > I do know of some bad examples of out-of-tree code abusing debugfs to do
> > crazy things (battery level monitoring?), but that's their own fault...
> >
> > debugfs is for DEBUGGING!  For anything you all feel should be "secure",
> > then just disable it entirely.
> >
> 
> Debugfs is very, very useful for, ahem, debugging.  I really think
> this is an example of why we should split lockdown into the read and
> write varieties and allow mounting and reading debugfs when only write
> is locked down.

Ok, but be sure that there are no "secrets" in those debugging files if
you really buy into the whole "lock down" mess...

Really, it's easier to just disable the whole thing.

greg k-h
