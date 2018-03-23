Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1790507-1521825541-2-7671717045832195131
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
    t=1521825540; b=r3Do16f/cdUEOmeSYABG/ZvCOEx2pu851/YXb22YwZL7F9o
    FrC/IRmHuSPqpvUQekTMA2xI30PSk/hpOuyYWnnKEbI20zke0XYtxas/erkSE1m8
    kJSMnG03yTSRvDTtXjpFqeqkX548TU/GX38hPTLf6s0ymTUA4wp6WTaihgJRxLZc
    dMko2iWEZx/PHYp4Qu1dNfyXj4YCFMmPJu0XGoQmTD+7ku75mFf1wzhCgL7xqXRI
    zsac74sK3oAwZT4ESEwok4ecuA2GH41FFGBJR60+E1Q7CZaHMhXkdQ/1ZnWuLy1a
    Y9l5pnnBFZEiW3LV7LZX0TC5+Tdy9IrfX3+Ivpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521825540; bh=iTJ2edWF/2nUQhDu4pw3M6fGtfuMv4kRQc2LzIi7k8c=; b=K
    QV2p4hao8nyfCcXkQOKKVcigH/mMmibiLBEeim8Uesha0a17lAZcOEXGgyj4gt8u
    OfOje0UQu6HLpf50WA9hutRdrSpPKUAG+7HRHHLvQF+lY2AVXwYMNLVdRixOzcDb
    fq9K+ib5vs8BQXYjYbaPPJ4G18pkrLcnKrJ9nIgj5LEL50ChLvoaN0dAPttVxZ5P
    2JX3V0AGh/otUroyOoheRkcuD2XJIvPnX4NN+UJOA4vpRE45+AlJjJkwvd0r6m5n
    JbpRb9hFFhBR49EfiZe++5zHX5lOoQwcrY/Bf+xRL0iwftDuyUuBzPBJsz8vBrbo
    ZYcCiT2HAxPB4knjQzJPw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Y8MU/+as x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bzccEanO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Y8MU/+as x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bzccEanO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeCWRSZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 13:18:25 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35923 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbeCWRSX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 13:18:23 -0400
X-Google-Smtp-Source: AG47ELtotZhjndwOWLh+6fsLFZWkbOJEWY3D9nf81L6xOWiDHj9Hbz9lfdzmn2AUbGbGBk8AMaP3ug==
Subject: Re: [PATCH 4.9 000/177] 4.9.90-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180323094205.090519271@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <38f8329c-79fc-c217-69df-4bb5dba024d2@roeck-us.net>
Date: Fri, 23 Mar 2018 10:18:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/23/2018 02:52 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.90 release.
> There are 177 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 25 09:41:28 UTC 2018.
> Anything received after that time might be too late.
> 

Partial results, build only.

Build results:
	total: 145 pass: 143 fail: 2
Failed builds:
	arm:allmodconfig
	arm64:allmodconfig

drivers/rtc/rtc-ac100.c:570:14: error: implicit declaration of function ‘devm_rtc_allocate_device'
drivers/rtc/rtc-ac100.c:599:8: error: implicit declaration of function ‘rtc_register_device’

Guenter
