Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1043372-1524676181-2-14632546218261825025
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
    1524676180; b=OvFAn+o1RrX9L/n+763ue6K03nrUEfk/0yrmVz6DtEVJL9dd73
    T64EdQn1BV4dHVr8AsbUFpNXFKuka68j9Cdj/nSBVhlfFJOzoqJGcmm7oZzISd43
    CkYqCe+rIfX1GeuVbbyM45WQTz7UGCT5/YvwVthVazhO8BAITeKIvlcU1jQAL3Tv
    d04qsjQoyXSOY9GkwLxE+Zjvzt1iZwBbdxzoQDK0Ak2ftSvVceBwX/ev5As03uZ1
    iOX8ZLuxrJQM+bjijfCKE5OpguxSD2FU6RBnzdHbo1zhiFXSjS7QXXRUExjlktGZ
    Gk2BHbFM64uuoGl7KRiv/+oUTozdqKU11KWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524676180; bh=NGy3RLmDt1HStDRWAijZa9kE7MWHQG
    VeWdjDkK2FJvc=; b=LlVHT4PaZtFhcgy1F0bsU//mnMNb6H9o+OM58AQtDQiYtn
    jxFWTPRR4PHnSgbG3WOoX/IksmtgfdomGIpRC6loULMwCyDU5lP33P2T2qopRK6J
    46fxex6r5QlmxTuHsdTSAsURYwMhb5MjC1eEMNbVnzmbP3tUSBDaxaPQ31+MPPAW
    H61veHBnevZ72Hzj7qztilJyHL2c0oHQaT4DKdboeJU9oaiqJNxOpdyEgxX7M2fC
    bOGQDTX0oC/NtGLxeWebLAKjm8e46kcij1kJiDuZRg083X0pqSGhgWpuaNLH0vkm
    V3HZqVQvSm8I/EsxLixrHiHMvf0aDYXufekSbBnA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=roeck-us.net header.i=@roeck-us.net header.b=FU9E4MXO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=roeck-us.net header.i=@roeck-us.net header.b=FU9E4MXO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN8shcwnu/4q9H0L+f7ucE29yHXK1h6dv4y06nE/slWhjN1SnmIKf7UJXdpjjKxHxdNh/Qt7hQBwnxF3cUPpz3TubYcZforDShYk6dNR9fDnhjdUqGuK
    963BuwRPt+Q3VNm1BgIrabYKn5uBAVGiaDeXtkeuG50AnZlFstaMsviptNWeeQX8mYUCn0Xrj8G3xHu7bgAZP+erOyw0RwVxDrOBGiIFucxisahUDCCUkvDZ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=kj9zAlcOel0A:10 a=viYhoEuuK30A:10 a=Kd1tUaAdevIA:10 a=B5zsdHCAaOolmQCdwgkA:9
    a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755019AbeDYRJf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 13:09:35 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:60955 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754926AbeDYRJd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 13:09:33 -0400
Date: Wed, 25 Apr 2018 10:09:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/183] 4.14.37-stable review
Message-ID: <20180425170931.GA19712@roeck-us.net>
References: <20180425103242.532713678@linuxfoundation.org>
 <20180425144110.GA12890@roeck-us.net>
 <20180425150754.GA29414@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425150754.GA29414@kroah.com>
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

On Wed, Apr 25, 2018 at 05:07:54PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 25, 2018 at 07:41:10AM -0700, Guenter Roeck wrote:
> > On Wed, Apr 25, 2018 at 12:33:40PM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.14.37 release.
> > > There are 183 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Fri Apr 27 10:32:04 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > Build results:
> > 	total: 146 pass: 145 fail: 1
> > Failed builds: 
> > 	powerpc:allmodconfig
> > Qemu test results:
> > 	total: 141 pass: 141 fail: 0
> > 
> > arch/powerpc/kernel/eeh_driver.c: In function 'eeh_report_resume':
> > arch/powerpc/kernel/eeh_driver.c:395:13: error: 'struct eeh_ops' has no member named 'notify_resume'
> 
> Thanks for the report, I've now dropped the offending patch.
> 

For v4.14.36-183-g55d212d:

Build results:
	total: 146 pass: 146 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Guenter
