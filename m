Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1184BC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB45B2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTqlyTCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB45B2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeJaGo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:44:27 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42037 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeJaGo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:44:27 -0400
Received: by mail-lj1-f193.google.com with SMTP id f3-v6so12890549ljk.9;
        Tue, 30 Oct 2018 14:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9gl8AdXDJcsEfO/u8owGMVyrsCHiw9dEED9FVNch6HM=;
        b=pTqlyTCCU/6bvOxMU6QtG2SA9sIfzQHw9qTJo5CaRuX0xs2vWdyTXez8LSeKMM0H2j
         sLiGaY5YGwGn3JSSEHf5rMRsYKnWSVlDEwEwb1wxJOaj4Md1+on/x8/PFk7reg2Z8fPK
         65LWJp8LBMjItp5MHR6l+2cB9o8weBkiGojpQ69aGGqKvYCepfL8JqrWwCk57iYstySD
         pRe7S4ahdibjQtn+VzAX98Ut1VtOJEQmYV/kw6Kqfc9zhEGwRARllJMMHEYTdBqop2xH
         nt6jgPuJGnAv6vtt7FWImGeaqHYz8cqhqkkOouI9MILSpxSDrIf0Ut4oZznMKLS7Ql7x
         qsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9gl8AdXDJcsEfO/u8owGMVyrsCHiw9dEED9FVNch6HM=;
        b=eJwsmgHLG3XFHrKXs+BcYs4l5toKIL5solTIEn6xvJryGUIasKIQqpMjMgQusayHr/
         7wZ4Uj2g9/0AeU4hfFj0fADtXSNN67pUXkg+mbmsNTuAXM9zwO18BSj+AAKNW/ULZhBo
         Ggb+U0Z+Huwd1qLEEnyeKwsq4YHOJm5ZkHIDFZvnWfx7Y15+fEzTNcZn0i0KXyGszNW9
         DpwG7Bjv78p1wzFhzGnnZ8JL6Fkpm70oJKlKo4d476Zo2/xH9H8wq3K0++NRjZIWSv04
         kSPTHlmQ6A8BXgFTO9HhSBQZFX/WdnSur2qUguDxIE0OHGlr6IoG5uAyGCjosoeqEYDD
         J4kQ==
X-Gm-Message-State: AGRZ1gJzLmmMyroN/8mMbu3cqrIEs4rTTinDCYwoHZEN+83GkvmIyzq4
        ywYvH5YUoWdvr75PaZpvJZI=
X-Google-Smtp-Source: AJdET5fRN09Ty4enu79g9N6X54IF4aOEztg6fkfApsZkEetRpSHHkt6mp0ZfqNyrB6UU2xh+HBr1ow==
X-Received: by 2002:a2e:4218:: with SMTP id p24-v6mr283408lja.58.1540936154022;
        Tue, 30 Oct 2018 14:49:14 -0700 (PDT)
Received: from [192.168.10.160] (91-159-62-242.elisa-laajakaista.fi. [91.159.62.242])
        by smtp.gmail.com with ESMTPSA id t6-v6sm3631523ljd.2.2018.10.30.14.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 14:49:13 -0700 (PDT)
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net>
 <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <20181030175814.GB10491@bombadil.infradead.org> <20181030182841.GE7343@cisco>
 <20181030192021.GC10491@bombadil.infradead.org>
 <9edbdf8b-b5fb-5a82-43b4-b639f5ec8484@gmail.com>
 <20181030213557.GE10491@bombadil.infradead.org>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <1245ce5b-5c36-7b5e-6bd7-b7bfeb3848b5@gmail.com>
Date:   Tue, 30 Oct 2018 23:49:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030213557.GE10491@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2018 23:35, Matthew Wilcox wrote:
> On Tue, Oct 30, 2018 at 10:43:14PM +0200, Igor Stoppa wrote:


>> Would it be possible to do the same here?
> 
> What Andy is proposing effectively puts all rare allocations into
> one pool.  Although I suppose it could be generalised to multiple pools
> ... one mm_struct per pool.  Andy, what do you think to doing that?

The reason to have pools is that, continuing the SELinux example, it 
supports reloading the policyDB.

In this case it seems to me that it would be faster to drop the entire 
pool in one go, and create a new one when re-initializing the rules.

Or maybe the pool could be flushed, without destroying the metadata.
One more reason for having pools is to assign certain property to the 
pool and then rely on it to be applied to every subsequent allocation.

I've also been wondering if pools can be expected to have some well 
defined property.

One might be that they do not need to be created on the fly.
The number of pools should be known at compilation time.
At least the meta-data could be static, but I do not know how this would 
work with modules.

>>> but we'd probably wrap it in list_for_each_rare_entry(), just to be nicer.
>>
>> This seems suspiciously close to the duplication of kernel interfaces that I
>> was roasted for :-)
> 
> Can you not see the difference between adding one syntactic sugar function
> and duplicating the entire infrastructure?

And list_add()? or any of the other list related functions?
Don't they end up receiving a similar treatment?

I might have misunderstood your proposal, but it seems to me that they 
too will need the same type of pairs rare_modify/rare_protect. No?

And same for hlist, including the _rcu variants.

--
igor
