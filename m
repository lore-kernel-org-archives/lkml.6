Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3741325-1521368825-2-7319810901600481832
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
    t=1521368824; b=rqzKxcxIyH1i6xGFox3TiEfmFgbMx2JJqpxSVjahPM6o8BC
    /wFbguiimQqqUBRCzo/6s5NDZrrPiC7tkQupV0xMEZhrHakyscWsnDN4VUiUs1dC
    lxWpMFhdp5p6EttLbA49PC1OslpdlPcAyDsbExMpU+t3hoLGG5tKJaq22oKeQT3t
    CgAbHnxwfy5QNr4wGOhYTU/QpvpJDNRWzOEbHNPC9CG1dGiSfN2eZJ4rxl8Jyo3+
    EZKsd0Az4yYA8iORSAR4ZmuNudnqzJbWJjDl34EjvYWfupRI9QCkwPWVb9XRP1vO
    l3/SyIMGaqK4gSMfOwSFQNdfqMZ5vqRtzFUjDPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521368824; bh=BWqMFZRyudMn+sQtC0qa3fj7Mh
    K0YwqMyDQXA0zK6Cs=; b=vzKOOoR285/W4hnih167esgIc7Dg5brr+n6kh6LHus
    p4vQ/NKjn+jR8kb+Tt0AI56c/08vcYx7Yiyd572+d1tRUVG+xq5kdXXf/PZOlkkF
    q9FaEHqglhPT7Zqx2RskgtnXxSxoHz1kyjZa046yQWwwLtaGYUskpkZ9nvAvsiN8
    vpxUfz5z88AUArl4xezZH54ZkiF06bRvdK2vJlHK07B5qNTBXtyNgJA4iTQU46Vu
    dN0RMTkk46PrXCPCIFJ4nS5j53T+K6AtTm8BOBMAi6EJKmVCGQWHfPDj4xb1CFwE
    m9Kn1tBb5Ad4s5eb1mUaB9i94sDI6bR70jv4rSjZQdcg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
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
        id S1754092AbeCRK1D (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 06:27:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41772 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753909AbeCRK1D (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Mar 2018 06:27:03 -0400
Date: Sun, 18 Mar 2018 11:27:02 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/86] 4.9.88-stable review
Message-ID: <20180318102702.GE32470@kroah.com>
References: <20180316152317.167709497@linuxfoundation.org>
 <34857d7e-34ec-a94e-470d-4ba5a0b9534b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34857d7e-34ec-a94e-470d-4ba5a0b9534b@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 17, 2018 at 07:41:51AM -0700, Guenter Roeck wrote:
> On 03/16/2018 08:22 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.88 release.
> > There are 86 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Mar 18 15:22:47 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 145 pass: 145 fail: 0
> Qemu test results:
> 	total: 137 pass: 137 fail: 0
> 
> Details are available at http://kerneltests.org/builders.

Thanks for testing all of these and letting me know.

greg k-h
