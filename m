Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B90ECDE48
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CB02075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbI9zD0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CB02075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeJYHWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 03:22:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42698 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJYHWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 03:22:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id y15-v6so2866772wru.9;
        Wed, 24 Oct 2018 15:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b7PS5g357cXYpMQNoDC0NRlpVAb0p6ug6D5Mo4tpd6w=;
        b=RbI9zD0MztRELhCdX3ajvA6fO+ThEWsIqkV5r1wtfVKmDeSLsbgx3bUWW9PSLYuLBW
         SCxroi2RzF0/ZiAK5xoB1bBbRH2Waun2fXmLgSG9ptLdN1vEWkEF2uOoJ+SRcCUJytoi
         4mkG4RIPDtnvoMOja4hPvwZ9qvjQBgLJCvcyjIkcA/gTnScNbaruynRy77UZAHqIWNyy
         2FPZ2ULRRcwPEBlUdXDe+SWPGLScyiCLvDFpC6URQZuNyiRaV9XNm57k6X+UpE7dHwQk
         JgMhSYKbJJ43yzcUq3AAnFFfTJGQRbyW0Xh0CpRAlHg+GG/elbBZj/zXYmGTaJwSU8s6
         Br7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b7PS5g357cXYpMQNoDC0NRlpVAb0p6ug6D5Mo4tpd6w=;
        b=nl0lcQwhWpefu1ZzHNr26ufZEDMUuzPw5ly7y/74VfChZZQ3ml2j1T25u9Y6tWpEkx
         r6Ax4gqeouhmNFvhdUwUn6hmhOB+8lUr4pTzF3gpSPozF1aRSTbmI4a2ItDLEed56dOC
         haWvwD133KRTnTm6jggHo7CUI+hbANL5XroElf0kOohAb0p/2Q4IAa29GN2PkpTzCz7D
         cI+k3fUIbLbsRPPOifWYfNhg1PcWcxZgtAEu3R8h9f/SvujVMK5LPig38LAkcfBn9ASl
         WUAmTUvbMAXgeNgLZ2k9y1S04xYKqsQoBRHVVOLVtrlcO5/xrNt50d+GBbm1V2ojFKRs
         SuBA==
X-Gm-Message-State: AGRZ1gK3qSsa4UFPi2aw7yoSbtOCpGXO1tncxfjqcH9f393CNNRryX3f
        6Ji7cW2/ELO8ejCxll7Nc7OsUqrRni5Tdw==
X-Google-Smtp-Source: AJdET5f7oQ1VJdOLzlUEI8yoM3RYFSRILn7zM8AXhhsgJsuynaUYR9lbqWpjr379I87kYQ+ViBlZkw==
X-Received: by 2002:adf:f90b:: with SMTP id b11-v6mr1606405wrr.307.1540421533809;
        Wed, 24 Oct 2018 15:52:13 -0700 (PDT)
Received: from [10.17.176.77] ([109.144.211.182])
        by smtp.gmail.com with ESMTPSA id x8-v6sm12829794wrd.54.2018.10.24.15.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 15:52:13 -0700 (PDT)
Subject: Re: [PATCH 14/17] prmem: llist, hlist, both plain and rcu
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        igor stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-15-igor.stoppa@huawei.com>
 <1634210774.446.1540381072927.JavaMail.zimbra@efficios.com>
 <243a8ff2-889c-089f-a1ff-c882933ca5c3@gmail.com>
 <20181024145606.GA9019@cisco>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <d630474b-73a5-c6ae-2141-49c1184381b2@gmail.com>
Date:   Thu, 25 Oct 2018 01:52:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181024145606.GA9019@cisco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2018 17:56, Tycho Andersen wrote:
> On Wed, Oct 24, 2018 at 05:03:01PM +0300, Igor Stoppa wrote:
>> On 24/10/18 14:37, Mathieu Desnoyers wrote:
>>> Also, is it the right approach to duplicate existing APIs, or should we
>>> rather hook into page fault handlers and let the kernel do those "shadow"
>>> mappings under the hood ?
>>
>> This question is probably a good candidate for the small Q&A section I have
>> in the 00/17.
>>
>>
>>> Adding a new GFP flags for dynamic allocation, and a macro mapping to
>>> a section attribute might suffice for allocation or definition of such
>>> mostly-read-only/seldom-updated data.
>>
>> I think what you are proposing makes sense from a pure hardening standpoint.
>>  From a more defensive one, I'd rather minimise the chances of giving a free
>> pass to an attacker.
>>
>> Maybe there is a better implementation of this, than what I have in mind.
>> But, based on my current understanding of what you are describing, there
>> would be few issues:
>>
>> 1) where would the pool go? The pool is a way to manage multiple vmas and
>> express common property they share. Even before a vma is associated to the
>> pool.
>>
>> 2) there would be more code that can seamlessly deal with both protected and
>> regular data. Based on what? Some parameter, I suppose.
>> That parameter would be the new target.
>> If the code is "duplicated", as you say, the actual differences are baked in
>> at compile time. The "duplication" would also allow to have always inlined
>> functions for write-rare and leave more freedom to the compiler for their
>> non-protected version.
>>
>> Besides, I think the separate wr version also makes it very clear, to the
>> user of the API, that there will be a price to pay, in terms of performance.
>> The more seamlessly alternative might make this price less obvious.
> 
> What about something in the middle, where we move list to list_impl.h,
> and add a few macros where you have list_set_prev() in prlist now, so
> we could do,
> 
> // prlist.h
> 
> #define list_set_next(head, next) wr_ptr(&head->next, next)
> #define list_set_prev(head, prev) wr_ptr(&head->prev, prev)
> 
> #include <linux/list_impl.h>
> 
> // list.h
> 
> #define list_set_next(next) (head->next = next)
> #define list_set_next(prev) (head->prev = prev)
> 
> #include <linux/list_impl.h>
> 
> I wonder then if you can get rid of some of the type punning too? It's
> not clear exactly why that's necessary from the series, but perhaps
> I'm missing something obvious :)

nothing obvious, probably there is only half a reference in the slides I 
linked-to in the cover letter :-)

So far I have minimized the number of "intrinsic" write rare functions,
mostly because I would want first to reach an agreement on the 
implementation of the core write-rare.

However, once that is done, it might be good to convert also the prlists 
to be "intrinsics". A list node is 2 pointers.
If that was the alignment, i.e. __align(sizeof(list_head)), it might be 
possible to speed up a lot the list handling even as write rare.

Taking as example the insertion operation, it would be probably 
sufficient, in most cases, to have only two remappings:
- one covering the page with the latest two nodes
- one covering the page with the list head

That is 2 vs 8 remappings, and a good deal of memory barriers less.

This would be incompatible with what you are proposing, yet it would be 
justifiable, I think, because it would provide better performance to 
prlist, potentially widening its adoption, where performance is a concern.

> I also wonder how much the actual differences being baked in at
> compile time makes. Most (all?) of this code is inlined.

If the inlined function expects to receive a prlist_head *, instead of a 
list_head *, doesn't it help turning runtime bugs into buildtime bugs?


Or maybe I miss your point?

--
igor
