Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2238391-1520658611-5-7634234696304516551
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520658611; b=vLSgi3yP/N0plsAaLyAssvjEtaxWtKxnL9IIbNb3lq4HOBJ
    lrRx1ysB8KODHoWIUSn3lZTFlMXuDehZ3QO7BBQNKle+cGvgozG/eB0IlcqkzyT5
    bF62JFb+OKtsh1/BVA1JB8si8rFNWBBPi8FtR5PGox59kubRHaMCoOzC86lOiNUH
    zsF9vZemOyCeSThHpEQDeFjnFzaJYQsG7PVD1lWSzIv9cYkH+dTe5uE/nuN3JROv
    y70eb7prCbYxA9nx9CxPlshrRvZPXPvfbLhB88uBWkarA1Y4lzMSW1R6eg2wDoXO
    Gb6DTV0Kt42BVOUdajVEkask98Oj6j4jbnJ2RuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520658611; bh=33Tuqhbd1QNP3BsJOqTpovZjk2b6Ek8FaA7TYlas3Oc=; b=e
    XEf7HM6zPTcTautbQp7K+4tXu8qdJ3MV1BPJ+uQgLFM7vIL2uvqyit3o7WtLBkiM
    jZcJGypF7+kcXL3DNnur1Qlun7IbwAkWWrjsUZzDqaGwiAUwjmR5zJ+QVc/tDrUu
    kN35AkM28758hYvza3w0pY/cf6Wytq+6MQlZSvzOZnQIbw4Kot4oj9QU3yRxsjR6
    mVgX9vzjkAB01roYrH7HaXcjBzC/DmDnaFzw6ekO0zQU9BluOLqGuAlcKNf14bfY
    r72CQIp/9wW3OBLCIOhHxQFta8zNI7RBBpJVrmEJLulffXavGbYeBNlWRys9xgrp
    c0B4YzTZ08dstAw1l794A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750714AbeCJFKH (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Mar 2018 00:10:07 -0500
Received: from osg.samsung.com ([64.30.133.232]:46257 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750703AbeCJFKG (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 10 Mar 2018 00:10:06 -0500
Subject: Re: [PATCH 4.15 00/11] 4.15.9-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180310001834.560857664@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <7fb3b595-66bb-4200-5b56-1896728ad19c@osg.samsung.com>
Date: Fri, 9 Mar 2018 22:10:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310001834.560857664@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/09/2018 05:19 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.9 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon Mar 12 00:18:21 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
