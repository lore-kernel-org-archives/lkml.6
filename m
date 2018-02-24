Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1887712-1519494908-2-15478876791464435677
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
    t=1519494907; b=XFpNMoMROyS/qXlz0GZl6XrIQ14ERAGjdFJmteOZj2bzoGl
    VfjpCMhQ49rhP7xrO1o59Q+MeJn5LfPQSXdooA9iu1kVojRzPjOpLB/LUK2t9yMR
    UbO5YcakWJKCZPoCvkphs8+4XKKgmZe1n0XF9IGE02oybQlUq3BhNOy+GqUSkUFS
    J82EQMJOnjiznmTzM4KYTA7BDP6DlOVRU/CQGp8kZOlstbfIcXmQTCNPA4oId57/
    cXrr2ig9SsP2GrKrk0O6UL/vZad4ie2BwuYSTCd9HhNYmdAsRObK+UgSLFXorNso
    iv+rA9DHbAScnusZSI68SpMsyPU/aRQ9zByHtgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519494907; bh=yEXZIl2y9eesKD4BnBt0eMCEP/brDCBoAvlT8fwH5Is=; b=V
    x+vcVl6pnyXbYxzSjv0h8eVgj68TA8UnFYSnr/FYoUaJ34yPvsWTIflFUHDEQCpk
    Ke30vNkjz3gRdG4+qd/igjD6KoGkHOGlXkn7KTtBFR9WUldS1/RmNmHXeqJeFP/z
    DSgv6swjbeXZoYS4UqfhGDViiATi1rq67fQ25b3TPrDuWkSCrW+v+JYSUDpFaCQF
    XTLQjpUe/2oH6va8Q/rkA68rDXfK37b0Of7AqVoNwVQgAri51H5qjbxgPP9oECR2
    tix0WOwQikz8AiO9L6KWfNBqQaTDHfKwxbFRod15KKy3kt8OgDuGLBroou5fZgoO
    X4fydHf1SahuZ/vzZT0RQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=E+mHnJ7o x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aEQlMp3m;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=E+mHnJ7o x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aEQlMp3m;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751448AbeBXRzG (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Feb 2018 12:55:06 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45934 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeBXRzF (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 24 Feb 2018 12:55:05 -0500
X-Google-Smtp-Source: AH8x226jpOq6TFe7X7EOo5WzdO/Oh4z/wMFMmDksAkSdrvy3QLJwqGld0Ozz3B/XuybluExB+b6MtQ==
Subject: Re: [PATCH 4.4 000/193] 4.4.118-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180223170325.997716448@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <21936fac-3ec0-33c8-596c-a564e01853e7@roeck-us.net>
Date: Sat, 24 Feb 2018 09:55:03 -0800
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

For v4.4.117-193-g68ab56f:

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 118 pass: 118 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
