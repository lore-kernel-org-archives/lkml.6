Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2952182-1522132655-2-12441235608056516158
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522132654; b=CL1nmhjR720Ki/4ukHP+KOklXIu0KGY1JzRGmSfQtdIZ40j
    r/dZNz2RH4Lelln5BQaU5y4vg0UDSOwo8M7bMyYPm0yDZzOpB/W7u6tmT2UUguwU
    lJBabYKfXfC17zuyIBdPu4HKFUpNi/MN/udM7r8WMh7Fl5STpNvX89wm1N8dDQBP
    7TcfIAqvZ3tq4kPpfHcCpdSprOcnRlztHSD1oOVJx1Yuc0rbjY3LjigH99ftDlN5
    os+PlfEgoXUe0pnnNI0ziT/9WhBbPjIQGoScCMq0SjNAwhC2JdzNfM2w3BsLP2ok
    ZSjJv5XNYmsNZ+7AFI2QMPOLdIAhbY2fC+95eCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522132654; bh=lD4UKbbpKMWLTMs00Oz9L7/IBDP/F+1xqzP8izG1d88=; b=D
    waAByjWbzt30SgsUlS8OJICR48pD4GzkXlroA/zikeVVKcMeer9mrGeVBDqTquF3
    nqEvP5upg6UPiemCAGopJtgkGsNcgHtVh0BBjvS2/7WWGg6Rnfdacn40UZQ3w/B1
    N21KqzaHKxtepJk7lPAyTAEbH+dPRvhAKlk0708BbXqtd/7d6IeHBf/ARgr0++iP
    eQGSatIoTb+4hNYC5nHZwMg5O49jkhXxZIMChwr6NJHtui2Z9q/ZvlyZO/RUpD+M
    33v6oyhUdlk2u+ZMZj16lLZCXqATQ/5aBH1BS3NCVOOJIhCqpoKlmkJGm3KVeUn7
    n834nolB2bn3CkPHNlORQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=sl/6ev/8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kGjZ8Pca;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=sl/6ev/8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kGjZ8Pca;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA3xTBVSXt3z6t3iBwbxlUV63yRYUN3pRcPYamWkRQ61Ufw2oZ6Dhu6YyP3eI2u9paw4QiARz4z4KKDUTpIr5dz09XW3DHZGDKK8lLz+j5MmQxOZu5jv
    PoEqT4clYYC3MIHhVSrul8B5wMu9dNArD4K7349jPjUHwClLgC3NNvmv6KJkoF9M47+ZrBSrwS1NNoPsCBOA1Rh6iMgqwXco1LuO9To4MmqUTL0JRymq00GO
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=DWDKLPo_AOAA:10
    a=v2DPQv5-lfwA:10 a=tKstIQbTxBXV35_m1UsA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbeC0Ghc (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 02:37:32 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34888 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbeC0Ghb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 02:37:31 -0400
X-Google-Smtp-Source: AIpwx4+qrG1nvqsosT4xh3bV7UvqGHit9deulRbeziVLU5uek4228I/A/4EM6ZrtO2aaNgN+ZHveLA==
Subject: Re: [PATCH 4.14 000/109] 4.14.28-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kash Pande <kash@tripleback.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180316152329.844663293@linuxfoundation.org>
 <7ec4a6aa-72cb-9fb6-5168-d1c4d49f1a6c@tripleback.net>
 <20180319182032.GA23774@roeck-us.net>
 <6b6fca54-9cd9-3c62-6c0f-b5e8477947ac@tripleback.net>
 <20180327062808.GC28908@kroah.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7e14038c-23c2-80b6-9c93-7843cbb5c36f@roeck-us.net>
Date: Mon, 26 Mar 2018 23:37:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327062808.GC28908@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/26/2018 11:28 PM, Greg Kroah-Hartman wrote:
> On Mon, Mar 26, 2018 at 01:54:18PM -0400, Kash Pande wrote:
>> On 2018-03-19 02:20 PM, Guenter Roeck wrote:
>>> Ryzen and Threadripper are only supported in v4.15+.
>>
>>
>> Nope, the offset for 1900X is not available in 4.15, I've had to
>> manually patch all systems otherwise monitoring complains they idle at 53C.
> 
> I don't understand, what patch are you talking about here?
> 

6509614fdd2d, but you'll also want aef17ca12719 if that isn't queued already.

Guenter
