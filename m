Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3628101-1525823784-2-7977831556939768351
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525823783; b=Uik53UQpubKvIQ59RdaKdrm3DD0aV9EtBt9ycf2zSB7JS6N4zX
    6f2p6xq83f9Uew0tReQ1b/ek8KGhFtqBtGIx84C30nE+ccxxPX1wluP8nkMiQNpi
    HLTTB2mwXWc7qFudF3b1AphHrrvnLY7hm1cLFJWFFBiv85lO6udU/lyG9JXv0NyM
    zexnEUauocBBAO7HkgOT1SVcY8785UpPRtpOmxyAzRu/l5WyWEA3KcpDau2f5u8I
    EVB9Bt95O+a89dv7/5cu2R9GzWL7gr42K2U+b5UsYE4POiXx7bgmGVJxx5jF5brN
    BsXJkTakiIyM0n6uiWKIsB9owjFkJjuqQ6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525823783;
    bh=j78Z3mvbpR4TXbeFeMhOk368ln/E4tGgkN1tvw8Sctw=; b=Lg3hGqYuglFk
    9IzwC3rOB+ecR4cvy+OTSx7af/jbLYRWzodFqnYiE6zJNNzlpYMGCAuKkdEBlW3t
    MRBswpzXzgYmFX54IPGn7A7xpZ9fAQuYHUWP7mO/KsCfJvjZ9t9kfHCKVgUneWcX
    uHCaag6uW/WnXBUxfTsqZy/j8cY5a8eVAC6nQxPB4iyD0LRFZf+1tvNyk4jzywbH
    dVnG15xYYCIJPQe5rUe282YTkQezU18L09l8XgudLJmA6s+5ZFjbv5MtznG29MBx
    zZltnMV49Jef7idQJvt98RHh62Il+rX1tnsVy849izyga6cKxyWkuJJwNAf5+J6+
    KUnnxYIEzg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
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
X-CM-Envelope: MS4wfGYslx/xqvGkSQhbnubsXke5v++eIISamqvaawrPwNrifn2ALqDRbylXm9dwn2+1T5OOG0HDKZbeWm0bPvLCihexA2iwKj/ZixO0B7dor6IUqOnHYGHU
    j32FyCBf81VJ5ltgB+bMsdIEmCEBXgjEe887xVkV0ICwxsZf47MLvhUrWX3z4e03ipLp6zCGYiuPcyO0R/HEGepKyFvwpLV5oAHrIA2OaM2q44LquWhOI6gA
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=_GnF6dH6mMMA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932654AbeEHX4V (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 19:56:21 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:45435 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932475AbeEHX4U (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 May 2018 19:56:20 -0400
Subject: Re: [PATCH 4.9 00/32] 4.9.99-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180508074008.800421598@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <fb5f52fc-d5d0-f03d-a47c-3f93dac55b81@kernel.org>
Date: Tue, 8 May 2018 17:56:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/08/2018 02:10 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.99 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu May 10 07:39:44 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.99-rc1.gz
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
