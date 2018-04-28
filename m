Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2002674-1524925727-2-9372480146780140587
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524925726; b=W4+6zpVfvbH0s4FBubrzYrqGozqqvUxTod/5jPOixIzlDBH9nh
    8cUind/vj0vks3xyIjHkbHog1WYf3Zmir5lud2/7Z2pJyK5x2m3wYAC9BFd4ScJm
    lGqBoteB/by52ko2D7GiYc4r2DNUhuuORSJKIn/FJfyvqDlydsZEvozHgoLN1dal
    D9nS4+4fZQvIUrDaE59EoODjppn4sIckjLxYaBmxXv2MV7ZUw37fF6Os4rLuVMGi
    dV/BZ+RCsZaT7AnGsROswBYP9wk7Ck+5xpxyoJJ9t23uM6d0FmS4J0gAJ8dBPZqk
    pYlzDO9O8xnu1IysCTjobQ2uuVZcH6ShXcQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524925726;
    bh=E/hNXjiwVF4Q0klYb3JNIhjsVzWVdaU3Bu9y+reYZqY=; b=QSEcL6HYMDxX
    KGeG1GhnUhjeOomaFUnsMnp5MnD4Na/w19VlVLMCUnSvf/qcoV+9XY3ZkvIds/is
    vlxNdXUt+VnoWuzfrgKiKAGw6BwjksXuf+M+6WeCVS2Xnd7nQ8RsCNfb1diqvCN6
    xg3Z0NQX/BmOaCJ81RlCBxXwmS02e1AxlV9jE7X9VJO91KxzEBfNjMy2zbkFUmVX
    uOUfyUkqDF+DFu56nqxmtrMDjJcsvtWpnw+GEhQD3xr5MIxuwmUZ+ViL8nAceu85
    X5m/u/EtSk1Ci8Fj4s5rOUhSr8f8WCsjHQBLxzoua1mix9b0LnAOx2jByuz+QH/6
    /x5jceWEUQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=R/06cdu6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JF3agQzu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=R/06cdu6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JF3agQzu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJT0gfW8ySpVvNk1+7u7TUMlstKpOimp+9FxNGdCXJOqoxsvCVqQg7odQ5UOGFmUb4fbytI7LwIG91OuqpPzo7aO92bHH3WDii5JzwHjShF8zDu/A8Da
    0CSUEjAVmyDQEllsxj92ZVoxn8TACskxzC8HXjeZu6YZwIAJ/8QBnsPybx61wix0cI+XlvhYYdorc3rXKe7MxtOgiPuKaUftfkjHkhJjiy5uZEqSIJAPp3pH
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=D2BsPUkyXeIA:10
    a=Kd1tUaAdevIA:10 a=YWtRXzOXAAAA:8 a=hy4FxF3ftOay81QUPLoA:9 a=QEXdDO2ut3YA:10
    a=eX-Bu5Fvq_kA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbeD1O2p (ORCPT <rfc822;greg@kroah.com>);
        Sat, 28 Apr 2018 10:28:45 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:46313 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeD1O2o (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 28 Apr 2018 10:28:44 -0400
X-Google-Smtp-Source: AB8JxZqEh8TWZPfkv/0zwVxRhUbDa2ZfrOx78AF5UBPweGmvSXZKcYtG7VILGAaUeJtY/AM6o9WKfw==
Subject: Re: [PATCH 4.14 00/80] 4.14.38-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180427135732.928644313@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <9c08bf57-c44a-30c3-b537-33a080e56f16@roeck-us.net>
Date: Sat, 28 Apr 2018 07:28:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/27/2018 06:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.38 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Apr 29 13:57:13 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.14.37-80-g73477f7:

Build results:
	total: 146 pass: 146 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
