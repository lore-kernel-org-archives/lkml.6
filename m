Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1456203-1522347198-2-3095944690807890546
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522347197; b=afX1pgwacT51UHT8cj7lGMKrARJjgQudtfgYu2ox9lBb2LDK+W
    mJxVp2wulyapczwbPEYxhrFCapftmcnuBgsHrnQ1hf6jN4jIpWVZA31NOfSBxXDI
    fnelG4jjACS8Y9vTKtihI2H5Vsw/tp6CCFLEnyzzhUhe9VSchiKJfqk/NL7c4edS
    c5gWiDYyTicbnoIgnajtW+/vvHIJ6X0Ej2oLmjzb1S+IWg4pxXp+ZkkcBP9DuEZZ
    pIt2EsoNM2o9Sw5hq5QxFwaXGyGdeBPLirFO6EavCTea1CYQ/rcxWFFwdy0oTxDX
    Dcu2VmpejdC3YAWHtSS15qwGLb78QsyYLotA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522347197;
    bh=KcbrRZ1JYxHuw5LU5wXOLqqSrh35qgaGtCcEMtLz8CE=; b=CYcIiNFOTsdV
    pzPB1XsDhFnkYyj7yevgAhdVwmaV+PGHT63Nc7YNRgWYFFjelEmAXfX3ZkVUL5/6
    d8PYpBopv0p8j7aMOF0/oMeiXMpaQftAQbbRzp3P+pDnfOdUMaiyU38bI2c/H8eD
    MlU6rTHgkLqdiLT+uyAaxftuuOSAhMJjXIZza3b5YW5m06petUxSQ9jMfhRRuCHV
    9ePAl2Ke4/B6Q55fdtQdsD+ruV+4tblUndaBcb4jum+NL9uAxnUJmN4fwyQqZT3z
    lxDbtxxlvKnFhdAcq6tMnToAh0dsoiM4wLRAtKRnwGHhXEEWS+uTiJpzsDQ7YSNe
    yyy3n2tmvw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b=GjSFTHI+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=colorfullife.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GGz1wLDP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=colorfullife.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b=GjSFTHI+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=colorfullife.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GGz1wLDP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=colorfullife.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNmARZNXpT5yVIsaEYA0+Ozl4JaWi2NlqbSoYyXLzB6bvJFnchnDYkxXbUPsQi3SxOuWHoNciz1Q/3XrquZMtuKqh/zYeQlvuBCxNs3mS69e53CGxYqD
    WGydvVZK7XyXv28NlZ/X/6FV8k3Hj0k9lVqkkHbC8xk+AzkqmgdtVJZ5NrQfZrryBjMgs9B2HzN8rV+P0lZf/E0RlV34tSDV0qukN9kMaMsyFgI88otIzbtb
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8 a=dBLJ3qMea2lKCQLVHzYA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753744AbeC2SNO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 14:13:14 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41595 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754120AbeC2SHq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 14:07:46 -0400
X-Google-Smtp-Source: AIpwx4/drSyZd3HsHnbABUgwO5HYs6Et/wQUV8iOS1Vi3iQT15nyAThKr1qYr2ykLo2n7yYH+QBqeQ==
Subject: Re: [RFC][PATCH] ipc: Remove IPCMNI
To: Matthew Wilcox <willy@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stanislav Kinsbursky <skinsbursky@parallels.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-api@vger.kernel.org
References: <87woyfyh57.fsf@xmission.com>
 <5d4a858a-3136-5ef4-76fe-a61e7f2aed56@redhat.com>
 <87o9jru3bf.fsf@xmission.com>
 <935a7c50-50cc-2dc0-33bb-92c000d039bc@redhat.com>
 <87woyego2u.fsf_-_@xmission.com>
 <047c6ed6-6581-b543-ba3d-cadc543d3d25@redhat.com>
 <87h8ph6u67.fsf@xmission.com>
 <7d3a1f93-f8e5-5325-f9a7-0079f7777b6f@redhat.com>
 <20180329021409.gcjjrmviw2lckbfk@linux-n805>
 <3e201de2-bed2-6f7d-0783-700d095142e0@colorfullife.com>
 <20180329105601.GA597@bombadil.infradead.org>
From: Manfred Spraul <manfred@colorfullife.com>
Message-ID: <05772f83-d680-aea1-b222-cef2430dcc83@colorfullife.com>
Date: Thu, 29 Mar 2018 20:07:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329105601.GA597@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Mathew,

On 03/29/2018 12:56 PM, Matthew Wilcox wrote:
> On Thu, Mar 29, 2018 at 10:47:45AM +0200, Manfred Spraul wrote:
>>>>>>> This can be implemented trivially with the current code
>>>>>>> using idr_alloc_cyclic.
>> Is there a performance impact?
>> Right now, the idr tree is only large if there are lots of objects.
>> What happens if we have only 1 object, with id=INT_MAX-1?
> The radix tree uses a branching factor of 64 entries (6 bits) per level.
> The maximum ID is 31 bits (positive signed 32-bit integer).  So the
> worst case for a single object is 6 pointer dereferences to find the
> object anywhere in the range (INT_MAX/2 - INT_MAX].  That will read 12
> cachelines.  If we were to constrain ourselves to a maximum of INT_MAX/2
> (30 bits), we'd reduce that to 5 pointer dereferences and 10 cachelines.
I'm concerned about the up to 6 branches.
But this is just guessing, we need a test with a realistic workload.

--
     Manfred
