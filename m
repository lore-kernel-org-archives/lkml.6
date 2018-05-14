Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1065765-1526314793-2-6800127006554381237
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526314793; b=Ln4RXHwrUQtNTAd0lr4E8+I3XyVRP0YtN2d8jMlpZySdLmxx//
    NRPHFQ/v0OoPM5EI1u+C0aOB3CMD7j9LA35QrVjHsAl7wwh9gme/IS3BJ0c3Bgtn
    IQWGwIRfiSRfRKQmUI5/Vex5tP4KFGAFvuCf728epbyOXDeXHpKPzcxcfvACzYUW
    5TiD0vLvw4RsvMIZ3HZCp1/5OxmwLXAFkmIyGktloERjDCkxIsaLhi3DhfypVfOF
    W98vZ5N0awmseI0gvfPPt8u944XBXcB1d7S/IUvz04bUke52fh7OavYzvrQnRryL
    i/G2vOU/OxGa65wHayhn5UN1DmO7LKwTAnxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526314793; bh=ntZZMt4VtHKBWzpDj15HVzIy0zA5sH
    xmbq3GYlJWs3Y=; b=dgJyWKQ/RFjUQ8icQnGwtRj6tMlmym/SsA29wfD99TXQNA
    I78C4+UVi43CCNS7SIqlmWJFYsezXX8BSQxJYp6Aw2EeNK01NmnxRQ0g28tOnul1
    7HGnLKxxSF5tIs0sz4wkQfe1hhznri6X3Ms7TjJ/GTBhw4+HEecvyVJ6uAedXJ7a
    z3qkOMxZljMu4kGNzeNCCKfFp3CA/CkoCb5NBJbVcZHwNviB5S4ylSyw7qLwlUxB
    JFC84E94OWsEmVrAGhLkPB4tN9+9qx1m0SXqimkEwIH+ITotdBmySW/sJq3zzXl9
    2yPQ1it4sTCNgVHipFub/GxZ2biiIfN4+lvnM6VQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=roeck-us.net header.i=@roeck-us.net header.b=dwrE+7zU
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=roeck-us.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=roeck-us.net header.i=@roeck-us.net header.b=dwrE+7zU
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=roeck-us.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG6wbFNY+/tbCaqD1mqwvS3qKR7iesY8MbII8DxmsNObxa/DJB6RU3G1fq5J4uwloBpOyyXWelJliGYWebhuFy3UQy87QpdADjVtJ/ugFhbvwDI8x3Dk
    YKnkX25VQX6bzLuthRw6cyjtWMu9ReHfw5UYKnxtf+vEXNDXx7yuE/Kk/pvOxu2MjZSxM1R/QtK60g5Hyzo3w8Oe9C+WY4CU5fRyKixk7DjQtZSYoEQhnqPp
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=kj9zAlcOel0A:10 a=0U73VwB4dlIA:10 a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8
    a=c1y0jFKIhTeymvTbFEYA:9 a=CjuIK1q_8ugA:10 a=eX-Bu5Fvq_kA:10
    a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbeENQTu (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 12:19:50 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:47464 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753030AbeENQTu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 May 2018 12:19:50 -0400
Date: Mon, 14 May 2018 09:19:47 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/23] 3.18.109-stable review
Message-ID: <20180514161947.GA31622@roeck-us.net>
References: <20180514064704.046463679@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514064704.046463679@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 08:48:29AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.109 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May 16 06:46:49 UTC 2018.
> Anything received after that time might be too late.
> 
Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 119 pass: 119 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
