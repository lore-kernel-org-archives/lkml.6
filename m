Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3092874-1525379121-2-13999872142153514233
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='dk',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525379119; b=AmSDvaC1rj0D3LKV9Pke73Tbp817Utw+AAdA/aA52IR2NuUZgm
    +K/prkvBHOup0YoEfc3HA7Mgks4ETYnbNxVNISOKnmwpOEvbVFi8cHArk6BIC8aT
    Ee4pM4JcLA+HTp/xuXW9Sbu85uEKNhDHMUPq7GcrLjQIo0h/ZOuQGzv2FiMMUxgY
    Y4jb0+NGLq3nIAkLsf7pyD9HfG+ZJOkhgSJkZsXg8uSCyUrWXYVMPpE1UVzdXgbO
    Cx7//ctC1WCG2uIldC91eNuWxG/ozAsUhgCgsAf8X2QNdaR1HbyMVFtacSAooaen
    XIKeVd7QgO3A8fAbwwpFlAt0nSkpLymfA5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525379119;
    bh=mZuvvKpBloZALj9Q+qMdL1uv2rtPw15vNyJFogHmk30=; b=Xg+5+w128PQ4
    j7BI5wZsb4sVI7meJajdUBntft/IIAZAnx0vyaO3dwblb+FVo6jXJK49XJM8y0JD
    2V17sPClbrq1oaGDoRo8Qz9s0MYsHLZ8fDjkJ70ipNdVqbfRYMps5ldQGTP8lQWC
    Qb9lFbNfC6qUpr4jeefZqe8l3fWIA7ymwBDpXvtjrLYMhl7nA7R82SXcMHPpd20E
    a0ftLkk2pmZowGkkh+fWcPvRNnExXbNktC0aXso58KZxbxhXbyxKcaA2uccPg4Lg
    X+5L/dDZvtyZVrDllMvfv72AeRKbvIo5S/XJjSyPg0OoxxLjlJ0AUoxh5vBpA6UE
    Ri49xSuL1g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=kernel-dk.20150623.gappssmtp.com
    header.i=@kernel-dk.20150623.gappssmtp.com header.b=LKcTLFZN
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=BjIo3Czw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.dk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=kernel-dk.20150623.gappssmtp.com
      header.i=@kernel-dk.20150623.gappssmtp.com header.b=LKcTLFZN
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=BjIo3Czw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.dk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfATQeAmjx5RufkOMOeGdapokfJosMQFB6k1z9RTDwAaHSQRUDHVTYt6+NMZc/0dninENWQlrDUylM6skBLtyQzhz8qEZQk1HoJ9TgIvoQuNG1WJ0ihJy
    Kbu1kDqC6F2uRTd0w9wifxICAYeCLRNz0FyX+SKpkuDRLvl7wrv51nCtQTdWdhW9hi7wQhBHH7FqzFmnpjPl3N55T9rdme/HnAciO8fzabTCiPgCLZpEaw81
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=JF9118EUAAAA:8 a=VwQbUJbxAAAA:8 a=HwgzkBgNlSfQ01T3QHoA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=xVlTc564ipvMDusKsbsT:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbeECUZE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 16:25:04 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45113 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeECUZB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 16:25:01 -0400
X-Google-Smtp-Source: AB8JxZoE4T2P/iUMl7M1bGkX+0QBBXk5bFjbsuBKsh+ltGc5k8J3EC7V291IjXlt4Rs3q9kahM4jKQ==
Subject: Re: [PATCH v2] fs: Add aio iopriority support for block_dev
To: Adam Manzanares <Adam.Manzanares@wdc.com>,
        Matthew Wilcox <willy@infradead.org>
Cc: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "bcrl@kvack.org" <bcrl@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180503182114.2797-1-adam.manzanares@wdc.com>
 <20180503183353.GC1562@bombadil.infradead.org>
 <47e0a519-37b4-f5e7-0616-8659d11c2b69@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <18300bdb-a12f-0b6c-1317-6db3e4391d57@kernel.dk>
Date: Thu, 3 May 2018 14:24:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <47e0a519-37b4-f5e7-0616-8659d11c2b69@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/3/18 2:15 PM, Adam Manzanares wrote:
> 
> 
> On 5/3/18 11:33 AM, Matthew Wilcox wrote:
>> On Thu, May 03, 2018 at 11:21:14AM -0700, adam.manzanares@wdc.com wrote:
>>> If we want to avoid bloating struct kiocb, I suggest we turn the private field
>>> into a union of the private and ki_ioprio field. It seems like the users of
>>> the private field all use it at a point where we can yank the priority from
>>> the kiocb before the private field is used. Comments and suggestions welcome.
>>
>> Or we could just make ki_hint a u8 or u16 ... seems unlikely we'll need
>> 32 bits of ki_hint.  (currently defined values are 1-5)
> 
> I like the approach of using a u16 for the ki_hint. I'll update and 
> resubmit.

It's intended to be a mask. If you do shrink it for now, then we need some
guard code to ensure it can always carry what it needs to.

-- 
Jens Axboe

