Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3335824-1519402722-2-9871598406051991039
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
    t=1519402721; b=oJWvy4bDa9kADZEvrCIjgWaR2/2KvAyCYp2/2JJEYyCY2rN
    BHIudcKirhgpVzh3ncC9V1UApMF5XHbReRE6DSik/v76nv/m3hAd4GG7lCtg7t2I
    UV1d7em3gAgCYmnTdbnuqChw6rfR4IfTN9kuMdwiQ3ZkomNbKK3WxSDgCVP5cnaX
    ePidwyvDy65nJVMFdZH608jLh94zi4cJwVXZAWZiSfkHJJpoVKyXsYIlK9j+Ujdj
    UDbe8ah31WgSo3c2Ftak6hXTUXktTCYECAPmmDLTUTYBk5JJDvqdNPxvF9Oi0in7
    WZ7XZczEBlXA+bo3BdtchCkSolFoZ0asp2VUHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519402721; bh=c6F2k5edRJkDXghXRlsQ4uR5WO
    /559AZrdcWMs91cyQ=; b=wjkx17i9EyyD9RXD4MP+KZvqGX1R42KUfQLB9npG+e
    wDTnYEf5zN9Bzt8gqhK3TznEoIr4jwftqXErm0u1eg1Y6DkvF8o2qf5T3Bf2KDWc
    58pG6doSFmr1rHxDa9HdmbrXy0Df+D9xyvGcIBbI7ICxFKIcccMdGPQqLQRFM6lK
    aO15bvHrlwMUMtTEoxJIECvN9yaCkNq6sQVtpv6XYQPuNPU1ha9L1VvCvrtthoK/
    12vRSrbyFWVdTIMfcAyAXrOYlZctfioHI1lj2F/fciiUIlbmDamFKcsOuOXXXA3B
    Jkc6OBqKMkyYd9DAQ5CzxdQcxbYCW7ib9nctLDpgp48A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbeBWQSX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 11:18:23 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47326 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbeBWQSW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 11:18:22 -0500
Date: Fri, 23 Feb 2018 17:18:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [4.4-stable 00/22] patches for 'randconfig'
Message-ID: <20180223161822.GA13207@kroah.com>
References: <20180220115527.1806578-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220115527.1806578-1-arnd@arndb.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 12:54:47PM +0100, Arnd Bergmann wrote:
> Like the earlier series of randconfig build fixes for 4.9, this is the
> equivalent for 4.4. Again, most of it is for harmless warnings, but there
> are also fixes for excessive stack consumption that can be possibly
> dangerous, and the 'genksyms' segfault fix is now needed to build the
> backported 'retpoline' support.
> 
> Please backport these 89 commits from mainline, and apply the 22 patches
> that needed manual changes.
> 
> 4000fbea945c ("isdn: icn: remove a #warning")
> f0bb2d50dfcc ("virtio_balloon: prevent uninitialized variable use")
> b115bebc07f2 ("gpio: xgene: mark PM functions as __maybe_unused")

You duplicated this commit your list, and in the patches afterward.  I
think the same thing happened for a few others, but not a problem.  I've
applied this long list, and the individual patches as well.  Many thanks
for this, hopefully we should have cleaner builds now.

greg k-h
