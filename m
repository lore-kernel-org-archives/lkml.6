Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1986038-1524530507-2-1433502397804604815
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
    1524530507; b=cD1zYcIpW/nxunpfanB5Fj5juj2hALECLCzUX2SqITyOuihAKH
    9YFN6y+isOOytP/RL+DgY2w4dd43F9+3BCa0ehVGRtt1kS7SSPxRcx/hVnCoBRKC
    LQoLR5AsZM2Yrfa8D/hmC6WqYcVqtAY834LzqCrE0JgtNrmaHKhOzA5WwCDGSlkA
    Q9sm9g1oBMi5hx80DkssN2Q+eXsM/hlx/d4NUPYW8RNbZWDKCFXsyI6ChsPGCSUE
    M2oh0VdcbD6dJTV+/RIxoWOHz0JQPtW+BWz17lUvwnAdsT7Z99EWKba/OhZaz7GV
    bhCwZnSNEfHWYoF9joZKDMACVk6rkQC/bGrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524530507;
    bh=KSh5szznXH+7srm9Mwrg3fTcbgX8G/NgiYmNFzHEKTw=; b=jFA0vzblx7DX
    1Ss0dZSf3jkrtSXUons/uHB4F2UoHQkjzdaVAipUsQLQYIfd/QSeRwUj4mX/YS+K
    Tv/3ta2rVFvjPq06YroRVl1Ue2C8KoMEmVnkZplQLtP90arxuHXD8dMX97QkxMES
    mN6Jc9CqBbyqSVVM9uDey4f3rxeK+aL8D7scZLhZ0MDFkHjp0IQIQToEReEUGYQ+
    6rqTYuQCPQgGDVfFGOnHU3Ud/dQ96bWAufcw/RqBJP3eDUGieDNsQ8OltUc+/SEJ
    GG5EYaHTax2cZ6AiOu6LorM7Yvmq0/ZH0FYjhyjSE3w0+7H4YP32z1kxvXUDFSWp
    77m4L18G4w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfGgoJcTL2H11Vct1D4nlQ8k8wPzOXaCz8XVv18ZEP4tqK0FmYcy5aOEUoU88DsJCVZo7wcAJBhD6ZL/eWZGFmzMr1ba3wm8bt37tCEZ3Iv5wHrBw2rff
    X9j8URuzK2iV/KjLja6oaUmhsMJoET8sDMHlqvC/qKDS5AHct/107iV8GuJkrjPlumdsQsbQumkO95lzlYaS/GXJOpgQJZUSnQap8TzzrpAyeysAhaspE74a
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=RMlRvZAwo0AA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=wV1J1nbwTEn18NIYiJoA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932635AbeDXAlo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 20:41:44 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:44997 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932624AbeDXAln (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 20:41:43 -0400
Subject: Re: [PATCH 4.9 00/95] 4.9.96-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180422135210.432103639@linuxfoundation.org>
 <20180423180410.GC27081@kroah.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <d29ad47d-333d-3c0c-21dc-cfcdcf62a54d@kernel.org>
Date: Mon, 23 Apr 2018 18:41:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423180410.GC27081@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/23/2018 12:04 PM, Greg Kroah-Hartman wrote:
> On Sun, Apr 22, 2018 at 03:52:29PM +0200, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 4.9.96 release.
>> There are 95 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Tue Apr 24 13:51:53 UTC 2018.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.96-rc1.gz
>> or in the git tree and branch at:
>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
>> and the diffstat can be found below.
> 
> And there is a -rc3 for this tree as well now out:
>  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.96-rc3.gz
> 
> thanks,
> 
> greg k-h
> 

rc3 looks good. Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
