Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-40595-1519693040-2-17213471926323455305
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
    t=1519693040; b=DmZL3YHwm/YeknOSpUGNoZwLkvnCkB9Aq3wxGE7+HsPQNXa
    A18ANvb6EGCvkW4aIv7tXo838SFVTk76GPcka5qL2L5IInsO6YPZc26JTrYKdzOv
    M1mmz42/9bEcHlqMWjOaMhRL3cCaSlBs/LBJWtNYZGXwQHOOTZ/2/W6vrKAghOPX
    Drn9mUk1/H9CtRUNNQep20UmJtaujg0JZ4gIsg+X5m7kG1CaAJRiEh5V0vhzR2bj
    Fy+IrvJScoEsx06uScjLzKELVexr7NOWMNKAdxdFqfSykgtUdI05xFoUX+BvOi9G
    /GTuNVvUocHB73XJ2dEE4I4C9PHb3aQdTq17b0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519693040; bh=NUaUqfWOtcfUviJT6kU+TNg4dcASy9lH797CTsvK8TU=; b=D
    TBokxkxj5dQKMWpiRsIfHYBxbDnvn3Ie9/Zz6Da6AAkUddTVFmeOjgKasmtGRjaB
    P1D11RDy5aDJNcBKsjQVpSmJ9ReFLi+i52KUY1IfvhFIgTGsMgQgKq6uMIL/0AsR
    BuOkzo9o+z0JhJE8YEGuDqGYb4bezCLbl6uxumJs0etyt6EVY/H7CK6AnxTunTk8
    gvj+KsvdgGIzXR3CMxB5ElSV408OKMWKAMmTyVXNKDgBVumw9iaQTTLSs+eW4/Ya
    dedl2umD0MGlh6CJWJBiPrAoIpTeyvRsax/9XkxNyvEr4CJHAiQrWe2RqpxKpVH8
    WlQlQBmQfRQhs0Pn/gQQQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbeB0A5R (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 19:57:17 -0500
Received: from osg.samsung.com ([64.30.133.232]:33676 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751574AbeB0A5R (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 26 Feb 2018 19:57:17 -0500
Subject: Re: [PATCH 4.9 00/39] 4.9.85-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180226201643.660109883@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <bdda2313-81af-3153-799d-66a2a6d593a6@osg.samsung.com>
Date: Mon, 26 Feb 2018 17:57:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/26/2018 01:20 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.85 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 28 20:16:31 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.85-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
