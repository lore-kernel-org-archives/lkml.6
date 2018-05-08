Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2981746-1525793979-2-6022175136109409838
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525793979; b=JsGrhLbmbBHc5uMUFvx/XH+9coDjnXFfDAlffiJ9G/x5Fs6X02
    w5wraowmRD33F37m6ysYLm+VlRPplEbZGEbjm1ElBnd8WiBtTpig8ihmluQo9Dx5
    fGT5/ncyl8vpU9UOVD7m/iX7Z9NT+wJkG4iWoS7rYHe66B0ubRo3W4YanSMIYHJZ
    m1OgO1SokMSa/SVuakaKuUXcP7XL+Ex+Ha/ZFznv/Iq92JUhuE1z3NYd7V8Ci5Df
    1Ieo2w1ZsGGQdhiye+9RQixTRPgE7lO7jN/7Me9aMhuWSISa8x7he0xKmX31dmaO
    TiNykzs49Z/HaNbkfqr+Gh5O3UsHav1uCjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525793979;
    bh=qzaOX82+7BqnjZG4DT9+j0TMX5WNvwvveZ95fOkCp50=; b=AtkmGICqoL3k
    m4jV/014Agu7VcU6HFsS1K2CKnPGLds0WKcGiYslomn82cq8vSstzhMtQlYB8Gix
    hdzb56IMqKKqjAGc07r1xG+RVUNUPM/DAFq5JaFm9d6NQk664snYStOYQoo6NWZK
    AuT6qTkE2J3QUbS7/rKyXNl2PtFVGaw2HpfKbLCVYphI+NYHm5zglcXGdfcXm5hr
    vTuR5kLQVaKbq166SWx4jVvyGzpR9M5OTm/ryP44j5WUrxBjw9yAP5YZU0uEh1TB
    +dX+vXcoYL8aulwQlZtoBA43Pee8eEvLYZNP8dWr1NjAds9UN/HRqZifZGsdSJhV
    P1do2UxQTw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=nY2FT+GN
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=nY2FT+GN
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGcc+Ui6HTSu9RoOtvHaL6y9vbO3irEwmcO10OYi9foeKuXeLIybko9ZVkHKqHP2tudR9Co7VKMRfct2kgEstxsDHBYNUU1qzsFDsGinn386KmjCqPRd
    TvDaTZc6YcmqsVYf7uFbM4b5Np2FAimi+J768UAMwBnL9kNuluFkZ/STffwr/f/bRiInmVQohX/fiVFsBaBm2/fewMzokSyoI+wzZU2KqZ9Si/9iFBgEGXTU
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=JfrnYn6hAAAA:8 a=9RPxxNiGgkFyOj8hc0kA:9 a=QEXdDO2ut3YA:10
    a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753635AbeEHPjh (ORCPT <rfc822;linux@kroah.com>);
        Tue, 8 May 2018 11:39:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33616 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752429AbeEHPjg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 May 2018 11:39:36 -0400
Subject: Re: [PATCH] mm: expland documentation over __read_mostly
To: Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, tglx@linutronix.de,
        arnd@arndb.de, cl@linux.com, keescook@chromium.org,
        luto@amacapital.net, longman@redhat.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <e2aa9491-c1e3-4ae1-1ab2-589a6642a24a@infradead.org>
 <20180507231506.4891-1-mcgrof@kernel.org>
 <32208.1525768094@warthog.procyon.org.uk>
 <20180508112321.GA30120@bombadil.infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7d6664dc-01f5-55d9-d309-0378ff609b8a@infradead.org>
Date: Tue, 8 May 2018 08:39:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508112321.GA30120@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/08/2018 04:23 AM, Matthew Wilcox wrote:
> On Tue, May 08, 2018 at 09:28:14AM +0100, David Howells wrote:
>> Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>>> + * execute a critial path. We should be mindful and selective if its use.
>>>
>>>                                                                  of its use.
>>
>>                                                                    in its use.
> 								     with its use.
> 
> Nah, just kidding.  Let's go with "in".
> 

Yeah, no, I don't care.  Just flip a 3-sided coin.

-- 
~Randy
