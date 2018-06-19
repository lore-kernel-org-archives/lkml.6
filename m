Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76204C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2397220836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZaRwBa6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2397220836
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757265AbeFSNRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:17:21 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45349 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756675AbeFSNRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:17:19 -0400
Received: by mail-pl0-f66.google.com with SMTP id c23-v6so10942327plz.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 06:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JGHpAec035pn7EWQUeWVNHXsdxbfHmwPOrB1M3nA4YY=;
        b=ZaRwBa6YDFlxU5JzD6W8Dc3hLDlqG8UwGGEr5B0JHg/JtztD6gpFGantST5sH8YWcq
         d4BOPN1RxxMGxF82I5+twIR0n3TxtcLHePT3nM0EN5wwCJNq+4RRDEv7MpHh4rWqzdaa
         muJn0z4bgQCoUv6y34LL0G6fLs2KVkI/+CDoORKbVMERxg0C7ycmjZoCu+Avw9Z/j/eu
         LlmFyXwFzhUN4dlmHryeKUa5wpI8y/SdWaKSRpPaQchG/2N3RBSvFsgDeuarPbAmPHoE
         AzDvxRzTV0j8J0ISvpTd03zDKKKQ0YV3ia9unTYTAiQq95w8JWrtC2/RzzRl17w6Cezm
         WpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JGHpAec035pn7EWQUeWVNHXsdxbfHmwPOrB1M3nA4YY=;
        b=eW3U5zcM5Sx4qyzU92ZD1V9CFFJfxWV7IPWjjhgWuH4UJBFwCu+8DwQTEdKtPdVNs9
         9rJd9oDUXCkq+yA6goQtWSNfnpvux6HGiTlS/jBVQ7n1ETus8JLTcYpdjAIP1QO2Ezn6
         9ZiCWlrv5ZPzyyNXhORH8NT7S2hpocMMFYdmxgRp6vO4c7LoVP3g4KO63fcnj7zoHJMP
         c0A0eviUKmPQG9eC/GGoq/SZDIrBjHk4KcyP6Cf1x3i5ttYeIZMi0BuqeG61xuV7RiNH
         U/QU5jxTtWkjjnlxTeCUd8m+/8qovJJ13CBGyk5vT1HqKJUm9AfR2Z0nULkJ7o00392h
         OIzg==
X-Gm-Message-State: APt69E2uI6NpB/mW1nib2mSPWpAcWTlGlZyZFgnKtIG4Bru8JOsV6KQs
        dG53r0xlam3qL6e480p1+nJ8TG/UQHETs93Irryo2g==
X-Google-Smtp-Source: ADUXVKJ4FlkLZVDh3O4kQN55mDbsy7dcZ3/AS/L7LqDayj7W6+k4TO8sw66NNmJ5rHaOuTyEwdCgrrlPJOmTl9AZK9o=
X-Received: by 2002:a17:902:8491:: with SMTP id c17-v6mr18674320plo.97.1529414238787;
 Tue, 19 Jun 2018 06:17:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Tue, 19 Jun 2018 06:16:58
 -0700 (PDT)
In-Reply-To: <CAHmME9oeoSbRZyf6qJTg+q-zZanYGu4q=YOZNqCCbRAFu15R9w@mail.gmail.com>
References: <CAHmME9rtoPwxUSnktxzKso14iuVCWT7BE_-_8PAC=pGw1iJnQg@mail.gmail.com>
 <CALvZod6Dxx79ztxzHsDVe6pj7Fa7ydJAjMf_EHV9H15+AsVwdA@mail.gmail.com>
 <CAHmME9qvRDQOJYdSPaAf-hg5raacu4TBgStLy7NzFL+j+dXheQ@mail.gmail.com>
 <CACT4Y+YLySJMfG4kCJ2FiPpPtN6sgU6k2FoZUYMFrJGLj+vDjw@mail.gmail.com> <CAHmME9oeoSbRZyf6qJTg+q-zZanYGu4q=YOZNqCCbRAFu15R9w@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 19 Jun 2018 15:16:58 +0200
Message-ID: <CACT4Y+YAYwXrTkawfPWMhX5tk85f9CDfN_w+5JfykgDnOG57PQ@mail.gmail.com>
Subject: Re: Possible regression in "slab, slub: skip unnecessary kasan_cache_shutdown()"
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 3:04 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> HI Dimitry,
>
> On Tue, Jun 19, 2018 at 6:55 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>> Your code frees all entries before freeing the cache, right? If you
>> add total_entries check before freeing the cache, it does not fire,
>> right?
>
> Yes, certainly.
>
>> Are you using SLAB or SLUB? We stress kernel pretty heavily, but with
>> SLAB, and I suspect Shakeel may also be using SLAB. So if you are
>> using SLUB, there is significant chance that it's a bug in the SLUB
>> part of the change.
>
> Nice intuition; I am indeed using SLUB rather than SLAB...

Now the reasonable question is: does SLUB path of
f9e13c0a5a33d1eaec374d6d4dab53a4f72756a0 have a bug?
syzbot has stressed SLAB version to death, and any such issues would
pop up very loudly, but I am not sure what is the amount of testing
for SLUB.
