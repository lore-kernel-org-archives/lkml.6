Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3181716-1525801962-2-7327501389001614085
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525801962; b=SPg8BgzjC3oKkXwbjnGYwtco3I5cNeN4wj7Ow3wymapqwUigOm
    nXxgVsvWzpc7NrO6F6eNCfVQVE3ALSPtzpbPQEsfA1onW3mSdFHwFDcpi90aroaK
    JUGyIxnXSB2rk/lsAZwVfg6Y0TJQkU0t8QXVULGPK55wcLK3KnwDi4clpwuAZyV7
    KHjFk09iJ6+jzc7981jeBDMACQ1yOiG32tmuofmYKAxgWvDcFB7i/vKpb2n20859
    LcrgMBJ9rHJ/y0Wd/UOcM+X4Q1pjkXlMHe8+w7G0mNAquwTCEKO0PTXGXowFbviU
    LcPJhJJLUPWv8JdkUmrg1S6l7ZLYXJpQFWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525801962; bh=5xS9aNykvlna8iJfyc6lYiYSFvXrjI
    4VWmSdaxI/opQ=; b=lTfKG54FaA5PVNOyIFjQz2nbGTGPH6sm3ZrxpONxliHL1G
    gu3XFchlJebduE2gEjeoaekFFNpu3FgCyrUmerIVxq6EqoPbzvHoph92AmWTp+uC
    oTfxVGTRDicrejFLz0t8xWU+tYvhpq8RZ83sIIFdIwn4gkkd+jYG1JBHOnKG4L2l
    m4U8JxuhPbL0BODPrFLL8MxlvnZ48+/JGefFyMN9+1Rn64PJq20luzjEFEvPO6YT
    uEYziuWxdFbpfYLMJVY1qHtXT5UT9xMFsg8NcxHCVh5UTXMNRdV4bRP2g79GspMb
    iqAoNSMIx9WzUsoyiBcto7YrRKWI9GX67Z5z0IUw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=EAvppQjW x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=EAvppQjW x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJC3hdjKjvkHF0ikegF0Lk4qXglfedyqN6iqks4KqCYk3ba3DlsOx+CH7OiuXA1oPf1qC1kvtEIivYVN7vtRJEBVjmLzfORogpgatI4LTqJrccwliJuR
    L4D0qCgqEKoG4lcK0mH2L7KbCYdnh0z8SOYMWGNp9aMWd52vMHTf9m0qt0K/OgQ1v0j581DpUeiPw6oB4uWXTT+TGziy6Hf/J+OOMesPE2uBLschhUZsxO95
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=0JwXymvhWcgA:10
    a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8 a=bg4_TUw-WZSBqNGtAAMA:9 a=CjuIK1q_8ugA:10
    a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753062AbeEHRwj (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 13:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751806AbeEHRwi (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 8 May 2018 13:52:38 -0400
Date: Tue, 8 May 2018 19:52:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.16 00/52] 4.16.8-stable review
Message-ID: <20180508175223.GA2408@kroah.com>
References: <20180508073928.058320984@linuxfoundation.org>
 <20180508162204.GC18520@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508162204.GC18520@roeck-us.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 09:22:04AM -0700, Guenter Roeck wrote:
> On Tue, May 08, 2018 at 10:09:58AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.16.8 release.
> > There are 52 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu May 10 07:38:51 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 143 pass: 143 fail: 0
> Qemu test results:
> 	total: 139 pass: 139 fail: 0
> 
> Details are available at http://kerneltests.org/builders/.

Ah, it's nice that everything is all working better now.  Thanks for
testing all of these and letting me know.

greg k-h
