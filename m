Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2406842-1522244293-2-11277552432797708854
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522244292; b=ABBhaYJJgCUaSvaDjjAeP5PtQiFISt9oOWiehH2rKkoNGFk
    Xob++vCn53HwSYwWpBEx8bZ2Gv8HHCMXdRHW6c+k/n4UhCbWlUy7eJT8uo/9POX6
    4g1vJUhiGYplfUWA/JLIU5FZ5Jt3fiHr4K8v5t7k36r9mHtAcilMiF9iqyHUl/JZ
    aEzIp8PSNqbIbYNzkef5fx1iKklFY/TGC6Lrc+C5HMSvmtJOldiH8LrdZg7n0yTi
    SvbrTVQzynwJxIabKJulNnOuYqqxBtItEQQ+BjVllMzVYhsY7prdufsPjaxsq6lJ
    mKvN2312wlbp5mbYVHBaxLmy3pkGBi9Dwm03XUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522244292; bh=38Ctq9JYuJU7dKwRivh9/lZIppVm4YyhspWUiTVbFWg=; b=V
    s40sk0B70eAVDMyD+A+W0nkQMnyCI+kdjOKmI190qSuYz1g4FJix+0S/cKtXltfN
    VcLGnIPOa/Nt+oBJvSEzZ1eD5OEyVUQQSKqxMYByrucz853V6OePz27MV30KXe/G
    Pwmu5e9SlzvWLSlBcvLyIgb5xzmC/9+3vajxdqykc3Iv7lIJHKuqBNUTJ6FFsqb3
    cnvfNa9nHd9byeyaOpS3eHHgKz4XIYqYTVRTibxg47tM1J/aiMCptIYJZSMj2DXS
    7I4t1SdTHQ8RVEGpi1a4vueUzjVpbnqzYaUA++eiILKUoYls3NtJLq8w1iIEslq7
    yBPWMUSdstvP2eoLH30CQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=P+7fiFON x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nF4NWRc1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=P+7fiFON x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nF4NWRc1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOEcbzFx5fIb7mmu+8tA0cSjkrDMsfuCdO3dFINsSh0KmpY8hjd86jR9jReWo57xgtrdPPBqRN3cvVBRBFsBNtMu9kw1XK6R1pPQyQPAEAvYfbYozFSr
    pILimpZne/h5kdWdLIw4dwXqZwgqSLMo17tmPpO8MKHVCtBdmV26RxwNQmWAGV6cPSC/+KgJFZA8NYV45CQql6wBWxdIyVuxdLL90Eoz259fDVjUm01Y3fs/
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=y98JahJlUwsA:10
    a=v2DPQv5-lfwA:10 a=wSFAT0bzRL9SllPayaAA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751072AbeC1NiK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 09:38:10 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45388 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeC1NiJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 09:38:09 -0400
X-Google-Smtp-Source: AIpwx4+/PJHDmnAs7AQNW3+M8lD1HIIT7RfWQQwyNf8kiK2w6R+CZs0rYsXdVJk3UdBuoeyby1WCow==
Subject: Re: [PATCH 4.4 00/43] 4.4.125-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180327162716.407986916@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7c9a761d-b77a-dc4c-46f0-b959d969063e@roeck-us.net>
Date: Wed, 28 Mar 2018 06:38:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/27/2018 09:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.125 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 29 16:27:00 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 127 pass: 127 fail: 0

Guenter
