Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2289356-1527183062-2-10407634159724614995
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527183061; b=CW2H3Is6/uo7jygVRofJp+/B90iuZzqiD8sVlN76uogUryHn96
    prWQVOkq45lUEzkOJJkterXvjHIuC2zYRojkvI+qi7I29BdbizuGrg1zqZIIRBi3
    kAJuiKS//z9+TqbQbfqOqbwDX2ukSVCfJXvWW4OD815mJXsCYY6zfgNgUevE2x7H
    bR0FJ2Z1ivJiDnS9YK4LEbh9/lds44JGOQ21gTsW1quMlX0jqNNYKRqPdTFLniyQ
    RIpaf0GKhQYZvq7DJPeXQh7DnENOAyzrqtk6J3GYAjMzMhvsWiFHvcMYEQKFNFcV
    OXrkXBjYULd40Rzi4QAsU9+elN0/rjmlTUDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527183061; bh=Yv8lXk24Bu+poKupYvvWwOhcPa80vY
    +ylUYYjmLuSzI=; b=FAlca8bHPWMMWXjs1DTL6C/PoATtf4AnWJOQa0yPH+u5D3
    vWD+0OArEyorvjeFKIsuo3R8EsotALBqHToYitQtcNvkb7/rGsBcU6paCuAYPVhl
    qsFtW7gERlXg7uYP8jyFGeDFCgBr7ibXo8BavTacSFEHgl+c6H6KT5aW60P9Ef6N
    0dMOfsb9lxt4GD9lPBtie82qTVFQ2GBx9HHWLYxhmcXdflvo504dZlRQS8thzf+Z
    BhJ0bPm9VXHmnQR/OrRFyjmTRnzqMjNIoLxRl9s/7V9JlDR/0+DSoHbuY40MeWQe
    Lsys5JlsjSkhU2Kn2hll3ioUIgprimKlqwoTCmpA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=roeck-us.net header.i=@roeck-us.net header.b=Qgj9rYWe
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
      header.d=roeck-us.net header.i=@roeck-us.net header.b=Qgj9rYWe
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
X-CM-Envelope: MS4wfF76lAgylv/w/4oQ97CMwz7jO7oNg6c9RjYvmUiOGiQahCcq8YMNRWABenu9Wzy4KRfaPjPmt/Z4xe5p24Fwr7TAUnIkB++t9AuNseZqYcMx6VdWvXde
    iib7kCfo95uWklwVsYmWWZTKJUSXYRi2ZDPhnfYoPztu326uzEm/tATOafp1Z5tMKE0TRf6sTsXTe6iSKdWNTvNZl4y2bVgi4bRyU8cZWIRQa0ZEuw+FLSEx
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=kj9zAlcOel0A:10 a=MQJW2e49u_IA:10 a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8
    a=8nm5TD73BZbFqXAjQKIA:9 a=CjuIK1q_8ugA:10 a=eX-Bu5Fvq_kA:10
    a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966637AbeEXRar (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 13:30:47 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:43812 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966512AbeEXRao (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 May 2018 13:30:44 -0400
Date: Thu, 24 May 2018 10:30:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/45] 3.18.110-stable review
Message-ID: <20180524173041.GA11172@roeck-us.net>
References: <20180524093120.599252450@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
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

On Thu, May 24, 2018 at 11:38:08AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.110 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat May 26 09:30:59 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 119 pass: 119 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
