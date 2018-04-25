Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133472-1524681445-2-16896773558606847062
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
    1524681444; b=MR0yPKBwDdxpzKWtJB5K+va0hnNgWu/ebs7kYZu+M9qBufP68M
    7YNP2voqSIEHzeoXsdskoSk8hJ6awFH2wWoHH0qbsYFRZwUpLJs6sbLznbkMYULx
    nthUb8+ILE9LcOWrccFr3XJhYPJEfYG3dV70GCTj3oOhK8p6LbSOyc7itp4Obc1X
    +JF1NLqfdTlr83s4LHGRptwwNUMWGGI4jn9HCiBL7T3dKmmkMzUt3ZmcjZDimqCA
    maDoIxG8n0ZXJy5klQ3ry29T+/c3F40HDby7QjuCRouXrh54ZaX3lbi8mq+k5sJX
    pm4yLJR/TW/MCbU5avPKF5vq0Ki8vV6rhGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524681444;
    bh=NGi9lMCF3WLyhoHQXpSB66jmcZOTP1Ywj56fo6+kA0M=; b=Z8ZKFcprv+Xt
    /rV3C4DAji2d9EpYQM5kwRo6di73gaF0z/etgiEPRWYK9Dptem9HL1AmIbN5G/Wh
    7eTO2U3Q2aX0fx4OFGTGc6a+KcEBs5QDdhzwpBh/g/gggID5D9F5G9KGU5Zdh6mK
    uj+gY0TG6bHeZk8qWjk9y0X/y+1yXBtIomfAd/nXSPDmza0/NW9bIBPlbH/5VXHN
    Q+4goAUVUr6TUMjh3zCxsyHHdYlzJ08LuKFiGOlGuph/4k6vr4shcGhtE+PSG66L
    Gt9FtzQxpfiNnAPpCJnrfnW7ZmotJ69Pa+kOVMG3k6dgJrqdPh8ILrjItR+dk68y
    VQOgQamgLg==
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
X-CM-Envelope: MS4wfGJOrP3Vt0nioS//1Dj/+2WogBtIWN3Duqjn3ParsAo/FxJDZ6IArDDiR5Q7JahQqpDG5MeyEZIcu/tXElwk4sdpnYog8dE4AkZiGC7W2c28KU7lZseV
    DgnEzmh2aZKqDpICucbs3NvlvTnjB7bT2pTPX+1g0DSp7mlN8HTSLCWT06kNifOtliLVemklIrk3/U/HyrrTqff4oh3maQakwZT3LBWPWmuSx16VPxMkRQSE
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=viYhoEuuK30A:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756208AbeDYShI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 14:37:08 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:42728 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756071AbeDYShF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 14:37:05 -0400
Subject: Re: [PATCH 4.14 000/183] 4.14.37-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180425103242.532713678@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <2f8ccf4c-5180-1a20-b3df-fa21d3688f0b@kernel.org>
Date: Wed, 25 Apr 2018 12:36:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/25/2018 04:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.37 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Apr 27 10:32:04 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.37-rc1.gz
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
