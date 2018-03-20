Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1907187-1521567172-2-16331282643783247802
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
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
    t=1521567171; b=FRiq7jv50fuqK0iak5bDKhEWoa+Zy7uhLmP5Rlm71MFsh8N
    8VQ1c3KAQEFi5CF0zbXvH6YrbdwhzEaf04tBtQpXdO1dkp0JDcqkNnRJSnzjeqEG
    XFEF4TgVzfwaqS4BiwWeauR+JjDbFaf3u+YfZXZNBffu98A4H+jgEkUgt7lCY6fB
    NIzLt+cjRyuHVekauG3uZrVtRIShOcZowp31a6b+srhc1t4gmLO/lV9XlTP1B1dl
    TDW45AQLaNTBLIFnljFUNlUXznADrwaJ+E7Ue+uqHvVszuXxQrpHUnr3C+ST6uGC
    srSR7S0jtvIwg7YL9ztqxqSx1/jgX4yTs0dP8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521567171; bh=4f5+kd8mMzWk1nZ1Ru4z5trSYgOAlPHLBabOgkqHsCU=; b=n
    bUCHFnmOMMiddl9RNZ0ggcR8rIAtX5mre7EPRXwFkv5OuXrS51X5PivrIgoORcTk
    pOLnF6LF3+jeYGAP21UIWgKHqxlWNWj3eK59DxDDCwmjeZ0hOm7IpwCPKO0YR6RU
    /A+mRUSGsN8uHiXOZ1w9lrzjSeLgss6NgyJ//XUoR9iaI55zlewhRv7XAQLuDqhS
    Qi/WgGGj6V9LM4W5V/P4xMML7Z/GT/mACm18e0F2V2nmwqFwJvp8VldkpVPw3a7H
    3zLJpIIyc5BS/rn1vTigGcoeNoSKB8pRXlrtNhRUJKcGvhMNRQ8T1CrrgK1UbSlG
    g4OwJEdQ1EP/21IHhdSYg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbeCTRct (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 13:32:49 -0400
Received: from osg.samsung.com ([64.30.133.232]:34062 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbeCTRct (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 20 Mar 2018 13:32:49 -0400
Subject: Re: [PATCH 4.9 000/241] 4.9.89-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180319180751.172155436@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <0c0b6fa6-5cfa-8e0a-2ae6-117ce25ddb75@osg.samsung.com>
Date: Tue, 20 Mar 2018 11:32:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/19/2018 12:04 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.89 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 21 18:07:03 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.89-rc1.gz
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
