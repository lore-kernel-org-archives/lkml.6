Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD1AC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E915214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZWcCubWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E915214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeJKP3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:29:35 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34000 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbeJKP3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:29:35 -0400
Received: by mail-it1-f194.google.com with SMTP id l127-v6so18146206ith.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d12y+ockzhXJH0TpWpp6L28F6LM4TlHubeWxTlxeIeI=;
        b=ZWcCubWiQHimSR7/kAE6RojrQuAyq0c7geLi/zHhALNHDdOJzL71cR7oAxDlHg1c6b
         hk+BfkF7cbrsswcJM4y5XenoBcwjKZ9aJgFo6JXUStwSZoCQNEesB8AXSeNwbu5/VOHD
         nT+PX9zEPX41xQnIaM3BO/vL5lbXvPCI8GO3XF2uJXJ/SOGivTOeDhRRuLJfSkTeSoNs
         AwFu+V7tRCuBNFXQLp2DrEJJ1SFG10+cJdOl8uNjywKep6Q4/qUSLoSwaFaQ1v8/jUqc
         ijsyBPxA9N3xL3wqdCLpcRMxktvJ4sLUwg6jWBAjzFP5fHXysEAOsYROzjkfGKaEaocg
         A85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d12y+ockzhXJH0TpWpp6L28F6LM4TlHubeWxTlxeIeI=;
        b=k7y/fBKsaoEx11GuLDrfBWtasDNDbSeVPGiOAUfvtP+dq4S0RaMlk6mz/6/tP6D5LV
         djMWxC0Qe5+9hr7SA9iouVSlk5zqSMjvmgYTlBDdl+rSDTIfiqN8x9djhi3tes66I/ZL
         xlUMzBq9wwy//zPjAtRaxbPCCLBwXqKd7EvchFHE1uWDmPNyHCeD4J0w2zwy32qayv82
         PuH+YYv0Uy+3hJYITggapxOPmddk6nWibHyLOI/o40C+uPvX/Xom6NVkxVKyas32Zdlc
         jSVKwQ9tQMytnjl30QZLEXhgJDVh7/+k0GenODAVtonFxF0xv1G/ZVkswkKk3d2ROgZu
         fBag==
X-Gm-Message-State: ABuFfoigBnUk/++8mCNDnPj/ZUumaJYcZfvlzGs/gnVI6B7PvsKML16u
        TNjaMzFM4WPJE9OwlX+si+8p6tH4YlgKr4t5u4L/rQ==
X-Google-Smtp-Source: ACcGV606H/xhxWLh3lgUUI3Jbnwo45aojTvez78hS8PtWd/i9dPrV31eTlQRAwqeGPe9GEN47fHGg11nz0BJXaWomtg=
X-Received: by 2002:a02:97c5:: with SMTP id v5-v6mr388808jaj.72.1539245006985;
 Thu, 11 Oct 2018 01:03:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 01:03:06
 -0700 (PDT)
In-Reply-To: <20181010214945.5owshc3mlrh74z4b@linutronix.de>
References: <20180918152931.17322-1-williams@redhat.com> <20181005163018.icbknlzymwjhdehi@linutronix.de>
 <20181005163320.zkacovxvlih6blpp@linutronix.de> <CACT4Y+YoNCm=0C6PZtQR1V1j4QeQ0cFcJzpJF1hn34Oaht=jwg@mail.gmail.com>
 <20181009142742.ikh7xv2dn5skjjbe@linutronix.de> <CACT4Y+ZB38pKvT8+BAjDZ1t4ZjXQQKoya+ytXT+ASQxHUkWwnA@mail.gmail.com>
 <20181010092929.a5gd3fkkw6swco4c@linutronix.de> <CACT4Y+agGPSTZ-8A8r8haSeRM8UpRYMAF8BC4A87yeM9nvpP6w@mail.gmail.com>
 <20181010095343.6qxved3owi6yokoa@linutronix.de> <CACT4Y+ZpMjYBPS0GHP0AsEJZZmDjwV9DJBiVUzYKBnD+r9W4+A@mail.gmail.com>
 <20181010214945.5owshc3mlrh74z4b@linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 11 Oct 2018 10:03:06 +0200
Message-ID: <CACT4Y+Zj0pBR_C-6fcMkFkrkKh-LwDupNHDz=ud7HJomtvFUVw@mail.gmail.com>
Subject: Re: [PATCH] mm/kasan: make quarantine_lock a raw_spinlock_t
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Clark Williams <williams@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 11:49 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> From: Clark Williams <williams@redhat.com>
> Date: Tue, 18 Sep 2018 10:29:31 -0500
>
> The static lock quarantine_lock is used in quarantine.c to protect the
> quarantine queue datastructures. It is taken inside quarantine queue
> manipulation routines (quarantine_put(), quarantine_reduce() and
> quarantine_remove_cache()), with IRQs disabled.
> This is not a problem on a stock kernel but is problematic on an RT
> kernel where spin locks are sleeping spinlocks, which can sleep and can
> not be acquired with disabled interrupts.
>
> Convert the quarantine_lock to a raw spinlock_t. The usage of
> quarantine_lock is confined to quarantine.c and the work performed while
> the lock is held is used for debug purpose.
>
> Signed-off-by: Clark Williams <williams@redhat.com>
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> [bigeasy: slightly altered the commit message]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Dmitry Vyukov <dvyukov@google.com>

> ---
> On 2018-10-10 11:57:41 [+0200], Dmitry Vyukov wrote:
>> Yes. Clark's patch looks good to me. Probably would be useful to add a
>> comment as to why raw spinlock is used (otherwise somebody may
>> refactor it back later).
>
> If you really insist, I could add something but this didn't happen so
> far. git's changelog should provide enough information why to why it was
> changed.
>
>  mm/kasan/quarantine.c |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -103,7 +103,7 @@ static int quarantine_head;
>  static int quarantine_tail;
>  /* Total size of all objects in global_quarantine across all batches. */
>  static unsigned long quarantine_size;
> -static DEFINE_SPINLOCK(quarantine_lock);
> +static DEFINE_RAW_SPINLOCK(quarantine_lock);
>  DEFINE_STATIC_SRCU(remove_cache_srcu);
>
>  /* Maximum size of the global queue. */
> @@ -190,7 +190,7 @@ void quarantine_put(struct kasan_free_me
>         if (unlikely(q->bytes > QUARANTINE_PERCPU_SIZE)) {
>                 qlist_move_all(q, &temp);
>
> -               spin_lock(&quarantine_lock);
> +               raw_spin_lock(&quarantine_lock);
>                 WRITE_ONCE(quarantine_size, quarantine_size + temp.bytes);
>                 qlist_move_all(&temp, &global_quarantine[quarantine_tail]);
>                 if (global_quarantine[quarantine_tail].bytes >=
> @@ -203,7 +203,7 @@ void quarantine_put(struct kasan_free_me
>                         if (new_tail != quarantine_head)
>                                 quarantine_tail = new_tail;
>                 }
> -               spin_unlock(&quarantine_lock);
> +               raw_spin_unlock(&quarantine_lock);
>         }
>
>         local_irq_restore(flags);
> @@ -230,7 +230,7 @@ void quarantine_reduce(void)
>          * expected case).
>          */
>         srcu_idx = srcu_read_lock(&remove_cache_srcu);
> -       spin_lock_irqsave(&quarantine_lock, flags);
> +       raw_spin_lock_irqsave(&quarantine_lock, flags);
>
>         /*
>          * Update quarantine size in case of hotplug. Allocate a fraction of
> @@ -254,7 +254,7 @@ void quarantine_reduce(void)
>                         quarantine_head = 0;
>         }
>
> -       spin_unlock_irqrestore(&quarantine_lock, flags);
> +       raw_spin_unlock_irqrestore(&quarantine_lock, flags);
>
>         qlist_free_all(&to_free, NULL);
>         srcu_read_unlock(&remove_cache_srcu, srcu_idx);
> @@ -310,17 +310,17 @@ void quarantine_remove_cache(struct kmem
>          */
>         on_each_cpu(per_cpu_remove_cache, cache, 1);
>
> -       spin_lock_irqsave(&quarantine_lock, flags);
> +       raw_spin_lock_irqsave(&quarantine_lock, flags);
>         for (i = 0; i < QUARANTINE_BATCHES; i++) {
>                 if (qlist_empty(&global_quarantine[i]))
>                         continue;
>                 qlist_move_cache(&global_quarantine[i], &to_free, cache);
>                 /* Scanning whole quarantine can take a while. */
> -               spin_unlock_irqrestore(&quarantine_lock, flags);
> +               raw_spin_unlock_irqrestore(&quarantine_lock, flags);
>                 cond_resched();
> -               spin_lock_irqsave(&quarantine_lock, flags);
> +               raw_spin_lock_irqsave(&quarantine_lock, flags);
>         }
> -       spin_unlock_irqrestore(&quarantine_lock, flags);
> +       raw_spin_unlock_irqrestore(&quarantine_lock, flags);
>
>         qlist_free_all(&to_free, cache);
>
