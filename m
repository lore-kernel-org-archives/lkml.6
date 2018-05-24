Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2289356-1527183133-2-3543813702973034214
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
    1527183133; b=VuaN5ZCqy46nQ/L3V2xSjaTp4u4N93GVlIXTQCCE3EhsKgIyqr
    cMvpkhl7rjNacRu5XlxDFtLCbUw2ow7zHUc6VsDW3lkNhGEiU5oKdTKypncFwqvh
    nzf3wBthkh6OIr7U5M3cWkEdHIT96h2a6VijIEVzdKwwPB9hZPuhNED6A2H4dHMf
    9PF0qkNVNZNs2EzRRLW/UNMytTCtipthYC6teZvKO2DZmYDgi3KdCZXjRX+s7NlE
    dOtrHdsvJhqZmjHRXblIYgXLz3+OuPUWt7W/xn02qLQF/qIiv/zdjs1F3ksaLgMA
    3BS/ZsovlMe9iy6I4syibYq/1oJT7+LycldQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527183133; bh=QvksC/OUbRgBFYrfunBgBei9izMuqe
    aPkNfSI2wGy78=; b=Ypi9HdH3pDaXR2MsH6eKqq2ieh04JX0KU202RpX4fvClEk
    qDfp6upUAsIvOiwvNyes/OhfxnKrwWWz5pp0bvthIoZ/w70D/ctlyz1f9xxNeMVX
    eaaKl/rMOZKrYiyVmetHqn/LCqYvkvn5yYy4F4VsoLFz+nQN7gU7DakPrYBtVWAB
    PaBpZpqCwS9rv4oYlBMnq7TNos0VGGAcUUPuS3PKNlOc1jmel5P3Wev8/FfoHj+Z
    lU9E9RjmLRMWJZWQzldlISk8ycjZjc++VM62LHDNIdKWKo2JvSWljUOJqocxQdmy
    zQqFfRdLCrmsoplJimoQ58cu0764jFFcd+L/vYFQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=roeck-us.net header.i=@roeck-us.net header.b=NT0cm/xc
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=roeck-us.net header.i=@roeck-us.net header.b=NT0cm/xc
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
X-CM-Envelope: MS4wfHgJsJ30IHN6fOm8O/2FVuecqpYlP+96y92ro3XkK2ly3ZuX0D6OwuyuvICtCOnqMFCbrOYZp4q4pczzvv/llqwyIXpZPSEEh23eFg37ylDu/74WuySi
    66SNb+fXBAQahWQeAz6NhWabCk5U7vbh/B8QaQ28lpWr4Fn1Qjn0u/bpfjSWR5Z8Ci41uGSL3RcXwgmgmlbehAhlM0ceC37+hnAlQ3OleKeD4viYr+WbIHXw
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=kj9zAlcOel0A:10 a=zhKW8NK6TxkA:10 a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8
    a=HrGe4c0wytnI9zpsiJsA:9 a=CjuIK1q_8ugA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966366AbeEXRcK (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 13:32:10 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:33558 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966288AbeEXRcK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 May 2018 13:32:10 -0400
Date: Thu, 24 May 2018 10:32:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/92] 4.4.133-stable review
Message-ID: <20180524173208.GB11172@roeck-us.net>
References: <20180524093159.286472249@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
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

On Thu, May 24, 2018 at 11:37:37AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.133 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat May 26 09:31:28 UTC 2018.
> Anything received after that time might be too late.
> 
Build results:
	total: 146 pass: 145 fail: 1
Failed builds: 
	s390:allmodconfig 
Qemu test results:
	total: 127 pass: 127 fail: 0

Build error (s390:allmodconfig):

arch/s390/built-in.o: In function `__s390x_indirect_jump_r1use_r1':
(.text.__s390x_indirect_jump_r1use_r1[__s390x_indirect_jump_r1use_r1]+0x2):
			undefined reference to `_LC_BR_R1'

Details are available at http://kerneltests.org/builders/.

Guenter
