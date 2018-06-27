Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2511C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C47C24687
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8nL5kyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C47C24687
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965550AbeF0RdI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:33:08 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:46526 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965055AbeF0RdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:33:06 -0400
Received: by mail-vk0-f67.google.com with SMTP id b134-v6so1650567vke.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 10:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9EaVJyNOM2Blcaa/tm2TGOUCWmXDP+G1pKMt9UlwkPo=;
        b=P8nL5kyiKuZqi34L3TZbAiwmace3QMx2YmecQKguER/kQI58EIWWGSjAS/7jWb54a2
         kisXj+rn5avbuKzPxh9bNb4MYAp8wZzbSa+zopTAi8lYE34SJBF0TqHXFB0yYLsJBYwI
         m6ULLcfJK/IImwXaiKT+BRfuzMCOCx5pUyJU3jB13BPnIknWCUKkWUNHYkM1X3fxLi2M
         UO8Z43Bhcmdj4L1mdKtrEgRUv8hJjVBNbYTla8ap4YqifidPjJp4XV90Y7dS+ZL/NjsH
         PMmYp+Z9zeNeCyiWUoYRiuTlRZ9borpoqqwxL+293gCgs4VeC8f3NWVLilAZlLm+jNmn
         UPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9EaVJyNOM2Blcaa/tm2TGOUCWmXDP+G1pKMt9UlwkPo=;
        b=pghb5gZ+kYXMtauHDsl1jcTkIcANEb0xVRcsvAlY3TzzjPgwyrN3wowWXePBnQvdLQ
         umjRckdvkBWcUQH5yd7BwsjwTg1dQjO4M2V08x0TO+ST1BdoLStNpR9uWgmBwxgkfMxl
         8hdBA93rTQdHsIkcCUtQCxWjXd6oBvGcnYOkNWjV+HIs1ejILy1Pjf/TN8Wit8gr7Dp9
         4qDfoSdsEtNb2mlQGVaAf+CDWVlSqhVHn50yPT1psnBIPfCaNy9eXbhq/txL1mNfampM
         idF9HPpaQv59VcTw1zHY/GajlDVDocuAjh3Cn54JsZN0xXt6deL2fPQK17e1e4EJM/rS
         Ut3w==
X-Gm-Message-State: APt69E0/ZX2xmYBKPow+zRsGO810JNa1mC0fVrmyHYpbhfYVeenqv0hx
        GeQc+Ud324psA/A6ErUPBCFhS3BfujNCb2LudRE=
X-Google-Smtp-Source: AAOMgpcCCfBLWXTAFyLi9eranGaupkXPWwbWUfB5RwJCE4OSaAz/wPkzXzAnRPF3ZGSX0q0dft0VH3vu/gD6NywzMzQ=
X-Received: by 2002:a1f:20d4:: with SMTP id g203-v6mr3203567vkg.176.1530120786071;
 Wed, 27 Jun 2018 10:33:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 10:33:05
 -0700 (PDT)
In-Reply-To: <20180626193040.GO2494@hirez.programming.kicks-ass.net>
References: <20180625105952.3756-1-mark.rutland@arm.com> <20180625105952.3756-2-mark.rutland@arm.com>
 <CAHp75Vdsu2LQtPdjaxfYhc3qT6gOe7bdGQKB==52W-WpORp-WQ@mail.gmail.com> <20180626193040.GO2494@hirez.programming.kicks-ass.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Jun 2018 20:33:05 +0300
Message-ID: <CAHp75VfBd8zfNqkNvL=3Q3u3zJdiMFeakBPcX9r+-_Pqz1bRPA@mail.gmail.com>
Subject: Re: [PATCHv2 01/11] atomic/tty: Fix up atomic abuse in ldsem
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Hurley <peter@hurleysoftware.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 10:30 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Jun 26, 2018 at 09:53:18PM +0300, Andy Shevchenko wrote:
>> On Mon, Jun 25, 2018 at 1:59 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > From: Peter Zijlstra <peterz@infradead.org>
>> >
>> > Mark found ldsem_cmpxchg() needed an (atomic_long_t *) cast to keep
>> > working after making the atomic_long interface type safe.
>> >
>> > Needing casts is bad form, which made me look at the code. There are no
>> > ld_semaphore::count users outside of these functions so there is no
>> > reason why it can not be an atomic_long_t in the first place, obviating
>> > the need for this cast.
>> >
>> > That also ensures the loads use atomic_long_read(), which implies (at
>> > least) READ_ONCE() in order to guarantee single-copy-atomic loads.
>> >
>> > When using atomic_long_try_cmpxchg() the ldsem_cmpxchg() wrapper gets
>> > very thin (the only difference is not changing *old on success, which
>> > most callers don't seem to care about).
>> >
>> > So rework the whole thing to use atomic_long_t and its accessors
>> > directly.
>> >
>> > While there, fixup all the horrible comment styles.
>>
>>
>> > -               ldsem_atomic_update(-LDSEM_WAIT_BIAS, sem);
>> > +               atomic_long_add_return(-LDSEM_WAIT_BIAS, &sem->count);
>>
>> I suppose it's simple atomic_long_add() here?
>
> Different ordering rules for those two. I didn't look hard enough to see
> if that mattered here.

Indeed. So, to follow semantics it would be something like

smp_mb__before_atomic();
atomic_long_add_relaxed();
smp_mb__after_atomic();

though I do not dare to convert that way (as I understood the simple
atomic_long_add_return() variant might be implemented better).

-- 
With Best Regards,
Andy Shevchenko
