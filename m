Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1170116-1517671741-2-12704330551540177813
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
    t=1517671740; b=q7wkLOXx9MxEIi66NbMuvwEZOy7Fg9+DfsPFm58vayAx/Ei
    47BYxkzKAFLJr90qcSQccMluaOrBy+1ZwKavLVRATZw68nuZCsAWn0qzhM/COEUw
    blbWXD4RTEHdiTZjSlp+juvvWOwFwgVk0RyDsdBd6b1FKiITItCdNqx/2l3MXvAM
    /EDrgvIZF1FTwsNd0mBUM8841yPhwsqnSJ5CuDc0Gw+yLE+ct6Vb2A+oJQNoDknF
    HKfsgGzjW25DjGYyMaECpwK0KU7V3tLwjtKSi60UQoxDQI13qa5vd9sFqXdYRvVQ
    It3qSwiMs2mYsdY2DJu9RpIz6novCQuzgLzs6YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517671740; bh=L7GmOh4Yze8JftXWk3T45qEkpTvg/MEVKwMqeelc4uU=; b=H
    dZxIVO6QIev2wZBPaVmew5RquaMNQ1uHexj7Cwy9MVHgDGdSVFmHPGtkEII/BeQo
    ulSEscmSoK/rYU21zgSFvkChgZAeHpVtgQ3zTkgO+hTq7q/Rer2sHUpXykUAiuL2
    hv5t3awAKAbqaZ7uHKj6BXq2Y1CK554lDrrBBdU9tj0EYdscQpas6ApN4GV4diWc
    D/JNW7wHmhkQCTreIhKpmeYnETZd5b0CuViacM9EZEBANW67BkBaJiU/ZocFCjYw
    GwpU7YtBQotkRqinyqLULTykySd5guQwWFSlAOXMiqEB1D2I8G12352z9qGlKRGJ
    ZCgWn6xfBFTcxQQYzZdsA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=o/sf3/nk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p0ibtwkM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=o/sf3/nk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p0ibtwkM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752465AbeBCP26 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 10:28:58 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33700 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752103AbeBCP25 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Feb 2018 10:28:57 -0500
X-Google-Smtp-Source: AH8x224q3o//z9YYH+k9G41dYbwqGLvkcvzVEcTFuZYd2uO8iRlVa3tUBNglMI6mmYUa1ofN+gmsjw==
Subject: Re: [PATCH 4.4 00/67] 4.4.115-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180202140815.091718203@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <dfe4da5a-1c80-96d3-2b61-e8b4fd375fd6@roeck-us.net>
Date: Sat, 3 Feb 2018 07:28:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/02/2018 08:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.115 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb  4 14:07:31 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 118 pass: 118 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
