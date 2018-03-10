Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2238391-1520658997-2-8223358428921382725
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
    t=1520658996; b=nfpct1d3MeovWP9g8EKCyGdyihS+1pUlDNGaEwBDtlff/17
    zLJX3t84ynl6bMJUzM4+tMsAbHfPioud3aAOICcPdqol4eGrDstpUI7ru/OPL/JU
    ry+h1QSktD1lhtTssUvd+AMZ1jd1wtyyaYwZeEjho8kS68HOsKWQdBj1FAVFQobJ
    V7p6p4lVvx91W/I3TlCtaK5Wg/AF036shvbnPr0QJDluYOwA6WTB/Dh2JzsG7UqM
    KXWvdBdfhDqtLIiHwRXTULoEmi/oKhWoZySAsJMF+Nf/yVQLNjtzJhUbYUFF/kOk
    SPC93SvvSJfWaqCiGTlkRKeMQjOSCgmmxYdo5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520658996; bh=GIcDN8a05PKeiPCEZO+4uObghzHnGnxivEnNEJpMYUQ=; b=T
    4Y0cbyRqRYuV66tOydwu3YII9vbTlUSU6EHGf+egwgHy5TLKSjrb6KB5Evd0YOCA
    HkU7s4xbte1ZJ97eyWCn4+rnjaBFbhObiIRI0DckGR/7z3u4tSovSxKrq5O64c+f
    q8NrJZuK2yRW7sl/f3v7NWetF7HzsDtleeLv4wRAr1jraPPcuvwNvHRGfpFGhY2b
    aOfrjh/gkzGtgROqYzq2RAs+PiCrqz7nIx7rNwbMLAW7AX8MT0fr0ePrjrzmfCaX
    egR4wE8KzN7zRTKM69HVOXQbuAkHMQ266AVOgqiKJRNCvHGQHVE1NUKs0vOEmlEP
    bmqJUYituSKX5Z67bQNWg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
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
        id S1750714AbeCJFQf (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Mar 2018 00:16:35 -0500
Received: from osg.samsung.com ([64.30.133.232]:48357 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750703AbeCJFQe (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 10 Mar 2018 00:16:34 -0500
Subject: Re: [PATCH 4.4 00/36] 4.4.121-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180310001807.213987241@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <49e355f2-eaa5-ed9b-eb7d-fcefe7a83f1e@osg.samsung.com>
Date: Fri, 9 Mar 2018 22:16:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/09/2018 05:18 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.121 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon Mar 12 00:17:54 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.121-rc1.gz
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
