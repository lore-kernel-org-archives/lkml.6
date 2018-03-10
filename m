Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3894084-1520711266-2-14409446400986982470
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520711266; b=HDUjr64TFNpB3XjZPeOH3ZoWaJlSV0dQf9FGUyH/GOqNDFO
    +RjQqnD6NFRTHZw7lkKUSbjbKWZ3l2DBrveZLYWHZ7E0cwrJX1XkESdGtkCkde6a
    JuN5BhKO/vzNgPr4W2MQdH0B15K6ICi8X6MnaIEfWPEMNWAZrUIyxTIu4Cj1++bt
    5U5GtzirTfMrfCHZ4YDd32N7K8bFzrA3/rNZ5685QTfac5ljxUVexRbEUvbOWbvP
    ATH14oL2gYP09hAebujyczxdSSQ+fX4fqvXuTI8EVH8JWPLtuPLvKZlWVZSzstny
    QgXERZ3+ydtX24IyLxk2VLTvDL4lzA285GfzjMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1520711266; bh=NX+u+9u
    OdyzRDRDIq0OLZafllJCjbNs62K3RK5u6ldc=; b=LRCMimukcoWv6bzNnZ0oGIw
    Fybz47k19/LduJDvO23kjn7lSXoGAlDiu5EAMeo28lTBvogzfhgB/b2JPuFZh8/i
    Mx9iBVELLK2XCvqJvTJCtblsSWACJBD+0cFauraRXfoICH712pkJw8Lz4J59RDyj
    cpNpdzQPuGOpLrWa6bukMapjr7VNs2WSxgYdVlKPJorbeztYxn0vgsIGqKNU+PU8
    gwlHZZoG86t9GKeRNnGKTusy15t5BsESDI5HJcPWkU2L/FtWrXTDCR2H//UWVPtd
    ge+EVMPmW+Cs236x/lHZu8ET8PYsXFIQOCxiMh04t2xEwB0TahCK8U/vMf7vzwQ=
    =
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751113AbeCJTrm (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Mar 2018 14:47:42 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34632 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeCJTrl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Mar 2018 14:47:41 -0500
Date: Sat, 10 Mar 2018 11:47:42 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4.14 1/4] powerpc/mm/slice: Remove intermediate bitmap
 copy
Message-ID: <20180310194742.GA12279@kroah.com>
References: <69684e92a32d00c491540e8adfa34fcb50c36244.1520468013.git.christophe.leroy@c-s.fr>
 <20180310001043.GD13963@kroah.com>
 <39af0017-6a9c-a032-8167-40b5f30840f8@c-s.fr>
 <20180310145258.GA6874@kroah.com>
 <84cf5fef-a940-cb2a-431e-5a550f725c4f@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84cf5fef-a940-cb2a-431e-5a550f725c4f@c-s.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 05:14:22PM +0100, christophe leroy wrote:
> 
> 
> Le 10/03/2018 à 15:52, Greg Kroah-Hartman a écrit :
> > On Sat, Mar 10, 2018 at 08:27:54AM +0100, christophe leroy wrote:
> > > 
> > > 
> > > Le 10/03/2018 à 01:10, Greg Kroah-Hartman a écrit :
> > > > On Fri, Mar 09, 2018 at 04:48:59PM +0100, Christophe Leroy wrote:
> > > > > Upstream 326691ad4f179e6edc7eb1271e618dd673e4736d
> > > > 
> > > > There is no such git commit id in Linus's tree :(
> > > > 
> > > > Please fix up and resend the series.
> > > 
> > > I checked again, it is there
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/powerpc/mm/slice.c?h=next-20180309&id=326691ad4f179e6edc7eb1271e618dd673e4736d
> > 
> > That is linux-next, which has everything and the kitchen sink.  It is
> > not Linus's tree.  Please wait for these things to be merged into
> > Linus's tree before asking for the to be merged into the stable tree.
> > That's a requirement.
> > 
> 
> Oops, sorry, I thought everything on kernel.org was official.

That would be a whole lot of "official" :)

Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for what the rules are here, if you haven't already.

> Once it is in, do I resend the patches or do I just ping you ?

You would need to resend the patches (if they need backporting
manually), or just send a list of the git commit ids that are needed to
be applied (usually easier.)

Also, why were these patches not tagged with the stable tag to start
with?  That way they would be automatically included in the stable tree
when they hit Linus's tree.

thanks,

greg k-h
