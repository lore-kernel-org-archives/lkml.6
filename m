Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2531373-1520026186-2-3067779115787639001
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
    t=1520026186; b=eW+fcpjuKQEek7wwu+7xgv3Z28FUpS6Y+IyUdNLX0FBGLDi
    x6WktrxdH5Lms4uFByF9oEiSMcJkc51jl51s0xjbZt4cel6Qa9Xc4HxFVInekKb6
    O8YlYMFfUxHgqsZvOVUGTZwHz8NSbkgfIfc0AF5yn8HILFTmOG9xBZjYQuLcwrj0
    f+Al5MCiAOFnUXz7iH2grOONH41bhobo3M2JvSD5ZiRi+I6qBUIIxPM6BpWzGV0X
    YAexvryTX+QEc8qKpBpDAK3Sla18aE5OewLDDBfot+AvUhVzpG4CE58s6vZXJf49
    viCqotGDgwSxB7Jcc9o6fj1Nhc4voUx9NETcHcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520026186; bh=GWfPlefI6RMD63kyFEo36h/uKod5jdWuPXsHdUqSNnk=; b=C
    I+XPQBCEj6I48vY6qQZ+Mgs3gH18U4fPFfAR9SGLjp/Tt+qd/P1aOG5Qowpv2vZa
    klk4LYNSMGfEbDA1z1Arx9Aq3sshuDypuwr44iRVRbKkmrc3VqjWJ7PqJ0PwsnIw
    tupNmrrDXqTAoJvfj/qxO3J3HriOaiAaIuYcsniB1UVunspjhhT9EC9ICD6+A87I
    bYpKa7pDKHKSmnz0qbjxPv4Jr7B8KAUj4YujnYrFySS5XwiuJfOea4veo+w3xbfW
    LzuOYga+BgRE+8VuXGixCwjhenWpAhedneNsUhg3Y69cmOBwtzVclK3wZAOGk91m
    4ovvNSxsxtaBLarlx1ERw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933892AbeCBV3n (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 16:29:43 -0500
Received: from osg.samsung.com ([64.30.133.232]:52647 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933687AbeCBV3m (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 16:29:42 -0500
Subject: Re: [PATCH 4.9 00/56] 4.9.86-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180302084449.568562222@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <2fd05b36-624b-8433-3b38-24452515eeb3@osg.samsung.com>
Date: Fri, 2 Mar 2018 14:29:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/02/2018 01:50 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.86 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar  4 08:44:26 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.86-rc1.gz
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
