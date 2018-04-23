Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1812140-1524519571-2-18354768746825974399
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
    1524519571; b=v1Emql+rSMrbb0rfw1tggMcY1NhpLVnGG9fwoFHDfpxLeC3QoO
    ICgmuAQabf0NAS7/kc4ZSjpZ9h+xdjqfaIXhFPn/haaLrWZBvo+Va0Nk05JbcFgW
    p2VCQUBdcl4A0fdbXLBmqQfMmg9ydI7x5WVe1GC3W5h+Y5xYL8Vj/6Dg1hOhzuvd
    Ct89WGNMvds9xPP47ylEkBNBNn2NAaFlmy3VZD3aZZsGQ8U+gJ/IPX3S27LOtWxb
    OAJdBIxzXehgjA3sSBAVgRY+uE3UTvGEOsooNtiaT1skXBUqa0wPy0013qCgTuld
    iwsyYorWVzRaKTK0HL5qJGIryBP/p0r9QEcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524519571;
    bh=vCQ/+Ra41GxUFp3TKLg1VEDQA5GvLbu17IOY7iracZo=; b=QsrBVB3RPLP/
    V64S0weVsshSwOzJi9eFMGJWRnBPoR53JBtl2O5P+Fszl4WmFz/smAC2Vrgjy+Ac
    RHGJrD22D/cmjoggZ64r/NUC+jtOQHkLidhcdv0eCkyCaBRrecKUdcuEwkGc2nvU
    mKE4MFb4irNcwInf6+mghCOUg2eMdaR8h1qK73gBkSmQ4p7jTFVAVxPYGaBXnakb
    2iWefj9NpGoVdMMDROmh7fLNvHZfBPFrlxZoDa/rHkgkzRT2+EXihvs2kBniKp58
    ttjjYYpC8ec0nOjXMm77jYeKs8229RJ0vdXvnFHBLIIL7YuBVDopKMWKtVhgsYpX
    06l2jSbbJA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfL7HynenL/aXI0EluhP+WPCiFd73L8WEgNJUsL1y43qyQJUuwcVPGCUWChLiB4os0eCajPzMk1Cne90wS8ggNPYBdY7Y/VQRfblkk2hcuWR34YPo6fhW
    d7Xmt6LjrUGMxerthTWEWH/joKXrkRN+2AhrRPHcgEWN4+XXKkG/7E5SxhV4HJs61ETYmlTGQPz74Um6fBDBoLR7Dhno3oNW/UEE1g1mTCGHNhw346aVu/Fg
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=BKw5nfpAfisA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932396AbeDWVi6 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 17:38:58 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:38607 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932484AbeDWViz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 17:38:55 -0400
Subject: Re: [PATCH 4.4 00/97] 4.4.129-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180422135304.577223025@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <4eae178d-aaed-3748-6f6b-965b69bfbf71@kernel.org>
Date: Mon, 23 Apr 2018 15:38:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/22/2018 07:52 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.129 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Apr 24 13:52:47 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.129-rc1.gz
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
