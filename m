Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3854521-1520711288-2-17239124293362058344
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520711287; b=TvLezB/faUgY6dhx3CgUzlXPdSZeD02NJNws7MQLvkplQjf
    2yDHzKUS4kwVIdnz9CERQMBpxmPBM1F8BH9o+I13aZRJxAP+9IVDz+sVr2pO3aUi
    id85Fay5AoiFmWsLXl7cA3tGWpcER/I4vSnt2BcvZcyRUJJk5A8dEvZ75pg6qC7i
    zxpr6loY3utdAHKnbE9qLgtTwIsZW1XfHeEXsfoI/tZ11cFTuNA3ylU5EjkmpQOo
    EDVxQmKoU9MBzZ7keizlVCeoZqOD5Rt/bt/+5QeBv2o/6ErNmz2evxGswAaYd7hh
    kK0HOMSjYaOEKwvQXlVkpUc7eACnXH+hYeB7IPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520711287; bh=nCqRX4rQZtLoU6k7fwrLgsyGUU
    N9U3VqITwjGx9qFhU=; b=uKSn+h8+4utqkfhEm5/7yn+sE+gIFmI43ZISn73d18
    diNEqyYBk4SvWlZF4FMh7fST5WqaCnQKA4SLHSxZj9mHyRi1Op7DJ1FaXGi5EQ2u
    eEMnCmkN0xRJevsuEGScfx+t3JRprovFy1sclUPUT2eIWjqcVI7sof4Khs/2tIVq
    WIzfkmszjQUeJgxVsY4XdF6IAAKjAvQPxKDNZa4W2Sw9Xna8KGZXjmLtwr3lQR/i
    2byFo7h2kgzNcTOAOIc3/B0d+jBXnALu9HliT3pG7hs7nszrmwoYbaJc01QsM6nI
    UWB0ll22e0PO9VQkmtkbTkLxI7P/9QOmnHuhx9GWjQ/w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbeCJTsF (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Mar 2018 14:48:05 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34692 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeCJTsE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Mar 2018 14:48:04 -0500
Date: Sat, 10 Mar 2018 11:48:05 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 00/11] 4.15.9-stable review
Message-ID: <20180310194805.GB12279@kroah.com>
References: <20180310001834.560857664@linuxfoundation.org>
 <e993513b-4972-5d0f-ebef-5d6d01d47eb4@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e993513b-4972-5d0f-ebef-5d6d01d47eb4@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 07:45:57AM -0800, Guenter Roeck wrote:
> On 03/09/2018 04:19 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.9 release.
> > There are 11 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Mon Mar 12 00:18:21 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 147 pass: 147 fail: 0
> Qemu test results:
> 	total: 141 pass: 141 fail: 0
> 
> Details are available at http://kerneltests.org/builders.

Wonderful, thanks for testing all of these and letting me know.

greg k-h
