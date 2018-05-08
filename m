Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3049930-1525796544-2-9534729088197830403
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
    1525796544; b=CLscYc32zpS4QO3KmEUE/e7snkAkHcFunqHwvIXAl6OpkkVSkC
    JVfPLtS0NV6C4Yh6Nb9Nqz61eH5j6Ndcmttc5jS1FiMKVH0d6NyQJIlTEOQHb4mD
    ezakIkpjapxV1BzYUfhfp8lQCMDqX6Zr7BL9w3THpuYUtUixE2tdOKmPvGtbtJuI
    PnG8NNwPkXU7smRwkcW9eT7LLrdrSvlDJsYrl2eDovaesq/dFghjDgmpXbUPQsIF
    6stDdLAv8IXF/znD4PZ7iUDU1hjZDiL/o+KiNF32mRxUsGgdTqPPmYe5wjUPos8r
    s/ywbTYdiwbeG3a40Ru8zgz3ni8nItgtArmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525796544; bh=fxvFQLt5JW2RnvYtqfuVu+qfc9Smu7
    th7ARJo+clehU=; b=RQPvI1PmZIsf4a5Xh+jctGOQ+ZdNT30rdXBuZE6Nc5ffub
    5k+KUD4jDHh7Rpk7pbbAK9C9yrIq961N9kBTqGp56o2J39PvWL8TfVTyLQXjPZn7
    qSXAu0DmBK+sYA4plhkq/B7wJRvUCiv3+rmyDA6qzD7GfINYMEj+bg58MoOF9LnR
    wRg0V5tlaE4ImGwuTRn5zViSQa6eeusq3UCjWN55kZUlNS9xcDxZmBSrivDkSeIs
    ZorONZJSVuV9VTtV0okxJH9JJhq8GmmcCZxrlR+bs5qa68al9thDxDItthEI5oT3
    /7JqxgPI3haanTe5MN0c6V4s2oQRKOA1CU8ya9YA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=roeck-us.net header.i=@roeck-us.net header.b=IVMeCL4D
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=roeck-us.net header.i=@roeck-us.net header.b=IVMeCL4D
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
X-CM-Envelope: MS4wfCbwj3aurNt0u5KTSjOf7hfIXjR23xVF0OraGG7EiJfKaii+QyTkiQdre6/A35EmFt2LZmOGdI5VHKtIo2H35L/kKvyRVkfjadURujVsadtQRBUferjo
    KfG5z/NiuC59C+vF3m4lAQqMEGhUT7t2sIZuc9cCHlcbGtImZJ3hemdjaPAiKtnTn9fZRftydtazy1Btj35CQZdpOZQGByWcWz8LPv855oHAu62YdjYnHlil
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=kj9zAlcOel0A:10 a=0JwXymvhWcgA:10 a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8
    a=bg1jY7CJ-xIyXN2IEHkA:9 a=CjuIK1q_8ugA:10 a=eX-Bu5Fvq_kA:10
    a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932890AbeEHQWK (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 12:22:10 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:49625 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932880AbeEHQWI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 May 2018 12:22:08 -0400
Date: Tue, 8 May 2018 09:22:04 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.16 00/52] 4.16.8-stable review
Message-ID: <20180508162204.GC18520@roeck-us.net>
References: <20180508073928.058320984@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
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

On Tue, May 08, 2018 at 10:09:58AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.8 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu May 10 07:38:51 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 143 pass: 143 fail: 0
Qemu test results:
	total: 139 pass: 139 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
