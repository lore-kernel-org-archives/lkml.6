Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3608093-1525201517-2-2906659791469231469
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
    1525201516; b=hgVTTpDmXA2yQOBmuQNtCxOta0DNARy81DjTlOw68fGuqKBEIN
    Mfi4R4zt1f/CDUiIH7uHYTBMa1F1HDpTYuqreAPCnsxYjfG2ZZSdVjIYkgmQsw8M
    +ViTPzOyQmofsAKvk/uByAsBEjedweBX8ACNDb88SWIK8wY3woJip7NKSDF4GVQr
    8pML5zC/4OVQZ1ccbxZFG8arWQzMqhNRFQOSNe61DHPv3WiS9gf5jUf2QXG79a/W
    9aX9qldM/Juoe+6dZmdfvZ+9gaB2/OwGsIKn/VG3OfDQsFKqVfE2oUTyoOHXFpuM
    w7xENmh0lWlOjgJqlhfpjOuePvLDyfx6JovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525201516;
    bh=W7W63wpCthRlLG25z8J2jkOwUDywECxpTSR+aS2yS6I=; b=nEKC2C8xzNx0
    8FgK45MQAzc9AdM3RIrwUFyTGbGGkn7tlLWstM7vq+mIYU2DOT1k+xFvyHEisAPK
    pJUmuE+c7hx+DZF7nfyaCjflUWcEBZmcWLlH10eb2vmLKOdafzJw+hzvkEs8JbDr
    rarnM/SU+6O3AgIn1kuo6qArct2XwL9tJqglPdm22/R+h5wOVyZv8LjNKd3MglN9
    WhpsxEhn28pk8FpyrTDo7nn1ARcb4wCeasrszcF3+44cgW6ZucHGjpd59AtBSKXi
    vRrL6nBeCFuxzk+X2t7IeRJq90tuYkJPP2lH/44tJe8YcnW3A0EqjySj5fd/0SqM
    Cm2dp3J4eA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfBFtZbC6l3znu6oACbeGwW68YzHBAK69R3zAiz7lHcU3ArAv0Y7ktblnVWX0veie9RNKmwYg8xpYdAvBhnoGi/8uNtqFDbgIG/xMERhWHt81sV4Bek07
    gQeCJJwTDu0PLqK2LO44yKRQcKbhJ/terkAECFp+bwgO67IXtxPj6jFZHSKqplgTKaJv1KB4t6fBUjcdNbjUvuYtrbEFgQYjiBSNCQ5R/2ihi8QnXa1gBTKg
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=vmN5MLnUJFoA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754907AbeEATFN (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 15:05:13 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:56583 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754790AbeEATFN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 May 2018 15:05:13 -0400
Subject: Re: [PATCH 3.18 00/25] 3.18.108-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180430183910.801976983@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <28967dc2-3515-27f1-086c-7b92e64264a0@kernel.org>
Date: Tue, 1 May 2018 13:04:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430183910.801976983@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/30/2018 01:23 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.108 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May  2 18:39:02 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.108-rc1.gz
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
