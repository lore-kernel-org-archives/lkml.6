Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1654150-1519743432-2-11188890975913861408
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
    t=1519743432; b=alqjLeoYHf7t1gLJ1jKJizquQUYp9ZtZQPD2IvuoiFqUavG
    seUdeKWqFW8nTPaViGMcSj1hlbkrkVULlmqwRKpWo3RACagsj8Ma88RbDmAvrmME
    W9opFEKSoCfh8PKquRekZDTRgzLbRb+HGxJcPN9thb6pTBmzSSFzMw2Y44yft1XM
    1fkaWTkhnjTPzCz/9120v0VTyZuTFcU4eYo8JOOso3OBWfPotnkGXRByXwVLU83p
    FGZptwpD/8f+oXRWxanMowj6LPpdBb+dCwR56wlTV0O4kiBNhhNDKQyePLqen/cr
    63FL2U9/oQrBlXipaNvI2Ow8kHnruyqO2uVGo4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519743432; bh=uq7+LzgqLykpVn4zdg3OLGg+f1TDYwPTMhIvVnWwyRU=; b=J
    LLwZeqO8UbAqHtbkmwueh2ljMbR6sEiioe3smRq0VUi7km/vSrzOtyTzLu+H2sc1
    DtVSoJ63p6pIJOomteyGk5tEoomjJ0W0wk7qGZ4YflNXH9f3QNvMKskzMedOUMfv
    p/aSA+HL6jXK0A9hFcmmrYpcNgi4pXkPWbcsbY7JwgbuhCHvBKCFbltt8IKVEU9J
    B3ylmcUN/j13XP7LX/AUmLKKjXN6NUVsi4pzGZ0nIf9+S3whNddK1nmg2aCa/94o
    d/3PIHXpoleTfo0eZjQWUQTbET4vPEajZadGmtCnyvGoVzjJxHV9LzmllgIqfeSW
    P9AkL5MuNdi2Y8D6aJ/Yg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=YvCViXAs x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=R44Wm8Ac;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=YvCViXAs x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=R44Wm8Ac;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753271AbeB0O5J (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 09:57:09 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32847 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753166AbeB0O5I (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 09:57:08 -0500
X-Google-Smtp-Source: AH8x227X02Q6g3JAc1QrRyEXU6JiJTfBeBGYaYzFhhGzQtx7YwIGVWNBgG0zHF+tQDF+sc9GDouaAw==
Subject: Re: [PATCH 4.14 00/54] 4.14.23-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180226202144.375869933@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <da2fd7a6-fa58-0e49-02dc-696733e7ebc7@roeck-us.net>
Date: Tue, 27 Feb 2018 06:57:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/26/2018 12:21 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.23 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 28 20:21:22 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 141 fail: 4
Failed builds:
	m32r:defconfig
	microblaze:mmu_defconfig
	microblaze:nommu_defconfig
	microblaze:allnoconfig
Qemu test results:
	total: 127 pass: 127 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
