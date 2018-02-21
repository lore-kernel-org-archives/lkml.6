Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1383150-1519212990-3-4530512078802375783
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519212989; b=Di0MlqzJ0UC+IgudgsLdMhTuBz6owQZGrk6TAKhPic410NB
    extzI4Jj6rWVBV13kb0VtuET59KZ4qIxpYuVCHpBTJKiVG8s0v9oxsnj8wNnkdJW
    n181i666pORmKAHLRSDN7u67bv1GebfjGol56xDzGdCHIwL9h60QbEyfXkljWKBI
    h0K7NkKLASi7m0+dMPLQFuhEU8fGL+92kPC7bL8oXYgN3qezRORXnqpR6P3ABDQL
    YujpUyMts/Hw+C3sXnl0wsUw5zpIcJ9m7fxFnZGcNA0Q+4O+IJ3OwOm4JeXCxCDJ
    ZNSatRvmoGD+FSQqpTM1w71Hv7adwE3KsH4NRYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519212989; bh=PXHR6i1w9bnLz9E7VJmjtCCJUo
    pbb2boxw6VK4bXjLo=; b=mCTJjtP6jRUQ8NpiYRsIvRFSyjXCkdme3KC+l1hrE2
    zDE7lJnhlh+d3rDzXDV1Ws/x8ZoATIfUcm9n79KCo3z9B7aZu7Lxo/4vETq2ccFd
    rXsHLpMrrDuWLVkEaQx1PZAItsZu788zEh/JnykO3mqC0cBsEpJzJ9UrpjYJqOEB
    iFainRO3ag7YfcE56ZOHiqex1Mx3iTmNalHCpveR/9S6BiKknbr/AkZ7uhE+0/sO
    1EK9ZzwowshCcTJxgY8nyScEygM0XAi8emBNxqYnducKeZJFqk1/cXPeecnM4FBd
    dIbIgyRaIAbcb6m3iSGQ3HkT5FWWpGnzHGb+vWbAkNQA==
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
        id S1753872AbeBULg1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 06:36:27 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36932 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753391AbeBULg0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 06:36:26 -0500
Date: Wed, 21 Feb 2018 12:36:28 +0100
From: gregkh <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: stable <stable@vger.kernel.org>, Olof Johansson <olof@lixom.net>,
        Kernel Build Reports Mailman List
        <kernel-build-reports@lists.linaro.org>,
        Olof's autobuilder <build@lixom.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: Re: stable-rc build: 3 warnings 0 failures
 (stable-rc/v4.14.20-119-g1b1ab1d)
Message-ID: <20180221113628.GC19900@kroah.com>
References: <5a8c18fe.594a620a.7443c.50c7@mx.google.com>
 <CAK8P3a3ma6aO_rBCj5e4AhUMhxRH383Ag2KzKQ9qfk2=Nkx-oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3ma6aO_rBCj5e4AhUMhxRH383Ag2KzKQ9qfk2=Nkx-oQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 04:22:04PM +0100, Arnd Bergmann wrote:
> On Tue, Feb 20, 2018 at 1:47 PM, Olof's autobuilder <build@lixom.net> wrote:
> 
> > Warnings:
> >
> >         arm64.allmodconfig:
> > drivers/media/tuners/r820t.c:1334:1: warning: the frame size of 2896 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> 
> Hi Greg,
> 
> please add
> 
> 16c3ada89cff ("media: r820t: fix r820t_write_reg for KASAN")
> 
> This is an old bug, but hasn't shown up before as the stack warning
> limit was turned off
> in allmodconfig kernels. The fix is also on the backport lists I sent
> for 4.9 and 4.4.

Now applied, thanks.

greg k-h
