Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3551165-1517610026-2-8935217624021060802
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517610026; b=jF2QeYS/RtR8LD6wd6Vpga/1ObTTZuOsay2iAUI5o3JDKtZ
    mU9sTvwHgJkXedEcN/f0g7q4pVVvzHb4+xP96GcPq4Q+bhxMCNwenBnpRb6m4KSj
    OClCj4Zwm07r08cBhZkLzDaj/eJ2LLyTa/NUPUwkybQ6ewvV3hNnRecyI7dQa4Lw
    jzCtfpoXxpq+cIhbohzijoORT/HfPg3rzt9JPZmW8SL3RSkBtJ0YH8azgHkoX3BT
    1gRIZqDLbsy9QprhJtvaMDMbMVTlOQ4Y0kg6F3QT5IsOstZAOx3x3+XhFCEPmCZO
    DIc0M0vsLqXp6n3Dt3cjSpzM654mBIEKX1nzIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517610026; bh=1z/9PGLN3jFPQwrnJbmxrTGd3e8A4W4pGa5JwX+SGJM=; b=Q
    qKe5Ghgejen4WNuSYdlXrZvUceJIcQsFmEn+Is+A8kdslqZ63NbIJd6uw7D2n1Lz
    TX0vFqLpVzpy/1i5JdNyXoMH4n+dDNpd53iu25BkHhxcLIWDIG6LlD321DRFLBRj
    Vn+8Z06hC/noIGpZlev6yQDgNfGD6fjOyXNXzLFf49Z5Qv25U04IASF6N6VUZLpP
    vLzTaqv7GfRI9KpkWeGOOZJXFWSne4Q9U38R9KRvFYS5EPIx/h2GrTszDPRzpcRn
    5x9mAIRa9v4LHF3n4lleyt5KojhSOqKZN6m+97awe9d6LFPLNu5aCL/fDsadOPvF
    7KrzBAuuuzKhrAume7yYw==
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
        id S1753013AbeBBWUX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 17:20:23 -0500
Received: from osg.samsung.com ([64.30.133.232]:62255 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753002AbeBBWUU (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Feb 2018 17:20:20 -0500
Subject: Re: [PATCH 4.4 00/67] 4.4.115-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180202140815.091718203@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <1dadc3b0-a2f5-76c1-80b8-af3c9821114c@osg.samsung.com>
Date: Fri, 2 Feb 2018 15:20:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/02/2018 09:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.115 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb  4 14:07:31 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.115-rc1.gz
> or in the git tree and branch at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
