Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1654150-1519743244-2-4874276842212093705
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
    t=1519743244; b=FwQsRvezialx1FgpnlC0N/xCIUaNJhMTS/SzwmXhHn4aqUl
    Vcw7BRYqQOIHP8kp2X5JoPecoyUUj0rHOwiLijYvVkNXYbquvE3+uPOznBei6a9x
    gWiWACZ1SvGUP9vov5i5HfumjZsZ13bLKhuXLmwYStiSXoq0vgFZWFnOLMSWexVU
    2t0HjM60rq0PdOlOYfSGNmgA7Eb11JI3F2qxQmLGI6qVeG/v59IyZclu4xvOGhQi
    AcGVdOJjxu5WSVQEMKCIrbg1+B/h2G41ZAHwQ3r3h+1Kd3lqPtEY9RZajjSunhc6
    fRb6LzDelTBcEFvTr+kuqdnVXGKyH1YnIMdtwCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519743244; bh=qFQSaT9X3zxNbOz5H0MHgUB9BzwngeiTB9utThEGaVQ=; b=b
    6+4FNfzjALtRMrCz9rW7FCMaWO/ogm9XUSmovMCV/Ha3ZUTWPU5L0PEJLz1dw018
    n+jzSJaVorXJGl2b9zLks/Odb7deWTZlJu2GBCgyZ44E2fxRVJhnoFjvD8HtLFLF
    wL3LvrNIZlgPnUFT2weODN4YzRgYIPhCQ9CaWL5i/YhieVIvvuqUTLQfMf6MItos
    1bModLgmzD/8Ym/njKkGLYSnpTu0a+tWVfLMU6jnBneQJsEvmvBAYIXgu57afnvB
    403u0zGdjf+5MgZyM+IB96fkxfEDIz+xGu82MXicznKSJpV+mnenMCLZnX9gB8jc
    SGKx+Gq9mTKE1VS1f9b5A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=XDFqfrWG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lHQge2J6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=XDFqfrWG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lHQge2J6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753292AbeB0OyC (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 09:54:02 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39368 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753266AbeB0OyB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 09:54:01 -0500
X-Google-Smtp-Source: AH8x224WDKWFXOL+xpNJYD82SoUmLn0EL5JrJHvs5O7rfcrjkccgutfihzLYL0lyH5BavQuyJ9duPQ==
Subject: Re: [PATCH 3.18 00/13] 3.18.97-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180226201527.242286068@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7030ade6-fdec-1f4c-99dd-4d743720b085@roeck-us.net>
Date: Tue, 27 Feb 2018 06:53:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226201527.242286068@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/26/2018 12:15 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.97 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 28 20:15:12 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 136 pass: 135 fail: 1
Failed builds:
	xtensa:allmodconfig
Qemu test results:
	total: 112 pass: 108 fail: 4
Failed tests:
	xtensa:dc232b:lx60:generic_kc705_defconfig
	xtensa:dc232b:kc705:generic_kc705_defconfig
	xtensa:dc233c:ml605:generic_kc705_defconfig
	xtensa:dc233c:kc705:generic_kc705_defconfig

Presumably the xtensa patch does not apply to this kernel.

Details are available at http://kerneltests.org/builders.

Guenter
