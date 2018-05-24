Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2285987-1527183285-2-3337588751039137656
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
    1527183284; b=lL2VgafZCcKhi+LbkADU+RtocofOu2WkfAOS1DJNixHlXQFiGo
    VMavsDQ+AhJnO3BCNgNB5pEAOovnjgtSinO6EmN0y7ORq0hjTDGj8yyYBJONXGhc
    JwvX/yOTpXIhFlFlBjCD66x5SeQ3ksWEwdpdt0bwTlX8aE+8aV9plniOjNSibdXF
    LipQx6hjjQfEaKYHdtvZPP2zHFRNVIJ5QZ0q6NklivKYpOcrN5ZylA7WV1Mi9SAN
    jl9CIxakzY7k/PzU0bsAHMToTHhGZ5NWj446kFaosiwQ6tsO3zDuarlNw+lphoc3
    ehkfIfgJ09zgUN3aHQS1vVOupT9/AhCz9xxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527183284; bh=D3etE+Agc1CqDkOL23arOgRg0Q9UQe
    f8/vuOfWC1LZw=; b=CSVqp2G53J5nPQgA8+pwTB9fgzHftLnrHc2Q/qUWPceF2y
    otWebZwVsq1XF2uS/vgt0ZQmuQqyWEMIaytKJJhQ5ScCRqmA4TiZXRnoz5FqRwyN
    eimqJF1S6u1ZkpoLTuLFboQvuYhE0FcvQsrB8oWMqsn1z6e5CR2PGlDYXcZuo739
    yK/hAFZrPh9A4MZd18FS57mD+ePQi9wqRUjWMdeOzihl5/ygVcEfwRBDtC6ETP3g
    gcCznYiFAj3VHXI5adJf87K3WU+f58eyyyFDGvuh7BCJqbdhjVR6pEVEz7v//dyp
    LVyJ9iJc/P55YONBHp0M6jzzv2BjXxBXol5FG/9w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=roeck-us.net header.i=@roeck-us.net header.b=drfhx1f5
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=roeck-us.net header.i=@roeck-us.net header.b=drfhx1f5
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
X-CM-Envelope: MS4wfBXJnvoS64qhefCSvViOLNx6if02Rq4AuYHDaNXK9TjLwRdQYwv63dRRL/hzr8aQJmViOIoeGKovgFBbpZ3cot+pOUc5iy55925qhMLIeyAkOs8q2rcU
    DKdj2PRmoXi6a/lBf4fFTo9f+gsZxsu/ft8LtvJKShGaVT1fFu3bK8zkFQpOBIebgLpjMFB7MmGqbABTvFF8315A7YJDxvD2EdPesFtr4kur6Kz53+mPWPsC
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=kj9zAlcOel0A:10 a=KzI24OduxaQA:10 a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8
    a=bg1jY7CJ-xIyXN2IEHkA:9 a=CjuIK1q_8ugA:10 a=eX-Bu5Fvq_kA:10
    a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967329AbeEXRen (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 13:34:43 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:53888 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966288AbeEXRem (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 May 2018 13:34:42 -0400
Date: Thu, 24 May 2018 10:34:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.16 000/161] 4.16.12-stable review
Message-ID: <20180524173441.GE11172@roeck-us.net>
References: <20180524093018.331893860@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
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

On Thu, May 24, 2018 at 11:37:05AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.12 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat May 26 09:29:22 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 143 pass: 143 fail: 0
Qemu test results:
	total: 139 pass: 139 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
