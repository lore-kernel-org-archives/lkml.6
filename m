Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1013802-1520615967-5-2593146027476439154
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='dk',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520615966; b=ClxP528DYtfZXbQGHNnluEYW2xV/yDspveREHnzlCyLYx9t
    f1zX8QE/dambLXggO+5oO7nC0aYdbG4pdOpq+3agU77vUG4jHYN71uxfjWZHp+Wu
    jB10RniN2NHve/Hy8w5PqLvB6GWhHrbP9jE4p8Rbyf1g8hjcPoVmqXpEIvIZIutH
    6ggO980KWyQ2e58Pu/qGqEmW64ZpYcB8jAyVxuyeyv3aqV38FIIUF1LF+9gU0mWF
    9BkdDCbVr5hxvNIUsmanjXppFidxqQDk7c8I8kEDddUCZeryzSUFfyel61GXLDqG
    AQKQnrDtBFasA7YPb4wUwpKoakXPg/ugZgMla1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520615966; bh=tCwQ5dPr2NH/bHlM4q79H8ztdDb0vuZZbZycVtxsIGA=; b=o
    LabPaKSVxATo2o1SjgYqwp7AzTHNZ/Zrhp1udCisDp+fth0pSelrMfiVxn0ebPzt
    WpCS65T/oex0kzmoOm1HsVNpp53h8+Jb069jarEqoe4Rw3KZOYgysJobOPzw//xw
    OZ1kGJKUQHq4NIwA3Fkndp3Q45gy7kw3VUH6k/wxoxI+HJU0GoXaz9v9qNylJ3OA
    Vb1F6yJl4vUxN18GJFmcSJpZD/mk2q3BnR+X2oENO1rfAX80Q4jQyS1c2U6sk70e
    /ErBrGSEcoaDjlmGpSvJxxqCrAYcxDzBNIOb3hBCmba525gS9S9rGPt0Jex+F9fH
    LqUWF0KDwtFMk5/Tdg8rQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b=eZ5bLrZG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ujauMzcs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.dk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b=eZ5bLrZG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ujauMzcs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.dk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751184AbeCIRTX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 12:19:23 -0500
Received: from mail-pl0-f43.google.com ([209.85.160.43]:39655 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932196AbeCIRTV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 12:19:21 -0500
X-Google-Smtp-Source: AG47ELu+JwGG+qG4kkpvrQsYAhUxPECnxt9JNFPWeYZ6yELah4yjw9WLHqJH38Kgl2XwPWrjfZznqw==
Subject: Re: [PATCH] loop: Fix lost writes caused by missing flag
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org
References: <20180212230558.5546-1-ross.zwisler@linux.intel.com>
 <20180309002048.GA22835@linux.intel.com>
 <81204608-a436-c16b-6846-947573e6ee3c@kernel.dk>
 <92dc07f1-dfbd-2449-ce76-502455f56136@kernel.dk>
 <20180309163554.GA485@linux.intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fa45f4eb-7003-bd6a-471c-fbfe16abcd72@kernel.dk>
Date: Fri, 9 Mar 2018 10:19:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20180309163554.GA485@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/9/18 9:35 AM, Ross Zwisler wrote:
> On Fri, Mar 09, 2018 at 08:38:57AM -0700, Jens Axboe wrote:
>> On 3/9/18 8:38 AM, Jens Axboe wrote:
>>> On 3/8/18 5:20 PM, Ross Zwisler wrote:
>>>> This has gotten Reviewed-by tags from Christoph and Ming Lei.
>>>>
>>>> Al, are you the right person to merge this?  Or is the correct person Jens,
>>>> whom I accidentally didn't include when I sent this out?
>>>>
>>>> Just wanted to make sure this got merged, and to see whether it was targeting
>>>> v4.16 or v4.17.
>>>
>>> I'm the right guy, but I don't see patches if I'm not cc'ed on them...
>>> I have queued this up for 4.16, thanks.
>>
>> I do see patches sent to linux-block aswell, but you didn't CC that one
>> either.
> 
> I figure out who to CC on my patches by using scripts/get_maintainer.pl, and
> it didn't know about you or linux-block because drivers/block wasn't covered
> in MAINTAINERS.  I'll send a patch to fix this.

I'm the first person for a check on drivers/block/ or
drivers/block/loop.c, though...

> As it was I just CC'd the folks involved in the original patch, and that one
> went up through Al.
> 
> Thanks for picking this up.

No problem, glad it worked out.

-- 
Jens Axboe
