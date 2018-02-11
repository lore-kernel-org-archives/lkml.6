Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2262623-1518347910-2-13512673823747828124
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
    t=1518347909; b=oov6i2Uhz8cYSqTY/1klF8t+T0//K7zvRK3whWOXW8aNgKZ
    nFJF7kv5zZObDbF+fVKlZ+qEONUfZtz9GIUx5UR9uEbNKuZ8UvpENMHHKjWL4Fey
    D5Ug6Y2rZ246l5q5PHYZSGA2B0Gcn500BMmogqjtcnFjZzjV8KZMkCnX/ezidS2t
    5O5veqQf5eVdCLmrFoVtWDjopG7QAqrbHtRhAXKMzhgEMg2TewbG+SI2TT0GIqdh
    rFF7YeM1mgU1rENZ08N9MLc4JOIimlgDILw7fJGw2W306pBxSeIqmCSS9Rgkgo+F
    R52aEOq1GTZ6mvpZ7VjlE5DrFxguMBfGEMqhkEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518347909; bh=IlPvZCkDuEhc6jH6qZTOwOekl6iNVlBaQkDXbMuhoP0=; b=I
    eR1bGJycwyXh6Dm83hicz8F/2WopNwFVrOynzi/UradLvtuv1Z724GPPrUHsmsvt
    UyrTsmXG4BeQmh6g/pS905hE4ki/rF7nZMGYZ4kRRUJYEsMMMM+89xRGexcG5Atq
    BUoiJ8Tn3PNy2kXLGCtZmZqK+CmgdknTzJiQSdwwPaniQL9+xGUeJUeJi3+xSR2M
    3OqX4AVBsoq9nAYbbYPyN1glMfhv2RPRiXjrxn9Bk10utKfLlMnQPcBAtpXhCcJz
    nQogx951wZnkPuVITMzVS2W4D4qwtdMcQ7sNPAX80v7ujM6jM4iqKdtq7ekNrzaJ
    SQBZWYIRv5zKVpwEUsbnA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ibzmwqZ0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Wj+yWWs4;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ibzmwqZ0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Wj+yWWs4;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753163AbeBKLS2 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 06:18:28 -0500
Received: from mail-pl0-f49.google.com ([209.85.160.49]:38935 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753090AbeBKLS1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Feb 2018 06:18:27 -0500
X-Google-Smtp-Source: AH8x226uIVrVTGN2EUu9L4oCDDnvyB9fvJgoW70DCmZH+G24bwzw71r5hVKW7u4bOnijO/m8oXpV9Q==
Subject: Re: [PATCH 3.2 00/79] 3.2.99-rc1 review
To: Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org
References: <lsq.1518322802.943358572@decadent.org.uk>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <2e228d38-783b-123e-8b9a-ce9f49b07568@roeck-us.net>
Date: Sun, 11 Feb 2018 03:18:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/10/2018 08:20 PM, Ben Hutchings wrote:
> This is the start of the stable review cycle for the 3.2.99 release.
> There are 79 patches in this series, which will be posted as responses
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Feb 13 12:00:00 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 86 pass: 86 fail: 0
Qemu test results:
	total: 69 pass: 69 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
