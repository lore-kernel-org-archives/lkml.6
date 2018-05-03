Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3287437-1525388018-2-8900463191430577522
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
    1525388017; b=cGCZv/cBz8sQ4kWiFjXAnOdFFS6x+SQoI5Qqst6ctf6VlEBWiL
    A0CQzaI09pAL/Jejm3/1zwFnW/yQWezV0cVKSuHIu1/gmOtPgyNA3REZ0TrW8xuS
    p6gGuY9DHc+GJFwXXqNyiff0i8jjVjB4TM3vZ2ZtiwY8X0iCv1kgwIM8zdT2kd1a
    4hn+O5Nt8t2P/TQqRehTx+O2N45cfXZa91Ku56uaLbtRB9IVz5cqGaSzEDD9C68X
    OXho8RBDjjUtSjn+9aTm8PVR4d/pAP9Q69UVDBurUwPWuPbtmZi86jU7GDcmjyP+
    hE1Rvu48lm7Ru76FeY2ljMQ97EMIF6L6X66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525388017;
    bh=DzqCywQ+NbZRgZp1C8li9aV/qGElOHY1ouCtSYtvUEE=; b=DiYVlmVykBqz
    9vr+oAaUYba9jLh0IMP46mQ3zVjuxD9BrOi6NF8Mx1jOrTgAMjgUy1qzwpyq1TM6
    m4h566+YMo10gVpTx2n5O7WxS13APlqN9IvT9p8cEtLtkVmXRU3nHjrUe+04QWRY
    ZojgQ7RdsbpBDnL18VoFqYkLjq2IQ8bRmB0AbZbVBK+tcZC8DMYiGXq9w5GLH2Is
    47bo5haYyHDyiC4dP9X4eKdEpAZ8LMkLWpWX6OHUEIti+tDtkkt4SLK78dYzg58h
    SucOqDg4gymNATI7HO2r080dvdHXZm55Viaap0fe0sQhR5kEoRDBzyOTesL8svVl
    YYtGa54T/w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=kernel-dk.20150623.gappssmtp.com
    header.i=@kernel-dk.20150623.gappssmtp.com header.b=lx+tAm77
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=KrOtasCD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.dk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=kernel-dk.20150623.gappssmtp.com
      header.i=@kernel-dk.20150623.gappssmtp.com header.b=lx+tAm77
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=KrOtasCD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.dk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEcvqV9NRriJ+y4Wg+bDOH+z1t6ww+svgqNicqVVGD31w2TVvVYf82hF7fmxepvT4fJQQAI1DJcNiIjPAQAIwV+NOPmLCZNaEYY8IRK9cnKtiSPCyMux
    uXOPBHX+iDSIcAvEVWYT5A1DBqTjuKezP3l0STYVqSECBALfOHEfU90XeNcSALuq6tu4eZFB3O6VqbuUeRC1K139fIcwlqCjWlyb+vJCj1pfmNlFBfmYV7qO
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=u3PRsLWrV3ZNU7Yh6ywA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751111AbeECWxZ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 18:53:25 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36752 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751380AbeECWxX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 18:53:23 -0400
X-Google-Smtp-Source: AB8JxZq+jIf+f4zWZd99v4vN2QNArZa8PwVfOeaSDs4HXSdkxV7BHD677nJxEGwubtlx631rKsHS6g==
Subject: Re: [PATCH v2] fs: Add aio iopriority support for block_dev
To: Matthew Wilcox <willy@infradead.org>
Cc: Adam Manzanares <Adam.Manzanares@wdc.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "bcrl@kvack.org" <bcrl@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180503182114.2797-1-adam.manzanares@wdc.com>
 <20180503183353.GC1562@bombadil.infradead.org>
 <47e0a519-37b4-f5e7-0616-8659d11c2b69@wdc.com>
 <18300bdb-a12f-0b6c-1317-6db3e4391d57@kernel.dk>
 <20180503224308.GA30823@bombadil.infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b74a5202-7078-88e8-6b30-7cad0c123703@kernel.dk>
Date: Thu, 3 May 2018 16:53:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180503224308.GA30823@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/3/18 4:43 PM, Matthew Wilcox wrote:
> On Thu, May 03, 2018 at 02:24:58PM -0600, Jens Axboe wrote:
>> On 5/3/18 2:15 PM, Adam Manzanares wrote:
>>> On 5/3/18 11:33 AM, Matthew Wilcox wrote:
>>>> Or we could just make ki_hint a u8 or u16 ... seems unlikely we'll need
>>>> 32 bits of ki_hint.  (currently defined values are 1-5)
>>>
>>> I like the approach of using a u16 for the ki_hint. I'll update and 
>>> resubmit.
>>
>> It's intended to be a mask. If you do shrink it for now, then we need some
>> guard code to ensure it can always carry what it needs to.
> 
> ummm ...
> 
> enum rw_hint {
>         WRITE_LIFE_NOT_SET      = 0,
>         WRITE_LIFE_NONE         = RWH_WRITE_LIFE_NONE,
>         WRITE_LIFE_SHORT        = RWH_WRITE_LIFE_SHORT,
> ...
> 
>                 .ki_hint = file_write_hint(filp),
> 
> static inline enum rw_hint file_write_hint(struct file *file)
> 
> #define RWF_WRITE_LIFE_NOT_SET  0
> #define RWH_WRITE_LIFE_NONE     1
> #define RWH_WRITE_LIFE_SHORT    2
> #define RWH_WRITE_LIFE_MEDIUM   3
> #define RWH_WRITE_LIFE_LONG     4
> #define RWH_WRITE_LIFE_EXTREME  5
> 
> It doesn't look like it's being used as a mask.

Right, currently it only supports the life time hint. I'm saying the
intent is, for when it's being expanded to cover other hints, is to
split up the value into maskable sections.

-- 
Jens Axboe

