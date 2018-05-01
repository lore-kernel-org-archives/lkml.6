Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3608093-1525201568-2-5036315654066391903
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
    1525201568; b=VjA/EEc3wqa4Bu+Lto/HfXS+xCn/7R9QXWrZfvYPm96Qx045JG
    RM+zhrdIgqWaseyaQzmQLmZwCm5PVVd558F0dGGg5GYVi+Aegf0NqrJToO+/shGd
    ZqaHM6R3w1ZXZgMKKW6kqWC3VW8t8G3TZ1OsheCuH74w05LmqcCRWSCi9UbNmowV
    QuuQbRDQm6C84hJPBJduxQToI3tAINj2kP/kc2GJDGceVlpJ9oDjlJuwBvroE6kY
    Tm+/NxvVAIYf9d+lbRMKckuFzw4CAx9ZcEgTZGI//WZj8HDDztL/xzaQbOb4TjDd
    ypz3KdPZvRBQPOYdr2wEqdpQEw+j5+0CinSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525201568;
    bh=aues/1Cc2VUdoJSqSdThjvyXT9WYGYa56CUtdbo7szo=; b=Ak1UJpZyevtM
    1v+pMkmGZdbLHaAes/xlG/ExpVi7gSaK7OuqZTfmRqU/X6KpnvIMne9mJL/SFI9q
    jAvor2Y/26yi4/LmvLqukznk0Pv9Jv317LSo1QDLTP0lgS1JEuJBQ6+0mw9GidPu
    qWvkXG/u7y9XBSxQOoZSN/2aXwZyOShwDh3uoAV7vSryWhDYcZ27dgfwbsLCPuau
    2zi4q0VqgCTJ6C74ylox68UAltG3TQ3N2YGeDN3xlUQk5Ckbx2MrjZCC9fehAq7u
    MTxXlOVrmanhrXn1serX7TZOWE9r0N+PxZy/shzKrHlxWy3fyhR7F0cF5co8Z2BE
    lRxRaODjgQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfB8yzGkVxV/xRzUxoVV0cofc8+5FGub5o9Wo//JpBUk+DqCpR0peu0Z9hzrBy65B19iJeCHmPuE8VWZtEdMPmJREg/HW1ZH2/oipodJ7Z0SrxBpRt3sN
    f0e6HNhdzly+Bo0++dgOV+P1dGHLFGCKK+kkQRVkn6a2wRnKYDivupBJp9iSzYYnbhBaiW+BihsrlgPFhWKzxe/o6Ay6FXLFgbl38tHLNGHpHh5X1GspgAUT
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=keWkJgPOSacA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755539AbeEATGF (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 15:06:05 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:58122 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754443AbeEATGF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 May 2018 15:06:05 -0400
Subject: Re: [PATCH 4.16 000/113] 4.16.7-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180430184015.043892819@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <b90d38b4-4055-2ca4-a716-86bd57bbe98c@kernel.org>
Date: Tue, 1 May 2018 13:05:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/30/2018 01:23 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.7 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May  2 18:39:46 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
