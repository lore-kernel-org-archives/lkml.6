Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8748AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCFA21479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BEm+TsKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BCFA21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeJJRT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:19:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46441 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbeJJRT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:19:27 -0400
Received: by mail-io1-f68.google.com with SMTP id t7-v6so3398994ioj.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 02:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ek5gZf8SEwoFB6tTmpdxgcujl0KPzmwCj2JurZyr7Qg=;
        b=BEm+TsKHi6EEbm2U2AlyhAAwKeSQZ9q9bqpFc1YN3caQNbNikZfWngg0+K7xLlsbzb
         YDyhJLn0S8ADDR/3vaHpPlQlLoM3K7rKLaPVvzJJrfzmOopDHRZKTRGaHTjWlSjPWp3Z
         WElRYHapTHzI+hSL1ejg+uJgH8ppruA4pFNXGtA0iGvk7+X8pmOTnbCAuEmJYv4wqxmn
         4V5r+ppUZbe7618lWLqr6d1qRB7EOtVXXsFH62Bo8lwMnWGewXNp8LBJ2ShrCyv0QN4x
         4wAhHtmL5jSZULalJ4djmc2gwd2xW3OXtMr9/raE+1rrVrHY/Qx7iHSobF1w+E1FwC3b
         FDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ek5gZf8SEwoFB6tTmpdxgcujl0KPzmwCj2JurZyr7Qg=;
        b=S77AuY7V+Juk8e6bKaI8cfyzxhL0DrjgN3qKvZ/SiPBY8tmqgRWo2lR3qiioFjEuHX
         L2apH8lzdrPlbx6nxR+f4T1VkkXGW9L2fOSM7gH92K91YP0Z05q+edgKDM50vNsm0312
         D+5EKPB98n2Sn6HtyT4Iz5pd24PVwXL6MaeqxnAOT14F/KhHAB/ENGOI2eTTUNzkjNZ5
         0SKq1GtuLcJLKHSBf2oIWA//Z8oy8/00oSP8Ar+7EIyB4icWGE9HAvx4jq35Bf8fyHW0
         cr6uUf0kdIUe6RgkNJwekIQkj7VdfbiKVYsQSIcSYPTRd49Hf6VG/0X490+pk0EnU8F3
         pTNQ==
X-Gm-Message-State: ABuFfoiD/rYkY79D8U1gjvvdtyfsj52E3Ie8iP5qjAbJtva1s4pi9BeV
        +T80WWz8/mJaM5/7VzCUEEcnbsal6B+5XBucnCfSrQ==
X-Google-Smtp-Source: ACcGV62wnqdZyrPbAcIkW1s6UTQAyUftnt+oTS7KaWx7dbW8kSlURm3bdol8aSGTJ8GCqW3XkfX/7/Jn2jSTQFj9j5w=
X-Received: by 2002:a6b:8b97:: with SMTP id n145-v6mr15831667iod.282.1539165481741;
 Wed, 10 Oct 2018 02:58:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 02:57:41
 -0700 (PDT)
In-Reply-To: <20181010095343.6qxved3owi6yokoa@linutronix.de>
References: <20180918152931.17322-1-williams@redhat.com> <20181005163018.icbknlzymwjhdehi@linutronix.de>
 <20181005163320.zkacovxvlih6blpp@linutronix.de> <CACT4Y+YoNCm=0C6PZtQR1V1j4QeQ0cFcJzpJF1hn34Oaht=jwg@mail.gmail.com>
 <20181009142742.ikh7xv2dn5skjjbe@linutronix.de> <CACT4Y+ZB38pKvT8+BAjDZ1t4ZjXQQKoya+ytXT+ASQxHUkWwnA@mail.gmail.com>
 <20181010092929.a5gd3fkkw6swco4c@linutronix.de> <CACT4Y+agGPSTZ-8A8r8haSeRM8UpRYMAF8BC4A87yeM9nvpP6w@mail.gmail.com>
 <20181010095343.6qxved3owi6yokoa@linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Oct 2018 11:57:41 +0200
Message-ID: <CACT4Y+ZpMjYBPS0GHP0AsEJZZmDjwV9DJBiVUzYKBnD+r9W4+A@mail.gmail.com>
Subject: Re: [PATCH] kasan: convert kasan/quarantine_lock to raw_spinlock
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Clark Williams <williams@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 11:53 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2018-10-10 11:45:32 [+0200], Dmitry Vyukov wrote:
>> > Should I repost Clark's patch?
>>
>>
>> I am much more comfortable with just changing the type of the lock.
>
> Yes, that is what Clark's patch does. Should I resent it?


Yes. Clark's patch looks good to me. Probably would be useful to add a
comment as to why raw spinlock is used (otherwise somebody may
refactor it back later).


>> What are the bad implications of using the raw spinlock? Will it help
>> to do something along the following lines:
>>
>> // Because of ...
>> #if CONFIG_RT
>> #define quarantine_spinlock_t raw_spinlock_t
>> #else
>> #define quarantine_spinlock_t spinlock_t
>> #endif
>
> no. For !RT spinlock_t and raw_spinlock_t are the same. For RT
> spinlock_t does not disable interrupts or preemption while
> raw_spinlock_t does.
> Therefore holding a raw_spinlock_t might increase your latency.

Ack.
