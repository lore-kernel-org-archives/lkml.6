Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2531373-1520026233-2-9088216804526599792
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
    t=1520026233; b=rY9QBv+ckQNhtyxwniJ0jjcrvLW/2e94EROjv6mxfGZOrB5
    YeDSMCpXRzs/pts1CsiGugp8eHw61v3IpnG5AG1PZaaq36bE3Ow2dLcH8P2+KZ2u
    T7a9WJglAXEGKq8Q4gYn2h0vIvhOukxPvWXS/+DsxJeQsYC/3cYSOm9urMDWZFJu
    bA4eoKLq2qVG8408XlRcMHId4i9rvNLi4/CrYBCUdX5MhxVx1AwJjK8O8P4I15tB
    wnGzWYU9ayEfk3kD8lweAK6IC9XcGx/nsfLeBXOE02VR0VAwm9xfEIl6ouLVIcPA
    q10TyS0oSEMJWNFUjaGguu8HrlSzKDqhg9t9Wkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520026233; bh=RSl6vDrXlS4r1HdQqICZOZZ3IpJ/3+LP7WlROAk+SlQ=; b=a
    fcYt8yiTI51Mi6Q3TvYdqTgczVOIgB7825G8arW4H6Ru4iunpUlzw5vIXUvznpUT
    abR0c7fCDOVuoJRYlCAv8G1veWz9IlISxHdp9X1s/c0t6ROu6GA24JGI3vTQ7oFs
    gb9HdvExX5e7n+DiYr598ldB2T0peN+6lcnPUojRxG1JWt4JyFfdfPw1n0vnYPCp
    gaKbnpLHcfwuJ+Saw6Dsnz083pxagSRlH1LbKc1kB4lXp8C6cpQ22nKuyEg2QfF3
    C9JDFxFVRlPOdMlJJUGMHsy3H9/4D1z7bBhIv5lCB7JMq68ShAtTDC6HhfisZmy2
    nqBXan0GlH6oG56ieCczg==
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
        id S933916AbeCBVac (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 16:30:32 -0500
Received: from osg.samsung.com ([64.30.133.232]:35521 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933687AbeCBVab (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 16:30:31 -0500
Subject: Re: [PATCH 4.4 00/34] 4.4.120-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180302084435.842679610@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <0281f9c4-462b-4270-3f03-6a5630352d15@osg.samsung.com>
Date: Fri, 2 Mar 2018 14:30:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/02/2018 01:50 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.120 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar  4 08:44:20 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.120-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
