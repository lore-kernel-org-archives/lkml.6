Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3128394-1525180882-2-12894216838644475033
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
    1525180881; b=COQjOBYajXwY0wdi3cxawBAs3/2gSyXIFpECCp+kg27rR1UXEM
    4jg3ZcTBnFu5AB7/1BzgaR4LE4f2wcggSpqli+8/DNuyD3dUu3M2+Ly8pVDdXeH4
    I+eV23X8kjYBSOEWNZlRDXpH6Vo/rcq+LLzudmO7kCloqJNvmHxYCbz8Oi91p/EP
    PReNqK25Pzxi0zLb0+9TL2szE78nVKwnTz1CcBzKv+MfyoElLnNezqAjb8m4CYUS
    zFHCmwtb2hqu3XxxCXVYJt7Y2j9uFyY3nnrYqaKnLralHXmXeUc4TVfRPGUiePCp
    3GxhUVvsCO2ihQbXxutEoXPFlYKVEJeV5rLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525180881;
    bh=eob2k0wP20FpC1pOd1Leffk3Le9gGjJ3OPhn57CU+Rc=; b=cZE50pi9n500
    0McmOtc9uPVpEbh8zYoOxqFV7CTZ1Wsnydm/8pp8hXuJgz5wiBtHF55GHk0JnwJH
    o9GKiG7VZ76vSPSNNFXQKDCpCnBO4RsEsrV6sC+EJqPmYcXNmIjAbGRhzpbkJ49S
    LyXiaz2XszSx9yEHWOA4wIBPRMZYxIELVUUAgNoStDJGS1isBgfzJZDo305iD4w/
    5S68n3Jm4mmWbR26xYtABmlLJ3/OAkbVcpDJ5SzDTyHLRTVIiNiH15bgPmAHpdKR
    BF4Ig91c6JAnh3ak79ztYM1R98xTz6Z16Ztt6FBPZjoAm3FXWL/g3kWhwFujR6zg
    6mhV9UE58g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=kkFNMv0Y x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=V3+9FKcW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=roeck-us.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=kkFNMv0Y x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=V3+9FKcW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=roeck-us.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMwD3f6r3qyr5u1+/9Vy7NuCytdXy+M/cKfj4bcFnosFiirKSsKrWop7tm/Ra1nG+58nokEjJmXClil/8wxg9Zc+9HEGPlrmBLR1HivVVMxpIgG2e1JJ
    7K+SwxZlKNvzpsvJZeBDmXUbHEUVxRG1u4DjM0ex7W9VcTrh/HY0RPvV91oZfo5GAvmOP/qug5ZEzx+oLgmfYTHOM1I26QOII0wRD4DEYnTp6+f6JQmvJGGu
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=E1qZANYqsVcA:10
    a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8 a=78T-dbKbSw616D4CLewA:9 a=QEXdDO2ut3YA:10
    a=eX-Bu5Fvq_kA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754511AbeEANVT (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 09:21:19 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:38040 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753505AbeEANVS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 May 2018 09:21:18 -0400
X-Google-Smtp-Source: AB8JxZpHmmYU3qjctd30ePC8zv0Kx4c7tUwWazQ5gKeSDUbAtwnxR36JDkE/v4Aiy4Clxr+bzAJzcA==
Subject: Re: [PATCH 4.14 00/91] 4.14.39-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180430184004.216234025@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <510ebe73-1825-8c25-077b-0d04dec82fe9@roeck-us.net>
Date: Tue, 1 May 2018 06:21:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/30/2018 12:23 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.39 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May  2 18:39:37 UTC 2018.
> Anything received after that time might be too late.
> 
Build results:
	total: 146 pass: 146 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
