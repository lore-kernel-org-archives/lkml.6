Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1963263-1519494857-2-17955695291524047510
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519494856; b=mJlv/w5gDqFruI+ZEPCffwJJLJBG9OKeCgITbZ/84586h0a
    DxhUz9KKEpRZk9pZLwZYNl5dcDPEH7CXB9aXO33yGYFJb0nhG6uLmonH229LVw98
    kyXBNeYjQd/SV2qzP9KSz4QPAwBMki9hu01L0ZP4K1tw2Yetje0H1DBk5SARKOcz
    4omafX0gaj7oDcfWmD3VgPbuNlgCeBzwItSQxTQgdZs6PT4fD75BlnwHwtcoE3DN
    skG8qKz5X140XLtkRzqhRol1BehitmpHrufyttVv8ze8BcDoROaO3dh501rR5fkz
    5orAw3IDKUr+blHbnIUoFd9ECcTXui4tIHR4ZQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519494856; bh=M2RWsbOXpT5EhAq/qNfNuKrV7SYOR5dXrOEK3+naaus=; b=v
    Hf2HwpbjXtfkj1BDuQUCs2F7lmLASYzqcy8arZcLGNvurReiQvO70Vs09nSlh+mD
    2yJma/QE/8wPA7QtfvfHKE0V9cgpqtzp4MSlk0uBYpnVK300/ZHeK6uXVVhxkuwc
    eJ8J708oHaq7mOn8dTg0XANhDqlnfIqACE3f5Jh8DJb3STXLW89T53fKy6N6bjmO
    fLokhZDqhg+m5Nf92Hde1gPQ/sCwZDKT1oFZEuVh1txj43bT7jG1IUoECXWok3E9
    nvrxf5NQj+jp9kxXlBASpWNS6Q0wbGw27bU8qks7nJ98vuPtAZ15Xxf2mMj1NWiD
    a+MYHAv9fBU38g9hCrfMQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fYAoWk3L x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pEI7o9K0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fYAoWk3L x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pEI7o9K0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbeBXRyN (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Feb 2018 12:54:13 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37615 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbeBXRyM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 24 Feb 2018 12:54:12 -0500
X-Google-Smtp-Source: AH8x225wd/ZKVmBAm9dQkg93gVvOpFvMykN48QVFIMnEkEOYC7lCy7vXEmqzznUDr40fUfzorn74wQ==
Subject: Re: [PATCH 3.18 00/58] 3.18.96-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180223170206.724655284@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <eb7629a3-aefc-15ba-bffa-87d5e6b4956d@roeck-us.net>
Date: Sat, 24 Feb 2018 09:54:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/23/2018 10:25 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.96 release.
> There are 58 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb 25 17:01:41 UTC 2018.
> Anything received after that time might be too late.
> 

For v3.18.95-57-g6b94779:

Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 112 pass: 112 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
