Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-293599-1519308765-2-7022301141149507019
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
    t=1519308764; b=jE2YASt2jJfqJrMGujMbbG5LvNdF2wRg2Qb7B3Xv/bqGcCd
    pzKqFLXmjq/0HASSTgo/+MXPcap/NijRmqJIxvsd85CcAwdUNs3GT5aNz73tiyIA
    SdXRka+E1rWhmolIb9UOMWiLCzVcsD+xiNCtxgcV96PQXWBoTAZR6nKA1DD6BJA7
    x9H1ShIsWmFm46bAntzo1cqrh/pa2rJslDDK1fzjS/Qj9tRso9yKU/Z7EroNCFTz
    mKlGTwqJYs4/Ry6VsqX1nw3D9Cm59PIGfvwcvI+6nw0J3FX9zYhBibRp2eLgzyHw
    htf+P3Xeq6gBnGGESkzqpRJA19PIkHOlQ9HsW1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519308764; bh=MtEhkhvYKlkRlUjSDzaFRbE699cZLpW3xs04xZ0+VYc=; b=K
    liMuSwuwOwlXkJ7IAEiJ+TTWqnsMhRubAuKByYH4+ArEl3rcBtyCCDkxgzpRQ4oS
    2xnEFZoN+KMlkJAo4TDh3U6s1jDsj1w5PX1EyIa533dC6t19GCaY+jpyddI4ymqp
    qzbBLP4R+bSiRer5+LnXjCjlyDQ0dQhKDYCmJaML+hNlK9F7TVDazGCDJgsOrJoJ
    yEmFvuThRUaLeI3Wm86N4LoLdnwRt9ronjqZvpG9LEdepwuyHl9bPmowFog2vZL/
    ntSn/cngMOrrOyZI9EXxo8e26fx3GJauLKDCAxtmW3PBHm8q7YEKOt2BYH2T505b
    GdBmzm/oVWjmjxiCS9Rpg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uaIz6KDq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qwCazCAQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uaIz6KDq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qwCazCAQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932728AbeBVOMe (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 09:12:34 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45373 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932581AbeBVOMc (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 09:12:32 -0500
X-Google-Smtp-Source: AH8x224xDRd8PSAZs6yU1uOhQC2hPE3v2nF0y3yUk2Q3uwagoLmDh/aEs71nnak1QX5dhp0sp/dZqA==
Subject: Re: [PATCH 4.9 00/77] 4.9.83-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180221124432.172390020@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <43dd7da4-340d-2e3f-0a98-0521ee5085f1@roeck-us.net>
Date: Thu, 22 Feb 2018 06:12:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 04:48 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.83 release.
> There are 77 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Feb 23 12:44:14 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 126 pass: 126 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
