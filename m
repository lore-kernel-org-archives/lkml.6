Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2363342-1527187280-2-3128947852971213087
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527187280; b=MqDLLFsWvoBg9aOmU5kiLRGwTx63QLRSHmYL2P7xcc0k3r56nF
    zhk1Js8FFYdW8JqlBeG6bASQw9pplePBaqG8JKsSAhBghQYeZgkNBmHAG9r32P9x
    WIfcQbo8c/wChJBqJ1cWhWLtjUfKivC72XbrKmYaEAuDlvHJk8t8LkHJ9VEOfxGe
    O3jgENR7qZtVigVCuNWhDzP0r+VyYjNXWT6pZjftgVo9SxRo/Ibth58MxKTzJf94
    hV8TjDkdDs4NGnq40wuciEY42jqmuRYerkZI/hIgWeUm1o/mqWTTPupUMInEBO5s
    CGanAczFCp/1LcU6kE53d3/DmeRIva9zOWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527187280;
    bh=SLc1Rd8PYwOZ0UHZ6CVCgBkcNlqBCTwtR5PVMU2yPOs=; b=EbMPpsdeRSgd
    sSfiypGSUh8upj2mPuVgZXQxsGrGBASbMNnlNicJ34F58rP9v4lOpg10ZuxJsC9j
    739j+4M7ih7dPLZXz4svggoOqEtViopUkF/zGaR2+wMY2fx7uymnG+eFxgRUsBti
    V6Ug8qox0O/uAcsUF5tKLMZ0IQlFSxEbnGdWx/vndEQPgIa9kY+Mzk+oupJnYw4I
    renpoi4g9s25WVU3Ln4/b7sS5e2C2+cEanXYIebAddWcpA7Z5O5vVaQJtJXVLEam
    xDn+ZjuTP3i29+O/88FtddTKxlL/BPQcAe4DmLLtDtRCDlkRUF2Y+sRj2tNxLuBV
    kRSPtxYhRA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=ZmcQpkg5
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=ZmcQpkg5
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
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
X-CM-Envelope: MS4wfKS0m8yPaFposqAM273dAuWXDDZKLi1ptUpLlHMr9JXwZtHVv4IUbH4ftc1YPmWgmBY9J5skH/Y1kCerb40HPQPjLqeFp4HgrNCsJ0rckUBRbXf3BdUG
    xI4jAhiuH50eS8H94+8gfxXB22yYK4tCoblVMie/4nCKxkRYBIlbLLqeb2K1kPEVuOi+d9klvTWMo9CL63ZBXZjd3a2OgYmLPnw/e2D1olea934wjI0ZnUn8
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=7Uoc8g_nlIUVD6JYjBsA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032767AbeEXSlQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 14:41:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55922 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030324AbeEXSlQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 May 2018 14:41:16 -0400
Subject: Re: [RFC PATCH 0/5] kmalloc-reclaimable caches
To: Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vijayanand Jitta <vjitta@codeaurora.org>
References: <20180524110011.1940-1-vbabka@suse.cz>
 <20180524114350.GA10323@bombadil.infradead.org>
 <0944e1ed-60fe-36ce-ea06-936b3f595d5f@infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cfb7c8df-2a6a-bf84-8a30-df97c58c9c47@infradead.org>
Date: Thu, 24 May 2018 11:40:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <0944e1ed-60fe-36ce-ea06-936b3f595d5f@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/24/2018 09:18 AM, Randy Dunlap wrote:
> On 05/24/2018 04:43 AM, Matthew Wilcox wrote:
>> On Thu, May 24, 2018 at 01:00:06PM +0200, Vlastimil Babka wrote:
>>> Now for the issues a.k.a. why RFC:
>>>
>>> - I haven't find any other obvious users for reclaimable kmalloc (yet)
>>
>> Is that a problem?  This sounds like it's enough to solve Facebook's
>> problem.
>>
>>> - the name of caches kmalloc-reclaimable-X is rather long
>>
>> Yes; Christoph and I were talking about restricting slab names to 16 bytes
>> just to make /proc/slabinfo easier to read.  How about
>>
>> kmalloc-rec-128k
>> 1234567890123456
>>
>> Just makes it ;-)
>>
>> Of course, somebody needs to do the work to use k/M instead of 4194304.
>> We also need to bikeshed about when to switch; should it be:
>>
>> kmalloc-rec-512
>> kmalloc-rec-1024
>> kmalloc-rec-2048
>> kmalloc-rec-4096
>> kmalloc-rec-8192
>> kmalloc-rec-16k
>>
>> or should it be
>>
>> kmalloc-rec-512
>> kmalloc-rec-1k
>> kmalloc-rec-2k
>> kmalloc-rec-4k
>> kmalloc-rec-8k
>> kmalloc-rec-16k
>>
>> I slightly favour the latter as it'll be easier to implement.  Something like
> 
> Yes, agree, start using the suffix early.
> 
>>
>> 	static const char suffixes[3] = ' kM';
>> 	int idx = 0;
>>
>> 	while (size > 1024) {

I would use   (size >= 1024)
so that 1M is printed instead of 1024K.

>> 		size /= 1024;
>> 		idx++;
>> 	}
>>
>> 	sprintf("%d%c", size, suffices[idx]);
> 
> 	                      suffixes
>>
>> --
> 
> 


-- 
~Randy
