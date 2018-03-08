Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2076409-1520518937-2-668616808295043608
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
    t=1520518936; b=P2s3LYjufeWE4oQ/u64OEJ1ht5x5JXcKDKLt9H7MAeLP+qe
    xugL4vb/Pp0JSGeDrYKpUohSFB9znstAQOsMCYatsu1pOAsH9MrT/K/nSxlkuiT8
    0A0tsk1vh/oKuxPeeiako1hj5oVwOQlx39TXJQHsijmz2AsxFgbor4JTfvZIyV0u
    VDTXIjFEq1RopZ5cwXh3kdojlTFX6mM0zsX8ic+fRCyx3d7DLa+a5PI0wLDJb63i
    7TWqn2SUwrWYm/YJ+Gs2J4voGWsmR41qAr48lQmuGlXXQvDhV6w44yoOy4I7Cqsr
    fpz7OK2Fczud1n2gtD4HHkLSR3bLnqPq5c0jktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520518936; bh=vAcd/MFqCr91jdNM7p5iSkQh3HB7VKLY8qMTVE+Kur0=; b=Z
    rNkfe+B9sL8ke9KyRNs60Idpx0DBunE8WDL1VmeexjiREi/Dof0SodpT6YzbOG8T
    18cbRztpkkKvG+fOaJo3CbiM8vRq4qAUWkGF3uj9KtuPrgxt7DvR6XTEYpypkD+C
    i1r5oTg6fzKFLgBv0ciV63G6kE1izFu0zDd5bdeBcCntNXV7hjGs6IDiPw5P+goU
    meHcRJdhx9NUUD8kZ3tugq82XNPl4g75U3k5dm/QzABhnBwbxHr4x6bUi4vRuowc
    w4Tpr+jHDU4aSt2p8DbIIvWr8I+gjiQHEpsC1TOnHMLtDQ6GACh7HUzhvmuvO+7G
    QEEnsfXhqYh2QgJKcIrfg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=o1vUdbkP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=a+SENs/E;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=o1vUdbkP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=a+SENs/E;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755625AbeCHOWO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 09:22:14 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33513 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755259AbeCHOWN (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 09:22:13 -0500
X-Google-Smtp-Source: AG47ELuf5mxn999PDFVULYagafMgV59dx38VBxGMfLySFVsX9zxDhawavh9r7AKtjK04oJ1ntxE1fA==
Subject: Re: [PATCH 4.14 000/110] 4.14.25-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180307191039.748351103@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <b9f9d4af-3924-2862-9790-bb67f6186759@roeck-us.net>
Date: Thu, 8 Mar 2018 06:22:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/07/2018 11:37 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.25 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Mar  9 19:10:03 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
