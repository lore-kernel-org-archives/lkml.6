Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3971411-1526649633-2-12220524324939151724
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526649633; b=BDz4UJu6E9CIf3GtOx1bQwvo5+DSMUzpPPktdepgd4sTv2rAWs
    eqgxToPR7CC+ajJhxNKmqU3LgEAjqSBH8c+shpfhQvwuXMGLFoMAEJo2RO6R7Xn7
    mjGkqcY8eJlm0U2+d6W0fxNLnSCJfQyBGXkbZ/CgHaC4rO/WFwbNNAAO8ChhJKsT
    2ck5JozoM33c+ie8/ryXr+4XSMVuLdTFy5mHef7jiM7sMnpYuzjxojNYk+xrffNa
    Qp1aDJ6ddR6SI6ixsu+uwLe9Ta/3rngaBT2dIcZdIbvEAb4mgL/hhzmFrymebttH
    GkUiuqTFS387RoDmGFYymmUDLMwBIwUPtEgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526649633;
    bh=8j3v1Tr7NWWQhkO0JuWXCrM9NaTz/OFAGGdr5bjxpf4=; b=Jth+IqyqxQfr
    KKdIBW5iHGnXAYVB1Xj4guWqYsB4YEH0QP2WwqxZxglLmeCtjmNfjL/V2VZTVzwi
    c72fgcJfSx+TZzzwvSuWrtTTrqu1RpRyQskNh46YBxx+dy8VBSBR86WklzFBiBiR
    ta5/M1pAdEie5waEd2ShYCUITMMZ5aa4h+8IfEO5bgIGKMurTigM27hyhBKX+nR9
    WbMZbkbKBrKIicacrjOSbEDvpCgqL/sSfqbDt06AFD3HCfTtEdjv6Ya0t50qdjMr
    HwNrCprJX2kVCRBluCHkHE/dm0KG702wWmvWQz2Y6Cye2/TuWyjOEQ7PmWk81Wtz
    7ir2h9j38A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=DQptL6L0 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=gj6gpIUj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=roeck-us.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=DQptL6L0 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=gj6gpIUj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=roeck-us.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMA4a5p+eSrUh8/1qqBGcDwg9ZrpQS49PYXa/z51K+zHUtmnXsjdN+A5xcIvLhnvsv39mtf1OrncjefngFJIr9grWz4nWA6sOy6rKKvQWY/jX6+Wz4EF
    guT1FlvtvmKkhQ8HIZQZZh4m2cUT47r9cYQ7Psyzr5t7a3CqRh2fxMTDElE9w4PoUzpqaEietPX/+odUjf+908LE5NDeHIqteJGkXLxxnG8mmdCjWiWP+8Fm
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VJxAwUlu02UA:10
    a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8 a=0-S9bWPPcnYqQOqgQa0A:9 a=QEXdDO2ut3YA:10
    a=eX-Bu5Fvq_kA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeERNU3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 09:20:29 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40389 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbeERNU2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 May 2018 09:20:28 -0400
X-Google-Smtp-Source: AB8JxZqYZK5zKB5sDUX21Rz0aZte6/uZjtO+t+9SOFokC+NZny0L3j84kwR1JqPMbJ2RxtJ86S+1xw==
Subject: Re: [PATCH 4.9 00/33] 4.9.101-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180518081535.096308218@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <fd7290bc-96de-05a8-092a-3fd2b07ac44e@roeck-us.net>
Date: Fri, 18 May 2018 06:20:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/18/2018 01:15 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.101 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun May 20 08:15:20 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.9.100-35-gb0935d4:

Build results:
	total: 146 pass: 146 fail: 0
Qemu test results:
	total: 137 pass: 137 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
