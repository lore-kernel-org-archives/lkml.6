Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-91218-1518277681-2-10463232720637046974
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518277681; b=ONcnXKZ8d4XgtxLVJqsTmXevb/QGJT/gl/YZsD352fl+GZV
    x7flWP/hffiy4jVYJxqHGI2JIqJS/XXZcgUtwXLwy6d6xYapT3APdyceRDqm67G2
    gwIYPrZ4LUynbYdLvPBLHO2TAxxPnIPzgJhipHKPZOYWFJSvkuyH/AzDnhDSJXZg
    tcwam0b1JQX2ERxLhF4+/DKc4+EInXR5OEzCGm8ljavkwSRiyIsu0520C7g+8MFx
    bksGTnVfq+e5D76aLY/kqQXGwXkLxJaMGZYeRVckJvIJW9FsOGors5fk/yVF1CcJ
    M9i7z6WSKtqnQhv8eb0uJoV3DOYpdWLSZU3uyCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518277681; bh=8c5KQg50FM2mKxXbq683jUdQDDvpBi88iUE0RPf85EM=; b=w
    dh1hqduPmwE2QVIDkM6lgvlZa9Fz2KTLHrPVBrE7wNEc8s7eP+V02I7uXfd4a/OL
    gtB8DSnOW4MzkiIjtOwJlXCGvrr/mR/1nQXrP6xKbXr9VoAgkKwhAIl5EKmCVmVE
    7MAfI7piRSv/tf+IACqA3fni5mh/AJnLuYl4Y0O4aj6kwRJWx/k1N4gaK3SQYiiS
    kZ01nubFSc2spQOHGWFxYe0sh1jV4FayDqacpSlfe26jRTT5CVVE2PHW2ptHYx+6
    o0e6KXaeyEImoAvSkXeGIgeJATU2F0pxjF+lxMFcuUB/wQUn87i852vY1nxQsZG3
    iIu3DwGlk8zkhX5sufnaA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lb02uBlW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HbezJoJ6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lb02uBlW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HbezJoJ6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751040AbeBJPr6 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 10:47:58 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38272 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeBJPr5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 10:47:57 -0500
X-Google-Smtp-Source: AH8x224fPPq2PWN9+GCZwPCj97TVszhP75YYdYL1v9FaiqUUULtxyztWY8y47INyuKYxycSzHhNrbQ==
Subject: Re: [PATCH 4.14 00/22] 4.14.19-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180209133934.024795822@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <21cefb90-d53e-0a8e-895c-adc42ef9a2ee@roeck-us.net>
Date: Sat, 10 Feb 2018 07:47:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180209133934.024795822@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/09/2018 05:39 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.19 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb 11 13:39:12 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 126 pass: 126 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
