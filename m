Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3546296-1525201616-2-2033812303741600668
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
    1525201616; b=XjKRA9yyVaM3q/F/rZLRmuN5RdAHsjaVqd/uZG3MK36Al+5wIn
    RQe5V5kcHwX0FNAK35SlRK7UFqN5K89r7ueSmRBmLUAKMkJigRRKkYdY3sTb6S42
    RiNR9TPHMls6Kf/7W7Op0oMDbvUWBwHildQgVyQTYh655j0I5BY3Ay3r0CdweoWx
    OVgJzgz/b+OBjonMYqvaIMyuoHvwlLxjQ4skxAQ5MKcc+lu2TyMIVifFpoOjtnJL
    UXJxfzfZd7iC5siY6NElqDLYiZnGBo/yEhTY9TXZb06Tu18/fXYpZsA5s9rqogPk
    SZPhafb07IBKBGxdcPqRuGAUnc1Etxm1dOow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525201616;
    bh=pB4Gr29rWqsSa4CgyTpUHZRHQJklcKXXKmk8UVr+7r4=; b=beICeDeU7dlM
    t6EbHG59tHEgb6/SZz8O1vneRDFzeYtv1T4RNCrE9g+mb/U4YidaLS/rj4rPMVgp
    oxpJ1RiH/EdLUEJViZt1kwxF7oDiWRqAKGoKq9cEXRLO+ImhFXY/RKvS73stwudd
    Qay3aHLIKNb6pIBVKo+kXwREE6Jjy3K6E/dziDc/qOreS2n2Pn0LSpd/0+x2pgAd
    VUDuacLcGZ5y8GdaK24oLgs0TQJQHuMsy538GBonMJy7DJPOngC/83qZJiPBcjV2
    nOz/2hSAfO+rHf1YBVYEkxOBCKCR+wLXZJFDk11yRFVxtuQNHhpRfTfq2bAuFl72
    j/7I/rX6Xw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAdjfGJKcp3w/F2XbKVuAEzQpKp5NySe9Xn15BuvhOthylDQW5dFyUpgHvwHSb3ah4wKq163zzofc/pzHXoWWoEkhn+LCDFbsdiF30dq1TtGwaF5DFYY
    AgfNs6ddYJUk5+uIy5FlMbkyUEqwdRyD8Y4TqRjsxa2S85jRIRSpvKScc0YbYWnIseifBj8QzPaKHzLhASbU5JNvL42IbqkbCZqcC1K/t6um3kQUw89WYQz+
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=E1qZANYqsVcA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754443AbeEATGy (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 15:06:54 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:58156 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752034AbeEATGy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 May 2018 15:06:54 -0400
Subject: Re: [PATCH 4.14 00/91] 4.14.39-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180430184004.216234025@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <74faad01-66da-50e3-8bcc-fffa1b2ac68d@kernel.org>
Date: Tue, 1 May 2018 13:06:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/30/2018 01:23 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.39 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May  2 18:39:37 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.39-rc1.gz
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
