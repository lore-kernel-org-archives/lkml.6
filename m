Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2168470-1524728099-2-6487861692473712953
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524728098; b=j66KgmVpPPVeA26v75ivUQ0AehV5XENp86N6r5rW/h4HBfPFIc
    G8VQ/wSnRUAU9Ry+oDrESs+IjKsx5f19Ml4tnqTt+y2L2eEFO3Mxhy405ueYqkLB
    9pb0XH4Sr2acZAB1rVjbKp4LUmJDekSdjZkEJ0aUnCl6KB2+xhhgmSkW9R6VN9ba
    6aJXHFu4rV8HcvLkCLVqSp4Zk9Ot24Ig9oqQ0GXAf772EEZboxNead6FHw0KfxDp
    /t0Ed70dK3Gqy2c2stGrEektn8mBmhWHekziwwcfYpemoPt55e7S3Qc99z5SVPb5
    J1Ofc92V8Hb1BrGrDIGZ8Uzle0gLN/CnR6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=fm2; t=1524728098; bh=6nPQ4rYvMJ
    VAY806FyqlTV/MsvulZZEeQh5ViMTPZnE=; b=NCndODo6BRYyK1xWWs0ZtxSFSa
    +1bNPc5dJx+8i2znE7QvN4ObufkKALKpBfBDkXcJ22lWbX6PoPhfmoKztGqlqTOS
    5OcFNg7I6v0U4OcpqetfQ0M0GbRHkMub3UvqKRHrjPIxdPc/Vo0yjFWHP+BPTXGt
    aJllRZbsBW+o+oNQo6TIzJHNj/ava4FenaBX3hgGs5Z99lvpRl1g0uwfAXFp17c0
    l9lOUwDgXCIFMEE1pYRrtEcxKjX7f7DzTBPejKYdPhuiN/UvNTnB2xhuyIYnNUAL
    EPmF+vMVSTQAQ/l+6e6APe8ejL1vSNJMasgsXpC2IekfCQvImUcAvKoGRQbA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rjwysocki.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rjwysocki.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rjwysocki.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rjwysocki.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPboc2QKwtfb6899NBfdN25x17kbXelhtjimpUb2pm3s/53azupmGLq18HuPEAizgDDFjrku1EmWwVCFIQQGom5wBm0WSSYiAZVoEGrnq08/ZhlwOObd
    x39C+n+1d0BFNWGfzYi1IDWKD0QTL64kMkL+7dzs+GaAl7lalTgGZXrjr6aVmhP/bx5yUN2lF8CnO6J1YgdPr5NNOugDk+fSVVfaHDUFZlVhuwi7Cjw1wcKm
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=SBIdoGQ9po5M4T0XLfwA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754246AbeDZHel (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 03:34:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60301 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754239AbeDZHek (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 26 Apr 2018 03:34:40 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: David Howells <dhowells@redhat.com>, jikos@suse.cz,
        torvalds@linux-foundation.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 07/24] hibernate: Disable when the kernel is locked down
Date: Thu, 26 Apr 2018 09:34:28 +0200
Message-ID: <4403604.jesDZjvsch@aspire.rjw.lan>
In-Reply-To: <20180426072646.GA31822@amd>
References: <20180413202234.GA4484@amd> <27926.1524148733@warthog.procyon.org.uk> <20180426072646.GA31822@amd>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thursday, April 26, 2018 9:26:46 AM CEST Pavel Machek wrote:
> On Thu 2018-04-19 15:38:53, David Howells wrote:
> > Pavel Machek <pavel@ucw.cz> wrote:
> > 
> > > > There is currently no way to verify the resume image when returning
> > > > from hibernate.  This might compromise the signed modules trust model,
> > > > so until we can work with signed hibernate images we disable it when the
> > > > kernel is locked down.
> > > 
> > > I'd rather see hibernation fixed than disabled like this.
> > 
> > The problem is that you have to store the hibernated kernel image encrypted,
> > but you can't store the decryption key on disk unencrypted or you've just
> > wasted the effort.
> 
> That's not how the crypto needs to work. Talk to Jiri Kosina, ok?
> 
> Firmware gives you a key, you keep it secret, use it to sign the
> hibernation image on suspend, and verify the signature on resume. Or
> something like that.

A simplified approach might be to encrypt the image during hibernation
using a user-provided passphrase and then ask for that passphrase during
resume to decrypt the image.

The attacker would then need to know the passphrase to substitute their
own image for the original one successfully.

