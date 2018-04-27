Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-599759-1524852796-2-7797965206598278740
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524852795; b=hU5oM3tLuU9SAk2vHXsE2OJnhWJ1BbP1lpySVKef8w6FJWoT+R
    5v7r9jzR8aaoM6LhwPbf9noX3HTHa/ygFaoE/WLeHmdsLOMEixZOq3viQRsd8cpQ
    8/XBtreqFWffn3OZGJVnWFmoIYUf8aPa0ttGxklfB/quGWHnSMgrxr5ICXuU3tRF
    Wcq+oIpCv8Oyp+FNaqx4ZEP83mKLiOczUuSub6EGkikslpfGb4iuUShZjbfNQKEz
    Jr1JXiVY5ZTq+4s0vWPzbWtJOuTqThxg0+qvQ3/17ivFRDvMg0GKk2G5ocY0O41q
    0T6fGAHF5Q9hnKrb+C7C9SBBmIdi+6ZgL1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524852795;
    bh=hIPGQanmzKF5OQtq4uknJusZtOZMMKWa27cWEZrs7Do=; b=ImVUlqYj44wn
    UT+wopgYeCgHwNPRUquBbKdsP6f+W4qVWmKfSmjWt6QI1XNZDMXaQ51Y4ayfzXeX
    7O0fMPcr5Kq7w6KFJ0WQi6X+5pcYRBsp7q9zXDuva2BvsMmCwaWA7WpxkX4Pwsl4
    9fsW2+BPg/8m2xPjCqNTZSVoPJbBQMF9j1ToHNGVxnFgRcTgQIXMJFD3VTVspPRl
    JpCUwiCfB4D/wPZ5tUE1tXO2VMnrvPDS69gQfM5OdzO1XFYg2RxtMsfCHwAKq/St
    SW7pw0gTUiMXr5UXDpXU5BPju7VdJkGff2W0P6gOQDwTLt38wkuBbCCjQeHyEOSh
    2TmG1I9/hQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKD7dc0m6FdxyIUkIVA4t9Fp7qtTxLyqdcYTUcG+QYqo2ZmMHfBGYJ9+ovjRKvnEuVYwG2dTuvNLFRu/GAF49Nfgmc5FPp1p4eh1FAZs/Sqp0G7l1/tE
    ssXVlz8Q2k2xeVjs4PUGB5JBPahnQDHv3vFkUOutnuqdppNfn454beW0wKFjAL9RedmBmGt0SemJL5qic5R13jXHqBeFi003U770f1+E/2cUdFbN6ifaJxOn
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=28HZq395EAYA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757918AbeD0SNB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 14:13:01 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:47188 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757523AbeD0SM7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Apr 2018 14:12:59 -0400
Subject: Re: [PATCH 3.18 00/24] 3.18.107-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180427135631.584839868@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <58442943-fe5c-80f6-7f7d-5a73612b4aa6@kernel.org>
Date: Fri, 27 Apr 2018 12:12:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/27/2018 07:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.107 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Apr 29 13:56:20 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.107-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
