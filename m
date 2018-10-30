Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFC1C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3382C2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0aWIQci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3382C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeJaFiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 01:38:21 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40013 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeJaFiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 01:38:21 -0400
Received: by mail-lf1-f68.google.com with SMTP id n3-v6so9982150lfe.7;
        Tue, 30 Oct 2018 13:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xu5WEvOdkhwAcw/tDTH6tw+32SrXTot1y5NB/AFoBIs=;
        b=b0aWIQciD2DGRdfad6mVuqrT1TXY/CanJEtTZyG6XTjz+2+EOLjtS+rkfnpr2boN03
         oN9lVCpGlyc0tzzkI/I5TdRulXOXBnCtUmStuLEC424QT09opngSh3BEjE4ihuJXDcG3
         m+taoz6yBFDiLKzINxZZupGq8xq3fmGbW2J2Dc4n+4tUUciYVhR+T5ST3tUeXCRKz6W5
         HoeepadUg8CE5t6HfOzFnqMwpZoodPw3l0UXcacKN06WCuLjmHxVedUGoYk+x3AK5K5r
         s03Hn2XEzSk9Gy8m5mXkMQcJgu0soW8vQ+nxi8L8zbRSktJ7o/73zW8kG8MKcM2lWrwR
         q/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xu5WEvOdkhwAcw/tDTH6tw+32SrXTot1y5NB/AFoBIs=;
        b=MOwjWdxMkdASGOArDEjwpgnJfuS0MP7MFgBFviDz9GV8EkUTCsQnwi6oB45iCMUtL8
         2I+7dEt1lSYr0f555JNqc9dwGngv1LMF6G/66Ic7d4NbgcJsd0pEwpOWeAOhEwjj4c3D
         mnY3gJWk1SVOCWVOg3iWS6UNbDUxARoyv6Kz49BjNcW+jEUDSazyTs+I2OniOyLUOjAY
         L9sIc7fkMPEtcDw65na5/x2Lib5jKZSC/tODcBjgt+zJ2Rl9AXf7wvmEaHlIT5SjfNlr
         EA+hHdryj6ZTu0Fptt5PPYQXids/QH/OXYFcMA9cgt9+TTLWe6gIqjCp8xG70WEd4RJV
         zw4w==
X-Gm-Message-State: AGRZ1gIk1QOeoZvxAC4BZOvsMi6LlYUhel9As9hEECh3cQo7Z5naWogI
        i3cE92mXXMIx4ltTBEHmfRs=
X-Google-Smtp-Source: AJdET5dXWs7fa9BaqgZOVF6fMUdOnr5Ha1IdjeehNskiWZnKSyoAqYLsDI8EHJfZ96s+YcHb7RUc6A==
X-Received: by 2002:a19:ab1a:: with SMTP id u26-v6mr139559lfe.103.1540932196483;
        Tue, 30 Oct 2018 13:43:16 -0700 (PDT)
Received: from [192.168.10.160] (91-159-62-169.elisa-laajakaista.fi. [91.159.62.169])
        by smtp.gmail.com with ESMTPSA id s69-v6sm3848162lfs.92.2018.10.30.13.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 13:43:15 -0700 (PDT)
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Matthew Wilcox <willy@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>
Cc:     Andy Lutomirski <luto@amacapital.net>,
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
References: <20181023213504.28905-11-igor.stoppa@huawei.com>
 <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net>
 <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <20181030175814.GB10491@bombadil.infradead.org> <20181030182841.GE7343@cisco>
 <20181030192021.GC10491@bombadil.infradead.org>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <9edbdf8b-b5fb-5a82-43b4-b639f5ec8484@gmail.com>
Date:   Tue, 30 Oct 2018 22:43:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030192021.GC10491@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2018 21:20, Matthew Wilcox wrote:
> On Tue, Oct 30, 2018 at 12:28:41PM -0600, Tycho Andersen wrote:
>> On Tue, Oct 30, 2018 at 10:58:14AM -0700, Matthew Wilcox wrote:
>>> On Tue, Oct 30, 2018 at 10:06:51AM -0700, Andy Lutomirski wrote:
>>>>> On Oct 30, 2018, at 9:37 AM, Kees Cook <keescook@chromium.org> wrote:
>>>> I support the addition of a rare-write mechanism to the upstream kernel.
>>>> And I think that there is only one sane way to implement it: using an
>>>> mm_struct. That mm_struct, just like any sane mm_struct, should only
>>>> differ from init_mm in that it has extra mappings in the *user* region.
>>>
>>> I'd like to understand this approach a little better.  In a syscall path,
>>> we run with the user task's mm.  What you're proposing is that when we
>>> want to modify rare data, we switch to rare_mm which contains a
>>> writable mapping to all the kernel data which is rare-write.
>>>
>>> So the API might look something like this:
>>>
>>> 	void *p = rare_alloc(...);	/* writable pointer */
>>> 	p->a = x;
>>> 	q = rare_protect(p);		/* read-only pointer */

With pools and memory allocated from vmap_areas, I was able to say

protect(pool)

and that would do a swipe on all the pages currently in use.
In the SELinux policyDB, for example, one doesn't really want to 
individually protect each allocation.

The loading phase happens usually at boot, when the system can be 
assumed to be sane (one might even preload a bare-bone set of rules from 
initramfs and then replace it later on, with the full blown set).

There is no need to process each of these tens of thousands allocations 
and initialization as write-rare.

Would it be possible to do the same here?

>>>
>>> To subsequently modify q,
>>>
>>> 	p = rare_modify(q);
>>> 	q->a = y;
>>
>> Do you mean
>>
>>      p->a = y;
>>
>> here? I assume the intent is that q isn't writable ever, but that's
>> the one we have in the structure at rest.
> 
> Yes, that was my intent, thanks.
> 
> To handle the list case that Igor has pointed out, you might want to
> do something like this:
> 
> 	list_for_each_entry(x, &xs, entry) {
> 		struct foo *writable = rare_modify(entry);

Would this mapping be impossible to spoof by other cores?

I'm asking this because, from what I understand, local interrupts are 
enabled here, so an attack could freeze the core performing the 
write-rare operation, while another scrapes the memory.

But blocking interrupts for the entire body of the loop would make RT 
latency unpredictable.

> 		kref_get(&writable->ref);
> 		rare_protect(writable);
> 	}
> 
> but we'd probably wrap it in list_for_each_rare_entry(), just to be nicer.

This seems suspiciously close to the duplication of kernel interfaces 
that I was roasted for :-)

--
igor

