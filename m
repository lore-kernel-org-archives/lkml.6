Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-296820-1518791308-2-599973781395092082
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
    t=1518791308; b=JevxHH2ia2Kj8RDPI2zIos5rjxpkNvl/Kf5QaDXLK6HUZvV
    5Nd1z78iK8XVPUKe7kY+hM5Lkse0Kr5sTrb9a4a1rne+EpCWIsBJ3CifVxtfyN+7
    PaNammn4SYBUYh7ogMru5Sx6swoZSXCK6hag4ltSeRRdII6tLJyvOqyelGqCvLnx
    w51knzpszVdhEm68wrJPAK2LQJqJLg3GPXb5L27pq9chxhKMej6E4psl5x2wzHtS
    aUQQRyn2sCqz26VgpKHc/47qa6UfbzPVaxelpHPMN6qcyQMT/9WKP7itjlMBNqWw
    BOarlur8lg9QgG9Rged0Pf3f4lIK34Lx5iq9Diw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518791308; bh=QWHov8o/IpwxNgEBkct8H9FbsgpRFBiAklkIsoDYVts=; b=V
    aOcYZ8iMgLHvnZOmNWvWTelQz6m1XsDW1lgByen+0/+7jQEwvjGsisG9CzXBxoGQ
    /Wt5zwkz7G0gotzJX/yMkGUkrer55vNbzvbh88RYbglqzVhn//inix0rJK/2cQWX
    s2CZ95jzQNRvEj9uJOoR4RXul+XmVyU2DBF3m7XyIEKUbYEDWI0vO3xFyl0WJnvn
    vAHIJTpTom7gH6H70HXSzk1zuTkBFQyvk8bgbYo9OZlTZmuZH2KUY+CD9v4WgI86
    ycr1seB81LgT+3+aOgNVMAQDsEoNQpDIuycwhq8htkAV/kJAXZWwsJqRkxwz2jpz
    yix/T1Ufq9E0ZMkf86g8g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ALatiTUi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HrKA93GJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ALatiTUi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HrKA93GJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034386AbeBPO21 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 09:28:27 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35441 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034384AbeBPO20 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 09:28:26 -0500
X-Google-Smtp-Source: AH8x226+xPbuBAdzJS92GCF+f61OjeB4TbG7tfHl0V6Cf6h4Z3hNtRLoqwqhftP0xAZP6IC2i7EMJw==
Subject: Re: [PATCH 4.15 000/202] 4.15.4-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180215151712.768794354@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <cbc0c633-9f5a-747e-ba0d-9354352c1c77@roeck-us.net>
Date: Fri, 16 Feb 2018 06:28:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/15/2018 07:15 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.4 release.
> There are 202 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Feb 17 15:16:28 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 147 pass: 147 fail: 0
Qemu test results:
	total: 126 pass: 126 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
