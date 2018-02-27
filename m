Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-20975-1519692846-2-16009654849227444731
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
    t=1519692846; b=Z+Gq9xxULsHiwFU0qD4FnWLGdk9A8hZj4rs2bfTYpU430S/
    Mo+h+doYwU++CbcS4m2Ed3vst/gkCjJI8ew9A6V1o6sMW5KUbHKxwJzqoI6vUsXx
    Qs86cunKKWdaRwmNdnLbK9UMPqlOefEWATTmM+JguSXL/VU3fPQJpFB5nRcs7iDj
    7BYFEswAr1e2EwlIYR8pDRlM/hXZP4MD09Xg4xVcZ3nZrb5WIu3l8xKus3K37Cjl
    rAzV55pGvOfh3PGM3ZooLBri7kWZ7mHNuEs434CsUGslyhViqMyDFOFN7frDDyAg
    acYr9kZRN03yeKnLu5LtaDe0M/bkXLKzOmRtdMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519692846; bh=mE3+PXAh9JogKS+Cl2JWAJMr7a20GIVGl3gNkdNr65o=; b=i
    qEkX//RwRfhvbk5Rtaac9tdQQR98ozqKpoFRmmr/hgKNYiLlAAWXb5DvT4qR1kfC
    zAayNjTfWHOvZ8njKz4zowojfHo5m+AquA44o/zhtju/grKv+oZ3HIQjZWeWCsfS
    P5beTmMq58LMdGcwMUDDAbbYfPpS74UvH+vqBRP+dVU/XOIoJojaIgR0oJtJ4W4m
    yRAiy0VyABTWr0/2rPivmjC8ZbrYy391DnF+rM1PpSq3TRFiOwJsbcEpA8fY+J0m
    AYu9ynnARn1fafCJ62AyhpgxXWX032yD7UuYRzVKQrtdP7LG0NSJjDUy/1w7TAez
    gaQkbRNa0kN8UFUoxCFSw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbeB0AyC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 19:54:02 -0500
Received: from osg.samsung.com ([64.30.133.232]:62696 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751539AbeB0AyC (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 26 Feb 2018 19:54:02 -0500
Subject: Re: [PATCH 3.18 00/13] 3.18.97-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180226201527.242286068@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <537aac22-5621-2140-aa78-1d7f235a6924@osg.samsung.com>
Date: Mon, 26 Feb 2018 17:53:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226201527.242286068@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/26/2018 01:15 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.97 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 28 20:15:12 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.97-rc1.gz
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
