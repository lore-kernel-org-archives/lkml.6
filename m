Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FFFC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AE022436
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="E9/rxS8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00AE022436
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752693AbeGDOIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:08:39 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45359 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752611AbeGDOIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:08:37 -0400
Received: by mail-wr0-f194.google.com with SMTP id u7-v6so5451798wrn.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FaSkkyqIRfQnsqWaqHGzbnHbHbfVhaQcHbXsk7xaCLw=;
        b=E9/rxS8nAuUQ6VMkTscyfit6Qh7Slnloj3P1t9HbtwCFgvnEoWy1jLrBXSdAjcTbqM
         +3HW46q+X8GOzdE4Rsf094SX+7EBb0DR4jqKme1xhyb92UbJ13EfXaIQDK7CzfgmlMyJ
         eTG5CNXExm+6FBMxEsIL5VdkKcsiy4hXqWuIotC7Lcs7pGxihtZ+gqUp1Zyd8DcDFSkX
         ln0GcbCXtxVq56/092bqywuTT3g3cDmZVeR/L7Vb/1nQhs9EGV7wLoKML58OLr4VbqkK
         roPYjGYn9U8wyZ895VmY2W3guCabX9eZrbFB1mLZRl+7rBgktr9L1EgB7/GopVkxyTMC
         4yLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FaSkkyqIRfQnsqWaqHGzbnHbHbfVhaQcHbXsk7xaCLw=;
        b=cgIJm1/fVCTkMyf1F9v1UB05xON0WyZlUwKuR5Xn6wpAXvAv/HxHsVGPrxrUx/ZjA3
         bUCwtJmMeRWP6LdVWr76ZYFmwLoCSFKy9MEOnYkQ8T61jHWSUe7nZtyMtd6arS2Yqj8f
         V06vvzUXZlduYsBaTaT1RWJutQaUXfordX38gf5nlDUiAVlFHQ2l/4V5vmdr2ld8GWbQ
         iVTxCRIiaTBmqmtwxEdkWW4yeqU6l8JOQcm4T0H2gh0EbXKQ+ExxoH72iZO4U79RZuaP
         XbnORs0lkACezUs8wBPz2uqzuJRw6qebcGo1qSIiaVzeIAY1Txq9BV0S6jLsZYN1ZdNK
         OjQw==
X-Gm-Message-State: APt69E0oQ0yfEWWwQ3JdIaTlWt1zWtYf1GllfO+nEKGfwJRIdAmWZqeB
        3awE+cQu9mZ5elOGX4KbNStQfg==
X-Google-Smtp-Source: AAOMgpdBmVD283bs0OhMnnuChrzyE1AKh7S3fd2iW5qURMYL6YUr0KK6FoPwGKq2MKkuJ49ZbJSLbg==
X-Received: by 2002:a5d:4452:: with SMTP id x18-v6mr1832491wrr.227.1530713315501;
        Wed, 04 Jul 2018 07:08:35 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C3350004CADE66801158EF.dip0.t-ipconnect.de. [2003:d9:93c3:3500:4ca:de66:8011:58ef])
        by smtp.googlemail.com with ESMTPSA id 77-v6sm2220713wmq.22.2018.07.04.07.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 07:08:34 -0700 (PDT)
Subject: Re: ipc/msg: zalloc struct msg_queue when creating a new msq
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        syzbot <syzbot+2827ef6b3385deb07eaf@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, linux@dominikbrodowski.net,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Dumazet <edumazet@google.com>
References: <000000000000e403b3056e76c786@google.com>
 <20180624025651.bvjlcfulbmycz5bf@linux-r8p5>
 <CACT4Y+anMTUCaRH5D4QoZR4bLdtH=_wtCxK2dM6isJozbVThDg@mail.gmail.com>
 <ff30f992-9c75-f230-c86a-902373f4ecaa@colorfullife.com>
 <CACT4Y+ZX0VSf23PTGpfwps4T0itMV-ZnSDQx6SuOucBE9sPSEw@mail.gmail.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <b9ffe11e-c63f-c5fb-f5e8-fc4eb8c4f0fa@colorfullife.com>
Date:   Wed, 4 Jul 2018 16:08:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZX0VSf23PTGpfwps4T0itMV-ZnSDQx6SuOucBE9sPSEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry,
On 07/04/2018 12:03 PM, Dmitry Vyukov wrote:
> On Wed, Jul 4, 2018 at 11:18 AM, Manfred Spraul
> <manfred@colorfullife.com> wrote:
>>
>> There are 2 relevant values: kern_ipc_perm.id and kern_ipc_perm.seq.
>>
>> For kern_ipc_perm.id, it is possible to move the access to the codepath that
>> hold the lock.
>>
>> For kern_ipc_perm.seq, there are two options:
>> 1) set it before publication.
>> 2) initialize to an invalid value, and correct that at the end.
>>
>> I'm in favor of option 2, it avoids that we must think about reducing the
>> next sequence number or not:
>>
>> The purpose of the sequence counter is to minimize the risk that e.g. a
>> semop() will write into a newly created array.
>> I intentially write "minimize the risk", as it is by design impossible to
>> guarantee that this cannot happen, e.g. if semop() sleeps at the instruction
>> before the syscall.
>>
>> Therefore, we can set seq to ULONG_MAX, then ipc_checkid() will always fail
>> and the corruption is avoided.
>>
>> What do you think?
>>
>> And, obviously:
>> Just set seq to 0 is dangerous, as the first allocated sequence number is 0,
>> and if that object is destroyed, then the newly created object has
>> temporarily sequence number 0 as well.
> Hi Manfred,
>
> It still looks fishy to me. This code published uninitialized uid's
> for years (which lead not only to accidentally accessing wrong
> objects, but also to privilege escalation). Now it publishes uninit
> id/seq. The first proposed fix still did not make it correct. I can't
> say that I see a but in your patch, but initializing id/seq in a racy
> manner rings bells for me. Say, if we write/read seq ahead of id, can
> reader still get access to a wrong object?
> It all suggests some design flaw to me. Could ipc_idr_alloc() do full
> initialization, i.e. also do what ipc_buildid() does? This would
> ensure that we publish a fully constructed object in the first place.
> We already have cleanup for ipc_idr_alloc(), which is idr_remove(), so
> if we care about seq space conservation even in error conditions
> (ENOMEM?), idr_remove() could accept an additional flag saying "this
> object should not have been used by sane users yet, so retake its
> seq". Did I get your concern about seq properly?
You have convinced me, I'll rewrite the patch:

1) kern_ipc_perm.seq should be accessible under rcu_read_lock(), this 
means replacing ipc_build_id() with two functions:
One that initializes kern_ipc_perm.seq, and one that would set 
kern_ipc_perm.id.
2) the accesses to kern_ipc_perm.id must be moved to the position where 
the lock is held. This is trivial.
3) we need a clear table that describes which variables can be accessed 
under rcu_read_lock() and which need ipc_lock_object().
   e.g.: kern_ipc_perm.id would end up under ipc_lock_object, 
kern_ipc_perm.seq or the xuid fields can be read under rcu_read_lock().
   Everything that can be accessed without ipc_lock_object must be 
initialized before publication of a new object.

Or, as all access to kern_ipc_perm.id are in rare codepaths:
I'll remove kern_ipc_perm.id entirely, and build the id on demand.

Ok?

--
     Manfred
