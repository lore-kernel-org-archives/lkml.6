Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3418695-1520696668-2-13803473840998815504
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520696668; b=PkOZDWFNZzWYYV9Zo/CYlCMihz1rejQ8vYS75k/ahCKL3i8
    T4ErmR3GpLa9JBIKyb4PB+7Pyl4QZkQTTdcwNjgNlYb6ajsDScUd1sm2FhWE7krM
    m2jp0UNx25+Rm7FjKKJiJahSlj1RVJKpDlvmXPABQORfyhncNPEekdoD+nszaTVb
    C4pTYcfULxK/MkrkZ6bt3UfEIH457Xu9/BXIY1sdmEdjBMIIbN1YlQsZYQqrwMzE
    ZlLwBqcuQOQMJ/1bp4Fg5p2515hz5QvAdDjP5ApmEQVV0vAKWeSikT7OTh7j2ftj
    Uulq0PUePsTY8ssz5yurGj5mZ0olkGgYt4FPmOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520696668; bh=OPbZPrYtMOq9/bzAzvVg3FfubBmHV/L4rhyAijPfvL0=; b=A
    P6Ykdv/wYhxRV3GUEjGf/daxg5xG/OWxezX9oTLjYgvP54fBQ3ObwrrpxxRHy+uC
    ifR65p5KJjJecSfXBPw50+qeSzQoS2U30NSAGdS9B9EFJHYISgRY2/Bpy/Y53UrL
    er7UYHt/Q6dOGyn4m5MW5rZsDliQDjcX9MJww/PTZRFPxJHWb2rxxQ9g4upvWNdr
    RRoQwzvgGFtjaQvqSkcYw7NULUEc6rxj7jg2CPij0TH2rQlvv/lqC/Q1P84VnFuX
    TpBSfMr7VizWe3arVkLE2Yknryf2W7TbBHvQ/U62CO+PKRXSKNo/JWr/s443wLmh
    /jaZbExBxPBEcVqpVVczA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=P1c0Ue5Z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VNhzt+Cy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=P1c0Ue5Z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VNhzt+Cy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932244AbeCJPo1 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Mar 2018 10:44:27 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36111 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932150AbeCJPo0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Mar 2018 10:44:26 -0500
X-Google-Smtp-Source: AG47ELulWITLtQ7kJU13TT2OSxa8YaYg6a8YkzZiswQYPWrV2zMizEcohmEcu4tqDdiKJdhWpsjXPQ==
Subject: Re: [PATCH 4.9 00/65] 4.9.87-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180310001824.927996722@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7874b14c-4273-e036-e4be-5160fec35633@roeck-us.net>
Date: Sat, 10 Mar 2018 07:44:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/09/2018 04:18 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.87 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon Mar 12 00:18:06 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 137 pass: 137 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
