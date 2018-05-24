Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2285987-1527183321-2-2549377243676745744
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527183321; b=mqi9SmADKKm7JhUwQVXd1HAKuRTr0oaWudnWKWLXZKapgoXKtC
    3NeRj6cP372g2C++YuLkVhMoa4RZJWHRTNybAc5KuV/wx1389E8G/qjLaB3rK2bp
    e+/AiJxnR0AeW0Xs6ADRCMihyg5LI2vEGb1G5H7iR6ehHuZsjchre/uh2bN4aZk2
    dBhbfRQ6tB0iBHua+/hJb85zT21q+dZGFW1kga/UVOOfb4uEeY553a8YER5tZH8k
    uoq/xeNC/7bIKvpmaXaMTz8c2UTUCIuT5o1+hCdCcn1Dp2IFo0K3RHFXi+Qq3Wns
    WFX/qdnmkGW4JeHwcpBNQG2RNQWD7peXa5mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527183321;
    bh=z+/cncxiB+1XguI5HWKwmhNe/zwYtJRMugVss5Z81Wk=; b=b1cidmahZx9u
    VMOH7g8ZW6gMT2MuD7Pw6EDL/7znxIs6nxDnU2R5JnEmkhocy5z7dgw3ue8nJyyO
    B0AqEyyg21b8je6Ie5mIH2Rtjo5sgFHhnD9OA6UuGTcR+K8dgziKBCwVzN7Qa1FV
    7bvr33hWwuNLLtYLMV6vzCgjPHJlP4TztKQiBsIpQ1F9TOTakGDH21k5CMuhLTMQ
    9HCozW/JlRihhkNkogQN5/Sck3rEsA95rAEqzmX2KsQRhl3tFGyRe1Ix8iWw+2yI
    603s8MaGuZu2gUdr++0yIDDPK1AXeaDPTan9B2Y4wNSVRBYrKz1y9jiv9d6IJ/ew
    d6DvQzqhKw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=RpviKCo8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=RpviKCo8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNa56oF+I8g/lQ+6ZVZVbNjGGGm9wUJrz4GEoEZcdwiVpybKXHjYYdrrnTmVdkvoMRc36FK8addqC/0Z23sY80SiPzRw6P87CNMI+vCJ0c8V6C9tBj59
    RdvgxvoQojI6jm/ZMd5jGZhJewdcDLsD6HrGewX6eRs7roIebOeB7xwWu+GlgsS8mqMqc39+d2qZeWh/75KD5nWXiXVusSNT7Hx/eSCqwuQcG4umJDDTtODy
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=4_-BN3WEXhEA:10 a=VUJBJC2UJ8kA:10 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8
    a=bdXydZEAbkn392bGRPwA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967556AbeEXRfH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 13:35:07 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37042 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967513AbeEXRfG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 May 2018 13:35:06 -0400
X-Google-Smtp-Source: AB8JxZpWhQAY1Su+ozEiWPnQ7wYGw2WMvthW7JwrlC0JTHIeuMZeq95692IFa6anisRHVZZI11xMCA==
Subject: Re: [RFC PATCH 0/5] kmalloc-reclaimable caches
To: Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>
Cc: linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vijayanand Jitta <vjitta@codeaurora.org>
References: <20180524110011.1940-1-vbabka@suse.cz>
 <20180524121347.GA10763@castle.DHCP.thefacebook.com>
 <fea26519-2b5f-b404-872d-47afabcd3393@suse.cz>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <01cbee1d-e5cf-8de1-6610-3043a2c5d5ca@redhat.com>
Date: Thu, 24 May 2018 10:35:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <fea26519-2b5f-b404-872d-47afabcd3393@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/24/2018 08:52 AM, Vlastimil Babka wrote:
> On 05/24/2018 02:13 PM, Roman Gushchin wrote:
>> On Thu, May 24, 2018 at 01:00:06PM +0200, Vlastimil Babka wrote:
>>> Hi,
>>>
>>> - I haven't find any other obvious users for reclaimable kmalloc (yet)
>>
>> As I remember, ION memory allocator was discussed related to this theme:
>> https://lkml.org/lkml/2018/4/24/1288
> 
> +CC Laura
> 
> Yeah ION added the NR_INDIRECTLY_RECLAIMABLE_BYTES handling, which is
> adjusted to page granularity in patch 4. I'm not sure if it should use
> kmalloc as it seems to be allocating order-X pages, where kmalloc/slab
> just means extra overhead. But maybe if it doesn't allocate/free too
> frequently, it could work?
> 

The page pool allocation is supposed to be a slow path but it's
one I'd rather not have too much overhead. It also just looks really odd
to be allocating higher order pages via kmalloc imho.
  
>>> I did a superset as IIRC somebody suggested that in the older threads or at LSF.
>>
>> This looks nice to me!
>>
>> Thanks!
>>
> 

