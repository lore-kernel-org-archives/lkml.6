Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3173065-1525180787-2-744643617653310193
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
    1525180786; b=BTnj7agrkdia05I8m6BQGfdaA8B6L8rIoQQ62zBMIxvHRWZnZf
    tN2XPwttBezOxd4RZAHFrFNT0iese+9Uh7ZJz3XiECsjLECGJ0iWQwaDdElXxJaD
    YwM8RnRk3uKgtLxAYEh+zGc0EOV/U+rRIi7DsMSAFnY9q7QiVw8vSOu1Gmuk8zRL
    H06dEm0mWBwtiKLQFkl+kCFEn3+4NE+Ohk4fy0Vucc227nkh31DGCOgBItD1LHqw
    uKyL5SE6zGmS+F7LGoW3z3WI7LtSXl10paQ2BOAhLILT35k7oFR55uOVQ5NWTxLi
    wDucAZJCUxJ9nQzDztdfxj9ubCztS8gNv8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525180786;
    bh=lMcU69/A6iX3UbJUAOSUFj9TP8xamoNEU4RJr0wBjcM=; b=NHYtTPj4cl6g
    u7q3ffzvRPZPjFskuJf39z9y5dSMuRxSyuzL8e2QZuNC77uNbTQc8+i1v6IveMxK
    EO5nYVcdx1sbkzKB3fkchQQ6LfE2sYCXiF1H0sps3CUy3IqVUwnGAllBmxZpK4kT
    ID0lURXGLKgeozX1cxYRBkMJfO27QsjVsuivh3BH/aybNBbeMmoiRG9aVjxbs2Hx
    jey8F0mrzMfk8SGDmFgvYV2Yd5xoIlN4TutWH0cMuccuCXY0SPolhHjbLE4Ht+fY
    MfEuku4AlPtGLsL4y6KOhFg4Yc+bb4eBqCRUgy7YboG+dvSjetousKp6uEvsCnfA
    QuRL7rvu/Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=ITAJdNK7 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=pJc4VaQI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=roeck-us.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=ITAJdNK7 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=pJc4VaQI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=roeck-us.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPF9k/q01hsq1kE0SEvzjgt4ZqK9B1fR6Es+GEsnzbUYLn+F3dCI7aFMMh/XVer+Y33/FTq+7tvCmYpccUGV4TNd6wK8gLE8ZPeV+4VEummxrrNVcTu3
    6VS8RspAGai9UfrbUE9pl/quu+IyHApGU87UDeSv9KUL80vKBDuxGvb8T6wxLWRXsbWdiwmvtmR89dQ7z0COrbeTGjSWxFKmXKWDErd/NA4jxnPv5RxvxVsP
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=J1GPtOpRGk0A:10
    a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8 a=HoCkWmlCV56ydFt2py0A:9 a=QEXdDO2ut3YA:10
    a=eX-Bu5Fvq_kA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755237AbeEANTo (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 09:19:44 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:39796 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753072AbeEANTn (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 May 2018 09:19:43 -0400
X-Google-Smtp-Source: AB8JxZpV+JxQAzaO6bu9gFLUtrhlEyz9QXx4RhdSpzRKl9VEJFTdCII9iNsvc0CVqz1FoWxaCxzDTA==
Subject: Re: [PATCH 4.4 00/44] 4.4.131-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180430190946.093694747@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <0cf4f0cd-363c-6778-3687-b41cd5039204@roeck-us.net>
Date: Tue, 1 May 2018 06:19:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/30/2018 12:24 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.131 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May  2 19:09:34 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 146 pass: 146 fail: 0
Qemu test results:
	total: 127 pass: 127 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
