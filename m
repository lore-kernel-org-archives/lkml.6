Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE9DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E0920663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njxabi4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E0920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391115AbeKVLNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 06:13:46 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37695 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732226AbeKVLNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 06:13:46 -0500
Received: by mail-ed1-f67.google.com with SMTP id h15so6330149edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 16:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k3R9baTTzJwVPv5u0FDrXuiwV1nrHmlliU76tzeMYzM=;
        b=njxabi4NxBOA/L92l3WXeQams9xVA3/QKNRDS2ndtgqFLjTdn2PTZ7DymN86cxrF2u
         WvLjgugnCiA8ReCHcv+kf0C7Wc0Wb7B4YnhThSMsnujCePFH8vSqQDgt6RhfVovszORQ
         O7Ek5o3HkAf2sOrJ18IvKF/qo6AbPc+nuP1mgtqdPn/eI2ByrHV95l9Xx7dlj6+Z/JX7
         m/5/zebu6HWPqTPlGO8J0OAQBBKrXGMiuJbqnlP3soVpF33Tms+di1AyoBA3HWSUwTZ4
         jo6APDdJur76DpfixtvZrWsKwqu/PxANjZ+bG9/j7dfvupoEcv2c2ysBYkP13CVQzTE8
         GqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=k3R9baTTzJwVPv5u0FDrXuiwV1nrHmlliU76tzeMYzM=;
        b=UHCYaMRShXVaA+Xcxl2UNx/dixZgayy0mOoeFeWnChtCRPwqYgOGlTowik7vfNhqQ0
         BIxJ7CjIgjaULoCiTC80CiXSAJgK0NAWuSeWsNssKmTAsNOj2DTaCkeMlTr3P7bh+twC
         /hARUJ9BCgO9dPpEmG9b3uskgXNPMlsFbGii997fk8A04CrjDTYD/dWGM6UON4a4p1De
         G1t2X/b4q1BDFMKJb5LcB3oPFZTmjfrAgEXPXkQCACm481+T6Bh4MgaZ4DO275f9YdlE
         rufE5Q9+H/WYiw182Xh+SFDLSDYiJAnEQAbfO6qbuu6qqJMuPNFudlD6zh9Sy1QuKHuH
         lBYA==
X-Gm-Message-State: AA+aEWbm/sHzfjm9cU/mz7Hl2RxMdNHz4hDqAFZirxYKJT217JpMa7PG
        tryqeL/DH1w6SdP/Z578NRA=
X-Google-Smtp-Source: AFSGD/VGhYggv7h07KYbXk36hbFLKFCO/ex3eEPg+7JvHDxhtMgTxP/nv8ZVh3FDjsP8Sfkhgxc5Uw==
X-Received: by 2002:a50:a1e5:: with SMTP id 92mr7658766edk.181.1542847018237;
        Wed, 21 Nov 2018 16:36:58 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id p22-v6sm1039465ejf.48.2018.11.21.16.36.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 16:36:57 -0800 (PST)
Date:   Thu, 22 Nov 2018 00:36:56 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Wengang Wang <wen.gang.wang@oracle.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: use this_cpu_cmpxchg_double in put_cpu_partial
Message-ID: <20181122003656.wmaoncvgjhlnei5m@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181117013335.32220-1-wen.gang.wang@oracle.com>
 <20181118010229.esa32zk5hpob67y7@master>
 <d3e91590-adaa-11a5-67f9-0ef15df6b07d@oracle.com>
 <20181121030241.h7rgyjtlfcnm3hki@master>
 <9e238df6-d018-68b8-1c79-0c248abf0804@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e238df6-d018-68b8-1c79-0c248abf0804@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 07:18:13PM -0800, Wengang Wang wrote:
>Hi Wei,
>
>I think you will receive my reply to Zhong, But I am copying my comments for
>that patch here (again):
>
>Copy starts ==>
>
>I am not sure if the patch you mentioned intended to fix the problem here.
>With that patch the negative page->pobjects would become a large positive
>value,
>it will win the compare with s->cpu_partial and go ahead to unfreeze the
>partial slabs.
>Though it may be not a perfect fix for this issue, it really fixes (or
>workarounds) the issue here.
>I'd like to skip my patch..
>
><=== Copy ends

Thanks.

I still didn't get the point. Let's see whether I would get your replay
to that thread.

>
>thanks,
>
>wengang
>
>
>On 2018/11/20 19:02, Wei Yang wrote:
>> On Tue, Nov 20, 2018 at 09:58:58AM -0800, Wengang Wang wrote:
>> > Hi Wei,
>> > 
>> > 
>> > On 2018/11/17 17:02, Wei Yang wrote:
>> > > On Fri, Nov 16, 2018 at 05:33:35PM -0800, Wengang Wang wrote:
>> > > > The this_cpu_cmpxchg makes the do-while loop pass as long as the
>> > > > s->cpu_slab->partial as the same value. It doesn't care what happened to
>> > > > that slab. Interrupt is not disabled, and new alloc/free can happen in the
>> > > Well, I seems to understand your description.
>> > > 
>> > > There are two slabs
>> > > 
>> > >      * one which put_cpu_partial() trying to free an object
>> > >      * one which is the first slab in cpu_partial list
>> > > 
>> > > There is some tricky case, the first slab in cpu_partial list we
>> > > reference to will change since interrupt is not disabled.
>> > Yes, two slabs involved here just as you said above.
>> > And yes, the case is really tricky, but it's there.
>> > 
>> > > > interrupt handlers. Theoretically, after we have a reference to the it,
>> > >                                                                    ^^^
>> > > 							 one more word?
>> > sorry, "the" should not be there.
>> > 
>> > > > stored in _oldpage_, the first slab on the partial list on this CPU can be
>> > >                                               ^^^
>> > > One little suggestion here, mayby use cpu_partial would be more easy to
>> > > understand. I confused this with the partial list in kmem_cache_node at
>> > > the first time.  :-)
>> > Right, making others understanding easily is very important. I just meant
>> > cpu_partial.
>> > 
>> > > > moved to kmem_cache_node and then moved to different kmem_cache_cpu and
>> > > > then somehow can be added back as head to partial list of current
>> > > > kmem_cache_cpu, though that is a very rare case. If that rare case really
>> > > Actually, no matter what happens after the removal of the first slab in
>> > > cpu_partial, it would leads to problem.
>> > Maybe you are right, what I see is the problem on the page->pobjects.
>> > 
>> > > > happened, the reading of oldpage->pobjects may get a 0xdead0000
>> > > > unexpectedly, stored in _pobjects_, if the reading happens just after
>> > > > another CPU removed the slab from kmem_cache_node, setting lru.prev to
>> > > > LIST_POISON2 (0xdead000000000200). The wrong _pobjects_(negative) then
>> > > > prevents slabs from being moved to kmem_cache_node and being finally freed.
>> > > > 
>> > > > We see in a vmcore, there are 375210 slabs kept in the partial list of one
>> > > > kmem_cache_cpu, but only 305 in-use objects in the same list for
>> > > > kmalloc-2048 cache. We see negative values for page.pobjects, the last page
>> > > > with negative _pobjects_ has the value of 0xdead0004, the next page looks
>> > > > good (_pobjects is 1).
>> > > > 
>> > > > For the fix, I wanted to call this_cpu_cmpxchg_double with
>> > > > oldpage->pobjects, but failed due to size difference between
>> > > > oldpage->pobjects and cpu_slab->partial. So I changed to call
>> > > > this_cpu_cmpxchg_double with _tid_. I don't really want no alloc/free
>> > > > happen in between, but just want to make sure the first slab did expereince
>> > > > a remove and re-add. This patch is more to call for ideas.
>> > > Maybe not an exact solution.
>> > > 
>> > > I took a look into the code and change log.
>> > > 
>> > > _tid_ is introduced by commit 8a5ec0ba42c4 ('Lockless (and preemptless)
>> > > fastpaths for slub'), which is used to guard cpu_freelist. While we don't
>> > > modify _tid_ when cpu_partial changes.
>> > > 
>> > > May need another _tid_ for cpu_partial?
>> > Right, _tid_ changes later than cpu_partial changes.
>> > 
>> > As pointed out by Zhong Jiang, the pobjects issue is fixed by commit
>> Where you discussed this issue? Any reference I could get a look?
>> 
>> > e5d9998f3e09 (not sure if by side effect, see my replay there),
>> I took a look at this commit e5d9998f3e09 ('slub: make ->cpu_partial
>> unsigned int'), but not see some relationship between them.
>> 
>> Would you mind show me a link or cc me in case you have further
>> discussion?
>> 
>> Thanks.
>> 
>> > I'd skip this patch.?? If we found other problems regarding the change of
>> > cpu_partial, let's fix them. What do you think?
>> > 
>> > thanks,
>> > wengang

-- 
Wei Yang
Help you, Help me
