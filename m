Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-40595-1519693080-2-9313284984422171586
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
    t=1519693080; b=EcRSghHC6xDPfCLOecVcbs5B8tJU0tsbJMwOhyso/2KJ9Rr
    ls/ktKA8RHw4CS5diFGU5TNAzMa4Fa82UJ8Xps3MxQEABATXLAjAk5xKNSz7AKAb
    t4ZLkDSLRSAPNZa7KvFsKnXILYeK/7lBbLvXQhISyQ9BoK60KtJ8zsUPvfTlIhgc
    9BokISEuKB7afv3H514QLPrqcEVCU3IXlgcCa9CrRQnit9EowhvPIXgiLhRMCPRC
    peZT6aTnzHbJ68nuvwPfFmzq8qaLxhsxAT84Bstb+RwzaXEQVsiDwB+g3/nRRjUX
    qrpVU1kzdxfNXCY6Rkik+hh5CXjOmZSalEKBJqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519693080; bh=JIxWllHFQbPtcjSV6K2+KWB6/f30VBtFU/KOLoPcOog=; b=Q
    AYQtn49s98ZUj8uLjbMFw4VOihKTFXfM7wXB49yslDURKPYGST4fCi8XwoSgiBfb
    vPd0/pUhqSErO/WyHUVMy2AfN+6YpAeoCHMQ7yNYl4fymWwUa3rN5cWy4OxXDRsZ
    j/IuiPGdjs0uyNo4+CMycfxuJS78J03x7z5L/YAg0wvrQHyro5l0y8VSGfXxOhhq
    7fLQHYxVUg8Fws+vld6znvLZxkltJm2mouFOgtJ5N3Si9SuN+nS4HPyU5fQrH7gW
    fYm1EXvrGcU3/jGnwjsDNiYBZvQ8BX5s726WcXhna7rk+MtcBYBGQ84MlCpXrplj
    WqzaALT/+nY32iOsL3bhg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeB0A56 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 19:57:58 -0500
Received: from osg.samsung.com ([64.30.133.232]:35701 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751233AbeB0A56 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 26 Feb 2018 19:57:58 -0500
Subject: Re: [PATCH 4.14 00/54] 4.14.23-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180226202144.375869933@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <b579004b-645a-b7bd-7d2c-e9e55c36a95d@osg.samsung.com>
Date: Mon, 26 Feb 2018 17:57:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/26/2018 01:21 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.23 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 28 20:21:22 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.23-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
