Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2542822-1518732036-2-11611487064431248748
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
    t=1518732035; b=BrWOJjc3v+hoz8WT0PwANNsPQZ6JtCQ2X/lgmCV/mzIekgp
    +s6brV5ddO48lvxIpWv1PSdR7k3pDztXXQlaFZ2xmFgPoMP8QgkQWF/daq7v9Usm
    ntg+z/gv9UnTczf/FfJUcCQ4psALW8VjR1UUWiq+es6FU/7C9Yrz8CJJiLe/8qUe
    Og8NwGOLdKH3QffuA5yAJvTnu3l9HZGViJBu4QW7IgkJPY9Q+V+9XIXv16zSSEXG
    0l4nPUVW+Wd5Ut8yRRcaba8yjpmGmViNMQGsXg7KrViqAC++MjnQ+Z6vusjzNTAi
    udiSSfYseB/ixel5op7j/p2a3H7BxrfsZYdpv6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518732035; bh=0ipapKe0S0Rjj8bebjXMIZ6RsLYXWVRobl0WlHrA9+c=; b=t
    PJCFRcOgDtAAzwVvOwitF4ebU/AfCIUlhu02ndRdrczaDTXLsJzeTezYuYaltT6/
    oVzYULTzGo0Ac38lwjlVbppAPYCdzP0D992Gaw3YBbPIydKtaDVnjPVVS3ZALTY9
    gBbhZOpBkW1SG9aTtYwJuytNgknK8Q8W4ytIuYdangR2178sZmqAPYLO6tJI+ltV
    /E8NNiTn33cqyDGCxZMr+Bg2Ba9tuI8qz+jJJ9FsgY+Y6xXxHesokUFg/7+MYJu3
    C8vZu1Tvsp1WOupRImA2HSQMqxIWKPXwSHo257mzuj+N6VeNycViS9tfkjpYNG2F
    YuOJj3sRJ1QqAQfLoVsIw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756138AbeBOWAc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 17:00:32 -0500
Received: from osg.samsung.com ([64.30.133.232]:40651 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752227AbeBOWAc (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 15 Feb 2018 17:00:32 -0500
Subject: Re: [PATCH 4.4 000/108] 4.4.116-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180215151222.267507937@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <ddc1d813-ce5b-e45e-27ee-c1d170878425@osg.samsung.com>
Date: Thu, 15 Feb 2018 15:00:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/15/2018 08:15 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.116 release.
> There are 108 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Feb 17 15:11:36 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.116-rc1.gz
> or in the git tree and branch at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted ob my test system. No dmesg regressions.

thanks,
-- Shuah
