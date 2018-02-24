Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1963263-1519495083-2-14812477625197701517
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
    t=1519495082; b=jh4DyrJAMADPSvjUhIDC7qbKaWe3A+89h8okf/Jqx7i5wOD
    Fr5E3jkNdCEUjcqaexXQItxuoxou32jHgRwne6+FGrKRytBbAfYcprU1tjEGWYPF
    zHzX7Yyy9WMazVdHlQ+ItBc5/hesJimY72RBtlIplXLoV3GaW/BwXAdr9g0PnGQF
    ei1oqDlfeCNmumUN86yfyv+x4Cl5TvnOOfSTuaETEjooszRrN4Vn5YD5nYf9iUZV
    hE1SbTTj028mnRnN7zKdFaCUo1KIE+EASFBYMD6zILsDgq7NYxOXVMP4/9qM1dg4
    qf6YYdIE4OSkQh6uFFc2mOgLQjNW4udz4uSFcyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519495082; bh=TP/UJmjnHAzaTzwvVBtu7rNQCbmWSE9KZ4ZDJCM4o94=; b=S
    poxXiuxgCWgfeVvtN5ifoZYIjJvwLLBo32SOPYUIeceGndxOPO53qv6cv1yPAnd3
    5O+Y4Low/6aZZnWI1mjWiDdC4Vy4lT1D5rAX0bOvqQQr0zGOExUC9hbZ2yd9TE7J
    hVBWnmoO8LAdaGLvTmyqeboQ6h6TaRJnFfefNym60ys3GYyxS2ttqookOj60EjBD
    Nx4iBtLRdzDsP6/GfpAzX9Bemc0pB0I8I75u7s9fGPz/T4U3vgtYdeN0ZBpgR4o5
    +a09LN3QWUR6oBMj/hmAJ8J2OPM2C7Mfzw3TRX98koXaoV8NO7JIvcFlzp5jHbyS
    tjYBpAQHCKKKPLWvLkj4w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rJX8I9Ql x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PG7/AMfY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rJX8I9Ql x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PG7/AMfY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbeBXR6B (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Feb 2018 12:58:01 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34233 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbeBXR6B (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 24 Feb 2018 12:58:01 -0500
X-Google-Smtp-Source: AH8x226CqoIKcIc3jRtEXnh/lSNrTxYRwUGU1dMjLltdK61bEVAgXCgENnSZDJcCJISGNnhyz9elog==
Subject: Re: [PATCH 4.14 000/159] 4.14.22-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180223170743.086611315@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <165fa146-7222-53a0-7862-e897baa599df@roeck-us.net>
Date: Sat, 24 Feb 2018 09:57:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/23/2018 10:25 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.22 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb 25 17:06:38 UTC 2018.
> Anything received after that time might be too late.
> 

For 4.14.21-160-g61e5ffb:

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 126 pass: 126 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
