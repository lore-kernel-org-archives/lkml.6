Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3120198-1525382437-2-7366851852777192679
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
    1525382436; b=QRfv6M+rMsvGbz3PbWFA90BmJ9fVBHnLUw8syh5a1bqRO/l/lm
    A1+ytXx1PQn+rtDFbq/lxkNPTD9KjyQUSRFW35/N4+2vW+M61vfs5k3yBHeef9Y9
    EUuYcuhZhukA6wsivf7wRgyXlZsTrXSHc1VQjiQ32ukJ2AFFnyR6yM/ez9kc1VOC
    sGBAWWP/ZKfUMzBwfHVrJMZj0owHObbKMsSaU3z61Txge2B+xJ9Vg6XMa0tujEli
    7v/8xYphMS6rQ5aTDOvZ5ErvAeY9k9m3lmsM6IKpsilR+MrABZPe478LIi15JrZb
    UZBoRrjROQa1zspIgG+Mb5FoP+K1r4cIHlQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525382436;
    bh=QlJ51uL6hd7z1CgInW6ZJ4dX9QGSPr6Uu79ut9rDOss=; b=mONp0xXzOnw2
    SE+2wvlhRt9Wwckun9h0KgjgPi8hvjyHG1GvFwtO9JDxLfeqJDzOabDULr6dXtXW
    XklZo99H3VpEIocX/52/4jxkWLySTvCitHSYY1pbxp0gRBmdCdY2byhqyWiaUZq3
    jUC+wSU/91T/Dzi6zXem3YvZCZlqYDqjPbEX9gTpalOicFPJYxJXBhWT+U+Ftz7U
    WfwJxglHYkeif3TDCepBmhJWrOld9VbCqicGLjdroyXSrzBMI+E0XRlS2us4REQc
    RnowWmQsBKtLrAWmADSkI9iDS+89JPdBzcueIV+mPvgJQIuVdZ93MkqFjBt7XI9O
    ooSdUsZZ2A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=kernel-dk.20150623.gappssmtp.com
    header.i=@kernel-dk.20150623.gappssmtp.com header.b=ev4ALAU2
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=sJlf1986;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.dk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=kernel-dk.20150623.gappssmtp.com
      header.i=@kernel-dk.20150623.gappssmtp.com header.b=ev4ALAU2
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=sJlf1986;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.dk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHcjdLmNbVEkQYfugej/7EBhu6MSmY2IqySSyXwmvSj7d5dVRs1QmQp2n9EBPh00J7c5KddlzoX8Z++mM7N9k0qET+3dPYItm2CN1Q63qWyI1Pkxs3QM
    p3YToLqU61tmk/9NgckD0uISLeYARvguglQDGUWEw1zp8qY/wPJWhty0p4LINJPA00RH8VZ3V84yp8mWaFuegM94hAQYE1BDHnIzYOjxkhrg2kjjwObD+WF8
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=JF9118EUAAAA:8 a=VwQbUJbxAAAA:8 a=u3PRsLWrV3ZNU7Yh6ywA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=xVlTc564ipvMDusKsbsT:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbeECVUc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 17:20:32 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:38803 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751261AbeECVUa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 17:20:30 -0400
X-Google-Smtp-Source: AB8JxZo/sZ/VdXQKFlcEDCOqouyGijqCKgTSwauBN/eOThn7cxiSmx428G16jBVSDrvUcI0huHWddA==
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
 <18300bdb-a12f-0b6c-1317-6db3e4391d57@kernel.dk>
 <e81c74fd-a4a2-80e0-476c-6ff35f158abf@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9e3ba3eb-9c41-3b5d-dc12-f9ef573ab53f@kernel.dk>
Date: Thu, 3 May 2018 15:20:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <e81c74fd-a4a2-80e0-476c-6ff35f158abf@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/3/18 2:58 PM, Adam Manzanares wrote:
> 
> 
> On 5/3/18 1:24 PM, Jens Axboe wrote:
>> On 5/3/18 2:15 PM, Adam Manzanares wrote:
>>>
>>>
>>> On 5/3/18 11:33 AM, Matthew Wilcox wrote:
>>>> On Thu, May 03, 2018 at 11:21:14AM -0700, adam.manzanares@wdc.com wrote:
>>>>> If we want to avoid bloating struct kiocb, I suggest we turn the private field
>>>>> into a union of the private and ki_ioprio field. It seems like the users of
>>>>> the private field all use it at a point where we can yank the priority from
>>>>> the kiocb before the private field is used. Comments and suggestions welcome.
>>>>
>>>> Or we could just make ki_hint a u8 or u16 ... seems unlikely we'll need
>>>> 32 bits of ki_hint.  (currently defined values are 1-5)
>>>
>>> I like the approach of using a u16 for the ki_hint. I'll update and
>>> resubmit.
>>
>> It's intended to be a mask. If you do shrink it for now, then we need some
>> guard code to ensure it can always carry what it needs to.
>>
> 
> Got it, I'll add the guard to rw_hint_valid along with a comment about 
> being limited by the size of ki_hint in case we get to a situation where 
> 16 bits is not enough.

Other way around - the API should not be limited by the fact that some
smaller type was chosen for an internal structure. Hence the guard/check
should not be in rw_hint_valid, but rather around where you assign
ki_hint. If/when we do extend the read/write hints, then we'll
potentially need to bump ki_hint to accommodate it.

-- 
Jens Axboe

