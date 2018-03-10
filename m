Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2238391-1520659079-2-77573966234133983
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
    t=1520659078; b=W1qxk2YF8gEMffBcbdecOgpfxrrSuIXRQPzLVeJ2eN7f3O9
    L6MgtafltT4A2m8DMfKa3bQNg26DICofPIdweepatTAqg4auT6oUK/8+0TrPvseN
    bGlfTa44ioDfc5S6Tc/a8Xf63JBnE94nJi2XhtPY2MYO3CtpDNvztAc/yBr6qNgc
    l41TvnODSFtUXMzf6jYqJdjl2mIaalT50Op4lUI2fhhJ2u8MPggqMbHVnYZGpqq/
    xJIl0pppcm4TkS1iQZSlvtQGx7Z/53M5C7zSm+y53UlmPkonwcXLlRbnBtCzXYZI
    vqhHyjEg1yIoHAz41vSWL99ef8qEBrfp2iTikTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520659078; bh=8OF8/3dikfkHXDE0f1SrEzzmnjyYz+55Rs0hI9ufiG8=; b=a
    cI6cdZzL8sisYcemwOIVEgW9UgksJZDVE9qHj7wR4qJmJ4nDflmY48RhpssGw/oq
    uHeJDY/QYhPyIrwLMpKVpq36EtiJYL8WI43J5B6Cv3geL5N/9Jprhr8odGO5JqNh
    Xbkg09ko4UQQWOL3S0A4FjnzJGMul0j9gzzO1u+P4Oo5NlVS4xW2vM3WXNSCvBFg
    KzlLBU50Q/GKjYxmpkgdOAmujO7pbHsq8SJg7X/XQyn+de3m+08IZ5KkX1iC3M0/
    vkax1RnulKoIkLjiMA9KOZUPjBJBMNAucSFG8VHK1ysCHkWz55el4J/6V560HiuS
    d0FqW2/3lJ7SwLYcEjnhQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750795AbeCJFR5 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Mar 2018 00:17:57 -0500
Received: from osg.samsung.com ([64.30.133.232]:34355 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbeCJFR5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 10 Mar 2018 00:17:57 -0500
Subject: Re: [PATCH 3.18 00/21] 3.18.99-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180310001801.045114869@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <38d49da4-a7c0-037e-1cac-542c6520a5d1@osg.samsung.com>
Date: Fri, 9 Mar 2018 22:17:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310001801.045114869@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/09/2018 05:18 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.99 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon Mar 12 00:17:44 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.99-rc1.gz
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
