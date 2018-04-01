Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3648885-1522569955-2-928872815967038407
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522569955; b=gMeM4XQFjtxgiwCQAUKlDzCbSmmQDZswOOsu3hEpIJVULBpzFf
    4X76I4wMxWohWTl05dwDRaEtOLJ7BaLYY610lP5gYLc8+hRphJ2Z2EiLWrodiEX3
    8zyzRHbomltMOYQ0ITxxClhWkU+f5xWbjbQZYzNE33h5NznytY2tTf5efw4UEKep
    HCsC4PiOCtu3z/haUKTpGgluHfk9Ya8Oy7tU1ef1Omp6gCMwhJXpXOGQ+VbZF946
    tZdh2JIUukjPbCirS+ZeKiQ0Q//3gi0+PivsrO5bXTYDkxSGDt9dt4PkbOwPSHTU
    l1QLyMViWAlKCVhdQRHRIXnFfpVmrFHX7/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522569955; bh=Jd43sewebDaTfzSRS/tnedwiXwBOSt
    nOoAPlZHoOOWY=; b=Z2w1uc7JB93ycPneqBruRYMSNNH5HwrvJvVAATDgM+9kgX
    ozTjZM5kFzE+38IuULPblLxoszpD7agTxU6kZcIPT4N1nfwPIcQA2eXdCmto+WyZ
    qyC4TdsY4K5/G8OdcWHSU1oUU7yfdrBv4p4RdrccEokQkUKT+fNGcd+8xKX6fxqI
    YcLsM2SvPq6jnCYwaLBstpCz/zWbBW2jXryp482nB4+AgZ+xKkJHHy6nsiE7lGNn
    lALBqvw3LHWwUfCb8+Z7TL96sDtKA+VLbW5ugSJDEc+DteN9rmqAsCg80A16RPS4
    4hMq5IplCbmVcAF/uSBHeiNp8nPaA8zQsvpU+bBQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG5NJoApsPsU8Wx07phiZHzAiYR9JRsoc+cWOXNuRzxT78CV1gpFHeqfGYo7JUIFPw9wNECi8spjrRQOOpDLJamrui4n6GWc27J0i2W+7tCISDZYWGyi
    b+BSwgdG1zQibUDoSOanD7EGzmaK7IXi3szWCB5DS4kwGazncZYddpghBcEJXkGDQAeZPt0SMTR6SY65JW4wTOdFV7t/f/tHykGY6ispjkRpUwEMBpBnXZ6d
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=J3XSWAmw1PxaEGvPMoQA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751386AbeDAIFw (ORCPT <rfc822;greg@kroah.com>);
        Sun, 1 Apr 2018 04:05:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51986 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbeDAIFv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 1 Apr 2018 04:05:51 -0400
Date: Sun, 1 Apr 2018 10:05:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paul Menzel <pmenzel+linux-serial@molgen.mpg.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: How to move serial8250_init out of the critical path to decrease
 boot time?
Message-ID: <20180401080546.GA31356@kroah.com>
References: <e086c888-df77-1fde-e3b8-9246c9ab3377@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e086c888-df77-1fde-e3b8-9246c9ab3377@molgen.mpg.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 01, 2018 at 09:11:15AM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> The goal is to boot a *distribution* Linux kernel as fast as possible. (The
> goal is currently 500 ms.)

What distro?

> With Linux 4.16-rc7, `serial8250_init()` takes almost 34 ms according to
> `initcall_debug` on the laptop TUXEDO Book BU1406 with an Intel Kaby Lake
> processor.
> 
> ```
> [    2.657950] calling  serial8250_init+0x0/0x168 @ 1
> [    2.657963] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [    2.692598] initcall serial8250_init+0x0/0x168 returned 0 after 33820
> usecs
> ```
> 
> One problem is, that the distributions do not build this as a module,
> despite more and more devices do not actually have serial connectors, but
> the chipset still exposes them.

Then fix that in the distro kernel build.

> What options are there?

File a bug with the distro.

> 1.  Try to probe it asynchronously as in the attached patch, which is not
> tested yet.

Please test it and watch to see what breaks :)

good luck!

greg k-h
