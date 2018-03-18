Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1222381-1521412786-2-3597729146269865448
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521412785; b=akCyZS2S9M3ABSjdfvxBljGZktqpzBWEPgBxxWuXt/5wFco
    PbSu4hJwzHz4p3k3FWrLgTcaKebmAWgAALij/+uFgAdgxrvFER8GkEgvaMj87//p
    YtiUHkslLuuhdyqgFJwcxIUwzfrDWOepW8Gxt9rVmF7qX3qCeIVff9lhYy4H8su1
    Uk/59NSUiq4Nk5TTtiqFLUyf/NHummitZYtODIsxLPuNdddNGTSdnaI8X2PrQ4Bj
    DJ1FgV2tnOi+vSLpxwr0iwVp4ON1YBepjHbmmhN8iG5oe1BQ871J4qTiqwjt7s/v
    CYL8wj/3SIUWu2D47XuRr0MvjVW9zypbTLpxugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521412785; bh=3AD3y7/4adWifHEwNLyG64GKA5YwGqKEI1/ejmPnSVk=; b=K
    TU/TdGUyFrePBf0tlR/hnk6TKjET6z3AI8TxXNbjsd1sj1LjLm5u1SUVNmlYkuMq
    Crt3DOaabs9xbFlEoLbkO9wfM7YTrMlqw+y6qZQCwPGer9hWCrgPSLGhG18D1yJ/
    DJIQp3x8N7BSPRbkD5HaeGDqmXDdQcMsxg9witNAtOGBC0sYCufR8K4F8TU1GqjS
    tvK3xYYUDFUd+1fd60qRNeRw3Z6+CJxmlCLK+5lrFlOtQ3o3l0DssU0zXNx7SOpm
    SjdjVVdwxoY7ybf4+aUy8aiIblTyhqz7dImVy77G4hNvT/6KbmGg3qkgog0Voz9/
    yb8tlK/fTAgo/Kve9JYYw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=YTFPF7qd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ksY+3TWp;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=YTFPF7qd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ksY+3TWp;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754354AbeCRWjm (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 18:39:42 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35931 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754026AbeCRWjl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Mar 2018 18:39:41 -0400
X-Google-Smtp-Source: AG47ELu1TWkTa0GE8qk3cXRo5r5hD8nlqOzABpCJlCBnw5DhE52+/cGOK3bjO2O5m13Dzc5cnRjxeg==
Subject: Re: [PATCH 4.14 000/109] 4.14.28-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180316152329.844663293@linuxfoundation.org>
 <20180318102454.GB30164@kroah.com> <20180318111442.GA4607@kroah.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <3113502c-0d76-e625-4216-03726117d05f@roeck-us.net>
Date: Sun, 18 Mar 2018 15:39:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180318111442.GA4607@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/18/2018 04:14 AM, Greg Kroah-Hartman wrote:
> On Sun, Mar 18, 2018 at 11:24:54AM +0100, Greg Kroah-Hartman wrote:
>> On Fri, Mar 16, 2018 at 04:22:29PM +0100, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 4.14.28 release.
>>> There are 109 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Sun Mar 18 15:22:53 UTC 2018.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.28-rc1.gz
>>> or in the git tree and branch at:
>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
>>> and the diffstat can be found below.
>>
>> -rc2 is out to fix a build problem on some configs:
>>   	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.28-rc2.gz
> 
> Ok, that sucked, let's try this again...
> 
> -rc3 is out, and this time it at least passed _my_ build tests:
>    	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.28-rc3.gz
> 

For v4.14.27-108-gde586f0:

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Guenter
