Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1272229-1519470713-2-6247441710979655558
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519470713; b=bEZut87b/1gNM4NGsVxS4I2qarkGMC5HnhtwP1I7oqvrl9O
    Ywszs61F5GYnwKRRCsfSJYjb/SREb9mZHNu9G0fkH1uwr/1gUDMZMuVyC4kD/nE0
    ct2OQgtO9CUFtL8ZNw4ES2KM9Kk3ApKs7PvYU24exvZLOx5aYfp7apkF8GCd4L93
    gxvGE+En7gpp22sRv/eBmDCMY0y4J7SRCWtRLoZJyutgf8sMArNDCgYqY2GxJEyB
    PB3npagPpLPNc3QSvDF/cKUl9gxOSGm7eNvg11vGh9LpW5IkrgO+LmY2Zpvh/5lK
    BGDs1DT/gcaFxVrGcObu6hs0ET0b+fpmmr9YW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519470713; bh=fMPJGeO2z5nylhictyBf2OG/5FFSpVKnicutc0Ia9mI=; b=Y
    tPjQ+/+z9jD4Omde9xGjMjDigf/cOAoPwJQ3DcSJvmqj31jUgW32COou1x/ZCUye
    zRy210pJEI2dk/r4+txF+R/fr1d3kGrEQxsUaHWlyBlFszDLeXk0z/0FwzhZ1hbg
    9iU8Mw7mNllPeTyUL3ZG8/0dVMd3cTV9ndaEbXFrvLmrF0S68Bm1yh8+fNYH4wTe
    CSRnAbaH65JzML38xhkKET4rE89m+QhBDV4iNPNPTG/VphYAM2XD8tKsDibk+z2M
    YcIb2Wsk5sn64225vdaZfqABhJ+/TrDZURQHFuxs2DWvbAzq8s/DG6f8mBs8q8mv
    3LQEMQgmfjTjc8/5/2HkA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LmULBLw9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mUM6y57d;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LmULBLw9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mUM6y57d;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750964AbeBXLLt (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Feb 2018 06:11:49 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35351 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbeBXLLs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 24 Feb 2018 06:11:48 -0500
X-Google-Smtp-Source: AH8x2273p8e6c6JKJEu2HQcpP5OTMrbRTUWkmL4nMe/40r6Y3Fm+I3YW/E741pECLODqKEfblL9WXw==
Subject: Re: [PATCH 4.4 000/193] 4.4.118-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180223170325.997716448@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <0ad305e4-e73d-e325-1772-8c771479c73f@roeck-us.net>
Date: Sat, 24 Feb 2018 03:11:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/23/2018 10:23 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.118 release.
> There are 193 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb 25 17:02:20 UTC 2018.
> Anything received after that time might be too late.
> 

m68k images in 3.18.96-rc and 4.4.118-rc fail to build with

m68k-linux-ld: cannot find SOFTIRQENTRY_TEXT

This is due to 'm68k: add missing SOFTIRQENTRY_TEXT linker section'.
There is no definition for SOFTIRQENTRY_TEXT in v4.4.y or v3.18.y.

Guenter
