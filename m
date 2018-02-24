Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1963263-1519495016-2-15858804172214598054
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
    t=1519495016; b=GFjLfu6Va5m8vGm9cdIE8vOWbiVGwX+8aFU2DusDNvVClR9
    +PKRs6Qn+p5KENeoItN+OMcGUoGN9aBvTZE80dNHR7cmMb4ZkMv5+EoAD571bYaN
    qZn2QjnU7N4XHmoXRTgzvgpKSYuaJbtYtLDf0VpBnW9ZFVA5pahHmF4tL66IdTHz
    06OPCxUj9zBRd9WsWXZuabZbBib3VIIqav4H8n7iKpreQSOJM7QxA31wZUv+zwZb
    YpBn4d0WeZabHYlKe6S0BjoVqsK4a7maRiKYaDcr1MIiWFucAWo+ToQVQmjUwhzm
    EKyM+yEfwB4XJxpiU0pKKEjcxNO3NVi7TupZDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519495016; bh=5MXERJeGA7A51mIrANBObA01NrKD02eLMZoQV3wQMDg=; b=l
    DY0HrLpsP0JbX9qVqqWfv06YrRuNuBRksJufqfEQbL2ypZKXsMIYbhPzkSGca4wn
    48julEbhLTzVYHB1neh7bYPUxk9O07yrFenfpEA+wFpNRkk0ZGLp9dYidSntCavD
    m0gwZCEUgHM/rUwyH3GLrocKb2vVmEZ28Pk3NlWkaH+WooFy/f0BjL0AOrS/HYr4
    ++j8NgjSZK65bGYoYt6rsxgHIDKCNLshXEUrww/xzSBM9Az5x/c44ygBbF6UTt7L
    0gRk8t3Xk1giPQ9x7ExiYdHArPxqFUc6tXwjSMW2v0A+p3swWNcRCA0hDfNY1mUc
    lGntoICnT/AlReBrIkBpg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lpztUpMY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lijieU4a;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lpztUpMY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lijieU4a;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbeBXR4x (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Feb 2018 12:56:53 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46008 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeBXR4w (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 24 Feb 2018 12:56:52 -0500
X-Google-Smtp-Source: AH8x225/BXNwRDbBwxENQv/eyeoZfPZMZJ3+0D8NW3OZecNf+2zQ06mwBF7Cq/mSkQByWRr52U0/Bg==
Subject: Re: [PATCH 4.9 000/145] 4.9.84-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180223170724.669759283@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7a3f1c29-5574-b9a4-7a37-7ba7df402239@roeck-us.net>
Date: Sat, 24 Feb 2018 09:56:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/23/2018 10:25 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.84 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb 25 17:06:27 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.9.83-146-ge908a05:

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 126 pass: 126 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
