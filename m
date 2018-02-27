Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-40595-1519693122-2-825319305408094939
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
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
    t=1519693122; b=rEcJIR+7Tg3Tn4SzsA0Ijs5+QVRVgNtgm7uZ7uRAtZUBnoQ
    MOgreZw4CQMDkAMOG5yfX7dGtoJwndSnqCccbicr8i8gmiXymYqCLW6q38wYUQQL
    qsBU4M+bF371icfjYgWBKS1e8bE6AOd5qFyw/A+ODNpnqDnIAtgDWzac9rRqtj9u
    1QV1JzinqlxV4hBP3vP4YHxgMLXmH78yx2sUGGhNDZjCa3apO0R1rerewxifDLHb
    7MaEiJmZ9BNmKxOvl+IUTBJdBD5OpLmhO+zXycSXHmYwtsHL38uOlBt+8dqKB+9z
    rnJHwpId6ru8e6Y8swzgd0wxgZYySBBLTpSaxRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519693122; bh=gjOvo34WVo1Nq9tVx6AZfhnA6ruYUXCvEDFexNV/l98=; b=O
    YyvNx+rv/i/xgoy4yERuolcBhew4QXqUD8HDp7iyd7qv74j7wjBQq1LaofyaW8rw
    jYIp0TSWQVrmErJuZhvBeSRnfCw7hxXKrnt4UnlO6rhineYIzQlw5JLVSP/A958E
    CA/fr4rv/q0W57/mUbCf67R4LaU8YPuPMmRTTcH3eAwKcW1i8wnmMPaz7ytbh2u2
    sC41HXPZXZzjoSQrRwU98+n2EzRTrCfWCqKoybIY9MJt0tnNK9F9SbfoA7p5545K
    n/HLuG8IFKBdA+Ng3qyvDFQ8WNLbv/4EyFoeHIrvlmOjQWOULis27ddIY5WxfQuR
    I+WYC0eMzrwbT7+2Oqe8A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbeB0A6k (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 19:58:40 -0500
Received: from osg.samsung.com ([64.30.133.232]:42553 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751455AbeB0A6k (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 26 Feb 2018 19:58:40 -0500
Subject: Re: [PATCH 4.15 00/64] 4.15.7-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180226202153.453363333@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <475cde86-0218-7f8b-837a-819c631e0a2c@osg.samsung.com>
Date: Mon, 26 Feb 2018 17:58:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/26/2018 01:21 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.7 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 28 20:21:30 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.7-rc1.gz
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
