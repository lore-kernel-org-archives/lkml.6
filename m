Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-881694-1518810094-2-7168755527387361459
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518810093; b=gAMG4mZNCA5ydpxJnvNbsAN9rDgSkNkXt6WG4pIu9ByW9hS
    NXH/af17ek4+kq4He9P/dYUVvX2qroyHKi6oYEKEiFum2fyvwav1qn+lNRRVfXtO
    59Ap5RI31Hv/eZq4/3nY7FSi8guMajngXqcDTQS/DYgILfJTVgTcap1ztJ4bnRU2
    HT7JU879iN3iPzgI0aJRacPEDr31oio+CdftCTKzcuwN9os8mTHfRWDle4fbuW6X
    B1gybT7EIAnVbfpF8vTx+S4vRBhKA0LAofWYJ6aqCd13LeXg7vkwrUsHYy/Yj98v
    xMYLtyrMvgJqWwZ6esQ8RxCd+JMk4m5gd6HwYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518810093; bh=eti+Arves0NO6QyGmvovcR25pf
    Od0dD2OB0xJrJYpic=; b=HOtUWZUUrS1zsZHpKGZ+WSSjCbV/fQfcTYlwXaWU1D
    jgU9hvOtsuUHdIlYdeIicR+e7mLRxt46HmtadRicUDkA26XjinQfZ1zd5pSpD0uc
    M3/kY8mrOoh+WenkjDgoEUYwPtIWVPDm0kj/NPRWN/xtylEUCM9wnqgGaiKBvdCG
    jlar8VSm7OBcPm+/r/0fUfMunW2Ys2Ck7TwclwsBuSGqUslpdxFOVW1ub0wPEJt+
    ggNawyNxQsYSUPbQGqr3EyNrSFlTbgQsU1rCO7Ike24K6pmPjlkI1Ofo05M5DTyJ
    RcNlbOgoljQdYHiDkY2mbZuvxz5e1YkfPwz9wwFi6Kvg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750970AbeBPTlR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 14:41:17 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59224 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbeBPTlQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 14:41:16 -0500
Date: Fri, 16 Feb 2018 20:08:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 000/202] 4.15.4-stable review
Message-ID: <20180216190823.GA27247@kroah.com>
References: <20180215151712.768794354@linuxfoundation.org>
 <cbc0c633-9f5a-747e-ba0d-9354352c1c77@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbc0c633-9f5a-747e-ba0d-9354352c1c77@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 06:28:23AM -0800, Guenter Roeck wrote:
> On 02/15/2018 07:15 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.4 release.
> > There are 202 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Feb 17 15:16:28 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 147 pass: 147 fail: 0
> Qemu test results:
> 	total: 126 pass: 126 fail: 0
> 
> Details are available at http://kerneltests.org/builders.

Nice, thanks for testing and letting me know.

greg k-h
